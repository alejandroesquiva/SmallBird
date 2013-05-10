<!--#include file="ADOVBS.INC"-->
<script language="JavaScript" SRC="includes/funciones.js"></script>

<!--------------------------------------------------------------------------------------------------

Función plasmar_smallbird(user,url,fecha,mensaje)

n_tweet_inicio = muestra el tweet número n 
n_tweet_final  = hasta el tweet número n 


--------------------------------------------------------------------------------------------------->
<%
sub plasmar_smallbird(id_tweet,user,url,fecha,mensaje,privado)
if privado = 0 then
%>
  <div id="id_tweet_<%Response.Write(user) %>" class="blogcomment">
            
           	  <div class="blogwcommentwrap">
                
                	<div class="commenttitle">
                    
                    	<p><span class="avatarname">
                        	<a href="buscar_perfil_usuario.asp?nombre_usuario=<% Response.Write(user) %>"><%Response.Write(user) %></a>
                            </span>
                            <span class="avatardate">On: <span class="avatardateorange"><%Response.Write(fecha)%></span>
                            </span><span class="avatarreply"><a href="re-smallbird.asp?smallbird=<% Response.Write(mensaje) %>" title="reply">Re-Smallbird</a></span></p>
                    
                  </div>
                    
                    <div class="commentuser"><a href="buscar_perfil_usuario.asp?nombre_usuario=<% Response.Write(user) %>"><img class="perfil" src="<%Response.Write(url)%>" width="70" height="70" /></a></div>
                    
                    <div class="commenttext">
                    
                    <p>
                    
                    <table border="0">
                        <tr>
                            <td><% Response.Write(mensaje) %></td>
                        </tr>
                        <tr>
                        	<td>                
                            <a class="twitter" target="_blank" href="https://twitter.com/intent/tweet?text=<% Response.Write(mensaje) %>"><img id="twitter" class="twitter" src="estilos/images/small-twitter.png" width="22" height="22"/></a> 
                            </td>
                        </tr>
                    </table>
                    
                    </p>                 
                    </div>
                    
                   <div align="center" class="contacttextarea">
					<%
                        if Session("admin")= 1 then
                            %>
                            <input class="featured-titles" style="background:#F00;color:#000" id="in_elim_tweet_<%Response.Write(id_user)%>" value="eliminar SmallBird" type="button" onclick="eliminar_smallbird_validar('<%Response.Write(id_tweet)%>')"/></a>
                            <%
                        end if
                    %>
                    
                  </div>
                    
                    <span class="box-arrow"></span>
                
                </div>
                
                </div>
<%
end if
end sub
%>


<!--------------------------------------------------------------------------------------------------

Función mostrar_perfil(nombre_usuario)

mostrar en un formato estilo tweet el perfil con toda la informacion del usuario


