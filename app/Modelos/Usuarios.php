<?php

namespace App\Modelos;

use App\Core\BaseModelo;

class UsuariosModelo extends BaseModelo
{
    public function getByCedula(int $cedula)
    {
        $this->pdo->prepare('');
    }
}
