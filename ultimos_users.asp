<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<!--#include file="includes/funciones.asp"-->

<!--------------------------------------------------------------------------------------------------

Función mostrar_ultimos_perfiles()
miestra los ultimos perfiles
--------------------------------------------------------------------------------------------------->

<%
sub mostrar_ultimos_perfiles(tampag,pag)
 
  On Error Resume Next
  Set oConn3 = CreateObject("ADODB.Connection")
  oConn3.Open "Data Source="& Server.MapPath("smallbird.mdb") &";Provider=Microsoft.Jet.OLEDB.4.0"
  set oRS3=Server.CreateObject("ADODB.recordset")
  
  SQL3 ="SELECT users.nombre_usuario FROM users ORDER BY users.Id_user DESC;"
  
  
  	oRS3.Open SQL3,oConn3,adOpenStatic, adCmdTable
	
	oRS3.PageSize = tampag
	oRS3.AbsolutePage = pag



  If Err.Description <> "" then
  Response.Write "<b>Error:" & Err.Description & "</b>"
  Else
  End If
	
  reg = 0
	
  Do while reg < tamPag AND NOT oRS3.EOF
  
  	call mostrar_perfil(oRS3("nombre_usuario"))
	
	reg = reg + 1
	
  oRS3.MoveNext
  Loop
  
  i = 1
  %>
    <div class="pagination">
  <ul>
  <%
  Do while i<=oRS3.PageCount
  
  if i&"" = pag then
  	estilo="blackcurveactive"
  else
  	estilo="blackcurve"
  end if
  
  %>
  <li><a href="ultimos_users.asp?pag=<%Response.Write(i)%>" title="<%Response.Write(i)%>" class="<%response.Write(estilo)%>"> <%Response.Write(i)%> </a></li>
  
  <%
  
  i = i+1
  
  loop 
  %>
  </ul>
  </div>
  <%
  oConn3.Close
  oRS3.Close
  Set oRS3 = Nothing
  Set oConn3 = Nothing

end sub
%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Últimos Usuarios Registrados</title>
</head>
<body>

<!--#include file="includes/up.asp"-->

<div class="blogcomment">
 	<div class="blogwcommentwrap">  
    	<div align="center" class="contacttextarea">
      		<h4 style="float:left;padding-left:20px">
            <a href="default.asp">Inicio</a>
            &gt;
            <a href="ultimos_users.asp">Últimos Usuarios Registrados</a>
            </h4>
        </div>
    
	</div>
</div>

        
		<%

	if (Request.QueryString("pag") = "")  then
		call mostrar_ultimos_perfiles(10,1)
	else
		call mostrar_ultimos_perfiles(10,Request.QueryString("pag"))
	end if
		%>
<iframe name="seguir" style="height: 1px; border:0" src="" width="0%">  
</iframe>
        
<!--#include file="includes/down.asp"-->
</body>
</html>