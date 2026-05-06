<?php

namespace App\Core;

use DateTimeImmutable;

class Validador
{
    public static function dateToString(?DateTimeImmutable $date): ?string
    {
        return $date ? $date->format('Y-m-d H:i:s') : null;
    }
}
