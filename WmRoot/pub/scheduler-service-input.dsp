<HTML>
   <HEAD language="JavaScript">
	<title>Assign Input Values</title>
   <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
   <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
   </HEAD>

   <BODY style="border-spacing: 0; border-width:0">
	 %switch scheduler_mode%
	 %case 'save'%
		 %invoke wm.server.schedule:convertIDataToString%
			  <input type="hidden" name="scheduleDataStr" id="scheduleDataStr" value="%value scheduleDataStr encode(html)%"/>
		  <script type="text/javascript">
		  	window.parent.setInputString((document.getElementById("scheduleDataStr")).value);
		  </script>
			%endinvoke%
			<script type="text/javascript">
				window.parent.hideSub(false);
			</script>
     %case%
		%invoke wm.server.services.adminui:serviceInfo%
       %ifvar message%
	   	<table width="100%" style="cell-spacing:0 border-spacing: 0; border-collapse:collapse; border-width:0; border-style:solid; border-color:gray">
          <tr>
            <td class="message" colspan=2>%value message%</td>
          </tr>
		  </table>

		%else%
	<table width="100%" style="cell-spacing:0 border-spacing: 0; border-collapse:collapse; border-width:0; border-style:solid; border-color:gray">

         <TR>
            <TD>
               <TABLE class="tableForm" CELLPADDING=2> %ifvar interface%
			   %invoke wm.server.schedule:getSchedulerInputWithServiceInfo%
                  <FORM name="testform1" method="post" action="scheduler-service-input.dsp" target="subFrame">

					  <input id="scheduler_mode" name="scheduler_mode" type="hidden" value="save" />
					  <input id="service" name="service" type="hidden" value="%value fullname%"/>
                     <TR>
                        <TD class="heading" colspan=2>Service Inputs</TD>
                     </TR>
                     <!-- - - - Inputs Section - - - -->
                     %ifvar newinput%
						 %loop newinput/rec_fields%
						 <TR>
							<script>writeTD("row");</script>
							%ifvar field_opt equals('true')%<i>%endif%
							%value field_name% &nbsp;&nbsp;%ifvar field_opt equals('true')%</i>%endif%


							%switch field_type%
								%case 'string'%
								<script>writeTD("row-l");</script>
								<INPUT name="%value field_name%" value="%value field_value encode(html)%"></TD>
								%case%
								<script>writeTD("row-l");</script>
								(Can't input objects)</TD>
							%endswitch%
							</TR>
                        <script>swapRows();</script>
                        %endloop%
					   	%else%
                     <TR>
                        <TD class="oddrow-l" colspan=2> No inputs to assign.</TD>
                     </TR>
					 %endif%
                     <TR>
                        <TD class="action" colspan=2>%ifvar newinput%<INPUT class="button2" type="submit" value="Save"></INPUT>
						<INPUT class="button2" type="button" value="Cancel" onclick="javascript:window.parent.hideSub(false);"></INPUT>
						   %else%
							<INPUT class="button2" type="button" value="Save" disabled="disabled"></input>
							<INPUT class="button2" type="button" value="Cancel" onclick="javascript:window.parent.hideSub(false);"></INPUT>
                           %endif%
                           </TD>
                     </TR>

				 </FORM>
				   %onerror%
					  <tr>
					  <td class="message" colspan=2>%value error% : %value errorMessage%</</td>
					  </tr>

				 %endinvoke%  %else%
                  <FORM name="testform" method="post"
                     action="service-test.dsp">
                     <TR class="heading">
                        <TD colspan=2>Specify Service Input</TD>
                     </TR>
                     <TR>
                        <TD class="oddrow">Interface</TD>
                        <TD class="oddrowdata">
                           <INPUT name="interface">
                           </INPUT></TD>
                     </TR>
                     <TR>
                        <TD class="oddrow">Service</TD>
                        <TD class="oddrowdata">
                           <INPUT name="service">
                           </INPUT></TD>
                     </TR>

                  </FORM> %endif%
               </TABLE> </TD>
         </TR>
      </TABLE>
	  %endif%
	   %onerror%
		  <tr>
		  <td class="message" colspan=2>%value error% : %value errorMessage%</</td>
		  </tr>
	  %endinvoke%
	  %endswitch%
   </BODY>
</HTML>
