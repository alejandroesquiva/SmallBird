// JavaScript Document


	function eliminar_smallbird_validar(id_tweet){
		
		confirmar=confirm("¿Estás seguro que quieres Eliminar este usuario?, si lo eliminas borraras todos sus SmallBirds"); 
		if (confirmar){ 
		// si pulsamos en aceptar
		URL = "admin-action.asp?action=delete&t=tweet&val1="+id_tweet;
		window.open(URL,"seguir");
		eliminarElemento("id_tweet_"+id_tweet);		
		}else{ 
		// si pulsamos en cancelar
		}
	
	}
	
	function eliminar_user_validar(user){
		
		
		confirmar=confirm("¿Estás seguro que quieres Eliminar este usuario?, si lo eliminas borraras todos sus SmallBirds"); 
		if (confirmar){ 
		// si pulsamos en aceptar
		URL = "admin-action.asp?action=delete&t=user&val1="+user;
		window.open(URL,"seguir");
		eliminarElemento("id_perfil_"+id_tweet);
		
		}else{ 
		// si pulsamos en cancelar
		}
	
	}
	
	function cambiar_boton(user){
		
		
		var bt = document.getElementById("in_"+user)
		var value = bt.value;
		
		if(value == "Seguir"){
			bt.value = "Dejar de Seguir"
			URL = "seguir.asp?id_user="+user;	
			
		}else{
			bt.value = "Seguir"
			URL = "dejar_de_seguir.asp?id_user="+user;
		}
		
		window.open(URL,"seguir") 
	}
	
	function foco_input(id){
	x = document.getElementById(id)	;
	x.value="";	
	
		if(id=="pass1" || id=="pass2" || id=="pass"){
			x.type="password";
		}
	
	}
	
	function blur_input(id,name){
	x = document.getElementById(id)	;
		if(x.value==""){

			if(id=="pass1" || id=="pass2" || id=="pass" ){
				x.type="test";	
			}
			x.value=name;
		}
	}
	
	function eliminarElemento(id){
	imagen = document.getElementById(id);	
	if (!imagen){
		
	} else {
		padre = imagen.parentNode;
		padre.removeChild(imagen);
	}
	
	}
