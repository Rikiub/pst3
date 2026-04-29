<?

/**
 * HTML base que heredan todas las vistas. Debe mantenerse lo más simple posible.
 * Tambien es donde se insertan las dependencias web.
 */
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <? // Recursos locales ?>
    <link rel="icon" href="/assets/img/favicon.png">
    <link rel="stylesheet" href="/assets/css/index.css">

    <?= $this->section('head') ?>

    <title><?= $this->e($titulo ?? 'Sofit Gym') ?></title>
</head>

<body>
    <div class="app">
        <?= $this->section('content') ?>
    </div>
<body/>
