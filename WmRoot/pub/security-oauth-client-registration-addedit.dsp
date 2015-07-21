<HTML>
<HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">

<TITLE>Integration Server Settings</TITLE>
<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
<SCRIPT SRC="webMethods.js.txt"></SCRIPT>
<SCRIPT>
	String.prototype.trim = function () {
		return this.replace(/^\s*/, "").replace(/\s*$/, "");
	}
	
	function isValidURL(url){
     	return url.match(/^(ht)tps?:\/\/[a-z0-9]/);
	} 
	
	function validateRedirectUris(regForm){
		var uriArray = regForm.dsp_redirect_uris.value.split("\n");
		var illegalChars = '^#%"';
		
		for(var i = 0;i<uriArray.length;i++){
			
			if (!isblank(uriArray[i]) && !isValidURL(uriArray[i])){
				alert(uriArray[i]+" is not valid, must enter valid Redirect URIs");
				return false;
			}
			
			for (var j=0; j<illegalChars.length; j++)
            {
              if (uriArray[i].indexOf(illegalChars.charAt(j)) >= 0)
              {
                alert (uriArray[i] + " contains illegal character: '" + illegalChars.charAt(j) + "'.\n Must enter valid Redirect URIs");
                return false;
              }
            }
			
		}
		return true;
	}
	
	function validateData(){
		var regForm=document.forms['oAuthClientRegForm'];
		
		if(isblank(regForm.name.value)){
			alert("Must provide a value for Name");
			regForm.name.focus();
			return false;
		}
		if(isSpclChar(regForm.name.value)){
			alert("The client name contains illegal characters, provide a valid value.");
			regForm.name.focus();
			return false;
		}
		if(isblank(regForm.version.value)){
			alert("Must provide a value for Version");
			regForm.version.focus();
			return false;
		}
		if(isSpclChar(regForm.version.value)){
			alert("The client version contains illegal characters, provide a valid value.");
			regForm.version.focus();
			return false;
		}
		if(isblank(regForm.dsp_redirect_uris.value)){
			alert("Must provide a value for Redirect URIs");
			regForm.dsp_redirect_uris.focus();
			return false;
		}
		if(!validateRedirectUris(regForm)){
			return false;
		}
		if(!validateIntValue(regForm.token_lifetime.value,'Expiration Interval')){
			return false;
		}
		if(!validateIntValue(regForm.token_refresh_limit.value,'Refresh Count')){
		 	return false;
		}
		%ifvar edit -notempty%
			regForm.operation.value="update-client";
		%else%
			regForm.operation.value="register-client";
		%endif%
				 
		var validateRefreshLimit=true;
			for (var j=0; j <regForm.refreshLimit.length; j++){
   		   		if (regForm.refreshLimit[j].checked){
           			if(regForm.refreshLimit[j].value!='0'){
           				validateRefreshLimit=false;
           			}
     			}
   			}
   			
   		   			
		if(validateRefreshLimit && (!isInteger(regForm.token_refresh_limit.value) || regForm.token_refresh_limit.value<0))
		{
			
   			alert("You must specify a valid positive Integer for Refresh Count limit.");
			regForm.token_refresh_limit.focus();
			return false;
			
		}
		
		for (var i=0; i < regForm.refreshLimit.length; i++){
   		   if (regForm.refreshLimit[i].checked){
           		if(regForm.refreshLimit[i].value!='0'){
           			regForm.token_refresh_limit.disabled=false;
           			regForm.token_refresh_limit.value=regForm.refreshLimit[i].value;
           		}
     		}
   		}
   		
   		for (var i=0; i < regForm.lifeTime.length; i++){
   		   if (regForm.lifeTime[i].checked){
           		if(regForm.lifeTime[i].value!=0){
           			regForm.token_lifetime.disabled=false;
           			regForm.token_lifetime.value=regForm.lifeTime[i].value;
           		}
     		}
   		}
		
		return true;
	}
	
	 function enabledisableLifeTimeField(lifetimeaction){
	 
  		if (lifetimeaction.value != 0){
  			document.forms['oAuthClientRegForm'].token_lifetime.value="";
			document.forms['oAuthClientRegForm'].token_lifetime.disabled = true;
		}else{
			document.forms['oAuthClientRegForm'].token_lifetime.disabled = false;
		}
	}
	
	function enabledisableRefreshLimitField(refershaction){
  		if (refershaction.value != 0){
  			document.forms['oAuthClientRegForm'].token_refresh_limit.value="";
			document.forms['oAuthClientRegForm'].token_refresh_limit.disabled = true;
		}else{
			document.forms['oAuthClientRegForm'].token_refresh_limit.disabled = false;
		}
	}
	
	function validateIntValue(fieldVal,fieldName){
		if(!isblank(fieldVal) && !isInteger(fieldVal)){
			alert("You must specify a valid Integer value for the field "+fieldName+".");
			return false;
		}
		return true;
	}
