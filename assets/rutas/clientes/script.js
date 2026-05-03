import { createGrid, crudButtons } from "/assets/js/grid.js";

const API_ENDPOINT = "/api/clientes";

const tableEl = document.getElementById("table");
/** @type {HTMLFormElement} */
const form = document.getElementById("form");
/** @type {HTMLDialogElement} */
const dialog = document.getElementById("modal-edit");

let METHOD = "PUT";

const grid = createGrid({
    columns: [
        "Cedula",
        "Nombre",
        "Apellido",
        "Correo",
        "Telefono",
        crudButtons(onModificar, onEliminar)
    ],
    server: {
        url: API_ENDPOINT,
        then: data => data.map(item => [
            item.cedula,
            item.nombre,
            item.apellido,
            item.correo,
            item.telefono,
            item.direccion,
        ]),
    },
});
grid.render(tableEl);

form.addEventListener("submit", (event) => {
    event.preventDefault();
    sendData(METHOD).then(() => {
        dialog.close();
        grid.forceRender();
    });
});

document.getElementById("btn-insertar").addEventListener("click", (event) => {
    form.reset();
    METHOD = "POST";
    dialog.showModal();
});

async function onModificar(id) {
    const data = await getData(`/${id}`);

    for (const el of form.elements) {
        if (el.name in data) {
            el.value = data[el.name];
        }
    }

    form.fecha_nacimiento.value = data.fecha_nacimiento?.substring(0, 10);

    form.elements["membresia[id_tipo]"].value = data.membresia.id_tipo;
    form.elements["membresia[id_estado]"].value = data.membresia.id_estado;
    form.elements["membresia[fecha_inicio]"].value = data.membresia.fecha_inicio.substring(0, 10);
    form.elements["membresia[fecha_fin]"].value = data.membresia.fecha_fin.substring(0, 10);

    METHOD = "PUT";
    dialog.showModal();
}

async function onEliminar(id) {
    await fetch(`${API_ENDPOINT}/${id}`, { method: "DELETE" });
}

async function getData(params = "") {
    const res = await fetch(`${API_ENDPOINT}${params}`);
    const json = await res.json();
    return json;
}

async function sendData(method) {
    const res = await fetch(API_ENDPOINT, {
        method: method,
        body: new FormData(form),
    });

    if (!res.ok) {
        console.log(await res.text());
        throw new Error(res.status)
    };
}