------------s--------------------------------------------------------------------------------------->
<%
   
 sub mostrar_perfil(nombre_usuario)
	
	
  On Error Resume Next
  Set oConn = CreateObject("ADODB.Connection")
  oConn.Open "Data Source="& Server.MapPath("smallbird.mdb") &";Provider=Microsoft.Jet.OLEDB.4.0"
  
  SQL1 = "SELECT Count(tweets.id_user) AS numero_tweets FROM users INNER JOIN tweets ON users.Id_user = tweets.id_user GROUP BY users.nombre_usuario HAVING (((users.nombre_usuario)="&Chr(39)&nombre_usuario&Chr(39)&")); "
  
  SQL2 = "SELECT Count (siguiendo.Id_user) AS cuenta_siguiendo FROM users INNER JOIN siguiendo ON users.Id_user = siguiendo.Id_user WHERE (((users.nombre_usuario)="&Chr(39)&nombre_usuario&Chr(39)&"));"
  
  SQL3 = "SELECT Count(seguidores.Id_user) AS cuenta_seguidores FROM users INNER JOIN seguidores ON users.Id_user = seguidores.Id_user WHERE (((users.nombre_usuario)="&Chr(39)&nombre_usuario&Chr(39)&")); "
  
  SQL4 = " SELECT users.id_user,users.nombre_usuario, users.mail, users.url_foto_perfil, users.fecha_registro FROM users WHERE (((users.nombre_usuario)="&Chr(39)&nombre_usuario&Chr(39)&"));" 
    
  Set oRS = oConn.Execute(SQL1)
  If Err.Description <> "" then
  Response.Write "<b>Error:" & Err.Description & "</b>"
  Else
  End If
  Do Until oRS.EOF
  
  num_tweets = oRS("numero_tweets")
    
  oRS.MoveNext
  Loop
  
  Set oRS = oConn.Execute(SQL2)
  If Err.Description <> "" then
  Response.Write "<b>Error:" & Err.Description & "</b>"
  Else
  End If
  Do Until oRS.EOF
  
  num_siguiendo = oRS("cuenta_siguiendo")
    
  oRS.MoveNext
  Loop
  
  Set oRS = oConn.Execute(SQL3)
  If Err.Description <> "" then
  Response.Write "<b>Error:" & Err.Description & "</b>"
  Else
  End If
    
  Do Until oRS.EOF
  
  num_seguidores = oRS("cuenta_seguidores")
    
  oRS.MoveNext
  Loop
  
  Set oRS = oConn.Execute(SQL4)
  If Err.Description <> "" then
  Response.Write "<b>Error:" & Err.Description & "</b>"
  Else
  End If
  Do Until oRS.EOF
  
  id_user = oRS("id_user")
  user = oRS("nombre_usuario")
  url_foto = oRS("url_foto_perfil")
  mail = oRS("mail")
  fech_reg = oRS("fecha_registro")
    
  oRS.MoveNext
  Loop
  
  if session("estado") = "true" then
  			
			SQL5 = "  SELECT siguiendo.Id_user, siguiendo.id_user_siguiendo FROM siguiendo WHERE (((siguiendo.Id_user)="&session("id_user")&") AND ((siguiendo.id_user_siguiendo)="&id_user&"));"
		  
		  	Set oRS = oConn.Execute(SQL5)
		  	If Err.Description <> "" then
		  	Response.Write "<b>Error:" & Err.Description & "</b>"
		  	Else
		  	End If
		  	Do Until oRS.EOF
		  
		  	if(session("id_user") = oRS("id_user") ) then 
		  	is_seguido = "true"
			else
			is_seguido = "false"
		  	end if
			
		  	oRS.MoveNext
		  	Loop
  
  end if
 
  
  oConn.Close
  Set oRS = Nothing
  Set oConn = Nothing
  
  if num_tweets = "" then
  	num_tweets = "0"
  end if 
  
  if num_seguidores = "" then
  	num_seguidores = "0"
  end if 
  
  if num_siguiendo = "" then
  	num_siguiendo = "0"
  end if 
  	
	

%>




