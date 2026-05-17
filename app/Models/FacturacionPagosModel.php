<?php

namespace App\Models;

use Exception;

class FacturacionPagosModel extends BaseModel
{
    // Registrar pago
    public function registrarPago(
        string $cedulaCliente,
        float $monto,
        string $metodoPago,
        ?string $comprobanteUrl = null,
        ?int $planTipoId = null,
    ): array {
        $cliente = $this->obtenerCliente($cedulaCliente);
        if (!$cliente) {
            throw new Exception("Cliente no encontrado.");
        }

        $membresiaActual = null;
        if ($cliente['id_membresia'] > 0) {
            $membresiaActual = $this->obtenerMembresiaPorId($cliente['id_membresia']);
        }

        if ($membresiaActual && $membresiaActual['id_tipo']) {
            $tipoMembresiaId = $membresiaActual['id_tipo'];
        } elseif ($planTipoId !== null) {
            $tipoMembresiaId = $planTipoId;
        } else {
            throw new Exception("Debe especificar el tipo de membresía para el primer pago.");
        }

        $duracionDias = match ($tipoMembresiaId) {
            1 => 30,
            2 => 90,
            3 => 365,
            default => 30,
        };
        $fechaPago = date('Y-m-d');
        $nuevaFechaVencimiento = date('Y-m-d', strtotime("+{$duracionDias} days"));

        $this->pdo->beginTransaction();
        try {
            // Crear nueva membresía
            $stmt = $this->pdo->prepare("INSERT INTO membresia (id_tipo, id_estado, fecha_inicio, fecha_fin) VALUES (?, 1, ?, ?)");
            $stmt->execute([$tipoMembresiaId, $fechaPago, $nuevaFechaVencimiento]);
            $nuevaId = $this->pdo->lastInsertId();

            // Actualizar cliente
            $stmt = $this->pdo->prepare("UPDATE cliente SET id_membresia = ? WHERE cedula_cliente = ?");
            $stmt->execute([$nuevaId, $cedulaCliente]);

            // Marcar membresía anterior como vencida
            if ($membresiaActual && $membresiaActual['id_membresia']) {
                $stmt = $this->pdo->prepare("UPDATE membresia SET id_estado = 2 WHERE id_membresia = ?");
                $stmt->execute([$membresiaActual['id_membresia']]);
            }

            // Registrar pago
            $stmt = $this->pdo->prepare("INSERT INTO pago (cedula_cliente, monto, metodo_pago, comprobante_url, estado, fecha_pago, fecha_vencimiento) VALUES (?, ?, ?, ?, 'Pagado', ?, ?)");
            $stmt->execute([$cedulaCliente, $monto, $metodoPago, $comprobanteUrl, $fechaPago, $nuevaFechaVencimiento]);
            $idPago = $this->pdo->lastInsertId();

            $this->pdo->commit();
            return [
                'exito' => true,
                'nueva_fecha_vencimiento' => $nuevaFechaVencimiento,
                'id_pago' => $idPago,
                'mensaje' => "Pago registrado. Vigencia hasta {$nuevaFechaVencimiento}"
            ];
        } catch (Exception $e) {
            $this->pdo->rollBack();
            throw new Exception("Error al registrar pago: " . $e->getMessage());
        }
    }

    // Obtener todos los pagos con estado del cliente
    public function obtenerTodosPagos(): array
    {
        $sql = "SELECT 
                    p.id_pago, 
                    p.cedula_cliente, 
                    CONCAT(per.nombre, ' ', per.apellido) AS nombre_cliente,
                    p.monto, 
                    p.metodo_pago, 
                    p.estado AS estado_pago,
                    p.fecha_pago, 
                    p.fecha_vencimiento,
                    m.fecha_fin AS membresia_fecha_fin,
                    COALESCE(DATEDIFF(m.fecha_fin, CURDATE()), 0) AS dias_restantes,
                    CASE
                        WHEN p.estado = 'Atrasado' AND p.fecha_vencimiento < CURDATE() THEN 'Vencido'
                        WHEN p.estado = 'Atrasado' AND p.fecha_vencimiento >= CURDATE() THEN 'Moroso'
                        WHEN m.fecha_fin < CURDATE() THEN 'Vencido'
                        WHEN DATEDIFF(m.fecha_fin, CURDATE()) <= 7 THEN 'Próximo a vencer'
                        ELSE 'Activo'
                    END AS estado_cliente
                FROM pago p
                JOIN (
                    SELECT cedula_cliente, MAX(id_pago) AS ultimo_id
                    FROM pago
                    GROUP BY cedula_cliente
                ) ult ON p.id_pago = ult.ultimo_id
                JOIN cliente c ON p.cedula_cliente = c.cedula_cliente
                JOIN persona per ON c.cedula_cliente = per.cedula_persona
                LEFT JOIN membresia m ON c.id_membresia = m.id_membresia
                ORDER BY p.fecha_pago DESC
                LIMIT 50";
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll();
    }

