<? // Componente principal donde importar todas las librerias ?>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Recursos locales -->
    <link rel="icon" href="/assets/img/favicon.png">
    <link rel="stylesheet" href="/assets/css/index.css">

    <!-- TODO: Esto deberia guardarse como archivos en la carpeta "lib" -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>

    <title><?= $this->e($titulo ?? 'Sofit Gym') ?></title>
</head>