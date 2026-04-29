<div class="Sidebar">
    <aside class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <div class="logo-container">
                <i class="fas fa-dumbbell logo-icon"></i>
                <h2>Sofit<span>GYM</span></h2>
            </div>
            <button class="sidebar-toggle" id="sidebarToggle">
                <i class="fa-chevron-left fas"></i>
            </button>
        </div>

        <nav class="sidebar-nav">
            <!-- Inicio -->
            <a href="/" class="active"><i class="fas fa-home"></i> <span>Inicio</span></a>

            <!-- 1. Gestionar Clientes e Inscripciones -->
            <div class="nav-group">
                <div class="group-title" data-group="mod1">
                    <i class="fas fa-id-card"></i> <span>Gestionar Clientes e Inscripciones</span>
                    <i class="fas fa-chevron-down toggle-icon"></i>
                </div>
                <div class="group-items" id="mod1">
                    <a href="clientes_registrar.php"><i class="fas fa-user-plus"></i> <span>Registro único digital de clientes</span></a>
                    <a href="clientes_estado.php"><i class="fas fa-tag"></i> <span>Estado de inscripción (Activo/Vencido/Moroso)</span></a>
                    <a href="clientes_historial_pagos.php"><i class="fas fa-history"></i> <span>Historial de pagos</span></a>
                    <a href="clientes_medidas.php"><i class="fas fa-chart-line"></i> <span>Medidas biométricas y nutrición</span></a>
                </div>
            </div>

            <!-- 2. Gestionar Trabajadores y Clases -->
            <div class="nav-group">
                <div class="group-title" data-group="mod2">
                    <i class="fas fa-chalkboard-user"></i> <span>Gestionar Trabajadores y Clases</span>
                    <i class="fas fa-chevron-down toggle-icon"></i>
                </div>
                <div class="group-items" id="mod2">
                    <a href="trabajadores_registrar.php"><i class="fas fa-user-tie"></i> <span>Registro de trabajadores</span></a>
                    <a href="horarios_clases.php"><i class="fas fa-calendar-week"></i> <span>Horarios, clases grupales y cupos</span></a>
                    <a href="asignar_cliente_clase.php"><i class="fas fa-user-check"></i> <span>Asignación de clientes a clases</span></a>
                </div>
            </div>

            <!-- 3. Gestionar Facturación y Control de Pagos -->
            <div class="nav-group">
                <div class="group-title" data-group="mod3">
                    <i class="fas fa-coins"></i> <span> Gestionar Facturación y Control de Pagos</span>
                    <i class="fas fa-chevron-down toggle-icon"></i>
                </div>
                <div class="group-items" id="mod3">
                    <a href="facturacion_automatica.php"><i class="fas fa-calculator"></i> <span>Automatización de vencimiento y recibos</span></a>
                    <a href="facturacion_panel.php"><i class="fas fa-chart-pie"></i> <span>Panel de ingresos y morosidad</span></a>
                    <a href="facturacion_notificaciones.php"><i class="fas fa-bell"></i> <span>Notificaciones (WhatsApp/Email)</span></a>
                </div>
            </div>

            <!-- 4. Controlar Asistencia -->
            <div class="nav-group">
                <div class="group-title" data-group="mod4">
                    <i class="fas fa-fingerprint"></i> <span>Controlar Asistencia</span>
                    <i class="fas fa-chevron-down toggle-icon"></i>
                </div>
                <div class="group-items" id="mod4">
                    <a href="asistencia_registrar.php"><i class="fas fa-edit"></i> <span>Registro entrada/salida por identificación</span></a>
                    <a href="asistencia_metricas.php"><i class="fas fa-chart-line"></i> <span>Métricas de ocupación por horario/día</span></a>
                </div>
            </div>

            <!-- 5. Gestionar Equipos y Maquinaria -->
            <div class="nav-group">
                <div class="group-title" data-group="mod5">
                    <i class="fas fa-microchip"></i> <span>Gestionar Equipos y Maquinaria</span>
                    <i class="fas fa-chevron-down toggle-icon"></i>
                </div>
                <div class="group-items" id="mod5">
                    <a href="equipos_mantenimiento.php"><i class="fas fa-tools"></i> <span>Registro de mantenimiento (preventivo/correctivo)</span></a>
                    <a href="equipos_historial.php"><i class="fas fa-history"></i> <span>Historial de mantenimiento</span></a>
                </div>
            </div>

            <!-- 6. Gestionar Productos -->
            <div class="nav-group">
                <div class="group-title" data-group="mod6">
                    <i class="fas fa-boxes"></i> <span>Gestionar Productos</span>
                    <i class="fas fa-chevron-down toggle-icon"></i>
                </div>
                <div class="group-items" id="mod6">
                    <a href="productos_stock.php"><i class="fas fa-boxes"></i> <span>Control de stock y demanda actual</span></a>
                </div>
            </div>

            <!-- 7. Gestionar Rutinas de Entrenamiento -->
            <div class="nav-group">
                <div class="group-title" data-group="mod7">
                    <i class="fas fa-dumbbell"></i> <span>Gestionar Rutinas de Entrenamiento</span>
                    <i class="fas fa-chevron-down toggle-icon"></i>
                </div>
                <div class="group-items" id="mod7">
                    <a href="rutinas_disenar.php"><i class="fas fa-pen-ruler"></i> <span>Diseñar planes de entrenamiento</span></a>
                    <a href="rutinas_asignar.php"><i class="fas fa-user-check"></i> <span>Asignar rutinas a clientes</span></a>
                </div>
            </div>

            <!-- 8. Consultar Asistente de Entrenamiento -->
            <div class="nav-group">
                <div class="group-title" data-group="mod8">
                    <i class="fas fa-robot"></i> <span>Consultar Asistente de Entrenamiento</span>
                    <i class="fas fa-chevron-down toggle-icon"></i>
                </div>
                <div class="group-items" id="mod8">
                    <a href="asistente_chat.php"><i class="fas fa-comments"></i> <span>Interfaz de chat con IA</span></a>
                    <a href="asistente_tendencias.php"><i class="fas fa-chart-line"></i> <span>Tendencias y sugerencias de rutinas/dietas</span></a>
                </div>
            </div>

            <!-- Separador visual -->
            <div class="sidebar-divider"></div>

            <!-- ========== MÓDULOS DE SEGURIDAD Y SOPORTE (como estaban antes) ========== -->
            <div class="nav-group">
                <div class="group-title" data-group="seguridad">
                    <i class="fas fa-shield-alt"></i> <span>Gestión de Auditoría y Seguridad</span>
                    <i class="fas fa-chevron-down toggle-icon"></i>
                </div>
                <div class="group-items" id="seguridad">
                    <a href="seguridad.php"><i class="fas fa-lock"></i> <span>Seguridad (Login/MD5/Captcha)</span></a>
                    <a href="roles_permisos.php"><i class="fas fa-users-cog"></i> <span>Roles y Permisos</span></a>
                    <a href="bitacora.php"><i class="fas fa-history"></i> <span>Bitácora del Sistema</span></a>
                </div>
            </div>

            <div class="nav-group">
                <div class="group-title" data-group="soporte">
                    <i class="fas fa-database"></i> <span>Gestión de Soporte y Datos</span>
                    <i class="fas fa-chevron-down toggle-icon"></i>
                </div>
                <div class="group-items" id="soporte">
                    <a href="reportes.php"><i class="fas fa-chart-bar"></i> <span>Reportes Estadísticos</span></a>
                    <a href="mantenimiento_bd.php"><i class="fas fa-database"></i> <span>Mantenimiento de BD</span></a>
                    <a href="ayuda.php"><i class="fas fa-question-circle"></i> <span>Ayuda Interactiva</span></a>
                    <a href="componente_inteligente.php"><i class="fas fa-brain"></i> <span>Componente Inteligente (IO/PERT)</span></a>
                </div>
            </div>
        </nav>
    </aside>
</div>