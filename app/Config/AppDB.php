<?php

namespace App\Config;

use App\Config\DBConfig;
use PDO;
use PDOStatement;

class AppDB
{
    private ?PDO $pdo = null;

    public function __construct(
        private string $host = DBConfig::HOST,
        private string $dbname = DBConfig::DBNAME,
        private string $usuario = DBConfig::USUARIO,
        private string $clave = DBConfig::CLAVE,
    ) {
        $this->host = $host ?? getenv('DB_HOST');
        $this->dbname = $dbname ?? getenv('DB_NAME');
        $this->usuario = $usuario ?? getenv('DB_USER');
        $this->clave = $clave ?? getenv('DB_PASSWORD');
    }

    public function crearConexion(): PDO
    {
        if ($this->pdo === null) {
            $dsn = "mysql:host={$this->host};dbname={$this->dbname};";
            $this->pdo = new PDO($dsn, $this->usuario, $this->clave, [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            ]);
        }
        return $this->pdo;
    }

    public function query(string $sql, array $params = []): PDOStatement
    {
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute($params);
        return $stmt;
    }
}
