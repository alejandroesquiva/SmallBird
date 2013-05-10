
<%
	sub mostrar_ultimos_tweets(num)
	
	
				  Set oConn_ult_s = Server.CreateObject("ADODB.Connection")
				  oConn_ult_s.Open "Data Source="& Server.MapPath("smallbird.mdb") &";Provider=Microsoft.Jet.OLEDB.4.0"
				  
				  SQL = "SELECT TOP "&num&" tweets.tweet,tweets.privado, users.nombre_usuario, users.url_foto_perfil FROM users INNER JOIN tweets ON users.Id_user = tweets.id_user ORDER BY tweets.Id_tweet DESC;" 
		
				  Set oRS_s = oConn_ult_s.Execute(SQL)
				  If Err.Description <> "" then

				  Else
				  End If
				  %>
                  		<div align="center" class="contacttextarea">
						
						<table width="100%">
      
                  <%
				  		  
				  Do Until oRS_s.EOF
				  
				  if oRS_s("privado") = 0 then
				
					mensaje = parsear_mensaje(oRS_s("tweet"))
					
				%>
					
                    <tr>
							<td>
								<a href="buscar_perfil_usuario.asp?nombre_usuario=<%response.Write(oRS_s("nombre_usuario"))%>"><img style="width:40px;height:auto;float:left;padding-right:20px" src="<%Response.Write(oRS_s("url_foto_perfil"))%>" title="<%response.Write(oRS_s("nombre_usuario"))%>" /></a>
							</td>
							<td>
                            	<h5 style="color:#cbcaca;float:left;font-family: 'HelveticaLTStdRoman', Arial, Helvetica, sans-serif"><%response.Write(mensaje)%></h5>							
                            </td>
					</tr>
					
				<%
				
				  end if
				  
				  oRS_s.MoveNext
				  Loop
				  
				  oConn_ult_s.Close
				  Set oRS_s = Nothing
				  Set oConn_ult_s = Nothing
		
	
	
%>			
               
		  </table>                
		</div>
			
<%	
	end sub


	call mostrar_ultimos_tweets(5)


%>


