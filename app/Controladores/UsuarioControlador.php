<?php

namespace App\Controladores;

use App\Controladores\BaseControlador;

class UsuarioControlador extends BaseControlador
{
    public function index(): void
    {
        echo $this->render('usuarios/index', [
            'titulo' => 'Usuarios',
            'items' => [],
        ]);
    }
}
