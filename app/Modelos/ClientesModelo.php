<?php

namespace App\Modelos;

use App\Core\BaseModelo;

class ClientesModelo extends BaseModelo
{
    private function sqlSelect(): string
    {
        return 'SELECT
                cliente.cedula_cliente AS cedula,
                cliente.id_membresia,
                persona.nombre,
                persona.apellido,
                persona.correo,
                persona.telefono,
                persona.direccion,
                persona.fecha_nacimiento,
                persona.fecha_registro,
                persona.activo,
                membresia.fecha_inicio,
                membresia.fecha_fin,
                membresia.id_membresia,
                membresia.id_tipo AS membresia_id_tipo,
                membresia.id_estado AS membresia_id_estado,
                tipo_membresia.nombre   AS membresia_tipo_nombre,
                estado_membresia.nombre AS membresia_estado_nombre
            FROM cliente
            LEFT JOIN persona ON persona.cedula_persona = cliente.cedula_cliente
            LEFT JOIN membresia ON cliente.id_membresia = membresia.id_membresia
            LEFT JOIN tipo_membresia ON membresia.id_tipo = tipo_membresia.id_tipo
            LEFT JOIN estado_membresia ON membresia.id_estado = estado_membresia.id_estado
        ';
    }

    public function getAll(): array
    {
        $stmt = $this->pdo->prepare(
            $this->sqlSelect()
            . 'ORDER BY persona.apellido, persona.nombre'
        );
        $stmt->execute();
        return $stmt->fetchAll();
    }

    public function getByCedula(string $cedula): ?array
    {
        $stmt = $this->pdo->prepare(
            $this->sqlSelect()
            . 'WHERE cliente.cedula_cliente = ?'
        );
        $stmt->execute([$cedula]);
        $row = $stmt->fetch();
        return $row ?: null;
    }

    public function insertCliente(array $datos)
    {
        return $this->pdoInsert('cliente', $datos);
    }

    public function updateCliente(int $cedula, array $datos)
    {
        return $this->pdoUpdate(
            'cliente',
            $datos,
            ['cedula_cliente' => $cedula],
        );
    }

    public function deleteByCedula(int $cedula): int
    {
        $stmt = $this->pdo->prepare(
            'DELETE FROM cliente
            WHERE cedula_cliente = ?'
        );
        $stmt->execute([$cedula]);
        return $stmt->rowCount();
    }
}
