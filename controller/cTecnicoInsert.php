<?php
include_once ("../model/usuarioModel.php");
include_once ("../model/tecnicoModel.php");

$usuario= new usuarioModel();
$tecnico = new tecnicoModel();

$tecnico_array = json_decode($_GET['value']);

$idEquipo=$tecnico_array->idEquipo;
$tecnico_nombre=$tecnico_array->nombreTecnico;
$tecnico_licencia=$tecnico_array->licencia;

$usuario->setIdEquipo($idEquipo);
$tecnico->setNombre($tecnico_nombre);   
$tecnico->setLicencia($tecnico_licencia); 

$usuario->insertIdEquipoEnUsuario(); 
$tecnico->insertTecnico();

?>
    

