<?php

namespace App\Controladores;

use App\Core\BaseControlador;

class UsuarioControlador extends BaseControlador
{
    public function index(): string
    {
        return $this->render('rutas/usuarios', [
            'items' => []
        ]);
    }
}
