<?php

use DI\ContainerBuilder;

// Constantes
const CONTAINER_FILE = 'config/container.php';
const RUTAS_FILE = 'config/rutas.php';

// Configurar rutas
$dispatcher = FastRoute\simpleDispatcher(require RUTAS_FILE);

// Obtener metodo y URI
$httpMethod = $_SERVER['REQUEST_METHOD'];
$uri = $_SERVER['REQUEST_URI'];
$uri = rawurldecode(parse_url($uri, PHP_URL_PATH));

// Configurar inyector de dependencias (PHP-DI)
$builder = new ContainerBuilder();
$builder->addDefinitions(CONTAINER_FILE)->useAttributes(true);
$container = $builder->build();

$rutaInfo = $dispatcher->dispatch($httpMethod, $uri);
switch ($rutaInfo[0]) {
    case FastRoute\Dispatcher::NOT_FOUND:
        // Si no se encuentra la ruta, redirigir a pagina de error.
        http_response_code(404);
        header('Location: /error?code=404');
        break;

    case FastRoute\Dispatcher::METHOD_NOT_ALLOWED:
        // Si el metodo no se permite, redirigir a pagina de error.
        http_response_code(405);
        header('Location: /error?code=405');
        break;

    case FastRoute\Dispatcher::FOUND:
        $handler = $rutaInfo[1];
        $vars = $rutaInfo[2];

        [$clase, $metodo] = $handler;

        if (class_exists($clase)) {
            // Obtener controlador e inyectar sus dependencias
            $controlador = $container->get($clase);

            // Ejecutar controlador junto a su metodo.
            $respuesta = $controlador->$metodo($vars);

            // Mostrar respuesta como string
            // Si es HTML, el navegador lo renderizara.
            echo $respuesta;
        } else {
            http_response_code(500);
            echo "Clase-controlador '$clase' no encontrado";
        }

        break;
}
