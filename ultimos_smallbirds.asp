<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<!--------------------------------------------------------------------------------------------------

Función mostrar_tweet(n_tweet_inicio,n_tweet_final)

n_tweet_inicio = muestra el tweet número n 
n_tweet_final  = hasta el tweet número n 


--------------------------------------------------------------------------------------------------->
<!--#include file="includes/funciones.asp"-->
<%
   
 sub mostrar_tweets(tampag,pag)

  On Error Resume Next
  Set oConn = CreateObject("ADODB.Connection")
  oConn.Open "Data Source="& Server.MapPath("smallbird.mdb") &";Provider=Microsoft.Jet.OLEDB.4.0"
  set oRS=Server.CreateObject("ADODB.recordset")
  
  SQL = "SELECT users.nombre_usuario, tweets.tweet, tweets.privado, tweets.fecha, tweets.id_tweet, users.url_foto_perfil FROM users INNER JOIN tweets ON users.Id_user = tweets.id_user ORDER BY tweets.id_tweet DESC;"

  
  
  	oRS.Open SQL,oConn,adOpenStatic, adCmdTable
	
	oRS.PageSize = tampag
	oRS.AbsolutePage = pag

 	If Err.Description <> "" then
  	Response.Write "<b>Error:" & Err.Description & "</b>"
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
  <li><a href="ultimos_smallbirds.asp?pag=<%Response.Write(i)%>" title="<%Response.Write(i)%>" class="<%response.Write(estilo)%>"> <%Response.Write(i)%> </a></li>
  
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
   
  %>



<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Últimos SmallBirds</title>
</head>
<body>

<!--#include file="includes/up.asp"-->

<div class="blogcomment">
 	<div class="blogwcommentwrap">  
    	<div align="center" class="contacttextarea">
      		<h4 style="float:left;padding-left:20px">
            <a href="default.asp">Inicio</a>
            &gt;
            <a href="ultimos_smallbirds.asp">Últimos SmallBirds Enviados</a>
            </h4>
        </div>
    
	</div>
</div>

        
		<%

			if (Request.QueryString("pag") = "")  then
				call mostrar_tweets(15,1)
			else
				call mostrar_tweets(15,Request.QueryString("pag"))
			end if
		%>

<iframe name="seguir" style="height: 1px; border:0" src="" width="0%">  
</iframe>
        
<!--#include file="includes/down.asp"-->
</body>
</html>