<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Encuesta</title>

    <script type="text/javascript" src="http://www.google.com/jsapi"></script>
    <script type="text/javascript">
      google.load('visualization', '1');
	  google.load('visualization', '2');
	  google.load('visualization', '3');
	  google.load('visualization', '4');
    </script>
    <script type="text/javascript" type="text/javascript">
	
    function drawVisualization1(nombre,id,val0,val1,val2,val3,val4) {
		  
		  
		  
			wrapper = new google.visualization.ChartWrapper({
			  chartType: 'ColumnChart',
			  dataTable: [['', 'La Mejor', 'Buena', 'Del Monton', 'Mala', 'Horrible'],
						  ['', val0, val1, val2, val3, val4]],          options: {'title': nombre},
			  containerId:"visualization"+(id-1)
			});
			wrapper.draw();
		
      }

    </script>

<%
'código ASP


sub modificar_datos(id_enc,val)
	
	On Error Resume Next
    Set oConn = CreateObject("ADODB.Connection")
	oConn.Open "Data Source="& Server.MapPath("smallbird.mdb") &";Provider=Microsoft.Jet.OLEDB.4.0"
	set oRS=Server.CreateObject("ADODB.recordset")

	SQL = "UPDATE encuestas SET val"&val&" = val"&val&"+1 WHERE id_encuesta = "&id_enc&";"

	Set oRS = oConn.Execute(SQL)

end sub




sub mostrar_graficas()
 
	
  On Error Resume Next
  Set oConn1 = CreateObject("ADODB.Connection")
  oConn1.Open "Data Source="& Server.MapPath("smallbird.mdb") &";Provider=Microsoft.Jet.OLEDB.4.0"
  
  SQL1 = "SELECT encuestas.* FROM encuestas; "  

  Set oRSx1 = oConn1.Execute(SQL1)
  If Err.Description <> "" then
  Response.Write "<b>Error:" & Err.Description & "</b>"
  Else
  End If
  
  Do Until oRSx1.EOF
  

  
  %>
  	<script language="javascript" type="text/javascript">
	
	var nombre = "<%Response.Write(oRSx1("nombre"))%>";
	var id = <%Response.Write(oRSx1("id_encuesta"))%>;
	var val0 = <%Response.Write(oRSx1("val0"))%>;
	var val1 = <%Response.Write(oRSx1("val1"))%>;
	var val2 = <%Response.Write(oRSx1("val2"))%>;
	var val3 = <%Response.Write(oRSx1("val3"))%>;
	var val4 = <%Response.Write(oRSx1("val4"))%>;
 		//alert(nombre);
	drawVisualization1(nombre,id,val0,val1,val2,val3,val4);
		
 	</script>
  <%
  
  oRSx1.MoveNext
  Loop

  
  oConn1.Close
  Set oRSx1 = Nothing
  Set oRSx2 = Nothing
  Set oConn1 = Nothing
	

	%>	

	<%


end sub
%>


</head>
<body onload="cargar_graficas()">

<!--#include file="includes/up.asp"-->
<!--#include file="includes/funciones.asp"-->

<div class="blogcomment">
 	<div class="blogwcommentwrap">  
    	<div align="center" class="contacttextarea">
      		<h4 style="float:left;padding-left:20px">
            <a href="default.asp">Inicio</a>
            &gt;
            <a href="encuesta.asp">Resultado de la Encuesta</a>
            </h4>
        </div>
    
	</div>
</div>


<div class="blogcomment">
 	<div class="blogwcommentwrap">   
    
    <div align="center" class="contacttextarea">
	
    <div id="visualization0" style="width: 600px; height: 400px;"></div>
    <div id="visualization1" style="width: 600px; height: 400px;"></div>
    <div id="visualization2" style="width: 600px; height: 400px;"></div>
    <div id="visualization3" style="width: 600px; height: 400px;"></div>
    <div id="visualization4" style="width: 600px; height: 400px;"></div>
    
    </div>


    <span class="box-arrow"></span>
	</div>
</div>
   

<%
'código ASP
if Request.Form() <> "" then 
	
	dim res(5)
	dim i
	for i=0 to 5
	
	call modificar_datos(i+1,Request.form("test"&i))
		res(i) = Request.form("test"&i)
	next
	


	call mostrar_graficas()
else

	call mostrar_graficas()
end if
%>

        
<!--#include file="includes/down.asp"-->
</body>
</html>