<?php

use App\Controladores\ClientesControlador;
use App\Controladores\ErrorControlador;
use App\Controladores\InicioControlador;
use FastRoute\RouteCollector;

return function (RouteCollector $r) {
    $r->addRoute('GET', '/', [InicioControlador::class, 'index']);
    $r->addRoute('GET', '/error', [ErrorControlador::class, 'index']);

    $r->addRoute('GET', '/clientes', [ClientesControlador::class, 'index']);
    // $r->addRoute('GET', '/clientes/{id:\d+}', [ClientesControlador::class, 'index']);

    $r->addGroup('/api', function (RouteCollector $r) {
        $r->addRoute('GET', '/clientes', [ClientesControlador::class, 'getAll']);
    });
};
