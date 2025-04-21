    document.addEventListener("DOMContentLoaded", () => {
    const filas = document.querySelectorAll("tbody tr");
    const itemsPagina = 8;
    let paginaActual = 1;
    const totalPaginas = Math.ceil(filas.length / itemsPagina);

    function mostrarPagina(pagina) {
        filas.forEach((fila, index) => {
            fila.style.display = ((index >= (pagina - 1) * itemsPagina) && (index < pagina * itemsPagina)) ? "table-row" : "none";
        });
    }

    document.getElementById("btn_anterior").addEventListener("click", () => {
        if (paginaActual > 1) {
            paginaActual--;
            mostrarPagina(paginaActual);
        }
    });

    document.getElementById("btn_siguiente").addEventListener("click", () => {
        if (paginaActual < totalPaginas) {
            paginaActual++;
            mostrarPagina(paginaActual);
        }
    });

    mostrarPagina(paginaActual);
});
