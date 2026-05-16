<?php

namespace App\Controller;

use App\Core\BaseControlador;

class InicioControlador extends BaseControlador
{
    public function index(): string
    {
        return $this->render('inicio/index');
    }
}
