
<HTML>
  <HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt">
    </SCRIPT>
    <SCRIPT LANGUAGE="JavaScript">
    			var agent = navigator.userAgent.toLowerCase();   
    			var ie = (agent.indexOf("msie") != -1);
    
	 	
	 		  function confirmEditBypass()
	 		  {
		 		  document.addform.submit();
		 		  return true;
	 		  }
	 		  
	 		  function toggleFtpSubtype(display)
	          {	
			 		elem = document.getElementById("ftpSubtype");
			 		rows = elem.rows;
					if (display == "on")
					{
						for(i = 0; i < rows.length; i++){
			   		    	if (ie) {
				   		     rows[i].style.display="block";
				   		   }else{
				   		     rows[i].style.display="block";
						     rows[i].style.display="table-row";
						   }
			   		    }
			   		    elem = document.getElementById("defaultRow");
			   		    rows = elem.rows;
			   		    cols = rows[0].cells;
			   		    cols[0].setAttribute((document.all ? 'className' : 'class'), "evenrow");
			   		    cols[1].setAttribute((document.all ? 'className' : 'class'), "evenrow-l");
	   				}
					else
					{
						for(i = 0; i < rows.length; i++){
			   		    	rows[i].style.display="none";
			   		    }
			   		    elem = document.getElementById("defaultRow");
			   		    rows = elem.rows;
			   		    cols = rows[0].cells;
			   		    cols[0].setAttribute((document.all ? 'className' : 'class'), "oddrow");
			   		    cols[1].setAttribute((document.all ? 'className' : 'class'), "oddrow-l");
					}
			  }
	
	 		  function overwriteDefaultProxy()
	 		  {
	 		  	// Check HTTP
	 		  	if ( document.addform.protocol[0].checked == true)
	 		  	{ 
		          	if ( document.addform.isDefault[0].checked == true &&
		          		 document.addform.defaultHTTPProxyAlias.value != "" &&
		          	 	 document.addform.defaultHTTPProxyAlias.value != document.addform.proxyAlias.value
  		          	)
  		          	{
	          			var confirmation = confirm("\"" + document.addform.defaultHTTPProxyAlias.value + "\" is configured as default HTTP proxy server. Do you want to set \"" + document.addform.proxyAlias.value + "\" as the new default HTTP proxy server?");
		                if (confirmation == false)
				             return false;
		          	}
		         }
		         // Check HTTPS
		         else if ( document.addform.protocol[1].checked == true)
		         {
			         	if ( document.addform.isDefault[0].checked == true &&
			         		 document.addform.defaultHTTPSProxyAlias.value != "" &&
			          	 	 document.addform.defaultHTTPSProxyAlias.value != document.addform.proxyAlias.value
  			          	)
  			          	{
		         			var confirmation = confirm("\"" + document.addform.defaultHTTPSProxyAlias.value + "\" is configured as default HTTPS proxy server. Do you want to set \"" + document.addform.proxyAlias.value + "\" as the new default HTTPS proxy server?");
			                if (confirmation == false)
					             return false;
					    }
		         }
		         // Check FTP
		         else if ( document.addform.protocol[2].checked == true)
		         {
		         		if ( document.addform.isDefault[0].checked == true &&
			         		 document.addform.defaultFTPProxyAlias.value != "" &&
			          	 	 document.addform.defaultFTPProxyAlias.value != document.addform.proxyAlias.value
  			          	)
  			          	{
		         			var confirmation = confirm("\"" + document.addform.defaultFTPProxyAlias.value + "\" is configured as default FTP proxy server. Do you want to set \"" + document.addform.proxyAlias.value + "\" as the new default FTP proxy server?");
			                if (confirmation == false)
					             return false;
					    }
		         }
		         return true;
	 		  }
	 		  
	          function confirmEdit ()
	          {
	            if ((document.addform.proxyAlias.value == "") ||
	                (document.addform.port.value == "")  ||
	                (document.addform.host.value == "")
					)
	            {
	              alert ("You must specify the arguments (Alias, Host Name or IP Address, Port Number) for the proxy server.");
	            }
	            else
	            {
	            	// Check Alias Overwrite
	               	if( overwriteAlias(document.addform.proxyAlias.value))
		          	{
						//Check Default Proxy overwrite
						if (overwriteDefaultProxy())
						{
					       	document.addform.submit();
		        	 		return true;
		        	 	}
	        		}
	        	  	else
	        	  		return false;
	              
	            }
		        return false;
	          }
	          function confirmAdd ()
	          {
		            if ((document.addform.proxyAlias.value == "") ||
		                (document.addform.port.value == "")  ||
		                (document.addform.host.value == "")
						)
		            {
		              alert ("You must specify the arguments (Alias, Host Name or IP Address, Port Number) for the proxy server.");
		              return false;
		            }
		            else if (! checkLegalName (document.addform.proxyAlias, "Alias") ||
		                    (! checkLegalUserName (document.addform.username.value, "Username")))
		            {
		            }
		            else
		            {
		            	if( overwriteAlias(document.addform.proxyAlias.value))
		            	{
				        	//Check Default Proxy overwrite
							if (overwriteDefaultProxy())
							{
						       	document.addform.submit();
			        	 		return true;
			        	 	}
		        	  	}
		        	  	else
		        	  		return false;
	            }
	            return true;
	          }
	          
	          
	          function overwriteAlias(alias)
	          {
 			               %ifvar action equals('edit')%
		          			  if (alias == document.addform.oldAlias.value)
		          			  	 return true;
		          		   %endif%
	          			  	
			          	  var aliasesArray;
			              if (! document.addform.aliases)
			              {
			                aliasesArray = new Array(0);
			              }
			              else if (! document.addform.aliases.length)
			              {
			                aliasesArray = new Array(1);
			                aliasesArray[0] = document.addform.aliases.value;
			              }
			              else
			              {
			                var aliasesLen = document.addform.aliases.length;
			                aliasesArray = new Array(aliasesLen);
			                for (i = 0; i < aliasesLen; i++)
			                {
			                  aliasesArray[i] = document.addform.aliases[i].value;
			                }
			              }
			            
			              for (ind = 0; ind < aliasesArray.length; ind++)
			              {
			                if (aliasesArray[ind] == alias)
			                {
				                  var confirmation = confirm("Do you want to overwrite existing alias " + document.addform.proxyAlias.value + "?");
				                  if (confirmation == false)
				                  {
				                    return false;
				                  }
			           		}
					      }
					      return true;
	          }
	          
	      	  function checkLegalName(field, fieldName)
	      	  {
	            var name = field.value;
	            var illegalChars = "- #&@^!%*:$./\\`;,~+=)(|}{][><\"";
	
	            for (var i=0; i<illegalChars.length; i++)
	            {
	              if (name.indexOf(illegalChars.charAt(i)) >= 0)
	              {
	                alert (fieldName + " contains illegal character: '" + illegalChars.charAt(i) + "'");
	                return false;
	              }
	            }
	            return true;
	          }
	      	  function checkLegalUserName(userName, fieldName)
	      	  {
	            var illegalChars = " \\\"";
	
	            for (var i=0; i<illegalChars.length; i++)
	            {
	              if (userName.indexOf(illegalChars.charAt(i)) >= 0)
	              {
	                alert (fieldName + " contains illegal character: '" + illegalChars.charAt(i) + "'");
	                return false;
	              }
	            }
	            return true;
	          }
	          </SCRIPT>
  </HEAD>
  %switch action% 
  %case 'editBypass'%
  <BODY onLoad="setNavigation('settings-proxy-addedit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditProxyBypassScrn');">
  %case 'edit'%
  <BODY onLoad="setNavigation('settings-proxy-addedit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditProxyScrn');">
  %case%
  <BODY onLoad="setNavigation('settings-proxy-addedit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_CreateProxyAliasScrn');">
  %end%
    <TABLE width="100%">
      <TR>
        <TD class="menusection-Settings" colspan="2">
            Settings &gt;
            Proxy Servers &gt;
            %ifvar action equals('edit')%
                %value proxyAlias% &gt; Edit
            %else%
              %ifvar action equals('editBypass')%
              	Edit Proxy Bypass
              %else%
		              Create Alias
              %endif%
            %endif%
        </TD>
      </TR>
      <TR>
        <TD colspan="2">
          <UL>
            <LI><A HREF="settings-network.dsp">Return to Proxy Servers</A></LI>
          </UL>
        </TD>
      </TR>
      	
   		<TR>
	        <TD></TD>
	        <TD>
	    		 <TABLE class="tableForm">
			        <TR>
	    		        <TD colspan="2" class="heading">%ifvar action equals('editBypass')%Proxy Bypass%else%Proxy Server Alias Properties%endif%</TD>
			        </TR>
	    		    <FORM NAME="addform" ACTION="settings-network.dsp" METHOD="POST">

	          
	          		  %ifvar action equals('editBypass')%
				          	%invoke wm.server.query:getSettings%
					      	<TR>
			        		   <TD class="oddrow">Addresses</TD>
					           <TD class="oddrow-l">
					           	<INPUT NAME="watt.net.proxySkipList" VALUE="%value watt.net.proxySkipList%" size=40>
					         </TD>
			        		</TR>
							<TR>
			        		   <TD class="evenrow"/>
					           <TD class="evenrow-l">Use commas (,) to separate entries.</TD>
							</TR>
							%endinvoke%
				     %else%
				          <TR>
				            <TD class="oddrow">Alias</TD>
				            <TD class="oddrow-l">
				              <INPUT NAME="proxyAlias" VALUE="%value proxyAlias%"> 
				              </TD>
				          </TR>
				          <TR>
				            <TD class="evenrow">Host Name or IP Address</TD>
				            <TD class="evenrow-l">
				              <INPUT NAME="host" VALUE="%value host%"> </TD>
				          </TR>
				          <TR>
				            <TD class="oddrow">Port Number</TD>
				            <TD class="oddrow-l">
				              <INPUT NAME="port" VALUE="%ifvar port equals('-1')%%else%%value port%%endif%" SIZE=5 MAXLENGTH=5> </TD>
				          </TR>
				          <TR>
				            <TD class="evenrow">User Name (optional)</TD>
				            <TD class="evenrow-l">
				              <INPUT NAME="username" VALUE="%value username%"> </TD>
				          </TR>
				          <TR>
				            <TD class="oddrow">Password (optional)</TD>
				            <TD class="oddrow-l">
				              <INPUT NAME="password" TYPE="password" autocomplete="off" VALUE="%value password%"/> </TD>
				          </TR>
				          <TR>
						        <TD class="evenrow">Protocol</TD>
						        <TD class="evenrow-l">
						          	<input type="radio" 
						          		%ifvar action equals('add')%
						          			checked
						          		%else%
						          			%ifvar protocol equals('HTTP')%
						          				checked
						          			%endif%
						          		%endif% 
						          		name="protocol" value="HTTP" onclick="toggleFtpSubtype('off');"
						          		>HTTP</input>
						          	<input type="radio" 
						          	 	%ifvar protocol equals('HTTPS')%checked%endif%
						          		name="protocol" value="HTTPS" onclick="toggleFtpSubtype('off');" 
						          		>HTTPS</input>
						          	<input type="radio" 
						          	%ifvar protocol equals('FTP')%checked%endif%
						          	name="protocol" value="FTP" onclick="toggleFtpSubtype('on');"
						          	>FTP</input>
						        </TD>
					      </TR>
					      	<tbody id="ftpSubtype">
						  	<TR>
						          <TD class="oddrow">Proxy Type</TD>
						          <TD class="oddrow-l">
										<input type="radio" name="ftpType"  checked %ifvar ftpType equals('0')%checked%endif% value="0">0. No proxy<br>
										<input type="radio" name="ftpType"  %ifvar ftpType equals('1')%checked%endif% value="1">1. ftp_user@ftp_host no proxy auth.<br>
										<input type="radio" name="ftpType"  %ifvar ftpType equals('2')%checked%endif% value="2">2. ftp_user@ftp_host proxy auth<br>
										<input type="radio" name="ftpType"  %ifvar ftpType equals('3')%checked%endif% value="3">3. site command<br>
										<input type="radio" name="ftpType"  %ifvar ftpType equals('4')%checked%endif% value="4">4. open command<br>
										<input type="radio" name="ftpType"  %ifvar ftpType equals('5')%checked%endif% value="5">5. ftp_user@proxy_user@ftp_host<br>		        
										<input type="radio" name="ftpType"  %ifvar ftpType equals('6')%checked%endif% value="6">6. proxy_user@ftp_host<br>		        									
										<input type="radio" name="ftpType"  %ifvar ftpType equals('7')%checked%endif% value="7">7. ftp_user@ftp_host proxy_user<br>		        									
								  </TD>
					         </TR>
							</tbody>
							<tbody id="defaultRow">
							<TR>
					            <TD>Default</TD>
				    	        <TD>
										<input type="radio" name="isDefault"  
											%ifvar isDefault equals('Y')%
												checked
											%endif%  
											value="Y">Yes</input>
										<input type="radio" name="isDefault"  
											%ifvar action equals('add')%
												checked 
											%else% 
												%ifvar isDefault equals('N')%
													checked
												%endif% 
											%endif%
											value="N">No</input>
								</TD>
					          </TR>
					          </tbody>
					     	 %ifvar protocol equals('FTP')%
				        		<SCRIPT>toggleFtpSubtype('on');</SCRIPT>
				        	%else%
				        		<SCRIPT>toggleFtpSubtype('off');</SCRIPT>
				        	%endif%
					%endif%  
			
			<!-- HIDDEN FIELDS -->
	        <INPUT type="hidden" NAME="status" VALUE="%value status%"> 
			%invoke wm.server.proxy:getDefaultHTTPProxyAlias%
				%ifvar defaultHTTPProxyAlias -isnull%
					<input type="hidden" name="defaultHTTPProxyAlias" value=""/>
				%else%
					<input type="hidden" name="defaultHTTPProxyAlias" value="%value defaultHTTPProxyAlias%"/>
				%endif%
		     %endinvoke%
	        
	        %invoke wm.server.proxy:getDefaultHTTPSProxyAlias%
	          	%ifvar defaultHTTPSProxyAlias -isnull%
					<input type="hidden" name="defaultHTTPSProxyAlias" value=""/>
				%else%
					<input type="hidden" name="defaultHTTPSProxyAlias" value="%value defaultHTTPSProxyAlias%"/>
				%endif%
	         %endinvoke%
	         
	         %invoke wm.server.proxy:getDefaultFTPProxyAlias%
				%ifvar defaultFTPPProxyAlias -isnull%
					<input type="hidden" name="defaultFTPProxyAlias" value=""/>
				%else%
					<input type="hidden" name="defaultFTPProxyAlias" value="%value defaultFTPProxyAlias%"/>
				%endif%
	         %endinvoke%
	         

			%invoke wm.server.proxy:getProxyServerAliases%
	          <TR>
	          %loop proxyAliases%
	            <TD>
	              <INPUT TYPE="hidden" NAME="aliases" VALUE="%value proxyAliases%" />
	            </TD>
	          %endloop%
	          </TR>
	         %endinvoke%

	          <TR>
	            <TD colspan=2 class="action">
	            %ifvar action equals('edit')%
	              <INPUT TYPE="hidden" NAME="action" VALUE="edit">
	              <INPUT TYPE="hidden" NAME="oldAlias" VALUE="%value proxyAlias%">
	              <INPUT type="button" value="Save Changes" onclick="return confirmEdit();">
	            %else%
						%ifvar action equals('editBypass')%
			              <INPUT TYPE="hidden" NAME="action" VALUE="editBypass">
			              <INPUT type="button" value="Save Changes" onclick="return confirmEditBypass();">
		            	%else%
			              <INPUT TYPE="hidden" NAME="action" VALUE="add">
			              <INPUT type="button" value="Save Changes" onclick="return confirmAdd();">
		            	%endif%
	            %endif%
	            </TD>
	          </TR>

	        </FORM>
	      </TABLE>
	    </TD>
	  </TR>	      

      
  
	</TABLE>

    </BODY>
  </HTML>
