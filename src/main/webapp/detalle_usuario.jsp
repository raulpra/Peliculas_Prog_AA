<%@ page import="org.example.dao.UsuarioDao" %>
<%@ page import="org.example.model.Usuario" %>
<%@ page import="org.example.exception.UsuarioNotFoundException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar_option.jsp"%>

<%
  int usuarioId = Integer.parseInt(request.getParameter("usuario_id"));
  Database database = new Database();
  database.connect();
  UsuarioDao usuarioDao = new UsuarioDao(database.getConnection());
  try{
    Usuario usuario = usuarioDao.getUsuario(usuarioId);
%>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-7">
            <div class="card shadow-lg rounded-2">
                <div class="card-header bg-black text-white text-center">
                    <h3 class="mb-0">Ficha del Usuario</h3>
                </div>
                <div class="card-body p-4">
                    <p><strong>Nombre:</strong> <%= usuario.getNombre() %></p>
                    <p><strong>Email:</strong> <%= usuario.getEmail() %></p>
                    <p><strong>Rol:</strong> <%= usuario.getRole() %></p>

                </div>
                <div class="card-footer text-end">
                  <% if (role.equals("usuario")){
                  %>
                    <a href="index.jsp" class="btn btn-secondary btn-sm">Volver</a>
                    <a href="edit_usuario.jsp?usuario_id=<%=usuario.getId()%>" class="btn btn-warning btn-sm">Editar</a>

                  <%
                    }else if (role.equals("admin")){
                  %>
                    <a href="usuarios.jsp" class="btn btn-secondary btn-sm">Volver</a>
                    <a href="edit_usuario.jsp?usuario_id=<%=usuario.getId()%>" class="btn btn-warning btn-sm">Editar</a>
                    <a href="delete_usuario?usuario_id=<%=usuario.getId()%>" class="btn btn-danger btn-sm">Eliminar</a>
                <%
                  }
                %>
                </div>
            </div>
        </div>
  </div>
</div>

<%
} catch ( UsuarioNotFoundException pnfe){
%>
<%@ include file="includes/usuario_not_found.jsp"%>
<%
  }
%>
<%@include file="includes/footer.jsp"%>