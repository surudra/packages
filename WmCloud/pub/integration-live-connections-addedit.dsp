
<HTML>
  <HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


    <LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
    <SCRIPT SRC="/WmRoot/webMethods.js.txt">
    </SCRIPT>
	
	<SCRIPT>

	function isValidURL(url){
     	return true;
	} 
	
	function validateRealmUrls(addConnectionform){
		var uriArray = addConnectionform.realmUrls.value.split(",");
		var illegalChars = '^#%"';
		
		for(var i = 0;i < uriArray.length;i++){
			
			if (!isblank(uriArray[i]) && !isValidURL(uriArray[i])){
				alert(uriArray[i]+" is not valid, must enter valid Realm URL");
				return false;
			}
			
			for (var j=0; j < illegalChars.length; j++)
            {
              if (uriArray[i].indexOf(illegalChars.charAt(j)) >= 0)
              {
                alert (uriArray[i] + " contains illegal character: '" + illegalChars.charAt(j) + "'.\n Must enter valid Realm URL");
                return false;
              }
            }
			
		}
		return true;
	}

	function validateData(){
	
		var addConnectionform = document.forms['addConnectionForm'];
		addConnectionform.localAction.value=addConnectionform.action.value;
		
		if(isblank(addConnectionform.aliasName.value)){
			alert("Must provide a value for Alias Name.");
			addConnectionform.aliasName.focus();
			return false;
		}
		
		if(isblank(addConnectionform.retry.value)){
			alert("Must provide a value for Maximum Reconnection Attempts.");
			addConnectionform.retry.focus();
			return false;
		}
		
		if ( !isInteger(addConnectionform.retry.value) ) {
			alert("You must specify a valid Integer value for Maximum Reconnection Attempts.");
			addConnectionform.retry.focus();
			return false;
		}
		
		return true;
	}
	
	function testConnection() {
	
		if ( validateData() ) {
			var addConnectionform = document.forms['addConnectionForm'];
			addConnectionform.localAction.value="test";
			return true;
		}
		else {
			return false;
		}
	}
	
    function added(message)
    {
        var newURL = encodeURI("integration-live.dsp?action=addFrom&message=" + message);
        location.href=newURL;
    }
	
    function addedFailed(message)
    {
        var newURL = encodeURI("integration-live.dsp?action=addFrom&errorMessage=" + message);
        location.href=newURL;
    }
	
    function updated(message)
    {
        var newURL = encodeURI("integration-live.dsp?action=addFrom&message="+message);
        location.href=newURL;
    }

    function updateFailed(message)
    {
        var newURL = encodeURI("integration-live.dsp?action=addFrom&errorMessage="+message);
        location.href=newURL;
    }
	
    </SCRIPT>
	
  </HEAD>
  %ifvar action equals('edit')%
	<BODY onLoad="setNavigation('integration-live-connections-addedit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_webMethodsCloud_EditAccountScrn');">
  %else%
	<BODY onLoad="setNavigation('integration-live-connections-addedit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_webMethodsCloud_CreateAccountScrn');">
  %endif%
  
<FORM NAME="addConnectionForm" method="POST">

	<input type="hidden" name="action" VALUE="%value action%">
	<input type="hidden" name="localAction" VALUE="">
	
  <TABLE WIDTH="100%">

%ifvar localAction%
%switch localAction%
%case 'test'%
  %invoke wm.client.integrationlive.connections:testUMConnection%
        %ifvar message%
          <TR><TD class="message" colspan="2">%value message%</TD></TR>
        %endif%
	%onerror%
		<tr><td class="message" colspan=3>%value errorMessage%</td></tr>
	%endinvoke%
%case 'add'%
  %invoke wm.client.integrationlive.connections:createUMConnection%
        %ifvar message%
			<SCRIPT>added("%value message%")</SCRIPT>
		 %endif%
	%onerror%
			<SCRIPT>addFailed("%value errorMessage%")</SCRIPT>
	%endinvoke%
%case 'edit'%
  %invoke wm.client.integrationlive.connections:updateUMConnection%
        %ifvar message%
			<SCRIPT>updated("%value message%")</SCRIPT>
		 %endif%
	%onerror%
			<SCRIPT>updateFailed("%value errorMessage%")</SCRIPT>
	%endinvoke%
