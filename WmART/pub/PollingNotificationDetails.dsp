%comment%------ Display Polling Notification Details ------%endcomment%

<HTML>
<head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <meta http-equiv="Expires" CONTENT="-1">
    <title>Connection Details</title>
    <link rel="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css"></link>    
    <SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
    
    <SCRIPT LANGUAGE="JavaScript">
        function validateNotificationSettings(ntv,mode,procTime,setupTime)
        {
            if (!isNum(ntv)) 
            { 
	            alert("Interval must be specified as a number");
    	        return false;
    	    }
    	    
    	    	if(mode!=undefined && mode != 'disable')
    	    {
	            if (!isNum(procTime.value)) 
    	        { 
	    	        alert("Max processing time must be specified as a number");
    	    	    return false;
	    	    }
	            if (!isNum(setupTime.value)) 
    	        { 
	    	        alert("Max setup time must be specified as a number");
    	    	    return false;
	    	    }
	    	    if(setupTime.value < 1 || setupTime.value > 999999)
	    	    {
	    	        alert("Max setup time must be a number from 1-999999");
    	    	    return false;
	    	    }
	    	}	    			
        }   	    
        
        function disableTimeout(mode)
        {
        	if(mode == 'disable') return true;
        	return false;
        }      
       </SCRIPT>
    
</head>
%invoke wm.art.admin:getAdapterTypeOnlineHelp%
%onerror%
%endinvoke%

%invoke wm.art.admin:retrieveAdapterTypeData%
%onerror%
%endinvoke%

