<HTML>
    <script Language="JavaScript">
    
        function verifyNonblankField(v, name)
        {
            if (isblank(v.value)) {
                alert(name + " is required.");
                return false;
            }
            else {
                return true;
            }
        }

        function verifyPositiveIntegerField(v, name, needCheck)
        {
            if (needCheck)
            {
            	if (isblank(v.value)) {
                	alert(name + " is required.");
                	return false;
            	}
            	else if (!isNum(v.value) || parseInt(v.value) <= 0) {
                	alert("Value must be a positive integer: "+name);
                	return false;
            	}
            	else {
                	return true;
            	}
            } else
            	return true;
        }

        function confirmEdit(isBrokerConfigured) {
            var defaultStoreDBGroup                 = document.editform.defaultStoreDBGroup;
            var defaultStoreDBSize                  = document.editform.defaultStoreDBSize;

            if (verifyNonblankField(defaultStoreDBGroup, "Store Location")  &&
                verifyPositiveIntegerField(defaultStoreDBSize, "Initial Store Size", true))
                       
                return true;
            else
                return false;
        }
        
    </script>

    <HEAD>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <meta http-equiv="Expires" content="-1">
        <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
        <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
    </HEAD>

    <BODY onLoad="setNavigation('settings-xastores-edit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditXARecoveryStoreScrn');">
        <TABLE width="90%">
            <TR>
                <TD class="menusection-Settings" colspan="2">
                    Settings &gt; Resources &gt; Store Settings &gt; Edit XA Recovery Store Settings<br>
                </TD>
            </TR>

            <TR>
                <TD colspan="2">
                    <UL>
                        <LI><A HREF="settings-docstores.dsp">Return to Store Settings</A></LI>
                    </UL>
                </TD>
            </TR>

            <TR>
                <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
                <TD width="100%">
                    <TABLE class="tableView">
                        <FORM NAME="editform" ACTION="settings-docstores.dsp" METHOD="POST" onsubmit="return confirmEdit()">
                            <input type="hidden" name="action" value="editXA" />

                                %invoke wm.server.xarecovery:getXARecoveryStoreSettings%
                                
                                <TR>
                                    <TD class="heading" colspan=3>XA Recovery Store</TD>
                                </TR>

                                <TR>
                                    <TD class="oddrow">Store Location</TD>
                                    <TD class="oddrowdata-l">
                                        <INPUT NAME="defaultStoreDBGroup" VALUE="%value defaultStoreDBGroup%" />
                                    </TD>
                                    <TD class="oddrowdata-l">*</TD>
                                </TR>
                                <TR>
                                    <TD class="evenrow">Initial Store Size (MB)</TD>
                                    <TD class="evenrowdata-l">
                                        <INPUT NAME="defaultStoreDBSize" VALUE="%value defaultStoreDBSize%" />
                                    </TD>
                                    <TD class="evenrowdata-l">*</TD>
                                </TR>
                                
                                %onerror%
                                    <script>writeMessage('%value errorMessage%');</script>
                                %endinvoke%
                                           
                                <TR>
                                    <TD class="space" colspan=3>&nbsp;</TD>
                                </TR>

                                <tr>
                                    <td class="space" colspan=3>* Server restart is required for settings to take effect.</td>
                                </tr>

                                <TR>
                                    <TD class="action" colspan=3>
                                        <input type="submit"
                                               name="submit"
                                               value="Save Changes"/>
                                    </TD>
                                </TR>

                        </FORM>
                    </TABLE>
                </TD>
            </TR>
           %endinvoke%
        </TABLE>
    </BODY>
</HTML>
