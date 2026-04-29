<?php

namespace App\Core;

use PDO;

abstract class BaseModelo
{
    public function __construct(
        protected PDO $pdo
    ) {
        $this->pdo = $pdo;
    }
}
