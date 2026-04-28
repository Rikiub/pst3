<?php

namespace App\Controladores;

use App\Controladores\BaseControlador;

class InicioControlador extends BaseControlador
{
    public function vista(): void
    {
        echo $this->render('inicio', ['titulo' => 'Bienvenido']);
    }
}
