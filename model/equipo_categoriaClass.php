<?php


class equipo_categoriaClass{
    protected $idCategoria;
    protected $idEquipo;
    
    /**
     * @return mixed
     */
    public function getIdCategoria()
    {
        return $this->idCategoria;
    }

    /**
     * @return mixed
     */
    public function getIdEquipo()
    {
        return $this->idEquipo;
    }

    /**
     * @param mixed $idCategoria
     */
    public function setIdCategoria($idCategoria)
    {
        $this->idCategoria = $idCategoria;
    }

    /**
     * @param mixed $nombre
     */
    public function setIdEquipo($idEquipo)
    {
        $this->idEquipo = $idEquipo;
    }

    function getObjectVars()
    {
        $vars = get_object_vars($this);
        return  $vars;
    }
    
    
    
    
}

