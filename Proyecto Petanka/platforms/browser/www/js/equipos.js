$(document).ready(function () {
  // COMPROBACION DE SI LA SESSION ESTA INICIADA 
  sessionCheck();

    $.ajax({
        type: 'GET',
        url: '../controller/cEquipos.php',
        dataType: 'json',
        success: function (result) {

            console.log(result);

            $(".equipos").empty();
            var newRow = "";

            $.each(result, function (i, equipo) {

                newRow += '<div class="card text-center col-md-3 mr-3 ml-3 mb-3 carousel" width: 18rem;>'
                newRow += '<img src="img/escudo_APC.png" class="card-img-top mx-auto d-block">'
                newRow += '<div class="card-body">'
                newRow += '<h5 class="card-title text-light">'+equipo.nombre+'</h5>'
                newRow += '<p class="card-text text-light">'+equipo.objectCategoria.idEquipo+'</p>'
                newRow += '<a class="btn btnPlantilla botones" data-id="'+equipo.idEquipo+'" data-toggle="modal" data-target="#myModalPlantilla">Plantilla</a>'
                newRow += '</div></div>'
            
            });

            newRow += '<div id="myModalPlantilla" class="modal fade text-center" tabindex="-1" role="dialog">'
            newRow += '<div class="modal-dialog" role="document">'
            newRow += '<div class="modal-content">'
            newRow += '<div class="modal-header">'
            newRow += '<h5 class="modal-title text-dark"></h5>'
            newRow += '<button type="button" class="close" data-dismiss="modal" aria-label="Close">'
            newRow += '<span aria-hidden="true">&times;</span>'
            newRow += '</button>'
            newRow += '</div>'
            newRow += '<div class="modal-body text-dark">'
            newRow += '</div>'
            newRow += '<div class="modal-footer">'
            newRow += '<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>'
            newRow += '</div></div></div></div>'

            $(".equipos").append(newRow);


            $(".btnPlantilla").click(function () {

                var idEquipo = $( this ).attr("data-id");

                $.each(result, function (i, equipo) {
                    if(idEquipo == equipo.idEquipo){
                        $( "#myModalPlantilla" ).find( ".modal-title" ).html("<b>"+equipo.nombre+' ('+equipo.objectCategoria.idEquipo+')</b>');
                    }
                });
                

                $.ajax({

                    type: 'GET',
                    data: {"idEquipo":idEquipo},
                    url: '../controller/cPlantilla.php',
                    dataType: 'json',
                    success: function (result) {
            
                        console.log(result);

                        $(' .modal-body ').empty();

                        var newRow = "";
                        newRow += "<h5><b>Jugadores</b></h5>";

                        $.each(result, function(i, jugador) {
                            newRow += "<p>"+jugador.objectJugador.nombre+"</p>";
                        });

                        $(".modal-body").append(newRow);

                        $.ajax({

                            type: 'GET',
                            data: {"idEquipo":idEquipo},
                            url: '../controller/cTecnicos.php',
                            dataType: 'json',
                            success: function (result) {
                    
                                console.log(result);
        
                                var newRow = "";
                                newRow += "<h5><b>Tecnicos</b></h5>";
        
                                $.each(result, function(i, tecnico) {
                                    newRow += "<p>"+tecnico.objectTecnico.nombre+" (";
                                    newRow += tecnico.objectTecnico.licencia+")</p>";
                                });
        
                                $(".modal-body").append(newRow);
                            }
                        });

                    }  
                });

            });

        }

    });
    


    

});


