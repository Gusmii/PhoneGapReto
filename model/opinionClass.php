<?php


class opinionClass{
    
    protected $idOpinion;
    protected $email;
    protected $fecha;
    protected $texto;


    public function getIdOpinion()
    {
        return $this->idOpinion;
    }

    public function getEmail()
    {
        return $this->email;
    }

    public function getFecha()
    {
        return $this->fecha;
    }

    public function getTexto()
    {
        return $this->texto;
    }

    public function setIdOpinion($idOpinion)
    {
        $this->idOpinion = $idOpinion;
    }

    public function setEmail($email)
    {
        $this->email = $email;
    }

    public function setFecha($fecha)
    {
        $this->fecha = $fecha;
    }

    public function setTexto($texto)
    {
        $this->texto = $texto;
    }

    function getObjectVars()
    {
        $vars = get_object_vars($this);
        return  $vars;
    }
    

 
}

