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
         
  Else
          Response.Write "<b>Se ha producido un error al insertar el registro</b>"
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
<%
sub mostrar_tweets_siguiendo(tampag,pag,id_user)

On Error Resume Next
  Set oConn = CreateObject("ADODB.Connection")
  oConn.Open "Data Source="& Server.MapPath("smallbird.mdb") &";Provider=Microsoft.Jet.OLEDB.4.0"
  set oRS=Server.CreateObject("ADODB.recordset")
  
  SQL = "SELECT tweets.id_user, users.nombre_usuario, users.url_foto_perfil, tweets.fecha,tweets.id_tweet, tweets.tweet, tweets.privado FROM users INNER JOIN tweets ON users.Id_user = tweets.id_user WHERE (((tweets.id_user) In (SELECT siguiendo.id_user_siguiendo FROM siguiendo WHERE siguiendo.Id_user="&id_user&"))) ORDER BY tweets.Id_tweet DESC;" 
  
  
  	oRS.Open SQL,oConn,adOpenStatic, adCmdTable
	
	oRS.PageSize = tampag
	oRS.AbsolutePage = pag


  If Err.Description <> "" then
		response.redirect("nofollow.asp")
  Else
  End If
	
  reg = 0
	
  Do while reg < tamPag AND NOT oRS.EOF
  
  	tiempo  = oRS("fecha") 
  	t_fecha = split(tiempo," ")

	mensaje = parsear_mensaje(oRS("tweet"))

	call plasmar_smallbird(oRS("id_tweet"),oRS("nombre_usuario"),oRS("url_foto_perfil"),t_fecha(0),mensaje,oRS("privado"))
	
	reg = reg + 1

  oRS.MoveNext
  Loop
  
  i = 1
  %>
  <div class="pagination">
  <ul>
  <%
  Do while i<=oRS.PageCount
  
  if i&"" = pag then
  	estilo="blackcurveactive"
  else
  	estilo="blackcurve"
  end if
  
  %>
  <li><a href="default.asp?pag=<%Response.Write(i)%>" title="<%Response.Write(i)%>" class="<%response.Write(estilo)%>"> <%Response.Write(i)%> </a></li>
  
  <%
  
  i = i+1
  
  loop 
  %>
  </ul>
  </div>
  <%
  oConn.Close
  oRS.Close
  Set oRS = Nothing
  Set oConn = Nothing


end sub



sub pagina_inicial()
	%>
<div class="blogcomment">
 	<div class="blogwcommentwrap">  
		<div align="center" class="contacttextarea">
        <h1 style="color:#000">¿Qué es SmallBird?</h1>
        <p style="text-align:justify; font-size:18px;padding-left:50px;padding-right:50px;padding-top:20px;padding-bottom:20px">SmallBird es una red social de Microbloggin, podrás escribir mensajes cortos de hasta 200 caracteres, los cuales seran leidos por tus seguidores más fervientes, a la vez tu podrás seguir a las personas que más te interese. Comparte contenido de calidad, consigue feedback, con SmallBird todo es posible.</p>
        </div>
        
        
        <div align="center" class="contacttextarea">
        <img src="images/inicio1.jpg" />
        	               
		</div>
        
        <div align="center" class="contacttextarea">
        <h1 style="color:#000">¿Cómo puedo usar SmallBird?</h1>
        <p style="text-align:justify; font-size:18px;padding-left:50px;padding-right:50px;padding-top:20px;padding-bottom:20px">El uso de SmallBird es muy sencillo, tan solo tienes que <a href="registro.asp">registrarte desde aquí</a>, una vez hecho esto podrás empezar a escribir tantos SmallBirds como quieras. <a href="buscar.asp">Encuentra lo que Buscas</a>, <a href="ultimos_users.asp">Sigue a personas conocidas</a> o mira los <a href="ultimos_smallbirds.asp">últimos SmallBirds enviados</a>.</p>
        </div>
    <span class="box-arrow"></span>
	</div>
</div>
   
        
	<%
end sub
%>





<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>SmallBirds</title>
</head>
<body>

<!--#include file="includes/up.asp"-->

<div class="blogcomment">
 	<div class="blogwcommentwrap">  
    	<div align="center" class="contacttextarea">
      		<h4 style="float:left;padding-left:20px">
            <a href="default.asp">Inicio</a>
        </div>
    
	</div>
</div>
        
		<%
			if session("estado") = "true" then	
				
			
			
				if Request.Form <> "" then
				
				
				 	if Request.Form("privado") <> "" then
        
            			privado = 1
        
        			else
        
            			privado = 0
       				
					end if
					
					call enviar_tweet(Session("id_user"),Request.Form("texto"),privado)
	
				end if
			
				if (Request.QueryString("pag") = "")  then
					call mostrar_tweets_siguiendo(15,1,session("id_user"))
				else
					call mostrar_tweets_siguiendo(15,Request.QueryString("pag"),session("id_user"))
				end if
			else
				call pagina_inicial()
			end if
		%>
        
      <br />
<iframe name="seguir" style="height: 1px; border:0" src="" width="0%">  
</iframe>
        
<!--#include file="includes/down.asp"-->
</body>
</html>