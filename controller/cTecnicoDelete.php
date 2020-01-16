<?php

include_once ("../model/tecnicoModel.php");

 $tecnico=new tecnicoModel();
 
 $tecnico_array = json_decode($_GET['value']);

 $idUsuario= $tecnico_array->idUsuario;
 
 $tecnico->setIdUsuario($idUsuario );    
 
 $resultado= $tecnico->delete();
 echo $resultado;
