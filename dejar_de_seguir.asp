

<!--#include file="includes/funciones.asp"-->

<%
Function dejar_seguir(id_user,id_seguidor)



  Set oConn = Server.CreateObject("ADODB.Connection")
  oConn.Open "Data Source="& Server.MapPath("smallbird.mdb") &";Provider=Microsoft.Jet.OLEDB.4.0"
  
  SQL1 = "DELETE *FROM siguiendo WHERE (((siguiendo.Id_user)="&id_user&") AND ((siguiendo.id_user_siguiendo)="&id_seguidor&"));"
  SQL2 = "DELETE *FROM seguidores WHERE (((seguidores.Id_user)="&id_seguidor&") AND ((seguidores.id_user_seguidor)="&id_user&"));"
  
  
  RecordsAffected=0
  oConn.Execute SQL1, RecordsAffected
 
  If RecordsAffected > 0 then
        dejar_seguir = "true" 
  Else
        Response.Write "<b>Se ha producido un error al insertar el registro</b>"
  		dejar_seguir = "false"
  End If
  
  RecordsAffected=0
  oConn.Execute SQL2, RecordsAffected
 
  If RecordsAffected > 0 then
         dejar_seguir = "true"
  Else
          Response.Write "<b>Se ha producido un error al insertar el registro</b>"
		  dejar_seguir = "false"
  End If

  oConn.Close 
  Set oRS = Nothing
  Set oConn = Nothing



end function
%>




<%
if session("estado") = "true" then
	if dejar_seguir(session("id_user"),Request.QueryString("id_user")) = "false" then 
	call mensaje_error("Error", "No has podido sequir a esta persona debido a un error en la BD")	
	end if

else
call mensaje_error("Error", "Debes iniciar sesión")	
end if	

%>

</body>
</html>
