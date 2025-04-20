package org.example.model;

import lombok.Data;

import java.sql.Date;

@Data
public class Favorito {

        int idUsuario;
        int idPelicula;
        Date fechaCreacion;

        public Favorito(int idUsuario, int idPelicula){
            this.idUsuario = idUsuario;
            this.idPelicula = idPelicula;
        }

}
