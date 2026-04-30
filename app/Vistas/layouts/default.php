<? $this->layout('layouts/base', ['titulo' => $titulo ?? null]) ?>

<? $this->push('head') ?>
    <link rel="stylesheet" href="/assets/css/componentes/sidebar.css">
    <script defer src="/assets/js/componentes/sidebar.js"></script>
<? $this->end() ?>

<div>
    <?= $this->insert('componentes/sidebar') ?>

    <div>
        <?= $this->section('content') ?>
    </div>
</div>
