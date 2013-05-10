<script language="JavaScript" SRC="includes/funciones.js"></script>
<script language="javascript">

	function validar_login(){
	
	userDefault="Usuario";
	passDefault="Contraseña";
	
	user = document.getElementById("user_login");
	pass = document.getElementById("pass");
	
		if(pass.value=="" || user.value == "" || pass.value==passDefault || user.value == userDefault){
			alert("No puedes dejar ningun campo vacio");
			user.focus();
		}else{
			document.forms["login"].submit()	
		}
	}
</script>
	
<div class="blogwidgetstart">
	<div class="widgettitle"></div>
    <div class="widgetbody">
    	<div class="blogadvertising">
        	<div class="contacttitle">
            	<h2>Login</h2>
            </div>
            <form action="login.asp" method="post" name="login">
            <div class="contacttextarea">
            	<fieldset>
                <input id="user_login" class="contacttextform" type="text" name="usuario_login" size="20" Value="Usuario" onblur="blur_input(this.form.usuario_login.id,'Usuario')" onfocus="foco_input(this.form.usuario_login.id)"/>
                </fieldset>
        	</div>
            <div class="contacttextarea">
            	<fieldset>
                <input id="pass" class="contacttextform" type="text" name="password_login" size="20" value="Contraseña" onblur="blur_input(this.form.password_login.id,'Contraseña')" onfocus="foco_input(this.form.password_login.id)"/>
                </fieldset>
            </div>
            <div class="contacttextarea">   
                <fieldset class="commentbutton_fieldset">
                <input class="featured-titles" type="button" value="Entrar" onclick="validar_login()"/>
                </fieldset>
            </div>
            <div class="contacttextarea">
            	<a class="featured-titles" href="registro.asp"> Registrar Usuario </a>
			</div>
				</form>
  	</div>
            <span class="box-arrow"></span>
</div>
</div>
