<script language="javascript">

	function modificar_datos(){
		
		name = document.getElementById("t_name");
		mail = document.getElementById("t_mail");
		pass = document.getElementById("t_pass");
		bt1 = document.getElementById("bt1");
		bt2 = document.getElementById("bt2");
		
		
		name.disabled = false;
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
	
	function verificar_foto(){
		
		file = document.forms["file_foto"].file1.value;
			
	if(file==""){	
			alert("Debes seleccionar tu foto de Perfil");
		}else{
			document.forms["file_foto"].submit();	
		}
	}
	
</script>

<%

	ForWriting = 2
	lngNumberUploaded = 0
	'Get binary data from form
	noBytes = Request.TotalBytes
	if noBytes < 200 then
			'call mensaje_error("Error","Debes introducir un archivo válido<br><br><p><a href='perfil.asp'>Volver</a></p>")
			
	else
		if noBytes > 200000 then
			call mensaje_error("Error","El archivo no puede superar los 200 Kbytes<br><br><p><a href='perfil.asp'>Volver</a></p>")
			Response.End()
		else
		
			binData = Request.BinaryRead(noBytes)
			'convery the binary data to a string
			Set RST = CreateObject("ADODB.Recordset")
			LenBinary = LenB(binData)
			
			if LenBinary > 0 Then
				RST.Fields.Append "myBinary",201, LenBinary
				RST.Open
				RST.AddNew
				RST("myBinary").AppendChunk BinData
				RST.Update
				strDataWhole = RST("myBinary")
			End if
			strBoundry = Request.ServerVariables ("HTTP_CONTENT_TYPE")
			lngBoundryPos = instr(1,strBoundry,"boundary=") + 8
			strBoundry = "--" & right(strBoundry,len(strBoundry)-lngBoundryPos)
			'Get first file boundry positions.
			lngCurrentBegin = instr(1,strDataWhole,strBoundry)
			lngCurrentEnd = instr(lngCurrentBegin + 1,strDataWhole,strBoundry) - 1
			Do While lngCurrentEnd > 0
			'Get the data between current boundry an
			' d remove it from the whole.
			strData = mid(strDataWhole,lngCurrentBegin, lngCurrentEnd - lngCurrentBegin)
			strDataWhole = replace(strDataWhole,strData,"")
			
			'Get the full path of the current file.
			lngBeginFileName = instr(1,strdata,"filename=") + 10
			lngEndFileName = instr(lngBeginFileName,strData,chr(34))
			'Make sure they selected at least one fi
			' le.
			if lngBeginFileName = lngEndFileName and lngNumberUploaded = 0 Then
			
				Response.Write "<H2> Ha ocurrido el siguiente error.</H2>"
				Response.Write "Debes elegir un archivo para subir"
				Response.Write "<BR><BR>Pulsa el botón volver, realiza la corrección."
				Response.Write "<BR><BR><INPUT type='button' onclick='history.go(-1)' value='<< Volver' id='button'1 name='button'1>"
				Response.End
			End if
			'There could be one or more empty file b
			' oxes.
			if lngBeginFileName <> lngEndFileName Then
				strFilename = mid(strData,lngBeginFileName,lngEndFileName - lngBeginFileName)
				tmpLng = instr(1,strFilename,"\")
				Do While tmpLng > 0
					PrevPos = tmpLng
					tmpLng = instr(PrevPos + 1,strFilename,"\")
				Loop
			
				FileName = right(strFilename,len(strFileName) - PrevPos)
				
				'Get the begining position of the file d
				' ata sent.
				'if the file type is registered with the
				' browser then there will be a Content-Typ
				' e
				lngCT = instr(1,strData,"Content-Type:")
				
				if lngCT > 0 Then
					lngBeginPos = instr(lngCT,strData,chr(13) & chr(10)) + 4
				Else
					lngBeginPos = lngEndFileName
				End if
				'Get the ending position of the file dat
				' a sent.
				lngEndPos = len(strData)
				
				'Calculate the file size.
				lngDataLenth = lngEndPos - lngBeginPos
				'Get the file data
				strFileData = mid(strData,lngBeginPos,lngDataLenth)
				'Create the file.
				Set fso = CreateObject("Scripting.FileSystemObject")
				url_foto_larga = server.mappath("images") &"/"& session("id_user")&"_"&FileName
				url_foto = "images/"& session("id_user")&"_"&FileName
				Set f = fso.OpenTextFile(url_foto_larga , ForWriting, True)
				f.Write strFileData
				Set f = nothing
				Set fso = nothing
				
				lngNumberUploaded = lngNumberUploaded + 1
				
			End if
			
			'Get then next boundry postitions if any
			' .
			lngCurrentBegin = instr(1,strDataWhole,strBoundry)
			lngCurrentEnd = instr(lngCurrentBegin + 1,strDataWhole,strBoundry) - 1
			loop
		
		end if
		
		
		Session("url_foto_perfil") = url_foto
		
		On Error Resume Next
  		Set oConn = CreateObject("ADODB.Connection")
  		oConn.Open "Data Source="& Server.MapPath("smallbird.mdb") &";Provider=Microsoft.Jet.OLEDB.4.0"
		
		SQL6 = "UPDATE users SET url_foto_perfil ='"&url_foto&"' WHERE Id_user = "&Session("id_user")&""
		  
	  
		 Set oRS = oConn.Execute(SQL6)
		 If Err.Description <> "" then
		 Response.Write "<b>Error:" & Err.Description & "</b>"
		 Else
		 End If
		 
  		oConn.Close 
  		Set oRS = Nothing
 	 	Set oConn = Nothing
		
		
	end if
	
	'call mensaje_error("Foto Subida","Has actualizado la foto de perfil correctamente<br><a href='perfil.asp'>Volver</a>")
	

%>

<%
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
%>
 
<div class="blogcomment">
 	<div class="blogwcommentwrap">   

        
        <div align="center" class="contacttextarea">
        <h1 style="color:#000">Modficar Foto Perfil (&lt; 200 KB)</h1>
        </div>
	    <div align="center" class="contacttextarea">  
        <form ENCTYPE="multipart/form-data" name="file_foto" method="post" action="perfil_foto.asp">
        </div>
        <div align="center" class="contacttextarea">
        <input id="file1" class="contacttextform" name="file1" type="file" />
        </div>
        <div align="center" class="contacttextarea">
       	<input class="featured-titles" type="button" onclick="verificar_foto()" value="Cambiar Foto Perfil" />
        </div>
        </form>

          
          
        <span class="box-arrow"></span>
	</div>
</div>


	