<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<script language="javascript">

function eliminar_fila(tabla,fila,id){
	
	if(tabla==1){
		confirmar=confirm("¿Estás seguro que quieres Eliminar a este usuario?, si lo eliminas borraras todos sus SmallBirds"); 
		if (confirmar){ 
		// si pulsamos en aceptar
		URL = "admin-action.asp?action=delete&t=user&val1="+id;
		window.open(URL,"admin-action");
		eliminarElemento("t"+tabla+"f"+fila);
		}else{ 
		// si pulsamos en cancelar
		}
	}
	
	if(tabla==2){
		
		confirmar=confirm("¿Estás seguro que quieres eliminar este SmallBird?"); 
		if (confirmar){ 
		// si pulsamos en aceptar
		URL = "admin-action.asp?action=delete&t=tweet&val1="+id;
		window.open(URL,"admin-action");
		eliminarElemento("t"+tabla+"f"+fila);
		}else{ 
		// si pulsamos en cancelar
		}
	}
	
}

function modificar_fila(tabla,fila,id){

	
	if(tabla==1){
		
		confirmar=confirm("¿Estás seguro que quieres modificar los datos de este usuario?"); 
		if (confirmar){ 
			// si pulsamos en aceptar
			
			i1=id;
			i2=document.getElementById("i1t1f"+fila);
			i3=document.getElementById("i2t1f"+fila);
			i4=document.getElementById("i3t1f"+fila);
			i5=document.getElementById("i4t1f"+fila);
			i6=document.getElementById("i5t1f"+fila);
			i7bruto=document.getElementById("i6t1f"+fila);
			
			if (i7bruto.checked==true){
				i7 = 1;
			}else{
				i7 = 0;
			}
			
			URL = "admin-action.asp?action=modify&t=user&f="+fila+"&val1="+i1+"&val2="+i2.value+"&val3="+i3.value+"&val4="+i4.value+"&val5="+i5.value+"&val6="+i6.value+"&val7="+i7;
			window.open(URL,"admin-action"); 
		}else{ 
		// si pulsamos en cancelar
		}
	}
	
	if(tabla==2){
				
		confirmar=confirm("¿Estás seguro que quieres modificar este SmallBird?"); 
		if (confirmar){ 
		// si pulsamos en aceptar
			i1=id;
			i2=document.getElementById("i1t2f"+fila);
			i3=document.getElementById("i2t2f"+fila);
			i4bruto=document.getElementById("i3t2f"+fila);
			
			if (i4bruto.checked==true){
				i4 = 1;
			}else{
				i4 = 0;
			}
		
			URL = "admin-action.asp?action=modify&t=tweet&f="+fila+"&val1="+i1+"&val2="+i2.value+"&val3="+i3.value+"&val4="+i4;
			
			window.open(URL,"admin-action");
		}else{ 
		// si pulsamos en cancelar
		}
		
		
		
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

</script>

<!--#include file="includes/funciones.asp"-->

<%
sub plasmar_fila_user(id_user,nombre,pass,mail,url,fecha,admin,fila)
%>

        
        <tr id="t1f<%response.write(fila)%>">
        	<td id="t1f<%response.write(fila)%>c1" align="center">
           <%Response.Write(id_user)%>
            </td>
            <td id="t1f<%response.write(fila)%>c2" align="center">
            <input id="i1t1f<%response.write(fila)%>" type="text" value="<%Response.Write(nombre)%>" size="10%"/>
            </td>
            <td id="t1f<%response.write(fila)%>c3" align="center">
            <input id="i2t1f<%response.write(fila)%>" type="text" value="<%Response.Write(pass)%>" size="10%"/>
            </td>
            <td id="t1f<%response.write(fila)%>c4" align="center">
            <input id="i3t1f<%response.write(fila)%>" type="text" value="<%Response.Write(mail)%>" size="12%"/>
            </td>
            <td id="t1f<%response.write(fila)%>c5" align="center">
            <input id="i4t1f<%response.write(fila)%>" type="text" value="<%Response.Write(url)%>" size="10%"/>
            </td>
            <td id="t1f<%response.write(fila)%>c6" align="center">
            <input id="i5t1f<%response.write(fila)%>" type="text" value="<%Response.Write(fecha)%>" size="10%"/>
            </td>
             <td id="t1f<%response.write(fila)%>c7" align="center">
             <%
			 if admin=0 then
			 %>
             	<input id="i6t1f<%response.write(fila)%>" type="checkbox" size="1%"/>
             <%
			 else
			 %>
             	<input id="i6t1f<%response.write(fila)%>" type="checkbox" checked="checked" size="1%"/>
             <%
			 end if
			 %>
            
            </td>
            <td id="t1f<%response.write(fila)%>c8" align="center">
            <img src="estilos/images/modificar.png" alt="modificar" title="Modificar" width="16" height="16" onclick="modificar_fila('1','<%response.write(fila)%>','<%response.write(id_user)%>')" />
            </td>
            <td id="t1f<%response.write(fila)%>c9" align="center">
            <img src="estilos/images/eliminar.jpg" alt="Eliminar" title="Eliminar" width="16" height="16" onclick="eliminar_fila('1','<%response.write(fila)%>','<%response.write(id_user)%>')" />
            </td>
            
        </tr>



<%
end sub



sub plasmar_fila_tweets(id_tweet,nombre,tweet,fecha,privado,fila)
%>
	
    	<tr id="t2f<%response.write(fila)%>">
        	<td id="t2f<%response.write(fila)%>c1" align="center">
           <%Response.Write(id_tweet)%>
            </td>
            <td id="t2f<%response.write(fila)%>c2" align="center">
            <%Response.Write(nombre)%>
            </td>
            <td id="t2f<%response.write(fila)%>c3" align="center">
            <input id="i1t2f<%response.write(fila)%>" type="text" value="<%Response.Write(tweet)%>" size="35%"/>
            </td>
            <td id="t2f<%response.write(fila)%>c4" align="center">
            <input id="i2t2f<%response.write(fila)%>" type="text" value="<%Response.Write(fecha)%>" size="15%"/>
            </td>
            <td id="t2f<%response.write(fila)%>c5" align="center">
            
             <%
			 if privado=0 then
			 %>
             	<input id="i3t2f<%response.write(fila)%>" type="checkbox" size="1"/>
             <%
			 else
			 %>
             	<input id="i3t2f<%response.write(fila)%>" type="checkbox" checked="checked" size="1"/>
             <%
			 end if
			 %>
            
            </td>
            <td id="t2f<%response.write(fila)%>c6" align="center">
            <img src="estilos/images/modificar.png" alt="modificar" title="Modificar" width="16" height="16"  onclick="modificar_fila('2','<%response.write(fila)%>','<%response.write(id_tweet)%>')"/>
            </td>
            <td id="t2f<%response.write(fila)%>c7" align="center">
            <img src="estilos/images/eliminar.jpg" alt="Eliminar" title="Eliminar" width="16" height="16" onclick="eliminar_fila('2','<%response.write(fila)%>','<%response.write(id_tweet)%>')" />
            </td>
            
        </tr>



<%
end sub




sub plasmar_fila_siguiendo(id_user,id_user_sig,fila)
%>
	
    	<tr>
        	<td>
            <%Response.Write(id_user)%>
            </td>
            <td>
            <%Response.Write(id_user_sig)%>
            </td>
                    
        </tr>



<%
end sub


sub mostrar_tablas()

	  On Error Resume Next
	  Set oConn_t1 = CreateObject("ADODB.Connection")
	  oConn_t1.Open "Data Source="& Server.MapPath("smallbird.mdb") &";Provider=Microsoft.Jet.OLEDB.4.0"
	  'oConn.Open "Libros"
	  SQL1 = "SELECT users.Id_user, users.nombre_usuario, users.password, users.mail, users.url_foto_perfil, users.fecha_registro, users.admin FROM users;" 
	  Set oRS_t1 = oConn_t1.Execute(SQL1)
	  
	  SQL2 = "SELECT tweets.Id_tweet, users.nombre_usuario, tweets.tweet, tweets.fecha, tweets.privado FROM users INNER JOIN tweets ON users.Id_user = tweets.id_user ORDER BY tweets.Id_tweet DESC; " 
	  
	  Set oRS_t2 = oConn_t1.Execute(SQL2)
	  
	  SQL3 = "SELECT siguiendo.* FROM siguiendo;"

	  Set oRS_t3 = oConn_t1.Execute(SQL3)
	
	  If Err.Description <> "" then
	  Response.Write "<b>Error:" & Err.Description & "</b>"
	  Else
	  End If

		%>
        <div class="blogcomment">    
        <div class="blogwcommentwrap">
		<table class="tb" border="1">
        	<tr>
            	<th align="center">
                ID
                </th>
                <th align="center">
                Usuario
                </th>
                <th align="center">
                Contraseña
                </th>
                <th align="center">
                Email
                </th>
                <th align="center">
                Foto Perfil
                </th>
                <th align="center">
                Fecha
                </th>
                <th align="center">
                Adm
                </th>
            </tr>
		<%	
		t1=1	
	  Do Until oRS_t1.EOF

		
		call plasmar_fila_user(oRS_t1("id_user"),oRS_t1("nombre_usuario"),oRS_t1("password"),oRS_t1("mail"),oRS_t1("url_foto_perfil"),oRS_t1("fecha_registro"),oRS_t1("admin"),t1)
		
		t1=t1+1


	  oRS_t1.MoveNext
	  Loop
	  
	  	%>
		</table>
        <span class="box-arrow"></span>
        </div>
        </div>
        <br />
        <br />
		<%
		
		
		%>
        
        <div class="blogcomment">    
        <div class="blogwcommentwrap">
		<table class="tb" border="1">
        	<tr>
            	<th align="center">
                NºSB
                </th>
                <th align="center">
                Usuario
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
            </tr>
		<%	
		
		t2=1
	  Do Until oRS_t2.EOF

		
		call plasmar_fila_tweets(oRS_t2("id_tweet"),oRS_t2("nombre_usuario"),oRS_t2("tweet"),oRS_t2("fecha"),oRS_t2("privado"),t2)
		t2=t2+1


	  oRS_t2.MoveNext
	  Loop
	  
	  	%>
		</table>
        <span class="box-arrow"></span>
        </div>
        </div>
        <br />
        <br />
		<%
		
		
		
	  oConn_t1.Close
	  Set oConn_t1 = Nothing
	  oRS_t1.Close
	  Set oRS_t1 = Nothing
	  oRS_t2.Close
	  Set oRS_t2 = Nothing
	  

end sub

%>


<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Panel Del Administrador</title>
</head>
<body>
		
       

<!--#include file="includes/up.asp"-->

<div class="blogcomment">
 	<div class="blogwcommentwrap">  
    	<div align="center" class="contacttextarea">
      		<h4 style="float:left;padding-left:20px">
            <a href="default.asp">Inicio</a>
            &gt;
            <a href="admin.asp">Panel del Administrador</a>
            </h4>
        </div>
    
	</div>
</div>
        
<%
	if session("admin")<> 1 then
	
		call mensaje_error("Error","No tienes permiso para entrar al panel de administración")
	else
		call mostrar_tablas()
		'mostrar_tabla_tweets()
		'mostrar_tabla_seguidores()
	end if


%>
<br />
<iframe name="admin-action" style="height: 1px; border:0" src="" width="0%">  
</iframe>
        
<!--#include file="includes/down.asp"-->



</body>
</html>