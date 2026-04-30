<?php

namespace App\Controladores;

use App\Core\BaseControlador;
use App\Modelos\UsuariosModelo;

class UsuarioControlador extends BaseControlador
{
    public function __construct(
        private UsuariosModelo $modelo
    ) {}

    public function index(): string
    {
        return $this->render('rutas/usuarios', [
            'items' => []
        ]);
    }

    public function getByCedula(string $cedula)
    {
        $usuario = $this->modelo->getByCedula($cedula);
    }
}
