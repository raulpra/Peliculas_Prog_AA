<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- Segunda barra de navegación -->
  <nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
    <div class="container d-flex justify-content-center">
      <ul class="navbar-nav flex-row gap-4">
        <li class="nav-item">
          <a class="nav-link fs-4 px-4 py-2 rounded hover-effect" href="index.jsp">PELÍCULAS</a>
        </li>
        <li class="nav-item">
          <a class="nav-link fs-4 px-4 py-2 rounded hover-effect " href="login.jsp">GÉNEROS</a>
        </li>

        <!-- barra navegación administrador -->
        <%
            if (role.equals("usuario")){
        %>
         <li class="nav-item">
             <a class="nav-link fs-4 px-4 py-2 rounded hover-effect " href="favoritos.jsp">FAVORITOS</a>
         </li>
        <%
            } else if (role.equals("admin")){
        %>
        <li class="nav-item">
            <a class="nav-link fs-4 px-4 py-2 rounded hover-effect " href="usuarios.jsp">USUARIOS</a>
        </li>
        <%
        }
        %>
      </ul>
    </div>
  </nav>