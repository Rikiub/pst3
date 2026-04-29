<?php

// Ubicacion de los controladores
const CONTROLADORES_DIR = 'App\Controladores';

// Configurar rutas
$dispatcher = FastRoute\simpleDispatcher(require 'app/rutas.php');

// Obtener metodo y URI
$httpMethod = $_SERVER['REQUEST_METHOD'];
$uri = $_SERVER['REQUEST_URI'];
$uri = rawurldecode(parse_url($uri, PHP_URL_PATH));

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
        $clase = CONTROLADORES_DIR . "\\$clase";

        if (class_exists($clase)) {
            $controlador = new $clase();

            // Pasar variables de la ruta como argumentos para el metodo
            $resultado = call_user_func_array([$controlador, $metodo], $vars);

            // Mostrar resultado como string
            // Si es HTML, el navegador lo renderizara.
            echo $resultado;
        } else {
            http_response_code(500);
            echo "Clase-controlador '$clase' no encontrado";
        }

        break;
}
