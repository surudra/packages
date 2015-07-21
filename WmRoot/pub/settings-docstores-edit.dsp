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

        function verifyNonnegativeIntegerField(v, name, needCheck)
        {
            if (needCheck)
            {
            	if (isblank(v.value)) {
                	alert(name + " is required.");
                	return false;
            	}
            	else if (!isNum(v.value) || parseInt(v.value) < 0) {
                	alert("Value must be a nonnegative integer: "+name);
                	return false;
            	}
           		else {
                	return true;
            	}
            } else
            	return true;
        }

        function verifyPercentageField(v, name)
        {
            if (isblank(v.value)) {
                alert(name + " is required.");
                return false;
            }
            else if (!isNum(v.value) || parseInt(v.value) < 0 || parseInt(v.value) > 100) {
                alert("Value must be an integer between 0 and 100: "+name);
                return false;
            }
            else {
                return true;
            }
        }

        function verifyInitialSize(storeSize) {
            var stsz = parseInt(storeSize.value);
            if (stsz < 2 ) {
                alert("Initial Store size must be greater than 1 MB");
                return false;
            }
            else {
                return true;
            }
        }

        function confirmEdit(isBrokerConfigured) {
            var tsDBGroup                 = document.editform.tsDBGroup;
            var tsDBSize                  = document.editform.tsDBSize;
            var tsNumMsgs                 = document.editform.tsNumMsgs;
            var triggerDBGroup            = document.editform.triggerDBGroup;
            var triggerDBSize             = document.editform.triggerDBSize;
            var maxDocsDefStore           = document.editform.maxDocsDefStore;
            var minDocsDefStore           = document.editform.minDocsDefStore;
            var maxDocsSentPerTransaction = document.editform.maxDocsSentPerTransaction;
            var maxLifeOfMessageHistory   = document.editform.maxLifeOfMessageHistory;

            if (verifyNonblankField(tsDBGroup,                         "Default Document Store Location")  &&
                verifyPositiveIntegerField(tsDBSize,                   "Initial Store Size", true) 				&&
                verifyNonnegativeIntegerField(maxDocsDefStore,         "Capacity", isBrokerConfigured)     &&
                verifyNonnegativeIntegerField(minDocsDefStore,         "Refill Level", isBrokerConfigured) &&
                verifyNonblankField(triggerDBGroup,                    "Trigger Document Store Location")  &&
                verifyPositiveIntegerField(triggerDBSize,              "Initial Store Size", true)               	&&
                verifyNonnegativeIntegerField(maxLifeOfMessageHistory, "Duration", true)                         	&&
                verifyInitialSize(tsDBSize)                                                     &&
                verifyInitialSize(triggerDBSize)                                           &&
                verifyPositiveIntegerField(maxDocsSentPerTransaction,  "Maximum Documents to Send per Transaction", isBrokerConfigured))
            {
                if (parseInt(minDocsDefStore.value) > parseInt(maxDocsDefStore.value)
                	&& parseInt(maxDocsDefStore.value) != 0 ) {
                    alert("The Refill Level (" + minDocsDefStore.value + ") " +
                          "cannot exceed the Capacity (" + maxDocsDefStore.value + ").");
                    return false;
                }
                else {
                    return true;
                }
            }
            else {
                return false;
            }
        }
    </script>

    <HEAD>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <meta http-equiv="Expires" content="-1">
        <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
        <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
    </HEAD>

    <BODY onLoad="setNavigation('settings-docstores-edit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditDocStoresScrn');">
        <TABLE width="90%">
            <TR>
                <TD class="menusection-Settings" colspan="2">
                    Settings &gt; Resources &gt; Store Settings &gt; Edit Document Store Settings<br>
                </TD>
            </TR>

            <TR>
                <TD colspan="2">
                    <UL>
                        <LI><A HREF="settings-docstores.dsp">Return to Store Settings</A></LI>
                    </UL>
                </TD>
            </TR>

			%invoke wm.server.dispatcher.adminui:getDocStoreSettings%
            <TR>
                <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
                <TD width="100%">
                    <TABLE class="tableView">
                        <FORM NAME="editform" ACTION="settings-docstores.dsp" METHOD="POST" onsubmit="return confirmEdit(%value isBrokerConfigured%)">
                            <input type="hidden" name="action" value="edit" />

                                <TR>
                                    <TD class="heading" colspan=3>Default Document Store</TD>
                                </TR>

                                <TR>
                                    <TD class="oddrow">Store Location</TD>
                                    <TD class="oddrowdata-l">
                                        <INPUT NAME="tsDBGroup" VALUE="%value tsDBGroup%" />
                                    </TD>
                                    <TD class="oddrowdata-l">*</TD>
                                </TR>

                                <TR>
                                    <TD class="evenrow">Initial Store Size (MB)</TD>
                                    <TD class="evenrowdata-l">
                                        <INPUT NAME="tsDBSize" VALUE="%value tsDBSize%" />
                                    </TD>
                                    <TD class="evenrowdata-l">*</TD>
                                </TR>


                           	%ifvar isBrokerConfigured equals('true')%
                                <TR>
                                    <TD class="oddrow">Capacity (documents)</TD>
                                    <TD class="oddrowdata-l">
                                        <INPUT NAME="maxDocsDefStore" VALUE="%value maxDocsDefStore%" />
                                    </TD>
                                    <TD class="oddrowdata-l">&nbsp;</TD>
                                </TR>

                                <TR>
                                    <TD class="evenrow">Refill Level (documents)</TD>
                                    <TD class="evenrowdata-l">
                                        <INPUT NAME="minDocsDefStore" VALUE="%value minDocsDefStore%" />
                                    </TD>
                                    <TD class="evenrowdata-l">&nbsp;</TD>
                                </TR>
                          	%else%
                                <TR>
                                    <TD class="oddrow">Capacity (documents)</TD>
                                    <TD class="oddrowdata-l">
                                        <INPUT TYPE="hidden" NAME="maxDocsDefStore" VALUE="(Broker Not Configured)" />
                                        (Broker Not Configured)
                                    </TD>
                                    <TD class="oddrowdata-l">&nbsp;</TD>
                                </TR>

                                <TR>
                                    <TD class="evenrow">Refill Level (documents)</TD>
                                    <TD class="evenrowdata-l">
                                        <INPUT TYPE="hidden" NAME="minDocsDefStore" VALUE="(Broker Not Configured)" />
                                        (Broker Not Configured)
                                    </TD>
                                    <TD class="evenrowdata-l">&nbsp;</TD>
                                </TR>
                          	%endif%

        %comment%
                                <TR>
                                    <TD class="oddrow">Number of Documents Retrieved per Transaction</TD>
                                    <TD class="oddnrowdata-l">
                                        <INPUT NAME="tsNumMsgs" VALUE="%value tsNumMsgs%" />
                                    </TD>
                                    <TD class="oddrowdata-l">&nbsp;</TD>
                                </TR>
        %endcomment%

                                <TR>
                                    <TR><TD class="space" colspan=3>&nbsp;</TD></TR>
                                </TR>

                                <TR>
                                    <TD class="heading" colspan=3>Trigger Document Store</TD>
                                </TR>

                                <TR>
                                    <TD class="oddrow">Store Location</TD>
                                    <TD class="oddrowdata-l">
                                        <INPUT NAME="triggerDBGroup" VALUE="%value triggerDBGroup%">
                                    </TD>
                                    <TD class="oddrowdata-l">*</TD>
                                </TR>

                                <TR>
                                    <TD class="evenrow">Initial Store Size (MB)</TD>
                                    <TD class="evenrowdata-l">
                                        <INPUT NAME="triggerDBSize" VALUE="%value triggerDBSize%">
                                    </TD>
                                    <TD class="evenrowdata-l">*</TD>
                                </TR>

                             
                                <TR>
                                    <TD class="oddrow">Inbound Document History (minutes)</TD>
                                    %ifvar isBrokerConfigured equals('false')%
                                    <TD class="oddrowdata-l">Not Available
                                        <INPUT NAME="maxLifeOfMessageHistory" VALUE="0" TYPE="hidden">
                                    </TD>
                                    <TD class="oddrowdata-l">&nbsp</TD>
                                    %else%
	                                    %ifvar exactlyOnceSupported equals('true')%
	                                    <TD class="oddrowdata-l">Not Available
	                                        <INPUT NAME="maxLifeOfMessageHistory" VALUE="0" TYPE="hidden">
	                                    </TD>
	                                    <TD class="oddrowdata-l">&nbsp</TD>
	                                    %else%
	                                    <TD class="oddrowdata-l">
	                                        <INPUT NAME="maxLifeOfMessageHistory" VALUE="%value maxLifeOfMessageHistory%">
	                                    </TD>
	                                    <TD class="oddrowdata-l">*</TD>
	                                    %endif%
	                                %endif%
                                </TR>

                                <TR>
                                    <TD class="evenrow">Inbound Client Side Queuing</TD>
                                    %ifvar isBrokerConfigured equals('false')%
                                    	<TD CLASS="evenrowdata-l">Not Available</TD>
                                        <TD class="evenrowdata-l">&nbsp</TD>
                                    %else%
	                                    %ifvar exactlyOnceSupported equals('true')%
	                                        <TD CLASS="evenrowdata-l">Not Available</TD>
	                                        <TD class="evenrowdata-l">&nbsp</TD>
	                                    %else%
	                                        %ifvar clusterEnabled equals('false')%
	                                        <TD CLASS="evenrowdata-l">
	                                            %ifvar INBOUNDQUEUING equals('on')%
	                                                <INPUT TYPE="radio" NAME="INBOUNDQUEUING" VALUE="on" checked>On</INPUT>
	                                                <INPUT TYPE="radio" NAME="INBOUNDQUEUING" VALUE="off">Off</INPUT>
	                                            %else%
	                                                <INPUT TYPE="radio" NAME="INBOUNDQUEUING" VALUE="on">On</INPUT>
	                                                <INPUT TYPE="radio" NAME="INBOUNDQUEUING" VALUE="off" checked>Off</INPUT>
	                                            %endif%
	                                        </TD>
	                                        %else%
	                                        <TD CLASS="evenrowdata-l">Off&nbsp;&nbsp;&nbsp;(Server is Cluster Enabled)
	                                            <INPUT TYPE="hidden" NAME="INBOUNDQUEUING" VALUE="off" />
	                                        </TD>
	                                        %endif%
	                                        <TD class="evenrowdata-l">*</TD>
	                                    %endif%
	                                %endif%
                                </TR>
                                
                                <TR>
                                    <script type="text/javascript">
                                        var runas = "%value TRIGGERUSER%";

                                        // define function to scroll through selections on
                                        // document.editform.TRIGGERUSER
                                        function updateSelector () {
                                            var sel = document.editform.TRIGGERUSER;
                                            for (var i=0; i<sel.options.length; i++) {
                                                if (sel.options[i].value == runas) {
                                                    sel.selectedIndex = i;
                                                }
                                            }
                                        }
                                    </script>
                                    
                                    <!--  RUN AS USER SUB CHANGES-->
                                    
				    <SCRIPT>
				      	function callback(val){      	    
				    		document.editform.TRIGGERUSER.value=val;
				  	}
				    </SCRIPT>

                                    <TD class="oddrow">User</TD>
                                    <TD class="oddrowdata-l">
                                    <!--
                                        %invoke wm.server.access:userList%
                                            <SELECT NAME="TRIGGERUSER">
                                                %loop users%
                                                    <OPTION value="%value name%"
                                                            %ifvar name equals('')% selected %endif%>
                                                        %value name%
                                                    </OPTION>
                                                %endloop%
                                            </SELECT>
                                        %endinvoke%
                                    
                                    <SCRIPT LANGUAGE="JavaScript">updateSelector();</SCRIPT>
                                    -->
                                    <!--  RUN AS USER SUB CHANGES START-->
				    <input name="TRIGGERUSER" size=12 value="%value TRIGGERUSER%"></input>
				    <link rel="stylesheet" type="text/css" href="subUserLookup.css" />
				    <script type="text/javascript" src="subUserLookup.js"></script>
				   <a class="submodal" href="subUserLookup.dsp"><img border=0 align="bottom" src="icons/magnifyglass.gif"/></a> 
  			           <!--  RUN AS USER SUB END-->
                                    </TD>
                                    <TD class="oddrowdata-l">*</TD>
                                </tr>
                                
                                
                                

                                <TR>
                                    <TD class="space" colspan=3>&nbsp;</TD>
                                </TR>

                                <TR>
                                    <TD class="heading" colspan=3>Outbound Document Store</TD>
                                </TR>

                                <TR>
                                    <TD class="oddrow">Maximum Documents to Send per Transaction</TD>
                                    <TD class="oddrowdata-l">
                                        %ifvar isBrokerConfigured equals('true')%
                                            <INPUT NAME="maxDocsSentPerTransaction" VALUE="%value maxDocsSentPerTransaction%" />
                                        %else%
                                            <INPUT TYPE="hidden" NAME="maxDocsSentPerTransaction" VALUE="Broker Not Configured">
                                            (Broker Not Configured)
                                        %endif%
                                    </TD>
                                    <TD class="oddrowdata-l">&nbsp;</TD>
                                </TR>
                                
                                 <TR>
                                    <TD class="space" colspan=3>&nbsp;</TD>
                                </TR>
                                   
