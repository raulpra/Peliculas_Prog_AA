package org.example.dao;

import org.example.model.Pelicula;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FavoritoDao {

    private Connection connection;

    public FavoritoDao (Connection connection){
        this.connection = connection;
    }

    public List<Pelicula> getFavoritosUserId(int id) throws SQLException {
        String sql = "SELECT p.*, g.nombre AS genero_nombre FROM favoritos f JOIN peliculas p ON f.id_pelicula = p.id JOIN generos g ON p.id_genero = g.id WHERE f.id_usuario = ?";
        PreparedStatement statement = null;
        ResultSet result = null;

        statement = connection.prepareStatement(sql);
        statement.setInt(1, id);
        result = statement.executeQuery();

        List<Pelicula> favoritosList = new ArrayList<>();

        while (result.next()) {
            Pelicula pelicula = new Pelicula();
            pelicula.setId(result.getInt("id"));
            pelicula.setTitulo(result.getString("titulo"));
            pelicula.setDirector(result.getString("director"));
            pelicula.setSinopsis(result.getString("sinopsis"));
            pelicula.setFechaEstreno(result.getDate("fecha_estreno"));
            pelicula.setGenero(result.getString("genero_nombre"));
            pelicula.setImagen(result.getString("imagen"));
            pelicula.setPuntuacion(result.getFloat("puntuacion"));
            favoritosList.add(pelicula);
        }

        return favoritosList;
    }
}
