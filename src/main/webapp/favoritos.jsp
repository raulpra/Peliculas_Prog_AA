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
    <h1 class="mb-4">Tus películas favoritas <%= currentSession.getAttribute("nombre")%> </h1>
    <div class="row row-cols-1 row-cols-md-3 g-4">
        <%

                Database database = new Database();
                database.connect();
                FavoritoDao favoritoDao = new FavoritoDao(database.getConnection());
                List<Pelicula> favoritosList = favoritoDao.getFavoritosUserId(userId);

                for (Pelicula pelicula : favoritosList) {
        %>
    <div class="col">
        <div class="card shadow-lg rounded-3" style="width: 22rem">

            <img src="images/film2.jpg" class="card-img-top" alt="...">
            <img src="../peliculas-images/<%=pelicula.getImagen() %>" class="card-img-top" alt="...">
            <div class="card-body">
                <h5 class="card-title"><%=pelicula.getTitulo()%></h5>
                <h5 class="card-title"><%=pelicula.getDirector()%></h5>
                <h5 class="card-title"><%=pelicula.getPuntuacion()%></h5>
                <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
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
    <%
        }
    %>
    </div>
</div>