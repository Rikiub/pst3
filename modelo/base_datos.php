<?php

class BaseDatos
{
    public function __construct(
        private string $host = 'localhost',
        private string $dbname = '',
        private string $usuario = 'root',
        private string $clave = '',
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
