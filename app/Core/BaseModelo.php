<?php

namespace App\Core;

use PDO;

abstract class BaseModelo
{
    public function __construct(
        protected PDO $pdo
    ) {}

    /**
     * Inserta una fila en una tabla.
     */
    protected function pdoInsert(string $table, array $data): int|false
    {
        $columns = array_keys($data);
        $placeholders = array_map(fn($col) => ":$col", $columns);

        $sql = sprintf(
            'INSERT INTO %s (%s) VALUES (%s)',
            $table,
            implode(', ', $columns),
            implode(', ', $placeholders)
        );

        $stmt = $this->pdo->prepare($sql);

        if ($stmt->execute($data)) {
            return $this->pdo->lastInsertId();
        }
        return false;
    }

    /**
     * Actualizar fila en una tabla.
     */
    protected function pdoUpdate(string $table, array $data, array $conditions): int
    {
        $setParts = [];
        foreach ($data as $col => $val) {
            $setParts[] = "$col = :set_$col";
        }

        $whereParts = [];
        foreach ($conditions as $col => $val) {
            $whereParts[] = "$col = :where_$col";
        }

        $sql = sprintf(
            'UPDATE %s SET %s WHERE %s',
            $table,
            implode(', ', $setParts),
            implode(' AND ', $whereParts)
        );

        // Prefix bind values to avoid name collisions
        $params = [];
        foreach ($data as $col => $val) {
            $params["set_$col"] = $val;
        }
        foreach ($conditions as $col => $val) {
            $params["where_$col"] = $val;
        }

        $stmt = $this->pdo->prepare($sql);
        $stmt->execute($params);
        return $stmt->rowCount();
    }

    protected function pdoDelete(string $table, string $column, int|string $id)
    {
        $sql = sprintf(
            'DELETE FROM %s
            WHERE %s = ?',
            $table,
            $column
        );
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute([$id]);
        return $stmt->rowCount();
    }
}
