<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  <script src="webMethods.js.txt"></script>
  <script language="JavaScript">
	
	function populateCacheManagerForm(form , mgr , oper)
	{
		form.operation.value = oper;
		
		if('edit' == oper)
		{
			form.cacheManagerName.value = mgr;
		}
		return true;
	}
	function populateCacheForm(form , mgr , cacheNm , oper)
	{
		form.operation.value = oper;
		form.cacheManagerName.value = mgr;
		
		if('edit' == oper || 'clear' == oper || 'delete' == oper || 'sync' == oper)
		{
			form.cacheName.value = cacheNm;
		}
		if('disable' == oper)
		{
			if (!confirm ("OK to disable '"+cacheNm+"'?")) {
				return false;
			}
		}
		
		if('clear' == oper)
		{
			if (!confirm ("OK to clear '"+cacheNm+"'?")) {
				return false;
			}
		}
		if('delete' == oper)
		{
			if (!confirm ("OK to delete '"+cacheNm+"'?")) {
				return false;
			}
		}
		if('enable' == oper)
		{
			if (!confirm ("OK to enable '"+cacheNm+"'?")) {
				return false;
			}
		}
		return true;
	}
	function enableDisableCache(form , mgr , cacheNm , oper,  enDis)
	{
		form.cacheName.value = cacheNm;
		if('true' == enDis)
		{
			oper = 'disable';
		}
		else
		{	
			oper = 'enable';
		}
		var boolVal = populateCacheForm(form , mgr , cacheNm , oper);
		return boolVal;
	}
  </script>
  
  <body onLoad="setNavigation('settings-cache-manager-view.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_CacheManager_Details');">
    <table width="100%">
		<tr>
			<td class="menusection-Settings" colspan="2"> Settings &gt; Caching &gt; %value cacheManagerName%</td>
		</tr>
		%ifvar operation equals('clear')%
			%invoke wm.server.ehcache.admin:clearCache%
				%ifvar message%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message%</td></tr>
				%endif%	
				%onerror%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage%</td></tr>	
			%endinvoke%
		%endif%
		%ifvar operation equals('enable')%
			%invoke wm.server.ehcache.admin:enableCache%
				%ifvar message%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message%</td></tr>
				%endif%
				%onerror%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage%</td></tr>	
			%endinvoke%
		%endif%
		%ifvar operation equals('disable')%
			%invoke wm.server.ehcache.admin:disableCache%
				%ifvar message%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message%</td></tr>
				%endif%
				%onerror%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
			%endinvoke%
		%endif%
		%ifvar operation equals('delete')%
			%invoke wm.server.ehcache.admin:deleteCache%
				%ifvar message%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message%</td></tr>
				%endif%
				%onerror%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
			%endinvoke%
		%endif%
		%ifvar operation equals('add')%
			%scope rparam(nonStopConfiguration={enabled='false'}) rparam(terracottaConfiguration={clustered='false'})%
				%scope nonStopConfiguration%
					%ifvar ../../enabled equals('true')% 
						%rename ../../enabled enabled -copy%
					%else%
						%rename ../../tempBool enabled -copy%
					%endif%	
					%ifvar ../../immediateTimeout equals('true')% 
						%rename ../../immediateTimeout immediateTimeout -copy%
					%else%
						%rename ../../tempBool immediateTimeout -copy%	
					%endif%	
					
					%rename ../../timeoutBehaviorType timeoutBehaviorType -copy%
					
					%rename ../../timeoutMillis timeoutMillis -copy%
				%endscope%
				%scope terracottaConfiguration%
					%ifvar ../../clustered equals('true')% 
						%rename ../../clustered clustered -copy%
					%else%
						%rename ../../tempBool clustered -copy%	
					%endif%	
					
					%ifvar ../../synchronousWrites equals('true')% 
						%rename ../../synchronousWrites synchronousWrites -copy%
					%else%
						%rename ../../tempBool synchronousWrites -copy%	
					%endif%	
					%rename ../../consistency consistency -copy%
					
					%rename ../nonStopConfiguration nonStopConfiguration -copy%
				%endscope%
				%invoke wm.server.ehcache.admin:addCache%
					%ifvar message%
						<tr><td colspan="2">&nbsp;</td></tr>
						<tr><td class="message" colspan="2">%value message%</td></tr>
					%endif%
					%onerror%
						<tr><td colspan="2">&nbsp;</td></tr>
						<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
				%endinvoke%
			%endscope%
		%endif%
		%ifvar operation equals('edit')%
			%scope rparam(nonStopConfiguration={enabled='false'}) rparam(terracottaConfiguration={clustered='false'})%
				%scope nonStopConfiguration%
					%ifvar ../../enabled equals('true')% 
						%rename ../../enabled enabled -copy%
					%else%
						%rename ../../tempBool enabled -copy%
					%endif%	
					%ifvar ../../immediateTimeout equals('true')% 
						%rename ../../immediateTimeout immediateTimeout -copy%
					%else%
						%rename ../../tempBool immediateTimeout -copy%	
					%endif%	
					
					%rename ../../timeoutBehaviorType timeoutBehaviorType -copy%
					
					%rename ../../timeoutMillis timeoutMillis -copy%
				%endscope%
				%scope terracottaConfiguration%
					%ifvar ../../clustered equals('true')% 
						%rename ../../clustered clustered -copy%
					%else%
						%rename ../../tempBool clustered -copy%	
					%endif%	
					
					%ifvar ../../synchronousWrites equals('true')% 
						%rename ../../synchronousWrites synchronousWrites -copy%
					%else%
						%rename ../../tempBool synchronousWrites -copy%	
					%endif%	
					%rename ../../consistency consistency -copy%
				
					%rename ../nonStopConfiguration nonStopConfiguration -copy%
				%endscope%
				%invoke wm.server.ehcache.admin:updateCache%
					%ifvar message%
						<tr><td colspan="2">&nbsp;</td></tr>
						<tr><td class="message" colspan="2">%value message%</td></tr>
					%endif%
					%onerror%
						<tr><td colspan="2">&nbsp;</td></tr>
						<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
				%endinvoke%
			%endscope%
		%endif%
		%ifvar message%
			%rename message oldMessage%
		%endifvar%
		%invoke wm.server.ehcache.admin:getCacheManager%
			%ifvar message%
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td class="message" colspan="2">%value message%</td></tr>
			%endif%
			%onerror%
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
		%endinvoke%

		<tr>
			<td colspan="2">
				<ul>
					<li><a href="settings-cache.dsp">Return to Caching</a></li>
					%ifvar isInternal equals('false')%
						<li><a href="javascript:document.htmlform_cache_add.submit();" onClick="return populateCacheForm(document.htmlform_cache_add,'%value cacheManagerName%','','add');">Add Cache</a></li>
						<li><a href="javascript:document.htmlform_manager_edit.submit();" onClick="return populateCacheManagerForm(document.htmlform_manager_edit,'%value cacheManagerName%','edit');">Edit Cache Manager Configuration</a></li>
					%endif%
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
							<table class="tableView">
							<tr>
								<td class="heading" colspan="2">Cache Manager Configuration</td>
							</tr>
							
							<tr>
								<td class="oddrow">Name</td>
								<td class="oddrowdata-l">
									%value cacheManagerName%
								</td>
							</tr>
							
							<tr>
								<td class="evenrow">Terracotta Server Array URLs</td>
								<td class="evenrowdata-l">
									%value tsaURL%
								</td>
							</tr>
							
							<tr>
								<td class="oddrow">Rejoin</td>	
								<td class="oddrowdata-l">
									%ifvar rejoin equals('true')%
										Yes
									%else%
										No
									%endif%	
								</td>
							</tr>

							<tr>
								<td class="evenrow">BigMemory Allocated</td>
								<td class="evenrowdata-l">
									%ifvar totalBigMemory -notempty% %value totalBigMemory% MB
									 %else% None
									 %endif%																
								</td>
							</tr>
							
							</table>
						</td>
						
					</tr>
				</table>
			</td>
		</tr>

		<tr>
			<td>
			<table width="75%">
				<tr>
					<td width="10px">
						<img src="images/blank.gif"  border=0>
					</td>
					<td>
						<table class="tableView" width="%ifvar isInternal equals('false')%50%%else%25%%endif%">
							<tr>
								<td class="heading" colspan="5">Cache List</td>
							</tr>

							<tr>
								<td class="oddcol-l">Cache Name</td>
								%ifvar isInternal equals('false')%
									<td class="oddcol">BigMemory</td>
									<td class="oddcol">Enabled</td>
									<td class="oddcol">Clear</td>
									<td class="oddcol">Delete</td>
								%endif%		
								
							</tr>
							%invoke wm.server.ehcache.admin:getCaches%
							%loop caches%
							
							<tr>
								<script>writeTD("row-l");</script>
									<a href="javascript:document.htmlform_cache_edit.submit();" onClick="return populateCacheForm(document.htmlform_cache_edit,'%value ../cacheManagerName%','%value cacheName%','edit');">
											%value cacheName%
									</a>
									
								</td>
								%ifvar isInternal equals('false')%
									<script>writeTD("rowdata");</script>
									
									 %ifvar maxMemoryOffHeap -notempty% %value maxMemoryOffHeap%
									 %else% None
									 %endif%
									 
									</td>
									<script>writeTD("rowdata");</script>
									 <a href="javascript:document.htmlform_cache_other.submit();" onClick="return enableDisableCache(document.htmlform_cache_other,'%value ../cacheManagerName%','%value cacheName%','ED','%value enabled%');">
										  %ifvar enabled equals('true')%
											Yes
										  %else%
											No
										  %endif% 	
									 </a>
									</td>
									<script>writeTD("rowdata");</script>
									
									  <a href="javascript:document.htmlform_cache_other.submit();" onClick="return populateCacheForm(document.htmlform_cache_other,'%value ../cacheManagerName%','%value cacheName%','clear');">
											<IMG SRC="images/clear_icon_16.png" border="0"
												height=16 width=16>
											
										</a>
										
									</td>
								
									<script>writeTD("rowdata");</script>
									<a href="javascript:document.htmlform_cache_other.submit();" onClick="return populateCacheForm(document.htmlform_cache_other,'%value ../cacheManagerName%','%value cacheName%','delete');">
										<img src="icons/delete.gif" border="no">
									 </a>
									
									</td>
									
								%endif%	
									
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
	<form name="htmlform_manager_edit" action="settings-cache-manager-addedit.dsp" method="POST">
		<input type="hidden" name="cacheManagerName">
		<input type="hidden" name="operation">
		
	</form>
	<form name="htmlform_cache_edit" action="settings-cache-addedit.dsp" method="POST">
		<input type="hidden" name="cacheManagerName">
		<input type="hidden" name="cacheName">
		<input type="hidden" name="operation">
		
	</form>
	<form name="htmlform_cache_add" action="settings-cache-addedit.dsp" method="POST">
		<input type="hidden" name="cacheManagerName">
		<input type="hidden" name="operation">
		
	</form>
	<form name="htmlform_cache_other" action="settings-cache-manager-view.dsp" method="POST">
		<input type="hidden" name="cacheManagerName">
		<input type="hidden" name="cacheName">
		<input type="hidden" name="operation">
		
	</form>
	<form name="htmlform_cache_sync" action="settings-cache-diff.dsp" method="POST">
		<input type="hidden" name="cacheManagerName">
		<input type="hidden" name="cacheName">
		<input type="hidden" name="operation">
		
	</form>
  </body> 	
</head>
