<?php
if ($_SERVER['SERVER_NAME'] == 'apc.dominios.fpz1920.com'){
    include_once ("connect_dataServer.php");
}else{
    include_once ("connect_data.php");
}
include_once 'categoriaClass.php';


class categoriaModel extends categoriaClass{
    
    private $link;
    private $list=array();
    
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
        $sql="call sp_categoria_load()";
        
        $result = $this->link->query($sql);
        while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC))
        {          
            $categoria = new categoriaModel();
            $categoria->setIdCategoria($row['idCategoria']);
            $categoria->setNombre($row['nombre']);

            array_push($this->list, $categoria);
        }
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

     // public function findNombreCategoria()
    // {
    //     $idCategoria=$this->idCategoria;
    //     $this->OpenConnect();
    //     $sql="call sp_nombre_categoria($idCategoria)";
        
    //     $result = $this->link->query($sql);
    //     while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC))
    //     {
    //         $this->setNombre($row['nombre']);
    //     }
    //     mysqli_free_result($result);
    //     $this->CloseConnect();
    // }
}


