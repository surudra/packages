<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  <script src="webMethods.js.txt"></script>
  <script language="JavaScript">

	function validate(thisform,oper)
	{
		if(oper == 'edit')
		{
			if(0 == thisform.value.value.length)
			{
				alert("You must specify a valid value for the field : 'Value'")
				thisform.value.focus();
				return false;
			} else if (255 < thisform.value.value.length) {
				alert("'Value' field cannot exceed 255 characters.")
				thisform.value.focus();
				return false;
			}
			thisform.operation.value= 'gl_edit';
		}
		else
		{
			var glKey = trimStr(thisform.key.value);
			thisform.key.value = glKey;
			if(0 == glKey.length)
			{
				alert("You must specify a valid value for the field : 'Key'")
				thisform.key.focus();
				return false;
			} else if(255 < glKey.length) {
				alert("'Key' field cannot exceed 255 characters.")
				thisform.key.focus();
				return false;
			}
			else
			{
				var invlaidChars = '~`!@#$%^&*()-+={}|[]\\:";\'<>?,/';
				for(var i=0;i<glKey.length; i++)
				{
					var ch = glKey.charAt(i);
					if(-1 != invlaidChars.indexOf(ch))
					{
						alert('Key must not contain these characters: ? ` ! @ # $ % ^ & * ( ) - + = { } | [ ] \\ : " ; \' < > ~ , /');
						thisform.key.focus();
						return false;
					}
				}
			}
			if(0 == thisform.value.value.length)
			{
				alert("You must specify a valid value for the field : 'Value'")
				thisform.value.focus();
				return false;
			} else if (255 < thisform.value.value.length) {
				alert("'Value' field cannot exceed 255 characters.")
				thisform.value.focus();
				return false;
			}
			thisform.operation.value= 'gl_add';
		}
		setValueForCheckBoxes();
		return true;
	}
	
	function trimStr(str) {
	  return str.replace(/^\s+|\s+$/g, '');
	}
	
	function setValueForCheckBoxes()
	{
	    var node_list = document.getElementsByTagName('input');
 
		for (var i = 0; i < node_list.length; i++) {
			var node = node_list[i];
		 
			if (node.getAttribute('type') == 'checkbox') {
				node.disabled = false;
				node.value = node.checked;
				
			}
		} 
	}
	
	function changeInputType(chkBox) {
		var oType = "text";
		if(chkBox.checked) {
			oType = "password";
		}
		var oldObject = document.getElementById("value");
		var newObject = document.createElement('input');
		newObject.type = oType;
		if(oldObject.size) newObject.size = oldObject.size;
		if(oldObject.value) newObject.value = oldObject.value;
		if(oldObject.name) newObject.name = oldObject.name;
		if(oldObject.id) newObject.id = oldObject.id;
		if(oldObject.className) newObject.className = oldObject.className;
		oldObject.parentNode.replaceChild(newObject,oldObject);
	  return newObject;
	}
  </script>
 
  %ifvar operation equals('edit')%
	<body onLoad="setNavigation('settings-global-variables-addedit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_GlobalVariables_Edit');">
  %else%
	<body onLoad="setNavigation('settings-global-variables-addedit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_GlobalVariables_Add');">
  %endif%
    <table width="100%">
		<tr>
			<td class="menusection-Settings" colspan="2"> 
				Settings &gt; Global Variables &gt; %ifvar operation equals('edit')%%value key%&nbsp;&gt;&nbsp;Edit%else%Add Global Variable%endif%
			</td>
		</tr>
		 
		%ifvar operation equals('edit')%
			%invoke wm.server.globalvariables:getGlobalVariableValue%
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
					<li><a href="settings-global-variables.dsp">Return to Global Variables</a></li>
				</ul>
			</td>
		</tr>
		<tr>
			<td>
			<form name="htmlform_glConfig" action="settings-global-variables.dsp" method="POST">
				<input type="hidden" name="operation">
			<table>
				<tr>
					<td width="10px">
						<img src="images/blank.gif"  border=0>
					</td>
					<td>	
						<table class="tableView" width="100%">
							<tr>
								<td class="heading" colspan="2">Global Variable</td>
							</tr>
							<tr>
								<td class="oddrow">Is Password?</td>	
								<td class="oddrow-l">
									%ifvar operation equals('add')%
										<input type="checkbox" name="isSecure" id="isSecure" onclick="changeInputType(this)" %ifvar isSecure equals('true')%checked%endif%>
									%endif%	
									%ifvar operation equals('edit')%
										<input type="checkbox" name="isSecure" id="isSecure" %ifvar isSecure equals('true')%checked%endif% disabled>
									%endif%
									
								</td>
							</tr>
							<tr>
								<td class="evenrow" >Key</td>
								<td class="evenrow-l" >
									%ifvar operation equals('add')%
										<input type="text" size="40" name="key" id="key">
									%endif%	
									%ifvar operation equals('edit')%
										<input type="text" size="40" name="key" id="key" value="%value key%" readonly="true" style="color:#808080;">
									%endif%
								</td>
							</tr>
							<tr>
								<td class="oddrow">Value</td>	
								<td class="oddrow-l">
									%ifvar operation equals('add')%
										<input type="text" size="40" name="value" id="value">
									%endif%	
									%ifvar operation equals('edit')%
										%ifvar isSecure equals('true')%
											<input type="password" autocomplete="off" size="40" name="value" id="value" />
										%else%
											<input type="text" size="40" name="value" id="value" value="%value value%">
										%endif%	
									%endif%
								</td>
							</tr>
		         			
									
							<tr>
								<td class="action" colspan=3>
									<input type="submit" name="submit" value="Save Changes" onclick="return validate(this.form,'%value -htmlcode operation%');">
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