<div id="id_perfil_<% Response.Write(user) %>" class="blogcomment">
 	<div class="blogwcommentwrap">   

     
     	<div align="center" class="contacttextarea">
        <h1><a href="buscar_perfil_usuario.asp?nombre_usuario=<% Response.Write(user) %>"><% Response.Write(user) %></a></h1>
        </div>

        <div align="center" class="contacttextarea">
        	<a href="buscar_perfil_usuario.asp?nombre_usuario=<% Response.Write(user) %>"><img style="width:200px; height:auto" src="<%Response.Write(url_foto)%>" width="72" height="72" /></a>
		</div>

     
	    <div align="center" class="contacttextarea">
     
    	<table align="center" width="50%" border="0">
	            
    		<tr>
  				<%if num_tweets = "0" then 
	
					%><td align="center"><h3><%Response.Write("SmallBirds")%></h3></td><%
	
    			else
				%>
    				  <td align="center"><h3><a href="buscar_perfil_usuario.asp?nombre_usuario=<% Response.Write(user) %>">SmallBirds</a></h3></td>
				<%
                end if
                %>
                
                <%if num_seguidores = "0" then 
                
                    %><td align="center"><h3><%Response.Write("Seguidores")%></h3></td><%
                
                else
                %>
                    <td align="center"><h3><a href="buscar_seguidores_user.asp?nombre_usuario=<% Response.Write(user) %>">Seguidores</a></h3></td>
                <%
                end if
                %>
                
                <%if num_siguiendo = "0" then 
                
                    %><td align="center"><h3><%Response.Write("Siguiendo")%></h3></td><%
                
                else
                %>
                    <td align="center"><h3><a href="buscar_siguiendos_user.asp?nombre_usuario=<% Response.Write(user) %>">Siguiendo</a></h3></td>
                 
                <%
                end if
                %> 
                  
                </tr>
                <tr>
                <%if num_tweets = "0" then 
                
                    %><td align="center"><%Response.Write(num_tweets)%></td><%
                
                else
                %>
                    <td align="center"><h3><a href="buscar_perfil_usuario.asp?nombre_usuario=<% Response.Write(user) %>"><%Response.Write(num_tweets)%></a></h3></td>
                <%
                end if
                %>
                
                <%if num_seguidores = "0" then 
                
                    %><td align="center"><h3><%Response.Write(num_seguidores)%></h3></td><%
                
                else
                %>
                    <td align="center"><h3><a href="buscar_seguidores_user.asp?nombre_usuario=<% Response.Write(user) %>"><%Response.Write(num_seguidores)%></a></h3></td>
            
                <%
                end if
                %>
                
                <%if num_siguiendo = "0" then 
                
                    %><td align="center"><h3><%Response.Write(num_siguiendo)%></h3></td><%
                
                else
                %>
                    <td align="center"><h3><a href="buscar_siguiendos_user.asp?nombre_usuario=<% Response.Write(user) %>"><%Response.Write(num_siguiendo)%></a></h3></td>
            
                <%
                end if
                %>
                
                </tr>
         </table>
                  
      </div>
      
      
      <div align="center" class="contacttextarea">
        	
            <%
			if session("estado") = "" OR session("id_user")= id_user then 
			
			else
				if is_seguido = "true" then
			%>	
				<input class="featured-titles" id="in_<%Response.Write(id_user)%>" class="bt" value="Dejar de Seguir" type="button" onclick="cambiar_boton('<%Response.Write(id_user)%>')"/></a>
			<%	
				else
			%>
            	<input class="featured-titles" id="in_<%Response.Write(id_user)%>" class="bt" value="Seguir" type="button" onclick="cambiar_boton('<%Response.Write(id_user)%>')"/></a>
			<%
            	end if 
			
			end if
			
			%>
          
      </div>
      
      <div align="center" class="contacttextarea">
      	<%
        	if Session("admin")= 1 then
				%>
				<input class="featured-titles" style="background:#F00;color:#000" id="in_elim_<%Response.Write(id_user)%>" value="eliminar Usuario" type="button" onclick="eliminar_user_validar('<%Response.Write(id_user)%>')"/></a>
				<%
			end if
        %>
        
      </div>

   
        <span class="box-arrow"></span>
	</div>
</div>




<%








end sub
%>        
<!---         
<a href="javascript: void(0);" onclick="window.open ('http://www.facebook.com/sharer.php?t=title of the article/post/whatever', 'Facebook', 'toolbar=0, status=0, width=550, height=350');"> <img src="estilos/facebook.png" alt="Compartir en Facebook" hspace="8" vspace="5" border="0" /></a>
--->
 
 
  
  
  <!--------------------------------------------------------------------------------------------------

Función mensaje_error(cabecera,mensaje)

inserta un mensaje de error en la pantalla pricipal

mensaje = es el mensaje de error


--------------------------------------------------------------------------------------------------->
<%
sub mensaje_error(cabecera,mensaje)
%>


 <div class="blogcomment">
            
           	  <div class="blogwcommentwrap">
                
                	<div class="commenttitle">
                    
                    	<p><span class="avatarname">
                        	<% Response.Write(cabecera) %>
                            </span>
                                                
                  </div>
                    
                    <div class="commentuser"><img class="perfil" src="estilos/images/error.png" width="70" height="70" />
                    </div>
                    
                    <div class="commenttext">
                    
                    <p>
                   <% Response.Write(mensaje) %>                    
                    </p>                 
                    </div>
                    <span class="box-arrow"></span>
                
                </div>
                
                </div>




<%  
end sub 

%>

<!--------------------------------------------------------------------------------------------------

Función usuario_existente(user)

comprubea si existe el usuario en la base de datos

--------------------------------------------------------------------------------------------------->


<%



function usuario_existente(user) 

