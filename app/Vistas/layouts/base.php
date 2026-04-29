<!DOCTYPE html>
<html lang="es">

<? $this->insert('componentes/head', ['titulo' => $titulo ?? null]) ?>

<body>
    <div class="app">
        <? $this->insert('componentes/sidebar') ?>
        
        <div>
            <?= $this->section('content') ?>
        </div>
    </div>
<body/>
