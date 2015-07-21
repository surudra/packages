<html>
    <script Language="JavaScript">
        function verifyPositiveIntegerField(value, name)
        {
            if (isblank(value)) {
                alert(name + " is required.");
                return false;
            }
            else if (!isNum(value) || parseInt(value) <= 0) {
                alert("Value must be a positive integer: "+name);
                return false;
            }
            else {
                return true;
            }
        }

        function verifyPositiveIntegerField_NotRequired(value, name)
        {
            if (isblank(value)) {
                return true;
            }
            else if (!isNum(value) || parseInt(value) <= 0) {
                alert("Value must be a positive integer: "+name);
                return false;
            }
            else {
                return true;
            }
        }

        function verifyNonnegativeIntegerField(value, name)
        {
            if (isblank(value)) {
                alert(name + " is required.");
                return false;
            }
            else if (!isNum(value) || parseInt(value) < 0) {
                alert("Value must be a nonnegative integer: "+name);
                return false;
            }
            else {
                return true;
            }
        }


        function verifyPercentageField_NotRequired(value, name)
        {
			if (isblank(value)) {
				return true;
			} 
			else if (!isNum(value) || parseInt(value) < 0 || parseInt(value) > 100) {
					alert("Value must be an integer between 0 and 100: "+name);
					return false;
			}
			else {
				return true;
			}
		}

        function verifyPercentageField(value, name)
        {
            if (isblank(value)) {
                alert(name + " is required.");
                return false;
            }
            else if (!isNum(value) || parseInt(value) < 0 || parseInt(value) > 100) {
                alert("Value must be an integer between 0 and 100: "+name);
                return false;
            }
            else {
                return true;
            }
        }

        function validateSettingValues()
        {
            var maxServerThreads = document.settings["watt.server.threadPool"].value;
            var minServerThreads = document.settings["watt.server.threadPoolMin"].value;
            var sessionTimeout   = document.settings["watt.server.clientTimeout"].value;
            var maxSchedThreads  = document.settings["watt.server.scheduler.threadThrottle"].value;
            var maxRedirects     = document.settings["watt.net.maxRedirects"].value;
            var outboundTimeout  = document.settings["watt.net.timeout"].value;
            var outboundRetries  = document.settings["watt.net.retries"].value;
            var svrThrdThreshold = document.settings["watt.server.control.serverThreadThreshold"].value;
			var schdThreadThrottle = document.settings["watt.server.scheduler.threadThrottle"].value;
            var sessionWarning   = document.settings["watt.server.session.stateful.warning"].value;
	    var maxStatefulSessions = document.settings["watt.server.session.stateful.max"].value;
	    
            if (verifyPositiveIntegerField(maxServerThreads,   "Maximum Server Threads")      &&
                verifyPositiveIntegerField(minServerThreads,   "Minimum Server Threads")      &&
                verifyPositiveIntegerField(sessionTimeout,     "Session Timeout")             &&
                verifyPositiveIntegerField(maxSchedThreads,    "Scheduler Maximum Threads")   &&
                verifyPositiveIntegerField_NotRequired(maxStatefulSessions,"Maximum Stateful Sessions")   &&
                verifyNonnegativeIntegerField(maxRedirects,    "Outbound Maximum Redirects")  &&
                verifyNonnegativeIntegerField(outboundTimeout, "Outbound Timeout")            &&
                verifyNonnegativeIntegerField(outboundRetries, "Outbound Retries")            &&
                verifyPercentageField_NotRequired(sessionWarning,  "Available Stateful Sessions Warning Threshold")   &&
                verifyPercentageField(svrThrdThreshold,        "Available Threads Warning Threshold") && 
                verifyPercentageField(schdThreadThrottle,      "Scheduler Thread Throttle")) {

                if (parseInt(maxServerThreads) < parseInt(minServerThreads)) {
                    alert("The Minimum number of server threads (" + minServerThreads + ")\n" +
                          "cannot exceed the Maximum number of server threads (" + maxServerThreads + ").");
                    return false;
                }
            	else if (parseInt(diagPriority) < 1 || parseInt(diagPriority) > 10) {
                	alert("Diagnostic Thread Priority must be an integer between 1 and 10");
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

    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <META HTTP-EQUIV="Expires" CONTENT="-1">

        <title>Integration Server Settings</title>
        <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
        <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
    </head>
    <body onLoad="setNavigation('settings-resources-edit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditResourceSetScrn');">

        <table width="100%">

            <tr>
                <td class="menusection-Settings" colspan="3">
                    Settings &gt; Resources &gt; Edit
                </td>
            </tr>

            <tr>
                <td colspan="3">
                    <ul>
                        <li><a href="settings-resources.dsp">Return to Resource Settings</a></li>
                    </ul>
                </td>
            </tr>

            %invoke wm.server.query:getResourceSettings%

                <tr>
                    <td><img src="images/blank.gif" height=10 width=10 border=0></td>
                    <td width="100%">
                        <table class="tableForm">
                            <form name="settings" action="settings-resources.dsp" onsubmit="return validateSettingValues()" >
                                <input type="hidden" name="action" value="change" />

                                %loop -struct Resources%
                                    %comment% <!-- key == name of section --> %endcomment%
                                    %scope #$key%
                                        %ifvar $key equals('ServerMemory')%
                                        %else%
                                        <tr>
                                            <td class="heading" colspan=2>%value name%</td>
                                        </tr>
                                        %endif%
                                        %comment%
                                            <!--                                              -->
                                            <!-- section is array of fields, of the structure -->
                                            <!--     key:   name                              -->
                                            <!--     value: record                            -->
                                            <!--         value                                -->
                                            <!--         resource                             -->
                                            <!--         description                          -->
                                            <!--         isrequired                           -->
                                            <!--         isodd                                -->
                                            <!--         calcvalue (calculated value)         -->
                                            <!--         calcdesc (calculated description)    -->
                                            <!--                                              -->
                                        %endcomment%

                                        %loop -struct fields%
                                            %scope #$key%
                                                %ifvar iseditable equals('true')%
                                                    <tr>
                                                        <td
                                                            %comment%

                                                                An embarrassing hack -- the first value in the Server Thread Pool is skipped, so
                                                                we start with even, not odd.

                                                             %endcomment%

                                                            %ifvar $key equals('ServerThreadPool')%
                                                                class="%ifvar isodd equals('true')%even%else%odd%endif%row"
                                                            %else%
                                                                class="%ifvar isodd equals('true')%odd%else%even%endif%row"
                                                            %endif%
                                                                nowrap >
                                                            %value title%
                                                        </td>

                                                        <td class="%ifvar isodd equals('true')%odd%else%even%endif%row-l">
							    %ifvar $key equals('SamlUrl')%
								    <input type="text" name="%value resource%" value="%value value%" size=40>						    
							    %else%
							          %ifvar $key equals('UserAgent')%
									<input type="text" name="%value resource%" value="%value value%" size=40>
								  %else%
								     %ifvar $key equals('tlsSettings')%
								        <select name="tlsSettings">
									   <option %ifvar value equals('None')%selected %endif%value="None">None</option>
									   <option %ifvar value equals('Explicit')%selected %endif%value="Explicit">Explicit</option>
									   <option %ifvar value equals('Implicit')%selected %endif%value="Implicit">Implicit</option>
		  							</select>
		  							
								     %else%
								        %ifvar $key equals('trustStoreAlias')%
								           <select name=trustStoreAlias class="listbox">
									      %invoke wm.server.security.keystore:listTrustStores%
									         <option name="" value=""></option>
									         %loop trustStores%
									            %ifvar isLoaded equals('true')%
									   	       <option name="%value keyStoreName%" value="%value keyStoreName%" %ifvar ../value vequals(keyStoreName)%selected%endif%>%value keyStoreName%</option>
									            %endif%
									         %endloop%
									      %endinvoke%
									   </select>
								        %else%
											%ifvar value equals('true')%
											  <input type="radio" name="%value resource%" value="true" checked>Yes</input>
											  <input type="radio" name="%value resource%" value="false">No</input>
											%else%
											  %ifvar value equals('false')%
												<input type="radio" name="%value resource%" value="true">Yes</input>
												<input type="radio" name="%value resource%" value="false" checked>No</input>
											  %else%
												<script>
												writeEdit("edit",
													  "%value resource%",
													  "%value value%");
												</script>
											  %endif%
											%endif%
										%endif%
							          %endif%
								   %endif%
							    %endif%
							    %value description%

                                                        </td>
							
							
							%ifvar requiresRestart equals('true')%
								<td class="%ifvar isodd equals('true')%odd%else%even%endif%row-l" >*</td>
							%endif%

                                                    %else%
                                                        %comment% edit mode and NOT editable  %endcomment%
                                                    %endif%
                                                </tr>
                                            %endscope%
                                        %endloop%     <!-- end of field -->
                                    %endscope%

                                    %ifvar $key equals('mwsSso')%
                                    %else%
                                        <tr><td>&nbsp;</td></tr>
                                    %endif%
                                %endloop%             <!-- end of section -->

                                <!-- Comment out this portion from the UI. May want to add it later. -->

                                <tr>
                                    <td class="space" colspan="2">&nbsp;</td>
                                </tr>

                                <tr>
                                    <td class="space" colspan="2">* Server restart is required for settings to take effect.</td>
                                </tr>

                                <tr>
                                    <td colspan="2" class="action">
                                        <input type="submit"
                                               name="submit"
                                               value="Save Changes"/>
                                    </td>
                                </tr>
                            </form>
                        </table>
                    </td>
                </tr>
            %endinvoke%
        </table>
    </body>
</html>
