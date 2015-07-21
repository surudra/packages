<html>
    <script Language="JavaScript">

    </script>

    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <META HTTP-EQUIV="Expires" CONTENT="-1">
        <title>Integration Server Settings</title>
        <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
        <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
    </head>

   <BODY onLoad="setNavigation('xamanualrecovery.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_XAManualRecoveryScrn');">
        <table width="100%">
        
            <!-- ------------------------- -->
            <!-- delete xid                -->
            <!-- ------------------------- -->
            %ifvar deleteXid equals('true')%
                %invoke wm.server.xarecovery:eraseTransaction% <!-- xid was passed in from details page -->
                %onerror%
                    <script>writeMessage('%value errorMessage%');</script>
                %endinvoke%
            %endif%
            <!-- ------------------------- -->
            <!-- set the value of writeRecoveryRecord field if it is passed in-->
            <!-- ------------------------- -->
            %ifvar writeRecoveryRecord%
                %invoke wm.server.xarecovery:setWriteRecoveryRecord% <!-- value was passed in from this page itself -->
				%endinvoke%
            %endif%

            <tr>
                <td class="menusection-Settings" colspan=2>
                    Settings &gt; Resources &gt; XA Manual Recovery
                </td>
            </tr>
			<tr>
                <td colspan=2>
                    <ul>
                        <li><a href="settings-resources.dsp">Return to Resource Settings</a></li>
                    </ul>
                </td>
            </tr>
			<!-- ------------------------- -->
            <!-- invoke lookup service     -->
            <!-- ------------------------- -->
            %invoke wm.server.xarecovery:getWriteRecoveryRecord%
				%ifvar writeRecoveryRecord equals('false')%
				<tr>
					<td colspan=2>
                    	<ul>
                        	<li><a href="xamanualrecovery.dsp?writeRecoveryRecord=true">Enable XA Transaction Recovery</a> </li>
		                </ul>
        	        </td>
				</tr>
               %else%                
			   <tr>
					<td colspan=2>
                    	<ul>
                        	<li><a href="xamanualrecovery.dsp?writeRecoveryRecord=false">Disable XA Transaction Recovery</a> </li>
		                </ul>
        	        </td>
				</tr>
            <!-- ------------------------- -->
            <!-- invoke lookup service     -->
            <!-- ------------------------- -->
            %invoke wm.server.xarecovery:getUnresolvedTXs%

            <tr>
                <td><IMG SRC="images/blank.gif" height=10 width=10>&nbsp;</td>
                <td width="100%">
                    <table class="tableView">
                    
                        <!-- ---------------- -->
                        <!-- write header     -->
                        <!-- ---------------- -->
                        
                        <tr>
                            <td class="heading" colspan=5>Unresolved XA Transactions</td>
                        </tr>
                        <tr>
                            <td class="oddcol-l">XID</td>
                            <td class="oddcol-l">Global&nbsp;2PC&nbsp;State</td>
                            <td class="oddcol-l">Error&nbsp;Message</td>
                            <td class="oddcol-l">Recovery&nbsp;Action Attempted</td>
                        </tr>
                            
                        <!-- ---------------------- -->
                        <!-- write line-item detail -->
                        <!-- ---------------------- -->
                            
                        %loop unresolvedTXs%
                            
                        <tr>
                            <script>writeTD("rowdata-l");</script><a href="xamanualrecovery-details.dsp?xid=%value xid%&globalState=%value 2PCState%">%value xid%</a></td>
                            <script>writeTD("rowdata-l");</script>%value 2PCState%</td>
                            <script>writeTD("rowdata-l");</script>%value error%</td>
                            <script>writeTD("rowdata-l");</script>%value recoveryActionAttempted%</td>
                          <!--  <td class="evenrowdata-l"><a href="javascript:document.listeners.submit();" onClick="return eraseTransaction(document.listeners, '%value -code xid%' );"><img src="icons/delete.gif" border="no"></A></td> -->
                        </tr>
                        
                        <script>swapRows();</script>       
                            
                        %endloop%
                            
                    </table>
                </td>
            </tr>
            %onerror%
                <script>writeMessage('%value errorMessage%');</script>
            %endinvoke%
			%endif%
		%endinvoke%
        </table>
    </body>
</html>
