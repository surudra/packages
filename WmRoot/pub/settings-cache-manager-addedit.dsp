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
			thisform.operation.value= 'cache_manager_edit';
		}
		else
		{
			var magrName = trimStr(thisform.cacheManagerName.value);
			thisform.cacheManagerName.value = magrName;
			if(0 == magrName.length)
			{
				alert("You must specify a valid value for the field : 'Name'")
				thisform.cacheManagerName.focus();
				return false;
			}
			else
			{
				var invlaidChars = '?[]/\\=+<>:;",*|^@';
				for(var i=0;i<magrName.length; i++)
				{
					var ch = magrName.charAt(i);
					if(-1 != invlaidChars.indexOf(ch))
					{
						alert('Cache Manager name must not contain these characters: ?[]/\\=+<>:;",*|^@');
						thisform.cacheManagerName.focus();
						return false;
					}
				}
			}
			thisform.operation.value= 'cache_manager_add';
		}
		if(thisform.rejoin.checked)
		{
			var urls = thisform.tsaURL.value;
			if(0 == urls.length)
			{
				alert("You must specify a valid value for the field : 'Terracotta Server Array URLs'")
				thisform.tsaURL.focus();
				return false;
			}
			thisform.rejoin.value = 'true';
		}
		else
		{
			thisform.rejoin.value = 'false';
		}
		thisform.rejoin.disabled = false;
		return true;
	}
	function enDisChkBox(txtArea)
	{
		var val = trimStr(txtArea.value);
		var chkBox = document.getElementById("rejoin");
		if(val.length > 0)
		{
			chkBox.checked = true;
		}
		else
		{
			chkBox.checked = false;
		}
	}
	function trimStr(str) {
	  return str.replace(/^\s+|\s+$/g, '');
	}
  </script>
  %ifvar operation equals('edit')%
	%invoke wm.server.ehcache.admin:getCacheManager%
	%endinvoke%
  %endif%
  %ifvar operation equals('edit')%
	<body onLoad="setNavigation('settings-cache-manager-addedit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_CacheManager_Edit');">
  %else%
	<body onLoad="setNavigation('settings-cache-manager-addedit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_CacheManager_Add');">
  %endif%
    <table width="100%">
		<tr>
			<td class="menusection-Settings" colspan="2"> 
				Settings &gt; Caching &gt; %ifvar operation equals('edit')%%value cacheManagerName%&nbsp;&gt;&nbsp;Edit%else%Add Cache Manager%endif%
			</td>
		</tr>
			
		<tr>
			<td colspan="2">
				<ul>
					<li><a href="settings-cache.dsp">Return to Caching</a></li>
				</ul>
			</td>
		</tr>
		<tr>
			<td>
			<form name="htmlform_chacheMgrConfig" action="settings-cache.dsp" method="POST">
			<input type="hidden" name="operation">
			
			<table>
				<tr>
					<td width="10px">
						<img src="images/blank.gif"  border=0>
					</td>
					<td>	
						<table class="tableView" width="100%">
							<tr>
								<td class="heading" colspan="2">Cache Manager Configuration</td>
							</tr>

							<tr>
								<td class="oddrow" >Name</td>
								<td class="oddrow-l" >
									%ifvar operation equals('add')%
										<input type="text" size="40" name="cacheManagerName" id="cacheManagerName">
									%endif%	
									%ifvar operation equals('edit')%
										<input type="hidden" name="oldCacheManagerName" id="oldCacheManagerName" value="%value cacheManagerName%"/>
										<input type="text" size="40" name="cacheManagerName" id="cacheManagerName" value="%value cacheManagerName%" readonly="true" style="color:#808080;">
									%endif%
								</td>
							</tr>
							%invoke wm.server.ehcache.admin:getLicenseDetails%
							<tr>
								<td class="evenrow">Terracotta Server Array URLs</td>	
								<td class="evenrow-l">
									%ifvar operation equals('add')%
										<textarea name="tsaURL" id="tsaURL" rows="5" cols="40" %ifvar licenseDetails/isDistributedCacheLicensed equals('false')%readonly="true" style="color:#808080;"%endif% onkeyup="enDisChkBox(this);" onchange="enDisChkBox(this);"></textarea>
									%endif%	
									%ifvar operation equals('edit')%
										%ifvar isInternal equals('false')%
											<textarea name="tsaURL" id="tsaURL" rows="5" cols="40" %ifvar licenseDetails/isDistributedCacheLicensed equals('false')%readonly="true" style="color:#808080;"%endif% onkeyup="enDisChkBox(this);" onchange="enDisChkBox(this);">%value tsaURL%</textarea>
										%else%
											<textarea name="tsaURL" id="tsaURL" rows="5" cols="40" %ifvar licenseDetails/isClusteringLicensed equals('false')%readonly="true" style="color:#808080;"%endif% onkeyup="enDisChkBox(this);" onchange="enDisChkBox(this);">%value tsaURL%</textarea>
										%endif%
									%endif%
									
								</td>
							</tr>
		          %ifvar operation equals('add')%
		          <tr>
			        		   <td class="evenrow"/>
					           <td class="evenrow-l" colspan=2>Use commas (,) to separate entries.</TD>
             </tr>
             %endif%
		          %ifvar operation equals('edit')%
		          <tr>
			        		   <td class="evenrow"/>
					           <td class="evenrow-l" colspan=2>Use commas (,) to separate entries.</TD>
             </tr>
             %endif%
							<tr>
								<td class="oddrow">Rejoin</td>	
								<td class="oddrow-l">
								
									<input type="checkbox" name="rejoin" id="rejoin" disabled="disabled" %ifvar rejoin equals('true')%checked%endif%>
								
								</td>
							</tr>
							%ifvar licenseDetails/isDistributedCacheLicensed equals('false')%
							<tr>
								<td class="evenrow" colspan="2"><font color="#808080"><b>Distributed Cache license is required for adding Terracotta Server Array URLs.</b></font></td>	
							</tr>
							%endif%
							%endinvoke%						
							<tr>
								<td class="action" colspan=3>
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
