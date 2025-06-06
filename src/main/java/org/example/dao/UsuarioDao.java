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
    //Login que solo devuelve el role
/*
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
*/
    //Login que devuelve un objeto usuario
    public Usuario loginUsers(String email, String password) throws SQLException, UsuarioNotFoundException {
        String sql = "SELECT id, nombre, email, password, role FROM usuarios WHERE email = ? AND password = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, email);
        statement.setString(2, password);
        ResultSet result = statement.executeQuery();

        if (!result.next()) {
            throw new UsuarioNotFoundException();
        }

        Usuario usuario = new Usuario();
        usuario.setId(result.getInt("id"));
        usuario.setNombre(result.getString("nombre"));
        //usuario.setApellido(result.getString("apellido"));
        //usuario.setEmail(result.getString("fecha_nacimiento"));
        //usuario.setPassword(result.getString("edad"));
        usuario.setEmail(result.getString("email"));
        usuario.setPassword(result.getString("password"));
        usuario.setRole(result.getString("role"));
        //usuario.setActivo(result.getBoolean("activo"));
        //usuario.setValoracion(result.getFloat("valoracion"));
        return usuario;
    }

    public ArrayList<Usuario> getUsuarios() throws SQLException, UsuarioNotFoundException{
        String sql = "SELECT * FROM usuarios";
        return launchQuery(sql);
    }

    public ArrayList<Usuario> getUsuarios(String search) throws SQLException, UsuarioNotFoundException {
        String sql = "SELECT * FROM usuarios WHERE email LIKE ? OR role LIKE ? OR nombre LIKE ?";
        if (search == null || search.isEmpty()) {
            return getUsuarios();
        }
        return launchQuery(sql, search);
    }

    private ArrayList<Usuario> launchQuery(String sql, String ...search) throws SQLException {
        PreparedStatement statement = null;
        ResultSet result = null;
        statement = connection.prepareStatement(sql);
        if (search.length > 0) {
            statement.setString(1, "%" + search[0] + "%");
            statement.setString(2, "%" + search[0] + "%");
            statement.setString(3, "%" + search[0] + "%");
        }
        result = statement.executeQuery();

        ArrayList<Usuario> usuarioList = new ArrayList<>();

        while (result.next()) {
            Usuario usuario = new Usuario();
            usuario.setId(result.getInt("id"));
            usuario.setNombre(result.getString("nombre"));
            usuario.setApellido(result.getString("apellido"));
            usuario.setFechaNacimiento(result.getDate("fecha_nacimiento"));
            usuario.setEdad(result.getInt("edad"));
            usuario.setEmail(result.getString("email"));
            usuario.setPassword(result.getString("password"));
            usuario.setRole(result.getString("role"));
            usuario.setActivo(result.getBoolean("activo"));
            usuario.setValoracion(result.getFloat("valoracion"));
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
        usuario.setApellido(result.getString("apellido"));
        usuario.setFechaNacimiento(result.getDate("fecha_nacimiento"));
        usuario.setEdad(result.getInt("edad"));
        usuario.setEmail(result.getString("email"));
        usuario.setPassword(result.getString("password"));
        usuario.setRole(result.getString("role"));
        usuario.setActivo(result.getBoolean("activo"));
        usuario.setValoracion(result.getFloat("valoracion"));

        statement.close();

        return usuario;
    }

    public boolean addUsuario (Usuario usuario) throws SQLException {
        String sql = "INSERT INTO usuarios (nombre, apellido, fecha_nacimiento, edad, email, password, role, activo, valoracion) VALUES (?,?,?,?,?,?,?,?,?)";
        PreparedStatement statement = null;

        statement = connection.prepareStatement(sql);
        statement.setString(1, usuario.getNombre());
        statement.setString(2, usuario.getApellido());
        statement.setDate(3, usuario.getFechaNacimiento());
        statement.setInt(4, usuario.getEdad());
        statement.setString(5, usuario.getEmail());
        statement.setString(6, usuario.getPassword());
        statement.setString(7,usuario.getRole());
        statement.setBoolean(8,usuario.isActivo());
        statement.setFloat(9,usuario.getValoracion());

        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;
    }

    public boolean edit (Usuario usuario) throws SQLException {
        String sentenciasql = "UPDATE usuarios SET nombre = ?, apellido = ?, fecha_nacimiento = ?, edad = ?, email = ?, password = ?, role = ?, activo = ?, valoracion = ? WHERE id = ?";
        PreparedStatement statement = null;
        statement = connection.prepareStatement(sentenciasql);

        statement.setString(1, usuario.getNombre());
        statement.setString(2, usuario.getApellido());
        statement.setDate(3, usuario.getFechaNacimiento());
        statement.setInt(4, usuario.getEdad());
        statement.setString(5, usuario.getEmail());
        statement.setString(6, usuario.getPassword());
        statement.setString(7, usuario.getRole());
        statement.setBoolean(8, usuario.isActivo());
        statement.setFloat(9, usuario.getValoracion());
        statement.setInt(10, usuario.getId());

        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;
    }

    public boolean delete(int usuarioId) throws SQLException {
        String sentenciasql = "DELETE FROM usuarios WHERE id=?";
        PreparedStatement statement = null;
        statement = connection.prepareStatement(sentenciasql);
        statement.setInt(1, usuarioId);

        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;

    }
}
