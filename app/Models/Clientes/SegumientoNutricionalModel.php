<?php

namespace App\Models\Clientes;

use App\Helpers\Validator;
use App\Models\BaseModel;
use DateTimeImmutable;
use InvalidArgumentException;

readonly class SeguimientoNutricionalDTO
{
    public function __construct(
        public ?int $id_seguimiento = null,
        public ?string $cedula_cliente = null,
        public ?DateTimeImmutable $fecha = new DateTimeImmutable(),
        public ?float $proteinas_g = null,
        public ?float $carbohidratos_g = null,
        public ?float $grasas_g = null,
        public ?float $calorias_diarias = null,
    ) {}

    public function validarInsert(): void
    {
        if (!$this->cedula_cliente) {
            throw new InvalidArgumentException('Debe tener una cédula de cliente');
        }
        if (!$this->fecha) {
            throw new InvalidArgumentException('Debe tener una fecha de seguimiento');
        }
    }
}

class SegumientoNutricionalModel extends BaseModel
{
    private function sqlSelect(): string
    {
        return 'SELECT * FROM seguimiento_nutricional';
    }

    private function mapRow(array $row): SeguimientoNutricionalDTO
    {
        return $this->mapper->map(SeguimientoNutricionalDTO::class, $row);
    }

    /**
     * Obtiene todos los seguimientos de un cliente.
     * @return array<SeguimientoNutricionalDTO>
     */
    public function getAllByCliente(string $cedula): array
    {
        $stmt = $this->pdo->prepare(
            <<<SQL
                {$this->sqlSelect()} 
                WHERE cedula_cliente = ?
                ORDER BY fecha DESC
            SQL
        );
        $stmt->execute([$cedula]);
        $rows = $stmt->fetchAll();

        return array_map([$this, 'mapRow'], $rows);
    }

    /**
     * Busca un seguimiento por su ID.
     */
    public function findById(int $id): SeguimientoNutricionalDTO|false
    {
        $stmt = $this->pdo->prepare(
            <<<SQL
                {$this->sqlSelect()} 
                WHERE id_seguimiento = ?
            SQL
        );
        $stmt->execute([$id]);
        $row = $stmt->fetch();

        if (!$row) {
            return false;
        }

        return $this->mapRow($row);
    }

    /**
     * Inserta un nuevo seguimiento.
     */
    public function insert(SeguimientoNutricionalDTO $seguimiento): SeguimientoNutricionalDTO
    {
        $seguimiento->validarInsert();

        $this->pdoInsert('seguimiento_nutricional', [
            'cedula_cliente' => $seguimiento->cedula_cliente,
            'fecha' => Validator::dateToString($seguimiento->fecha),
            'proteinas_g' => $seguimiento->proteinas_g,
            'carbohidratos_g' => $seguimiento->carbohidratos_g,
            'grasas_g' => $seguimiento->grasas_g,
            'calorias_diarias' => $seguimiento->calorias_diarias,
        ]);

        $id = $this->pdo->lastInsertId();
        return $this->findById($id);
    }

    /**
     * Actualiza un seguimiento existente.
     */
    public function update(SeguimientoNutricionalDTO $seguimiento): SeguimientoNutricionalDTO
    {
        if (!$seguimiento->id_seguimiento) {
            throw new InvalidArgumentException('Se requiere id_seguimiento para actualizar');
        }

        $seguimiento->validarInsert();

        $this->pdoUpdate('seguimiento_fisico', [
            'cedula_cliente' => $seguimiento->cedula_cliente,
            'fecha' => Validator::dateToString($seguimiento->fecha),
            'proteinas_g' => $seguimiento->proteinas_g,
            'carbohidratos_g' => $seguimiento->carbohidratos_g,
            'grasas_g' => $seguimiento->grasas_g,
            'calorias_diarias' => $seguimiento->calorias_diarias,
        ], ['id_seguimiento' => $seguimiento->id_seguimiento]);

        return $this->findById($seguimiento->id_seguimiento);
    }

    /**
     * Elimina un seguimiento por ID.
     */
    public function delete(int $id): int
    {
        $stmt = $this->pdo->prepare(
            'DELETE FROM seguimiento_nutricional WHERE id_seguimiento = ?'
        );
        $stmt->execute([$id]);
        return $stmt->rowCount();
    }
}