</SCRIPT>
</HEAD>
 
%ifvar edit -notempty%
<BODY onLoad="setNavigation('security-oauth-client-registration-addedit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_OAuthRegisterClientScrn');">
%else%
<BODY onLoad="setNavigation('security-oauth-client-registration-addedit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_OAuthEditClientScrn');">
%endif%

<FORM NAME="oAuthClientRegForm" action="security-oauth-client-registration.dsp" method="POST">

	<input type="hidden" name="operation">
	
  <TABLE WIDTH="100%">

            <TR>
                <TD class="menusection-Settings" colspan="3">
                   Security &gt; OAuth &gt; Client Registration &gt; 
                    %ifvar edit -notempty%
                    	Edit
                    %else%
                    	Register Client
                    %endif%
                    
                </TD>
            </TR>

            <TR>
                <TD colspan="3">
                    <UL>
                        <LI><a href="security-oauth-client-registration.dsp">Return to Client Registration</a></LI>
                    </UL>
                </TD>
            </TR>
            <TR>
           	 <TD width="2%">
			  &nbsp;
			</TD>
            <TD width="70%">
           		%ifvar client_id -notempty%
            		%invoke wm.server.oauth:getClientRegistration%
            		%endinvoke%
            	%else%
            		%ifvar name -notempty%
            			%invoke wm.server.oauth:getClientRegistrationUsingName%
            			%endinvoke%
            		%endif%
           		 %endif%
           		
            	<TABLE WIDTH="100%">
            		<TR>
            			<TD class="heading" colspan="2">Client Configuration</TD>
            		</TR>
            		%ifvar edit -notempty%
            		<TR>
            			<TD class="oddrow" nowrap>ID</TD>
            			<TD class="oddrow-l">
            			 	<INPUT NAME="client_id" id="client_id" TYPE="TEXT" VALUE="%value client_id%" SIZE="50" readonly="true" style="color:#808080;">
            			 </TD>
            		</TR>
            		<TR>
            			<TD class="evenrow" nowrap>Secret</TD>
            			<TD class="evenrow-l">
            			 	<INPUT NAME="client_secret" id="client_secret" TYPE="TEXT" VALUE="%value client_secret%" SIZE="50" readonly="true" style="color:#808080;">
            			 </TD>
            		</TR>
            		%endif%
            		<TR>
            			<TD class="oddrow" nowrap>Name</TD>
            			<TD class="oddrow-l">
            				%ifvar edit -notempty%
            			 		<INPUT NAME="name" id="name" TYPE="TEXT" VALUE="%value name%" SIZE="50" >
            			 	%else%
            			 		<INPUT NAME="name" id="name" TYPE="TEXT" VALUE="" SIZE="50">
            			 	%endif%
            			 </TD>
            		</TR>
            		<TR>
            			<TD class="evenrow" nowrap>Version</TD>
            			<TD class="evenrow-l">
            				%ifvar edit -notempty%
            			 		<INPUT NAME="version" id="version" TYPE="TEXT" VALUE="%value version%" SIZE="50">
            			 	%else%
            			 		<INPUT NAME="version" id="version"  TYPE="TEXT" VALUE="" SIZE="50">
            			 	%endif%
            			 </TD>
            		</TR>
            	
            		<TR>
            			<TD class="oddrow" nowrap>Type</TD>
            			 <TD class="oddrow-l">
            				%ifvar edit -notempty%
            				<SELECT name="type" id="type">
 								<OPTION value="confidential"  %ifvar type equals('confidential')% selected="true" %endif%>Confidential</OPTION>
  								<OPTION value="public"  %ifvar type equals('public')% selected="true" %endif%>Public</OPTION>
  							</SELECT>
  							%else%
  							<SELECT name="type" id="type">
  								<OPTION value="confidential">Confidential</OPTION>
  								<OPTION value="public">Public</OPTION>
							</SELECT>
							%endif%
            			 </TD>
            		</TR>
            		<TR>
            			<TD class="evenrow" nowrap>Description</TD>
            			<TD class="evenrow-l">
            				%ifvar edit -notempty%
            			 		<INPUT NAME="notes" id="notes" TYPE="TEXT" VALUE="%value notes%" SIZE="103">
            			 	%else%
            			 		<INPUT NAME="notes" id="notes" TYPE="TEXT" VALUE="" SIZE="103">
            			 	%endif%
            			 </TD>
            		</TR>
            		<TR>
            			<TD class="oddrow" nowrap>Redirect URIs</TD>
            			<TD class="oddrow-l">
            				
            				%ifvar edit -notempty%
            			 	 <textarea name="dsp_redirect_uris" id="dsp_redirect_uris" wrap="off"  rows="5" cols="100" >%value dsp_redirect_uris%</textarea> 
            			 	 %else%
            			 	 <textarea name="dsp_redirect_uris" id="dsp_redirect_uris" rows="5" cols="100"  wrap="off"></textarea> 
            			 	 %endif% <BR/>
            			 	 Enter one URI per line
            			 </TD>
            		</TR>
            		 <TR><TD><BR/></TD></TR>
            		<TR>
            			<TD class="heading" colspan="2">Token</TD>
            		</TR>
            		<TR>
            			<TD class="oddrow" nowrap>Expiration Interval</TD>
            			<TD class="oddrow-l">
            				%ifvar edit -notempty%
            				%switch token_lifetime%            		
            				%case '-2'%		
            				<INPUT type="radio" name="lifeTime" id="lifeTime" value="-2" checked onclick="enabledisableLifeTimeField(this)"/>Use OAuth Global Setting &lt; %value globalAccessTokenLiftime% &gt; <BR/>
            				<INPUT type="radio" name="lifeTime" id="lifeTime" value="-1" onclick="enabledisableLifeTimeField(this)"/>Never Expires <BR/>
            				<INPUT type="radio" name="lifeTime" id="lifeTime" value="0" onclick="enabledisableLifeTimeField(this)"/>Expires in &nbsp;
            				<INPUT NAME="token_lifetime" id="token_lifetime" TYPE="TEXT" SIZE="15" disabled="true">  seconds
            				%case '-1'%
            				<INPUT type="radio" name="lifeTime" id="lifeTime" value="-2" onclick="enabledisableLifeTimeField(this)"/>Use OAuth Global Setting &lt; %value globalAccessTokenLiftime% &gt; <BR/>
            				<INPUT type="radio" name="lifeTime" id="lifeTime" value="-1" checked onclick="enabledisableLifeTimeField(this)"/>Never Expires <BR/>
            				<INPUT type="radio" name="lifeTime" id="lifeTime" value="0" onclick="enabledisableLifeTimeField(this)"/>Expires in &nbsp;
            				<INPUT NAME="token_lifetime" id="token_lifetime" TYPE="TEXT" SIZE="15" disabled="true">  seconds
            				%case%
            				<INPUT type="radio" name="lifeTime" id="lifeTime" value="-2" onclick="enabledisableLifeTimeField(this)"/>Use OAuth Global Setting &lt; %value globalAccessTokenLiftime% &gt; <BR/>
            				<INPUT type="radio" name="lifeTime" id="lifeTime" value="-1" onclick="enabledisableLifeTimeField(this)"/>Never Expires <BR/>
            				<INPUT type="radio" name="lifeTime" id="lifeTime" value="0" checked onclick="enabledisableLifeTimeField(this)"/>Expires in &nbsp;
            				<INPUT NAME="token_lifetime" id="token_lifetime" TYPE="TEXT" VALUE="%value token_lifetime%" SIZE="15">  seconds
            			 	%end%
            			 	%else%
            			 	%invoke wm.server.oauth:getOAuthSettings%
            			 	<INPUT type="radio" name="lifeTime" value="-2" checked onclick="enabledisableLifeTimeField(this)"/>Use OAuth Global Setting %ifvar accessTokenLifetime equals('-1')% &lt; Never Expires &gt; %else% &lt; %value accessTokenLifetime%  seconds &gt;  %endif% <BR/>
            			 	<INPUT type="radio" name="lifeTime" value="-1" onclick="enabledisableLifeTimeField(this)"/>Never Expires <BR/>
            				<INPUT type="radio" name="lifeTime" value="0" onclick="enabledisableLifeTimeField(this)"/>Expires in &nbsp;
            			 	<INPUT NAME="token_lifetime" id="token_lifetime"  TYPE="TEXT" VALUE="" SIZE="15">  seconds
            			 	%endinvoke%
            			 	%endif%
            			 </TD>
            		</TR>
            		<TR>
            			<TD class="evenrow" nowrap>Refresh Count</TD>
            			<TD class="evenrow-l">
            				%ifvar edit -notempty%
            				%switch token_refresh_limit%
            				 %case '-1'%
            				<INPUT type="radio" name="refreshLimit" id="refreshLimit" value="-1" checked onclick="enabledisableRefreshLimitField(this)"/>Unlimited <BR/>
            				<INPUT type="radio" name="refreshLimit" id="refreshLimit" value="0" onclick="enabledisableRefreshLimitField(this)"/>Limit &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            				<INPUT NAME="token_refresh_limit" id="token_refresh_limit" TYPE="TEXT" SIZE="15" disabled="true"> 
            				%case%
            				<INPUT type="radio" name="refreshLimit" id="refreshLimit" value="-1" onclick="enabledisableRefreshLimitField(this)"/>Unlimited <BR/>
            				<INPUT type="radio" name="refreshLimit" id="refreshLimit" value="0" checked onclick="enabledisableRefreshLimitField(this)"/>Limit &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            				<INPUT NAME="token_refresh_limit" id="token_refresh_limit" TYPE="TEXT" VALUE="%value token_refresh_limit%" SIZE="15">
            				%end%
            			 	%else%
            			 	<INPUT type="radio" name="refreshLimit" id="refreshLimit" value="-1" onclick="enabledisableRefreshLimitField(this)"/>Unlimited <BR/>
            				<INPUT type="radio" name="refreshLimit" id="refreshLimit" value="0" checked onclick="enabledisableRefreshLimitField(this)"/>Limit &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            			 	<INPUT NAME="token_refresh_limit" id="token_refresh_limit" TYPE="TEXT" VALUE="0" SIZE="15">
            			 	%endif%
            			 </TD>
            		</TR>
            		
            	</TABLE>
            </TD>
             <TD width="28%">
			  &nbsp;
			</TD>
            </TR>
            <TR>
            	<TD width="2%">
            	&nbsp;
            	</TD>
				<TD  class="action" >
					<input type="submit" name="submit" value="Save Changes" onclick="return validateData();">
				</TD>
				 <TD width="28%">
			  	&nbsp;
				</TD>
			</TR>
    </TABLE>
	<input type="hidden" name="dsp_scopes" value="%value dsp_scopes%">
	%ifvar edit -notempty%
		<input type="hidden" name="enabled" value="%value enabled%">
	%else%
		<input type="hidden" name="enabled" value="true">
	%endif%
</FORM>
</BODY>
</HEAD>
</HTML>