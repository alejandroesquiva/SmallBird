          
        
        </div>

        <div class="rightsection rightsectionalt">
        
<%
if(Session("estado") = "true") then
%>
<!--#include file="mod_logueado.asp"-->

<%else%>
<!--#include file="mod_no_logueado.asp"-->
<%
end if
%>


        	
        </div>
        <!-- End Right Section -->
    
    </div>
    <!-- End Main Body Wrap -->

</div>
<!--#include file="footer.asp"-->
<!-- Start Scroll To Top Div -->
<div id="scrolltab"></div>
<!-- End Scroll To Top Div -->