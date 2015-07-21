<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt"></SCRIPT>

    <TITLE>Integration Server -- Port Access Management</TITLE>
    <SCRIPT SRC="ports.js.txt"></SCRIPT>
	
%invoke wm.server.net.listeners:ListenerAdmin%
<!-- This is a Flow Service -->
  %ifvar configURL%
    <script>
		if(is_csrf_guard_enabled && needToInsertToken) {
			document.location.replace("%value configURL%?listenerKey=%value -code listenerKey encode(url)%&pkg=%value pkg%&ssl=%value ssl%%ifvar listenerType%&listenerType=%value listenerType%%endif%%ifvar mode%&mode=%value mode%%endif%%ifvar listening%&listening=%value listening%%endif%%ifvar portName%&portName=%value encode(url) portName%%endif%&"+_csrfTokenNm_+"="+_csrfTokenVal_);
		} else {
			document.location.replace("%value configURL%?listenerKey=%value -code listenerKey encode(url)%&pkg=%value pkg%&ssl=%value ssl%%ifvar listenerType%&listenerType=%value listenerType%%endif%%ifvar mode%&mode=%value mode%%endif%%ifvar listening%&listening=%value listening%%endif%%ifvar portName%&portName=%value encode(url) portName%%endif%");
		}
	</script>
  %endif%

  %ifvar message%
    <script>
		if(is_csrf_guard_enabled && needToInsertToken) {
			document.location.replace("security-ports.dsp?message2=%value -urlencode message%&"+_csrfTokenNm_+"="+_csrfTokenVal_);
		} else {
			document.location.replace("security-ports.dsp?message2=%value -urlencode message%");
		}
	</script>
  %endif%

