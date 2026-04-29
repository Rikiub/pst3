<?php

namespace App\Core;

use League\Plates\Engine;

abstract class BaseControlador
{
    public function __construct(
        protected Engine $templates
    ) {
        $this->templates = $templates;
    }

    public function render(string $vista, array $datos = []): string
    {
        return $this->templates->render($vista, $datos);
    }
}
