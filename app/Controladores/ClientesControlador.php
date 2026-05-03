<?php

namespace App\Controladores;

use App\Core\BaseControlador;
use App\Modelos\Cliente;
use App\Modelos\ClientesModelo;
use DateTimeImmutable;
use Exception;
use Throwable;

class ClientesControlador extends BaseControlador
{
    public function __construct(
        private ClientesModelo $modelo
    ) {}

    public function index(): string
    {
        return $this->render('rutas/clientes/index', [
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
        $res = $this->modelo->getByCedula($vars['cedula']);

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
            // Valida el POST
            $cedula = $_POST['cedula'];
            $cliente = $this->mapper->map(Cliente::class, $_POST);
            $cliente->validarInsert();

            // Asignar fecha actual
            $cliente->fecha_registro = new DateTimeImmutable();

            // Verificar que el cliente no exista
            $check = $this->modelo->getByCedula($cedula);
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
    public function put(): string
    {
        try {
            $cedula = $_POST['cedula'];
            $cliente = $this->mapper->map(Cliente::class, $_POST);

            $check = $this->modelo->getByCedula($cedula);
            if (!$check) {
                http_response_code(400);
                return json_encode(['error' => 'El cliente no existe']);
            }

            $this->modelo->updateCliente($cliente);

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

        $check = $this->modelo->getByCedula($cedula);
        if (!$check) {
            http_response_code(404);
            return json_encode(['error' => 'El cliente no existe']);
        }

        $this->modelo->deleteByCedula($cedula);
        http_response_code(204);

        return null;
    }
}