<!--
                                <TR>
                                    <TD class="heading" colspan=3>Run Trigger Service As User</TD>
                                </tr>
                                
                                <TR>
                                    <script type="text/javascript">
                                        var runas = "%value TRIGGERUSER%";

                                        // define function to scroll through selections on
                                        // document.editform.TRIGGERUSER
                                        function updateSelector () {
                                            var sel = document.editform.TRIGGERUSER;
                                            for (var i=0; i<sel.options.length; i++) {
                                                if (sel.options[i].value == runas) {
                                                    sel.selectedIndex = i;
                                                }
                                            }
                                        }
                                    </script>

                                    <TD class="oddrow">User</TD>
                                    <TD class="oddrowdata-l">
                                        %invoke wm.server.access:userList%
                                            <SELECT NAME="TRIGGERUSER">
                                                %loop users%
                                                    <OPTION value="%value name%"
                                                            %ifvar name vequals(../TRIGGERUSER)% SELECTED %endif%>
                                                        %value name%
                                                    </OPTION>
                                                %endloop%
                                            </SELECT>
                                        %endinvoke%
                                        <SCRIPT LANGUAGE="JavaScript">updateSelector();</SCRIPT>
                                    </TD>
                                    <TD class="oddrowdata-l">*</TD>
                                </TR>


                                <tr>
                                    <td class="space" colspan=3>&nbsp;</td>
                                </tr>
-->
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
