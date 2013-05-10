
<script lang="javascript" >

function puntuar(){
	
	var test = new Array();
	
	for(var i=0;i<5;i++){
		test[i] = document.forms["encuesta"]["test"+i].value;	
		
	}
	
	document.forms["encuesta"].submit();

}


</script>

<div class="blogwidgetstart">

<div class="widgettitle"></div>
                
                <div class="widgetbody">
               
                
                	<div class="blogadvertising">
                    
                    <div class="contacttitle">
            
                <h2>Encuesta</h2>
            
        		</div>


 <div class="contacttextarea">
   <h4 style="color:#666">Diseño</h4>
 </div>
<form action="encuesta.asp" method="post" name="encuesta">
 <div class="contacttextarea">
                <select name="test0">
                    <option value="0">La mejor</option>
                    <option value="1">Buena</option>
                    <option value="2">Del Monton</option>
                    <option value="3">Mala</option>
                    <option value="4">Horrible</option>
                </select>
 </div>
 <div class="contacttextarea">
 <h4 style="color:#666">Funcionalidad</h4>
 </div>
 <div class="contacttextarea">
                <select name="test1">
                    <option value="0">La mejor</option>
                    <option value="1">Buena</option>
                    <option value="2">Del Monton</option>
                    <option value="3">Mala</option>
                    <option value="4">Horrible</option>
                </select>
 </div>
 <div class="contacttextarea">
 <h4 style="color:#666">Originalidad</h4>
 </div>
 <div class="contacttextarea">
                	<select name="test2">
                    <option value="0">La mejor</option>
                    <option value="1">Buena</option>
                    <option value="2">Del Monton</option>
                    <option value="3">Mala</option>
                    <option value="4">Horrible</option>
                </select>
 </div>
 <div class="contacttextarea">
 <h4 style="color:#666">Usabilidad</h4>
 </div>
 <div class="contacttextarea">
                <select name="test3">
                    <option value="0">La mejor</option>
                    <option value="1">Buena</option>
                    <option value="2">Del Monton</option>
                    <option value="3">Mala</option>
                    <option value="4">Horrible</option>
                </select>
 </div>
 <div class="contacttextarea">
 <h4 style="color:#666">Accesibilidad</h4>
 </div>
 <div class="contacttextarea">
                <select name="test4">
                    <option value="0">La mejor</option>
                    <option value="1">Buena</option>
                    <option value="2">Del Monton</option>
                    <option value="3">Mala</option>
                    <option value="4">Horrible</option>
                </select>
</div>
<div class="contacttextarea">
                <input class="featured-titles" type="button" onClick='puntuar()' value="puntuar" />
</div>
<div class="contacttextarea">
                <h4><a style="" href="encuesta.asp"><input class="featured-titles" type="button" value="Estadísticas" /></a></h4>
</div>
                    
            
                
            
        		
			

 </div>
                           

                
             
                
              <span class="box-arrow"></span>
            
            </div>
            </div>
