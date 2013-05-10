
<!--------------------------------------------------------------------------------------------------

Función seguir(user,seguidor)

inserta en el campo correspondiente de la base de datos un item que dice a quien sigue.
--------------------------------------------------------------------------------------------------->

<%
Function seguir(id_user,id_seguidor)

  Set oConn = Server.CreateObject("ADODB.Connection")
  oConn.Open "Data Source="& Server.MapPath("smallbird.mdb") &";Provider=Microsoft.Jet.OLEDB.4.0"
  
  SQL1 = "INSERT INTO siguiendo (id_user, id_user_siguiendo) VALUES ('"&id_user&"','"&id_seguidor&"');" 
  SQL2 = "INSERT INTO seguidores (id_user, id_user_seguidor) VALUES ('"&id_seguidor&"','"&id_user&"');" 
  
  
  RecordsAffected=0
  oConn.Execute SQL1, RecordsAffected
 
  If RecordsAffected > 0 then
        seguir = "true" 
  Else
        Response.Write "<b>Se ha producido un error al insertar el registro</b>"
  		seguir = "false"
  End If
  
  RecordsAffected=0
  oConn.Execute SQL2, RecordsAffected
 
  If RecordsAffected > 0 then
         seguir = "true"
  Else
          Response.Write "<b>Se ha producido un error al insertar el registro</b>"
		  seguir = "false"
  End If

  oConn.Close 
  Set oRS = Nothing
  Set oConn = Nothing



end function
%>



<!--#include file="includes/funciones.asp"-->

<%
if session("estado") = "true" then
	if seguir(session("id_user"),Request.QueryString("id_user")) = "false" then 
	call mensaje_error("Error", "No has podido sequir a esta persona debido a un error en la BD")	
	end if

else
call mensaje_error("Error", "Debes iniciar sesión")	
end if	

%>

</body>
</html>
