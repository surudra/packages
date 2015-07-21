<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  <script src="webMethods.js.txt"></script>
  <script language="JavaScript">

	function validate(thisform,oper) {
	
		var js_Alias = thisform.alias;
		if(!isValidString(js_Alias,"'Alias'" , true, true))
		{
			return false;
		}
		var js_UserName = thisform.userName; 
		if(!isValidString(js_UserName,"'User Name'" , true, false))
		{
			return false;
		}
		
		var sftpServerAliasSelectO = document.getElementById("sftpServerAlias");
		var sftpServerAliasSelectedIndex = sftpServerAliasSelectO.selectedIndex;
		if(0 == sftpServerAliasSelectedIndex) {
			alert("You must select a value for the field : 'SFTP Server Alias'.");
			sftpServerAliasSelectO.focus();
			return false;
		}
		var pass = document.htmlform_Config.authenticationType[0].checked;
		var pubKey = document.htmlform_Config.authenticationType[1].checked;
		
		if(pass) {
			var js_password = thisform.password; 
			var js_rePassword = thisform.rePassword;
			if(isblank(js_password.value)) {
				alert("You must specify a value for the field : 'Password'.");
				js_password.focus();
				return false;
			}
			if(isblank(js_rePassword.value)) {
				alert("You must specify a value for the field : 'Re-type Password'.");
				js_rePassword.focus();
				return false;
			}
			if(js_password.value != js_rePassword.value) {
				alert("Values for password and re-entered password do not match.");
				js_password.focus();
				return false;
			}
		}
		
		if(pubKey) {
			var js_passPhrase = thisform.passPhrase; 
			var js_rePassPhrase = thisform.rePassPhrase;
			var js_privateKeyFileLocation = thisform.privateKeyFileLocation;
			if(isblank(js_privateKeyFileLocation.value)) {
				alert("You must specify a value for the field : 'Private Key Location'.");
				js_privateKeyFileLocation.focus();
				return false;
			}
			if(isblank(js_privateKeyFileLocation.value) && isblank(js_passPhrase.value)) {
				return true;
			}
			if(js_passPhrase.value != js_rePassPhrase.value) {
				alert("Values for passPhrase and re-entered passPhrase do not match.");
				js_passPhrase.focus();
				return false;
			}
		}
		
		var js_maximumRetries = thisform.maximumRetries;
		
		if(!isValidInteger(js_maximumRetries,"'Maximum Retries'", false, true, 6))
		{
			return false;
		}
		
		var js_connectionTimeout = thisform.connectionTimeout;
		if(!isValidInteger(js_connectionTimeout,"'Connection Timeout'", false, false, 2147483647))
		{
			return false;
		}
		var js_sessionTimeout = thisform.sessionTimeout;
		if(!isValidInteger(js_sessionTimeout,"'Session Timeout'", false, false, 2147483647))
		{
			return false;
		}
		
		var selectO = document.getElementById("compression");
		var selectedIndex = selectO.selectedIndex;
		if(selectedIndex != 0) {
			var js_compressionLevel = thisform.compressionLevel;
			if(!isValidInteger(js_compressionLevel,"'Compression Level'", false, true, 9))
			{
				return false;
			}
		}
		var sep = "";
		var newOrderText = "";
		var prefExAlgo = thisform.preferredKeyExchangeAlgorithmSel;
		for (i = 0; i <= prefExAlgo.options.length-1; i++) {   
            newOrderText += "" + sep + prefExAlgo.options[i].value;
            sep = ",";
        }
		thisform.preferredKeyExchangeAlgorithm.value = newOrderText;
		return true;
	}
	
	function isValidString(aField ,fieldName , isMandatoryField , validateForInvalidChars)
	{
		var fieldVal = trimStr(aField.value);
		aField.value = fieldVal;
		if(isMandatoryField && isblank(fieldVal))
		{
			alert("You must specify a value for the field : "+fieldName+".");
			aField.focus();
			return false;
		}
		else
		{
			if(validateForInvalidChars) { 
				var invlaidChars = '~`!@#$%^&*()-+={}|[]\\:";\'<>? ,/';
				for(var i=0;i<fieldVal.length; i++)
				{
					var ch = fieldVal.charAt(i);
					if(-1 != invlaidChars.indexOf(ch))
					{
						alert(fieldName+' must not contain these characters: (blank space) ~ ` ! @ # $ % ^ & * ( ) - + = { } | [ ] \\ : " ; \' < > ? , /');
						aField.focus();
						return false;
					}
				}
			}
		}
		return true;
	}
	
	function isValidInteger(aField, fieldName, isMandatoryField ,validateForZero, upperLimit)
	{
		var fieldVal = trimStr(aField.value);
		aField.value = fieldVal;
		
		if(isMandatoryField)
		{	
			if(isblank(fieldVal))
			{	
				alert("You must specify a valid Integer for the field : "+fieldName+".");
				aField.focus();
				return false;
			}
			else
			{
				if(!validateIntValue(aField , fieldName , fieldVal , validateForZero, upperLimit))
				{
					return false;
				}
			}
		}		
		else
		{	
			if(!validateIntValue(aField , fieldName , fieldVal , validateForZero, upperLimit))
			{
				return false;
			}
		}
		return true;
	}
	
	function validateIntValue(aField , fieldName , fieldVal , validateForZero, upperLimit)
	{
	   if(!isblank(fieldVal) && (!isInteger(fieldVal) || fieldVal.charAt(0) == '-' || fieldVal.charAt(0) == '+'))
		{
			alert("You must specify a valid positive Integer for the field : "+fieldName+".");
			aField.focus();
			return false;
		}
		else if(validateForZero && !isblank(fieldVal) && !isIntegerGreaterThan(fieldVal, 0))
		{
			alert("Specify a valid positive integer for the field : "+fieldName+", The valid values must be between 1 and "+upperLimit+".");
			aField.focus();
			return false;
		}
		else if(!isblank(fieldVal) && !isIntegerLessThan(fieldVal ,upperLimit))
		{
			if(validateForZero)
				alert("Specify a valid positive integer for the field : "+fieldName+", The valid values must be between 1 and "+upperLimit+".");
			else
				alert("Specify a valid positive integer for the field : "+fieldName+", The valid values must be between 0 and "+upperLimit+".");
			aField.focus();
			return false;
		}
		return true;
	}
	
	function trimStr(str) {
	  return str.replace(/^\s+|\s+$/g, '');
	}
	
	function changeColumnProperties()
	{
		var elem = document.getElementById("othreSubtype");
		var authType = document.getElementById('authenticationType');
		var pass = document.htmlform_Config.authenticationType[0].checked;
		var pubKey = document.htmlform_Config.authenticationType[1].checked;
		var rows = elem.rows;
		var clz;
		var cols;
		if(pass==true || pass=="true") {
			document.getElementById('passwordDiv').style.display='block';
			document.getElementById('passPhraseDiv').style.display='none';
			clz = "even";
		} else {
			document.getElementById('passPhraseDiv').style.display='block';
			document.getElementById('passwordDiv').style.display='none';
			clz = "odd";
		}
		for(i = 0; i < rows.length; i++)
		{
			cols = rows[i].cells;
			cols[0].setAttribute((document.all ? 'className' : 'class'), clz+"row");
			cols[1].setAttribute((document.all ? 'className' : 'class'), clz+"row-l");
			clz = (clz == "even") ? "odd" : "even";
		}
		
	}
	
	function move(formO,selectO,to) {
	    var index = selectO.selectedIndex;
        var selectLength  = selectO.length - 1;
        if (index == -1) return false;
        if(to == +1 && index == selectLength) {
           return false;
        } else if(to == -1 && index == 0) {
           return false;
        }
        swap(index,index+to,formO,selectO);
        return true;
    }
    
    function swap(fIndex,sIndex,formO,selectO) {
        fText  = selectO.options[fIndex].text;
        fValue = selectO.options[fIndex].value;
        selectO.options[fIndex].text  = selectO.options[sIndex].text;
        selectO.options[fIndex].value = selectO.options[sIndex].value;  
        selectO.options[sIndex].text = fText;
        selectO.options[sIndex].value = fValue;
        selectO.options[sIndex].selected = true;    
    }
    
	function populateOptions(options1) {
	    var selectO = document.htmlform_Config.preferredKeyExchangeAlgorithmSel;
		var optionsArray = options1.split(',');
		var elOptNew = null;
		for(var i = 0; i < optionsArray.length; i++) {
		  elOptNew = new Option(optionsArray[i], optionsArray[i]);
		  try {
			selectO.options[i] = elOptNew; // standards compliant; doesn't work in IE
		  } catch(ex) {
		    selectO.options.add(elOptNew, i); // IE only
          }
		}
    }
	
	function setSelection(selectID , value) {
		var selectO = document.getElementById(selectID);
		for (var i = 0; i < selectO.options.length; i++) {   
           if(value == selectO.options[i].value) {
			 selectO.options[i].selected = true;    
		   }
        }
	}
	
	function enableDisableCompressionLevel() {
		var selectO = document.getElementById("compression");
		var compressionLvlTxt = document.getElementById("compressionLevel");
		var selectedIndex = selectO.selectedIndex;
		if(selectedIndex == 0) {
			compressionLvlTxt.readOnly = true; 
			compressionLvlTxt.style.color = '#808080';
		} else { 
			compressionLvlTxt.readOnly = false; 
			compressionLvlTxt.style.color = '#000000';
		}
	}
  </script>
 
  %ifvar operation equals('edit')%
	<body onLoad="setNavigation('settings-sftp-client-useralias-addedit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_SFTP_UserAliasSettings_Edit');">
  %else%
	<body onLoad="setNavigation('settings-sftp-client-useralias-addedit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_SFTP_UserAliasSettings_Create');">
  %endif%
    <table width="100%">
		<tr>
			<td class="menusection-Settings" colspan="2"> 
				Settings &gt; SFTP &gt; User Alias Settings &gt; %ifvar operation equals('edit')%%value alias%&nbsp;&gt;&nbsp;Edit%else%Create User Alias%endif%
			</td>
		</tr>
		 
		%ifvar operation equals('edit')%
			%invoke wm.server.sftpclient:getUserAlias%
				%ifvar message%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message%</td></tr>
				%endif%
				%onerror%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
			%endinvoke%
		%endif%	
		<tr>
			<td colspan="2">
				<ul>
					<li><a href="settings-sftp-client.dsp">Return to SFTP</a></li>
					<li><a href="settings-sftp-client-usersettings.dsp">Return to User Alias Settings</a></li>
				</ul>
			</td>
		</tr>
		<tr>
			<td>
			<form name="htmlform_Config" action="settings-sftp-client-usersettings.dsp" method="POST">
				<input type="hidden" name="operation" id="operation" value="%value operation%">
			<table>
				<tr>
					<td width="10px">
						<img src="images/blank.gif"  border=0>
					</td>
					<td>
					
						<table class="tableView" width="100%">
							<tr>
								<td class="heading" colspan="2">SFTP User Alias Properties</td>
							</tr>
							<tr>
								<td class="oddrow" width="30%">Alias</td>	
								<td class="oddrow-l" width="70%">
									%ifvar operation equals('add')%
										<input type="text" name="alias" id="alias" style="width:100%;">
									%endif%	
									%ifvar operation equals('edit')%
										<input type="text" name="alias" id="alias" style="width:100%;" value="%value alias%" readonly="true" style="color:#808080;">
									%endif%
									
								</td>
							</tr>
							<tr>
								<td class="evenrow" width="30%">User Name</td>
								<td class="evenrow-l" width="70%">
									%ifvar operation equals('add')%
										<input type="text" name="userName" id="userName" style="width:100%;">
									%endif%	
									%ifvar operation equals('edit')%
										<input type="text" name="userName" id="userName" style="width:100%;" value="%value userName%" readonly="true" style="color:#808080;">
									%endif%
								</td>
							</tr>
							<tr>
								<td class="oddrow" width="30%">Authentication Type</td>	
								<td class="oddrow-l" width="70%">
									
									<input type="radio" name="authenticationType" id="authenticationType" value="password" checked onclick="changeColumnProperties();"/> Password&nbsp;&nbsp;
									<input type="radio" name="authenticationType" id="authenticationType" value="publicKey" %ifvar authenticationType equals('publicKey')% checked %endif%  onclick="changeColumnProperties();"/> Public Key
								</td>
							</tr>
							</table>
							<div name="passwordDiv" id="passwordDiv" style="display:block;">
								<table class="tableForm" width="100%" >
									<tr>
										<td class="evenrow" width="30%">Password</td>
										<td class="evenrow-l" width="70%">
											<input type="password" name="password" id="password" autocomplete="off" style="width:100%;"/>
										</td>
									</tr>
									<tr>
										<td class="oddrow"width="30%">Re-type Password</td>
										<td class="oddrow-l" width="70%" >
											<input type="password" name="rePassword" id="rePassword" autocomplete="off" style="width:100%;"/>
										</td>
									</tr>
								</table>	
							</div>	
									         			
							<div name="passPhraseDiv" id="passPhraseDiv" style="display:block;">
								<table class="tableForm" width="100%" >
									<tr>
										<td class="evenrow" width="30%">Private Key Location</td>	
										<td class="evenrow-l" width="70%">
											%ifvar operation equals('add')%
												<input type="text" name="privateKeyFileLocation" id="privateKeyFileLocation" style="width:100%;">
											%endif%	
											%ifvar operation equals('edit')%
												%ifvar privateKeyFileLocation%
													<input type="text" name="privateKeyFileLocation" id="privateKeyFileLocation" style="width:100%;" value="%value privateKeyFileLocation%">	
												%else%
													<input type="text" name="privateKeyFileLocation" id="privateKeyFileLocation" style="width:100%;">	
												%endif%	
											%endif%
										</td>
									</tr>	
									<tr>
										<td class="oddrow" width="30%">PassPhrase</td>
										<td class="oddrow-l" width="70%">
											<input type="password" name="passPhrase" id="passPhrase" autocomplete="off" style="width:100%;"/>
										</td>
									</tr>
									<tr>
										<td class="evenrow" width="30%">Re-type PassPhrase</td>
										<td class="evenrow-l" width="70%">
											<input type="password" name="rePassPhrase" id="rePassPhrase" autocomplete="off" style="width:100%;"/>
										</td>
									</tr>
								</table>
							</div>
							
							<div name="othrePropsDiv" id="othrePropsDiv" style="display:block;">
								<input type="hidden" name="preferredKeyExchangeAlgorithm" id="preferredKeyExchangeAlgorithm">
								<table class="tableForm" width="100%" >
									<tbody id="othreSubtype">
										<tr>
											<td class="evenrow" width="30%">SFTP Server Alias</td>
											<td class="evenrow-l" width="70%">
												%ifvar operation equals('add')%
													
													<select name="sftpServerAlias" id="sftpServerAlias" style="width:100%;">
														<option value=""></option>
														%invoke wm.server.sftpclient:listServerAliases%
															%loop SFTPServerAliases%
																<option value="%value alias%">%value alias%</option>
															%endloop%	
														%endinvoke%	
													</select>
												%endif%	
												%ifvar operation equals('edit')%
													<select name="sftpServerAlias" id="sftpServerAlias" style="width:100%;">
														<option value=""></option>
														%invoke wm.server.sftpclient:listServerAliases%
															%loop SFTPServerAliases%
																<option value="%value alias%">%value alias%</option>
															%endloop%	
														%endinvoke%	
														
													</select>
													<script>setSelection('sftpServerAlias','%value sftpServerAlias%');</script>
												%endif%
											
											</td>
										</tr>
										</tbody>
								</table>
							</div>	
							<table width="100%">
										<tr>
											<td class="heading" colspan="2">SFTP User Alias Advanced Settings (Optional)</td>
										</tr>
										<tr>
											<td class="oddrow" width="30%">Preferred Key Exchange Algorithms</td>
											<td class="oddrow-l" width="70%">
												<table class="tableForm" width="100%">
													<tr>
														<td>
															%ifvar operation equals('add')%
																<select name="preferredKeyExchangeAlgorithmSel" id="preferredKeyExchangeAlgorithmSel" size="3">
																	%invoke wm.server.sftpclient:listKeyExchangeAlgorithms%
																		%loop keyExchangeAlgorithms%
																			<option value="%value%">%value%</option>
																		%endloop%	
																	%endinvoke%	
																</select>
															%endif%	
															%ifvar operation equals('edit')%
																<select name="preferredKeyExchangeAlgorithmSel" id="preferredKeyExchangeAlgorithmSel" size="3">
																		<option value=""></option>															
																</select>
																<script>populateOptions('%value preferredKeyExchangeAlgorithm%');</script>
															%endif%
														</td>
														<td align="left">
															<input type="button" style="width: 50px" value="Up" onClick="move(this.form,this.form.preferredKeyExchangeAlgorithmSel,-1)"><br>
															<input type="button" style="width: 50px" value="Down" onClick="move(this.form,this.form.preferredKeyExchangeAlgorithmSel,+1)">
														</td>		
													<tr>
												</table>	
											</td>
										</tr>
										<tr>
											<td class="evenrow" width="30%">Maximum Retries</td>	
											<td class="evenrow-l" width="70%">
												%ifvar operation equals('add')%
													<input type="text" name="maximumRetries" id="maximumRetries" value="6">
												%endif%	
												%ifvar operation equals('edit')%
													<input type="text" name="maximumRetries" id="maximumRetries" value="%value maximumRetries%">	
												%endif%
											</td>
										</tr>
										<tr>
											<td class="oddrow" width="30%">Connection Timeout</td>	
											<td class="oddrow-l" width="70%">
												%ifvar operation equals('add')%
													<input type="text"  name="connectionTimeout" id="connectionTimeout" value="0">
												%endif%	
												%ifvar operation equals('edit')%
													<input type="text"  name="connectionTimeout" id="connectionTimeout" value="%value connectionTimeout%">	
												%endif%
												seconds
											</td>
										</tr>	
										<tr>
											<td class="evenrow" width="30%">Session Timeout</td>	
											<td class="evenrow-l" width="70%">
												%ifvar operation equals('add')%
													<input type="text"  name="sessionTimeout" id="sessionTimeout" value="30">
												%endif%	
												%ifvar operation equals('edit')%
													<input type="text"  name="sessionTimeout" id="sessionTimeout" value="%value sessionTimeout%">	
												%endif%
												minutes
											</td>
										</tr>	
										<tr>
											<td class="oddrow" width="30%">Compression</td>	
											<td class="oddrow-l" width="70%">
												<select name="compression" id="compression" onchange="enableDisableCompressionLevel();">
													%invoke wm.server.sftpclient:listCompressionAlgorithms%
														%loop compressionAlgorithms%
															<option value="%value%">%value%</option>
														%endloop%	
													%endinvoke%	
												</select>
												%ifvar operation equals('edit')%
												    <script>setSelection('compression', '%value compression%');</script>
												%endif% 
											</td>
										</tr>	
										<tr>
											<td class="evenrow" width="30%">Compression Level</td>	
											<td class="evenrow-l" width="70%">
												%ifvar operation equals('add')%
													<input type="text" name="compressionLevel" id="compressionLevel" value="6">
												%endif%	
												%ifvar operation equals('edit')%
													<input type="text" name="compressionLevel" id="compressionLevel" value="%value compressionLevel%">	
												%endif%
											</td>
										</tr>		
										<script>enableDisableCompressionLevel();</script>	
										<tr>
											<td class="oddrow" width="30%">Proxy Alias</td>
											<td class="oddrow-l" width="70%">
												%ifvar operation equals('add')%
													<select name="proxyAlias" id="proxyAlias" >
														<option value="" ></option>
														%invoke wm.server.proxy:listHTTPAndHTTPSProxyAliasNames%
															%loop proxyAliases%
																<option value="%value%">%value%</option>
															%endloop%	
														%endinvoke%	
													</select>
												%endif%	
												%ifvar operation equals('edit')%
													<select name="proxyAlias" id="proxyAlias" >
														<option value=""></option>
														%invoke wm.server.proxy:listHTTPAndHTTPSProxyAliasNames%
															%loop proxyAliases%
																<option value="%value%">%value%</option>
															%endloop%	
														%endinvoke%	
														
													</select>
													<script>setSelection('proxyAlias','%value proxyAlias%');</script>
												%endif%
											
											</td>
										</tr>
									</tbody>
								</table>
							</div>	
							<script>changeColumnProperties();</script>
							<table class="tableForm" width="100%" >						
								<tr>
									<td class="action" colspan="8">
										<input type="submit" name="submit" value="Save Changes" onclick="return validate(this.form,'%value operation%');">
									</td>
								</tr>
							</table>
					</td>
				
				</tr>
			</form>
			</table>
			</td>
		</tr>
		
    </table>
	
  </body> 	
</head>
