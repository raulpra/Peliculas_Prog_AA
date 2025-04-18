<%@page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar_option.jsp"%>


  <!-- Contenido principal -->
  <div class="container mt-4 py-4" style="background-color: #ffffff ">
        <% if (name != null){
        %>
        <h1>Bienvenido a Explorer Cinema <%= currentSession.getAttribute("nombre")%></h1>
        <%
            }else{
        %>
        <h1>Bienvenido a Explorer Cinema </h1>
        <%
            }
        %>
        <p>Explora películas, géneros, y guarda tus peliculas favoritas al iniciar sesión.</p>
        <% if (role.equals("admin")){
        %>
            <div class="container d-flex justify-content-end py-3">
                <a href="add_pelicula.jsp" class="btn btn-success">Añadir Película</a>
            </div>
        <%
            }
        %>
        <div class="row row-cols-1 row-cols-md-3 g-4">
        <%
            Database database = new Database();
            database.connect();
            PeliculaDao peliculaDao = new PeliculaDao(database.getConnection());
            List<Pelicula> peliculaList = peliculaDao.getAll();
            for (Pelicula pelicula : peliculaList){
        %>
            <div class="col card-paginacion">
                <div class="card shadow-lg rounded-3 h-100 d-flex flex-column" style="width: 22rem">

                    <img src="images/film2.jpg" class="card-img-top" alt="...">
                    <img src="../peliculas-images/<%=pelicula.getImagen() %>" class="card-img-top" alt="...">
                    <div class="card-body d-flex flex-column">
                       <h5 class="card-title"><%=pelicula.getTitulo()%></h5>
                       <h5 class="card-title"><%=pelicula.getDirector()%></h5>
                       <h5 class="card-title"><%=pelicula.getPuntuacion()%></h5>
                       <p class="card-text"><%=pelicula.getSinopsis()%></p>
                        <div class= "mt-auto">
                           <a href="detalle_pelicula.jsp?pelicula_id=<%=pelicula.getId()%>" class="btn btn-secondary btn-sm">Detalles</a>
                           <%
                                if (role.equals("usuario")){
                           %>
                           <a href="add_favoritos?pelicula_id=<%=pelicula.getId()%>" class="btn btn-primary btn-sm">Marcar favorito</a>
                           <%
                                }
                           %>
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