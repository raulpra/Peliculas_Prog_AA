package org.example.dao;

import org.example.exception.GeneroNotFoundException;
import org.example.exception.PeliculaNotFoundException;
import org.example.model.Genero;
import org.example.model.Pelicula;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class GeneroDao {
    private Connection connection;

    public GeneroDao(Connection connection) {
        this.connection = connection;
    }

    public ArrayList<Genero> getAll() throws SQLException {
        String sentenciasql = "SELECT * FROM generos";
        PreparedStatement statement = null;
        ResultSet result = null;

        statement = connection.prepareStatement(sentenciasql);
        result = statement.executeQuery();

        ArrayList<Genero> generoArrayList = new ArrayList<>();

        while (result.next()) {
            Genero genero = new Genero();
            genero.setId(result.getInt("id"));
            genero.setNombre(result.getString("nombre"));
            genero.setDescripcion(result.getString("descripcion"));

            generoArrayList.add(genero);
        }
        statement.close();

        return generoArrayList;
    }


    public Genero get(int generoId) throws SQLException, GeneroNotFoundException {
        String sentenciasql = "SELECT * FROM generos WHERE id = ?";
        PreparedStatement statement = null;
        ResultSet result = null;

        statement = connection.prepareStatement(sentenciasql);
        statement.setInt(1, generoId);
        result = statement.executeQuery();

        if (!result.next()) {
            throw new GeneroNotFoundException();
        }
        Genero genero = new Genero();
        genero.setId(result.getInt("id"));
        genero.setNombre(result.getString("nombre"));
        genero.setDescripcion(result.getString("descripcion"));

        statement.close();

        return genero;

    }

    public boolean add(Genero genero) throws SQLException {
        String sentenciasql = "INSERT INTO generos (nombre, descripcion) VALUES (?,?)";
        PreparedStatement statement = null;

        statement = connection.prepareStatement(sentenciasql);
        statement.setString(1,genero.getNombre());
        statement.setString(2, genero.getDescripcion());

        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;
    }

    public boolean delete(int generoId) throws SQLException {
        String sentenciasql = "DELETE FROM generos WHERE id=?";
        PreparedStatement statement = null;
        statement = connection.prepareStatement(sentenciasql);
        statement.setInt(1, generoId);

        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;

    }
}