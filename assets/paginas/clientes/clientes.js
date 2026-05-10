import { createGrid } from "/assets/js/grid.js";
import { API_PREFIX, fetchApi } from "/assets/js/api.js";
import FormDataJson from "form-data-json";
import Alpine from "alpinejs";

document.addEventListener("alpine:init", () => {
    Alpine.data("crud", () => ({
        endpoint: "clientes",
        method: "PUT",
        id: "",

        init() {
            this.grid = createGrid({
                columns: [
                    "Cedula",
                    "Nombre",
                    "Apellido",
                    "Correo",
                    "Telefono",
                ],
                server: {
                    url: `${API_PREFIX}/${this.endpoint}`,
                    then: data => data.map(item => [
                        item.cedula,
                        item.nombre,
                        item.apellido,
                        item.correo,
                        item.telefono,
                        item.direccion,
                    ]),
                },
                onAdd: this.onAdd.bind(this),
                onEdit: this.onEdit.bind(this),
                onDelete: this.onDelete.bind(this),
            });
            this.grid.render(this.$refs.table);
        },

        async handleSubmit() {
            let body = null;
            let url = "";

            if (this.method == "PUT" || this.method == "DELETE") {
                url = `/${this.endpoint}/${this.id}`;
            }
            if (this.method == "PUT" || this.method == "POST") {
                body = FormDataJson.toJson(this.$refs.form, { skipEmpty: true });
            }

            await fetchApi(url, { method: this.method, body: body });

            this.$refs.modal.close();
            this.grid.forceRender();
        },

        async onAdd() {
            this.method = "POST";
            this.$refs.form.reset();
            this.$refs.modal.showModal();
        },
        async onEdit(id) {
            this.method = "PUT";
            this.id = id;

            const data = await fetchApi(`/${this.endpoint}/${this.id}`);

            const onlyDate = (value) => value?.split('T')[0];
            data.fecha_nacimiento = onlyDate(data.fecha_nacimiento);
            data.membresia.fecha_inicio = onlyDate(data.membresia.fecha_inicio);
            data.membresia.fecha_fin = onlyDate(data.membresia.fecha_fin);

            FormDataJson.fromJson(this.$refs.form, data, { clearOthers: true });
            this.$refs.modal.showModal();
        },
        async onDelete(id) {
            this.method = "DELETE";
            this.id = id;
            this.$refs.modal.showModal();
        },
    }));
});
