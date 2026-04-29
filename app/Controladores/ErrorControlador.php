<?php

namespace App\Controladores;

use App\Controladores\BaseControlador;

class ErrorControlador extends BaseControlador
{
    public function index(string $razonError): string
    {
        return $this->render(
            'error',
            ['error' => $razonError],
        );
    }
}
