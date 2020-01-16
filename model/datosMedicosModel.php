<?php
if ($_SERVER['SERVER_NAME'] == 'apc.dominios.fpz1920.com'){
    include_once ("connect_dataServer.php");
}else{
    include_once ("connect_data.php");
}
include_once 'datosMedicosClass.php';


class datosMedicosModel extends datosMedicosClass{
    
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
        $sql="call sp_datosMedicos_load";
        
        $result = $this->link->query($sql);
        while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC))
        {
            $newDatosMedicos = new usuarioModel();
            $newDatosMedicos->setIdDatosMedicos($row['idDatosMedicos']);
            $newDatosMedicos->setDatos($row['datos']);
            $newDatosMedicos->setUltimaRevision($row['ultimaRevision']);
            
            array_push($this->list, $newDatosMedicos);
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
}


