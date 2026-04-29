<?php

namespace App\Controladores;

use App\Core\BaseControlador;

class InicioControlador extends BaseControlador
{
    public function index(): string
    {
        return $this->render('rutas/inicio');
    }
}
