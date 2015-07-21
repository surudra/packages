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
		<TD class="menusection-DeployerServers" colspan="4"> %value serverAlias% &gt; Remote Server Properties</TD>
	</TR>
</TABLE>

<TABLE width="100%">
    %invoke wm.deployer.gui.server.ISCluster:isClusterNode%
        %onerror%
            <TR><TD>error in wm.deployer.gui.server.ISCluster:isClusterNode</TD></TR>
        	%loop -struct%
        		<TR><TD>%value $key%=%value%</TD></TR>
        	%endloop%
    %endinvoke%
    <!-- save status + message for later -->
    %rename status isCNstatus -copy%
    %rename message isCNmessage -copy%
    
    <!-- Refresh and other top of page links -->
	<TR>
		<TD colspan="2">
            <UL>	
                <LI><a onclick="startProgressBar();" href="remote-server-properties.dsp?serverAlias=%value serverAlias%">Refresh this Page</a></LI>
                %ifvar isCluster equals('true')%
                <LI><a onclick="startProgressBar();" href="cluster-properties.dsp?serverAlias=%value serverAlias%">Cluster Properties for %value serverAlias%</a></LI>
                %endif%
            </UL>	                
		</TD>
	</TR>

   	<TR>
        <TD><IMG height="10" src="images/blank.gif" width="5"></TD>
        <TD>
            %rename serverAlias alias -copy%
            %invoke wm.deployer.Wrapper:getAliasValues%
            %onerror%
                <TR><TD>error in wm.deployer.Wrapper:getAliasValues</TD></TR>
            	%loop -struct%
            		<TR><TD>%value $key%=%value%</TD></TR>
            	%endloop%
            %endinvoke%
            
            <!-- Main alias value display, always present -->
	    %scope aliasValues%	    
            <TABLE class="tableView" width="100%">
        		<TR>
        			<TD class="heading" colspan="2">Remote Server Alias Properties</TD>
        		</TR>
        
                <TR>
                	<script> writeTD("row"); </script>Alias</TD>
                	<script> writeTD("rowdata-l", "nowrap"); </script>%value alias%</TD>
                </TR>
                <SCRIPT>swapRows();</SCRIPT>    
                <TR>
                	<script> writeTD("row"); </script>Host Name or IP Address</TD>
                	<script> writeTD("rowdata-l", "nowrap"); </script>%value host%</TD>
                </TR>
                <SCRIPT>swapRows();</SCRIPT>    
                <TR>
                	<script> writeTD("row"); </script>Port Number</TD>
                	<script> writeTD("rowdata-l", "nowrap"); </script>%value port%</TD>
                </TR>
                <SCRIPT>swapRows();</SCRIPT>    
                <TR>
                	<script> writeTD("row"); </script>User Name</TD>
                	<script> writeTD("rowdata-l", "nowrap"); </script>%value user%</TD>
                </TR>
                <SCRIPT>swapRows();</SCRIPT>    
                <TR>
                	<script> writeTD("row"); </script>Execute ACL</TD>
                	<script> writeTD("rowdata-l", "nowrap"); </script>%value acl%</TD>
                </TR>
                <SCRIPT>swapRows();</SCRIPT>    
                <TR>
                	<script> writeTD("row"); </script>Idle Timeout (minutes)</TD>
                	<script> writeTD("rowdata-l", "nowrap"); </script>%value timeout% (0 = none)</TD>
                </TR>
                <SCRIPT>swapRows();</SCRIPT>    
                <TR>
                	<script> writeTD("row"); </script>Use SSL</TD>
                	<script> writeTD("rowdata-l", "nowrap"); </script>%value ssl%</TD>
                </TR>
                <SCRIPT>swapRows();</SCRIPT>    
                <TR>
                	<script> writeTD("row"); </script>Private Key</TD>
                	<script> writeTD("rowdata-l", "nowrap"); </script>%value privKeyFile%</TD>
                </TR>
                <SCRIPT>swapRows();</SCRIPT>    
                <TR>
                	<script> writeTD("row"); </script>Certificates</TD>
                	<script> writeTD("rowdata-l", "nowrap"); </script>%value certFiles%</TD>
                </TR>
                <SCRIPT>swapRows();</SCRIPT>    
                <TR>
                	<script> writeTD("row"); </script>Retry Server</TD>
                	<script> writeTD("rowdata-l", "nowrap"); </script>%value retryServer%</TD>
                </TR>
                <SCRIPT>swapRows();</SCRIPT>
            </TABLE>
	    %endscope%
        </TD>
    </TR>


    <!-- Cluster host list, only if it exists -->
  	<TR>
		<TD><IMG height="4" src="images/blank.gif" width="0" border="0"></TD>
	</TR>

   	<TR>
        <TD><IMG height="10" src="images/blank.gif" width="5"></TD>
        <TD>            
            <TABLE class="tableView" width="100%">
		        <TR>
		          <TD class="heading">Cluster Hosts</TD>
		        </TR>		
                %ifvar isCluster equals('true')%
    				<TR>
    					<td class="oddcol-l">Online Hosts</td>
    				</TR>
    				<script>resetRows();</script>
                    %invoke wm.deployer.gui.server.ISCluster:getClusterServerList%
        				%loop clusterServers%
        					<TR>
        						<script> writeTD("rowdata-l", "nowrap");</script><a>%value hostAddress%</a></TD>
        						<!-- could use hostExternal here -->
        					</TR>
        					<script>swapRows();</script>
        			    %endloop%
						<TR><td class="oddcol-l">Offline Hosts</td></TR>
						%loop offlineServers%
						<script>resetRows();</script>						
							<TR>								
								<script> writeTD("rowdata-l", "nowrap");</script><a>%value offlineServer%</a></TD>
							</TR>
						%endloop%
                        %onerror%
                            <TR><TD>error in wm.deployer.gui.server.ISCluster:getClusterServerList</TD></TR>
                        	%loop -struct%
                        		<TR><TD>%value $key%=%value%</TD></TR>
                        	%endloop%
                    %endinvoke%				
			    %else%
                    %ifvar isCNstatus equals('Error')%
    					<TR>
    						<script> writeTD("rowdata-l");</script><a>%value serverAlias%: %value isCNmessage%</a></TD>
    					</TR>                    
                    %else%
    					<TR>
    						<script> writeTD("rowdata-l");</script><a>%value serverAlias% is not clustered.</a></TD>
    					</TR>
					%endif%			    
			    %endif%
            </TABLE>
        </TD>
    </TR>
    
</TABLE>

<SCRIPT> stopProgressBar(); </SCRIPT>
</BODY></HTML>
