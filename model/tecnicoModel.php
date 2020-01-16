<?php
if ($_SERVER['SERVER_NAME'] == 'apc.dominios.fpz1920.com'){
    include_once ("connect_dataServer.php");
}else{
    include_once ("connect_data.php");
}
include_once 'tecnicoClass.php';


class tecnicoModel extends tecnicoClass{
    
    private $link;
    private $list=array();
    private $objectEntrenador = array();

    public function getObjectEntrenador(){
        return $this->objectEntrenador;
    }

    public function setObjectEntrenador($objectEntrenador){
        $this->objectEntrenador = $objectEntrenador;
    }
    
    public function OpenConnect()
    {
        $konDat=new connect_data();
        try
        {
            $this->link=new mysqli($konDat->host,$konDat->userbbdd,$konDat->passbbdd,$konDat->ddbbname);
        }
        catch(Exception $e)
        {
            echo $e->getMessage();
        }
        $this->link->set_charset("utf8");
    }
    
    public function CloseConnect()
    {
        mysqli_close ($this->link);
        
    }
    
    public function setList()
    {
        $this->OpenConnect();
        $sql="call sp_tecnico_load()";
        
        $result = $this->link->query($sql);
        while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC))
        {
            $newTecnico = new tecnicoModel();
            
            $newTecnico->setIdTecnico($row['idTecnico']);
            $newTecnico->setIdUsuario($row['idUsuario']);
            $newTecnico->setLicencia($row['licencia']);
            $newTecnico->setNombre($row['nombre']);
            
            array_push($this->list, $newTecnico);
        }
        mysqli_free_result($result);
        $this->CloseConnect();
    }
    
    public function delete()
    {
        $this->OpenConnect();
        
        $idUsuario=$this->getIdUsuario();
        
        
        $sql = "CALL sp_delete_tecnico($idUsuario)";
        
        if ($this->link->query($sql)>=1) // delete egiten da
        {
            echo "El Tecnico se ha borrado con exito";
        } else {
            echo "Fallo al borrar el Tecnico: (" . $this->link->errno . ") " . $this->link->error;
        }
        
        $this->CloseConnect();
    }

    public function findTecnicoByUser()
    {   
        $idUsuario=$this->idUsuario;
        $this->OpenConnect();  
        $sql="call sp_tecnico_by_idUsuario($idUsuario)";
        $result = $this->link->query($sql);
        while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC))
        {
            $this->setIdTecnico($row['idTecnico']);
            $this->setLicencia($row['licencia']);
            $this->setNombre($row['nombre']);
        } 
        mysqli_free_result($result);
        $this->CloseConnect();
    }

    public function insertTecnico()
    {   
        $this->OpenConnect();
        $nombre=$this->getNombre();
        $licencia=$this->getLicencia();
        $sql="call sp_insertar_tecnico('$nombre', '$licencia')";
        $result = $this->link->query($sql);

        mysqli_free_result($result);
        $this->CloseConnect();
    }

    function getListJsonString() {
        
        $arr=array();
        
        foreach ($this->list as $object)
        {
            $vars = $object->getObjectVars();
            
            array_push($arr, $vars);
        }
        return json_encode($arr);
    }

}

