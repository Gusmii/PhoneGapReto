<?php
include_once ("../model/usuarioModel.php");
include_once ("../model/jugadorModel.php");

$usuario= new usuarioModel();
$jugador = new jugadorModel();

$jugador_array = json_decode($_GET['value']);

$idEquipo=$jugador_array->idEquipo;
$nombre_jugador=$jugador_array->nombreJugador;

$usuario->setIdEquipo($idEquipo);
$jugador->setNombre($nombre_jugador);   

$usuario->insertIdEquipoEnUsuario(); 
$jugador->insertJugador();

?>
    

