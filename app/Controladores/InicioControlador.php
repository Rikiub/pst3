<?php

namespace App\Controladores;

use App\Controladores\BaseControlador;

class InicioControlador extends BaseControlador
{
    public function index(): string
    {
        return $this->render('inicio');
    }
}
