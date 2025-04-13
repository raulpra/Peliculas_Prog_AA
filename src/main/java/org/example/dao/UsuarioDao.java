package org.example.dao;

import org.example.exception.UsuarioNotFoundException;
import org.example.model.Usuario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class UsuarioDao {

    private Connection connection;

    public UsuarioDao(Connection connection) {
        this.connection = connection;
    }

    public String loginUsers (String email, String password) throws SQLException, UsuarioNotFoundException {

        String sql = "SELECT role FROM usuarios WHERE email = ? AND password = ?";

        PreparedStatement statement = connection.prepareStatement((sql));
        statement.setString(1,email);
        statement.setString(2,password);
        ResultSet result = statement.executeQuery();
        if (!result.next()){
            throw new UsuarioNotFoundException();
        }

        return result.getString("role");
    }

    public ArrayList<Usuario> getUsuarios() throws SQLException, UsuarioNotFoundException {
        String sql = "SELECT * FROM usuarios";
        PreparedStatement statement = null;
        statement = connection.prepareStatement(sql);
        ResultSet result = statement.executeQuery();

        ArrayList<Usuario> usuarioList = new ArrayList<>();

        while (result.next()) {
            Usuario usuario = new Usuario();
            usuario.setId(result.getInt("id"));
            usuario.setNombre(result.getString("nombre"));
            usuario.setEmail(result.getString("email"));
            usuario.setPassword(result.getString("password"));
            usuario.setRole(result.getString("role"));
            usuarioList.add(usuario);
        }
        statement.close();

        return usuarioList;
    }


    public Usuario getUsuario (int id) throws SQLException, UsuarioNotFoundException {
        String sql = "SELECT * FROM usuarios WHERE id = ?";
        PreparedStatement statement = null;
        ResultSet result = null;

        statement = connection.prepareStatement(sql);
        statement.setInt(1, id);
        result = statement.executeQuery();

        if (!result.next()){
            throw new UsuarioNotFoundException();
        }
        Usuario usuario = new Usuario();
        usuario.setId(result.getInt("id"));
        usuario.setNombre(result.getString("nombre"));
        usuario.setEmail(result.getString("email"));
        usuario.setPassword(result.getString("password"));
        usuario.setRole(result.getString("role"));

        statement.close();

        return usuario;
    }
}
