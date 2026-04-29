<? $this->layout('layouts/base', ['titulo' => $titulo ?? null]) ?>

<div>
    <? $this->insert('componentes/sidebar') ?>

    <div>
        <?= $this->section('content') ?>
    </div>
</div>