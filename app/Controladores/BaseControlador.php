<?php

namespace App\Controladores;

use League\Plates\Engine;

class BaseControlador
{
    public function __construct(
        protected Engine $templates = new Engine('app/Vistas')
    ) {
        $this->templates = $templates;
    }

    public function render(string $vista, array $datos = []): string
    {
        return $this->templates->render($vista, $datos);
    }
}
