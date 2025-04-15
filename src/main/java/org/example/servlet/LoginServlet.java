package org.example.servlet;

import org.example.dao.UsuarioDao;
import org.example.database.Database;
import org.example.exception.UsuarioNotFoundException;
import org.example.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;


@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException{

        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try{
            Database database = new Database();
            database.connect();
            UsuarioDao usuarioDao = new UsuarioDao(database.getConnection());
            /*Cuando usamos el login que solo devuelve el role
            String role = usuarioDao.loginUsers(email, password);

            HttpSession session = request.getSession();
            session.setAttribute("email", email);
            session.setAttribute("role", role);*/

            //Cuando usamos el login que devuelve el objeto Usuario
            Usuario usuario = usuarioDao.loginUsers(email, password);
            HttpSession session = request.getSession();
            session.setAttribute("email", usuario.getEmail());
            session.setAttribute("role", usuario.getRole());
            session.setAttribute("nombre", usuario.getNombre());
            session.setAttribute("id", usuario.getId());


            response.getWriter().print("ok");

        }catch (SQLException sqle) {
            try {
                response.getWriter().println("No se ha podido conectar con la base de datos");
            } catch (IOException ioe) {
                ioe.printStackTrace();
            }
            sqle.printStackTrace();
        }catch (ClassNotFoundException cnfe){
            cnfe.printStackTrace();
        }catch (IOException ioe){
            ioe.printStackTrace();
        }catch (UsuarioNotFoundException unfe){
            try{
                response.getWriter().println("Usuario/contraseña incorrectos");
            }catch (IOException ioe) {
                ioe.printStackTrace();
            }
        }

    }
}
