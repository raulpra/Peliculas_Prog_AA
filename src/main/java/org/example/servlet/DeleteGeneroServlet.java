package org.example.servlet;

import org.example.dao.GeneroDao;
import org.example.database.Database;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/delete_genero")

public class DeleteGeneroServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setCharacterEncoding("UTF-8");

        HttpSession currentSession = request.getSession();
        if (currentSession.getAttribute("role") == null) {
            response.sendRedirect("/peliculas_app/login.jsp");
            return;
        }

        String generoId = request.getParameter("genero_id");

        try {
            Database database = new Database();
            database.connect();
            GeneroDao generoDao = new GeneroDao(database.getConnection());
            generoDao.delete(Integer.parseInt(generoId));

            response.sendRedirect("/peliculas_app/generos.jsp");

        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }


    }
}