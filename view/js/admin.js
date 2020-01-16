sessionCheck();

var miApp = angular.module('miApp', []);
miApp.controller('miControlador', ['$scope', '$http', function ($scope, $http) {

    //Escondemos todo al Principio
    $scope.ConAjax = "true";
    $scope.agregarEquipos = "false";
    $scope.agregarJugador = "false";
    $scope.agregarTecnico = "false";
    $scope.modificarEquipo = "false";
    $scope.eliminarEquipos = "false";
    $scope.eliminarJugadores = "false";
    $scope.eliminarTecnicos = "false";
    $scope.verTabla = "true";


    $scope.misdatosEquipo = {
        idEquipo: "",
        idCategoria: "",
        nombreEquipo: "",
    }

    $scope.misdatosJugador = {
        idJugador: "",
        idUsuario: "",
        nombreJugador: "",
    }

    $scope.misdatosTecnico = {
        idUsuario: "",
        idTecnico: "",
        licencia: "",
        nombreTecnico: "",
    }


    $http({
        method: 'GET',
        url: '../controller/cEquipos.php',
    }).then(function (data) { //necesito saber un evento que al cargar lista sepa que esta cargado

        console.log(data.data);
        $scope.lista = data.data; //asigna a la lista los datos recibidos
        $scope.verMenu = "true";

        setTimeout(function () { //hace que se ejecute mas tarde para que pueda realizar esta accion

            $(".nombreEquipo").click(function () {

                var idEquipo = $(this).attr("data-id");
                alert(idEquipo);


                // $http({
                //     method: 'GET',
                //     data: {"idEquipo":idEquipo},
                //     url: '../controller/cPlantilla.php',
                // }).then(function (data) { //necesito saber un evento que al cargar lista sepa que esta cargado

                //     console.log(data.data);

                // });



            });

            $http({
                method: 'GET',
                url: '../controller/cCategoria.php',
            }).then(function (data) {

                console.log(data.data);
                $scope.categorias = data.data;
            });

            $http({
                method: 'GET',
                url: '../controller/cJugadores.php',
            }).then(function (data) {

                console.log(data.data);
                $scope.jugadores = data.data;
            });

            $http({
                method: 'GET',
                url: '../controller/cTecnicosLoad.php',
            }).then(function (data) {

                console.log(data.data);
                $scope.tecnicos = data.data;
            });

            $http({
                method: 'GET',
                url: '../controller/cOpiniones.php',
            }).then(function (data) {

                console.log(data.data);
                $scope.opiniones = data.data;
            });

            $scope.Buscar = function () {
                $scope.eliminarTecnicos = "false";
                $scope.eliminarEquipos = "false";
                $scope.eliminarJugadores = "false";
                $scope.agregarEquipos = "false";
                $scope.agregarTecnico = "false";
                $scope.agregarJugador = "false";
                $scope.buscarEquipo = "true";
            }

            $scope.EquipoNuevo = function () {
                $scope.eliminarTecnicos = "false";
                $scope.eliminarEquipos = "false";
                $scope.eliminarJugadores = "false";
                $scope.buscarEquipo = "false";
                $scope.agregarTecnico = "false";
                $scope.agregarJugador = "false";
                $scope.agregarEquipos = "true";

            }

            $scope.JugadorNuevo = function () {
                $scope.eliminarTecnicos = "false";
                $scope.eliminarEquipos = "false";
                $scope.eliminarJugadores = "false";
                $scope.buscarEquipo = "false";
                $scope.agregarEquipos = "false";
                $scope.agregarTecnico = "false";
                $scope.agregarJugador = "true";

            }

            $scope.TecnicoNuevo = function () {
                $scope.eliminarTecnicos = "false";
                $scope.eliminarEquipos = "false";
                $scope.eliminarJugadores = "false";
                $scope.buscarEquipo = "false";
                $scope.agregarEquipos = "false";
                $scope.agregarJugador = "false";
                $scope.agregarTecnico = "true";
            }

            $scope.cancelar = function () {
                $scope.buscarEquipo = "false";
                $scope.agregarEquipos = "false";
                $scope.agregarJugador = "false";
                $scope.agregarTecnico = "false";
                $scope.eliminarEquipos = "false";
                $scope.eliminarJugadores = "false";
                $scope.eliminarTecnicos = "false";
            }

            $scope.EliminarEquipo = function () {
                $scope.eliminarJugadores = "false";
                $scope.eliminarTecnicos = "false";
                $scope.buscarEquipo = "false";
                $scope.agregarTecnico = "false";
                $scope.agregarJugador = "false";
                $scope.agregarEquipos = "false";
                $scope.eliminarEquipos = "true";
            }

            $scope.EliminarJugador = function () {
                $scope.eliminarTecnicos = "false";
                $scope.buscarEquipo = "false";
                $scope.agregarTecnico = "false";
                $scope.agregarJugador = "false";
                $scope.agregarEquipos = "false";
                $scope.eliminarEquipos = "false";
                $scope.eliminarJugadores = "true";
            }

            $scope.EliminarTecnico = function () {
                $scope.buscarEquipo = "false";
                $scope.agregarTecnico = "false";
                $scope.agregarJugador = "false";
                $scope.agregarEquipos = "false";
                $scope.eliminarEquipos = "false";
                $scope.eliminarJugadores = "false";
                $scope.eliminarTecnicos = "true";
            }

            $scope.agregarEquipo = function () {

                alert($scope.misdatosEquipo.idCategoria.idCategoria);
                equipoNuevo = { 'idCategoria': $scope.misdatosEquipo.idCategoria.idCategoria, 'nombre': $scope.misdatosEquipo.nombreEquipo };

                equipoNuevo = JSON.stringify(equipoNuevo);
                alert(equipoNuevo);

                $http({
                    method: 'GET',
                    params: { value: equipoNuevo },
                    url: '../controller/cEquipoInsert.php',
                }).then(function (data) {

                    console.log(data.data);

                });
            }

            $scope.agregar_Jugador = function () {

                jugadorNuevo = { 'nombreJugador': $scope.misdatos.nombreJugador, 'idEquipo': $scope.misdatosEquipo.idEquipo.idEquipo };

                jugadorNuevo = JSON.stringify(jugadorNuevo);
                alert(jugadorNuevo);

                $http({
                    method: 'GET',
                    params: { value: jugadorNuevo },
                    url: '../controller/cJugadorInsert.php',
                }).then(function (data) {

                    console.log(data.data);

                });
            }

            $scope.agregar_Tecnico = function () {

                tecnicoNuevo = { 'nombreTecnico': $scope.misdatos.nombreTecnico, 'licencia': $scope.misdatos.licencia, 'idEquipo': $scope.misdatosEquipo.idEquipo.idEquipo };

                tecnicoNuevo = JSON.stringify(tecnicoNuevo);
                alert(tecnicoNuevo);

                $http({
                    method: 'GET',
                    params: { value: tecnicoNuevo },
                    url: '../controller/cTecnicoInsert.php',
                }).then(function (data) {

                    console.log(data.data);

                });
            }

            $scope.eliminarEquipo = function () {

                EquipoDelete = { 'idEquipo': $scope.misdatosEquipo.idEquipo.idEquipo };

                EquipoDelete = JSON.stringify(EquipoDelete);
                alert(EquipoDelete);

                $http({
                    method: 'GET',
                    params: { value: EquipoDelete },
                    url: '../controller/cEquipoDelete.php',
                }).then(function (data) {

                    console.log(data.data);

                });
            }

            $scope.eliminarJugador = function () {

                JugadorDelete = { 'idUsuario': $scope.misdatosJugador.idUsuario.idUsuario };

                JugadorDelete = JSON.stringify(JugadorDelete);
                alert(JugadorDelete);

                $http({
                    method: 'GET',
                    params: { value: JugadorDelete },
                    url: '../controller/cJugadorDelete.php',
                }).then(function (data) {

                    console.log(data.data);

                });
            }

            $scope.eliminarTecnico = function () {

                TecnicoDelete = { 'idUsuario': $scope.misdatosTecnico.idUsuario.idUsuario };

                TecnicoDelete = JSON.stringify(TecnicoDelete);
                alert(TecnicoDelete);

                $http({
                    method: 'GET',
                    params: { value: TecnicoDelete },
                    url: '../controller/cTecnicoDelete.php',
                }).then(function (data) {

                    console.log(data.data);

                });
            }
        }, 300)
    });
}]);
$("#logout").click(function () {
    $.ajax({
        url: "../controller/login/logOut.php",
        dataType: "text",
        success: function (result) {
            alert('Session destruida, hasta la proxima ;-)');
            location.href = "../index.html"
        },
        error: function (xhr) {
            alert("An error occured: " + xhr.status + " " + xhr.statusText);
        }
    });
});
function sessionCheck() {
    $.ajax({
        url: "/ERRONKA4_GRUPO2/controller/login/cSessionGetVar.php",
        dataType: "json",

        success: function (result) {
            console.log(result);
            userCheck(result);
        },
        error: function (xhr) {
            alert("An error occured: " + xhr.status + " " + xhr.statusText);
        }
    });
}

function userCheck(result) {
    if ((!result.admin - 1) || (result.admin==null)) {
        if (result.admin == 1) {
        } else {
            location.href = "../index.html";
        }
        // } else {
        // 	alert("Error al iniciar sesion");
    }
}