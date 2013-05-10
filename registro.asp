<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<!--------------------------------------------------------------------------------------------------

Función insertar_usuario_bd(usuario,password,email)

inserta en la base de datos un nuevo usuario, con todos sus datos 

usuario = nombre del usuario
password = password del usuario
email = email del usuario

--------------------------------------------------------------------------------------------------->

  
  <%
  
  sub insertar_usuario_bd(usuario,password,email,url_foto)
  
  	FechaHoraActual = obtener_fechahora_actual()
	
	
  'le damos formato al tweet, incluyendo enlaces y demás
   
   Set oConn = Server.CreateObject("ADODB.Connection")
  oConn.Open "Data Source="& Server.MapPath("smallbird.mdb") &";Provider=Microsoft.Jet.OLEDB.4.0"
  
  SQL = "INSERT INTO users ([nombre_usuario], [password],[mail],[url_foto_perfil],[fecha_registro]) VALUES ('"&usuario&"','"&password&"','"&email&"','"&url_foto&"','"&FechaHoraActual&"');" 
  
  RecordsAffected=0
  oConn.Execute SQL, RecordsAffected
 

  If RecordsAffected > 0 then
         
  Else
          Response.Write "<b>Se ha producido un error al insertar el registro</b>"
  End If

  oConn.Close 
  Set oRS = Nothing
  Set oConn = Nothing
 
  end sub 
  
  %>
  


<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Registro</title>
</head>
<body>

<!--#include file="includes/up.asp"-->
<!--#include file="includes/funciones.asp"-->

<div class="blogcomment">
 	<div class="blogwcommentwrap">  
    	<div align="center" class="contacttextarea">
      		<h4 style="float:left;padding-left:20px">
            <a href="default.asp">Inicio</a>
            &gt;
            <a href="registro.asp">Registro</a>
            </h4>
        </div>
    
	</div>
</div>
        
		<%

			if Request.Form("usuario") = "" then 
			
			%>
			<!--#include file="includes/mod_registro.asp"-->
			<%
			
			else
				
				if usuario_existente(Request.Form("usuario")) = "true" then
					call mensaje_error("Error","El USUARIO YA EXISTE")
				else
						
					call insertar_usuario_bd(Request.Form("usuario"),Request.Form("password"),Request.Form("email"),Request.Form("foto"))
					
						session("nombre_usuario") = Request.Form("usuario")
						session("password") = Request.Form("password")
						session("mail") = Request.Form("email")
					  	session("url_foto_perfil") = Request.Form("foto")
						Session("estado") = "true"
					
					'conseguimos el id				
					  On Error Resume Next
					  Set oConn_log = CreateObject("ADODB.Connection")
					  oConn_log.Open "Data Source="& Server.MapPath("smallbird.mdb") &";Provider=Microsoft.Jet.OLEDB.4.0"
					  
					  SQL = "SELECT users.Id_user FROM users WHERE (((users.nombre_usuario)='"&request.Form("usuario")&"'));"
					  
					  Set oRS_log = oConn_log.Execute(SQL)
					
					  If Err.Description <> "" then
					  Response.Write "<b>Error:" & Err.Description & "</b>"
					  Else
					  End If
					  
					  Do Until oRS_log.EOF
					  
						Session("id_user") = oRS_log("id_user")
					  
					  oRS_log.MoveNext
					  Loop
					  oConn_log.Close
					  Set oRS_log = Nothing
					  Set oConn_log = Nothing
					  
					  response.Redirect("default.asp")
					
					
				end if
				
			end if
		%>

        
<!--#include file="includes/down.asp"-->
</body>
</html>