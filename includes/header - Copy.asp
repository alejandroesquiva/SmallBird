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

<div id="header">
    	<!-- Start navigation area -->
        <div id="navigation">

        	<div id="navigation_wrap">

                <!-- Start contact info area -->
                <div id="conteactinfo">
                
          <!-- Poner aqui el logo y el buscador-->
                
                </div>
                <!-- End contact info area -->
                <!-- Start navigation -->
                <div id="navi">
                
                    <ul>
                    
                        <li><a href="/themes/response/" title="Inicio">Inicio</a></li>
                        <li><a href="#" title="Buscar">Buscar</a></li>
                        <li><a href="#" title="Perfil">Perfil</a></li>
                        <li><a href="blog.html" title="Notificaciones">Notificaciones</a></li>
                    </ul>
                
                </div>
                <!-- End navigation -->
                
			</div>
        
        </div>
        <!-- End navigation area -->
        <div class="clear"></div>
        <!-- Start Social & Logo area -->
        <div id="header_small">
        	<!-- Start Social area -->
        	<div class="social">
            	
                <ul>
                <li><a href="#" class="social-google"></a></li>
                <li><a href="#" class="social-facebook"></a></li>
                <li><a href="#" class="social-twitter"></a></li>
                <li><a href="#" class="social-linkedin"></a></li>
                <li><a href="#" class="social-forrst"></a></li>
                <li><a href="#" class="social-dribbble"></a></li>
                </ul>
                
            </div>
            <!-- End Socialarea -->
            
            <!-- Start Logo area -->
            <div id="logo">
             
            </div>
            <!-- End Logo area -->
        
        </div>
        <!-- End Social & Logo area -->

</div>



