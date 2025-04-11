package org.example.model;

import lombok.Data;

@Data
public class Favorito {

        int idUsuario;
        int idPelicula;

        public Favorito(int idUsuario, int idPelicula){
            this.idUsuario = idUsuario;
            this.idPelicula = idPelicula;
        }

}
