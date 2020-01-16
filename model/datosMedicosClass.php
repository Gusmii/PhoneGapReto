<?php


class datosMedicosClass{
    protected $idDatosMedicos;
    protected $datos;
    protected $ultimaRevision;
 
    
    
    /**
     * @return mixed
     */
    public function getIdDatosMedicos()
    {
        return $this->idDatosMedicos;
    }

    /**
     * @return mixed
     */
    public function getDatos()
    {
        return $this->datos;
    }

    /**
     * @return mixed
     */
    public function getUltimaRevision()
    {
        return $this->ultimaRevision;
    }

    /**
     * @param mixed $idDatosMedicos
     */
    public function setIdDatosMedicos($idDatosMedicos)
    {
        $this->idDatosMedicos = $idDatosMedicos;
    }

    /**
     * @param mixed $datos
     */
    public function setDatos($datos)
    {
        $this->datos = $datos;
    }

    /**
     * @param mixed $ultimaRevision
     */
    public function setUltimaRevision($ultimaRevision)
    {
        $this->ultimaRevision = $ultimaRevision;
    }

    function getObjectVars()
    {
        $vars = get_object_vars($this);
        return  $vars;
    }
    
    
    
    
}

