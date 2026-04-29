<?php

namespace App\Controladores;

use App\Controladores\BaseControlador;

class InicioControlador extends BaseControlador
{
    public function index(): void
    {
        echo $this->render('inicio', ['titulo' => 'Bienvenido']);
    }
}
