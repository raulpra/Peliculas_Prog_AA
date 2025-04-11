package org.example.model;

import lombok.Data;

@Data
public class Usuario {

    private int id;
    private String nombre;
    private String email;
    private String password;
    private String role;
}
