document.addEventListener("DOMContentLoaded", () => {
    const cards = document.querySelectorAll(".card-paginacion");
    const itemsPagina = 6;
    let paginaActual = 1;
    const totalPaginas = Math.ceil(cards.length / itemsPagina);

    function mostrarPagina(pagina) {
        cards.forEach((card, index) => {
            card.style.display = ((index >= (pagina - 1) * itemsPagina) && (index < pagina * itemsPagina)) ? "block" : "none";
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