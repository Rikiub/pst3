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
        return $this->render('rutas/clientes/index', [
            'items' => []
        ]);
    }

    public function get(): string
    {
        $res = $this->modelo->getAll();
        return json_encode($res);
    }

    public function getFind(array $vars): string
    {
        $res = $this->modelo->getByCedula($vars['cedula']);

        if (!$res) {
            return http_response_code(404);
        }

        return json_encode($res);
    }

    public function insert(): string
    {
        $res = $this->modelo->insertCliente($_POST);
        return json_encode($res);
    }

    public function delete(array $vars)
    {
        $res = $this->modelo->deleteByCedula($vars['cedula']);
        return json_encode($res);
    }
}
