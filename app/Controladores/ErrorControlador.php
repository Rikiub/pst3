<?php

namespace App\Controladores;

use App\Controladores\BaseControlador;

class ErrorControlador extends BaseControlador
{
    public function index(): string
    {
        $code = $_GET['code'];

        if ($code == '404') {
            $mensaje = '404: Pagina no encontrada';
        } else if ($code == '405') {
            $mensaje = '405: Metodo no soportado';
        }

        return $this->render(
            'rutas/error',
            ['error' => $mensaje],
        );
    }
}
