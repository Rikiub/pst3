<?php

namespace App\Controladores;

use App\Controladores\BaseControlador;

class UsuarioControlador extends BaseControlador
{
    public function vista(): void
    {
        echo $this->render('usuario', ['titulo' => 'Usuarios']);
    }
}
