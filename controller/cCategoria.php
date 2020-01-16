<?php
include_once ("../model/categoriaModel.php");

$categoria= new categoriaModel();
$categoria->setList(); 
$categoriaJSON=$categoria->getListJsonString();

echo $categoriaJSON;

?>