    // Búsqueda AJAX de pagos
    public function buscarPagos(string $termino): array
    {
        $termino = "%{$termino}%";
        $sql = "SELECT 
                    p.id_pago, 
                    p.cedula_cliente, 
                    CONCAT(per.nombre, ' ', per.apellido) AS nombre_cliente,
                    p.monto, 
                    p.metodo_pago, 
                    p.estado AS estado_pago,
                    p.fecha_pago, 
                    p.fecha_vencimiento,
                    m.fecha_fin AS membresia_fecha_fin,
                    COALESCE(DATEDIFF(m.fecha_fin, CURDATE()), 0) AS dias_restantes,
                    CASE
                        WHEN p.estado = 'Atrasado' AND p.fecha_vencimiento < CURDATE() THEN 'Vencido'
                        WHEN p.estado = 'Atrasado' AND p.fecha_vencimiento >= CURDATE() THEN 'Moroso'
                        WHEN m.fecha_fin < CURDATE() THEN 'Vencido'
                        WHEN DATEDIFF(m.fecha_fin, CURDATE()) <= 7 THEN 'Próximo a vencer'
                        ELSE 'Activo'
                    END AS estado_cliente
                FROM pago p
                JOIN (
                    SELECT cedula_cliente, MAX(id_pago) AS ultimo_id
                    FROM pago
                    GROUP BY cedula_cliente
                ) ult ON p.id_pago = ult.ultimo_id
                JOIN cliente c ON p.cedula_cliente = c.cedula_cliente
                JOIN persona per ON c.cedula_cliente = per.cedula_persona
                LEFT JOIN membresia m ON c.id_membresia = m.id_membresia
                WHERE p.id_pago LIKE ? 
                   OR p.cedula_cliente LIKE ? 
                   OR per.nombre LIKE ? 
                   OR per.apellido LIKE ?
                ORDER BY p.fecha_pago DESC
                LIMIT 50";
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute([$termino, $termino, $termino, $termino]);
        return $stmt->fetchAll();
    }

    // Actualizar pago
    public function actualizarPago(
        int $idPago,
        float $monto,
        string $metodoPago,
        string $estado,
        string $fechaPago,
        string $fechaVencimiento,
    ): bool {
        $sql = "UPDATE pago SET monto = ?, metodo_pago = ?, estado = ?, fecha_pago = ?, fecha_vencimiento = ? WHERE id_pago = ?";
        $stmt = $this->pdo->prepare($sql);
        return $stmt->execute([$monto, $metodoPago, $estado, $fechaPago, $fechaVencimiento, $idPago]);
    }

    // Eliminar pago
    public function eliminarPago(int $idPago): bool
    {
        $stmt = $this->pdo->prepare("DELETE FROM pago WHERE id_pago = ?");
        return $stmt->execute([$idPago]);
    }

    // Obtener clientes (solo primer nombre) para el modal
    public function obtenerClientesSimples(): array
    {
        $sql = "SELECT cedula_cliente, p.nombre AS nombre, p.correo, p.telefono 
                FROM cliente c 
                JOIN persona p ON c.cedula_cliente = p.cedula_persona 
                ORDER BY p.nombre";
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll();
    }

    // Métodos auxiliares privados
    private function obtenerCliente(string $cedula): ?array
    {
        $stmt = $this->pdo->prepare("SELECT cedula_cliente, id_membresia FROM cliente WHERE cedula_cliente = ?");
        $stmt->execute([$cedula]);
        return $stmt->fetch() ?: null;
    }

    private function obtenerMembresiaPorId(int $id): ?array
    {
        $stmt = $this->pdo->prepare("SELECT id_membresia, id_tipo, fecha_fin, id_estado FROM membresia WHERE id_membresia = ?");
        $stmt->execute([$id]);
        return $stmt->fetch() ?: null;
    }
}
