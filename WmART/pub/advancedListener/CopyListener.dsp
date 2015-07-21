%comment%------ Display configured Listener node ------%endcomment%
%comment%----- LG TRAX 1-MHXZY -----%endcomment%
%comment%----- Move occurrances of swaprows() to make alternate -----%endcomment%
%comment%----- display lines in form have alternating colors -----%endcomment%
<html>
    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <meta http-equiv="Expires" CONTENT="-1">
        <title>Listener Details</title>
        <link rel="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css"></link>
        <SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
        <script src="artconnjs.txt"></script>
    </head>

    <body>
        <form name="form" action="ListAdvancedListeners.dsp" method="POST">
        <input type="hidden" name="action" value="saveListener">
        <input type="hidden" name="passwordChange" value="false">
            %invoke wm.art.admin:retrieveAdapterTypeData%
            %onerror%
            %endinvoke%

            <table width=100%>
                <tr>
                    <td class="menusection-Adapters" colspan=4>Adapters &gt; %value displayName% &gt; Copy Listener</td>
                </tr>

                <tr>
                    <td colspan=2>
                        <ul>
                            <li><a href="ListAdvancedListeners.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchListenerName=%value -urlencode searchListenerName%&dspName=.LISTRESOURCES">
                                Return to %value displayName% Listeners
                            </a></li>
                        </ul>
                    </td>
                </tr>

                %invoke wm.art.ns:getListenerConfiguration%
                <tr>
                    <td class="heading" colspan=2>Configure Listener Copy &gt; %value mcfDisplayName%</td>
                </tr>
		<script>resetRows();</script>
                <script>setNavigation('ListResources.dsp', '%value TemplateURL%', 'foo');</script>
                

                <tr>
                    %include GetISPackages.dsp%
                    <script>swapRows();writeTD('row');</script>Folder Name</td>
                    <script>writeTD('rowdata-l');swapRows();</script><input size=30 name="listenerFolderName"></input></td>
                </tr>

                <tr>
                    <script>writeTD('row');</script>Listener Name</td>
                    <script>writeTD('rowdata-l');swapRows();</script><input size=30 name="listenerNodeName"></input></td>
                </tr>

                %ifvar requiresConnection equals('yes')%
                    <tr>
                        <script>writeTD('row');</script>Connection name</td>
                        <script>writeTD('rowdata-l');swapRows();</script>
                            %invoke wm.art.admin.connection:listResources%
                                %ifvar connDataNode -notempty%
                                    <select name="connDataNodeName">
                                        %loop connDataNode%
                                            <option value="%value connectionAlias%"
                                                    %ifvar connectionAlias vequals(../connDataNodeName)% selected %endif%
                                            />%value connectionAlias%</option>
                                        %endloop%
                                    </select>
                                %else%
                                    no connections
                                %endif%
                            %endinvoke%
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
                %comment%-- LG TRAX 1-MHXP3 --%endcomment%
		%comment%-- Change this to point to a NEW .dsp for COPY ONLY --%endcomment% 
		%comment%-- New for Elbe Release --%endcomment%
                %include DisplayListenerCopyDetails.dsp%

                %onerror%
                    %ifvar localizedMessage%
                        %comment%-- Localized error message supplied --%endcomment%
                        <tr><td class="message">Error encountered <%value error%> %value localizedMessage%</td></tr>
                    %else%
                        %ifvar error%
                            <tr><td class="message">Error encountered <%value error%> %value errorMessage%</td></tr>
                        %endif%
                    %endif%
                %endinvoke%
            </table>

            <table width=100%>
                <tr>
                    <td class="action" colspan="2">
                        <input type="submit" name="SUBMIT" value="Save Listener Copy" width=100 onclick="return validateForm(this.form)"></input>
                        <input type="hidden" name="adapterTypeName"    value="%value adapterTypeName%">
                        <input type="hidden" name="listenerTypeName"   value="%value listenerTypeName%">
                        <input type="hidden" name="requiresConnection" value="%value requiresConnection%">
                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>
