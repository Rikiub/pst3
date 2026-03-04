<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Recursos locales -->
    <link rel="icon" href="recursos/img/favicon.png">
    <link rel="stylesheet" href="recursos/css/styles.css">

    <title><?= $titulo ?? 'Proyecto' ?></title>
</head>

<body>
    <?= include 'vista/componentes/header.php' ?>

    <div>
        <?= $BODY ?>
    </div>
<body/>
