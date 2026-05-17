<input name="id_seguimiento" hidden>

<label>Fecha de seguimiento
    <input type="date" name="fecha" required>
    <small x-text="errors.fecha"></small>
</label>

<hr>

<fieldset class="grid">
    <label>Proteínas (g)
        <input type="number" name="proteinas_g" step="any" min="0" x-mask="999.9" placeholder="0.0">
        <small x-text="errors.proteinas_g"></small>
    </label>

    <label>Carbohidratos (g)
        <input type="number" name="carbohidratos_g" step="any" min="0" x-mask="999.9" placeholder="0.0">
        <small x-text="errors.carbohidratos_g"></small>
    </label>
</fieldset>

<fieldset class="grid">
    <label>Grasas (g)
        <input type="number" name="grasas_g" step="any" min="0" x-mask="999.9" placeholder="0.0">
        <small x-text="errors.grasas_g"></small>
    </label>

    <label>Calorías diarias (kcal)
        <input type="number" name="calorias_diarias" step="any" min="0" x-mask="9999.9" placeholder="0.0">
        <small x-text="errors.calorias_diarias"></small>
    </label>
</fieldset>