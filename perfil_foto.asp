<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Foto Perfil</title>
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
            <a href="perfil.asp">Perfil [<b style="color:#F90"><%=session("nombre_usuario")%></b>]</a>
            &gt;
            <a href="perfil_foto.asp">Cambiar Foto</a>
            </h4>
        </div>
    
	</div>
</div>
        
		<%
            if session("estado") = "true" then
			
           		%>
                <!--#include file="includes/mod_perfil_personal_foto.asp"-->
                <%
            else
            call mensaje_error("ERROR", "No puedes acceder a tu perfil personal, debes loguearte primero")
            end if
        %>
        
<!--#include file="includes/down.asp"-->
</body>
</html>