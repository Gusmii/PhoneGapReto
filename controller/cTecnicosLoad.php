<?php
include_once ("../model/tecnicoModel.php");

$tecnico = new tecnicoModel();
$tecnico->setList(); 
$tecnicoJSON=$tecnico->getListJsonString();

echo $tecnicoJSON;

?>