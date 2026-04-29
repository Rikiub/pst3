<?php

namespace App\Core;

use PDO;
use PDOException;
use RuntimeException;

/**
 * Crear instancia PDO segun los parametros
 */
function createPDO(
    string $host,
    string $database,
    string $username,
    string $password
): PDO {
    $defaultOptions = [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES => false,
    ];

    $dsn = "mysql:host={$host};dbname={$database};";

    try {
        return new PDO(
            $dsn,
            $username,
            $password,
            $defaultOptions
        );
    } catch (PDOException $e) {
        throw new RuntimeException('Conexion a base de datos fallida: ' . $e->getMessage());
    }
}
