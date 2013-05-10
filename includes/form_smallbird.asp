<script language="javascript">

function cuenta(){
	var caracteres = document.forms["enviar_smallbird"].Texto.value.length;
	
		
	n_caracteres = document.getElementById("n_car");
	
	x=200 - caracteres;
	
	n_caracteres.innerHTML = "<strong>"+x+"</strong>";
	
	if(caracteres>200){
		n_caracteres.style.color = "#F00"		
	}else{
		n_caracteres.style.color = "#000"
	}
		
}

function validar_smallbird(){
	
	var mensaje = document.forms["enviar_smallbird"].Texto.value;
	
	nuevo_mensaje = "";
		
	//document.forms["enviar_smallbird"].Texto.value = "hello mandarina";
	
	
	document.forms["enviar_smallbird"].submit();

	
}

</script>



		
    
    
    <div class="blogwidgetstart">
            
            <div class="widgettitle">
            	                    
                <div class="contacttitle">
                	<h2>Enviar SmallBird</h2>            
        		</div>
            
            </div>
            	
                <div class="blogcommentform">
                
                	<form action="default.asp" method="post" name="enviar_smallbird">
                    
                    <fieldset>
                    
                    	<textarea style="background:#93e4ff;color:#000" name="Texto" cols="5" rows="5" onkeydown="cuenta()" onkeyup="cuenta()"></textarea>
                    
                    </fieldset>
                    
                    <fieldset class="commentbutton_fieldset">
                    
        <table width="313" border="0">
          <tr>
            <td width="165"><input name="Submit" type="button" value="SmallBird" class="featured-titles" onclick="validar_smallbird()"></td>
            <td width="41" id="n_car" ><strong>200<strong></td>
            <td width="93" id="td_priv" ><span><strong>Privado<strong><input type="checkbox" name="privado" /></span></td>
          </tr>
        </table>
                    </fieldset>
                    
                    </form>
                
                </div>
                
              <span class="box-arrow"></span>
            
            </div>
            

