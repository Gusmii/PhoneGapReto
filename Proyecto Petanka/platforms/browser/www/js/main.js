var usuarios;

$(document).ready(function () {

  $('#logout').hide();
  // COMPROBACION DE SI LA SESSION ESTA INICIADA 
  sessionCheck();


  $(".info").click(function () {
    $('#exampleModalLongTitle').html($(this).prev('h2').text());
  });

  // TRANSICION DE LOS DROPDOWNS A LA SECCION
  $(function () {
    $('.dropdown-menu>a[href]').click(function () {
      if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname) {
        var $target = $(this.hash);
        $target = $target.length && $target || $('[name=' + this.hash.slice(1) + ']');
        if ($target.length) {
          var targetOffset = $target.offset().top;
          $('html,body').animate({ scrollTop: targetOffset }, 800);
          return false;
        }
      }
    });
  });

  // VALIDAMIENTO DEL MODAL CONTACTO

  $('.modal-footer>#enviarOp').click(function () {

    var regex = /[\w-\.]{2,}@([\w-]{2,}\.)*([\w-]{2,}\.)[\w-]{2,4}/;
    var mensaje;

    if (regex.test($("form").find('#email').val().trim())) {

      if ($("form").find('#comentario').val() == "") {
        alert('No has escrito el comentario');
        mensaje = "no";
        slide_stop();
      }

      mensaje = "si";

    } else {
      alert('La direccón de correo no es válida');
      mensaje = "no";
      slide_stop();
    }

    if (mensaje == "si") {

      var email = $("form").find('#email').val();
      var texto = $("form").find('#comentario').val();

      $.ajax({

        type: 'GET',
        data: { 'email': email, 'texto': texto },
        url: 'controller/cInsertarOpinion.php',
        dataType: 'json',
        success: function (result) {

          console.log(result);

        }

      });

      $('#myModal').modal('toggle');
      $("form").find('#email').val("");
      $("form").find('#comentario').val("");
    }
  });
});

$("#logout").click(function () {
  $.ajax({
    url: "controller/login/logOut.php",
    dataType: "text",
    success: function (result) {

      console.log(result);

      newRow = "";
      newRow += "<p>Session destruida</p>";

      $("body").append(newRow);
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
      //decide que teiene que hacer dependiendo de el tipo de usuario
      userCheck(result);
    },
    error: function (xhr) {
      alert("An error occured: " + xhr.status + " " + xhr.statusText);
    }
  });

}

function userCheck(result) {
  if (!result.admin - 1) {
    if (result.admin == 1) {
      location.href = "admin.html";
    } else {
      //Adapta la pagina de Index para los usuarios
      habilitarLogout(result);
    }
  }
}

function habilitarLogout(result) {
  var htmlzatia = "";

  htmlzatia += 'Bienvenido ' + result.name + ', haz click para cerrar sesión';
  $("#logout").html(htmlzatia);

  $('#logout').show();

  $('.btnLogin').hide();
  $('.btnRegister').hide();
}