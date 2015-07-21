<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  <script src="webMethods.js.txt"></script>
  <script language="JavaScript">
	var gVal1 = "";
	var gVal2 = "";
	function validate(form1)
	{
		return true;
	}
	function writeTableRow(text)
	{
		
		if(gVal1 != gVal2)
		{
			writeTD("childrowred");
			document.write("<center>");
			document.write(text);
			document.write("</center>");
		}
		else
		{
			writeTD("rowdata-l");
			document.write("<center>");
			document.write(text);
			document.write("</center>");
		}
		
	}
	function setValues(index , val)
	{
		if(0 == index)
		{
			gVal1 = val;
			//alert(gVal1);
		}
		else
		{
			gVal2 = val;
			//alert(gVal2);
		}
	}
	
  </script>
  <body onLoad="setNavigation('settings-cache-diff.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Cache_Add');">
  <table width="100%">
		<tr>
			<td class="menusection-Settings" colspan="2"> 
				Settings &gt; Caching &gt; %value cacheManagerName% &gt; %ifvar cacheName%%value cacheName% &gt; Synchronize
			</td>
		</tr>
		%ifvar cacheName%
			%invoke wm.server.ehcache.admin:getCache%
				%ifvar message%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message%</td></tr>
				%endif%
				%onerror%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
			%endinvoke%
		%endifvar% 
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td colspan="2">
				<ul>
					<li><a href="settings-cache-addedit.dsp?cacheManagerName=%value -urlencode cacheManagerName%&cacheName=%value -urlencode cacheName%&operation=edit">Return to&nbsp;%value cacheName%</a></li>
				</ul>
			</td>
		</tr>
		<tr>
			<td>
				<form name="htmlform_cacheConfig" action="settings-cache-addedit.dsp" method="POST">
				<input type="hidden" name="cacheManagerName" value="%value cacheManagerName%">
				<input type="hidden" name="cacheName" value="%value cacheName%">
				<input type="hidden" name="operation" value="edit">
				<input type="hidden" name="sync_operation" value="true">
				<table width="100%">
					<tr>
						<td width="10px">
							<img src="images/blank.gif"  border=0>
						</td>
						<td valign="top" width="50%">	
							<table class="tableForm" width="100%">
								<tr>
									<td class="heading" colspan="3">Cache Configuration</td>
								</tr>
								<tr>
									<td class="oddcol" width="50%">Name</td>
									<td class="oddcol" width="25%">Configuration On Disk</td>
									<td class="oddcol" width="25%">Configuration In Effect</td>
								</tr>
								%ifvar configMismatch/cacheName%
									<tr>
										%loop configMismatch/cacheName%
											<script>setValues('%value $index%','%value%')</script>
										%endloop%
										<script>writeTD("row");</script>Cache Name</td>
										%loop configMismatch/cacheName%
											<script>writeTableRow('%value%');</script></td>
										%endloop%
									</tr>
									<script>swapRows();</script>
								%endif%	
								
								%ifvar configMismatch/maxElementsInMemory%
									
									<tr>
										%loop configMismatch/maxElementsInMemory%
											<script>setValues('%value $index%','%value%')</script>
										%endloop%
										<script>writeTD("row");</script><center>Maximum Elements in Memory</center></td>
										%loop configMismatch/maxElementsInMemory%
											<script>writeTableRow('%value%');</script>
											</td>
										%endloop%
									</tr>	
									<script>swapRows();</script>
								%endif%	
								
								%ifvar configMismatch/eternal%
									<tr>
										%loop configMismatch/eternal%
											<script>setValues('%value $index%','%value%')</script>
										%endloop%
										<script>writeTD("row");</script><center>Eternal</center></td>
										%loop configMismatch/eternal%
											<script>writeTableRow('%value%');</script></td>
										%endloop%									
									</tr>
									<script>swapRows();</script>
								%endif%	
								
								%ifvar configMismatch/timeToLiveSeconds%
									<tr>
										%loop configMismatch/timeToLiveSeconds%
											<script>setValues('%value $index%','%value%')</script>
										%endloop%
										<script>writeTD("row");</script><center>Time to Live (seconds)</center></td>
										%loop configMismatch/timeToLiveSeconds%
											<script>writeTableRow('%value%');</script></td>
										%endloop%
									</tr>	
									<script>swapRows();</script>
								%endif%	
								
								%ifvar configMismatch/timeToIdleSeconds%
									<tr>
										%loop configMismatch/timeToIdleSeconds%
											<script>setValues('%value $index%','%value%')</script>
										%endloop%
										<script>writeTD("row");</script><center>Time to Idle (seconds)</center></td>
										%loop configMismatch/timeToIdleSeconds%
											<script>writeTableRow('%value%');</script></td>
										%endloop%	
									</tr>
									<script>swapRows();</script>
								%endif%	
								
								%ifvar configMismatch/overflowToDisk%
									<tr>
										%loop configMismatch/overflowToDisk%
											<script>setValues('%value $index%','%value%')</script>
										%endloop%
										<script>writeTD("row");</script><center>Overflow to Disk</center></td>
										%loop configMismatch/overflowToDisk%
												<script>writeTableRow('%value%');</script></td>
										%endloop%	
									</tr>
									<script>swapRows();</script>
								%endif%	
								
								%ifvar configMismatch/diskPersistent%
									<tr>
										%loop configMismatch/diskPersistent%
											<script>setValues('%value $index%','%value%')</script>
										%endloop%
										<script>writeTD("row");</script><center>Persist to Disk</center></td>	
										%loop configMismatch/diskPersistent%
												<script>writeTableRow('%value%');</script></td>
										%endloop%
									</tr>
									<script>swapRows();</script>
								%endif%	
								
								%ifvar configMismatch/maxElementsOnDisk%
									<tr>
										%loop configMismatch/maxElementsOnDisk%
											<script>setValues('%value $index%','%value%')</script>
										%endloop%
										<script>writeTD("row");</script><center>Maximum Elements on Disk</center></td>
										%loop configMismatch/maxElementsOnDisk%
												<script>writeTableRow('%value%');</script></td>
										%endloop%									
									</tr>
									<script>swapRows();</script>
								%endif%	
								
								%ifvar configMismatch/diskExpiryThreadIntervalSeconds%
									<tr>
										%loop configMismatch/diskExpiryThreadIntervalSeconds%
											<script>setValues('%value $index%','%value%')</script>
										%endloop%
										<script>writeTD("row");</script><center>Disk Expiry Thread Interval (seconds)</center></td>
										%loop configMismatch/diskExpiryThreadIntervalSeconds%
												<script>writeTableRow('%value%');</script></td>
										%endloop%
									</tr>
									<script>swapRows();</script>
								%endif%	
								
								%ifvar configMismatch/diskSpoolBufferSizeMB%
									<tr>
										%loop configMismatch/diskSpoolBufferSizeMB%
											<script>setValues('%value $index%','%value%')</script>
										%endloop%
										<script>writeTD("row");</script><center>Disk Spool Buffer Size (megabytes)</center></td>	
										%loop configMismatch/diskSpoolBufferSizeMB%
												<script>writeTableRow('%value%');</script></td>
										%endloop%
									</tr>
									<script>swapRows();</script>
								%endif%	
								
								%ifvar configMismatch/clearOnFlush%
									<tr>
										%loop configMismatch/clearOnFlush%
											<script>setValues('%value $index%','%value%')</script>
										%endloop%
										<script>writeTD("row");</script><center>Clear on Flush</center></td>
										%loop configMismatch/clearOnFlush%
												<script>writeTableRow('%value%');</script></td>
										%endloop%										
									</tr>
									<script>swapRows();</script>
								%endif%	
								
								%ifvar configMismatch/copyOnRead%
									<tr>
										%loop configMismatch/copyOnRead%
											<script>setValues('%value $index%','%value%')</script>
										%endloop%
										<script>writeTD("row");</script><center>Copy on Read</center></td>	
										%loop configMismatch/copyOnRead%
												<script>writeTableRow('%value%');</script></td>
										%endloop%	
									</tr>
									<script>swapRows();</script>
								%endif%	
								
								%ifvar configMismatch/copyOnWrite%
									<tr>
										%loop configMismatch/copyOnWrite%
											<script>setValues('%value $index%','%value%')</script>
										%endloop%
										<script>writeTD("row");</script><center>Copy on Write</center></td>
										%loop configMismatch/copyOnWrite%
											<script>writeTableRow('%value%');</script></td>
										%endloop%											
									</tr>
									<script>swapRows();</script>
								%endif%	
								
								%ifvar configMismatch/memoryStoreEvictionPolicy%
									<tr>
										%loop configMismatch/memoryStoreEvictionPolicy%
											<script>setValues('%value $index%','%value%')</script>
										%endloop%
										<script>writeTD("row");</script><center>Memory Store Eviction Policy</center></td>	
										%loop configMismatch/memoryStoreEvictionPolicy%
										<script>writeTableRow('%value%');</script></td>
										%endloop%	
									</tr>
									<script>swapRows();</script>
								%endif%	
								
								%ifvar configMismatch/statistics%
									<tr>
										%loop configMismatch/statistics%
											<script>setValues('%value $index%','%value%')</script>
										%endloop%
										<script>writeTD("row");</script><center>Statistics</center></td>
										%loop configMismatch/statistics%
											<script>writeTableRow('%value%');</script></td>
										%endloop%										
									</tr>
									<script>swapRows();</script>
								%endif%	
								
								%ifvar configMismatch/logging%
									<tr>
										%loop configMismatch/logging%
											<script>setValues('%value $index%','%value%')</script>
										%endloop%
										<script>writeTD("row");</script><center>Logging</center></td>
										%loop configMismatch/logging%
											<script>writeTableRow('%value%');</script></td>
										%endloop%									
									</tr>	
									<script>swapRows();</script>
								%endif%	
								
								<tr>
									<td class="heading" colspan="3">Big Memory</td>
								</tr>
								
								<tr>
									<td class="oddcol" width="50%">Name</td>
									<td class="oddcol" width="25%">Configuration On Disk</td>
									<td class="oddcol" width="25%">Configuration In Effect</td>
								</tr>
								<script>swapRows();</script>	
								%ifvar configMismatch/overflowToOffHeap%
									<tr>
										%loop configMismatch/overflowToOffHeap%
											<script>setValues('%value $index%','%value%')</script>
										%endloop%
										<script>writeTD("row");</script><center>Overflow To Off-heap</center></td>	
										%loop configMismatch/overflowToOffHeap%
											<script>writeTableRow('%value%');</script></td>
										%endloop%
									</tr>
									<script>swapRows();</script>
								%endif%	
								
								%ifvar configMismatch/maxMemoryOffHeap%
									<tr>
										%loop configMismatch/maxMemoryOffHeap%
											<script>setValues('%value $index%','%value%')</script>
										%endloop%
										<script>writeTD("row");</script><center>Maximum Off-heap</center></td>	
										%loop configMismatch/maxMemoryOffHeap%
											<script>writeTableRow('%value%');</script></td>
										%endloop%
									</tr>	
									<script>swapRows();</script>
								%endif%
								
							</table>			
						</td>
						<td valign="top">
							<table class="tableForm" width="100%" >
								<tr>
									<td class="heading" colspan="3">Distributed Cache Configuration</td>
								</tr>	
								<tr>
									<td class="oddcol" width="50%">Name</td>
									<td class="oddcol" width="25%">Configuration On Disk</td>
									<td class="oddcol" width="25%">Configuration In Effect</td>
								</tr>
															
								%ifvar configMismatch/clustered%								
									<tr>
										%loop configMismatch/clustered%
											<script>setValues('%value $index%','%value%')</script>
										%endloop%
										<script>writeTD("row");</script><center>Distributed</center></td>	
										%loop configMismatch/clustered%
												<script>writeTableRow('%value%');</script></td>
										%endloop%									
									</tr>
									<script>swapRows();</script>
								%endif%	
								
								%ifvar configMismatch/consistency%
									<tr>
										%loop configMismatch/consistency%
											<script>setValues('%value $index%','%value%')</script>
										%endloop%
										<script>writeTD("row");</script><center>Consistency</center></td>
										%loop configMismatch/consistency%
											<script>writeTableRow('%value%');</script></td>
										%endloop%
									</tr>
									<script>swapRows();</script>
								%endif%	
																	
								%ifvar configMismatch/enabled%
									<tr>
										%loop configMismatch/enabled%
											<script>setValues('%value $index%','%value%')</script>
										%endloop%
										<script>writeTD("row");</script><center>High Availability</center></td>
										%loop configMismatch/enabled%
											<script>writeTableRow('%value%');</script></td>
										%endloop%
									</tr>
									<script>swapRows();</script>
								%endif%	
								
								%ifvar configMismatch/timeoutMillis%
									<tr>
										%loop configMismatch/timeoutMillis%
											<script>setValues('%value $index%','%value%')</script>
										%endloop%
										<script>writeTD("row");</script><center>Timeout (milliseconds)</center></td>	
										%loop configMismatch/timeoutMillis%
											<script>writeTableRow('%value%');</script></td>
										%endloop%
									</tr>
									<script>swapRows();</script>
								%endif%	
								
								%ifvar configMismatch/timeoutBehaviorType%
									<tr>
										%loop configMismatch/timeoutBehaviorType%
											<script>setValues('%value $index%','%value%')</script>
										%endloop%
										<script>writeTD("row");</script><center>Timeout Behavior</center></td>	
										%loop configMismatch/timeoutBehaviorType%
											<script>writeTableRow('%value%');</script></td>
										%endloop%
									</tr>
									<script>swapRows();</script>
								%endif%	
								
								
								%ifvar configMismatch/immediateTimeout%
									<tr>
										%loop configMismatch/immediateTimeout%
											<script>setValues('%value $index%','%value%')</script>
										%endloop%
										<script>writeTD("row");</script><center>Immediate Timeout When Disconnected</center></td>
										%loop configMismatch/immediateTimeout%
											<script>writeTableRow('%value%');</script></td>
										%endloop%									
									</tr>
									<script>swapRows();</script>
								%endif%	
								
										
								%ifvar configMismatch/synchronousWrites%	
									<tr>
										%loop configMismatch/synchronousWrites%
											<script>setValues('%value $index%','%value%')</script>
										%endloop%
										<script>writeTD("row");</script><center>Synchronous Writes</center></td>	
										%loop configMismatch/synchronousWrites%
											<script>writeTableRow('%value%');</script></td>
										%endloop%
									</tr>
									<script>swapRows();</script>
								%endif%	
						</table>							
						</td>
					</tr>
					<tr>
						<td width="10px">
							<img src="images/blank.gif"  border=0>
						</td>
						<td colspan="2" class="action">
							<input type="submit" name="submit1" value="Synchronize" onclick="return validate(this.form);">
						</td>
					</tr>
				</table>
				</form>
				<td width="10px">
					<img src="images/blank.gif"  border=0>
				</td>
			</td>
		</tr>
		
    </table>
	
  </body> 	
</head>