<!-- endinvoke for wm.server.net.listeners:ListenerAdmin -->
%endinvoke%

  </HEAD>

  <BODY onLoad="setNavigation('security-ports.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_PortsScrn');">
    <TABLE width="100%">
      <TR>
        <TD class="menusection-Security" colspan="2"> Security &gt; Ports  </TD>
      </TR>
        %ifvar message2%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message2%</TD></TR>
        %endif%

      <TR>
        <TD colspan="2">
          <UL>
            <LI><A HREF="security-ports-add.dsp">Add Port</A></LI>
            <LI><A HREF="security-ports-primary.dsp">Change Primary Port</A></LI>
            <LI><A HREF="server-ipaccess.dsp?listenerKey=global">Change Global IP Access Restrictions</A></LI>
          </UL>
        </TD>
      </TR>
      <TR>
        <TD><IMG SRC="images/blank.gif" height="10" width="10"></TD>
        <TD>
          <TABLE class="tableView" width="100%">
            %invoke wm.server.ports:listListeners%
            <TR>
              <TD class="heading" colspan="11">Port List</TD>
            </TR>

            <TR>
              <TD class="oddcol">Port</TD>
              <TD class="oddcol">Alias</TD>
              <TD class="oddcol">Protocol</TD>
              <TD class="oddcol">Type</TD>
              <TD class="oddcol">Package</TD>
              <TD class="oddcol">Enabled</TD>
              <TD class="oddcol">Access Mode</TD>
              <TD class="oddcol">IP Access</TD>
              <TD class="oddcol">Advanced</TD>
              <TD class="oddcol">Delete</TD>
              <TD class="oddcol">Description</TD>
            </TR>

            %loop listeners%
			%invoke wm.server.quiesce:isDisableQuiescePort%
            <TR>
			  <!-- PORT -->
              <script>writeTD("rowdata");</script>
                %ifvar protocol equals('Email')%
                  <A HREF="javascript:editListener(document.listeners, '%value encode(htmlcode) key%', '%value encode(htmlcode) user%@%value host%' , '%value pkg%', '%value encode(htmlcode) factoryKey%', %ifvar primary equals('true')%'primary'%else%'%value listening%'%endif%);">
                    %value encode(html) user%@%value host%
                  </A>
                %else%
				  %ifvar listenerType equals('regularinternal')%
                    <A HREF="javascript:editListener(document.listeners, '%value encode(htmlattr) key%', '%value encode(javascript) proxyHost%:%value encode(htmlattr) port%', '%value pkg%', '%value -code factoryKey%', %ifvar primary equals('true')%'primary'%else%'%value listening%'%endif%);">
				    %value proxyHost%:%value port%
                    </A>
				  %else%
					<A HREF="javascript:editListener(document.listeners, '%value encode(htmlattr) key%', '%value encode(htmlattr) port%', '%value pkg%', '%value -code factoryKey%', %ifvar primary equals('true')%'primary'%else% %ifvar isDisableQuiescePort equals('true')%'quiesce'%else%'%value listening%'%endif%%endif%);">
             %value encode(html) port%
					</A>
                  %endif%
                %endif%
              </TD>

			  <!-- ALIAS -->
              <script>writeTD("rowdata");</script>%value portAlias%</TD>

			  <!-- PROTOCOL -->
              <script>writeTD("rowdata");</script>
                    		%value protocol% </TD>

			  <!-- TYPE -->
              <script>writeTD("rowdata");</script>
                          %ifvar listenerType%
                            %switch listenerType%
                              %case 'revinvokeinternal'%
                                Enterprise Gateway Registration
                              %case 'regularinternal'%
                                Registration Internal
                              %case 'revinvoke'%
                               Enterprise Gateway External
                              %case 'Regular'%
                                %ifvar primary equals('true')%
                                  <IMG SRC="images/green_check.gif"> Primary
                                %else%
                                  Regular
                                %endif%
                              %case 'Diagnostic'%
                                Diagnostic
                              %case%
                                %value listenerType%
                              %endswitch%
                          %else%
                            Regular
                          %endif%</TD>

			  <!-- PACKAGE -->
              <script>writeTD("rowdata");</script>%value pkg%</TD>

			  <!-- ENABLED -->
              <script>writeTD("rowdata");</script>

                %ifvar primary equals('true')%
                  %ifvar listening equals('true')%
                    <img src="images/green_check.gif" border="no">Yes
                  %else%
                    &nbsp;&nbsp;&nbsp;No
                  %endif%
                %else%
                  %ifvar listening equals('true')%
                    <a class="imagelink" href="javascript:document.listeners.submit();" onClick="return enableListener(document.listeners, 'disable', '%value encode(htmlattr) key%', '%value pkg%', '%ifvar protocol equals('Email')%%value -code user%@%value host%%else%%value encode(htmlattr) key%%endif%');"><img src="images/green_check.gif" border="no">Yes</a>
                  %else%
                    &nbsp;&nbsp;&nbsp;<a href="javascript:document.listeners.submit();" onClick="return enableListener(document.listeners, 'enable', '%value encode(htmlattr) key%', '%value pkg%', '%ifvar protocol equals('Email')%%value -code user%@%value host%%else%%value encode(htmlattr) key%%endif%');">No</a>
                  %endif%
                %endif%
              </TD>

			  <!-- ACCESS MODE -->
              <script>writeTD("rowdata");</script>
                %ifvar protocol equals('Email')%
                  <A href="security-ports-editaccess.dsp?port=%value key encode(url)%%ifvar listenerType%&listenerType=%value listenerType%%endif%">
                    <!-- Edit -->
					%ifvar accessMode equals('Allow')%
						Allow
					%else%
						Deny
					%endif%
					%ifvar hasAccessList equals('true')% +%endif% 
                  </A>
                %else%
                    %ifvar provider equals('JBoss')%
                      Not Applicable
                    %else%
                      %ifvar provider equals('JBossMQ')%
                        Not Applicable
                      %else%
						%switch listenerType%
						%case 'revinvokeinternal'%
							Not Applicable
						%case 'revinvoke'%
							Not Applicable
						%case%
                          <A href="security-ports-editaccess.dsp?port=%value key encode(url)%%ifvar listenerType%&listenerType=%value listenerType%%endif%">
                          <!-- Edit  --> 
						  %ifvar accessMode equals('Allow')%
							Allow
						  %else%
							Deny
						  %endif%
						  %ifvar hasAccessList equals('true')% +%endif% 
                        </A>
                        %endswitch%
                      %endif%
                    %endif%
                %endif%
              </TD>			  

			  <!-- IP ACCESS MODE -->
              <script>writeTD("rowdata");</script>
                    %ifvar provider equals('JBoss')%
                      Not Applicable
                    %else%
                      %ifvar provider equals('JBossMQ')%
                        Not Applicable
                      %else%
                      %ifvar listenerType equals('regularinternal')%
                        Not Applicable
                      %else%
	                %ifvar protocol equals('Email')%
	                  <a href="server-ipaccess.dsp?listenerKey=%value key encode(url)%&pkg=%value pkg%">
					   %ifvar ipAccessMode equals('Allow')%
						 Allow
					   %else%
						 Deny
					   %endif%
					    %ifvar hasIPAccessList equals('true')% +%endif% 
					  </a>
	                %else%
	                  <a href="server-ipaccess.dsp?listenerKey=%value key encode(url)%&pkg=%value pkg%">
					    %ifvar ipAccessMode equals('Allow')%
						  Allow
					    %else%
						  Deny
					    %endif%
					    %ifvar hasIPAccessList equals('true')% +%endif% 
					  </a>
	                %endif%
                      %endif%
                    %endif%
              </TD>
			  
			  <!-- ADVANCED -->
              <script>writeTD("rowdata");</script>
                %ifvar primary equals('true')%
                  &nbsp;
                %else%
				  %ifvar isDisableQuiescePort equals('true')%
					 &nbsp;
				  %else%	
					 %switch protocol%
					 %case 'HTTP'%
							<a href="http-advanced.dsp?listenerKey=%value key encode(url)%&pkg=%value pkg%&listening=%ifvar listening%%value listening%%else%false%endif%">Edit</a>
					 %case 'HTTPS'%
							<a href="http-advanced.dsp?listenerKey=%value key encode(url)%&pkg=%value pkg%&listening=%value listening%">Edit</a>
					 %case%
						 Not Applicable
					 %endswitch%
				   %endif%
              	%endif%
              </TD>

			  <!-- DELETE -->
              <script>writeTD("rowdata");</script>
                <a href="javascript:document.listeners.submit();" onClick="return removeListener(document.listeners, '%value encode(htmlattr) key%', '%value pkg%', '%ifvar protocol equals('Email')%%value -code user%@%value host%%else%%value encode(htmlattr) key%%endif%' );"><img src="icons/delete.gif" border="no"></A>
              </TD>
              
       <!-- DESCRIPTION -->
              <script>writeTD("rowdata");</script>
                    		%value portDescription% </TD>

            </TR>
            <script>swapRows();</script>
			%endinvoke%
            %endloop%

            %endinvoke%
          </TABLE>
        </TD>
      </TR>
    </TABLE>

    <form name="listeners" action="security-ports.dsp" method="POST">
    <input type="hidden" name="listenerKey">
    <input type="hidden" name="portName">
    <input type="hidden" name="factoryKey">
    <input type="hidden" name="operation">
    <input type="hidden" name="mode">
    <input type="hidden" name="listening">
    <input type="hidden" name="pkg">
    </form>

    <form name="addListener" action="security-ports.dsp" method="POST">
    <input type="hidden" name="operation" value="create">
    <input type="hidden" name="action" value="edit">
    </form>

  </BODY>
</HTML>

