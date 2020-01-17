$(document).ready(function () {
  // COMPROBACION DE SI LA SESSION ESTA INICIADA 
  sessionCheck();

    $.ajax({
        type: 'GET',
        url: '../controller/cOpiniones.php',
        dataType: 'json',
        success: function (result) {

            console.log(result);

            $(".opiniones").empty();
            var newRow = "";

            $.each(result, function (i, opiniones) {
 
                newRow += '<div class="card m-3 text-dark">'
                newRow += '<div class="card-header">'+opiniones.fecha+'</div>'
                newRow += '<div class="card-body">'
                newRow += '<p class="card-text">'+opiniones.texto+'</p>'
                newRow += '<p></p>'
                newRow += '<span id="star1'+i+'" class="fa fa-star"></span>'
                newRow += '<span id="star2'+i+'" class="fa fa-star"></span>'
                newRow += '<span id="star3'+i+'" class="fa fa-star"></span>'
                newRow += '<span id="star4'+i+'" class="fa fa-star"></span>'
                newRow += '<span id="star5'+i+'" class="fa fa-star"></span>'
                newRow += '</div></div>'

 
            });

            $(".opiniones").append(newRow);
            
                for(var x=0; x<=result.length; x++){

                    var cant = Math.floor((Math.random() * 5) + 1);

                    for(var z=1; z<=cant; z++){
                        $( '#star'+z+x ).addClass( 'checked' );
                    }
                }
        

        }

    });


    

});


