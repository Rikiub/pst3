<?php

namespace App\Controladores;

use Exception;

class BaseControlador
{
    /**
     * @param array<int,string> $datos
     */
    protected function render(string $vista, array $datos = []): string
    {
        // Extrae el array asociativo a variables individuales
        extract($datos);

        // Ruta del archivo de vista
        $vista = "app/Vistas/{$vista}.php";

        if (!file_exists($vista)) {
            throw new Exception('Vista no encontrada: ' . $vista);
        }

        // Extraer HTML de la vista
        ob_start();
        include $vista;
        $BODY = ob_get_clean();

        // Insertar HTML en la plantilla base
        ob_start();
        include 'app/Vistas/_base.php';
        $BODY = ob_get_clean();

        return $BODY;
    }
}
