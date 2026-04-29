<?php

namespace App\Config;

use FastRoute\RouteCollector;

return function (RouteCollector $r) {
    $r->addRoute('GET', '/', ['InicioControlador', 'index']);
    $r->addRoute('GET', '/error', ['ErrorControlador', 'index']);

    $r->addRoute('GET', '/facturacion', ['FacturacionControlador', 'index']);

    $r->addRoute('GET', '/usuarios', ['UsuarioControlador', 'index']);
    $r->addRoute('GET', '/usuarios/{id:\d+}', ['UsuarioControlador', 'index']);
};
