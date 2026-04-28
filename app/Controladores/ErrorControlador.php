<?php

namespace App\Controladores;

use App\Controladores\BaseControlador;

class ErrorControlador extends BaseControlador
{
    public function vista(string $razonError): void
    {
        echo $this->render('error', ['titulo' => 'No encontrado', 'error' => $razonError]);
    }
}
