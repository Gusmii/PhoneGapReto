<?php
if ($_SERVER['SERVER_NAME'] == 'apc.dominios.fpz1920.com'){
    include_once ("connect_dataServer.php");
}else{
    include_once ("connect_data.php");
}
include_once 'usuarioClass.php';
include_once 'adminModel.php';

class usuarioModel extends usuarioClass
{

    private $link;

    private $list = array();

    private $objectJugador = array();

    private $objectTecnico = array();

    private $objAdmin;

    /**
     *
     * @param mixed $objAdmin
     */
    public function setObjAdmin($objAdmin)
    {
        $this->objAdmin = $objAdmin;
    }

    public function getObjAdmin()
    {
        return $this->objAdmin;
    }

    public function getObjectJugador()
    {
        return $this->objectJugador;
    }

    public function getObjectTecnico()
    {
        return $this->objectTecnico;
    }

    public function OpenConnect()
    {
        $konDat = new connect_data();
        try {
            $this->link = new mysqli($konDat->host, $konDat->userbbdd, $konDat->passbbdd, $konDat->ddbbname);
        } catch (Exception $e) {
            echo $e->getMessage();
        }
        $this->link->set_charset("utf8"); // honek behartu egiten du aplikazio eta
                                          // //databasearen artean UTF -8 erabiltzera datuak trukatzeko
    }

    public function CloseConnect()
    {
        mysqli_close($this->link);
    }

    public function setJugadoresByEquipo()
    {
        $this->OpenConnect();
        $id = $this->getIdEquipo();
        $sql = "call sp_usuario_by_equipo($id)";
        $result = $this->link->query($sql);
        while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
            $newUsuario = new usuarioModel();
            $newUsuario->setIdEquipo($row['idEquipo']);
            $newUsuario->setIdUsuario($row['idUsuario']);

            require_once ($_SERVER['DOCUMENT_ROOT'] . "/ERRONKA4_GRUPO2/model/jugadorModel.php");

            $jugador = new jugadorModel();
            $jugador->setIdUsuario($row['idUsuario']);
            $jugador->findJugadorByUser();

            $newUsuario->objectJugador = $jugador;

            array_push($this->list, $newUsuario);
        }
        mysqli_free_result($result);
        unset($jugador);
        $this->CloseConnect();
    }

    public function insertIdEquipoEnUsuario()
    {
        $this->OpenConnect();
        $idEquipo = $this->getIdEquipo();
        $sql = "call sp_insertar_equipo_en_usuario($idEquipo)";
        $result = $this->link->query($sql);

        mysqli_free_result($result);
        $this->CloseConnect();
    }

    public function findUserByUsername()
    {
        $this->OpenConnect();
        $user = $this->nombreUsuario;

        $sql = "call spFindUserByUsername('$user')";

        $result = $this->link->query($sql);
        $userExists = false;

        if ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
            $passwordEncripted = $row['password'];

            if (password_verify($this->getPassword(), $passwordEncripted)) {
                $this->setAdmin($row['admin']);
                $userExists = true;
            }
        }
        return $userExists;
        mysqli_free_result($result);
        $this->CloseConnect();
    }

    public function setTecnicosByEquipo()
    {
        $this->OpenConnect();
        $id = $this->getIdEquipo();
        $sql = "call sp_usuario_by_equipo($id)";
        $result = $this->link->query($sql);
        while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
            $newUsuario = new usuarioModel();
            $newUsuario->setIdEquipo($row['idEquipo']);
            $newUsuario->setIdUsuario($row['idUsuario']);

            require_once ($_SERVER['DOCUMENT_ROOT'] . "/ERRONKA4_GRUPO2/model/tecnicoModel.php");

            $tecnico = new tecnicoModel();
            $tecnico->setIdUsuario($row['idUsuario']);
            $tecnico->findTecnicoByUser();

            $newUsuario->objectTecnico = $tecnico;

            array_push($this->list, $newUsuario);
        }
        mysqli_free_result($result);
        unset($tecnico);
        $this->CloseConnect();
    }

    function getListJsonStringJugador()
    {
        $arr = array();
        foreach ($this->list as $usuario) {
            if ($usuario->getObjectJugador()->getNombre() != null) {
                $vars = $usuario->getObjectVars();
                $objectJugador = $usuario->objectJugador->getObjectVars();
                $vars['objectJugador'] = $objectJugador;
                array_push($arr, $vars);
            }
        }
        return json_encode($arr);
    }

    function getListJsonStringTecnico()
    {
        $arr = array();
        foreach ($this->list as $usuario) {
            if ($usuario->getObjectTecnico()->getIdTecnico() != null) {
                $vars = $usuario->getObjectVars();
                $objectTecnico = $usuario->objectTecnico->getObjectVars();
                $vars['objectTecnico'] = $objectTecnico;
                array_push($arr, $vars);
            }
        }
        return json_encode($arr);
    }
}

