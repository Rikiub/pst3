import { API_PREFIX, fetchApi } from "/assets/js/api.js";
import { createGrid } from "/assets/js/grid.js";
import FormDataJson from "form-data-json";
import Alpine from "alpinejs";

/** @param {{
     * endpoint: string,
     * columns: array<string|object>,
     * fieldMap: (item: object) => array<string|int>,
     * gridOptions: object,
 * }} options
 */
export function crudTableComponent(options = { gridOptions: {} }) {
    const { endpoint, columns, fieldMap, gridOptions } = options;

    return {
        grid: null,

        init() {
            const serverUrl = `${API_PREFIX}/${endpoint}`
            const modalEvent = "open-modal";

            this.grid = createGrid({
                columns: columns,
                server: {
                    url: serverUrl,
                    then: data => data.map(item => fieldMap(item)),
                },
                crud: {
                    onAdd: () => this.$dispatch(modalEvent, { mode: "add" }),
                    onEdit: (id) => this.$dispatch(modalEvent, { mode: "edit", id }),
                    onDelete: (id) => this.$dispatch(modalEvent, { mode: "delete", id }),
                },
                ...gridOptions,
            });
            this.grid.render(this.$refs.table);
        },

        refreshGrid() {
            this.grid.forceRender();
        }
    };
}

Alpine.data("crudTable", crudTableComponent);