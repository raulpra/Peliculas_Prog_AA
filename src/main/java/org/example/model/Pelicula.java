package org.example.model;

import lombok.Data;

import java.sql.Date;

@Data
public class Pelicula {

    private int id;
    private String titulo;
    private String director;
    private String sinopsis;
    private Date fechaEstreno;
    private String genero;
    private String imagen;
    private float puntuacion;
    private boolean disponible;
}
