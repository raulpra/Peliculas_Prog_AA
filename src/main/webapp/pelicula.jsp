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


//todo card para mostrar la pelicula

<%
    } catch ( PeliculaNotFoundException pnfe){
%>
    <%@ include file="includes/pelicula_not_found.jsp"%>
<%
}
%>


<%@include file="includes/footer.jsp"%>