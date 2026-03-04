<?php

class Controlador
{
    /* Determinar y ejecutar un metodo del controlador automaticamente segun el parametro "accion" en la URL. */
    public function parse_url(): void
    {
        $accion = $_GET['accion'] ?? null;

        if (!$accion) {
            throw new Error('Se requiere una accion');
        }
        if (!method_exists($this, $accion)) {
            throw new Error("Accion ' . $accion . ' no encontrada en {$this}.");
        }

        $this->$accion();
    }

    /**
     * @param array<int,string> $datos
     */
    protected function render(string $vista, array $datos = []): string
    {
        // Extrae el array asociativo a variables individuales
        extract($datos);

        // Ruta del archivo de vista
        $vista = "vista/{$vista}.php";

        if (!file_exists($vista)) {
            throw new Exception('Vista no encontrada: ' . $vista);
        }

        // Extraer HTML de la vista
        ob_start();
        require $vista;
        $BODY = ob_get_clean();

        // Insertar HTML en la plantilla base
        ob_start();
        require 'vista/base.php';
        $BODY = ob_get_clean();

        return $BODY;
    }
}
