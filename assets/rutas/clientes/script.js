import { createGrid, crudButtons } from "/assets/js/grid.js";

const tableEl = document.getElementById("table");
const form = document.forms["form"];
const dialogId = "dialog";

const grid = createGrid({
    columns: [
        "Cedula",
        "Nombre",
        "Apellido",
        "Correo",
        "Telefono",
        crudButtons(onDialogModificar, onDialogEliminar)
    ],
    server: {
        url: "/api/clientes",
        then: data => data.map(item => [
            item.cedula,
            item.nombre,
            item.apellido,
            item.correo,
            item.telefono,
            item.direccion,
        ]),
    },
    autoWidth: true,
});
grid.render(tableEl);

function onDialogInsertar() {
    openDialog(dialogId);
}

function onDialogModificar(id) {
    openDialog(dialogId);
}

function onDialogEliminar(id) {

}