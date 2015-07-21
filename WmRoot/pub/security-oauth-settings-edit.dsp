<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  <script src="webMethods.js.txt"></script>
  
  <script LANGUAGE="JavaScript">
  	function valueAltered()
	{
		document.editform.isChanged.value = "true";
	}
	
	function confirmEdit ()
	{ 	
		var authCodeLifetime = document.editform.authCodeLifetime.value; 
		if(!isInteger(authCodeLifetime) || authCodeLifetime <0)
		{
			alert("You must specify a valid positive Integer for Authorization code expiration interval.");
			document.editform.authCodeLifetime.focus();
			return false;
		}

		var accessTokenLifetime = document.editform.accessTokenLifetime.value; 
		var validateAccessTokenLifetime=true;
			for (var j=0; j <document.editform.lifeTime.length; j++){
   		   		if (document.editform.lifeTime[j].checked){
           			if(document.editform.lifeTime[j].value!='0'){
           				validateAccessTokenLifetime=false;
           			}
     			}
   			}
   			
   		   			
		if(validateAccessTokenLifetime && (!isInteger(accessTokenLifetime) || accessTokenLifetime<0))
		{
			
   			alert("You must specify a valid positive Integer for Access token expiration interval.");
			document.editform.accessTokenLifetime.focus();
			return false;
			
		}
		
		if (document.editform.cbRequireHTTPS.checked) {
		   document.editform.requireHTTPS.value = "true";
		}
		else {
		   document.editform.requireHTTPS.value = "false";
		}
		
         if(!validateAccessTokenLifetime){
         	document.editform.accessTokenLifetime.disabled=false;
         	document.editform.accessTokenLifetime.value=-1;
         }
           		
		document.editform.submit();
		return true;
	}
	
	function enabledisableAccessTokenField(lifetimeaction){
 		if (lifetimeaction.value != 0){
  			document.forms['editform'].accessTokenLifetime.value="";
			document.forms['editform'].accessTokenLifetime.disabled = true;
		}else{
			document.forms['editform'].accessTokenLifetime.disabled = false;
		}
	}
	
  </script>
  
  <body onLoad="setNavigation('security-oauth-settings-edit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_OAuthEditScrn');">
   
    <table width="100%">
	<tr>
		<td class="menusection-Settings" colspan="2"> Security &gt; OAuth &gt; Edit OAuth Global Settings</td>
	</tr>

      <tr>
        <td colspan="2">
          <ul>
		    <li><a href="security-oauth-settings.dsp">Return to OAuth</a></li>
          </ul>
        </td>
      </tr>		

    <TR>
	    <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
	    
	    <TD>
	    
	   
	
		<FORM NAME="editform" ACTION="security-oauth-settings.dsp" METHOD="POST">
		 <TABLE class="tableView" width="50%">
	    		<script>swapRows();</script>
	    		<TR>
	    			<TD class="heading" colspan=3>Authorization Server Settings</TD>
	    		</TR>
	    
         
         	    	%invoke wm.server.oauth:getOAuthSettings%
         	    	<script>swapRows();</script>
	 	    	<TR>
	 	    		<script>writeTDWidth("row", "45%");</script>
	 	    			Require HTTPS
	 	    		</TD>
					<script>writeTD("row-l");</script>
					    <input type="checkbox" name="cbRequireHTTPS" id="cbRequireHTTPS" %ifvar requireHTTPS equals('true')%checked%endif% onChange="valueAltered()">
						<input type="hidden" name="requireHTTPS" value="%value requireHTTPS%">
					</TD>
	 	    	</TR>

				<script>swapRows();</script>
							
			<TR>
				<script>writeTDWidth("row", "40%");</script>Authorization code expiration interval</TD>
				<script>writeTD("row-l");</script>
					<input TYPE="hidden" NAME="isChanged" VALUE="false">
					<input NAME="authCodeLifetime" VALUE="%value authCodeLifetime%" onChange="valueAltered()"> seconds
				</TD>
			</TR>

			<script>swapRows();</script>
			<TR>
				<script>writeTDWidth("row", "40%");</script>Access token expiration interval</TD>
				<script>writeTD("row-l");</script>
					
					<INPUT type="radio" name="lifeTime" id="lifeTime" value="-1" %ifvar accessTokenLifetime equals('-1')% checked %endif% onclick="enabledisableAccessTokenField(this)" onChange="valueAltered()">Never Expires <BR/>
					
					<INPUT type="radio" name="lifeTime" id="lifeTime" value="0" %ifvar accessTokenLifetime equals('-1')% %else% checked %endif% onclick="enabledisableAccessTokenField(this)" onChange="valueAltered()">Expires in
					%ifvar accessTokenLifetime equals('-1')%
					<input NAME="accessTokenLifetime" VALUE="" onChange="valueAltered()" disabled=true> seconds
					%else%
					<input NAME="accessTokenLifetime" VALUE="%value accessTokenLifetime%" onChange="valueAltered()" > seconds
					%endif%
				</TD>
			</TR>

			<script>swapRows();</script>

			<TR>
				<TD class="heading" colspan=3>Resource Server Settings</TD>
			</TR>
			
			<tr>
				<script>writeTDWidth("row", "25%");</script><A HREF="settings-remote.dsp"><b>Authorization server</b></A></TD>
				
				<script>writeTD("row-l");</script>
			      <select name="remoteServerAlias" onchange="valueAltered()">

				%invoke wm.server.remote:serverList%

				%loop -struct servers%
					<option value="%value $key%" %ifvar $key vequals(../remoteServerAlias)% selected %endif%>
						%value $key%
					</option>
				%endloop%
				  
				  </select>
				</td>
			</tr>
			<script>swapRows();</script>		

			</TABLE>
			
		<table class="tableView" width="50%">
		<TR>
        	    <TD class="action" class="row" width="50%">
        	      <input TYPE="hidden" NAME="action" VALUE="edit">
        	      <input type="button" value="Save Changes" onclick="return confirmEdit()">
        	    </TD>
        	</TR>
        
        </table>
        </FORM>
	    
	</TR>
	  
	  
	 </table>
  </body> 	
</head>
