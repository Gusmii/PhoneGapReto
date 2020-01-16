<?php
if ($_SERVER['SERVER_NAME'] == 'apc.dominios.fpz1920.com'){
    include_once ("connect_dataServer.php");
}else{
    include_once ("connect_data.php");
}
include_once 'equipo_categoriaClass.php';


class equipo_categoriaModel extends equipo_categoriaClass{
    
    private $link;
    private $list=array();
    private $objectNombre=array();
    
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
    
    public function findCategoria()
    {
        $idEquipo=$this->idEquipo;
        $this->OpenConnect();
        $sql="call sp_categoria_del_equipo($idEquipo)";
        
        $result = $this->link->query($sql);
        while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC))
        {          
            $this->setIdCategoria($row['idCategoria']);
            $this->setIdEquipo($row['nombre']);
        }
        mysqli_free_result($result);
        $this->CloseConnect();
    }

    public function insert()
    {
        $this->OpenConnect();
        $idCategoria=$this->getIdCategoria();
        $sql="call sp_insertar_idCat_equipo_categoria($idCategoria)";
        
        $result = $this->link->query($sql);
      
        mysqli_free_result($result);
        $this->CloseConnect();
    }

    function getListJsonString() {
        
        $arr=array();
        foreach ($this->list as $nombre)
        {
            $vars = $nombre->getObjectVars();
            $objectNombre=$nombre->objectNombre->getObjectVars();
            $vars['objectNombre']=$objectNombre;
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


