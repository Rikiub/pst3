<?php

require_once 'funciones/url.php';

// URL
$PAGINA = $_GET['pagina'] ?? null;
$ACCION = $_GET['accion'] ?? null;

// Si no hay parametros, redirigir a la pagina principal
if (!$PAGINA && !$ACCION) {
    $_query = http_build_query([
        'pagina' => Pagina::INICIO,
        'accion' => Accion::VISTA,
    ]);
    $_url = '?' . $_query;

    header('Location: ' . $_url);
}

// Front controller
$CONTROLADOR = 'controlador/' . $PAGINA . '.php';

if (is_file($CONTROLADOR)) {
    require_once $CONTROLADOR;
} else {
    // Redireccionar a pagina de error.
    require_once 'controlador/404.php';
}
