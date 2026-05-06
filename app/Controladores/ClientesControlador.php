<?php

namespace App\Controladores;

use App\Core\BaseControlador;
use App\Modelos\Cliente;
use App\Modelos\ClientesModelo;
use DateTimeImmutable;
use Throwable;

class ClientesControlador extends BaseControlador
{
    public function __construct(
        private ClientesModelo $modelo
    ) {}

    public function index(): string
    {
        return $this->render('rutas/clientes', [
            'items' => []
        ]);
    }

    public function get(): string
    {
        $res = $this->modelo->getAll();
        return $this->objectToJson($res);
    }

    public function getFind(array $vars): ?string
    {
        $res = $this->modelo->findByCedula($vars['cedula']);

        if (!$res) {
            http_response_code(404);
            return null;
        }

        return $this->objectToJson($res);
    }

    /**
     * Crear
     */
    public function post(): string
    {
        try {
            $body = $this->getRequestData();
            $body['fecha_registro'] = new DateTimeImmutable();  // Asignar fecha actual

            // Valida el POST
            $cliente = $this->mapper->map(Cliente::class, $_POST);

            // Verificar que el cliente no exista
            $check = $this->modelo->findByCedula($cliente->cedula);
            if ($check) {
                http_response_code(400);
                return json_encode(['error' => 'El cliente ya existe']);
            }

            // Crea el cliente
            $cliente = $this->modelo->insertCliente($cliente);

            // Enviar JSON
            http_response_code(201);
            return $this->objectToJson($cliente);
        } catch (Throwable $e) {
            http_response_code(400);
            return json_encode(['error' => $e->getMessage()]);
        }
    }

    /**
     * Modificar
     */
    public function put(array $vars): string
    {
        try {
            $cedula = $vars['cedula'];

            $body = $this->getRequestData();
            $cliente = $this->mapper->map(Cliente::class, $body);

            $check = $this->modelo->findByCedula($cedula);
            if (!$check) {
                http_response_code(400);
                return json_encode(['error' => 'El cliente no existe']);
            }

            $cliente = $this->modelo->updateCliente($cliente);

            http_response_code(201);
            return $this->objectToJson($cliente);
        } catch (Throwable $e) {
            http_response_code(400);
            return json_encode(['error' => $e->getMessage()]);
        }
    }

    /**
     * Eliminar
     */
    public function delete(array $vars): string|null
    {
        $cedula = $vars['cedula'];

        $check = $this->modelo->findByCedula($cedula);
        if (!$check) {
            http_response_code(404);
            return json_encode(['error' => 'El cliente no existe']);
        }

        $this->modelo->deleteByCedula($cedula);
        http_response_code(204);

        return null;
    }
}
