<?php
session_start();
require_once __DIR__ . '/../models/AsistenciaModel.php';

class AsistenciaController
{
    private $model;
    private $pdo;

    public function __construct()
    {
        // Forzar zona horaria de PHP para que coincida con MySQL
        date_default_timezone_set('America/Caracas'); // Cambia a tu zona horaria
        $host = 'localhost';
        $dbname = 'sofit_gym';
        $user = 'root';
        $pass = '';
        try {
            $this->pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4", $user, $pass);
            $this->pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            // Sincronizar zona horaria de MySQL con PHP
            $offset = (new DateTime())->getOffset() / 3600;
            $this->pdo->exec("SET time_zone = '$offset:00'");
        } catch (PDOException $e) {
            die("Error de conexión: " . $e->getMessage());
        }
        $this->model = new AsistenciaModel($this->pdo);
    }

    public function index()
    {
        $entradasHoy = $this->model->obtenerEntradasHoy();
        $fechaSeleccionada = $_GET['fecha'] ?? date('Y-m-d');
        $ocupacion = $this->model->obtenerOcupacionPorFranjas($fechaSeleccionada);
        $detalleEntradas = $this->model->obtenerEntradasPorFecha($fechaSeleccionada);
        $mensaje = $_SESSION['mensaje'] ?? '';
        $tipoMensaje = $_SESSION['tipo_mensaje'] ?? '';
        unset($_SESSION['mensaje'], $_SESSION['tipo_mensaje']);

        require_once __DIR__ . '/../view/Asistenciavista.php';
    }

    public function buscarClientesAjax()
    {
        if (!isset($_GET['ajax']) || $_GET['ajax'] !== 'buscar_clientes') return;
        $termino = $_GET['termino'] ?? '';
        $resultados = $this->model->buscarClientes($termino);
        header('Content-Type: application/json');
        echo json_encode($resultados);
        exit;
    }

    public function registrarEntrada()
    {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            http_response_code(405);
            echo json_encode(['error' => 'Método no permitido']);
            return;
        }
        $cedula = $_POST['cedula'] ?? '';
        $hora = !empty($_POST['hora']) ? $_POST['hora'] : null;
        if (empty($cedula)) {
            echo json_encode(['success' => false, 'message' => 'Debe seleccionar un cliente.']);
            return;
        }
        $resultado = $this->model->registrarEntrada($cedula, $hora);
        echo json_encode($resultado);
    }

    public function buscarEntradasAjax()
    {
        if (!isset($_GET['ajax']) || $_GET['ajax'] !== 'buscar_entradas') return;
        $termino = $_GET['termino'] ?? '';
        $resultados = $this->model->buscarEntradas($termino);
        header('Content-Type: application/json');
        echo json_encode($resultados);
        exit;
    }

    public function editarEntrada()
    {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            http_response_code(405);
            echo json_encode(['error' => 'Método no permitido']);
            return;
        }
        $id = intval($_POST['id']);
        $nuevaHora = $_POST['hora'] ?? '';
        if (empty($nuevaHora)) {
            echo json_encode(['success' => false, 'message' => 'La hora es requerida']);
            return;
        }
        $ok = $this->model->actualizarEntrada($id, $nuevaHora);
        echo json_encode(['success' => $ok]);
    }

    public function eliminarEntrada()
    {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            http_response_code(405);
            echo json_encode(['error' => 'Método no permitido']);
            return;
        }
        $id = intval($_POST['id']);
        $ok = $this->model->eliminarEntrada($id);
        echo json_encode(['success' => $ok]);
    }
}

// Enrutamiento
$controller = new AsistenciaController();
$action = $_GET['action'] ?? 'index';

switch ($action) {
    case 'buscar_clientes_ajax': $controller->buscarClientesAjax(); break;
    case 'registrar': $controller->registrarEntrada(); break;
    case 'buscar_entradas_ajax': $controller->buscarEntradasAjax(); break;
    case 'editar': $controller->editarEntrada(); break;
    case 'eliminar': $controller->eliminarEntrada(); break;
    default: $controller->index(); break;
}
?>