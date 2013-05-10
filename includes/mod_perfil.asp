<%
On Error Resume Next
  Set oConn = CreateObject("ADODB.Connection")
  oConn.Open "Data Source="& Server.MapPath("smallbird.mdb") &";Provider=Microsoft.Jet.OLEDB.4.0"
  
  SQL1 = "SELECT Count(tweets.id_user) AS numero_tweets FROM users INNER JOIN tweets ON users.Id_user = tweets.id_user GROUP BY users.nombre_usuario HAVING (((users.nombre_usuario)="&Chr(39)&session("nombre_usuario")&Chr(39)&")); "
  
  SQL2 = "SELECT Count (siguiendo.Id_user) AS cuenta_siguiendo FROM users INNER JOIN siguiendo ON users.Id_user = siguiendo.Id_user WHERE (((users.nombre_usuario)="&Chr(39)&session("nombre_usuario")&Chr(39)&"));"
  
  SQL3 = "SELECT Count(seguidores.Id_user) AS cuenta_seguidores FROM users INNER JOIN seguidores ON users.Id_user = seguidores.Id_user WHERE (((users.nombre_usuario)="&Chr(39)&session("nombre_usuario")&Chr(39)&")); "
  
  SQL4 = " SELECT users.id_user,users.nombre_usuario, users.mail, users.url_foto_perfil, users.fecha_registro FROM users WHERE (((users.nombre_usuario)="&Chr(39)&session("nombre_usuario")&Chr(39)&"));" 
    
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




<div class="blogwidgetstart">
	<div class="widgettitle">
    </div>
    <div class="widgetbody">
        <div class="blogadvertising">
            <div class="contacttitle">
                <h2>Perfil</h2>
            </div>
                <div class="contacttextarea">
                     <img src="<%Response.Write(session("url_foto_perfil"))%>" style="width:240px; height:auto"/>
                </div>
                <div class="contacttextarea">
                      <h1 style="color:#000"><%Response.Write(session("nombre_usuario"))%></h1>
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
                
                
                
                
                <div class="contacttextarea">   
                        <div class="contacttextarea">
                            <a href="perfil.asp">
                            <input class="featured-titles" type="button" value="Ver perfil" />
                            </a>
                        </div>
                        
                       
                        <div class="contacttextarea">
                            <a href="logout.asp">       
                            <input class="featured-titles" type="button" value="Salir" />
                            </a>
                        </div>
             	</div>
          </div>
            	<span class="box-arrow"></span>
   </div>
</div>
            
