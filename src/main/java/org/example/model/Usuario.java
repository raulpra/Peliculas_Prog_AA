package org.example.model;

import lombok.Data;

import java.sql.Date;

@Data
public class Usuario {

    private int id;
    private String nombre;
    private String apellido;
    private Date fechaNacimiento;
    private int edad;
    private String email;
    private String password;
    private String role;
    private boolean activo;
    private float valoracion;
}
