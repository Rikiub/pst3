import { createGrid } from "/assets/js/grid.js";

const tableEl = document.getElementById("table");

const grid = createGrid({
    columns: [
        "Cedula",
        "Nombre",
        "Apellido",
        "Correo",
        "Telefono",
    ],
    server: {
        url: "/api/clientes",
        then: data => data.map(item => [
            item.cedula_persona,
            item.nombre,
            item.apellido,
            item.correo,
            item.telefono,
        ]),
    },
});
grid.render(tableEl);
