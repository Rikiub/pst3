<?php

namespace App\Core;

use CuyZ\Valinor\Mapper\TreeMapper;
use CuyZ\Valinor\Normalizer\Normalizer;
use DI\Attribute\Inject;
use League\Plates\Engine;
use Exception;

abstract class BaseControlador
{
    #[Inject]
    protected Engine $templates;

    #[Inject]
    protected TreeMapper $mapper;

    #[Inject]
    private Normalizer $normalizer;

    public function objectToJson(mixed $object): string
    {
        return $this->normalizer->normalize($object);
    }

    function getRequestData(): array
    {
        $contentType = $_SERVER['CONTENT_TYPE'] ?? '';

        // Si el contenido es JSON, entonces decodificarlo.
        if (stripos($contentType, 'application/json') !== false) {
            $rawInput = file_get_contents('php://input');
            $data = json_decode($rawInput, true);

            if (json_last_error() === JSON_ERROR_NONE && is_array($data)) {
                return $data;
            }

            throw new Exception('Invalid JSON');
        }

        // Si el contenido es form POST, entonces devolver directamente
        return $_POST;
    }

    public function render(string $vista, array $datos = []): string
    {
        return $this->templates->render($vista, $datos);
    }
}
