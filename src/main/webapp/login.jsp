<%@page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar_option.jsp"%>

<script type="text/javascript">
    $(document).ready(function() {
        $("form").on("submit", function(event) {
            event.preventDefault();
            const formValue = $(this).serialize();
            $.ajax("login", {
                type: "POST",
                data: formValue,
                statusCode: {
                    200: function(response) {
                      console.log("Respuesta del servidor:", response);
                        if (response === "ok") {
                            window.location.href = "/steam";
                        } else {
                            $("#result").html("<div class='alert alert-danger' role='alert'>" + response + "</div>");
                        }
                    }
                }
            });
        });
    });
</script>

<div class="container" style="margin-top: 100px;">
    <div class="row justify-content-center">
        <div class="col-4">
            <h3 class="text-center mb-4">Iniciar sesión</h3>
            <form>
                <div class="mb-3">
                    <label for="email" class="form-label">Correo electrónico</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>

                <div class="mb-3">
                    <label for="password" class="form-label">Contraseña</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>

                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">Login</button>
                </div>
            </form>
        </div>
    </div>
</div>

<%@include file="includes/footer.jsp"%>