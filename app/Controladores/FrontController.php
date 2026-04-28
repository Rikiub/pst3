<?php

namespace App\Controladores;

use App\Controladores\ErrorControlador;

class FrontController
{
    public function __construct(
        public string $namespace = 'App\\Controladores\\',
        public string $suffixClase = 'Controlador',
        public string $defaultControlador = 'inicio',
        public string $defaultMetodo = 'vista'
    ) {
        $this->namespace = $namespace;
        $this->suffixClase = $suffixClase;
        $this->defaultControlador = $defaultControlador;
        $this->defaultMetodo = $defaultMetodo;
    }

    public function iniciar(): void
    {
        $path = $_SERVER['REQUEST_URI'] ?? '/';
        $segmentos = !empty($path) ? explode('/', trim($path, '/')) : [];

        $nombreControlador = !empty($segmentos[0]) ? $segmentos[0] : $this->defaultControlador;
        $nombreMetodo = !empty($segmentos[1]) ? $segmentos[1] : $this->defaultMetodo;

        // Verificar que la clase exista
        $rutaControlador = $this->namespace . ucfirst($nombreControlador) . $this->suffixClase;

        if (!class_exists($rutaControlador)) {
            $this->noEncontrado('Pagina no encontrada');
            return;
        }

        $controlador = new $rutaControlador;

        // Verificar que el metodo de la clase exista
        if (!method_exists($controlador, $nombreMetodo)) {
            $this->noEncontrado($nombreControlador . ': ' . ' Accion no encontrada');
            return;
        }

        call_user_func([$controlador, $nombreMetodo]);
    }

    public function noEncontrado(string $razon): void
    {
        new ErrorControlador()->vista($razon);
    }
}
