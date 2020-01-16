<?php

include_once ("../model/jugadorModel.php");

 $jugador=new jugadorModel();
 
 $jugador_array = json_decode($_GET['value']);

 $idUsuario=$jugador_array->idUsuario;
 
 $jugador->setIdUsuario($idUsuario );    
 
 $resultado=$jugador->delete();
 echo $resultado;
