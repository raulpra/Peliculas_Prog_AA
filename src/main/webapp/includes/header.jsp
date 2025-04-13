<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.database.Database" %>
<%@ page import="org.example.model.Pelicula" %>
<%@ page import="org.example.dao.PeliculaDao" %>
<%@ page import="java.util.List" %>

<!doctype html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Steam</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- añadimos jquery para poder usar ajax que es javascript-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>

<body style="background-color: rgb(185, 130, 130);">

<header>
  <!-- Barra de navegación principal -->
     <nav class="navbar navbar-dark" style="background-color: #c61414 ">
        <div class="container-fluid">
            <a class="navbar-brand" href="index.jsp"> <img src="images/ExplorerCinema.png" alt="Bootstrap" width="380" height="90"></a>

            <!-- Cogemos la sesión actual -->
            <%
                HttpSession currentSession = request.getSession();
                String role = "anonymous";
                if (currentSession.getAttribute("role") !=null){
                    role = currentSession.getAttribute("role").toString();
                }
                if (role.equals("anonymous")) {
            %>
            <a href = "/peliculas_app/login.jsp" title = "Iniciar sesión"><img src= "images/enter.png" height="40" width="40"></a>
            <%
                }else{
            %>
            <a href = "/peliculas_app/logout" title = "Cerrar sesión"><img src= "images/exit.png" height="40" width="40"></a>
            <%
            }
            %>
        </div>
    </nav>
</header>