<?php
include_once ("../model/opinionModel.php");

$opinion = new opinionModel();

$email=filter_input(INPUT_GET,"email");

if (isset($email)){
    $opinion->setEmail($email);
}

$texto=filter_input(INPUT_GET,"texto");

if (isset($texto)){
    $opinion->setTexto($texto);
}

$opinion->insertOpinion(); 


?>