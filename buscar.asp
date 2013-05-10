<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>


<!--#include file="includes/funciones.asp"-->


<%
sub mostrar_perfiles_busqueda(busqueda)

	  On Error Resume Next
	  Set oConn_t1 = CreateObject("ADODB.Connection")
	  oConn_t1.Open "Data Source="& Server.MapPath("smallbird.mdb") &";Provider=Microsoft.Jet.OLEDB.4.0"


	  SQL1 = "SELECT users.* FROM users WHERE (((users.nombre_usuario) Like "&Chr(34)&"%"&busqueda&"%"&Chr(34)&"));"
	   
	   Set oRS_t1 = oConn_t1.Execute(SQL1)
	  
	   If Err.Description <> "" then
  	   Response.Write "<b>Error:" & Err.Description & "</b>"
  	   Else
  	   
   	   End If
	  
	  Do Until oRS_t1.EOF

		call mostrar_perfil(oRS_t1("nombre_usuario"))


	  oRS_t1.MoveNext
	  Loop
	  
	 oConn_t1.Close
 	 Set oRS_t1 = Nothing
 	 Set oConn_t1 = Nothing


	
end sub

sub mostrar_tweets_busqueda(busqueda)

	On Error Resume Next
	  Set oConn_t1 = CreateObject("ADODB.Connection")
	  oConn_t1.Open "Data Source="& Server.MapPath("smallbird.mdb") &";Provider=Microsoft.Jet.OLEDB.4.0"
	
		SQL1= "SELECT users.nombre_usuario, users.url_foto_perfil, tweets.fecha,tweets.id_tweet, tweets.tweet,tweets.privado FROM users INNER JOIN tweets ON users.Id_user = tweets.id_user WHERE (((tweets.tweet) Like "&Chr(34)&"%"&busqueda&"%"&Chr(34)&")) ORDER BY tweets.Id_tweet DESC; "

	   Set oRS_t1 = oConn_t1.Execute(SQL1)
	  
	   If Err.Description <> "" then
  	   Response.Write "<b>Error:" & Err.Description & "</b>"
  	   Else
  	   
   	   End If
	  
	  Do Until oRS_t1.EOF

		tiempo  = oRS_t1("fecha") 
  		t_fecha = split(tiempo," ")
		
		
		mensaje = parsear_mensaje(oRS_t1("tweet"))
		 
		
		call plasmar_smallbird(oRS_t1("id_tweet"),oRS_t1("nombre_usuario"),oRS_t1("url_foto_perfil"),t_fecha(0),mensaje,oRS_t1("privado"))


	  oRS_t1.MoveNext
	  Loop
	  
	 oConn_t1.Close
 	 Set oRS_t1 = Nothing
 	 Set oConn_t1 = Nothing


end sub
%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Busqueda</title>
</head>
<body>

<!--#include file="includes/up.asp"-->

<div class="blogcomment">
 	<div class="blogwcommentwrap">  
    	<div align="center" class="contacttextarea">
      		<h4 style="float:left;padding-left:20px">
            <a href="default.asp">Inicio</a>
            &gt;
            <a href="buscar.asp">Buscar</a>
            </h4>
        </div>
    
	</div>
</div>

        
<div class="blogcomment">
 	<div class="blogwcommentwrap">   

     
     	<div align="center" class="contacttextarea">
        <h1 style="color:#000">Introduce lo que quieras buscar...</h1>
        </div>

        <div align="center" class="contacttextarea">
        	<form action="buscar.asp" method="post">
            	<input id="busqueda" class="contacttextform" name="busqueda" type="text" />
                <input type="submit" class="featured-titles"  />
            </form>
		</div>
        <span class="box-arrow"></span>
	</div>
</div>


        
		<%		
				
				if (Request.Form <> "") then
				
					busqueda = Request.Form("busqueda")
					
					call mostrar_perfiles_busqueda(busqueda)
					call mostrar_tweets_busqueda(busqueda)
					
				end if
		%>
        
<!--#include file="includes/down.asp"-->
</body>
</html>