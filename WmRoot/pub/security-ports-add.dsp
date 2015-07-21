<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
    <TITLE>Integration Server -- Port Access Management</TITLE>
  </HEAD>

  <BODY onload="document.addListener.factoryKey[0].checked = true;setNavigation('security-ports.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_AddPortScrn');">
    <TABLE width="100%">
      <TR>
        <TD class="menusection-Security" colspan=2>
          Security &gt;
          Ports &gt;
          Add Port</TD>
      </TR>
      <TR><TD colspan="2">
      <UL>
      <LI><A HREF="security-ports.dsp">Return to Ports</A></LI>

      </UL>
        </TD>
      </TR>
      <TR>
        <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
        <TD>
          <TABLE class="tableForm">
            <TR>
              <TD class="heading" colspan="2">Select Type of Port to Configure</TD>
            </TR>
              <form name="addListener" action="security-ports.dsp" method="POST">
              <input type="hidden" name="operation" value="create">
              <input type="hidden" name="action" value="edit">
              <input type="hidden" name="mode" value="edit">
              <input type="hidden" name="listenerType" value="Regular">


            <tr>
                <td class="oddrow">Type</td>
                <td class="oddrow-l">
					%invoke wm.server.net.listeners:listAllFactories%
						%loop factories%
							%switch name%
							  %case 'webMethods/HTTP'%
								<input type="radio" name="factoryKey" value="%value key%" onclick="document.addListener.listenerType.value='Regular';">%value name%</input><BR>
							  %case 'webMethods/HTTPS'%
								<input type="radio" name="factoryKey" value="%value key%" onclick="document.addListener.listenerType.value='Regular';">%value name%</input><BR>
							  %case 'HTTP Diagnostic'%	
							   <input type="radio" name="factoryKey" value="%value key%" onclick="document.addListener.listenerType.value='Diagnostic';">HTTP Diagnostic</input><BR>
							  %case 'HTTPS Diagnostic'%	
							   <input type="radio" name="factoryKey" value="%value key%" onclick="document.addListener.listenerType.value='Diagnostic';">HTTPS Diagnostic</input><BR> 
							  %case 'Enterprise Gateway Server'%	
							   <input type="radio" name="factoryKey" value="%value key%" onclick="document.addListener.listenerType.value='revinvoke';">Enterprise Gateway Server</input><BR>
							  %case 'Internal Server'%	
							   <input type="radio" name="factoryKey" value="%value key%" onclick="document.addListener.listenerType.value='regularinternal';">Internal Server</input><BR> 
							  %case%
								<input type="radio" name="factoryKey" value="%value key%">%value key%</input><BR>
							%endswitch%
						%endloop%
					%endinvoke%
				</td>
            </tr>
            <tr>
                <td colspan="2" class="action"><input type="submit" value="Submit"></td>
            </tr>
            </form>
          </table>
        </td>
      </tr>
    </table>
  </body>
  </html>
