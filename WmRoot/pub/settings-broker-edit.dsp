
<HTML>
<HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
<SCRIPT SRC="webMethods.js.txt">
</SCRIPT>

%invoke wm.server.dispatcher.adminui:getBrokerSettings%

<SCRIPT LANGUAGE="JavaScript">

function displayTrustore(flag) {
	if ( flag == "true")
	{
		document.all.divtruststore.style.display = 'block';
	}
	else
	{
		document.all.divtruststore.style.display = 'none';
	}
}

function displaySettings(object) {
  if (object.options[object.selectedIndex].value == "basic") {
      document.all.divbasic.style.display = 'block';
      document.all.divssl.style.display = 'none';   
      document.editform.isEncrypted[1].disabled = false;         
  }else if (object.options[object.selectedIndex].value == "ssl") {
      document.all.divbasic.style.display = 'none';
      document.all.divssl.style.display = 'block';
      document.editform.isEncrypted[0].checked = true;
      document.editform.isEncrypted[1].disabled = true;
      displayTrustore('true');
  }else {
      document.all.divbasic.style.display = 'none';
      document.all.divssl.style.display = 'none';
      document.editform.isEncrypted[1].disabled = false;
  }
}

	function loadDocument() {
	
	//alert('%value certfileType%');
	
		setNavigation('settings-broker-edit.dsp',  '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Msging_EditBrokerScrn');
		
		%switch certfileType%
<!-- Trax 1-1RI0MD - 'JKS' is not supported for Keystore type  -->	
<!--   			%case 'JKS'% -->
<!--   				document.editform.certfileType.selectedIndex=1; -->
    			%case 'PKCS12'%
      				document.editform.certfileType.selectedIndex=1;
  		%end%
  		
  		%switch truststoreType%
    			%case 'JKS'%
      				document.editform.truststoreType.selectedIndex=1;
  		%end%
  		
  		//isSSLAltered();
	}
	
	
	function valueAltered()
	{
		document.editform.isChanged.value = "true";
	}
	
    function isIllegalName(name)
    {
    	// according to Enterprise Server Java Client API Reference Guide
    	// '@', '\', '/' are restricted characters
      	var illegalChars = "@/\\";

        for (var i=0; i<illegalChars.length; i++)
        {
      		if (name.indexOf(illegalChars.charAt(i)) >= 0)
        	return false;
    	}
    	return true;
    }
	
	function confirmEdit ()
	{ 	
		var configuredList = document.editform.BROKERCONFIGURATION;
		for (var i=0; i<configuredList.length; i++) {
			if (configuredList[i].checked) {
				config = configuredList[i].value;
			}
		}
		if ( config == "true" )
		{	
			
			if ( isblank(document.editform.brokerHost.value) )
			{
				alert ("Broker Host is required.");
				return false;
			}
			else if ( isblank(document.editform.brokerName.value) )
			{
				alert ("Broker Name is required.");
				return false;
			}
			else if ( isblank(document.editform.clientGroupName.value) )
			{
				alert ("Client Group is required.");
				return false;
			}
			else if ( isblank(document.editform.CLIENTPREFIX.value) )
			{
				alert("Client Prefix is required.");
				return false;
			}
			else if ( !isblank(document.editform.CLIENTPREFIX.value) &&
			          !isIllegalName(document.editform.CLIENTPREFIX.value))
			{
            			alert("Invalid Client Prefix value:\nRefer to Enterprise Server Java API Client Reference Guide for restricted characters.");
				return false;
			}
			
			//Client authentication Basic check
			if ( document.editform.clientAuth.value == "basic")
			{
				if (document.editform.brokerUser.value == "" || document.editform.brokerPassword.value == "")
				{
					alert("Broker username and password are required for Basic client authentication");
					return false;
				}
			}
			
			//Client authentication SSL check
			if ( document.editform.clientAuth.value == "ssl")
			{
				if (document.editform.certfile.value == "" || document.editform.certfileType.value == "" || document.editform.password.value == "")
				{
					alert("Keystore file, type and password are required for SSL client authentication");
					return false;
				}
			}
			
			if ( document.editform.isEncrypted[0].checked == true)
			{
				if (document.editform.truststore.value == "" || document.editform.truststoreType.value == "")
				{
					alert("Truststore file and type are required for encryption");
					return false;
				}
			}
			
		    	document.editform.submit();
		    	return true;
		    	 
		    	
		}else 
		{
		    document.editform.submit();
		   	return true;
		}
	}
