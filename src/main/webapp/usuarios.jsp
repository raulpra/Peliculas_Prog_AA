<%@ page import="org.example.dao.UsuarioDao" %>
<%@ page import="org.example.model.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar_option.jsp"%>

<%
    if ((currentSession.getAttribute("role") == null) || (!currentSession.getAttribute("role").equals("admin")) ){
        response.sendRedirect("/peliculas_app/login.jsp");
    }
%>

<%
    String search = request.getParameter("search");
%>

<div class="container mt-4 py-4" style="background-color: #ffffff ">
    <div class="container mt-5">
        <h2 class="mb-4">Gestión de Usuarios</h2>
        <div class="d-flex justify-content-between align-items-center mb-3">
            <form  method="get" action="<%=request.getRequestURI()%>" class="d-flex mb-4" role="search" style="max-width: 350px; width: 100%;">
                <input type="text" name="search" id="search" class="form-control" placeholder="Buscar por nombre, correo o role" value="<%= search != null ? search : "" %>">
            </form>
        <% if (role.equals("admin")){
        %>
            <div class="container d-flex justify-content-end py-3">
                <a href="add_usuario.jsp" class="btn btn-success">Añadir Usuario</a>
            </div>
        <%
            }
        %>
        </div>
        <table class="table table-striped table-bordered align-middle shadow-sm rounded-3">
            <thead class="table-dark">
            <tr>
                <th scope="col">Nombre</th>
                <th scope="col">Apellido</th>
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
                List<Usuario> usuarioList = usuarioDao.getUsuarios(search);

                for (Usuario usuario : usuarioList) {
            %>
            <tr>
                <td><%= usuario.getNombre() %></td>
                <td><%= usuario.getApellido() %></td>
                <td><%= usuario.getEmail() %></td>
                <td><%= usuario.getRole() %></td>
                <td>
                    <a href="detalle_usuario.jsp?usuario_id=<%=usuario.getId()%>" class="btn btn-secondary btn-sm">Detalles</a>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<div class="d-flex justify-content-center mt-4">
    <button id="btn_anterior" class="btn btn-outline-secondary  me-1">Anterior</button>
    <button id="btn_siguiente" class="btn btn-outline-secondary">Siguiente</button>
</div>

<script src="./scripts/script_paginacion_tabla.js"></script>


<%@include file="includes/footer.jsp"%>