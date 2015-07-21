%comment%------ Display configured Listener node ------%endcomment%
%comment%----- LG TRAX 1-MHXZY -----%endcomment%
%comment%----- Move occurrances of swaprows() to make alternate -----%endcomment%
%comment%----- display lines in form have alternating colors -----%endcomment%
<html>
    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <meta http-equiv="Expires" CONTENT="-1">
        <title>Connection Details</title>
        <link rel="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css"></link>    
        <SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
        <script src="../artconnjs.txt"></script>
    </head>

    <body>
	%comment%------ LG TRAX 1-MHXP3 ------%endcomment%
	%comment%------ Removed onSubmit="return validate(form) ------%endcomment%
        <form name="form" action="ListAdvancedListeners.dsp" method="POST">
            <input type="hidden" name="action"         value="editListener">
            <input type="hidden" name="passwordChange" value="false">
            <input type="hidden" name="searchListenerName" value="%value searchListenerName%">
            %invoke wm.art.admin:retrieveAdapterTypeData%
            %onerror%
            %endinvoke%
          
            <table width=100%>
                <tr>
                    %ifvar readOnly equals('true')%
                        <td class="menusection-Adapters" colspan=2>Adapters &gt; %value displayName% &gt; View Listener</td>
                    %else%       
                        <td class="menusection-Adapters" colspan=2>Adapters &gt; %value displayName% &gt; Edit Listener</td>
                    %endif%    
                </tr>
              
                <tr>
                    <td colspan=2>
                        <ul>
                            <li>
                                <a href="ListAdvancedListeners.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchListenerName=%value -urlencode searchListenerName%&dspName=.LISTRESOURCES">
                                    Return to %value displayName% Listeners
                                </a>
                            </li>
                            <li>
                                %ifvar readOnly equals('true')%
                                    <a href="NotificationOrder.dsp?readOnly=true&adapterDisplayName=%value displayName%&adapterTypeName=%value -urlencode adapterTypeName%&listenerNodeName=%value listenerNodeName%">
                                        View Notification Order
                                    </a>
                                %else%       
                                    <a href="NotificationOrder.dsp?readOnly=false&adapterDisplayName=%value displayName%&adapterTypeName=%value -urlencode adapterTypeName%&listenerNodeName=%value listenerNodeName%">
                                        Edit Notification Order
                                    </a>
                                %endif%
                            </li>
                        </ul>
                    </td>
                </tr>

                <tr>
                    %comment% this makes the columns the same in both edit and view mode. %endcomment%
                    <td width="25%"></td>
                    <td width="75%"></td>
                </tr>
               
                %invoke wm.art.ns:getListenerConfiguration%

                    <tr>
                        <td class="heading" colspan=2>%value listenerNodeName% Details</td>
                    </tr>
                      
                    <tr>
                        <script>writeTD('row');</script>Listener Type</td>
                        <script>writeTD('rowdata-l');swapRows();</script>
                            %ifvar mcfDisplayName%
                                %value mcfDisplayName%
                            %else%
                                %value connectionFactoryType%
                            %endif%
                        </td>
                    </tr>
    
                    <tr>
                        <script>writeTD('row');</script>Package Name</TD>
                        <script>writeTD('rowdata-l');swapRows();</script>%value packageName%</td>
                    </tr>    
                    
                    %ifvar requiresConnection equals('yes')%
                        <tr>
                            <script>writeTD('row');</script>Connection name</td>
                            <script>writeTD('rowdata-l');swapRows();</script>
                                %ifvar readOnly equals('true')%
                                    %value connDataNodeName%
                                %else%
                                    %invoke wm.art.admin.connection:listResources%
                                        %ifvar connDataNode -notempty%
                                            <select name="connDataNodeName" size=1 >
                                                %loop connDataNode%
                                                    <option value="%value connectionAlias%"
                                                            %ifvar ../connDataNodeName vequals(connectionAlias)% selected="true" %endif%
                                                    >
                                                        %value connectionAlias% 
                                                    </option>
                                                %endloop%
                                            </select>
                                        %else%
                                            no connections
                                        %endif%
                                    %endinvoke%
                                %endif%
                            </td>
                        </tr>
                    %endif%
                
                    <tr>
                        <script>writeTD('row');</script>Retry Limit</TD>
                        <script>writeTD('rowdata-l');swapRows();</script>
                            %ifvar readOnly equals('true')%
                                %value retryLimit%
                            %else%
                                 <input size=60 name="retryLimit" value="%value retryLimit%"></input></td>
                            %endif%
                        </td>
                    </tr>    
                    
                    <tr>
                        <script>writeTD('row');</script>Retry Backoff Timeout</TD>
                        <script>writeTD('rowdata-l');swapRows();</script>
                            %ifvar readOnly equals('true')%
                                %value retryBackoffTimeout%
                            %else%
                                 <input size=60 name="retryBackoffTimeout" value="%value retryBackoffTimeout%"></input></td>
                            %endif%
                        </td>
                    </tr> 
                                          
                    <tr>
                        <script>writeTD('row');</script>Execution Configuration</TD>
                        <script>writeTD('rowdata-l');swapRows();</script>
							%ifvar readOnly equals('true')%
                                   %ifvar threadConfiguration equals('multiThread')%
										Concurrent 
									%else%
										Sequential
									%endif%
                            %else%
								 %ifvar threadConfiguration equals('singleThread')% 
									<input type="radio" name="threadConfiguration" value="singleThread" checked>Sequential</input>
									<input type="radio" name="threadConfiguration" value="multiThread">Concurrent </input>
								%else%
								
									 <input type="radio" name="threadConfiguration" value="singleThread" >Sequential </input>
									<input type="radio" name="threadConfiguration" value="multiThread" checked>Concurrent</input>
								%endif%
							%endif%	
                        </td>
                    </tr>
					<tr>
                        <script>writeTD('row');</script>Thread Count</TD>
                        <script>writeTD('rowdata-l');swapRows();</script>
							 %ifvar readOnly equals('true')%
								%value threadCount%
                             %else%
								 <input size=60 name="threadCount" value="%value threadCount%"></input></td>
							%endif%
                        </td>
                    </tr>
                    %include DisplayListenerDetails.dsp%
                
                %onerror%
                    %ifvar localizedMessage%
                        %comment%-- Localized error message supplied --%endcomment%
                        <tr><td class="message">Error encountered <pre>%value localizedMessage%</pre></td></tr>
                    %else%
                        %ifvar error%
                            <tr><td class="message">Error encountered <pre>%value errorMessage% (%value error%)</pre></td></tr>
                        %endif%
                    %endif%
                %endinvoke%
            </table>
              
            <table width=100%>
                <tr>
                    <td class="action" colspan="2">
                        %ifvar readOnly equals('true')%
                        %else%
                            %comment%------ LG TRAX 1-MHXP3 ------%endcomment%
                            %comment%------ Removed onclick="return setPasswordEdit() ------%endcomment%
                            %comment%------ Added onclick="return validate(this.form) ------%endcomment%
                            <input type="submit" name="SUBMIT" value="Save Changes" width=100 onclick="return validateForm(this.form)"></input>
                            <input type="hidden" name="adapterTypeName"    value="%value adapterTypeName%">
                            <input type="hidden" name="listenerTemplate"   value="%value listenerTemplate%">       
                            <input type="hidden" name="listenerNodeName"   value="%value listenerNodeName%">
                            <input type="hidden" name="requiresConnection" value="%value requiresConnection%">
                        %endif%        
                    </td>
                </tr>
            </table>
        </form>    
    </body>
</html>
