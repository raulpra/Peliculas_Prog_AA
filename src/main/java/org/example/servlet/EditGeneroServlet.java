package org.example.servlet;

import org.example.dao.GeneroDao;
import org.example.database.Database;
import org.example.model.Genero;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet("/edit_genero")
public class EditGeneroServlet extends HttpServlet {

    private ArrayList<String> errors;

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        HttpSession currentSession = request.getSession();
        if (currentSession.getAttribute("role") == null) {
            response.sendRedirect("/peliculas_app/login.jsp");
        }

        int id = Integer.parseInt(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");

        try{
            Database database = new Database();
            database.connect();
            GeneroDao generoDao = new GeneroDao(database.getConnection());
            Genero genero = new Genero();
            genero.setId(id);
            genero.setNombre(nombre);
            genero.setDescripcion(descripcion);

            boolean edited = generoDao.update(genero);
            if (edited){
                response.getWriter().print("ok");
            }else {
                response.getWriter().print("No se ha podido actualizar el género");
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
        }catch (IOException ioe){
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
        if (request.getParameter("descripcion").isEmpty()){
            errors.add("La descripcion es obligatoria");
        }
        return errors.isEmpty();
    }
}
