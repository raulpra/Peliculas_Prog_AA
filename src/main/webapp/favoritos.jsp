<%@ page import="org.example.dao.FavoritoDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar_option.jsp"%>

<%
    if ((currentSession.getAttribute("role") == null) || (!currentSession.getAttribute("role").equals("usuario")) ){
        response.sendRedirect("/peliculas_app/login.jsp");
    }
%>

<div class="container mt-4 py-4" style="background-color: #ffffff ">
    <h1 class="mb-4">Tus películas favoritas <i><%= currentSession.getAttribute("nombre")%></i> </h1>
    <div class="row row-cols-1 row-cols-md-3 g-4">
        <%

                Database database = new Database();
                database.connect();
                FavoritoDao favoritoDao = new FavoritoDao(database.getConnection());
                List<Pelicula> favoritosList = favoritoDao.getFavoritosUserId(userId);

                for (Pelicula pelicula : favoritosList) {
        %>
    <div class="col card-paginacion">
        <div class="card shadow-lg rounded-3 h-100 d-flex flex-column" style="width: 22rem">

            <img src="images/<%=pelicula.getImagen() %>" class="card-img-top"  style="height: 290px; object-fit: contain" alt="...">
            <div class="card-body d-flex flex-column ">
                <h4 class="card-title mb-1"><%=pelicula.getTitulo()%></h4>
                <p class="mb-1"> <%=pelicula.getDirector()%></p>
                <h6 class="card-title mb-1"><i class="bi bi-star-fill" style="color:gold"> </i><%=pelicula.getPuntuacion()%>/10</h6>
                <div class= "mt-auto">
                    <a href="detalle_pelicula.jsp?pelicula_id=<%=pelicula.getId()%>" class="btn btn-secondary btn-sm">Detalles</a>
                    <%
                        if (role.equals("usuario")){
                    %>
                <a href="delete_favoritos?pelicula_id=<%=pelicula.getId()%>" class="btn btn-primary btn-sm">Quitar favorito</a>
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