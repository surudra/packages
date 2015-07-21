<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt">
    </SCRIPT>
    <TITLE>Integration Server -- Port Access Management</TITLE>
  </HEAD>


        %switch Action%
          %case 'resetPort'%
            %invoke wm.server.portAccess:resetPort%
              <script>
					if(is_csrf_guard_enabled && needToInsertToken) {
						document.location.replace("security-ports-editaccess.dsp?port=%value -urlencode port encode(url)%%ifvar message%&message=%value -urlencode message%%endif%&"+_csrfTokenNm_+"="+_csrfTokenVal_);
					} else {	
						document.location.replace("security-ports-editaccess.dsp?port=%value -urlencode port encode(url)%%ifvar message%&message=%value -urlencode message%%endif%");
					}
			   </script>
            %endinvoke%
          %case 'addNode'%
            %invoke wm.server.portAccess:addNodes%
              <script>
					if(is_csrf_guard_enabled && needToInsertToken) {
						document.location.replace("security-ports-editaccess.dsp?port=%value -urlencode port encode(url)%%ifvar message%&message=%value -urlencode message%%endif%&"+_csrfTokenNm_+"="+_csrfTokenVal_);
					} else {	
						document.location.replace("security-ports-editaccess.dsp?port=%value -urlencode port encode(url)%%ifvar message%&message=%value -urlencode message%%endif%");
					}	
			  </script>
            %endinvoke%
          %case 'deleteNode'%
            %invoke wm.server.portAccess:deleteNode%
              <script>
					if(is_csrf_guard_enabled && needToInsertToken) {
						document.location.replace("security-ports-editaccess.dsp?port=%value -urlencode port encode(url)%%ifvar message%&message=%value -urlencode message%%endif%&"+_csrfTokenNm_+"="+_csrfTokenVal_);
					} else {
						document.location.replace("security-ports-editaccess.dsp?port=%value -urlencode port encode(url)%%ifvar message%&message=%value -urlencode message%%endif%");
					}					
			  </script>
            %endinvoke%
          %case 'setType'%
            %invoke wm.server.portAccess:setType%
              <script>
					if(is_csrf_guard_enabled && needToInsertToken) {
						document.location.replace("security-ports-editaccess.dsp?port=%value -urlencode port encode(url)%%ifvar message%&message=%value -urlencode message%%endif%&"+_csrfTokenNm_+"="+_csrfTokenVal_);
					} else {
						document.location.replace("security-ports-editaccess.dsp?port=%value -urlencode port encode(url)%%ifvar message%&message=%value -urlencode message%%endif%");
					}		
			  </script>
            %endinvoke%
        %endswitch%





  <BODY onLoad="setNavigation('security-ports.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_EditAccessModeScrn');">

    <FORM action="security-ports-editaccess.dsp" method="POST">
    <INPUT TYPE="HIDDEN" NAME=Action VALUE="addNode">
    <INPUT TYPE="HIDDEN" NAME=Page VALUE="Edit">

    <TABLE width="100%">

    <TR>
      <TD class="menusection-Security" colspan=2>
        Security &gt;
        Ports &gt;
        Edit Access Mode &gt;
        %value port% </TD>
    </TR>

  %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
    <TR><TD class="message" colspan="2">%value message%</TD></TR>
  %endif%

    <TR>
      <TD colspan="2">
    %ifvar listenerType equals('registration')%
      <UL>
          <LI><A href="security-ports.dsp">Done</A></LI>
      </UL>
       <TR>
        <TD  class="heading"colspan=2>Service Lists cannot be edited on a Registration Listener</TD>
       </TR>
    %else%

    %invoke wm.server.portAccess:getPort%

        <UL>
          <LI><A href="security-ports.dsp">Return to Port List</A></LI>
          %switch type%
            %case 'exclude'%
              <LI><A href="security-ports-addaccess.dsp?port=%value port encode(url)%">Add Folders and Services to Allow List</A></LI>
              <LI><a onclick="return confirm('Warning: You will allow access to all services through this port until services are added to the deny list.  The current service list will be cleared.  Are you sure?');" href="security-ports-editaccess.dsp?port=%value port encode(url)%&Action=setType&type=include">Set Access Mode to Allow by Default</A>
            %case 'include'%
              <LI><A href="security-ports-addaccess.dsp?port=%value port encode(url)%">Add Folders and Services to Deny List</A></LI>
              <LI><a onclick="return confirm('Warning: You will block all access to the server through this port until services are added to the allow list.  The current service list will be cleared and defaults will be provided.  Are you sure?');" href="security-ports-editaccess.dsp?port=%value port encode(url)%&Action=setType&type=exclude">Set Access Mode to Deny by Default</A>
          %endswitch%
          <LI><A href="security-ports-editaccess.dsp?port=%value port encode(url)%&Action=resetPort"
                 onClick="return confirm('Warning: You will block all access to the server through this port until services are added to the allow list.  The current service list will be cleared and defaults will be provided.  Are you sure?');"
                 >Reset to default access settings</A></LI>
        </UL>
      </TD>
    </TR>

    <TR>
      <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
      <TD width=100%>
        <TABLE class="tableView">


        <!-- Display Edit Page -->


        <!-- GENERATE PORT LIST -->

       <TR>
          <TD class="heading" colspan=2>Port Service Access Settings</TD>
        </TR>
	    %ifvar port%
     	   <INPUT TYPE="hidden" NAME="port" VALUE="%value port%">
        %endif%
       <TR>
          <TD class="oddrow">Access Mode</TD>
          <TD class="oddrowdata-l">
                %switch type%
                  %case 'include'%
                    Allow by Default
                  %case 'exclude'%
                    Deny by Default
                %endswitch%
                </SELECT>
          </TD>
        </TR>
        </TABLE>
        <BR>
        <TABLE class="tableView">

        <TR>
          <TD class="heading" colspan=2>
            %switch type%
              %case 'include'%
                Deny List
              %case 'exclude'%
                Allow List
            %endswitch%
          </TD>
        </TR>
        <TR>
          <TD class="oddcol">Folders and Services</TD>
          <TD class="oddcol">Remove</TD>
        </TR>
        %loop nodeList%
        <TR>
            <script>writeTD("rowdata-l");</script>%value%</TD>
            <script>writeTD("rowdata");</script>
                   <a href="security-ports-editaccess.dsp?port=%value port encode(url)%&node=%value -urlencode%&Action=deleteNode&Page=Edit">
                   <img src="icons/delete.gif" border="no"></a>
            </TD>
            <script>swapRows();</script>
        </TR>
        %endloop%
        %endinvoke%
    %endif%
        </TABLE>
      </TD>
    </TR>
  </TABLE>
</FORM>
</BODY>
</HTML>

