<%@page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar_option.jsp"%>

<%
    String search = request.getParameter("search");
%>


  <!-- Contenido principal -->
  <div class="container mt-4 py-4" style="background-color: #ffffff ">
        <% if (name != null){
        %>
      <h1>Bienvenido a Explorer Cinema <i><%= currentSession.getAttribute("nombre")%> </i></h1>
        <%
            }else{
        %>
        <h1>Bienvenido a Explorer Cinema </h1>
        <%
            }
        %>
        <p>Explora películas, géneros, y guarda tus peliculas favoritas al iniciar sesión.</p>

        <div class="d-flex justify-content-between align-items-center mb-3">
            <form method="get" action="<%= request.getRequestURI()%>" class="d-flex mb-4" role="search" style="max-width: 350px; width: 100%;">
                <input type="text" name="search" id="search" class="form-control" placeholder="Buscar por título o género" value="<%= search != null ? search : "" %>">
            </form>

            <% if (role.equals("admin")){
            %>
                <div class="container d-flex justify-content-end mt-1 py-3">
                    <a href="add_pelicula.jsp" class="btn btn-success">Añadir Película</a>
                </div>
            <%
                }
            %>
        </div>

        <div class="row row-cols-1 row-cols-md-3 g-4">
        <%
            Database database = new Database();
            database.connect();
            PeliculaDao peliculaDao = new PeliculaDao(database.getConnection());
            List<Pelicula> peliculaList = peliculaDao.getAll(search);
            for (Pelicula pelicula : peliculaList){
        %>
            <div class="col card-paginacion">
                <div class="card shadow-lg rounded-3 h-100 d-flex flex-column" style="width: 22rem">

                   <!-- <img src="images/film2.jpg" class="card-img-top" alt="..."> -->
                    <img src="../peliculas-images/<%=pelicula.getImagen() %>" class="card-img-top" style="height: 290px; object-fit: contain" alt="...">
                    <div class="card-body d-flex flex-column ">
                       <h4 class="card-title mb-1"><%=pelicula.getTitulo()%></h4>
                       <p class="mb-1"> <%=pelicula.getDirector()%></p>
                       <h6 class="card-title mb-1"><i class="bi bi-star-fill" style="color:gold"> </i><%=pelicula.getPuntuacion()%>/10</h6>
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