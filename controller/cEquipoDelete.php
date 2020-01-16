<?php

include_once ("../model/equipoModel.php");

 $equipo=new equipoModel();
 
 $equipo_array = json_decode($_GET['value']);

 $idEquipo=$equipo_array->idEquipo;
 
     $equipo->setIdEquipo($idEquipo );    
 
 $resultado=$equipo->delete();
 echo $resultado;
?>