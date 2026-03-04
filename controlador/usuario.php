<?php

require_once 'controlador/base.php';

class UsuarioControlador extends Controlador
{
    public function vista(): void
    {
        echo $this->render('usuario', ['titulo' => 'Usuarios']);
    }
}

new UsuarioControlador()->parse_url();
