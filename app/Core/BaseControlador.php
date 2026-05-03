<?php

namespace App\Core;

use CuyZ\Valinor\Mapper\TreeMapper;
use CuyZ\Valinor\Normalizer\Normalizer;
use DI\Attribute\Inject;
use League\Plates\Engine;

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

    public function render(string $vista, array $datos = []): string
    {
        return $this->templates->render($vista, $datos);
    }
}
