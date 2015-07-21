<HTML><HEAD>
<TITLE>Select Logical Server Type</TITLE>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<SCRIPT src="webMethods.js"></SCRIPT>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<BODY>

<SCRIPT language=JavaScript>
</SCRIPT>

<TABLE width="100%">
	<TR>
		<TD class="menusection-DeployerServers" colspan="3">%value name% > Select Logical Server Type</TD>
	</TR>
</TABLE>
<TABLE width="100%">
  <TBODY>

		<TR>
			<TD colspan="2">
     		<UL>	
        	<LI><a onclick="startProgressBar();" href="edit-plugin-server.dsp?pluginType=%value pluginType%&name=%value name%">Return to %value name% > Properties</a>
     		</UL>	
			</TD>
		</TR>

    <TR>
      <TD><IMG height="10" src="images/blank.gif" width="10"></TD>
    </TR>
    <TR>
      <TD><IMG height="0" src="images/blank.gif" width="10"></TD>
      <TD valign="top">
        <TABLE class="tableForm">
          <TBODY>
            <TR>
              <TD class="heading" colspan="2">Select Logical Server Type</TD>
            </TR>
            <FORM name="slectTypeForm" action=add-plugin-logical-server.dsp method=post>
            <INPUT type="hidden" name="name" VALUE="%value name%">
            <INPUT type="hidden" name="pluginType" VALUE="%value pluginType%">

						<TR>
							<TD class="oddrow">Type</TD>
							<TD class="oddrow-l">
								<input type="radio" name="logicalPluginName" value="IS" CHECKED>IS & TN<BR>
									%invoke wm.deployer.gui.UIPlugin:listPlugins%  
										%ifvar plugins -notempty%
											%loop plugins%
												%ifvar pluginType vequals(../pluginType)%
												%else%
								<input type="radio" name="logicalPluginName" value="%value pluginType%">%value pluginType%<BR>
												%endif%
											%endloop%
										%endif%        
									%endinvoke%        
							</TD>
						</TR>

            <TR>
              <TD class="action" colspan="2">
								<INPUT type="submit" VALUE="Go to next step" name="submit">
							</TD>
            </TR>
    				</FORM>
          </TBODY>
        </TABLE>
      </TD>
    </TR>
  </TBODY>
</TABLE>

</BODY>
</HTML>
