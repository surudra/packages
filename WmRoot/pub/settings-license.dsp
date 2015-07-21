<HTML>
  <HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


    <TITLE>Integration Server Settings</TITLE>
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt">
    </SCRIPT>
  </HEAD>

  <BODY onLoad="setNavigation('settings-license.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_LicensingScrn');">
      <TABLE width=100%>
        <TR>
          <TD class="menusection-Settings" colspan="2">Settings &gt; License
          </TD>
        </TR>

        <TR>
          <TD colspan=2>
            <UL>
              <LI><A HREF="settings-license-edit.dsp">Licensing Details</A></LI>
            </UL>
          </TD>
        </TR>
        <TR>
	  <TD>
	  </TD>
	  <TD>
		<TABLE>
		<TR>
		   <TD class="heading" colspan=11>License Information</TD>
		</TR>

	        <TR>
	           <TD class="oddcol">Feature Name</TD>
	           <TD class="oddcol">Enabled</TD>
                </TR>

			%invoke wm.server.query:getLicenseInfo%
			   %loop LicenseInfo%
			      %loop -struct%
			      <TR>
				 <script>writeTD("row");</script>%value $key%</TD>
				 %ifvar #$key equals('true')%
				 <script>writeTD("rowdata");</script><img src="images/green_check.gif" border="no">Yes</TD>
				 %else%
				 <script>writeTD("rowdata");</script><img src="icons/delete.gif" border="no">No</TD>
				 %endif%
				 <script>swapRows();</script>
			      </TR>
			      %endloop%
			   %endloop%
			%endinvoke%
		</TD>
        </TR>
        </TABLE>

</TABLE>
  </BODY>
</HTML>
