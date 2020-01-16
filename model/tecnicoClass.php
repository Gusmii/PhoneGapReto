<?php


class tecnicoClass{
    protected $idUsuario;
    protected $idTecnico;
    protected $licencia;
    protected $nombre;


    public function getIdUsuario()
    {
        return $this->idUsuario;
    }

    public function getIdTecnico()
    {
        return $this->idTecnico;
    }

    public function getLicencia()
    {
        return $this->licencia;
    }

    public function getNombre()
    {
        return $this->nombre;
    }

    public function setIdUsuario($idUsuario)
    {
        $this->idUsuario = $idUsuario;
    }

    public function setIdTecnico($idTecnico)
    {
        $this->idTecnico = $idTecnico;
    }

    public function setLicencia($licencia)
    {
        $this->licencia = $licencia;
    }

    public function setNombre($nombre)
    {
        $this->nombre = $nombre;
    }
    
    function getObjectVars()
    {
        $vars = get_object_vars($this);
        return  $vars;
    }
    

 
}

