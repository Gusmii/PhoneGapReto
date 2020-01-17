$(document).ready(function () {

	// COMPROBACION DE SI LA SESSION ESTA INICIADA 

	sessionCheck();

	$("#submit").click(function () {
		alert('hola');
		var name = $("#name").val();
		var password = $("#password").val();
		$.ajax({
			data: { 'name': name, 'password': password },
			url: "../controller/login/cSessionSetVar.php",
			dataType: "text",
			success: function (result) {

				result = JSON.parse(result);
				console.log(result);
				userCheck(result);
			},
			error: function (xhr) {
				alert("An error occured: " + xhr.status + " " + xhr.statusText);
			}
		});
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

function userCheck(result){
	if (!result.admin -1) {
		if (result.admin == 1) {
			location.href="admin.html";
		} else { 
			location.href="../index.html";
		}
	// } else {
	// 	alert("Error al iniciar sesion");
	 }
}