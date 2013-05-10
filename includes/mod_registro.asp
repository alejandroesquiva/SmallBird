<script language="JavaScript" SRC="includes/funciones.js"></script>
<script language="javascript">
	function validar_registro(){
		
		userDefault="Usuario"
		pass1Default="Contraseña"
		pass2Default="Repita la contraseña"
		mailDefault="Email"
		
		user = document.getElementById("user");
		pass1 = document.getElementById("pass1");
		pass2 = document.getElementById("pass2");
		mail = document.getElementById("mail");
		
		
		if (user.value == "" || pass1.value == "" || pass2.value == "" || mail.value == "" || user.value == userDefault || pass1.value == pass1Default || pass2.value == pass2Default || mail.value == mailDefault){
			alert("Todos los campos deben ser usados");
		}else{
					
			
			if(pass1.value!=pass2.value){
				alert("las contraseñas no coinciden");
				pass1.focus();
			}else{
				
				if(validarEmail(mail.value)==true){
					
					document.forms["registro"].submit();	
				}else{
					
					alert("La dirección de email " + mail.value + " es incorrecta.");
					mail.focus();
				}				
			}
		}
		
	}
	
	id_anterior = "";
	
	function cambiar_input(id){
				
		input=document.getElementById("foto");
		input.value = id;
		foto = document.getElementById(id).style.background="#00F";
		
		if(id_anterior != ""){
			foto2 = document.getElementById(id_anterior).style.background="rgba(255,0,0,0)";		
		}
		
		if(id == id_anterior){
			id_anterior = "";	
		}else{
			id_anterior = id;
		}
		//document.id.style.border = "medium solid black";

	}
	
	function validarEmail(valor) {
		if (/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(valor)){
		return true;
		} else {
		return false;
		}
	}

</script>
<div class="blogcomment">
 	<div class="blogwcommentwrap">   

        
        <div align="center" class="contacttextarea">
        <h1 style="color:#000">Registro</h1>
        </div>
        
     
	    <div align="center" class="contacttextarea">
        
        <form name="registro" action="registro.asp" method="post">
        
        <input id="user" class="contacttextform" type="text" name="usuario" size="20" value="Usuario" onblur="blur_input(this.form.usuario.id,'Usuario')" onfocus="foco_input(this.form.usuario.id)" />	
        </div>
        <div align="center" class="contacttextarea">
        <input id="pass1" class="contacttextform" type="text" name="password" size="20" value="Contraseña" onblur="blur_input(this.form.pass1.id,'Contraseña')" onfocus="foco_input(this.form.pass1.id)" />
        </div>
        <div align="center" class="contacttextarea">        
        <input id="pass2" class="contacttextform" type="text" name="rep_password" size="20" value="Repita la contraseña" onblur="blur_input(this.form.pass2.id,'Repita la contraseña')" onfocus="foco_input(this.form.pass2.id)" />
        </div>
        <div align="center" class="contacttextarea">        
        <input id="mail" class="contacttextform" type="text" name="email" size="20" value="Email" onblur="blur_input(this.form.email.id,'Email')" onfocus="foco_input(this.form.email.id)"/>
        </div>

               
      	
        <div align="center" class="contacttextarea">
        <h1 style="color:#000">Elige Avatar</h1>
        </div>
        
        
        <div align="center" class="contacttextarea"> 
	    	<%

					Set ObjetoFSO = Server.CreateObject("Scripting.FileSystemObject")
					folder = "images/avatar/"
					'nos selecciona la carpeta en la que esta el archivo
					
					Set ObjetoCarpeta = ObjetoFSO.GetFolder(Server.MapPath(folder))
									
					'busca en todos los archivos que encuentra en dicha carpeta
					For Each Fichero in ObjetoCarpeta.Files
					%>
                    <img id="<%Response.write(folder&Fichero.Name)%>" src="<%response.Write(folder&Fichero.Name)%>" width=60px height=60px onclick="cambiar_input(this.id)" name="<%Response.write(folder&Fichero.Name)%>" />
                    <%
					Next
					
					
					Set Fichero = Nothing
					Set ObjetoCarpeta = Nothing
					Set ObjetoFSO = Nothing

			%>
        </div>
        
        <div align="center" class="contacttextarea">       
        <input class="featured-titles" type="button" onclick="validar_registro()" value="Registrar"/>
        
        <input name="foto" id="foto" hidden="true" value="images/profileDefault.jpg"/>
        </form>
        </div>
     
        <span class="box-arrow"></span>
	</div>
</div>

