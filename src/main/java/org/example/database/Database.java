package org.example.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {

    private Connection connection;

    public void connect() throws ClassNotFoundException, SQLException {
        Class.forName("org.mariadb.jdbc.Driver");
        connection = DriverManager.getConnection("jdbc:mariadb://db:3306/cineapp", "user", "password");
    }

    public void disconnect() throws SQLException {
        connection.close();
        System.out.println("Desconexión realizada con éxito");
    }

    public Connection getConnection() {
        return connection;
    }
}
