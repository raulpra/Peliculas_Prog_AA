package org.example.servlet;

import org.example.dao.FavoritoDao;
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

@WebServlet("/add_favoritos")

public class AddFavoritoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setCharacterEncoding("UTF-8");

        HttpSession currentSession = request.getSession();
        if (currentSession.getAttribute("role") == null) {
            response.sendRedirect("/peliculas_app/login.jsp");
            return;
        }

        String peliculaId = request.getParameter("pelicula_id");
        int userId = (int) currentSession.getAttribute("id");

        try {
            Database database = new Database();
            database.connect();
            FavoritoDao favoritoDao = new FavoritoDao(database.getConnection());
            favoritoDao.addFavorito(userId,Integer.parseInt(peliculaId));

            response.sendRedirect("/peliculas_app/index.jsp");

        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }


    }
}