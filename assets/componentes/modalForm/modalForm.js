import { fetchApi } from "/assets/js/api.js";
import FormDataJson from "form-data-json";
import Alpine from "alpinejs";

/** @param {{
     * endpoint: string,
     * transformEditData: (data: object) => object,
 * }} options
 */
export function modalFormComponent(options = { transformEditData: (data) => data }) {
    const { endpoint, transformEditData } = options;

    return {
        endpoint: options.endpoint,
        transformEditData: transformEditData,
        mode: "add",
        id: "",

        loading: false,
        errors: {},

        handleEvent(detail) {
            if (!detail.mode) console.error("A 'mode' must be provided");

            if (detail.mode === "add") {
                this.onAdd();
                return;
            }

            if (!detail.id) console.error("A 'id' must be provided");

            if (detail.mode === "edit") {
                this.onEdit(detail.id);
            } else if (detail.mode === "delete") {
                this.onDelete(detail.id);
            } else {
                console.error("'mode' must be one of: 'add', 'edit', 'delete'");
            }
        },

        async handleSubmit() {
            let valid = true;

            /** @type {HTMLFormElement} */
            const form = this.$refs.form;

            /** Validar formulario */
            for (const input of form.elements) {
                if (input.checkValidity()) {
                    this.setInputValidity(input, true);
                } else {
                    this.setInputValidity(input, false);
                    valid = false;
                }
            }

            if (this.mode === "delete" || valid) {
                let body = null;
                let url = `/${this.endpoint}`;
                this.loading = true;

                if (this.mode == "edit" || this.mode == "delete") {
                    url = `${url}/${this.id}`;
                }
                if (this.mode == "edit" || this.mode == "add") {
                    body = FormDataJson.toJson(this.$refs.form, { skipEmpty: true });
                }

                const method = {
                    "add": "POST",
                    "edit": "PUT",
                    "delete": "DELETE",
                }[this.mode];

                await fetchApi(url, { method, body: body });

                this.loading = false;
                this.$refs.modal.close();
                this.$dispatch("form-success");
            } else {
                console.log("Invalid input, form submit canceled");
            }
        },

        async onAdd() {
            this.clearForm();
            this.mode = "add";
            this.$refs.modal.showModal();
        },
        async onEdit(id) {
            this.clearForm();

            this.mode = "edit";
            this.id = id;

            let data = await fetchApi(`/${this.endpoint}/${this.id}`);
            data = this.transformEditData(data);

            FormDataJson.fromJson(this.$refs.form, data, { clearOthers: true });
            this.$refs.modal.showModal();
        },
        async onDelete(id) {
            this.mode = "delete";
            this.id = id;
            this.$refs.modal.showModal();
        },

        checkValidity(input) {
            this.clearInputValidity(input);

            if (input.checkValidity()) {
                this.setInputValidity(input, true);
            } else {
                this.setInputValidity(input, false);
            }
        },

        /** @param {HTMLInputElement} input
         * @param {boolean} valid
         * @param {string?} message
         */
        setInputValidity(input, valid, message = null) {
            message = valid
                ? ""
                : message ?? input.validationMessage;
            valid ? input.setCustomValidity("") : input.setCustomValidity(message);

            input.setAttribute("aria-invalid", !valid);
            this.errors[input.name] = message;
        },
        /** @param {HTMLInputElement} input */
        clearInputValidity(input) {
            input.setCustomValidity("");
            input.removeAttribute("aria-invalid");
            this.errors[input.name] = "";
        },
        clearForm() {
            this.$refs.form.reset();

            for (const input of this.$refs.form.elements) {
                this.clearInputValidity(input);
            }
        },
    };
}

Alpine.data("modalForm", modalFormComponent);