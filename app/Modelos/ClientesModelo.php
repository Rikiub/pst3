<?php

namespace App\Modelos;

use App\Core\BaseModelo;

readonly class Usuario
{
    public function __construct(
        public int $cedula_persona,
        public string $nombre,
        public string $apellido,
        public string $correo,
        public int $telefono,
        public int $direccion,
        public string $fecha_nacimiento,
        public string $fecha_registro,
        public bool $activo
    ) {}
}

class ClientesModelo extends BaseModelo
{
    private string $tabla = 'cliente';

    public function getAll(): array
    {
        $stmt = $this->pdo->prepare(
            "SELECT persona.* FROM $this->tabla
            LEFT JOIN
                persona ON persona.cedula_persona = cliente.cedula_cliente"
        );
        $stmt->execute();
        return $stmt->fetchAll();
    }

    public function getByCedula(int $cedula): array
    {
        $stmt = $this->pdo->prepare(
            "SELECT * FROM $this->tabla
            WHERE cedula_persona = ?"
        );
        $stmt->execute([$cedula]);
        return $stmt->fetch()[0];
    }
}
