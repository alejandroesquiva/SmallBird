<script language="javascript" type="text/javascript">
	function mensaje_error(mensaje){
		alert(mensaje);
	}

</script>
<!--#include file="includes/funciones.asp"-->
<%
sub eliminar_user(id_user)

Set oConn = Server.CreateObject("ADODB.Connection")
  oConn.Open "Data Source="& Server.MapPath("smallbird.mdb") &";Provider=Microsoft.Jet.OLEDB.4.0"
  'oConn.Open "Libros"

  SQL = "DELETE *FROM users WHERE id_user=" & id_user 
  RecordsAffected=0
  oConn.Execute SQL, RecordsAffected

  If RecordsAffected > 0 then
          %>
		  <script language="javascript">
		  	mensaje_error('Has eliminiado este usuario correctamente')
		  </script>
		  <%
  Else
          Response.Write "<b>Se ha producido un error al borrar el registro</b>"
  End If

  oConn.Close 
  Set oRS = Nothing
  Set oConn = Nothing

end sub

sub eliminar_tweet(id_tweet)

Set oConn = Server.CreateObject("ADODB.Connection")
  oConn.Open "Data Source="& Server.MapPath("smallbird.mdb") &";Provider=Microsoft.Jet.OLEDB.4.0"
  'oConn.Open "Libros"

  SQL = "DELETE *FROM tweets WHERE id_tweet=" & id_tweet 
  RecordsAffected=0
  oConn.Execute SQL, RecordsAffected

  If RecordsAffected > 0 then
          %>
		  <script language="javascript">
		  	mensaje_error('Has eliminiado este SmallBird correctamente')
		  </script>
		  <%
		  Else
          Response.Write "<b>Se ha producido un error al borrar el registro</b>"
  End If

  oConn.Close 
  Set oRS = Nothing
  Set oConn = Nothing

end sub

sub modificar_user(id_user,nombre,pass,mail,url_foto,fecha,admin)

	'if usuario_existente(nombre)="true" then 
		%>
		<script language="javascript">
		//	mensaje_error("Este usuario ya existe, por favor introduzca un nombre de usuario que no este en la base de datos")
		</script>
		<%
	'else
	
		On Error Resume Next
		Set oConn = CreateObject("ADODB.Connection")
		oConn.Open "Data Source="& Server.MapPath("smallbird.mdb") &";Provider=Microsoft.Jet.OLEDB.4.0"
	
		SQL = "UPDATE users SET nombre_usuario ='"&nombre&"', mail = '"&mail&"',[password] ='"&pass&"',url_foto_perfil ='"&url_foto&"',fecha_registro ='"&fecha&"',admin ='"&admin&"' WHERE Id_user = "&id_user&""
		
		Set oRS = oConn.Execute(SQL)
		If Err.Description <> "" then
		Response.Write "<b>Error:" & Err.Description & "</b>"
		Else
		%>
		  <script language="javascript">
		  	mensaje_error('Has modificado este usuario correctamente')
		  </script>
		<%
		End If
				
				
		oConn.Close 
		Set oRS = Nothing
		Set oConn = Nothing
	
	'end if		
	
end sub

sub modificar_tweet(id_tweet,mensaje,fecha,privacidad)

		On Error Resume Next
		Set oConn = CreateObject("ADODB.Connection")
		oConn.Open "Data Source="& Server.MapPath("smallbird.mdb") &";Provider=Microsoft.Jet.OLEDB.4.0"
	
		SQL = "UPDATE tweets SET tweet ='"&mensaje&"',fecha ='"&fecha&"',privado ="&privacidad&" WHERE id_tweet = "&id_tweet&";"
		
		Set oRS = oConn.Execute(SQL)
		If Err.Description <> "" then
		Response.Write "<b>Error:" & Err.Description & "</b>"
		Else
		%>
		  <script language="javascript">
		  	mensaje_error('Has modificado este SmallBird correctamente')
		  </script>
		<%
		End If
				
				
		oConn.Close 
		Set oRS = Nothing
		Set oConn = Nothing

end sub

	if session("admin")<> 1 then
	
		call mensaje_error("Error","No tienes permiso para entrar aquí, este acceso sólo esta permitido para el administrado")
	else
		
		if request.QueryString("action")="delete" then
		
							
			if request.QueryString("t")="user" then
				
				'si se intenta eliminar un administrador así mismo, se le rechaza el acceso

					
				id_user1=session("id_user")&""
				id_user2=request.QueryString("val1")&""	
				
				if id_user1 <> id_user2 then
								
					call eliminar_user(request.QueryString("val1"))
				
				else
					%>
                    <script language="javascript">
						mensaje_error("No puedes eliminarte a tí mismo desde aquí, si quieres borrar tu cuenta de usuario se debe hacer desde el perfil personal");
					</script>
                    <%
				end if 
			end if
				
			
			
			if request.QueryString("t")="tweet" then
				
				call eliminar_tweet(request.QueryString("val1"))
				
			end if
						
		end if
		
		if request.QueryString("action")="modify" then
		
			if request.QueryString("t")="user" then
				
				id_user = request.QueryString("val1")
				nombre = request.QueryString("val2")
				pass = request.QueryString("val3")
				mail = request.QueryString("val4")
				url_foto = request.QueryString("val5")
				fecha = request.QueryString("val6")
				admin = request.QueryString("val7")
			
				call modificar_user(id_user,nombre,pass,mail,url_foto,fecha,admin)
			
			end if
			
			if request.QueryString("t")="tweet" then
			
				id_tweet = request.QueryString("val1")
				response.Write(id_tweet)
				mensaje = request.QueryString("val2")
				fecha = request.QueryString("val3")
				privacidad = request.QueryString("val4")
				
				call modificar_tweet(id_tweet,mensaje,fecha,privacidad)
				
			end if
			
		end if
		
	end if


%>
