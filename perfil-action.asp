<script language="javascript" type="text/javascript">
	function mensaje_error(mensaje){
		alert(mensaje);
	}

</script>
<!--#include file="includes/funciones.asp"-->
<%
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
		 	mensaje_error("Este Smallbird ha sido borrado correctamente")
		 </script>
		 <%
  Else
          Response.Write "<b>Se ha producido un error al borrar el registro</b>"
  End If

  oConn.Close 
  Set oRS = Nothing
  Set oConn = Nothing

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
			mensaje_error('Has modificado correctamente el SmallBird')
		</script>
		<%
		End If
				
				
		oConn.Close 
		Set oRS = Nothing
		Set oConn = Nothing

end sub



if session("nombre_usuario") <> request.QueryString("nombre_usuario") then


	
		call mensaje_error("Error","No tienes permiso para entrar aquí, este acceso sólo esta permitido para el administrado")
	else
		
		if request.QueryString("action")="delete" then
		
				call eliminar_tweet(request.QueryString("val1"))
						
		end if
		
		if request.QueryString("action")="modify" then
		
				id_tweet = request.QueryString("val1")
				mensaje = request.QueryString("val2")
				fecha = request.QueryString("val3")
				privacidad = request.QueryString("val4")
				
				call modificar_tweet(id_tweet,mensaje,fecha,privacidad)
					
		end if
		
end if
%>
