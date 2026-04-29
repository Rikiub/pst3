<?php

use League\Plates\Engine;

use function App\Core\createPDO;
use function DI\env;

return [
    // Configurar directorio donde cargar vistas/plantillas
    Engine::class => function () {
        return new Engine('app/Vistas');
    },
    // Configurar conexion PDO a la base de datos
    PDO::class => function () {
        return createPDO(
            env('DB_HOST', 'localhost'),
            env('DB_DATABASE', 'sofit_gym'),
            env('DB_USERNAME', 'root'),
            env('DB_PASSWORD', ''),
        );
    },
];
