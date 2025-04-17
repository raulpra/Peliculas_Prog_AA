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

        </div>
        <div class="card-footer text-end">
          <a href="generos.jsp" class="btn btn-secondary btn-sm">Volver</a>
          <%
            if (role.equals("admin")){
          %>
          <a href="edit_genero.jsp?genero_id=<%= genero.getId() %>" class="btn btn-warning btn-sm">Editar</a>
          <a href="delete_genero?genero_id=<%= genero.getId() %>" class="btn btn-danger btn-sm">Eliminar</a>
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