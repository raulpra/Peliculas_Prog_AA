package org.example.servlet;

import org.example.dao.PeliculaDao;
import org.example.database.Database;
import org.example.model.Pelicula;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;

import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.UUID;


@WebServlet("/add_pelicula")
@MultipartConfig

public class NewPeliculaServlet extends HttpServlet {

    private ArrayList<String> errors;

    @Override
    public void doPost( HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        HttpSession currentSession = request.getSession();
        if (currentSession.getAttribute("role") == null){
            response.sendRedirect("/peliculas_app/login.jsp");
            return;
        }

        if (!validate(request)){
            response.getWriter().print(errors.toString());
            return;
        }

        String titulo = request.getParameter("titulo");
        String director = request.getParameter("director");
        String sinopsis = request.getParameter("sinopsis");
        String fechaEstreno = request.getParameter("fecha_estreno");
        Date fecha = Date.valueOf(fechaEstreno);
        String puntuacion = request.getParameter("puntuacion");
        String genero = request.getParameter("id_genero");
        Part image = request.getPart("imagen");

        try {
            Database database = new Database();
            database.connect();
            PeliculaDao peliculaDao = new PeliculaDao(database.getConnection());
            Pelicula pelicula = new Pelicula();
            pelicula.setTitulo(titulo);
            pelicula.setDirector(director);
            pelicula.setSinopsis(sinopsis);
            pelicula.setFechaEstreno(fecha);
            pelicula.setPuntuacion(Float.parseFloat(puntuacion));
            pelicula.setGenero(genero);

            String filename = "film.jpg";
            if (image.getSize() != 0) {
                //creo un nombre de foto aleatorio y por ahora solo damos por válido jpg
                filename = UUID.randomUUID().toString() + ".jpg";

                String imagePath = "C:/apache-tomcat-9.0.102/webapps/peliculas-images";
                InputStream inputStream = image.getInputStream(); //representación en datos de la imagen
                Files.copy(inputStream, Path.of(imagePath + File.separator + filename));
            }
            pelicula.setImagen(filename);

            boolean added = peliculaDao.add(pelicula);
            if (added) {
                response.getWriter().print("ok");
            } else {
                response.getWriter().print("No se ha podido registrar el juego");
            }

        } catch (SQLException sqle) {
            try {
                response.getWriter().println("No se ha podido conectar con la base de datos");
                sqle.printStackTrace();
                response.getWriter().println("Error SQL: " + sqle.getMessage());
            } catch (IOException ioe){
                ioe.printStackTrace();
            }
            sqle.printStackTrace();
        } catch (ClassNotFoundException cnfe){
            cnfe.printStackTrace();
        } catch (IOException ioe) {
            ioe.printStackTrace();
        }
    }

    private boolean validate(HttpServletRequest request){
        errors = new ArrayList<>();
        if (request.getParameter("titulo").isEmpty()){
            errors.add("El título es obligatorio");
        }
        if (request.getParameter("director").isEmpty()){
            errors.add("El director es obligatorio");
        }
        if (request.getParameter("fecha_estreno").isEmpty()){
            errors.add("Fecha de estreno es obligatorio");
        }
        if (request.getParameter("id_genero").isEmpty()) {
            errors.add("Seleccione un genero");
        }
        return errors.isEmpty();
    }
}