On Error Resume Next
  Set oConn = CreateObject("ADODB.Connection")
  oConn.Open "Data Source="& Server.MapPath("smallbird.mdb") &";Provider=Microsoft.Jet.OLEDB.4.0"
  
  SQL = "SELECT users.nombre_usuario FROM users WHERE (((users.nombre_usuario)="&Chr(39)&user&Chr(39)&"));"


  
  Set oRS = oConn.Execute(SQL)

  If Err.Description <> "" then
  Response.Write "<b>Error:" & Err.Description & "</b>"
  Else
  End If
    
%>
<!--

extraemos los datos de la base de datos y la mostramos en la pantalla

-->
<%
	
  Do Until oRS.EOF

  user_bd = oRS("nombre_usuario")
  
  oRS.MoveNext
  Loop
  oConn.Close
  Set oRS = Nothing
  Set oConn = Nothing
  
  if user_bd = user then
  usuario_existente = "true"
  else
  usuario_existente = "false"
  end if
  
  end function 
%>







  <!--------------------------------------------------------------------------------------------------

Función obtener_fechahora_actual()

nos devuelve una variable con la fecha y la hora parseada correctamente
--------------------------------------------------------------------------------------------------->

<%
Function obtener_fechahora_actual()

		if Day (Now) < 10 then 
			fecha = "0"&Day (Now)&"/"
		else
			fecha = Day (Now)&"/"
		end if
		
		if Month (Now) < 10 then 
			fecha = fecha&"0"&Month (Now)&"/"
		else
			fecha = fecha&Month (Now)&"/"
		end if
		
		fecha = fecha & Year (Now) &" "
		
		if Hour (Now) < 10 then 
			fecha = fecha&"0"&Hour (Now)&":"
		else
			fecha = fecha&Hour (Now)&":"
		end if
		
		if Minute (Now) < 10 then 
			fecha = fecha&"0"&Minute (Now)&":"
		else
			fecha = fecha&Minute (Now)&":"
		end if
		
		if Second (Now) < 10 then 
			fecha = fecha&"0"&Second (Now)
		else
			fecha = fecha&Second (Now)
		end if
		
		obtener_fechahora_actual = fecha
end function
%>

<!--------------------------------------------------------------------------------------------------

Función parsear_mensahe(mensaje)

devuelve una variable mensaje parseada correctamente

--------------------------------------------------------------------------------------------------->
<%
function parsear_mensaje(men)
  
  palabras = split(men," ")
  n_palabras = Ubound(palabras)
  mensaje = ""
 
   Dim i
   for i=0 to n_palabras
   		
			
		If InStr(palabras(i),"http://www.")>0 then
		
		nombre_enlace = split(palabras(i),".") 
		pal = "<a href = "&palabras(i)&" target=_blank>"&nombre_enlace(1)&"</a>"
		
		
		else
		
			if InStr(palabras(i),"www.")>0 then
			
			nombre_enlace = split(palabras(i),".") 
			pal = "<a href = http://"&palabras(i)&" target=_blank>"&nombre_enlace(1)&"</a>" 
		
			else
		
				If  InStr(palabras(i),".es")>0 OR InStr(palabras(i),".com")>0 OR InStr(palabras(i),".tk")>0 OR InStr(palabras(i),".org")>0 OR InStr(palabras(i),".net")>0 then
				
				nombre_enlace = split(palabras(i),".") 
				pal = "<a href = http://www."&palabras(i)&" target=_blank>"&nombre_enlace(0)&"</a>"
			
				else
			
				
			
					If InStr(palabras(i),"@")>0 AND len(palabras(i))>1 then
					MyString = Replace(palabras(i), "@", "")
					pal = "<a href =buscar_perfil_usuario.asp?nombre_usuario="&MyString&">@"&MyString&"</a>"
				
					else
					
						If InStr(palabras(i),"#")>0 AND len(palabras(i))>1 then
						MyString = Replace(palabras(i), "#", "")
						pal = "<a href='hastag.asp?q="&MyString&"'>"&palabras(i)&"</a>"
				
						else
						
						pal = palabras(i)
						
						End if
					End if	
				end if
			end if
			
					
	
		End if
		
		mensaje = mensaje & " " & pal
		
		next


parsear_mensaje = mensaje
end function
%>


