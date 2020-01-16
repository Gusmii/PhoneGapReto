<?php
if ($_SERVER['SERVER_NAME'] == 'apc.dominios.fpz1920.com'){
    include_once ("connect_dataServer.php");
}else{
    include_once ("connect_data.php");
}
include_once 'equipoClass.php';



class equipoModel extends equipoClass{
    
    private $link;
    private $list=array();
    private $objectCategoria=array();
    
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
        $this->link->set_charset("utf8"); // honek behartu egiten du aplikazio eta
        //                  //databasearen artean UTF -8 erabiltzera datuak trukatzeko
    }
    
    public function CloseConnect()
    {
        mysqli_close ($this->link);
        
    }
    
    public function setList()
    {
        $this->OpenConnect();
        $sql="call sp_equipo_load()";
        
        $result = $this->link->query($sql);
        while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC))
        {
            $newEquipo = new equipoModel();
            
            $newEquipo->setIdEquipo($row['idEquipo']);
            $newEquipo->setNombre($row['nombre']);

            require_once ($_SERVER['DOCUMENT_ROOT']."/ERRONKA4_GRUPO2/model/equipo_categoriaModel.php");
            
            $equipo_categoria = new equipo_categoriaModel();
            $equipo_categoria->setIdEquipo($row['idEquipo']);
            $equipo_categoria->findCategoria();
            
            $newEquipo->objectCategoria=$equipo_categoria;
            
            array_push($this->list, $newEquipo);
        }
        mysqli_free_result($result);
        $this->CloseConnect();
    }

    public function insert()
    {
        $this->OpenConnect();
        $nombre=$this->getNombre();
        $sql="call sp_insertar_nombre_equipo('$nombre')";
        
        $result = $this->link->query($sql);
      
        mysqli_free_result($result);
        $this->CloseConnect();
    }

    public function delete()
    {
        $this->OpenConnect();
        
        $idEquipo=$this->getIdEquipo();
        
        
        $sql = "CALL sp_delete_equipo($idEquipo)";
        
        if ($this->link->query($sql)>=1) // delete egiten da
        {
            echo "El Equipo se ha borrado con exito";
        } else {
            echo "Fallo al borrar el Equipo: (" . $this->link->errno . ") " . $this->link->error;
        }
        
        $this->CloseConnect();
    }

    function getListJsonString() {
        
        $arr=array();
        foreach ($this->list as $categoria)
        {
            $vars = $categoria->getObjectVars();
            $objectCategoria=$categoria->objectCategoria->getObjectVars();
            $vars['objectCategoria']=$objectCategoria;
            array_push($arr, $vars);
            
        }
        return json_encode($arr);
    }
    
    // function getListJsonString() {
        
    //     $arr=array();
        
    //     foreach ($this->list as $object)
    //     {
    //         $vars = $object->getObjectVars();
            
    //         array_push($arr, $vars);
    //     }
    //     return json_encode($arr);
    // }
}


