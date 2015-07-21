%ifvar mode equals('edit')%
  %ifvar disableport equals('true')%
    %invoke wm.server.net.listeners:disableListener%
    %endinvoke%
  %endif%
%endif%


%invoke wm.server.net.listeners:getListener%

<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
    <TITLE>Integration Server -- Port Access Management</TITLE>

    <SCRIPT Language="JavaScript">
        var hiddenOptions = new Array();   
        
		function allowSecureClients()
		{
			if(!document.properties.mysecureclients.checked)
			{
				document.properties.secureclients.value = "false";
			}
			else 
			{
				document.properties.secureclients.value = "true";
			}
		}

        function confirmDisable()
        {
          var enabled = "%value ../listening%";

          if(enabled == "primary")
          {
            alert("Port must be disabled to edit these settings.  Primary port cannot be disabled.  To edit these settings, please select a new primary port");
            return false;
          }
          else if(enabled == "true")
          {
            if(confirm("Port must be disabled so that you can edit these settings.  Would you like to disable the port?"))
            {
			 if(is_csrf_guard_enabled && needToInsertToken) {	
				document.location.replace("configFTPS.dsp?listenerKey=%value encode(javascript) listenerKey%&pkg=%value pkg%%ifvar listenerType%&listenerType=%value encode(javascript) listenerType%%endif%&mode=edit&disableport=true&"+_csrfTokenNm_+"="+_csrfTokenVal_);
			 } else {
				document.location.replace("configFTPS.dsp?listenerKey=%value encode(javascript) listenerKey%&pkg=%value pkg%%ifvar listenerType%&listenerType=%value encode(javascript) listenerType%%endif%&mode=edit&disableport=true");
			 }
            }
          }
          else {
		     if(is_csrf_guard_enabled && needToInsertToken) {
				document.location.replace("configFTPS.dsp?listenerKey=%value encode(javascript) listenerKey%&pkg=%value pkg%%ifvar listenerType%&listenerType=%value encode(javascript) listenerType%%endif%&mode=edit&"+_csrfTokenNm_+"="+_csrfTokenVal_);
			  } else {
				document.location.replace("configFTPS.dsp?listenerKey=%value encode(javascript) listenerKey%&pkg=%value pkg%%ifvar listenerType%&listenerType=%value encode(javascript) listenerType%%endif%&mode=edit");
			  }
		   }
          return false;
        }

        function setupData() {
            %ifvar port%
            document.properties.operation.value = "update";
            document.properties.oldPkg.value = "%value pkg%";
            %else%
            document.properties.operation.value = "add";
            %endif%
			setupKeystoreData(document.properties);
        }

      function verify() {

        var e = document.properties.port.value;
        if (( e != null ) && ( e != "" ) && !isblank(e)) {

          for (count=0; count<e.length; count++){
            var sstr = e.substring(count,count+1);
            var test = parseInt(sstr);
            if (isNaN(test)) {
              alert("Invalid Port "+e);
              return (false);
            }
          }

        }

        document.properties.submit();
        return (true);

      }

		function refreshCA()
		{
		     if(is_csrf_guard_enabled && needToInsertToken) {
				document.location.replace("configFTPS.dsp?action=refresh&listenerKey=%value encode(javascript) listenerKey%&pkg=%value pkg%%ifvar listenerType%&listenerType=%value encode(javascript) listenerType%%endif%&mode=view&listening=%value listening%&"+_csrfTokenNm_+"="+_csrfTokenVal_);
			} else {
				document.location.replace("configFTPS.dsp?action=refresh&listenerKey=%value encode(javascript) listenerKey%&pkg=%value pkg%%ifvar listenerType%&listenerType=%value encode(javascript) listenerType%%endif%&mode=view&listening=%value listening%");
			}
			return false;
		}


    </SCRIPT>
	<base target="_self">
		<style>
	  		.listbox  { width: 100%; }
		</style>
  </HEAD>


  <body onLoad="setupData();setNavigation('security-ports.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_FTPS_PortConfigScrn');">
    <TABLE width="100%">
      <TR>
        <TD class="menusection-Security" colspan=2>
          Security &gt;
          Ports &gt;
          %ifvar ../mode equals('view')%
            View FTPS Port Details
          %else%
            Edit FTPS Port Configuration
          %endif%
        </TD>
      </TR>
      
      <TR>
        <TD colspan="2">
          <UL>
            <LI><A HREF="security-ports.dsp">Return to Ports</A></LI>
            %ifvar ../mode equals('view')%
              %ifvar listening equals('primary')%
              %else%
                <LI><A onclick="return confirmDisable();" HREF="">
                  Edit FTPS Port Configuration
                </A></LI>
              %endif%
            %endif%
          </UL>
        </TD>
      </TR>
      <TR>
        <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
        <TD>
          <TABLE class="%ifvar ../mode equals('view')%tableView%else%tableForm%endif%">
          <tr>
              <td class="heading" colspan="2">FTPS Listener Configuration</td>
          <tr>

          <form name="properties" action="security-ports.dsp" method="POST" onsubmit="return submit();">
          <input type="hidden" name="factoryKey" value="webMethods/FTPS">
          <input type="hidden" name="operation">
          <input type="hidden" name="listenerKey" value="%value listenerKey%">
          <input type="hidden" name="secureclients" value=%value secureclients%>
          <input type="hidden" name="oldPkg">
			  %ifvar ../mode equals('edit')%
				<tr>
					<td class="evenrow">Enable</td>
					<td class="evenrow-l">
					  <input type="radio" name="enable" value="yes" >Yes</input>
					  <input type="radio" name="enable" value="no" checked>No</input>
					</td>
				</tr>
			  %endif%		  
              <td class="oddrow">Port</td>
              <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
                <script>writeEdit('%value -htmlall mode%', 'port', '%value -htmlall port%');</script>
              </td>
          </tr>
          <tr>
                <td class="evenrow">Alias</td>
                <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
                  %ifvar listenerKey -notempty%
                    %value portAlias% 
                  %else%
                    <input name="portAlias" value="%value portAlias%" size="60">
                  %endif%
                </td>
            </tr>
            <tr>
                <td class="oddrow">Description (optional)</td>
                <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
                  %ifvar ../mode equals('view')%
                    %value portDescription%
                  %else%
                    <input name="portDescription" value="%value portDescription%" size="60">
                  %endif%
                </td>
            </tr>

          <tr>
              <td class="evenrow">Package Name</td>
              <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
                %ifvar mode equals('view')%
                  %value pkg%
                %else%
                  %invoke wm.server.packages:packageList%
                  <select name="pkg">
                  %loop packages%
                      %ifvar enabled equals('false')%
                      %else%
                  %ifvar ../pkg -notempty%
                    <option size="15" width=30% %ifvar ../pkg vequals(name)%selected %endif%value="%value name%">%value name%</option>
                  %else%
                    <option size="15" width=30% %ifvar name equals('WmRoot')%selected %endif%value="%value name%">%value name%</option>
                  %endif%
                  %endif%
                  %endloop%
                  </select>
                  %endinvoke%
                %endif%
              </td>
          </tr>
		  <tr>
                <td class="oddrow">Bind Address (optional)</td>
                <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
				%ifvar ../mode equals('view')%
                  %value bindAddress%
                %else%
                    <input name="bindAddress" value="%value bindAddress%">
                %endif%
              </td>
           </tr>
		<tr>
	       <td class="evenrow">Passive Mode Listen Address (optional)</td>
	       <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
	  		%ifvar ../mode equals('view')%
	                     %value pasvAddr%
	                %else%
	                       <input name="pasvAddr" value="%value pasvAddr%">
	                %endif%
	       </td>
        </tr>
   	   <TR>
	      <TD class="oddrow">Secure Clients Only</TD>
		%ifvar ../mode equals('view')%
		   <TD class="oddrowdata-l">
		     %ifvar secureclients equals('true')% 
		        True 
		     %else% 
		        False 
		     %endif%
		   </TD>
		%else%
		   <TD class="oddrow-l"> 
  		            
  		     %ifvar pkg equals('')%
  		        <input type="checkbox" onclick="allowSecureClients();" id="mysecureclients" name="mysecureclients" checked >
  		     %else%
  		            
  		        %ifvar secureclients equals('true')% 
  		           <input type="checkbox" onclick="allowSecureClients();" id="mysecureclients" name="mysecureclients" checked >
  		        %else%
  		           <input type="checkbox" onclick="allowSecureClients();" id="mysecureclients" name="mysecureclients" >        
  		        %endif% 
  		            
  		     %endif%
  		       
		   </TD>

	       %endif%
	    </TR>
		   %scope param(ssl='true') param(ftps='true')%	
			%include config-common-sec-properties.dsp%
		   %endscope%	
           %include config-keystore-common.dsp%
           
          %ifvar mode equals('view')%
          %else%
          <tr>
              <td colspan="2" class="action">
            <input type="button" value="Save Changes" onclick="submit();">
              </td>
          </tr>
          %endif%
        </form>
      </table>
    </td>
  </tr>
  </table>
</body>
</html>
%endinvoke%
