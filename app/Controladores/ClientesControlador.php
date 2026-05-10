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
        $tipos = $this->modelo->getEstadosMembresia();
        $estados = $this->modelo->getTiposMembresia();

        return $this->render('clientes/index', [
            'tipos' => $tipos,
            'estados' => $estados,
        ]);
    }

    public function getClientes(): string
    {
        $clientes = $this->modelo->getAll();
        return $this->jsonResponse($clientes);
    }

    public function findCliente(array $vars): ?string
    {
        $cliente = $this->modelo->findByCedula($vars['cedula']);

        if (!$cliente) {
            http_response_code(404);
            return null;
        }

        return $this->jsonResponse($cliente);
    }

    /**
     * Crear
     */
    public function insertCliente(): string
    {
        $body = $this->getParsedBody();
        $body['fecha_registro'] = new DateTimeImmutable();  // Asignar fecha actual

        // Valida el POST
        $cliente = $this->mapper->map(Cliente::class, $body);

        // Verificar que el cliente no exista
        $check = $this->modelo->findByCedula($cliente->cedula);
        if ($check) {
            return $this->jsonResponse(['message' => 'El cliente ya existe'], 400);
        }

        // Crea el cliente
        $cliente = $this->modelo->insertCliente($cliente);

        // Enviar JSON
        return $this->jsonResponse($cliente, 201);
    }

    /**
     * Modificar
     */
    public function updateCliente(array $vars): string
    {
        $cedula = $vars['cedula'];

        $body = $this->getParsedBody();
        $body['cedula'] = $cedula;

        $cliente = $this->mapper->map(Cliente::class, $body);

        $check = $this->modelo->findByCedula($cedula);
        if (!$check) {
            return $this->jsonResponse(['message' => 'El cliente no existe'], 400);
        }

        $cliente = $this->modelo->updateCliente($cliente);
        return $this->jsonResponse($cliente, 201);
    }

    /**
     * Eliminar
     */
    public function deleteCliente(array $vars): string|null
    {
        $cedula = $vars['cedula'];

        $check = $this->modelo->findByCedula($cedula);
        if (!$check) {
            return $this->jsonResponse(['message' => 'El cliente no existe'], 404);
        }

        $this->modelo->deleteByCedula($cedula);

        http_response_code(204);
        return null;
    }
}
