<?php

require_once 'controlador/base.php';

class NotFoundControlador extends Controlador
{
    public function vista(): void
    {
        echo $this->render('404', ['titulo' => 'No encontrado']);
    }
}

new NotFoundControlador()->parse_url();
