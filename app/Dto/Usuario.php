<?php

namespace App\Dto;

readonly class UsuarioDto
{
    public string $nombre;
    public string $apellido;
    public string $cedula_persona;
    public int $telefono;
    public string $correo;
}
