<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<!--#include file="includes/funciones.asp"-->

<!------------------------------------------------------------------------------------
Función mostrar_perfiles_siguiendo(user)

nos devuelve una lista con los perfiles de los usuarios 

-------------------------------------------------------------------------------------->

<%
 
sub mostrar_perfiles_siguiendo(user)  
 
On Error Resume Next
  Set oConn1 = CreateObject("ADODB.Connection")
  oConn1.Open "Data Source="& Server.MapPath("smallbird.mdb") &";Provider=Microsoft.Jet.OLEDB.4.0"
  
  SQL1 = " SELECT siguiendo.id_user_siguiendo FROM users INNER JOIN siguiendo ON users.Id_user = siguiendo.Id_user WHERE (((users.nombre_usuario)="&Chr(39)&user&Chr(39)&"));"  

  Set oRSx1 = oConn1.Execute(SQL1)
  If Err.Description <> "" then
  Response.Write "<b>Error:" & Err.Description & "</b>"
  Else
  End If
  
  Do Until oRSx1.EOF
  
 	 SQL2 = "SELECT users.Id_user, users.nombre_usuario FROM users WHERE (((users.Id_user)="& oRSx1("id_user_siguiendo")&")); "
	 
	  	Set oRSx2 = oConn1.Execute(SQL2)
		If Err.Description <> "" then
		Response.Write "<b>Error:" & Err.Description & "</b>"
		Else
		End If
		  
		Do Until oRSx2.EOF
		
		call mostrar_perfil(oRSx2("nombre_usuario"))
				
	    oRSx2.MoveNext
		Loop	
    
  oRSx1.MoveNext
  Loop
  
  oConn1.Close
  Set oRSx1 = Nothing
  Set oRSx2 = Nothing
  Set oConn1 = Nothing
  
  end sub
%>



<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Busqueda Cuentas que Sigues</title>
</head>
<body>

<!--#include file="includes/up.asp"-->

<div class="blogcomment">
 	<div class="blogwcommentwrap">  
    	<div align="center" class="contacttextarea">
      		<h4 style="float:left;padding-left:20px">
            <a href="default.asp">Inicio</a>
            &gt;
            <a href="buscar_siguiendos_user.asp?nombre_usuario=<%=Request.QueryString("nombre_usuario")%>">Personas que sigue <b style="color:#F90"><%=Request.QueryString("nombre_usuario")%></b></a>
            </h4>
        </div>
    
	</div>
</div>

        
		<%
            if usuario_existente(Request.QueryString("nombre_usuario")) = "true" then
            call mostrar_perfiles_siguiendo(Request.QueryString("nombre_usuario"))
            else
            call mensaje_error("ERROR", "No existe ningun usuario con este nombre")
            end if
        %>
        
        <br />
<iframe name="seguir" style="height: 1px; border:0" src="" width="0%">  
</iframe>
        
<!--#include file="includes/down.asp"-->
</body>
</html>