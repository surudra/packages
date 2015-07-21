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
					document.location.replace("configSSLSOCK.dsp?listenerKey=%value -htmlcode listenerKey%&pkg=%value pkg%%ifvar listenerType%&listenerType=%value -htmlcode listenerType%%endif%&mode=edit&disableport=true&"+_csrfTokenNm_+"="+_csrfTokenVal_ );
				} else {
					document.location.replace("configSSLSOCK.dsp?listenerKey=%value -htmlcode listenerKey%&pkg=%value pkg%%ifvar listenerType%&listenerType=%value -htmlcode listenerType%%endif%&mode=edit&disableport=true");
				}
            }
          }
          else {
			if(is_csrf_guard_enabled && needToInsertToken) {
				document.location.replace("configSSLSOCK.dsp?listenerKey=%value -htmlcode listenerKey%&pkg=%value pkg%%ifvar listenerType%&listenerType=%value -htmlcode listenerType%%endif%&mode=edit&"+_csrfTokenNm_+"="+_csrfTokenVal_ );
			} else {
				document.location.replace("configSSLSOCK.dsp?listenerKey=%value -htmlcode listenerKey%&pkg=%value pkg%%ifvar listenerType%&listenerType=%value -htmlcode listenerType%%endif%&mode=edit");
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
        }
    </SCRIPT>

  </HEAD>
  <body onLoad="setupData();setNavigation('security-ports.dsp', 'doc/OnlineHelp/WmRoot.htm#CS_Security_Ports_EditSSLSOCK.htm', 'foo');">
    <TABLE width="100%">
      <TR>
        <TD class="menusection-Security" colspan=2>
          Security &gt;
          Ports &gt;
          %ifvar ../mode equals('view')%
            View SSL Socket Listener Details
          %else%
            Edit SSL Socket Listener Configuration
          %endif%
        </TD>
      </TR>
      <TR>
        <TD colspan="2">
          <UL>
            <LI><A HREF="security-ports.dsp">Return to Ports</A></LI>
            %ifvar ../mode equals('view')%
              %ifvar ../listening equals('primary')%
              %else%
                <LI><A onclick="return confirmDisable();" HREF="">
                  Edit SSL Socket Listener Configuration
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
              <td class="heading" colspan="2">SSL Socket Listener Configuration</td>
          <tr>
          <form name="properties" action="security-ports.dsp" method="POST">
          <input type="hidden" name="factoryKey" value="webMethods/SSLSOCK">
          <input type="hidden" name="operation">
          <input type="hidden" name="listenerKey" value="%value listenerKey%">
          <input type="hidden" name="oldPkg">
      %ifvar listenerType%
        <input type="hidden" name="listenerType" value="%value listenerType%">
        %endif%

              <td class="oddrow">Port</td>
              <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
                %ifvar ../mode equals('view')%
                  %value port%
                %else%
                  <input name="port" value="%value port%">
                %endif%
              </td>
          </tr>
          <tr>
              <td class="evenrow">Client Authentication</td>
              <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
                %ifvar mode equals('view')%
                  %switch clientAuth%
                    %case 'none'%None
                    %case 'request'%Request Client Certificates
                    %case 'require'%Require Client Certificates
                    %case%None
                  %endswitch%
                %else%
                  <select name="clientAuth">
                  <option %ifvar clientAuth equals('none')%selected %endif%value="none">None</option>
                  <option %ifvar clientAuth equals('request')%selected %endif%value="request">Request Client Certificates</option>
                  <option %ifvar clientAuth equals('require')%selected %endif%value="require">Require Client Certificates</option>
                  </select>
                %endif%
              </td>
          </tr>
          <tr>
              <td class="oddrow">Package Name</td>
              <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
                %ifvar ../mode equals('view')%
                  %value pkg%
                %else%
                  %invoke wm.server.packages:packageList%
                  <select name="pkg">
                  %loop packages%
                      %ifvar enabled equals('false')%
                      %else%
                      %ifvar ../pkg -notempty%
                      <option %ifvar ../pkg vequals(name)%selected %endif%value="%value name%">%value name%</option>
                      %else%
                      <option %ifvar name equals('WmRoot')%selected %endif%value="%value name%">%value name%</option>
                      %endif%
                      %endif%
                  %endloop%
                  </select>
                  %endinvoke%
                %endif%
              </td>
          </tr>
		  <tr>
                <td class="evenrow">Bind Address (optional)</td>
                <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
				%ifvar ../mode equals('view')%
                  %value bindAddress%
                %else%
                    <input name="bindAddress" value="%value bindAddress%">
                %endif%
              </td>
           </tr>
          <tr>
            <td class="space" colspan="2">&nbsp;</td>
          </tr>
          <tr>
              <td class="heading" colspan="2">Listener Specific Credentials (Optional)</td>
          </tr>
          <tr>
              <td class="oddrow">Server's Certificate</td>
              <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
                <script>writeEdit('%value -htmlcode mode%', 'signedCert', '%value -code certChain[0]%');</script>
              </td>
          </tr>
          <tr>
              <td class="evenrow">Authority's Certificate</td>
              <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
                <script>writeEdit('%value -htmlcode mode%', 'caCert', '%value -code certChain[1]%');</script>
              </td>
          </tr>
          <tr>
              <td class="oddrow">Private Key</td>
              <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
                <script>writeEdit('%value -htmlcode mode%', 'privKey', '%value -code privKey%');</script>
              </td>
          </tr>
          <tr>
              <td class="evenrow">Trusted Authority Directory</td>
              <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
                <script>writeEdit('%value -htmlcode mode%', 'caDir', '%value -code caDir%');</script>
              </td>
          </tr>

          %ifvar mode equals('view')%
          %else%
          <tr>
              <td colspan="2" class="action">
                  <input type="submit" value="Save Changes">
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
