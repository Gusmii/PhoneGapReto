<?php
include_once ("../model/equipoModel.php");

$equipo= new equipoModel();
$equipo->setList(); 
$equipoJSON=$equipo->getListJsonString();

echo $equipoJSON;

?>