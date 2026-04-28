<?php

namespace App\Modelos;

use App\Config\DBConfig;
use PDO;

class BaseDatos
{
    public function __construct(
        private string $host = DBConfig::HOST,
        private string $dbname = DBConfig::DBNAME,
        private string $usuario = DBConfig::USUARIO,
        private string $clave = DBConfig::CLAVE,
    ) {
        $this->host = getenv('MARIADB_HOST') ?? $host;
        $this->dbname = getenv('MARIADB_DATABASE') ?? $dbname;
        $this->usuario = getenv('MARIADB_USER') ?? $usuario;
        $this->clave = getenv('MARIADB_PASSWORD') ?? $clave;
    }

    public function getConexion(): PDO
    {
        $dsn = 'mysql' . ':' . 'host=' . $this->host . ';' . 'dbname=' . $this->dbname . ';';
        $pdo = new PDO($dsn, $this->usuario, $this->clave);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        return $pdo;
    }
}
