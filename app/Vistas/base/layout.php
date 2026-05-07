<?php $this->layout('base', ['titulo' => $titulo ?? null]) ?>

<?php $this->push('head') ?>
    <link rel="stylesheet" href="/assets/base/layout/layout.css">

    <link rel="stylesheet" href="/assets/base/parciales/sidebar/sidebar.css">
<?php $this->end() ?>

<div class="layout-default">
    <?= $this->insert('parciales/sidebar') ?>

    <div class="layout-default-content">
        <?= $this->section('content') ?>
    </div>
</div>
