<%@ page import="org.example.model.Genero" %>
<%@ page import="org.example.dao.GeneroDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar_option.jsp"%>

<!-- Contenido principal -->
<div class="container mt-4" style="background-color: #ffffff ">
    <h1>Bienvenido a Explorer Cinema</h1>
    <p>Explora películas, géneros, y accede a más funciones al iniciar sesión.</p>
    <div class="row row-cols-1 row-cols-md-3 g-4">
        <%
            Database database = new Database();
            database.connect();
            GeneroDao generoDao = new GeneroDao(database.getConnection());
            List<Genero> generoList = generoDao.getAll();
            for (Genero genero : generoList){
        %>

        <div class="col">
            <div class="card shadow-lg rounded-3" style="width: 22rem; transition: transform 0.3s ease, box-shadow 0.3s ease;">
                <img src="images/film2.jpg" class="card-img-top" alt="...">
                <div class="card-body">
                    <h5 class="card-title"><%= genero.getNombre() %></h5>
                    <p class="card-text"><%= genero.getDescripcion() %></p>
                    <%
                        if (role.equals("admin")) {
                    %>
                    <a href="edit_genero.jsp?genero_id=<%= genero.getId() %>" class="btn btn-primary">Modificar</a>
                    <a href="delete_genero?genero_id=<%= genero.getId() %>" class="btn btn-danger">Eliminar</a>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
        <%
            }
        %>
    </div>

<%@include file="includes/footer.jsp"%>