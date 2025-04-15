
<%@ page import="org.example.database.Database" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.model.Genero" %>
<%@ page import="org.example.dao.GeneroDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar_option.jsp"%>

<%
    if ((currentSession.getAttribute("role") == null) || (!currentSession.getAttribute("role").equals("admin")) ){
      response.sendRedirect("/pelicula_app/login.jsp");
    }
%>

<script type="text/javascript">
    $(document).ready(function() {
        $("form").on("submit", function(event) {
            event.preventDefault();
            const form= $("#pelicula-form")[0];//con esto cambiamos la forma en que enviamos los datos
            const formValue = new FormData(form);//y con esto. todo para poder enviar la imagen al otro lado, el servlet
            $.ajax({
                url:"add_pelicula",
                type: "POST",
                enctype: "multipart/form-data",//con esta línea le decimos que tb van otros datos. Para las imagenes o los tipo file.
                data: formValue,
                processData: false,
                contentType: false,
                cache: false,
                timeout: 10000,
                statusCode: {
                    200: function(response) {
                        console.log("Respuesta del servidor:", response);
                        if (response === "ok") {
                          window.location.href = "/peliculas_app/index.jsp";
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



<%
    Database db = new Database();
    db.connect();
    GeneroDao generoDao = new GeneroDao(db.getConnection());
    List<Genero> generos = generoDao.getAllGeneros(); // Este método debe retornar todos los géneros
%>


<div class="container mt-5">
    <h2 class="mb-4">Añadir nueva película</h2>
    <form method="post" id="pelicula-form" enctype="multipart/form-data" class="shadow p-4 bg-white rounded">
        <div class="mb-3">
            <label for="titulo" class="form-label">Título</label>
            <input type="text" class="form-control" id="titulo" name="titulo" required>
        </div>
        <div class="mb-3">
            <label for="director" class="form-label">Director</label>
            <input type="text" class="form-control" id="director" name="director" required>
        </div>
        <div class="mb-3">
            <label for="sinopsis" class="form-label">Sinopsis</label>
            <textarea class="form-control" id="sinopsis" name="sinopsis" rows="3" required></textarea>
        </div>
        <div class="mb-3">
            <label for="fecha_estreno" class="form-label">Fecha de Estreno</label>
            <input type="date" class="form-control" id="fecha_estreno" name="fecha_estreno" required>
        </div>
        <div class="mb-3">
            <label for="puntuacion" class="form-label">Puntuación (0.0 - 10.0)</label>
            <input type="number" step="0.1" min="0" max="10" class="form-control" id="puntuacion" name="puntuacion" required>
        </div>
        <div class="mb-3">
            <label for="id_genero" class="form-label">Género</label>
            <select class="form-select" id="id_genero" name="id_genero" required>
                <option selected disabled value="">Selecciona un género</option>
                <% for (Genero genero : generos) { %>
                <option value="<%= genero.getId() %>"><%= genero.getNombre() %></option>
                <% } %>
            </select>
        </div>
        <div class="mb-3">
            <label for="imagen" class="form-label">Imagen</label>
            <input type="file" class="form-control" id="imagen" name="imagen" accept="image/*" required>
        </div>
        <button type="submit" class="btn btn-primary">Guardar Película</button>
        <a href="index.jsp" class="btn btn-secondary ms-2">Volver</a>

      <div id="result"></div>
    </form>
</div>
