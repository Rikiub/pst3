<? $this->layout('layouts/default', ['titulo' => 'Clientes']) ?>

<? $this->push('head') ?>
    <link rel="stylesheet" href="/assets/rutas/clientes/styles.css">
    <script type="module" src="/assets/rutas/clientes/script.js"></script>
<? $this->stop() ?>

<? $this->insert('componentes/dialog', [
    'id' => 'dialog',
    'titulo' => 'Eliminar',
    'content' => 'rutas/clientes/modal_form',
]) ?>

<div class="Clientes">
    <h1>Clientes</h1>

    <button class="btn-insertar" onclick="openDialog('dialog')">Insertar</button>

    <div class="table" id="table"></div>
</div>
