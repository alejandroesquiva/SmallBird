<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<!--#include file="includes/funciones.asp"-->
<%
sub mostrar_mensaje_nofollow()
	%>
<div class="blogcomment">
 	<div class="blogwcommentwrap">  
		<div align="center" class="contacttextarea">
        <h1 style="color:#000">¿No sigues a nadie?, Empieza a seguir a estas personas</h1>
        </div>
        <div align="center" class="contacttextarea">
        <a class="featured-titles" href="ultimos_users.asp">Últimos Users Resgistrados</a>
        </div>
     	 
		 <%call mostrar_imagenes_perfiles()%>
		 
    <span class="box-arrow"></span>
	</div>
</div>
   
        
	<%
end sub

sub mostrar_imagenes_perfiles()
	
	Set oConn_ult = Server.CreateObject("ADODB.Connection")
		  oConn_ult.Open "Data Source="& Server.MapPath("smallbird.mdb") &";Provider=Microsoft.Jet.OLEDB.4.0"
		  
		  SQL = "SELECT TOP 100 users.nombre_usuario, users.url_foto_perfil FROM users ORDER BY users.id_user DESC;"  

		  Set oRS = oConn_ult.Execute(SQL)
		  If Err.Description <> "" then
		  Response.Write "<b>Error:" & Err.Description & "</b>"
		  Else
		  End If
		  %>
          <div align="center" class="contacttextarea">
          <%
		  	  
		  Do Until oRS.EOF
		  	
			
			%>
             <a class="ff" href="buscar_perfil_usuario.asp?nombre_usuario=<% Response.Write(oRS("nombre_usuario")) %>"><img title="<% Response.Write(oRS("nombre_usuario")) %>" alt="<% Response.Write(oRS("nombre_usuario")) %>" src="<% = oRS("url_foto_perfil") %>" style="width:80px; height:auto" /></a>
           <%
		  oRS.MoveNext
		  Loop
		  
		  oConn_ult.Close
		  Set oRS = Nothing
		  Set oConn_ult = Nothing
		%>
		</div>
		<%
	
end sub

%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Sugeridos</title>
</head>
<body>

<!--#include file="includes/up.asp"-->
<div class="blogcomment">
 	<div class="blogwcommentwrap">  
    	<div align="center" class="contacttextarea">
      		<h4 style="float:left;padding-left:20px">
            <a href="default.asp">Inicio</a>
            &gt;
            <a href="nofollow.asp">Sugeridos</a>
            </h4>
        </div>
    
	</div>
</div>
        
		<%
			if session("estado") = "true" then	
				
				call mostrar_mensaje_nofollow()
				
			else
				call mensaje_error("Error","no tienes permiso para ver esta página")
			end if
		%>
        
<!--#include file="includes/down.asp"-->
</body>
</html>