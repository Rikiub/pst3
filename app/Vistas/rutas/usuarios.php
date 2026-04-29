<? $this->layout('layouts/default', ['titulo' => 'Usuarios']) ?>

<h1>Usuarios</h1>

<? foreach ($items as $d): ?>
    <p><?= $d->cedula_persona ?></p>
<? endforeach ?>
