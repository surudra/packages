<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
    <TITLE>Integration Server Settings</TITLE>
    <style> 
    	.noshow {display: none;}
    </style>
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
    <SCRIPT LANGUAGE="JavaScript">

		function verifyNonblankField(fld, name) 
		{		
			if (isblank(fld.value)) {
				alert(name + " is required.");
				return false;
			} else {
				return true;
			}
		}

        function verifyPositiveIntegerField(fld, name)
        {
			if (isblank(fld.value)) {
				alert(name + " is required.");
				return false;
			}
			else if (!isNum(fld.value) || parseInt(fld.value) <= 0) {
				alert(name + " must be a positive integer.");
				return false;
			}
			else {
				return true;
			}
        }

        function verifyNonnegativeIntegerField(fld, name)
        {
			if (isblank(fld.value)) {
				alert(name + " is required.");
				return false;
			}
			else if (!isNum(fld.value) || parseInt(fld.value) < 0) {
				alert(name + " must be a non-negative integer.");
				return false;
			}
			else {
				return true;
			}
        }

		function validate()
		{
			var valid = true;
			if(document.cluster.clusterAware.value == "true") {
                valid = verifyNonblankField(document.cluster.clusterName, "Cluster Name") &&
                        verifyPositiveIntegerField(document.cluster.clusterSessTimeout, "Session Timeout")  &&
                        verifyNonblankField(document.cluster.tsaURLsTA, "Terracotta Server Array URLs")
            }   
			if (valid) {
				document.forms[0].submit();
			}
		}
		
    </SCRIPT>

  </HEAD>

%ifvar doc equals('edit')%
    <BODY onLoad="setNavigation('settings-cluster.dsp','/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditClusterScrn');">
%else%
     <BODY onLoad="setNavigation('settings-cluster.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_ClusterScrn');">
