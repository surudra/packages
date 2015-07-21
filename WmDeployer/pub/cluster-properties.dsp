<HTML><HEAD>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Expires content=-1>
<LINK href="webMethods.css" type=text/css rel=stylesheet>
<SCRIPT src="webMethods.js"></SCRIPT>
</HEAD>
<BODY>

<TABLE width="100%">
	<TR>
		<TD class="menusection-DeployerServers" colspan="4"> %value serverAlias% &gt; Cluster Properties</TD>
	</TR>
</TABLE>

<TABLE width="100%">
    %invoke wm.deployer.gui.server.ISCluster:getClusterServerList%
        %onerror%
            <TR><TD>error in wm.deployer.gui.server.ISCluster:getClusterServerList</TD></TR>
        	%loop -struct%
        		<TR><TD>%value $key%=%value%</TD></TR>
        	%endloop%
    %endinvoke%
    
    <!-- Refresh and other top of page links -->
	<TR>
		<TD colspan="2">
            <UL>	
                <LI><a onclick="startProgressBar();" href="cluster-properties.dsp?serverAlias=%value serverAlias%">Refresh this Page</a></LI>
                <LI><a onclick="startProgressBar();" href="remote-server-properties.dsp?serverAlias=%value serverAlias%">Remote Server Properties for %value serverAlias%</a></LI>
            </UL>	                
		</TD>
	</TR>

   	<TR>
        <TD><IMG height="10" src="images/blank.gif" width="5"></TD>
        <TD>
            
            <TABLE class="tableView" width="100%">
        		<TR>
        			<TD class="heading" colspan="2">Cluster Configuration</TD>
        		</TR>

				<TR>
					<td class="oddcol-l">Remote Server</td><td class="oddcol">Status</td>
				</TR>
				<script>resetRows();</script>
                <TR>
                	<script> writeTD("row-l"); </script>%value serverAlias%</TD>

					<SCRIPT>writeTD('rowdata');</SCRIPT>

                        %invoke wm.deployer.gui.server.ISCluster:isValidClusterConfig%

						%ifvar status equals('Error')%
							<IMG alt="Error: %value -htmlcode message%" src="images/dependency.gif" border="0" width="14" height="14"></TD>
						%else%
							%ifvar offlineServers -notempty%
							<IMG alt="Warning: All nodes in the cluster are not online." src="images/warning.gif" border="0" width="16" height="16"></TD>
							%else%
								%ifvar isValidCluster equals('true')%
									<IMG alt="Cluster Configuration Ok" src="images/green_check.gif" border="0" width="13" height="13"></TD>
								%else%
								<IMG alt="Warning: %value -htmlcode message%" src="images/warning.gif" border="0" width="16" height="16"></TD>
								%endif%
							%endif%
						%endif%

                        %onerror%
                            <TR><TD>error in wm.deployer.gui.server.ISCluster:isValidClusterConfig</TD></TR>
                        	%loop -struct%
                        		<TR><TD>%value $key%=%value%</TD></TR>
                        	%endloop%
                        %endinvoke%

                </TR>
                <SCRIPT>swapRows();</SCRIPT>    
            </TABLE>
        </TD>
    </TR>

  	<TR>
		<TD><IMG height="4" src="images/blank.gif" width="0" border="0"></TD>
	</TR>

   	<TR>
        <TD><IMG height="10" src="images/blank.gif" width="5"></TD>
        <TD>            
            <TABLE class="tableView" width="100%">
		        <TR>
		          <TD class="heading">Online Cluster Hosts</TD>
		        </TR>		
                %ifvar clusterServers -notempty%
    				<TR>
    					<td class="oddcol-l">Host</td>
    				</TR>
    				<script>resetRows();</script>
    				%loop clusterServers%
    					<TR>
    						<script> writeTD("rowdata-l", "nowrap");</script><a>%value hostAddress%</a></TD>
    						<!-- could use hostExternal here -->
    					</TR>
    					<script>swapRows();</script>
    			    %endloop%				
			    %else%
					<TR>
						<script> writeTD("rowdata-l", "nowrap");</script><a>Online Cluster Host list unavailable.</a></TD>
					</TR>			    
			    %endif%
				
				<TR>
		          <TD class="heading">Offline Cluster Hosts</TD>
		        </TR>
				%ifvar offlineServers -notempty%
    				<TR>
    					<td class="oddcol-l">Host</td>
    				</TR>
    				<script>resetRows();</script>
    				%loop offlineServers%
    					<TR>
    						<script> writeTD("rowdata-l", "nowrap");</script><a>%value offlineServer%</a></TD>
    						<!-- could use hostExternal here -->
    					</TR>
    					<script>swapRows();</script>
    			    %endloop%				
			    %endif%
            </TABLE>
        </TD>
    </TR>
    
</TABLE>

<SCRIPT> stopProgressBar(); </SCRIPT>
</BODY></HTML>
