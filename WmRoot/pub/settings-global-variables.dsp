<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  <script src="webMethods.js.txt"></script>
  <script language="JavaScript">
	<!--add jscript here-->
	function populateForm(form , glNm ,oper)
	{
		if('edit' == oper)
			form.operation.value = "edit";
		if('delete' == oper)
		{
			if (!confirm ("OK to delete '"+glNm+"'?")) {
				return false;
			}
			form.operation.value = 'gl_del';	
		}
		form.key.value = glNm;
		return true
	}
	
  </script>
  
  <body onLoad="setNavigation('settings-global-variables.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_GlobalVariables');">
   
    <table width="100%">
		<tr>
			<td class="menusection-Settings" colspan="2"> Settings &gt; Global Variables </td>
		</tr>
		%ifvar operation equals('gl_add')%
			%invoke wm.server.globalvariables:addGlobalVariable%
				%ifvar message%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message%</td></tr>
				%endif%
				%onerror%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
			%endinvoke%
		%endif%	  
		%ifvar operation equals('gl_edit')%
			%invoke wm.server.globalvariables:editGlobalVariable%
				%ifvar message%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message%</td></tr>
				%endif%
				%onerror%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
			%endinvoke%
		%endif%	
		%ifvar operation equals('gl_del')%
			%invoke wm.server.globalvariables:removeGlobalVariable%
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
					<li><a href="settings-global-variables-addedit.dsp?operation=add">Add&nbsp;Global&nbsp;Variable</a></li>
				</ul>
			</td>
		</tr>
		<tr>
			<td>
				<table width="50%">
					<tr>
						<td width="10px">
							<img src="images/blank.gif"  border=0>
						</td>
						<td>	
							<table class="tableView" width="100%">
								<tr>
									<td class="heading" colspan="4">Global Variables</td>
								</tr>
								<tr>
									<td class="oddcol-l">Key</td>
									<td class="oddcol">Value</td>
									<td class="oddcol">Is Password?</td>
									<td class="oddcol">Delete</td>
								</tr>
								%invoke wm.server.globalvariables:listGlobalVariables%
									%loop globalVariables%
										<tr>
											<script>writeTD("row-l");</script>
												<a href="javascript:document.htmlform_gl_edit.submit();" onClick="return populateForm(document.htmlform_gl_edit,'%value key%','edit');">
												   %value key%
												</a>   
											</td>
											<script>writeTD("rowdata");</script>
												%ifvar isSecure equals('true')%
													******
												%else%
													%value value%
												%endif%
											</td>						
											<script>writeTD("rowdata");</script>
												%ifvar isSecure equals('true')%
													Yes
												%else%
													No
												%endif%
											</td>
											<script>writeTD("rowdata");</script>
												<a href="javascript:document.htmlform_gl_delete.submit();" onClick="return populateForm(document.htmlform_gl_delete,'%value key%','delete');">
													<img src="icons/delete.gif" border="no">
												</a> 	
											</td>
										</tr>
										<script>swapRows();</script>
									%endloop%
								%endinvoke%	
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
    </table>
	<form name="htmlform_gl_edit" action="settings-global-variables-addedit.dsp" method="POST">
		<input type="hidden" name="operation">
		<input type="hidden" name="key">
	</form>
	<form name="htmlform_gl_delete" action="settings-global-variables.dsp" method="POST">
		<input type="hidden" name="operation">
		<input type="hidden" name="key">
	</form>
  </body> 	
</head>
