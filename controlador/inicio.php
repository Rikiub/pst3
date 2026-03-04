<?php

require_once 'controlador/base.php';

class InicioControlador extends Controlador
{
    public function vista(): void
    {
        echo $this->render('inicio', ['titulo' => 'Bienvenido']);
    }
}

new InicioControlador()->parse_url();