<BODY onLoad="setNavigation('ListPollingNotifications.dsp', '%value encode(javascript) helpsys%', 'foo')">
    <form name="form" action="ListPollingNotifications.dsp" method="POST"
            onSubmit="return validateNotificationSettings(form.notificationInterval.value, form.coordinationMode, form.executeTimeout, form.setupTimeout);">
        <input type="hidden" name="searchNotificationName" value="%value searchNotificationName%">    
        <table width=100%>
            <tr>
            %ifvar readOnly equals('true')%
                <td class="menusection-Adapters" colspan=4>Adapters &gt; %value displayName% &gt; View Notication Schedule</td>
            %else%       
                <td class="menusection-Adapters" colspan=4>Adapters &gt; %value displayName% &gt; Edit Notification Schedule</td>
            %endif%    
            </tr>
            <tr><td colspan=2>
            <ul>
            <li><A HREF="ListPollingNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchNotificationName=%value -urlencode searchNotificationName%&dspName=.LISTPOLLINGNOTIFICATIONS">Return to %value displayName% Notifications</A>
            </ul>
            </td></tr>
        </table>
        %invoke wm.art.admin:retrievePollingNotificationData%
            <table class="tableView">
            <tr>
                <td class="heading" colspan=2>Details for %value notificationNodeName%</td>
            </tr>
            %ifvar notificationData%
                %scope notificationData%  
                <tr>
                <script>writeTD('row');</script>
                Interval: (seconds) </TD>
                <script>writeTD('rowdata-l');</script>
                %ifvar ../readOnly equals('false')%
                    <input type=text name=notificationInterval size=6 value="%value notificationInterval%">
                %else%
                    %value notificationInterval%
                %end%
                </td></tr>
                <tr>
                <script>writeTD("row");</script>
                Overlap: </TD>
                <script>writeTD('rowdata-l');</script>
                %ifvar ../readOnly equals('false')%
                	%ifvar displayOverlap equals('true')%
                    		<input type="checkbox" name=notificationOverlap value=true %ifvar notificationOverlap equals('true')%checked%endif%></td>
                    	%else%
                    		<input type="checkbox" name=notificationOverlap value=true %ifvar notificationOverlap equals('true')%checked%endif% DISABLED></td>	
                    	%end%
                %else%
                    <input type="checkbox" name=notificationOverlap value=true %ifvar notificationOverlap equals('true')%checked%endif% DISABLED></td>
                %end%
                </td></tr>
                <tr>
                <script>writeTD("row");</script>
                Immediate: </td>
                <script>writeTD("rowdata-l");</script>
                %ifvar ../readOnly equals('false')%
                    <input type="checkbox" name=notificationImmediate value=true %ifvar notificationImmediate equals('true')%checked%endif%></td>
                %else%
                    <input type="checkbox" name=notificationImmediate value=true %ifvar notificationImmediate equals('true')%checked%endif% DISABLED></td>
                %endif%
                </td></tr>
		        %invoke wm.art.admin:retrievePollingNotificationCapabilities%
		       
		            <tr>
		                <td class="heading" colspan=2>Cluster settings</td>
		            </tr>
					<tr>
					
		                <script>writeTD("row");</script>
		                Coordination mode: </td>
		                <script>writeTD("row");</script>
		           		%ifvar isClusterAware equals('true')%
			                %ifvar ../../readOnly equals('false')%
			                    <select name="coordinationMode" onchange="this.form.executeTimeout.disabled= disableTimeout(coordinationMode.options[coordinationMode.selectedIndex].value);this.form.setupTimeout.disabled= disableTimeout(coordinationMode.options[coordinationMode.selectedIndex].value)">  
						            %loop supportedModes%
		                				<option value="%value modeName%" %ifvar ../coordinationMode vequals(modeName)% selected="true" %endif% >%value displayName%</option>
		            				%endloop%
					            </select>
					        %else%
					            %loop supportedModes%
	                				%ifvar ../coordinationMode vequals(modeName)% 
	                					%value displayName%
	                				 %endif%
	            				%endloop%
					        %endif%
					    %else%
				            %loop supportedModes%
                				%ifvar ../coordinationMode vequals(modeName)% 
                					%value displayName%
                				 %endif%
            				%endloop%
				        %endif%
					    
						</td>
					</tr>
	                <tr>
		                <script>writeTD('row');</script>
	    	            Max process time: (seconds) </TD>
		                <script>writeTD('rowdata-l');</script>
		           		%ifvar isClusterAware equals('true')%
			                %ifvar ../../readOnly equals('false')%
		    	            	<input type=text name=executeTimeout size=6 %ifvar ../coordinationMode equals('disable')% DISABLED %endif% value = "%value ../executeTimeout%">
		    	            %else%
		    	            	%value ../executeTimeout%
		    	            %endif%
	    	            %else%
	    	            	%value ../executeTimeout%
	    	            %endif%
	    	            
	    	            </td>
	                </tr>
	                <tr>
		                <script>writeTD('row');</script>
	    	            Max setup time: (seconds) </TD>
		                <script>writeTD('rowdata-l');</script>
		           		%ifvar isClusterAware equals('true')%
			                %ifvar ../../readOnly equals('false')%
		    	            	<input type=text name=setupTimeout size=6 %ifvar ../coordinationMode equals('disable')% DISABLED %endif% value = "%value ../setupTimeout%">
		    	            %else%
		    	            	%value ../setupTimeout%
		    	            %endif%
	    	            %else%
	    	            	%value ../setupTimeout%
	    	            %endif%
	    	            
	    	            </td>
	                </tr>
		        %endinvoke%	               
                %endscope%
            %else%
                <tr><td colspan=3 class="message">
                Notification has been deleted</td></tr>
            %endif%  
            <tr><td class="action" colspan="2"> 
            %ifvar readOnly equals('false')%
                %ifvar notificationData%
                    <input type="submit" name="submit" value="Save Settings" width=100></input>
                    <input type="hidden" name="adapterTypeName" value="%value adapterTypeName%">
                    <input type="hidden" name="notificationNodeName" value="%value notificationNodeName%">
                    <input type="hidden" name="action" value="edit">
                %endif%
            %endif%
            </td></tr>
            </table>          
        %onerror%
            %comment%-- Localized error message supplied --%endcomment%
            <table>
            <tr><td colspan=3 class="message">
            <PRE>
            %ifvar localizedMessage%
                %value localizedMessage%
            %else%
                %value errorMessage%
            %endif%
            </PRE>
            </td></tr>
        %endinvoke%
    </form>
</body>
</HTML>
