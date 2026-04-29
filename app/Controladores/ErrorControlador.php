<?php

namespace App\Controladores;

use App\Core\BaseControlador;

class ErrorControlador extends BaseControlador
{
    public function index(): string
    {
        $code = $_GET['code'];
        $mensaje = '';

        if ($code == '404') {
            $mensaje = '404: Pagina no encontrada';
        } else if ($code == '405') {
            $mensaje = '405: Metodo no soportado';
        }

        return $this->render(
            'rutas/error',
            ['mensaje' => $mensaje],
        );
    }
}
