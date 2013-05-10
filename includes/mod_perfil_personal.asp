<script language="javascript">

	function eliminar_fila(fila,id,nombre_usuario){
		
		
			confirmar=confirm("¿Estás seguro que quieres este smallbird?");
			if (confirmar){ 
			// si pulsamos en aceptar
			URL = "perfil-action.asp?action=delete&val1="+id+"&nombre_usuario="+nombre_usuario;
			window.open(URL,"perfil-action");
			eliminarElemento("t1f"+fila);
			}else{ 
			// si pulsamos en cancelar
			}
	}
		
	function modificar_fila(fila,id,nombre_usuario){
		
		confirmar=confirm("¿Estás seguro que quieres modificar este SmallBird?"); 
		if (confirmar){ 
			// si pulsamos en aceptar
			
			i1=id;
			i2=document.getElementById("i1t1f"+fila);
			i3=document.getElementById("i2t1f"+fila);
			i4bruto=document.getElementById("i3t1f"+fila);
			
			if (i4bruto.checked==true){
				i4 = 1;
			}else{
				i4 = 0;
			}
			
			URL = "perfil-action.asp?action=modify&nombre_usuario="+nombre_usuario+"&val1="+i1+"&val2="+i2.value+"&val3="+i3.value+"&val4="+i4;
			window.open(URL,"perfil-action"); 
		}else{ 
		// si pulsamos en cancelar
		}		
	}
	
	
function eliminarElemento(id){
	imagen = document.getElementById(id);	
	if (!imagen){
		
	} else {
		padre = imagen.parentNode;
		padre.removeChild(imagen);
	}
	
}

	

	function modificar_datos(){
		
		name4 = document.getElementById("t_name");
		mail = document.getElementById("t_mail");
		pass = document.getElementById("t_pass");
		bt1 = document.getElementById("bt1");
		bt2 = document.getElementById("bt2");
		
		
		name4.disabled = false;
		mail.disabled = false;
		pass.disabled = false;
		
		bt1.hidden = true;
		bt2.hidden = false;	
	}
	
	function verificar_datos(){
		
		if(name.value == "" || mail.value == "" || pass.value == ""){
			alert("No puedes dejar ningún campo vacio");	
		}else{
			document.forms["datos"].submit();	
		}
		
	}
	
	id_anterior = "";
	
	function cambiar_input(id){
				
		input=document.getElementById("foto");
		input.value = id;
		foto = document.getElementById(id).style.background="#00F";
		
		if(id_anterior != ""){
			foto2 = document.getElementById(id_anterior).style.background="rgba(255,0,0,0)";		
		}
		
		if(id == id_anterior){
			id_anterior = "";	
		}else{
			id_anterior = id;
		}
		//document.id.style.border = "medium solid black";

	}
	
	function validar_eliminacion(){
		confirmar=confirm("¿Estás seguro que quieres eliminar tu cuenta?, se borrarán todos tus SmallBirds"); 
		if (confirmar){ 
		// si pulsamos en aceptar
		document.forms["eliminar_user"].submit();
		}else{ 
		// si pulsamos en cancelar
		}
		
	}
	
</script>

<%

