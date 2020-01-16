<?php
include_once ("../model/usuarioModel.php");

$usuario= new usuarioModel();

$idEquipo=filter_input(INPUT_GET,"idEquipo");
if (isset($idEquipo))
{
    $usuario->setIdEquipo($idEquipo);
}

$usuario->setTecnicosByEquipo(); 
$usuarioJSON=$usuario->getListJsonStringTecnico();

echo $usuarioJSON;
?>