%endif%

    <TABLE WIDTH="100%">
      <TR>
        <TD class="menusection-Settings" colspan="2">
          Settings &gt;
          Cluster
          %ifvar doc equals('edit')%
            &gt; Edit
          %endif%
        </TD>
      </TR>

  %ifvar action equals('update')%
    %invoke wm.server.cluster:setSettings%
      %ifvar message%
		<tr><td colspan="2">&nbsp;</td></tr>
		<TR><TD colspan=2 class="message">%value encode(html) message%</TD></TR>
      %endif%
    %endinvoke%
  %endif%

  %invoke wm.server.query:getClusterSettings%

  %comment% If 'message' is present, display it only when the Enable Clustering link is clicked. %endcomment%
  %ifvar action equals('change')%
    %ifvar clusterAware equals('true')%
      %ifvar message%
		<tr><td colspan="2">&nbsp;</td></tr>
        <TR><TD colspan=2 class="message">%value encode(htmlall) message%</TD></TR>
      %endif%
    %endif%
  %endif%

    <TR>
        <TD colspan=2>
          <UL>
			%ifvar doc equals('edit')%
				<LI><A HREF="settings-cluster.dsp">Return to Cluster Settings</A></LI>
			  %ifvar clusterAware equals('true')%
				  <LI><A HREF="settings-cluster.dsp?doc=edit&action=change&clusterAware=false">Disable Cluster</A></LI>
			  %else%
				  <LI><A HREF="settings-cluster.dsp?doc=edit&action=change&clusterAware=true">Enable Cluster</A></LI>
			  %endif%

			%else%
				<LI><A HREF="settings-cluster.dsp?doc=edit">Edit Cluster Settings</A></LI>
			%endif%
          </UL>
        </TD>
     </TR>
     
	 <TR>
        <TD></TD>
        <TD>
          <TABLE class=%ifvar doc equals('edit')%"tableForm" %else%"tableView"%endif% width="40%">

            <TR>
				<TD colspan=3 class="heading">General</TD>
            </TR>
            <TR>
				  <TD  class="oddrow">Clustering Status</TD>
				  %ifvar ../doc equals('edit')%
					  <TD class="oddrowdata-l" colspan=2>
					  %ifvar clusterAware equals('true')%
						<IMG SRC="images/enabled.gif"> Enabled %ifvar pendingRestart equals('true')% (pending restart) %endif%
					  %else%
						Disabled %ifvar pendingRestart equals('true')% (pending restart) %endif%
					  %endif%</TD>
				  %else%
					  <TD class="oddrowdata-l" colspan=2>
					  %ifvar clusterAware equals('true')%
						<IMG SRC="images/enabled.gif"> Enabled %ifvar pendingRestart equals('true')% (pending restart) %endif%
					  %else%
						Disabled %ifvar pendingRestart equals('true')% (pending restart) %endif%
					  %endif%
					  </TD>
				%endif%
			</TR>

		  %ifvar ../doc equals('edit')%
			<FORM NAME="cluster" METHOD="POST" ACTION="settings-cluster.dsp">
			<INPUT TYPE="hidden" NAME="action" VALUE="update">
			<INPUT TYPE="hidden" NAME="cluster-action" VALUE="cluster-action">
			<INPUT TYPE="hidden" NAME="clusterAware" VALUE="%value clusterAware%">
		  %endif%

			%ifvar clusterAware equals('true')%
				<TR>
					  <TD class="evenrow">Cluster Name</TD>
					  %ifvar ../doc equals('edit')%
					  <TD class="evenrow-l" colspan=2><input type="text" name="clusterName" value="%value -html clusterName%" maxlength=32></TD>
					  %else%
					  <TD class="evenrowdata-l" colspan=2><script>writeEditNullable("%value ../doc%", "clusterName", "%value encode(html) clusterName%");</script></TD>
					  %endif%
				</TR>
				<TR>
					  <TD class="oddrow">Session Timeout</TD>
					  %ifvar ../doc equals('edit')%
					  <TD class="oddrow-l" colspan=2><script>writeEditNullable("%value ../doc%", "clusterSessTimeout", "%value -code clusterSessTimeout%");</script> minutes</TD>
					  %else%
					  <TD class="oddrowdata-l" colspan=2><script>writeEditNullable("%value ../doc%", "clusterSessTimeout", "%value -code clusterSessTimeout%");</script> minutes</TD>
					  %endif%
				</TR>

				%comment% Start edit fields. %endcomment%
				%ifvar ../doc equals('edit')%
					 <TR id="terracotta">
					   <TD class="evenrow">Terracotta Server Array URLs</TD>
					   <TD class="evenrow-l" colspan=2><textarea  name="tsaURLs" id="tsaURLsTA" rows="5" cols="40">%value -code tsaURLs%</textarea><br>Use commas (,) to separate entries.</TD>
					 </TR>
					%comment% End edit fields. %endcomment%

				%else% 
				 <TR id="terracotta">
				   <TD class="evenrow">Terracotta Server Array URLs</TD>
				   <TD id="tsaURLs" class="evenrow-l" colspan=2>%value -code tsaURLs%</TD>
				 </TR>  
            %endif%
      %endif%

      %ifvar doc equals('edit')%
			<TR>
              <TD class="space" colspan="3" >&nbsp;</TD>
            </TR>
            <TR>
              <TD colspan=3 class="action">
                <INPUT type="button" onclick="validate();" value="Save Settings"></TD>
            </TR>
          </FORM>
      %endif%

        <tr><td class="space" colspan="3">&nbsp;</td></tr>
			%comment% Only show cluster hosts when not in 'edit' mode. %endcomment%
			%ifvar doc equals('edit')% %else%
               <TR>
                  <TD class="heading" colspan="14">Cluster Hosts</TD>
               </TR>
               %ifvar hosts%
                 <TR>
                   <TD class="oddcol">Name</TD>
                   <TD class="oddcol">Address</TD>
                   <TD class="oddcol">Server Start Time</TD>
                   <TD class="oddcol">Server Up Time</TD>
                   <TD class="oddcol">Total Memory (KB)</TD>
                   <TD class="oddcol">Free Memory (KB)</TD>
                   <TD class="oddcol">Used Memory (KB)</TD>
                   <TD class="oddcol">Current Server Threads</TD>
                   <TD class="oddcol">Max Server Threads</TD>
                   <TD class="oddcol">Current System Threads</TD>
                   <TD class="oddcol">Max System Threads</TD>
                   <TD class="oddcol">Total Requests</TD>
                   <TD class="oddcol">Average Duration (ms)</TD>
                 </TR>
               %loop hosts%
               <TR>
                  <script>writeTD("rowdata");</script>%value server%</TD>
                  <script>writeTD("rowdata");</script>%value hostAddress%</TD>
                  <script>writeTDnowrap("rowdata");</script>%value startTime%</TD>
                  <script>writeTD("rowdata");</script>%value uptime%</TD>
                  <script>writeTD("rowdata");</script>%value totalMem%</TD>
                  <script>writeTD("rowdata");</script>%value freeMem%</TD>
                  <script>writeTD("rowdata");</script>%value usedMem%</TD>
                  <script>writeTD("rowdata");</script>%value svrT%</TD>
                  <script>writeTD("rowdata");</script>%value svrTMax%</TD>
                  <script>writeTD("rowdata");</script>%value sysT%</TD>
                  <script>writeTD("rowdata");</script>%value sysTMax%</TD>
                  <script>writeTD("rowdata");</script>%value reqTotal%</TD>
                  <script>writeTD("rowdata");</script>%value reqAvg%</TD>
               </TR> 
               %endloop%
               %else%
               <TR>
                 <TD class="oddrow-l" colspan=3>No Cluster Hosts</TD>
               </TR>
               %endif%
%endif%
           %endinvoke%


      </TABLE>
    </TD>
  </TR>
</TABLE>

</BODY>
</HTML>
