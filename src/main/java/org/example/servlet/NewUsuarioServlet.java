package org.example.servlet;

import org.example.dao.UsuarioDao;
import org.example.database.Database;
import org.example.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet("/add_usuario")
public class NewUsuarioServlet extends HttpServlet {

    private ArrayList<String> errors;

    @Override
    public void doPost (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        HttpSession currentSession = request.getSession();
        if (currentSession.getAttribute("role") == null) {
            response.sendRedirect("/peliculas_app/login.jsp");
        }

        if (!validate(request)) {
            response.getWriter().println(errors.toString());
            return;
        }

        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        try{
            Database database = new Database();
            database.connect();
            UsuarioDao usuarioDao = new UsuarioDao(database.getConnection());
            Usuario usuario = new Usuario();
            usuario.setNombre(nombre);
            usuario.setEmail(email);
            usuario.setPassword(password);
            usuario.setRole(role);

            boolean added = usuarioDao.addUsuario(usuario);
            if (added) {
                response.getWriter().print("ok");
            }else {
                response.getWriter().print("No se ha podido registrar el usuario");
            }
        } catch (SQLException sqle){
            try{
                response.getWriter().println("No se ha podido conectar con la base de datos");
                sqle.printStackTrace();
                response.getWriter().println("Error SQL: " + sqle.getMessage());
            }catch (IOException ioe){
                ioe.printStackTrace();
            }
            sqle.printStackTrace();
        } catch (IOException ioe){
            ioe.printStackTrace();
        }catch (ClassNotFoundException cnfe){
            cnfe.printStackTrace();
        }
    }

    private boolean validate (HttpServletRequest request){
        errors = new ArrayList<>();
        if (request.getParameter("nombre").isEmpty()){
            errors.add("El nombre es obligatorio");
        }
        if (request.getParameter("email").isEmpty()){
            errors.add("El email es obligatorio");
        }
        if (request.getParameter("password").isEmpty()){
            errors.add("La contraseña es obligatoria");
        }
        if (request.getParameter("role").isEmpty()){
            errors.add("Seleccione un rol");
        }
        return errors.isEmpty();
    }
}
