<link href="../estilos/css/main.css" rel="stylesheet" type="text/css">
<div class="blogwidgetstart">

<div class="widgettitle"></div>
	<div class="widgetbody">
    	<div class="blogadvertising">
        	<div class="contacttitle">
            	<h2>Últimos Usuarios</h2>
            </div>
            <div class="contacttextarea">
   				<table width="100%">
     
       	 <%
		
	      Set oConn_ult = Server.CreateObject("ADODB.Connection")
		  oConn_ult.Open "Data Source="& Server.MapPath("smallbird.mdb") &";Provider=Microsoft.Jet.OLEDB.4.0"
		  
		  SQL = "SELECT TOP 21 users.nombre_usuario, users.url_foto_perfil FROM users ORDER BY users.id_user DESC;"  

		  Set oRS = oConn_ult.Execute(SQL)
		  If Err.Description <> "" then

		  Else
		  End If
		  
		  i=0		  
		  Do Until oRS.EOF
		  	
			if i=0 then
				%>
				<tr>
               	<%
			end if
			
			%>
			<td width="33%" align="" align="center">
             <a class="ff" href="buscar_perfil_usuario.asp?nombre_usuario=<% Response.Write(oRS("nombre_usuario")) %>"><img title="<% Response.Write(oRS("nombre_usuario")) %>" alt="<% Response.Write(oRS("nombre_usuario")) %>" src="<% = oRS("url_foto_perfil") %>" style="width:80px; height:auto" /></a>
             </td>
			
			<%
			
			
			if i=2 then
				%>
				</tr>
				<%
				i=0
			else
				i=i+1
			end if	
			
			

				
		  	
		  oRS.MoveNext
		  Loop
		  
		  oConn_ult.Close
		  Set oRS = Nothing
		  Set oConn_ult = Nothing
		  
		  %>
		
        </table>
        </div>    
	      
        <div class="contacttextarea">
        	<a href="ultimos_users.asp">       
            <input class="featured-titles" type="button" value="Ver Usuarios" />
			</a>
        </div>  
                
              <span class="box-arrow"></span>
            
            </div>
            </div>
        
        