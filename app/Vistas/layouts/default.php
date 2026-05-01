<? $this->layout('layouts/base', ['titulo' => $titulo ?? null]) ?>

<? $this->push('head') ?>
    <link rel="stylesheet" href="/assets/layouts/default/styles.css">

    <link rel="stylesheet" href="/assets/componentes/sidebar/styles.css">
    <script type="module" src="/assets/componentes/sidebar/script.js"></script>
<? $this->end() ?>

<div class="LayoutDefault">
    <?= $this->insert('componentes/sidebar') ?>

    <div class="LayoutDefault--content">
        <?= $this->section('content') ?>
    </div>
</div>
