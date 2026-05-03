<?php

namespace App\Core;

use DateTimeImmutable;

class Validador
{
    public static function dateToString(?DateTimeImmutable $date): ?string
    {
        // Solo fecha
        $format = 'Y-m-d';

        if ($date->format('H:m:s') === '00:00:00') {
            // Agregar tiempo
            $format = $format . '\TH:i:s';
        }

        return $date ? $date->format($format) : null;
    }
}
