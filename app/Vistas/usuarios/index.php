<?php

/** @var array<\App\Dto\UsuarioDto> $items */
?>
<? $this->layout('layouts/base', ['titulo' => 'Usuarios']) ?>

<h1>Usuarios</h1>

<?php foreach ($items as $d): ?>
    <p><?= $d->cedula_persona ?></p>
<?php endforeach ?>
