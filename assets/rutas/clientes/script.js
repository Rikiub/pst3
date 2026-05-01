const grid = new gridjs.Grid({
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
}).render(document.getElementById("table"));
