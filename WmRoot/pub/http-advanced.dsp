%ifvar op equals('Apply')%
  %invoke wm.server.net.listeners:httpControls%
  %endinvoke%
%endif%

%invoke wm.server.net.listeners:getListener%

<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
    <TITLE>Advanced Port Controls</TITLE>
    <SCRIPT Language="JavaScript">
	
	function  setOperation(form1)
	{
		form1.op.value = "Apply";
		return true;
	}
        function changeAction(form) {
			if(null != form.op && undefined != form.op)
				form.op.value = "Cancel";
            form.action = "security-ports.dsp"
            return true;
        }

        function checkSuspend(form) {
            if (form.suspended.value == "true")
            {
              alert("Listener suspended, must be resumed before other controls can be applied");
              return false;
            }
            if (form.listenerCntl.checked)
            {
              var msg = "";
			  if(form.listenerCntl.value == 'resume')
				msg = "Other controls can not be applied when resume has been selected.";
			  if(form.listenerCntl.value == 'suspend')
				msg = "Other controls can not be applied when suspend has been selected.";
			  alert(msg);
              return false;
            }
            return true;
        }
        function clearOtherAction(form) {
            document.properties.actionListener.checked = false;
            document.properties.actionListener.value = "";
            document.properties.stepsizeListener.value = "";
            document.properties.actionThreadPool.checked = false;
            document.properties.actionThreadPool.value = "";
            document.properties.numThreads.value = "";
            return true;
        }
    </SCRIPT>
    </HEAD>
  <BODY onLoad="setNavigation('security-ports.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_AdvancedControlsScrn');">
  <TABLE width="100%">
   <TR>
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message%</TD></TR>
        %endif%
      <TD class="menusection-Security" colspan=2>
        Security &gt;
        Ports &gt;
        Advanced Controls
        %ifvar listenerKey%
           &gt %value listenerKey%
        %endif%
      </TD>
   </TR>
   <TR>
      <TD colspan="2">
          <UL>
            <LI><A HREF="security-ports.dsp">Return to Ports</A></LI>
          </UL>
      </TD>
   </TR>
   <TR>
     <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
     <TD>
       <TABLE class="tableForm">
          <tr>

            <form name="properties" action="http-advanced.dsp" method="POST">
            <input type="hidden" name="factoryKey" value="webMethods/HTTP">
            <input type="hidden" name="pkg" value="%value pkg%">
            <input type="hidden" name="listenerKey" value="%value listenerKey%">
            <input type="hidden" name="listening" value="%value listening%">
            <input type="hidden" name="threadPool" value="%value threadPool%">
            <input type="hidden" name="listenerType" value="%value listenerType%">
            <input type="hidden" name="minThread" value="%value minThread%">
            <input type="hidden" name="ssl" value="%value ssl%">
            <input type="hidden" name="suspended" value="%value suspended%">
			<!--added for PIE-21143 can not localize Apply button in http-advanced.dsp -->
			<input type="hidden" name="op" id="op" value="">

           <tr>
             <td class="heading" colspan="2">
                %switch listenerType%
                    %case 'Regular'%Regular
                    %case 'revinvoke'%Enterprise Gateway External
                    %case 'revinvokeinternal'%Enterprise Gateway Registration 
                    %case 'regularinternal'%Registration Internal
                    %case 'Diagnostic'%Diagnostic
                  %endswitch%
                  %ifvar ssl equals('true')%
                    HTTPS
                  %else%
                    HTTP
                  %endif%
             Listener State</td>
           </tr>
           <tr>
              <td class="oddrow">Started</td>
              <td class="oddrowdata-l">
                 %switch listening%
                    %case 'true'%Yes
                    %case 'false'%No
                    %case%Unknown
                 %endswitch%
              </td>
           </tr>
           <tr>
              <td class="oddrow">Suspended</td>
              <td class="oddrowdata-l">
                 %switch suspended%
                    %case 'true'%Yes
                    %case 'false'%No
                    %case%No
                 %endswitch%
              </td>
           </tr>
           <tr>
              <td class="oddrow">Throttled</td>
              <td class="oddrowdata-l">
                 %ifvar curDelay equals('0')%
                    No
                 %else%
                    Yes [%value curDelay%ms]
                 %endif%
              </td>
           </tr>

           %ifvar threadPool equals('true')%
           <tr>
             <td class="heading" colspan="2">Private Thread Pool</td>
           </tr>
            <tr>
              <td class="oddrow">Max Number Threads</td>
              <td class="oddrowdata-l">
                 %value maxThread%
              </td>
            </tr>
           %endif%

           %ifvar listenerType equals('regularinternal')%
             <tr>
               <td class="heading" colspan="2">Internal Server Registration Port</td>
             </tr>
             <tr>
               <td class="oddrow">Max Number Connections</td>
               <td class="oddrowdata-l">
                 %value maxConnections%
               </td>
             </tr>
           %endif%

           <tr>
            <td class="space" colspan="2">&nbsp;</td>
           </tr>
           <tr>
           %ifvar listenerType equals('regularinternal')%
             <tr>
               <td class="heading" colspan="2">Internal Server Registration Port Controls</td>
             </tr>
          <tr>
             <td class="oddrow">
               <input type="radio" name="actionMaxConns" value="increase" %ifvar actionMaxConns equals('increase')%checked%endif%>Increase By
               <input type="radio" name="actionMaxConns" value="decrease" %ifvar actionMaxConns equals('decrease')%checked%endif%>Decrease By
               <input type="radio" name="actionMaxConns" value="set" %ifvar actionMaxConns equals('set')%checked%endif%>Set To</td>
             </td>
             <td class="oddrow-1">
               <input type="text" name="maxConns" value="%value maxConns%">Connections
             </td>
           </tr>
           %else%
           <tr>
             <td class="heading" colspan="2">Listener Controls</td>
           </tr>
           <tr>
             %ifvar suspended equals('true')%
                 <td class="oddrow">Resume</td>
               <td class="oddrow-l">
                 <input type="checkbox" name="listenerCntl" value="resume" onclick="return clearOtherAction(document.properties);"></input>
               </td>
             %else%
                 <td class="oddrow">Suspend</td>
               <td class="oddrow-l">
              <input type="checkbox" name="listenerCntl" value="suspend" onclick="return clearOtherAction(document.properties);"></input>
               </td>
             %endif%
           </tr>
           <tr>
             <td class="oddrow">
               <input type="radio" name="actionListener"  value="increase" %ifvar actionListener equals('increase')%checked%endif% onclick="return checkSuspend(document.properties);">Increase By
               <input type="radio" name="actionListener"  value="decrease" %ifvar actionListener equals('decrease')%checked%endif% onclick="return checkSuspend(document.properties);">Decrease By
               <input type="radio" name="actionListener"  value="set" %ifvar actionListener equals('set')%checked%endif% onclick="return checkSuspend(document.properties);">Set To</td>
             </td>
             <td class="oddrow-l">
               <input name="stepsizeListener" value="%value stepsizeListener%"  onClick="return checkSuspend(document.properties);">Delay(ms)
             </td>
           </tr>
          %endif%

           %ifvar threadPool equals('true')%
           <tr>
             <td class="heading" colspan="2">Private Thread Pool Controls</td>
           </tr>
           <tr>
             <td class="oddrow">
               <input type="radio" name="actionThreadPool" value="increase" %ifvar actionThreadPool equals('increase')%checked%endif% onClick="return checkSuspend(document.properties);" >Increase By
               <input type="radio" name="actionThreadPool" value="decrease" %ifvar actionThreadPool equals('decrease')%checked%endif% onClick="return checkSuspend(document.properties);">Decrease By
               <input type="radio" name="actionThreadPool" value="set" %ifvar actionThreadPool equals('set')%checked%endif% onClick="return checkSuspend(document.properties);" >Set To</td>
             </td>
             <td class="oddrow-l">
               <input name="numThreads" value="%value numThreads%" onClick="return checkSuspend(document.properties);">Threads
             </td>
           </tr>
           %endif%

            <tr>
                <td  class="action">
                    <input type="submit" name="submitButton" value="Apply" onclick="return setOperation(this.form);">
                </td>
                <td  class="action">
                    <input type="submit" name="cancelButton" value="Cancel" onclick="return changeAction(document.properties);">
                </td>
            </tr>
			
      </form>
        </table>
      </td>
    </tr>
</TABLE>
</BODY>





</HTML>
%endinvoke%
