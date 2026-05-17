// facturacion.js - Toda la lógica JavaScript

document.addEventListener('DOMContentLoaded', function() {
    // ==================== AUTO-CERRAR ALERTAS ====================
    function autoCloseAlerts() {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => {
            setTimeout(() => {
                alert.classList.add('fade-out');
                setTimeout(() => alert.remove(), 500);
            }, 4000);
        });
    }
    autoCloseAlerts();

    // ==================== PESTAÑAS ====================
    const tabs = document.querySelectorAll('.tab-btn');
    const contents = document.querySelectorAll('.tab-content');
    function activateTab(tabId) {
        tabs.forEach(btn => btn.classList.remove('active'));
        contents.forEach(c => c.classList.remove('active'));
        document.getElementById(tabId).classList.add('active');
        document.querySelector(`.tab-btn[data-tab="${tabId}"]`).classList.add('active');
        const url = new URL(window.location.href);
        url.searchParams.set('tab', tabId);
        window.history.pushState({}, '', url);
    }
    tabs.forEach(btn => {
        btn.addEventListener('click', () => {
            const target = btn.getAttribute('data-tab');
            activateTab(target);
        });
    });
    const urlParams = new URLSearchParams(window.location.search);
    const urlTab = urlParams.get('tab');
    if (urlTab && document.getElementById(urlTab)) activateTab(urlTab);
    else activateTab('tab-pagos');

    // ==================== BUSCADOR AJAX ====================
    const searchInput = document.getElementById('searchPagos');
    const tablaBody = document.getElementById('tablaPagosBody');
    let timeoutId = null;

    function escapeHtml(str) {
        if (!str) return '';
        return str.replace(/[&<>]/g, function(m) {
            if (m === '&') return '&amp;';
            if (m === '<') return '&lt;';
            if (m === '>') return '&gt;';
            return m;
        });
    }

    function primerNombreJS(nombreCompleto) {
        if (!nombreCompleto) return '';
        return nombreCompleto.split(' ')[0];
    }

    function buscarPagos() {
        const termino = searchInput.value.trim();
        fetch(`?page=facturacion&action=buscar_ajax&ajax=buscar_pagos&termino=${encodeURIComponent(termino)}`)
            .then(response => response.json())
            .then(data => {
                if (data.length === 0) {
                    tablaBody.innerHTML = '<tr><td colspan="9" class="text-center">No se encontraron pagos.</td></tr>';
                    return;
                }
                let html = '';
                data.forEach(p => {
                    let estadoPagoBadge = '';
                    if (p.estado_pago === 'Pagado') estadoPagoBadge = '<span class="badge-pagado">Pagado</span>';
                    else if (p.estado_pago === 'Atrasado') estadoPagoBadge = '<span class="badge-atrasado">Atrasado</span>';
                    else estadoPagoBadge = '<span class="badge-pendiente">Pendiente</span>';

                    let estadoClienteClass = '';
                    if (p.estado_cliente === 'Activo') estadoClienteClass = 'estado-activo';
                    else if (p.estado_cliente === 'Próximo a vencer') estadoClienteClass = 'estado-proximo';
                    else estadoClienteClass = 'estado-vencido';

                    let diasRestantesHtml = '';
                    const dias = parseInt(p.dias_restantes);
                    if (dias < 0) diasRestantesHtml = `Vencido hace ${Math.abs(dias)} días`;
                    else if (dias === 0) diasRestantesHtml = '<span class="aviso-vencimiento">⚠️ ¡Vence hoy!</span>';
                    else if (dias <= 5) diasRestantesHtml = `<span class="aviso-vencimiento">⚠️ ¡Te quedan ${dias} días!</span>`;
                    else diasRestantesHtml = `Faltan ${dias} días`;

                    const nombreCorto = primerNombreJS(p.nombre_cliente);

                    html += `
                        <tr data-id="${p.id_pago}">
                            <td>${p.id_pago}</td>
                            <td>${escapeHtml(p.cedula_cliente)}</td>
                            <td>${escapeHtml(nombreCorto)}</td>
                            <td>$${parseFloat(p.monto).toFixed(2)}</td>
                            <td>${escapeHtml(p.metodo_pago)}</td>
                            <td>${estadoPagoBadge}</td>
                            <td><span class="${estadoClienteClass}">${escapeHtml(p.estado_cliente)}</span></td>
                            <td>${diasRestantesHtml}</td>
                            <td>
                                <div class="acciones-botones">
                                    <button class="btn btn-sm btn-warning editar-btn" data-bs-toggle="modal" data-bs-target="#editarModal" 
                                        data-id="${p.id_pago}"
                                        data-cliente="${escapeHtml(p.cedula_cliente)}"
                                        data-nombre="${escapeHtml(p.nombre_cliente)}"
                                        data-monto="${p.monto}"
                                        data-metodo="${escapeHtml(p.metodo_pago)}"
                                        data-estado="${escapeHtml(p.estado_pago)}"
                                        data-fecha_pago="${p.fecha_pago}"
                                        data-fecha_vencimiento="${p.fecha_vencimiento}">
                                        <i class="fas fa-edit"></i> Editar
                                    </button>
                                    <button class="btn btn-sm btn-danger eliminar-btn" data-bs-toggle="modal" data-bs-target="#eliminarModal" 
                                        data-id="${p.id_pago}">
                                        <i class="fas fa-trash-alt"></i> Eliminar
                                    </button>
                                    <button class="btn btn-sm btn-info ver-btn" data-bs-toggle="modal" data-bs-target="#verModal" 
                                        data-id="${p.id_pago}"
                                        data-cliente="${escapeHtml(p.cedula_cliente)}"
                                        data-nombre="${escapeHtml(primerNombreJS(p.nombre_cliente))}"
                                        data-monto="${p.monto}"
                                        data-metodo="${escapeHtml(p.metodo_pago)}"
                                        data-estado="${escapeHtml(p.estado_pago)}"
                                        data-fecha_pago="${p.fecha_pago}"
                                        data-fecha_vencimiento="${p.fecha_vencimiento}"
                                        data-comprobante="${escapeHtml(p.comprobante_url) || 'No disponible'}">
                                        <i class="fas fa-eye"></i> Ver
                                    </button>
                                </div>
                            </td>
                        </tr>
                    `;
                });
                tablaBody.innerHTML = html;
                // Reasignar eventos a los botones dinámicos
                document.querySelectorAll('.editar-btn').forEach(btn => {
                    btn.addEventListener('click', function(e) {
                        document.getElementById('edit_id').value = this.dataset.id;
                        document.getElementById('edit_cliente').value = this.dataset.cliente;
                        document.getElementById('edit_nombre').value = this.dataset.nombre;
                        document.getElementById('edit_monto').value = this.dataset.monto;
                        document.getElementById('edit_metodo').value = this.dataset.metodo;
                        document.getElementById('edit_estado').value = this.dataset.estado;
                        document.getElementById('edit_fecha_pago').value = this.dataset.fecha_pago;
                        document.getElementById('edit_fecha_vencimiento').value = this.dataset.fecha_vencimiento;
                    });
                });
                document.querySelectorAll('.eliminar-btn').forEach(btn => {
                    btn.addEventListener('click', function(e) {
                        document.getElementById('delete_id').value = this.dataset.id;
                        document.getElementById('confirmDeleteBtn').href = `?page=facturacion&action=eliminar&eliminar_pago=${this.dataset.id}&tab=tab-lista`;
                    });
                });
                document.querySelectorAll('.ver-btn').forEach(btn => {
                    btn.addEventListener('click', function(e) {
                        document.getElementById('ver_id').innerText = this.dataset.id;
                        document.getElementById('ver_cedula').innerText = this.dataset.cliente;
                        document.getElementById('ver_nombre').innerText = this.dataset.nombre;
                        document.getElementById('ver_monto').innerText = `$ ${parseFloat(this.dataset.monto).toFixed(2)}`;
                        document.getElementById('ver_metodo').innerText = this.dataset.metodo;
                        document.getElementById('ver_estado').innerText = this.dataset.estado;
                        document.getElementById('ver_fecha_pago').innerText = this.dataset.fecha_pago;
                        document.getElementById('ver_fecha_vencimiento').innerText = this.dataset.fecha_vencimiento;
                        document.getElementById('ver_comprobante').innerText = this.dataset.comprobante;
                    });
                });
            })
            .catch(error => console.error('Error en búsqueda:', error));
    }

    if (searchInput) {
        searchInput.addEventListener('keyup', function() {
            if (timeoutId) clearTimeout(timeoutId);
            timeoutId = setTimeout(buscarPagos, 400);
        });
    }
    document.getElementById('btnBuscar')?.addEventListener('click', buscarPagos);

    // ==================== MODAL CLIENTE ====================
    const searchClient = document.getElementById('searchClient');
    const clienteModal = document.getElementById('clienteModal');
    function filterClientTable() {
        const filter = searchClient.value.toLowerCase();
        document.querySelectorAll('#clientesTabla tbody tr').forEach(row => {
            const text = row.innerText.toLowerCase();
            row.style.display = text.includes(filter) ? '' : 'none';
        });
    }
    if (searchClient) searchClient.addEventListener('keyup', filterClientTable);
    document.getElementById('clientesTabla')?.addEventListener('click', (e) => {
        const btn = e.target.closest('.btn-select-client');
        if (!btn) return;
        const row = btn.closest('tr');
        const id = row.getAttribute('data-id');
        const nombre = row.getAttribute('data-nombre');
        if (id && nombre) {
            document.getElementById('selected_cliente_id').value = id;
            document.getElementById('cliente_selected_text').innerText = nombre;
            document.getElementById('cliente_cedula').value = id;
            bootstrap.Modal.getInstance(clienteModal).hide();
        }
    });

    // ==================== MÉTODO DE PAGO ====================
    document.querySelectorAll('.method-item').forEach(item => {
        item.addEventListener('click', () => {
            const metodo = item.getAttribute('data-metodo');
            document.getElementById('selected_metodo').value = metodo;
            document.getElementById('metodo_selected_text').innerText = metodo;
            bootstrap.Modal.getInstance(document.getElementById('metodoModal')).hide();
        });
    });

    // ==================== PLAN ====================
    document.querySelectorAll('.plan-item').forEach(item => {
        item.addEventListener('click', () => {
            const plan = item.getAttribute('data-plan');
            const text = item.getAttribute('data-text');
            document.getElementById('selected_plan').value = plan;
            document.getElementById('plan_selected_text').innerText = text;
            bootstrap.Modal.getInstance(document.getElementById('planModal')).hide();
        });
    });

    // ==================== FORMULARIO REGISTRO ====================
    const formRegistro = document.getElementById('formRegistroPago');
    if (formRegistro) {
        formRegistro.addEventListener('submit', (e) => {
            const montoInput = document.getElementById('monto_input');
            if (!document.getElementById('selected_cliente_id').value) {
                alert('Debe seleccionar un cliente.');
                e.preventDefault();
                return;
            }
            if (!montoInput.value || parseFloat(montoInput.value) <= 0) {
                alert('Monto inválido.');
                e.preventDefault();
                return;
            }
            const hiddenMonto = document.createElement('input');
            hiddenMonto.type = 'hidden';
            hiddenMonto.name = 'monto';
            hiddenMonto.value = montoInput.value;
            formRegistro.appendChild(hiddenMonto);
            montoInput.disabled = true;
        });
    }

    // ==================== EDITAR (estáticos) ====================
    document.querySelectorAll('.editar-btn').forEach(btn => {
        btn.addEventListener('click', function(e) {
            document.getElementById('edit_id').value = this.dataset.id;
            document.getElementById('edit_cliente').value = this.dataset.cliente;
            document.getElementById('edit_nombre').value = this.dataset.nombre;
            document.getElementById('edit_monto').value = this.dataset.monto;
            document.getElementById('edit_metodo').value = this.dataset.metodo;
            document.getElementById('edit_estado').value = this.dataset.estado;
            document.getElementById('edit_fecha_pago').value = this.dataset.fecha_pago;
            document.getElementById('edit_fecha_vencimiento').value = this.dataset.fecha_vencimiento;
        });
    });

    // ==================== ELIMINAR (estáticos) ====================
    document.querySelectorAll('.eliminar-btn').forEach(btn => {
        btn.addEventListener('click', function(e) {
            document.getElementById('delete_id').value = this.dataset.id;
            document.getElementById('confirmDeleteBtn').href = `?page=facturacion&action=eliminar&eliminar_pago=${this.dataset.id}&tab=tab-lista`;
        });
    });

    // ==================== VER (estáticos) ====================
    document.querySelectorAll('.ver-btn').forEach(btn => {
        btn.addEventListener('click', function(e) {
            document.getElementById('ver_id').innerText = this.dataset.id;
            document.getElementById('ver_cedula').innerText = this.dataset.cliente;
            document.getElementById('ver_nombre').innerText = this.dataset.nombre;
            document.getElementById('ver_monto').innerText = `$ ${parseFloat(this.dataset.monto).toFixed(2)}`;
            document.getElementById('ver_metodo').innerText = this.dataset.metodo;
            document.getElementById('ver_estado').innerText = this.dataset.estado;
            document.getElementById('ver_fecha_pago').innerText = this.dataset.fecha_pago;
            document.getElementById('ver_fecha_vencimiento').innerText = this.dataset.fecha_vencimiento;
            document.getElementById('ver_comprobante').innerText = this.dataset.comprobante;
        });
    });
});