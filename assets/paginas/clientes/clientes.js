import { crudTableComponent } from "/assets/componentes/crudTable/crudTable.js";
import { modalFormComponent } from "/assets/componentes/modalForm/modalForm.js";
import { extractDate } from "/assets/js/helpers.js";
import { fetchApi } from "/assets/js/api.js";
import Alpine from "alpinejs";

const ENDPOINT = "clientes";

Alpine.data("crudTable", () => crudTableComponent({
    endpoint: ENDPOINT,
    columns: [
        "Cedula",
        "Nombre",
        "Apellido",
        "Correo",
        "Telefono",
    ],
    fieldMap: (item) => [
        item.cedula,
        item.nombre,
        item.apellido,
        item.correo,
        item.telefono,
    ]
}));

Alpine.data("modalForm", () => ({
    ...modalFormComponent({
        endpoint: ENDPOINT,
        transformEditData: (data) => {
            data.fecha_nacimiento = extractDate(data.fecha_nacimiento);
            data.membresia.fecha_inicio = extractDate(data.membresia.fecha_inicio);
            data.membresia.fecha_fin = extractDate(data.membresia.fecha_fin);
            return data;
        },
    }),
    async validarCedula(input) {
        this.checkValidity(input);

        if (this.method === "POST") {
            let cliente = null;

            try {
                cliente = await fetchApi(`/${ENDPOINT}/${input.value}`);
            } catch { }

            if (cliente) this.setInputValidity(input, false, "El cliente ya existe");
        }
    }
}));
