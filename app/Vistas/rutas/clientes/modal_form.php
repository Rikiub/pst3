<form class="dialog-form" name="form">
    <div class="content">
        <div>
            <label>Cédula
                <input name="cedula" type="text" placeholder="29135792">
            </label>

            <label>Nombre
                <input name="nombre" type="text" placeholder="Juan">
            </label>

            <label>Apellido
                <input name="apellido" type="text" placeholder="Pérez">
            </label>
        </div>

        <div>
            <label>Teléfono
                <input name="telefono" type="tel" placeholder="0414-526949">
            </label>

            <label>Correo
                <input name="correo" type="email" placeholder="correo@ejemplo.com">
            </label>

            <label>Dirección
                <input name="direccion" type="text" placeholder="Calle Principal #123">
            </label>
        </div>

        <div>
            <label>Fecha de Nacimiento
                <input name="fecha_nacimiento" type="date">
            </label>

            <label>Fecha de Registro
                <input name="fecha_registro" type="date">
            </label>

            <label>Activo
                <input name="activo" type="checkbox" value="1">
            </label>
        </div>

        <div>
            <select>Tipo Membresia
                <option name="membresia_id_tipo" value="1">Mensual</option>
            </select>

            <select>Estado Membresia
                <option name="membresia_id_estado" value="1">Activo</option>
            </select>

            <label>Fecha Inicio Membresía
                <input name="fecha_inicio" type="date">
            </label>
    
            <label>Fecha Fin Membresía
                <input name="fecha_fin" type="date">
            </label>
        </div>
    </div>

    <button type="submit">Enviar</button>
</form>