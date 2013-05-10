<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>


<!--#include file="includes/funciones.asp"-->

<!--------------------------------------------------------------------------------------------------

Función enviar_tweet(id_user,tweet,privado)

inserta en la tabla tweets una nueva fila con todos los campos necesarios.

id_user = id del usuario que ha enviado el tweet
tweet = mensaje que ha escrito el usuario
privado = indica si el mensaje solo lo puede leer la gente que sigue o si lo puede leer todo el mundo, es decir si es 1 es privado y si es 0 es público.


--------------------------------------------------------------------------------------------------->

  
  <%
  
  sub enviar_tweet(id_user,tweet,privado)
  
  	FechaHoraActual = obtener_fechahora_actual()
	
	
  'le damos formato al tweet, incluyendo enlaces y demás
  
  
  
   
   Set oConn = Server.CreateObject("ADODB.Connection")
  oConn.Open "Data Source="& Server.MapPath("smallbird.mdb") &";Provider=Microsoft.Jet.OLEDB.4.0"
  
  SQL = "INSERT INTO tweets (id_user, tweet,[fecha],privado) VALUES ('"&id_user&"','"&tweet&"',#"&FechaHoraActual&"#,'"&privado&"');" 
  
  RecordsAffected=0
  oConn.Execute SQL, RecordsAffected
  
  
  

  If RecordsAffected > 0 then
  
  %>
  
  <div class="blogcomment">
 	<div class="blogwcommentwrap">  
		<div align="center" class="contacttextarea">
        <h1 style="color:#000">Has Enviado Correctamente su Re-SmallBird</h1>
        <p style="text-align:justify; font-size:18px;padding-left:50px;padding-right:50px;padding-top:20px;padding-bottom:20px"><a href="default.asp">Volver a la Página Inicial</a></p>
        </div>
        
        <span class="box-arrow"></span>
	</div>
</div>
  
  <%
         
  Else
          call mensaje_error("error","Se ha producido un error al intentar insertar tu smallbird en la base de datos, por favor vuelva a intentarlo mas tarde.")
  End If

  oConn.Close 
  Set oRS = Nothing
  Set oConn = Nothing
 
  end sub 
  
  %>
  
  <!--------------------------------------------------------------------------------------------------

Función mostrar_tweets_siguiendo(15,Session("nombre_usuario"))
miestra los ultimos perfiles
--------------------------------------------------------------------------------------------------->


<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>RE-SmallBirds</title>
</head>
<body>

<!--#include file="includes/up.asp"-->

<div class="blogcomment">
 	<div class="blogwcommentwrap">  
    	<div align="center" class="contacttextarea">
      		<h4 style="float:left;padding-left:20px">
            <a href="default.asp">Inicio</a>
            &gt;
            <a href="re-smallbird.asp">Re-SmallBird</a>
            </h4>
        </div>
    
	</div>
</div>
        
		<%
			if session("estado") = "true" then	
				
			
			
				if Request.QueryString("smallbird") <> "" then
				
				
				 	call enviar_tweet(Session("id_user"),Request.QueryString("smallbird"),0)
	
				end if
				
			else
				call mensaje_error("Error","Debes estar logueado")
			end if
		%>
        
<!--#include file="includes/down.asp"-->
</body>
</html>