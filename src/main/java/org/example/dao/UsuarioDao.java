package org.example.dao;

import org.example.exception.UsuarioNotFoundException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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

}
