<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="estilos/style.css" />
<title>Login</title>
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
             <a href="login.asp">Login</a>
            </h4>
        </div>
    
	</div>
</div>
<%


  On Error Resume Next
  Set oConn_log = CreateObject("ADODB.Connection")
  oConn_log.Open "Data Source="& Server.MapPath("smallbird.mdb") &";Provider=Microsoft.Jet.OLEDB.4.0"
  


  
  
	SQLLOG = "  SELECT users.* FROM users WHERE (((users.nombre_usuario)="&Chr(39)&Request.Form("usuario_login")&Chr(39)&"));"



  
  Set oRS_log = oConn_log.Execute(SQLLOG)

  If Err.Description <> "" then
  Response.Write "<b>Error:" & Err.Description & "</b>"
  Else
  End If
  
  Do Until oRS_log.EOF
  
  	Session("id_user") = oRS_log("id_user")
	Session("nombre_usuario") = oRS_log("nombre_usuario")
	Session("password") = oRS_log("password")
	Session("mail") = oRS_log("mail")
	Session("url_foto_perfil") = oRS_log("url_foto_perfil")
	Session("admin") = oRS_log("admin")
	Session("estado") = "true"
   
  oRS_log.MoveNext
  Loop
  oConn_log.Close
  Set oRS_log = Nothing
  Set oConn_log = Nothing
  
  
	
	pass1 = Request.Form("password_login")
	pass2 = Session("password")
	
if pass1 = pass2 then
Response.Redirect("default.asp")

else
Session("estado") = "false"
Session.Contents.RemoveAll()
call mensaje_error("ERROR","El usuario o la contraseña no coinciden")

end if

%>


<!--#include file="includes/down.asp"-->

</body>
</html>
