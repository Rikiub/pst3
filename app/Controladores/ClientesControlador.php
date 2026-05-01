<?php

namespace App\Controladores;

use App\Core\BaseControlador;
use App\Modelos\ClientesModelo;

class ClientesControlador extends BaseControlador
{
    public function __construct(
        private ClientesModelo $modelo
    ) {}

    public function index(): string
    {
        return $this->render('rutas/clientes', [
            'items' => []
        ]);
    }

    public function getAll(): string
    {
        $res = $this->modelo->getAll();
        return json_encode($res);
    }

    public function getByCedula(string $cedula)
    {
        $res = $this->modelo->getByCedula($cedula);
        return json_encode($res);
    }
}
