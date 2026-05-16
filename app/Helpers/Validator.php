<?php

namespace App\Helpers;

use DateTimeInterface;

class Validator
{
    public static function dateToString(?DateTimeInterface $date): ?string
    {
        return $date ? $date->format('Y-m-d H:i:s') : null;
    }
}
