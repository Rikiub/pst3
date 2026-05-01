<? $this->layout('layouts/default', ['titulo' => 'Clientes']) ?>

<? $this->push('head') ?>
    <link rel="stylesheet" href="/assets/rutas/clientes/styles.css">
    <script type="module" src="/assets/rutas/clientes/script.js"></script>
<? $this->stop() ?>

<div class="Clientes">
    <h1>Clientes</h1>

    <div class="table" id="table"></div>
</div>
