<? $this->layout('layouts/base', ['titulo' => $titulo ?? null]) ?>

<? $this->push('head') ?>
    <link rel="stylesheet" href="/assets/layouts/default/styles.css">
<? $this->end() ?>

<div class="LayoutDefault">
    <?= $this->insert('componentes/sidebar') ?>

    <div class="LayoutDefault--content">
        <?= $this->section('content') ?>
    </div>
</div>
