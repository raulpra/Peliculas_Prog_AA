package org.example.model;

import lombok.Data;

import java.sql.Date;

@Data
public class Genero {

    private int id;
    private String nombre;
    private String descripcion;
    private String ejemplos;
    private Date fechaAgregado;
    private boolean activo;
}
