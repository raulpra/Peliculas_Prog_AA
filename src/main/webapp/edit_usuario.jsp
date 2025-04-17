<%@ page import="org.example.model.Usuario" %>
<%@ page import="org.example.dao.UsuarioDao" %>
<%@ page import="org.example.exception.UsuarioNotFoundException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar_option.jsp"%>

<%
    if ((currentSession.getAttribute("role") == null) || (currentSession.getAttribute("id") == null)){
        response.sendRedirect("peliculas_app/login.jsp");
    }
    int usuarioId = Integer.parseInt(request.getParameter("usuario_id"));
    if (!role.equals("admin") && userId != usuarioId) {
        response.sendRedirect("peliculas_app/login.jsp");
    }
    Database database = new Database();
    database.connect();
    UsuarioDao usuarioDao = new UsuarioDao(database.getConnection());
    try{
      Usuario usuario = usuarioDao.getUsuario(usuarioId);
%>

<script type="text/javascript">
    $(document).ready(function() {
        $("form").on("submit", function(event) {
            event.preventDefault();
            const formValue = $(this).serialize();
            $.ajax({
                url:"edit_usuario",
                type: "POST",
                data: formValue,
                statusCode: {
                    200: function(response) {
                        console.log("Respuesta del servidor:", response);
                        if (response === "ok") {
                            window.location.href = "/peliculas_app/detalle_usuario.jsp?usuario_id=<%=usuario.getId()%>";
                        } else {
                            $("#result").html("<div class='alert alert-danger' role='alert'>" + response + "</div>");
                        }
                      },
                      404: function (response) {
                          $("#result").html("<div class='alert alert-danger' role='alert'>Error al enviar datos</div>");
                      },
                      500: function(response){
                          console.error("Server error:", response);
                          $("#result").html("<div class='alert alert-danger' role='alert' " + response.toString() + "</div>");
                    }
                }
            });
        });
    });
</script>


<div class="container mt-5">
    <h2 class="mb-4">Modificar usuario</h2>
    <form method="post" id="usuario_edit-form"  class="shadow p-4 bg-white rounded">
        <div class="mb-3">
            <label for="nombre" class="form-label">Nombre</label>
            <input type="text" class="form-control" id="nombre" name="nombre" value="<%=usuario.getNombre()%>">
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">Correo Electrónico</label>

            <input type="email" class="form-control" id="email" name="email" value="<%=usuario.getEmail()%>" <%= "usuario".equals(usuario.getRole()) ? "readonly" : "" %> required>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Contraseña</label>
            <input type="password" class="form-control" id="password" name="password" value ="<%=usuario.getPassword()%>" required>
        </div>
        <div class="mb-3">
            <label for="role" class="form-label">Rol</label>
            <%
                if ("admin".equals(role)) {
            %>
                <select class="form-select" id="role" name="role" required>
                    <option disabled value="">Seleccione un rol</option>
                    <option value="admin" <%= "admin".equals(usuario.getRole()) ? "selected" : "" %>>Administrador</option>
                    <option value="usuario" <%= "usuario".equals(usuario.getRole()) ? "selected" : "" %>>Usuario</option>
                </select>
            <%
                } else {
            %>
                <input type="text" class="form-control" name="role" value="<%= usuario.getRole() %>" readonly>
            <%
                }
            %>
        </div>

        <input class="btn btn-primary" type="submit" value="Modificar">
        <!--<button type="submit" class="btn btn-primary">Guardar Usuario</button>-->
        <a href="detalle_usuario.jsp?usuario_id=<%=usuario.getId()%>" class="btn btn-secondary ms-2">Cancelar</a>

        <input type="hidden" name="id" value="<%= usuarioId %>">
        <div id="result"></div>
    </form>
</div>

<%
    }catch (UsuarioNotFoundException unfe) {
%>
    <%@ include file="includes/usuario_not_found.jsp"%>
<%
    }
%>

<%@include file="includes/footer.jsp"%>