sub plasmar_fila_tweet_usuario(id_tweet,tweet,fecha,publico,fila)
%>

        
        <tr id="t1f<%response.write(fila)%>">
        	<td id="t1f<%response.write(fila)%>c1" align="center">
           <%Response.Write(fila)%>
            </td>
            <td id="t1f<%response.write(fila)%>c2" align="center">
            <input id="i1t1f<%response.write(fila)%>" type="text" value="<%Response.Write(tweet)%>" size="35%"/>
            </td>
            <td id="t1f<%response.write(fila)%>c3" align="center">
            <input id="i2t1f<%response.write(fila)%>" type="text" value="<%Response.Write(fecha)%>" size="25%"/>
            </td>
            <td id="t1f<%response.write(fila)%>c7" align="center">
             <%
			 if publico=0 then
			 %>
             	<input id="i3t1f<%response.write(fila)%>" type="checkbox" size="1%"/>
             <%
			 else
			 %>
             	<input id="i3t1f<%response.write(fila)%>" type="checkbox" checked="checked" size="1%"/>
             <%
			 end if
			 %>
            
            </td>
            <td id="t1f<%response.write(fila)%>c8" align="center">
            <img src="estilos/images/modificar.png" alt="modificar" title="Modificar" width="16" height="16" onclick="modificar_fila('<%response.write(fila)%>','<%response.write(id_tweet)%>','<%=session("nombre_usuario")%>')" />
            </td>
            <td id="t1f<%response.write(fila)%>c9" align="center">
            <img src="estilos/images/eliminar.jpg" alt="Eliminar" title="Eliminar" width="16" height="16" onclick="eliminar_fila('<%response.write(fila)%>','<%response.write(id_tweet)%>','<%=session("nombre_usuario")%>')" />
            </td>
            
        </tr>



<%
end sub



sub mostrar_tabla_tus_smallbirds()


 	  On Error Resume Next
	  Set oConn_pp = CreateObject("ADODB.Connection")
	  oConn_pp.Open "Data Source="& Server.MapPath("smallbird.mdb") &";Provider=Microsoft.Jet.OLEDB.4.0"
	  'oConn.Open "Libros"
	  SQL="SELECT tweets.tweet, tweets.fecha, tweets.id_tweet, tweets.privado FROM tweets WHERE (((tweets.id_user)="&session("id_user")&")) ORDER BY tweets.Id_tweet DESC;"
	  
	  Set oRS_pp = oConn_pp.Execute(SQL)
	  
	  If Err.Description <> "" then
	  Response.Write "<b>Error:" & Err.Description & "</b>"
	  Else
	  End If
	  %>
	    <div align="center" class="contacttextarea">
		<table class="tb" border="1">
	  <%
	  if oRS_pp.EOF then
	  	Response.write("No has enviado ningun SmallBird")
	  else
	  
	  %>

        	<tr>
                <th align="center">
                Nº
                </th>
            	<th align="center">
                SmallBird
                </th>
                <th align="center">
                Fecha
                </th>
                <th align="center">
                Privado
                </th>
                <th align="center">
                Mod.
                </th>
                <th align="center">
                Elim.
                </th>
            </tr>
		<%	
		end if
		
		
		t1=1	
	  Do Until oRS_pp.EOF

		
		call plasmar_fila_tweet_usuario(oRS_pp("id_tweet"),oRS_pp("tweet"),oRS_pp("fecha"),oRS_pp("privado"),t1)
		
	
		
		t1=t1+1


	  oRS_pp.MoveNext
	  Loop
	  %>
	  </table>
      </div>
	  <%
      oConn_pp.Close
	  Set oConn_pp = Nothing
	  oRS_pp.Close
	  Set oRS_pp = Nothing
	  
end	sub

	
  if(Request.Form <> "") then
  	
		On Error Resume Next
		Set oConn = CreateObject("ADODB.Connection")
		oConn.Open "Data Source="& Server.MapPath("smallbird.mdb") &";Provider=Microsoft.Jet.OLEDB.4.0"
		  
		SQL6 = "UPDATE users SET nombre_usuario ='"&Request.Form("name")&"', mail = '"&Request.Form("mail")&"',[password] ='"&Request.Form("pass")&"', url_foto_perfil = '"&Request.Form("foto")&"' WHERE Id_user = "&Session("id_user")&""
			  
		Set oRS = oConn.Execute(SQL6)
		If Err.Description <> "" then
		Response.Write "<b>Error:" & Err.Description & "</b>"
		Else
		End If
					
					
		oConn.Close 
		Set oRS = Nothing
		Set oConn = Nothing
					
  		Session("nombre_usuario") = Request.Form("name")
		Session("password") = Request.Form("pass")
		Session("mail") = Request.Form("mail")
		Session("url_foto_perfil") = Request.Form("foto")
					
				
	end if

