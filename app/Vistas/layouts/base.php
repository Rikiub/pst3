<!DOCTYPE html>
<html lang="es">

<? $this->insert('componentes/head', ['titulo' => $titulo ?? null]) ?>

<body>
    <nav>
        <a>Inicio</a>
    </nav>

    <div>
        <?= $this->section('content') ?>
    </div>
<body/>
