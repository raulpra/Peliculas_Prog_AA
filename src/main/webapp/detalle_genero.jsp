<%@ page import="org.example.dao.GeneroDao" %>
<%@ page import="org.example.model.Genero" %>
<%@ page import="org.example.exception.GeneroNotFoundException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar_option.jsp"%>

<%
  int generoId = Integer.parseInt(request.getParameter("genero_id"));
  Database database = new Database();
  database.connect();
  GeneroDao generoDao = new GeneroDao(database.getConnection());
  try{
    Genero genero = generoDao.getGenero(generoId);
%>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-7">
            <div class="card shadow-lg rounded-2">
                <div class="card-header bg-black text-white text-center">
                    <h3 class="mb-0">Detalle del Género</h3>
                </div>
                <div class="card-body p-4">
                    <p><strong>Nombre:</strong> <%= genero.getNombre() %></p>
                    <p><strong>Descripción:</strong> <%= genero.getDescripcion() %></p>
                    <p><strong>Ejemplos:</strong> <%= genero.getEjemplos() %> ...</p>
                    <div class="row g-3 mt-3">
                    <%
                        PeliculaDao peliculaDao = new PeliculaDao(database.getConnection());
                        List<Pelicula> peliculaList = peliculaDao.getAll(genero.getNombre());
                        for (Pelicula pelicula : peliculaList){
                    %>
                        <div class="col-4 d-flex justify-content-center">
                            <div class="card shadow-sm rounded-3 h-100" style="width: 10rem;">
                                <div class="d-flex justify-content-center align-items-center bg-light" style="height: 180px;">
                                    <img src="../peliculas-images/<%=pelicula.getImagen() %>" class="img-fluid" style="max-height: 100%; object-fit: contain;" alt="...">
                                </div>
                                <div class="card-body text-center p-2">
                                    <h6 class="card-title mb-1"><%=pelicula.getTitulo()%></h6>
                                </div>
                            </div>
                        </div>
                    <%
                        }
                    %>
                    </div>
                    <p class=" mt-4"><strong>Fecha Actulización:</strong> <%= genero.getFechaAgregado() %></p>
                    <%
                        if (role.equals ("admin")){
                    %>
                    <p><strong>Activo:</strong> <%= genero.isActivo() ? "SI" : "No" %></p>
                    <%
                        }
                    %>
                </div>
                <div class="card-footer text-end">
                    <a href="generos.jsp" class="btn btn-secondary btn-sm">Volver</a>
                    <%
                        if (role.equals("admin")){
                    %>
                        <a href="edit_genero.jsp?genero_id=<%= genero.getId() %>" class="btn btn-warning btn-sm">Editar</a>
                        <a href="delete_genero?genero_id=<%= genero.getId() %>" class="btn btn-danger btn-sm" onclick="return confirm('¿Desea eliminar permanentemente?')">Eliminar</a>
                    <%
                        }
                    %>
                </div>
              </div>
          </div>
    </div>
</div>

<%
} catch ( GeneroNotFoundException pnfe){
%>
<%@ include file="includes/genero_not_found.jsp"%>
<%
  }
%>

<%@include file="includes/footer.jsp"%>