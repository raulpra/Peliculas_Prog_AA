<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.dao.PeliculaDao" %>
<%@ page import="org.example.model.Pelicula" %>
<%@ page import="org.example.exception.PeliculaNotFoundException"%>

<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar_option.jsp"%>

<%
    int peliculaId = Integer.parseInt(request.getParameter("pelicula_id"));
    Database database = new Database();
    database.connect();
    PeliculaDao peliculaDao = new PeliculaDao(database.getConnection());
    try{
        Pelicula pelicula = peliculaDao.get(peliculaId);
%>

<div class="container my-5 d-flex justify-content-center">
    <div class="card mb-3" style="max-width: 900px; width: 100%; min-height: 500px;">
        <div class="row g-0 h-100">
            <div class="col-md-6">
                <img src="images/film2.jpg" class="img-fluid rounded-start h-100 w-100 object-fit-cover" alt="Imagen película" style="object-fit: cover;">
            </div>

            <div class="col-md-6 d-flex align-items-center">
                <div class="card-body">
                    <h1 class="card-title mb-5 mt-0"><%=pelicula.getTitulo()%></h1>
                    <p class="card-text"><strong>Director:</strong> <%=pelicula.getDirector()%></p>
                    <p class="card-text"><strong>Fecha de estreno:</strong> <%=pelicula.getFechaEstreno()%></p>
                    <p class="card-text"><strong>Género:</strong> <%=pelicula.getGenero()%></p>
                    <p class="card-text"><strong>Puntuación:</strong> <%=pelicula.getPuntuacion()%></p>
                    <p class="card-text"><strong>Sinopsis:</strong> <%=pelicula.getSinopsis()%> </p>
                </div>
            </div>

        </div>
        <div class="card-footer text-end">
            <a href="index.jsp" class="btn btn-secondary btn-sm">Volver</a>
            <%
                if (role.equals("admin")){
            %>
            <a href="edit_pelicula.jsp?pelicula_id=<%=pelicula.getId()%>" class="btn btn-warning btn-sm">Modificar</a>
            <a href="delete_pelicula?pelicula_id=<%=pelicula.getId()%>" class="btn btn-danger btn-sm" onclick="return confirmar()">Eliminar</a>
            <%
                }
            %>
        </div>
    </div>
</div>

<%
    } catch ( PeliculaNotFoundException pnfe){
%>
    <%@ include file="includes/pelicula_not_found.jsp"%>
<%
}
%>
<script src="./scripts/script_confirmacion.js"></script>

<%@include file="includes/footer.jsp"%>