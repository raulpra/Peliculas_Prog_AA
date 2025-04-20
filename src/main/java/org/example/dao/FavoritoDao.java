package org.example.dao;

import org.example.model.Genero;
import org.example.model.Pelicula;

import java.sql.*;
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

    public boolean addFavorito(int usuarioId, int peliculaId) throws SQLException {
        String sentenciasql = "INSERT INTO favoritos (id_usuario, id_pelicula, fecha_agregado) VALUES (?,?,?)";
        PreparedStatement statement = null;

        statement = connection.prepareStatement(sentenciasql);
        statement.setInt(1,usuarioId);
        statement.setInt(2, peliculaId);
        statement.setDate(3,new Date(System.currentTimeMillis()));

        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;
    }

    public boolean deleteFavorito(int usuarioId, int peliculaId) throws SQLException {
        String sentenciasql = "DELETE FROM favoritos WHERE id_usuario = ? AND id_pelicula = ?";
        PreparedStatement statement = null;

        statement = connection.prepareStatement(sentenciasql);
        statement.setInt(1, usuarioId);
        statement.setInt(2, peliculaId);

        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;

    }
}
