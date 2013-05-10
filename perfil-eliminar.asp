
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
          Response.Write "<b>El registro se ha borrado correctamente.</b>"
  Else
          Response.Write "<b>Se ha producido un error al borrar el registro</b>"
  End If

  oConn.Close 
  Set oRS = Nothing
  Set oConn = Nothing

end sub

if request.form<>"" then

	call eliminar_user(request.Form("id_user"))
	Session.Contents.RemoveAll()
	Response.Redirect("default.asp")

else

response.Write("prohibido")

end if
%>
