%comment%----- Lists configured connections -----%endcomment%
<HTML>
    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <meta http-equiv="Expires" CONTENT="-1">
        <title>List Connections</title>
        <link rel="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css"></link>
        <script src="connectionfilter.js.txt"></script>

        <SCRIPT LANGUAGE="JavaScript">
            function confirmDisable (aliasName)
            {            	
                var s1 = "OK to disable the `"+aliasName+"' connection?\n\n";
                var s2 = "Disabling a connection causes all services to be \n";
                var s3 = "unavailable for use.\n";
                return confirm (s1+s2+s3);
            }
           
            function confirmEnable (aliasName)
            {      
                var s1 = "OK to enable the `"+aliasName+"' connection?\n\n";
                return confirm (s1);
            }
            function confirmDelete (aliasName)
            {
                var s1 = "OK to delete the `"+aliasName+"' connection?\n\n";
                return confirm (s1);
            }            
        </SCRIPT>
        <SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
    </head>

    %invoke wm.art.admin:getAdapterTypeOnlineHelp%
    %onerror%
    %endinvoke%

    %invoke wm.art.admin:retrieveAdapterTypeData%
    %onerror%
    %endinvoke%

    <BODY onLoad="setNavigation('ListResources.dsp','%value encode(javascript) helpsys%', 'foo');showHideFilterCriteria('searchConnectionName');">    
    <form name="form" action="ListResources.dsp" method="POST">    
        <table width="100%">
        <tr>
           <td class="menusection-Adapters" colspan=8>Adapters &gt; %value displayName% &gt; Connections</td>
        </tr>
	
        %ifvar action%
            %switch action%

                %case 'saveConnection'%
                    %invoke wm.art.admin.connection:createResource%
                    %onerror%
                        %ifvar localizedMessage%
                            <tr><td class="message" colspan=8>Error encountered <pre>%value localizedMessage%</pre></td></tr>
                        %else%
                            %ifvar error%
                                <tr><td class="message" colspan=8>Error encountered <pre>%value errorMessage%</pre></td></tr>
                            %endif%
                        %endif%
                    %endinvoke%

                %case 'deleteConnection'%
                    %invoke wm.art.admin.connection:deleteResource%
                    %onerror%
                        %ifvar localizedMessage%
                            <tr><td class="message" colspan=8>Error encountered <pre>%value localizedMessage%</pre></td></tr>
                        %else%
                            %ifvar error%
                                <tr><td class="message" colspan=8>Error encountered <pre>%value errorMessage%</pre></td></tr>
                            %endif%
                        %endif%
                    %endinvoke%

                %case 'editConnection'%
                    %invoke wm.art.admin.connection:updateResource%
                    %onerror%
                        %ifvar localizedMessage%
                            <tr><td class="message" colspan=8>Error encountered <pre>%value localizedMessage%</pre></td></tr>
                        %else%
                            %ifvar error%
                                <tr><td class="message" colspan=8>Error encountered <pre>%value errorMessage%</pre></td></tr>
                            %endif%
                        %endif%
                    %endinvoke%

                %case 'enableConnection'%
                    %invoke wm.art.admin.connection:setResourceState%
                    %onerror%
                        %ifvar localizedMessage%
                          <tr><td class="message" colspan=8>Error encountered <pre>%value localizedMessage%</pre></td></tr>
                        %else%
                          %ifvar error%
                            <tr><td class="message" colspan=8>Error encountered <pre>%value errorMessage%</pre></td></tr>
                           %endif%
                        %endif%
                    %endinvoke%

            %endswitch%
        %endif%

        <tr>
            <td colspan=2>
                <ul>
                <li><a href="ListAdapterConnTypes.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchConnectionName=%value -urlencode ../searchConnectionName%&dspName=.LISTCONNECTIONTYPES">Configure New Connection</a>
                <li id="showfew" name="showfew"><a href="javascript:showFilterPanel(true)">Filter Connections</a></li>
                <!-- <li style="display:none" id="showall" name="showall"><a href="javascript:showFilterPanel()">Show All Connections</a></li>-->
                <li style="display:none" id="showall" name="showall"><a href="/WmART/ListResources.dsp?adapterTypeName=%value -urlencode adapterTypeName%&dspName=.LISTRESOURCES">Show All Connections</a></li>
                
                <DIV id="filterContainer" name="filterContainer" style="display:none;padding-top=2mm;">
                 <br>
                  <table>
				  <tr valign="top">
					<td>
                    	<span>Filter criteria</span><br>                    	
                    	<input id="searchConnectionName" name="searchConnectionName" value="%value -urldecode searchConnectionName%" onkeydown="return processKey(event)" />
					</td>
					<td>					
                     <br>
                        <input id="submitButton" name="Submit" type="submit" value="Submit" width="15" height="15" onClick="validateSearchCriteria('searchConnectionName');return false;"/>                                                             
                     </br>
                    </td> 
                  </tr>
                  </table>
                 </br>  
                </DIV>
                </ul>
            </td>
        </tr>
         %invoke wm.art.admin.connection:listResources% 
        <tr>
        <td colspan=8 align="right">
        	<label style="color:#666666;font-weight:bold;text-align:inherit;">%value pageLabel%</label>
        </td>
        </tr>
        <tr>
            <td class="heading" colspan=8>Connections</td>
        </tr>
        <tr> 
            <td class="oddcol-l">Connection Name<a id="ascCN" href="/WmART/ListResources.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchConnectionName=%value -urlencode searchConnectionName%&sort=CA&dspName=.LISTRESOURCES"><img border="0" style="float: middle" src="images/arrow_up.gif" width="15" height="15"></a>
            <a id="desCN" href="/WmART/ListResources.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchConnectionName=%value -urlencode searchConnectionName%&sort=CA&DES=true&dspName=.LISTRESOURCES"><img border="0" src="images/arrow_down.gif" style="float: middle" width="15" height="16"></a></td>
            <td class="oddcol-l">Package Name<a href="/WmART/ListResources.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchConnectionName=%value -urlencode searchConnectionName%&sort=PN&dspName=.LISTRESOURCES"><img border="0" src="images/arrow_up.gif" align="baseline" width="15" height="15"></a>
            <a href="/WmART/ListResources.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchConnectionName=%value -urlencode searchConnectionName%&sort=PN&DES=true&dspName=.LISTRESOURCES"><img border="0" src="images/arrow_down.gif" align="baseline" width="15" height="15"></a></td>
            <td class="oddcol-l">Connection Type<a href="/WmART/ListResources.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchConnectionName=%value -urlencode searchConnectionName%&sort=CT&dspName=.LISTRESOURCES"><img border="0" src="images/arrow_up.gif" align="baseline" width="15" height="15"></a>
            <a href="/WmART/ListResources.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchConnectionName=%value -urlencode searchConnectionName%&sort=CT&DES=true&dspName=.LISTRESOURCES"><img border="0" src="images/arrow_down.gif" align="baseline" width="15" height="15"></a></td>
            <td class="oddcol-l">Enabled<a href="/WmART/ListResources.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchConnectionName=%value -urlencode searchConnectionName%&sort=EN&dspName=.LISTRESOURCES"><img border="0" src="images/arrow_up.gif" align="baseline" width="15" height="15"></a>
            <a href="/WmART/ListResources.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchConnectionName=%value -urlencode searchConnectionName%&sort=EN&DES=true&dspName=.LISTRESOURCES"><img border="0" src="images/arrow_down.gif" align="baseline" width="15" height="15"></a></td>
            <td class="oddcol">Edit</td>
            <td class="oddcol">View</td>
            <td class="oddcol">Copy</td>	
            <td class="oddcol">Delete</td>
        </tr>
                    
        %ifvar connDataNode -notempty%
            %loop connDataNode%
            
                <tr>
                    <script>writeTD('rowdata-l');</script>%value connectionAlias%</td>
                    <script>writeTD('rowdata-l');</script>%value packageName%</td>
                    <script>writeTD('rowdata-l');</script>
                        %ifvar mcfDisplayName%%value mcfDisplayName%%else%%value connectionFactoryType%%endif%
                    </td>
    
                    %switch connectionState%
                        %case 'enabled'%
                            <script>writeTD('rowdata');</script>
                                <a href="javascript:submitURL('/WmART/ListResources.dsp?action=enableConnection&connectionState=disabled&adapterTypeName=%value -urlencode ../adapterTypeName%&connectionAlias=%value -urlencode connectionAlias%&dspName=.LISTRESOURCES')"
			           ONCLICK="return confirmDisable('%value connectionAlias%');">
                                    <img src="/WmRoot/images/green_check.gif" height=13 width=13 alt="Disable" border=0>Yes
                                </a>
                            </td>
    
                        %case 'shuttingdown'%
                            <script>writeTD('rowdata');</script>
                                <a href="/WmART/ListResources.dsp?action=enableConnection&connectionAlias=%value -urlencode connectionAlias%&connectionState=shuttingdown&adapterTypeName=%value -urlencode ../adapterTypeName%&dspName=.LISTRESOURCES"
			           ONCLICK="return confirmEnable('%value connectionAlias%');">
                                    <img src="/WmRoot/images/blank.gif" alt="Enable" border=0>No
                                </a>
                            </td>
    
                        %case 'disabled'%
                            <script>writeTD('rowdata');</script>
	                        <a href="javascript:submitURL('/WmART/ListResources.dsp?action=enableConnection&connectionState=enabled&adapterTypeName=%value -urlencode ../adapterTypeName%&connectionAlias=%value -urlencode connectionAlias%&dspName=.LISTRESOURCES')"
			           ONCLICK="return confirmEnable('%value connectionAlias%');">
                                    <img src="/WmRoot/images/blank.gif" border=0 alt="Enable">No
                                </a>
                            </td>
    
						%comment%-- start trax# 1-14BGHB --%endcomment%
		    			%comment% A new connection state called pendingEnabled is introduced which is set just before %endcomment%
		    			%comment% enabling the connection, i.e. this is a transitionary state between the disabled and enabled. %endcomment%
                        %case 'pendingEnabled'%
                            <script>writeTD('rowdata');</script>
                            Pending enabled
                            </td>
						%comment%-- end trax# 1-14BGHB --%endcomment%
    
                    %endswitch%
    
                    %ifvar connectionState equals('disabled')%
                        <script>writeTD('rowdata');</script>
                            <a href="/WmART/ConnNodeDetails.dsp?readOnly=false&connectionAlias=%value -urlencode connectionAlias%&adapterTypeName=%value -urlencode ../adapterTypeName%&searchConnectionName=%value -urlencode ../searchConnectionName%">
                                <img src="/WmART/icons/config_edit.gif" alt="Edit" border=0>
                            </a>
                        </td>
                    %else%
                        <script>writeTD('rowdata');</script>
                            <img src="/WmART/icons/disabled_edit.gif" alt="Disable Connection to Edit" border=0>
                        </td>
                    %endif%
	    
                    <script>writeTD('rowdata');</script>
                        <a href="/WmART/ConnNodeDetails.dsp?readOnly=true&connectionAlias=%value -urlencode connectionAlias%&adapterTypeName=%value -urlencode ../adapterTypeName%&searchConnectionName=%value -urlencode ../searchConnectionName%">
                            <img src="/WmRoot/icons/file.gif" alt="View" border=0>
                        </a>
                    </td>
    
                    <script>writeTD('rowdata');</script>
                    
                        <a href="/WmART/CopyConnection.dsp?readOnly=false&connectionAlias=%value -urlencode connectionAlias%&adapterTypeName=%value -urlencode ../adapterTypeName%&searchConnectionName=%value -urlencode ../searchConnectionName%">
                            <img src="/WmART/icons/copy.gif" alt="Copy" border=0>
                        </a>
                    </td>
    
                    <script>writeTD('rowdata');swapRows();</script>
                        %ifvar connectionState equals('disabled')%
                            <a href="/WmART/ListResources.dsp?action=deleteConnection&connectionAlias=%value -urlencode connectionAlias%&adapterTypeName=%value -urlencode ../adapterTypeName%&dspName=.LISTRESOURCES"
                               ONCLICK="return confirmDelete('%value connectionAlias%');">
                                <img src="/WmRoot/icons/delete.gif" alt="Delete" border=0>
                            </a>
                        %else%
                            <img src="/WmART/icons/delete_disabled.gif" alt="Disable Connection to Delete" border=0>
                        %endif%
                    </td>
                </tr>
            %endloop%
        %else%
            <tr><td class="message" colspan=8>No connections found</td></tr>
        %endif%		
		
        %onerror%
            %ifvar localizedMessage%
                <tr><td class="message">Error encountered <pre>%value localizedMessage%</pre></td></tr>
            %else%
                %ifvar error%
                    <tr><td class="message">Error encountered <pre>%value errorMessage%</pre></td></tr>
                %endif%
            %endif%
        %endinvoke%
        </table>	
        	
		<div class="oddrowdata" id="goContainer" name="goContainer" style="display:none;padding-top=2mm;">
        	%ifvar pStart equals('1')%
				<label style="color:#666666;font-weight:bold;text-align:inherit;">
				Page (1-<script>writeTD('rowdata-l');</script>%value pageSize% )</td></label>
		
			%else%		
        		<a href="/WmART/ListResources.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchConnectionName=%value -urlencode searchConnectionName%&prev=true&dspName=.LISTRESOURCES">&laquo; Previous</a>&nbsp;<label style="color:#666666;font-weight:bold;text-align:inherit;">Page (1-
				<script>writeTD('rowdata-l');</script>%value pageSize% )</label></td>
			%endif%	
			<input type="text" name="pageNumber" value="%value pStart%" size="1" onkeypress="return isNumberKey(this.form,event);">&nbsp;<input type="submit" name="Go" value="Go" onClick="jumpToPage(this);return false;">				
			%ifvar pStart vequals(pageSize)%			
				<!-- Next -->
			%else%
				<a href="/WmART/ListResources.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchConnectionName=%value -urlencode searchConnectionName%&prev=false&dspName=.LISTRESOURCES">Next &raquo;</a>
			%endif%		
		</div>
        
		<div class="oddrowdata" id="paginationContainer" name="paginationContainer" style="display:;padding-top=2mm;">
        %ifvar pStart equals('1')%
			%else%
        		<a href="/WmART/ListResources.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchConnectionName=%value -urlencode searchConnectionName%&prev=true&dspName=.LISTRESOURCES">&laquo; Previous</a>              
			%endif%
	        %loop totalNosOfPages%
		        %ifvar totalNosOfPages -notempty%           		
	         		<a href="/WmART/ListResources.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchConnectionName=%value -urlencode searchConnectionName%&pageNumber=%value -urlencode totalNosOfPages%&dspName=.LISTRESOURCES">
	         		%ifvar totalNosOfPages vequals(/pStart)% 
	         			<a><label style="color:#666666;font-weight:bold;">%value totalNosOfPages%</label>
		%else%		
	         			%ifvar totalNosOfPages equals('...')%
	         				</a><a href="javascript:showHidePageCriteria()">%value totalNosOfPages%</a>
	         			%else%
	         				%value totalNosOfPages%<a>
	         			%endif%
	         		%endif%	
	         	%else%
	         		%value pStart%
		%endif%	
						
            %endloop%		
		%ifvar pStart vequals(pageSize)%			
				<!-- Next -->
		%else%
				<a href="/WmART/ListResources.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchConnectionName=%value -urlencode searchConnectionName%&prev=false&dspName=.LISTRESOURCES">Next &raquo;</a>
		%endif%		
		</div>
    	<input type="hidden" name="adapterTypeName" value="%value adapterTypeName%">
    	<input type="hidden" name="searchConnectionName" value="%value searchConnectionName%">     	
    	<input type="hidden" name="pStart" value="%value pStart%">    	 
    	<input type="hidden" name="totalNosOfPages" value="%value totalNosOfPages%">
    	<input type="hidden" name="pageNumber" value="%value pageNumber%">
	<input type="hidden" name="pageSize" value="%value pageSize%">         	 
    	<input type="hidden" value="" name="sortCriteria">
    	<input type="hidden" value="%value pageLabel%" name="pageLabel">
        </form>        
    </body>
</HTML>
