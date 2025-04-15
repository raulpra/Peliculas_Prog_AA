<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- Segunda barra de navegación -->
  <nav class="navbar navbar-expand-lg px-3 py-2 bg-dark border-bottom">
    <div class="container d-flex justify-content-center">
      <ul class="navbar-nav flex-row gap-4">
        <li class="nav-item">
          <a class="nav-link fs-4 px-4 py-1 rounded hover-effect text-white" href="index.jsp">PELÍCULAS</a>
        </li>
        <li class="nav-item">
          <a class="nav-link fs-4 px-4 py-1 rounded hover-effect text-white" href="generos.jsp">GÉNEROS</a>
        </li>

        <!-- barra navegación administrador -->
        <%
            if (role.equals("usuario")){
        %>
         <li class="nav-item">
             <a class="nav-link fs-4 px-4 py-1 rounded hover-effect text-white" href="favoritos.jsp?">FAVORITOS</a>
         </li>

        <%
            } else if (role.equals("admin")){
        %>
        <li class="nav-item">
            <a class="nav-link fs-4 px-4 py-1 rounded hover-effect text-white " href="usuarios.jsp">USUARIOS</a>
        </li>
        <%
        }
        %>
      </ul>

        <ul class="navbar-nav ms-auto">
            <%
                if (role.equals("usuario")) {
            %>
            <li class="nav-item">
                <a class="nav-link fs-6 px-3 py-1 rounded hover-effect text-white" href="detalle_usuario.jsp?usuario_id=<%=currentSession.getAttribute("id")%>">MI PERFIL</a>
            </li>
            <%
                }
            %>
        </ul>
    </div>
  </nav>