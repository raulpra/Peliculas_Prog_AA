package org.example.dao;

import org.example.exception.GeneroNotFoundException;
import org.example.model.Genero;

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

    public ArrayList<Genero> getAllGeneros() throws SQLException, GeneroNotFoundException {
        String sentenciasql = "SELECT * FROM generos";
        return launchQuery(sentenciasql);
    }

    public ArrayList<Genero> getAllGeneros(String search) throws SQLException, GeneroNotFoundException {
        String sentenciasql = "SELECT * FROM generos WHERE nombre LIKE ? OR descripcion LIKE ?";
        if (search == null || search.isEmpty()) {
            return getAllGeneros();
        }
        return launchQuery(sentenciasql, search);
    }

    private ArrayList<Genero> launchQuery (String sentenciasql, String ...search) throws SQLException {
        PreparedStatement statement = null;
        ResultSet result = null;

        statement = connection.prepareStatement(sentenciasql);
        if (search.length > 0){
            statement.setString(1, "%" + search[0] + "%");
            statement.setString(2, "%" + search[0] + "%");
        }
        result = statement.executeQuery();

        ArrayList<Genero> generoArrayList = new ArrayList<>();

        while (result.next()) {
            Genero genero = new Genero();
            genero.setId(result.getInt("id"));
            genero.setNombre(result.getString("nombre"));
            genero.setDescripcion(result.getString("descripcion"));
            genero.setEjemplos(result.getString("ejemplos"));
            genero.setFechaAgregado(result.getDate("fecha_agregado"));
            genero.setActivo(result.getBoolean("activo"));

            generoArrayList.add(genero);
        }
        statement.close();

        return generoArrayList;
    }

    public Genero getGenero(int generoId) throws SQLException, GeneroNotFoundException {
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
        genero.setEjemplos(result.getString("ejemplos"));
        genero.setFechaAgregado(result.getDate("fecha_agregado"));
        genero.setActivo(result.getBoolean("activo"));

        statement.close();

        return genero;

    }

    public boolean add(Genero genero) throws SQLException {
        String sentenciasql = "INSERT INTO generos (nombre, descripcion, ejemplos, fecha_agregado, activo) VALUES (?,?,?,?,?)";
        PreparedStatement statement = null;

        statement = connection.prepareStatement(sentenciasql);
        statement.setString(1,genero.getNombre());
        statement.setString(2, genero.getDescripcion());
        statement.setString(3, genero.getEjemplos());
        statement.setDate(4, genero.getFechaAgregado());
        statement.setBoolean(5, genero.isActivo());

        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;
    }

    public boolean update(Genero genero) throws SQLException {
        String sentinciasql = "UPDATE generos SET nombre = ?, descripcion = ?, ejemplos = ?, fecha_agregado = ?, activo = ? WHERE id = ?";
        PreparedStatement statement = null;
        statement = connection.prepareStatement(sentinciasql);

        statement.setString(1,genero.getNombre());
        statement.setString(2, genero.getDescripcion());
        statement.setString(3, genero.getEjemplos());
        statement.setDate(4, genero.getFechaAgregado());
        statement.setBoolean(5, genero.isActivo());
        statement.setInt(6, genero.getId());

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