</SCRIPT>  
</HEAD>
<body onLoad="loadDocument();">
<TABLE width="90%">
	<TR>
    	<TD class="menusection-Settings" colspan="2">Settings &gt; Messaging &gt; Broker Settings &gt; Edit</TD>
    </TR>
    
      
    <TR>
        <TD colspan="2">
          <UL>
            <LI><A HREF="settings-broker.dsp">Return to Broker Settings</A></LI>
          </UL>
        </TD>
    </TR>
    
    <TR>
	    <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
	    
	    <TD>
	    
	   
	
		<FORM NAME="editform" ACTION="settings-broker.dsp" METHOD="POST">
		 <TABLE class="tableView" width="60%">
	    		<script>swapRows();</script>
	    		<TR>
	    			<TD class="heading" colspan=3>Broker Configuration</TD>
	    		</TR>
	    
         
         	    	%invoke wm.server.dispatcher.adminui:isBrokerConfigured%
         	    	<script>swapRows();</script>
	 	    	<TR>
	 	    		<script>writeTDWidth("row", "25%");</script>
	 	    			Configured
	 	    		</TD>
	 	    		 %ifvar BROKERCONFIGURATION equals('false')%
	 				
	 	    		<script>writeTD("row-l");</script>
	 	    			<INPUT TYPE="radio" NAME="BROKERCONFIGURATION" VALUE="true" onChange="valueAltered()">Yes
	 	    			<INPUT TYPE="radio" NAME="BROKERCONFIGURATION" VALUE="false" onChange="valueAltered()" checked>No
	 	    		</TD>
	 	    		%else%
	 			<script>writeTD("row-l");</script>
	 				<INPUT TYPE="radio" NAME="BROKERCONFIGURATION" VALUE="true" onChange="valueAltered()" checked>Yes
	 				<INPUT TYPE="radio" NAME="BROKERCONFIGURATION" VALUE="false" onChange="valueAltered()">No
	 			</TD>	    		
	 	    		%endif%
	 	    	</TR>

			<script>swapRows();</script>
			<TR>
				<script>writeTDWidth("row", "25%");</script>Broker Host</TD>
				<script>writeTD("row-l");</script>
					<INPUT TYPE="hidden" NAME="isChanged" VALUE="false">
					<INPUT NAME="brokerHost" VALUE="%value brokerHost%" onChange="valueAltered()">
				</TD>
			</TR>

			<script>swapRows();</script>
			<TR>
				<script>writeTDWidth("row", "25%");</script>Broker Name</TD>
				<script>writeTD("row-l");</script>
					<INPUT NAME="brokerName" VALUE="%value brokerName%" onChange="valueAltered()">
				</TD>
			</TR>
			
			<script>swapRows();</script>
			<TR>
				<script>writeTDWidth("row", "25%");</script>Client Group</TD>
				<script>writeTD("row-l");</script>
					<INPUT NAME="clientGroupName" VALUE="%value clientGroupName%" onChange="valueAltered()">
				</TD>
			</TR>	        	        
			
			<script>swapRows();</script>
			<TR>
				<script>writeTDWidth("row", "25%");</script>Client Prefix</TD>
				<script>writeTD("row-l");</script>
					<INPUT NAME="CLIENTPREFIX" size="55" VALUE="%value CLIENTPREFIX%" onChange="valueAltered()">
				</TD>
			</TR>	        	        
			
			<script>swapRows();</script>
			<TR>

				<script>writeTDWidth("row", "25%");</script>Share Client Prefix</td>
				<script>writeTD("row-l");</script>
					%ifvar isISClustered equals(true)%
						<INPUT TYPE="radio" NAME="isISClustered" VALUE="true" checked disabled onChange="valueAltered()">Yes</INPUT>
						<INPUT TYPE="radio" NAME="isISClustered" VALUE="false" disabled onChange="valueAltered()">No</INPUT>
					%else%
						%ifvar isClientPrefixShared equals(true)%				
							<INPUT TYPE="radio" NAME="isClientPrefixShared" VALUE="true" checked onChange="valueAltered()">Yes</INPUT>
							<INPUT TYPE="radio" NAME="isClientPrefixShared" VALUE="false" onChange="valueAltered()">No</INPUT>
						%else%
							<INPUT TYPE="radio" NAME="isClientPrefixShared" VALUE="true" onChange="valueAltered()">Yes</INPUT>
							<INPUT TYPE="radio" NAME="isClientPrefixShared" VALUE="false" checked onChange="valueAltered()">No</INPUT>
						%endif%	
					%endif%
				</td>
			</TR>	        	 
			
			<TR>
				<td class="heading" colspan=3>Client Authentication Settings</td>
			</TR>
			
			<script>swapRows();</script>
			<tr>
				<script>writeTDWidth("row", "25%");</script>Client Authentication</TD>
				<script>writeTD("row-l");</script>
				      <select name="clientAuth" onchange="displaySettings(this.form.clientAuth);valueAltered()">
				      	%ifvar clientAuth equals('none')%
				      		<option value="none" selected>None</option>
				      	%else%
				      		<option value="none">None</option>
				      	%endif%

				      	%ifvar clientAuth equals('basic')%
				      		<option value="basic" selected>Username/Password</option>
				      	%else%
				      		<option value="basic">Username/Password</option>
				      	%endif%

				      	%ifvar clientAuth equals('ssl')%
				      		<option value="ssl" selected>SSL</option>
				      	%else%
				      		<option value="ssl">SSL</option>
				      	%endif%
					
				      </select>
				</td>
			</tr>
			<script>swapRows();</script>		
			</TABLE>
			
			%ifvar clientAuth equals('basic')%
				<div id="divbasic" STYLE="display: block">
			%else%
				<div id="divbasic" STYLE="display: none">
			%endif%	
			
				<table class="tableView" width="60%">
				
				<script>swapRows();</script>
				<tr>
					<script>writeTDWidth("row", "25%");</script>Username</TD>
					<script>writeTD("row-l");</script><INPUT NAME="brokerUser" VALUE="%value brokerUser%" onChange="valueAltered()"></td>
				</tr>

				<script>swapRows();</script>
				<tr>
					<script>writeTDWidth("row", "25%");</script>Password</TD>
					<script>writeTD("row-l");</script><INPUT NAME="brokerPassword" TYPE="password" autocomplete="off" VALUE="%value brokerPassword%" onChange="valueAltered()" /></td>
				</tr>
				</table>
			</div>

			%ifvar clientAuth equals('ssl')%
				<div id="divssl" STYLE="display: block">
			%else%
				<div id="divssl" STYLE="display: none">
			%endif%	

				<table class="tableView" width="60%">
				
				<script>swapRows();</script>
				<tr>
					<script>writeTDWidth("row", "25%");</script>Keystore</TD>
					<script>writeTD("row-l");</script><INPUT NAME="certfile" VALUE="%value certfile%" onChange="valueAltered()"></td>
				</tr>
				
				<script>swapRows();</script>
				<tr>
					<script>writeTDWidth("row", "25%");</script>Keystore Type</TD>
					<script>writeTD("row-l");</script>
						<select name="certfileType" onChange="valueAltered()">
						        <option value=""></option>
                					<option value="PKCS12" >PKCS12</option>
              					</select>
					</td>
				</tr>

				<script>swapRows();</script>
				<tr>
					<script>writeTDWidth("row", "25%");</script>Keystore Password</td>
					<script>writeTD("row-l");</script><INPUT NAME="password" TYPE="password" autocomplete="off" value="%value password%" onChange="valueAltered()" /></td>
				</tr>

				
			   </table>
			</div>
		
			<TABLE class="tableView" width="60%">
			<TR>
				<td class="heading" colspan=3>Encryption Settings</td>
			</TR>
			<script>swapRows();</script>
			<tr>
					<script>writeTDWidth("row", "25%");</script>Encryption</td>
					<script>writeTD("row-l");</script>
						%ifvar isEncrypted equals(true)%
							<INPUT TYPE="radio" NAME="isEncrypted" VALUE="true" checked onClick="displayTrustore('true');valueAltered()">Yes</INPUT>
							<INPUT TYPE="radio" NAME="isEncrypted" VALUE="false" onClick="displayTrustore('false');valueAltered()">No</INPUT>
						%else%
							<INPUT TYPE="radio" NAME="isEncrypted" VALUE="true" onClick="displayTrustore('true');valueAltered()">Yes</INPUT>
							<INPUT TYPE="radio" NAME="isEncrypted" VALUE="false" checked onClick="displayTrustore('false');valueAltered()">No</INPUT>
						%endif%
					</td>
			</tr>
			</table>
			
			%ifvar isEncrypted equals('true')%
				<div id="divtruststore" STYLE="display: block">
			%else%
				<div id="divtruststore" STYLE="display: none">
			%endif%	
			
				<table class="tableView" width="60%">
					<script>swapRows();</script>				
				<tr>
					<script>writeTDWidth("row", "25%");</script>Truststore</TD>
					<script>writeTD("row-l");</script><INPUT NAME="truststore" VALUE="%value truststore%" onChange="valueAltered()"></td>
				</tr>
				
				<script>swapRows();</script>
				<tr>
					<script>writeTDWidth("row", "25%");</script>Truststore Type</TD>
					<script>writeTD("row-l");</script>
						<select name="truststoreType" onChange="valueAltered()">
						        <option value=""></option>
                					<option value="JKS">JKS</option>
              					</select>
					</td>
				</tr>
				</table>
			</div>
			
		
		<table class="tableView" width="60%">
		<TR>
        	    <TD class="action" class="row" width="25%">
        	      <INPUT TYPE="hidden" NAME="action" VALUE="edit">
        	      <INPUT type="button" value="Save Changes" onclick="return confirmEdit()">
        	    </TD>
        	</TR>
        
        	%ifvar isUpdated equals('true')%
        	  <tr>
        	    <td class="subheading"> 
        	      * Settings have been modified. Server restart is required.
        	    </td>
        	  </tr>
        	%endif%	  
        </table>
        </FORM>
	    					<script>displaySettings(document.editform.clientAuth)</script>

	</TR>
      
 </TABLE>

 </BODY>
 </HTML>
