<%@ page import="org.example.dao.UsuarioDao" %>
<%@ page import="org.example.model.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar_option.jsp"%>

<div class="container mt-5">
    <h2 class="mb-4">Gestión de Usuarios</h2>
    <table class="table table-striped table-bordered align-middle shadow-sm">
        <thead class="table-dark">
        <tr>
            <th scope="col">Nombre</th>
            <th scope="col">Email</th>
            <th scope="col">Rol</th>
            <th scope="col">Acciones</th>
        </tr>
        </thead>
        <tbody>
        <%
            Database database = new Database();
            database.connect();
            UsuarioDao usuarioDao = new UsuarioDao(database.getConnection());
            List<Usuario> usuarioList = usuarioDao.getUsuarios();

            for (Usuario usuario : usuarioList) {
        %>
        <tr>
            <td><%= usuario.getNombre() %></td>
            <td><%= usuario.getEmail() %></td>
            <td><%= usuario.getRole() %></td>
            <td>
                <a href="detalle_usuario.jsp?usuario_id=<%=usuario.getId()%>" class="btn btn-primary btn-sm">Detalles</a>
                <a href="edit_usuario.jsp?usuario_id=<%=usuario.getId()%>" class="btn btn-warning btn-sm">Editar</a>
                <a href="delete_usuario?usuario_id=<%=usuario.getId()%>" class="btn btn-danger btn-sm">Eliminar</a>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>


<%@include file="includes/footer.jsp"%>