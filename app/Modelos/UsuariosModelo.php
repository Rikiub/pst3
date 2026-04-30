<?php

namespace App\Modelos;

use App\Core\BaseModelo;

readonly class Usuario
{
    public string $nombre;
}

class UsuariosModelo extends BaseModelo
{
    public function getByCedula(int $cedula): ?Usuario
    {
        $stmt = $this->pdo->prepare('SELECT * FROM usuarios WHERE cedula = ?');
        $stmt->execute([$cedula]);
        return $stmt->fetch()[0];
    }
}
