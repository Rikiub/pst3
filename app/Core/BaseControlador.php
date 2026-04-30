<?php

namespace App\Core;

use DI\Attribute\Inject;
use League\Plates\Engine;

abstract class BaseControlador
{
    #[Inject]
    protected Engine $templates;

    public function render(string $vista, array $datos = []): string
    {
        return $this->templates->render($vista, $datos);
    }
}
