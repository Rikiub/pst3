<?php

use App\Controller\Clientes\ClientesControlador;
use App\Controller\Clientes\SeguimientoFisicoControlador;
use App\Controller\ErrorControlador;
use App\Controller\InicioControlador;
use FastRoute\RouteCollector;

return function (RouteCollector $r) {
    $r->addRoute('GET', '/', [InicioControlador::class, 'index']);
    $r->addRoute('GET', '/error', [ErrorControlador::class, 'index']);

    $r->addRoute('GET', '/clientes', [ClientesControlador::class, 'index']);
    $r->addRoute('GET', '/clientes/{cedula}', [ClientesControlador::class, 'showCliente']);

    $r->addGroup('/api', function (RouteCollector $r) {
        $r->addGroup('/clientes', function (RouteCollector $r) {
            $r->addRoute('GET', '', [ClientesControlador::class, 'getClientes']);
            $r->addRoute('GET', '/{cedula}', [ClientesControlador::class, 'findCliente']);
            $r->addRoute('POST', '', [ClientesControlador::class, 'insertCliente']);
            $r->addRoute('PUT', '/{cedula}', [ClientesControlador::class, 'updateCliente']);
            $r->addRoute('DELETE', '/{cedula}', [ClientesControlador::class, 'deleteCliente']);

            $r->addGroup('/{cedula}/seguimiento-fisico', function (RouteCollector $r) {
                $r->addRoute('POST', '', [SeguimientoFisicoControlador::class, 'insert']);
                $r->addRoute('GET', '', [SeguimientoFisicoControlador::class, 'getByCliente']);
                $r->addRoute('PUT', '/{seguimientoId}', [SeguimientoFisicoControlador::class, 'update']);
                $r->addRoute('DELETE', '/{seguimientoId}', [SeguimientoFisicoControlador::class, 'delete']);
            });
        });
    });
};
