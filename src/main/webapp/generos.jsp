<%@ page import="org.example.model.Genero" %>
<%@ page import="org.example.dao.GeneroDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar_option.jsp"%>

<%
    String search = request.getParameter("search");
%>

<!-- Contenido principal -->
<div class="container mt-4 py-4" style="background-color: #ffffff ">
    <h1>Descubre todos los géneros disponibles</h1>
    <p>Explora películas, géneros, y accede a más funciones al iniciar sesión.</p>

    <div class="d-flex justify-content-between align-items-center mb-3">
        <form method="get" action="<%= request.getRequestURI()%>" class="d-flex mb-4" role="search" style="max-width: 350px; width: 100%;">
            <input type="text" name="search" id="search" class="form-control" placeholder="Buscar por nombre" value="<%= search != null ? search : "" %>">
        </form>

        <% if (role.equals("admin")){
        %>
            <div class="container d-flex justify-content-end py-3">
                <a href="add_genero.jsp" class="btn btn-success">Añadir Género</a>
            </div>
        <%
        }
        %>
    </div>
    <div class="row row-cols-1 row-cols-md-3 g-4">
        <%
            Database database = new Database();
            database.connect();
            GeneroDao generoDao = new GeneroDao(database.getConnection());
            List<Genero> generoList = generoDao.getAllGeneros(search);
            for (Genero genero : generoList){
        %>

        <div class="col card-paginacion">
            <div class="card shadow-lg rounded-3 h-100 d-flex flex-column " style="width: 22rem; transition: transform 0.3s ease, box-shadow 0.3s ease;">
                <img src="images/film2.jpg" class="card-img-top" alt="...">
                <div class="card-body d-flex flex-column ">
                    <h3 class="card-title"><%= genero.getNombre() %></h3>
                    <p class="card-text flex-grow-1"><%= genero.getDescripcion() %></p>
                    <div class = "mt-auto">
                        <a href="detalle_genero.jsp?genero_id=<%=genero.getId() %>" class="btn btn-secondary btn-sm">Detalles</a>
                    </div>
                </div>
            </div>
        </div>
        <%
            }
        %>
    </div>
</div>

<div class="d-flex justify-content-center mt-4">
    <button id="btn_anterior" class="btn btn-outline-secondary  me-1">Anterior</button>
    <button id="btn_siguiente" class="btn btn-outline-secondary">Siguiente</button>
</div>

<script src="./scripts/script_paginacion.js"></script>


<%@include file="includes/footer.jsp"%>