<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
    <TITLE>Integration Server -- IP Access Management</TITLE>
  </HEAD>

   <BODY onLoad="setNavigation('server-ipaccess-add.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_AddHoststoListScrn');">

    <TABLE width="100%">
      <TR>
        <TD class="menusection-Security" colspan=2>
          Security &gt;
          Ports &gt;
          IP Access &gt;
          Add Hosts
          %ifvar listenerKey%
			%ifvar listenerKey equals('global')%
				&gt; global
			%else%
				&gt; %value listenerKey%
			%endif%
          %endif%
      </TD>
      </TR>

      <TR>
        <TD colspan="2">
          <UL>
            <LI><A HREF="server-ipaccess.dsp?listenerKey=%value listenerKey%&pkg=%value pkg%">Return to IP Access</A></LI>
          </UL>
        </TD>
      </TR>
      <SCRIPT>
        function doAddAllow(){
       	    if (document.allowadd.allow.value==""){
    		    return false;
    		}
	    	if (!validateHostPattern(document.allowadd.allow.value))
	    		return false;
            var form = document.allowadd;
            form.submit();
            return true;
        }

        function doAddDeny(){
	    if (document.denyadd.deny.value==""){
	    	return false;
	    }
	    	if (!validateHostPattern(document.denyadd.deny.value))
	    		return false;
            var form = document.denyadd;
            form.submit();
            return true;
        }
        function validateHostPattern(hostPatterns)
		{
			var regex = new RegExp("^ *[a-zA-Z0-9\-.\*\?]+ *$");
			var hostPattersnList = hostPatterns.split(",");
			for ( i = 0; i < hostPattersnList.length ; i++)
			{
				var hostPattern = hostPattersnList[i];
				//var hostPattern = hostPattern.trim();
				var match = regex.exec(hostPattern);
				if (!match && !(isIPv6Address(hostPattern)))
				{
					alert("Invalid host pattern: " + hostPattern);
					return false; 
				}
			}
			return true;
		}
         </SCRIPT>


      <TR>
        <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
        <TD>
      %switch type%
          %case 'exclude'%
      <table class="tableForm">
            <TR>
              <TD class="heading" colspan="2">Allow Host</TD>
            </TR>
            <TR>
              <TD class="subheading" colspan="2">Separate hosts with commas</TD>
            </TR>
            <TR>
              <TD class="oddrow" valign="top">Hosts</TD>
              <TD class="oddrow-l">
                <FORM NAME="allowadd" ACTION="server-ipaccess.dsp" METHOD="POST">
                  <INPUT TYPE="hidden" NAME="action" VALUE="add">
                  <INPUT TYPE="hidden" NAME="listenerKey" VALUE="%value listenerKey%">
                  <INPUT TYPE="hidden" NAME="pkg" VALUE="%value pkg%">
                  <INPUT NAME="allow" size="40" VALUE=""></INPUT>
                  Example: *.allowme.com, *.allowme2.com
              </TD>
            </TR>
            <tr>
              <td colspan="2" class="action"><input type="button" value="Add Hosts" onClick="doAddAllow();"></td>
            </tr>
                </FORM>
          </table>
    %case 'include'%
          <TABLE class="tableForm">
            <TR>
              <TD class="heading" colspan="2">Deny Host</TD>
            </TR>
            <TR>
              <TD class="subheading" colspan="2">Separate hosts with commas</TD>
            </TR>
            <TR>
              <TD class="oddrow" valign="top">Hosts</TD>
              <TD class="oddrow-l">
                <FORM NAME="denyadd" ACTION="server-ipaccess.dsp" METHOD="POST">
                  <INPUT TYPE="hidden" NAME="action" VALUE="add">
                  <INPUT TYPE="hidden" NAME="listenerKey" VALUE="%value listenerKey%">
                  <INPUT TYPE="hidden" NAME="pkg" VALUE="%value pkg%">
                  <INPUT NAME="deny" size="40" VALUE=""></INPUT>
                  Example: *.denyme.com, *.denyme2.com
               </TD>
            </TR>
            <tr>
               <td colspan="2" class="action"><input type="button" value="Add Hosts" onClick="doAddDeny();"></td>
            </tr>
                </FORM>
          </table>
    %endswitch%
        </td>
      </tr>


    </table>
  </body>
  </html>
