package org.example.dao;


import org.example.model.Pelicula;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class PeliculaDao {

    private Connection connection;

    public PeliculaDao (Connection connection){
        this.connection = connection;
    }

    public ArrayList<Pelicula> getAll() throws SQLException{
        String sentenciasql = "SELECT * FROM peliculas";
        PreparedStatement statement = null;
        ResultSet result = null;

        statement = connection.prepareStatement(sentenciasql);
        result = statement.executeQuery();

        ArrayList<Pelicula> peliculaArrayList = new ArrayList<>();

        while(result.next()){
            Pelicula pelicula = new Pelicula();
            pelicula.setId(result.getInt("id"));
            pelicula.setTitulo(result.getString("titulo"));
            pelicula.setDirector(result.getString("director"));
            pelicula.setSinopsis(result.getString("sinopsis"));
            pelicula.setFechaEstreno(result.getDate("fechaEstreno"));
            pelicula.setGenero(result.getString("genero"));
            pelicula.setImagen(result.getString("imagen"));
            pelicula.setPuntuacion(result.getFloat("puntuacion"));

            peliculaArrayList.add(pelicula);
        }

        statement.close();
        return peliculaArrayList;
    }


    public boolean add (Pelicula pelicula) throws SQLException {
        String sentenciasql = "INSERT INTO peliculas (titulo, director, sinopsis, fechaEstreno, genero, imagen, puntuacion) VALUES (?,?,?,?,?,?,?)";
        PreparedStatement statement = null;

        statement = connection.prepareStatement(sentenciasql);
        statement.setString(1, pelicula.getTitulo());
        statement.setString(2,pelicula.getDirector());
        statement.setString(3,pelicula.getSinopsis());
        statement.setDate(4, pelicula.getFechaEstreno());
        statement.setString(5,pelicula.getGenero());
        statement.setString(6,pelicula.getImagen());
        statement.setFloat(7,pelicula.getPuntuacion());

        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;
    }

}
