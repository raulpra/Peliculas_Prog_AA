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
                url:"add_genero",
                type: "POST",
                data: formValue,
                statusCode: {
                    200: function(response) {
                        console.log("Respuesta del servidor:", response);
                        if (response === "ok") {
                            window.location.href = "/peliculas_app/generos.jsp";
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
    <h2 class="mb-4">Añadir nuevo género</h2>
    <form method="post" id="genero-form"  class="shadow p-4 bg-white rounded">
        <div class="mb-3">
            <label for="nombre" class="form-label">Nombre del género</label>
            <input type="text" class="form-control" id="nombre" name="nombre" required>
        </div>
        <div class="mb-3">
            <label for="descripcion" class="form-label">Descripción</label>
            <input type="text" class="form-control" id="descripcion" name="descripcion" required>
        </div>
        <div class="mb-3">
            <label for="ejemplos" class="form-label">Ejemplos :</label>
            <input type="text" class="form-control" id="ejemplos" name="ejemplos" required>
        </div>
        <div class="mb-3">
            <label for="fecha_actualizacion" class="form-label">Fecha de actualización</label>
            <input type="date" class="form-control" id="fecha_actualizacion" name="fecha_actualizacion" required>
        </div>
        <div class="mb-3">
            <label for="activo" class="form-label">Activo</label>
            <select class="form-select" id="activo" name="activo" required>
                <option disabled value="">Seleccione una opción</option>
                <option value="true" >Si</option>
                <option value="false">No</option>
            </select>
        </div>
        <input class="btn btn-primary" type="submit" value="Registrar">
        <a href="generos.jsp" class="btn btn-secondary ms-2">Cancelar</a>

        <div id="result"></div>
    </form>
</div>
