<?php

namespace App\Controladores;

use App\Controladores\BaseControlador;

class UsuarioControlador extends BaseControlador
{
    public function index(): string
    {
        return $this->render('rutas/usuarios', [
            'items' => []
        ]);
    }
}
