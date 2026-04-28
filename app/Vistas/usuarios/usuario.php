<?php

/** @var array<\App\Dto\UsuarioDto> $data */
?>

<h1>Usuarios</h1>

<?php foreach ($data as $d): ?>
    <p><?= $d->cedula_persona ?></p>
<?php endforeach ?>