%>



<div class="blogcomment">
 	<div class="blogwcommentwrap">   

		<div align="center" class="contacttextarea">
        <h1 style="color:#000">Modifica Tus SmallBirds</h1>
        </div>
        
       	<div align="center" class="contacttextarea">
        <% call mostrar_tabla_tus_smallbirds()%>
        </div>
          
    
    
    <span class="box-arrow"></span>
	</div>
</div>
 
<div class="blogcomment">
 	<div class="blogwcommentwrap">   

        
        <div align="center" class="contacttextarea">
        <h1 style="color:#000">Modficar Datos</h1>
        </div>
        
     
	    <div align="center" class="contacttextarea">
        
        <form name="datos" action="perfil.asp" method="post">
        	<span><h1>Nombre Usuario</h1> 
            	<input id="t_name" class="contacttextform" name="name" type="text" disabled="disabled" value="<%Response.Write(Session("nombre_usuario"))%>" />
            </span>
           	<span><h3>Email</h1>
                <input id="t_mail" class="contacttextform" name="mail" type="text" disabled="disabled" value="<%Response.Write(Session("mail"))%>" />
            </span>
            <span><h1>Password</h1>
                <input id="t_pass" class="contacttextform" name="pass" type="password" disabled="disabled" value="<%Response.Write(Session("password"))%>" />
            </span>
      
            
            <input name="foto" id="foto" value="<%Response.Write(session("url_foto_perfil"))%>" hidden="true" type="text">
  

          </div>
          
        <div align="center" class="contacttextarea">
        <h1 style="color:#000">Elige Avatar o... <a href="perfil_foto.asp">Escoge tu propia foto perfil</a></h1>
        </div>
          
          <div align="center" class="contacttextarea"> 
	    	<%

					Set ObjetoFSO = Server.CreateObject("Scripting.FileSystemObject")
					folder = "images/avatar/"
					'nos selecciona la carpeta en la que esta el archivo
					
					Set ObjetoCarpeta = ObjetoFSO.GetFolder(Server.MapPath(folder))
									
					'busca en todos los archivos que encuentra en dicha carpeta
					For Each Fichero in ObjetoCarpeta.Files
					%>
                    <img id="<%Response.write(folder&Fichero.Name)%>" src="<%response.Write(folder&Fichero.Name)%>" width=60px height=60px onclick="cambiar_input(this.id)" name="<%Response.write(folder&Fichero.Name)%>" />
                    <%
					Next
					
					
					Set Fichero = Nothing
					Set ObjetoCarpeta = Nothing
					Set ObjetoFSO = Nothing

			%>
        </div>
        <div align="center" class="contacttextarea"> 
        
            <input id="bt1" class="featured-titles" type="button" onclick="modificar_datos()" value="Modificar datos" />
        	<input id="bt2" class="featured-titles" type="submit" hidden="true" value="Enviar Datos"<td width="0">
            </form>
         </div>
          
          
        <span class="box-arrow"></span>
	</div>
</div>





<div class="blogcomment">
 	<div class="blogwcommentwrap">   

		<div align="center" class="contacttextarea">
        <h1 style="color:#000">Eliminar Cuenta</h1>
        <div align="center" class="contacttextarea">
        
        <form action="perfil_eliminar.asp" method="post" name="eliminar_user">
        <input type="button" class="featured-titles" value="Eliminar" onclick="validar_eliminacion()" />
        <input name="id_user" hidden="true" value="<%response.Write(session("id_user"))%>" />
        </form>
        
        </div>
        </div>
          
    
    
    <span class="box-arrow"></span>
	</div>
</div>

<br />
<iframe name="perfil-action" style="height: 1px; border:0" src="" width="0%">  
</iframe>


	