%endswitch%
%endif% 
  
            <TR>
                <TD class="menusection-Settings" colspan="3">
                   webMethods Cloud &gt; Accounts &gt; 
					%ifvar action equals('edit')%
						Edit Account
					%else%
						Create Account
					%endif%
                </TD>
            </TR>

            <TR>
                <TD colspan="3">
                    <UL>
                        <LI><a href="integration-live.dsp">Return to On-premise Accounts</a></LI>
                    </UL>
                </TD>
            </TR>
            <TR>
           	 <TD width="2%">
			  &nbsp;
			</TD>
            <TD width="70%">
				%ifvar localAction%
				
				%else%
					%ifvar action equals('edit')%
						%invoke wm.client.integrationlive.connections:getUMConnection%
							%ifvar message%
								<tr><td colspan="3">&nbsp;</td></tr>
								<tr><td class="message" colspan="3">%value message%</td></tr>
							%endif%
							%onerror%
								<tr><td colspan="3">&nbsp;</td></tr>
								<tr><td class="message" colspan=3>%value errorMessage%</td></tr>
						%endinvoke%
					%endif%					
				%endif%	
				
            	<TABLE>
            		<TR>
            			<TD class="heading" colspan="2">General Settings</TD>
            		</TR>

					<TR>
						<TD class="oddrow" nowrap>Alias Name</TD>

						%ifvar action equals('edit')%
								<TD class="oddrow-l">
									<INPUT NAME="aliasName" id="aliasName" TYPE="TEXT" VALUE="%value aliasName%" SIZE="50" readonly="true" style="color:#808080;">
								 </TD>
						%else%
								<TD class="oddrow-l">
									<INPUT NAME="aliasName" id="aliasName" TYPE="TEXT" VALUE="%value aliasName%" SIZE="50">
								 </TD>							
						%endif%
					</TR>					

            		<TR>
            			<TD class="evenrow" nowrap>Description</TD>
            			<TD class="evenrow-l">
           			 		<INPUT NAME="description" id="description" TYPE="TEXT" VALUE="%value description%" SIZE="103">
            			 </TD>
            		</TR>

					<TR>
						<TD class="oddrow" nowrap>Stage</TD>

						<TD class="oddrow-l">
							  %invoke wm.client.integrationlive.connections:getStages%
							  %ifvar action equals('edit')%
							  	<input type="hidden" name="stage" VALUE="%value ../stage%">
								<select disabled>
							  %else%										
								<select name="stage">
							  %endif%
								
							  %loop stages%
									<option size="15" width=30% %ifvar ../stage vequals(stageKey)% selected %endif%value="%value stageKey%">%value stageDisplay%</option>
							  %endloop%
							  </select>
							  %endinvoke%
						 </TD>							
					</TR>					
					
            		<TR>
            			<TD class="heading" colspan="2">Account Settings</TD>
            		</TR>
					
            		<TR>
            			<TD class="evenrow" nowrap>Maximum Reconnection Attempts</TD>
            			<TD class="evenrow-l">
            				%ifvar action equals('edit')%
            			 		<INPUT NAME="retry" id="retry" TYPE="TEXT" VALUE="%value retry%">
            			 	%else%
								%ifvar localAction equals('test')%
									<INPUT NAME="retry" id="retry" TYPE="TEXT" VALUE="%value retry%">
								%else%
									<INPUT NAME="retry" id="retry"  TYPE="TEXT" VALUE="5">
								%endif%            			 		
            			 	%endif%
            			 </TD>
            		</TR>

					<TR>
            			<TD class="evenrow" nowrap>Time to Live</TD>
            			<TD class="evenrow-l">
            				%ifvar action equals('edit')%
            			 		<INPUT NAME="timeToLive" id="timeToLive" TYPE="TEXT" VALUE="%value timeToLive%">
            			 	%else%
								%ifvar localAction equals('test')%
									<INPUT NAME="timeToLive" id="timeToLive" TYPE="TEXT" VALUE="%value timeToLive%">
								%else%
									<INPUT NAME="timeToLive" id="timeToLive"  TYPE="TEXT" VALUE="0">
								%endif%            			 		
            			 	%endif%
            			 </TD>
            		</TR>

					<!--  RUN AS USER SUB -->
					<SCRIPT>
					  //This function can be changed to do something with the user
					  function callback(val){
						document.addConnectionForm.runAsUser.value=val;
					  }
					</SCRIPT>
					
					<TR>
						  <TD class="oddrow">Run As User</td>
						  <TD class="oddrow-l">
							<input name="runAsUser" id="runAsUser" size=20 value="%value runAsUser%"></input>
							<link rel="stylesheet" type="text/css" href="/WmRoot/subUserLookup.css" />
							<script type="text/javascript" src="/WmRoot/subUserLookup.js"></script>
							<a class="submodal" href="/WmRoot/subUserLookup.dsp"><img border=0 align="bottom" src="/WmRoot/icons/magnifyglass.gif"/></a>
						  </TD>
					</TR>
					<!-- END RUN AS USER SUB -->

					<input type="hidden" name="isEnabled" VALUE="%value isEnabled%">

					<TR>
						<TD colspan="3" class="action" >
							<INPUT type="submit" value="Test Account Settings" onClick="return testConnection();">
							<input type="submit" name="submit" value="Save Changes" onclick="return validateData();">
						</TD>
					</TR>
					
            	</TABLE>
            </TD>
            </TR>
    </TABLE>
</FORM>


    </BODY>
  </HTML>
