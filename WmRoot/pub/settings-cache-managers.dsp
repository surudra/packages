<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  <script src="webMethods.js.txt"></script>
  <script language="JavaScript">
	<!--add jscript here-->
	function populateForm(form , mgrNm ,oper)
	{
	
	
		if('add' == oper)
			form.operation.value = oper;
		if('add' != oper)
			form.cacheManagerName.value = mgrNm;
		if('delete' == oper)
		{
			if (!confirm ("OK to delete '"+mgrNm+"'?")) {
				return false;
			}
			form.operation.value = 'cache_manager_delete';	
		}
		if('reload' == oper)
		{
			if (!confirm ("OK to reload '"+mgrNm+"'?")) {
				return false;
			}
			form.operation.value = 'cache_manager_reload';	
		}
		if('shutdown' == oper)
		{
			if (!confirm ("OK to shutdown '"+mgrNm+"'?")) {
				return false;
			}
			form.operation.value = 'cache_manager_shutdown';	
		}
		if('start' == oper)
		{
			if (!confirm ("OK to start '"+mgrNm+"'?")) {
				return false;
			}
			form.operation.value = 'cache_manager_start';	
		}
	}
	
  </script>
  
  <body onLoad="setNavigation('settings-cache-managers.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_CachingScrn');">
    <table width="100%">
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
									<td class="heading" colspan="1">System Cache Managers</td>
								</tr>
								<tr>
									<td class="oddcol-l">Name</td>
									
								</tr>
								%invoke wm.server.ehcache.admin:getCacheManagers%
								
								%loop systemCacheManagers%
									
									<tr>
										<script>writeTD("row-l");</script>
										
										
											<a href="javascript:document.htmlform_manager_view.submit();" onClick="return populateForm(document.htmlform_manager_view,'%value encode(htmlattr) cacheManagerName%','view','System');">
												%value cacheManagerName%
											</a>
										</td>	
									</tr>
									<script>swapRows();</script>
									%endloop%
							
							</table>
						</td>
					<!--End : loop -->
					</tr>
				</table>
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
									<td class="heading" colspan="4">Public Cache Managers</td>
								</tr>
								<tr>
									<td class="oddcol-l">Name</td>
									<td class="oddcol">Reload</td>
									<td class="oddcol">Start/Shutdown</td>
									<td class="oddcol">Delete</td>
								</tr>
															
								%loop publicCacheManagers%
									
									<tr>
										<script>writeTD("row-l");</script>
										
										
											<a href="javascript:document.htmlform_manager_view.submit();" onClick="return populateForm(document.htmlform_manager_view,'%value encode(htmlattr) cacheManagerName%','view');">
												%value cacheManagerName%
											</a>
										
										</td>
										<script>writeTD("rowdata");</script>
										<!-- need to update the link once code is added for deleting a asset form current list-->
										   <!--<a href="security-ports-editaccess.dsp?port=%value port encode(url)%&node=%value -urlencode%&Action=deleteNode&Page=Edit">-->
										  %ifvar status equals('STATUS_ALIVE')%
											  <a href="javascript:document.htmlform_manager_all.submit();" onClick="return populateForm(document.htmlform_manager_all,'%value encode(htmlattr) cacheManagerName%','reload');">
												<img src="icons/icon_reload.gif" border="no">
											  </a>
										  %else%
												<img src="icons/reload.gif" height=16 width=14 border="no">
										  %endif%
										   <!--</a>-->
										</td>						
										<script>writeTD("rowdata");</script>
											%ifvar status equals('STATUS_ALIVE')%
												<a href="javascript:document.htmlform_manager_all.submit();" onClick="return populateForm(document.htmlform_manager_all,'%value encode(htmlattr) cacheManagerName%','shutdown');">
													Shutdown
												</a>
											%else%
												<a href="javascript:document.htmlform_manager_all.submit();" onClick="return populateForm(document.htmlform_manager_all,'%value encode(htmlattr) cacheManagerName%','start');">
													Start
												</a>
											%endif%
											<!--</a>-->
										</td>
										<script>writeTD("rowdata");</script>
												
												   <a href="javascript:document.htmlform_manager_all.submit();" onClick="return populateForm(document.htmlform_manager_all,'%value encode(htmlattr) cacheManagerName%','delete');">
													<img src="icons/delete.gif" border="no">
												   </a>
												   <!--</a>-->
										</td>
									</tr>
									<script>swapRows();</script>
									%endloop%
							%endinvoke%		
							</table>
						</td>
					<!--End : loop -->
					</tr>
				</table>
			</td>
		</tr>
    </table>
	<form name="htmlform_manager_view" action="settings-cache-manager-view.dsp" method="POST">
		<input type="hidden" name="cacheManagerName">
		
	</form>
	<form name="htmlform_manager_add" action="settings-cache-manager-addedit.dsp" method="POST">
		<input type="hidden" name="operation">
		
	</form>
	<form name="htmlform_manager_all" action="settings-cache.dsp" method="POST">
		<input type="hidden" name="operation">
		<input type="hidden" name="cacheManagerName">
		
	</form>
  </body> 	
</head>
