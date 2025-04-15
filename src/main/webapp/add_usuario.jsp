<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar_option.jsp"%>

<%
    if ((currentSession.getAttribute("role") == null) || (!currentSession.getAttribute("role").equals("admin")) ){
        response.sendRedirect("/peliculas_app/login.jsp");
    }
%>

<script type="text/javascript">
    $(document).ready(function() {
        $("form").on("submit", function(event) {
            event.preventDefault();
            const formValue = $(this).serialize();
            $.ajax({
                url:"add_usuario",
                type: "POST",
                data: formValue,
                statusCode: {
                    200: function(response) {
                        console.log("Respuesta del servidor:", response);
                        if (response === "ok") {
                            window.location.href = "/peliculas_app/usuarios.jsp";
                        } else {
                            /*con esto siempre se queda el mensaje de login en fondo rojo.
                            $("#result").html(response);*/
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
    <h2 class="mb-4">Añadir nuevo usuario</h2>
    <form method="post" id="usuario-form"  class="shadow p-4 bg-white rounded">
        <div class="mb-3">
            <label for="nombre" class="form-label">Nombre</label>
            <input type="text" class="form-control" id="nombre" name="nombre" >
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">Correo Electrónico</label>
            <input type="email" class="form-control" id="email" name="email" required>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Contraseña</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>
        <div class="mb-3">
            <label for="role" class="form-label">Rol</label>
            <select class="form-select" id="role" name="role" required>
                <option selected disabled value="">Selecciona un rol</option>
                <option value="admin">Administrador</option>
                <option value="usuario">Usuario</option>
            </select>
        </div>

        <input class="btn btn-primary" type="submit" value="Registrar">
        <!--<button type="submit" class="btn btn-primary">Guardar Usuario</button>-->
        <a href="index.jsp" class="btn btn-secondary ms-2">Cancelar</a>

        <div id="result"></div>
    </form>
</div>