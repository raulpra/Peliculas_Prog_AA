
<%@ page import="org.example.database.Database" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.model.Genero" %>
<%@ page import="org.example.dao.GeneroDao" %>
<%@ page import="org.example.exception.PeliculaNotFoundException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar_option.jsp"%>

<%
  if ((currentSession.getAttribute("role") == null) || (!currentSession.getAttribute("role").equals("admin")) ){
    response.sendRedirect("/pelicula_app/login.jsp");
  }

  int peliculaId = Integer.parseInt(request.getParameter("pelicula_id"));
  Database database = new Database();
  database.connect();
  PeliculaDao peliculaDao = new PeliculaDao(database.getConnection());
  try {
    Pelicula pelicula = peliculaDao.get(peliculaId);
    String generoPelicula = pelicula.getGenero();
%>

<script type="text/javascript">
  $(document).ready(function() {
    $("form").on("submit", function(event) {
      event.preventDefault();
      const form= $("#pelicula-form")[0];//con esto cambiamos la forma en que enviamos los datos
      const formValue = new FormData(form);//y con esto. todo para poder enviar la imagen al otro lado, el servlet
      $.ajax({
        url:"edit_pelicula",
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
              window.location.href = "/peliculas_app/detalle_pelicula.jsp?pelicula_id=<%=pelicula.getId()%>";
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
  <h2 class="mb-4">Modificar película</h2>
  <form method="post" id="pelicula-form" enctype="multipart/form-data" class="shadow p-4 bg-white rounded">
    <div class="mb-3">
      <label for="titulo" class="form-label">Título</label>
      <input type="text" class="form-control" id="titulo" name="titulo" value="<%=pelicula.getTitulo()%>">
    </div>
    <div class="mb-3">
      <label for="director" class="form-label">Director</label>
      <input type="text" class="form-control" id="director" name="director" value="<%=pelicula.getDirector()%>">
    </div>
    <div class="mb-3">
      <label for="sinopsis" class="form-label">Sinopsis</label>
      <textarea class="form-control" id="sinopsis" name="sinopsis" rows="3" required><%=pelicula.getSinopsis()%></textarea>
    </div>
    <div class="mb-3">
      <label for="fecha_estreno" class="form-label">Fecha de Estreno</label>
      <input type="date" class="form-control" id="fecha_estreno" name="fecha_estreno" value="<%=pelicula.getFechaEstreno()%>">
    </div>
    <div class="mb-3">
      <label for="puntuacion" class="form-label">Puntuación (0.0 - 10.0)</label>
      <input type="number" step="0.1" min="0" max="10" class="form-control" id="puntuacion" name="puntuacion" value="<%=pelicula.getPuntuacion()%>" required>
    </div>
    <div class="mb-3">
      <label for="id_genero" class="form-label">Género</label>
      <select class="form-select" id="id_genero" name="id_genero">
        <option selected disabled value="">Selecciona un género</option>
        <% for (Genero genero : generos) { %>
        <option value="<%= genero.getId() %>" <%=generoPelicula.equals(genero.getNombre()) ? "selected" : ""%>><%= genero.getNombre() %></option>
        <% } %>
      </select>
    </div>
    <div class="mb-3">
      <label for="imagen" class="form-label">Imagen</label>
      <input type="file" class="form-control" id="imagen" name="imagen" accept="image/*" value="<%=pelicula.getImagen()%> ">
    </div>

    <div class="mb-3">
      <label for="disponible" class="form-label">Disponible en cines</label>
      <select class="form-select" id="disponible" name="disponible" required>
        <option selected disabled value="">Selecciona una opción</option>
        <option value="true" <%=pelicula.isDisponible() ? "selected" : "" %>>Disponible</option>
        <option value="false"  <%=!pelicula.isDisponible() ? "selected" : "" %>>Descatalogada</option>
      </select>
    </div>

    <input class="btn btn-primary" type="submit" value="Modificar" onclick="return confirm('¿Desea confirmar?')">
    <!--<button type="submit" class="btn btn-primary">Modificar</button>-->
    <a href="index.jsp" class="btn btn-secondary ms-2">Cancelar</a>

    <input type="hidden" name="id" value="<%=pelicula.getId()%>">

    <div id="result"></div>
  </form>
</div>


<%
} catch (PeliculaNotFoundException pnfe){
%>
<%@ include file="includes/pelicula_not_found.jsp"%>
<%
  }
%>

<%@include file="includes/footer.jsp"%>
