<meta charset="utf-8">
<title>Response Single Blog Post Page</title>
<meta name="description" content="Response Premium Html Responsive Template - Blog Section" />
<meta name="keywords" content="Responsive Html, Responsive Template, Response, Blog Portfolio" />
<meta name="apple-mobile-web-app-capable" content="yes" /> 
<meta name="apple-mobile-web-app-status-bar-style" content="grey" /> 
<meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.0;" /> 
<link rel="shortcut icon" href="http://www.derby-web-design-agency.co.uk/themes/response/images/favicon.png" /> 
<link rel="bookmark icon" href="http://www.derby-web-design-agency.co.uk/themes/response/images/favicon.png" /> 
<link href="estilos/css/main.css" rel="stylesheet" type="text/css">

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="estilos/js/jquery.nivo.slider.js"></script>
<script src="estilos/sjs/twitter.js"></script>    
<script src="estilos/js/custom.js"></script>   
<script>
	//// Start Simple Sliders ////
	$(function() {
		setInterval("rotateDiv()", 10000);
	});
		
		function rotateDiv() {
		var currentDiv=$("#simpleslider div.current");
		var nextDiv= currentDiv.next ();
		if (nextDiv.length ==0)
			nextDiv=$("#simpleslider div:first");
		
		currentDiv.removeClass('current').addClass('previous').fadeOut('2000');
		nextDiv.fadeIn('3000').addClass('current',function() {
			currentDiv.fadeOut('2000', function () {currentDiv.removeClass('previous');});
		});
	
	}
	//// End Simple Sliders //// 
</script> 


    	<!-- Start navigation area -->
        <div id="navigation">

        	

            

                <!-- Start contact info area -->
                <!-- Start navigation -->
                <div id="navi">
                
                    <ul>
                    
                        <li style="background:#5bb1f0"><a style="color:#000" href="default.asp" title="Inicio"><b>Inicio</b></a></li>
                        <li style="background:#5bb1f0"><a style="color:#000" href="buscar.asp" title="Buscar"><b>Buscar</b></a></li>
                        
                        <%
						if session("estado") = "true" then
						%>
						<li style="background:#5bb1f0"><a style="color:#000" href="perfil.asp" title="Perfil"><b>Perfil</b></a></li>
						<%
						end if

						if session("admin") = 1 then
						%>
						<li style="background:#5bb1f0"><a style="color:#000" href="admin.asp" title="Administrador"><b>Administrador</b></a></li>
                        <%
						end if
						%>
              
             
                <!-- End navigation -->
                
				</div>
                
                <div id="navi" style="margin-top:5px">
                
                	<form name="buscar" action="buscar.asp" method="post">
                    <span>
                        <input class="contacttextform" id="busqueda" name="busqueda" type="text" style="width:200px;background:#93e4ff;color:#000" />
                        <img src="images/logobuscar.png" onclick="buscar.submit()" style="width:35px; height:auto;vertical-align: middle;position:relative;" />
                    </span>
                    </form>
                
				</div>
                
                <div id="navi">
                
                	<a href="default.asp"><img src="estilos/images/logo.png" style="vertical-align:bottom;position:relative;" /></a>
                
				</div>
                

        
        </div>
        <!-- End navigation area -->
        <div class="clear"></div>
       





