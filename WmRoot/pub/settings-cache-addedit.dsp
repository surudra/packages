  <html>
  <head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <meta http-equiv="Expires" content="-1">
    <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
    <script src="webMethods.js.txt"></script>
    <script language="JavaScript">
  	var gOldMaxEntLocalDiskVal = "0";
  	var gOldDiskExpThIntervalVal = "120";
  	var gOldDiskSpoolBufSizeVal = "30";
  	var gEvictionPolicyValSelIndex = 0;
  	var isBigMemoryLicenced = false;
      var isCacheManagerAlive = false;
  	var isBigMemOverflowtoOffheap = false;
  	var bigMemMaximumOffheap = "";
  	var agent = navigator.userAgent.toLowerCase();   
      var ie = (agent.indexOf("msie") != -1);
  	function validate(theForm)
  	{
  		var js_cacheName = theForm.cacheName;
  		if(!isValidString(js_cacheName, "'Cache Name'", true))
  		{
  			return false;
  		}
  		var js_maxElementsInMemory = theForm.maxElementsInMemory; 
  		if(!isValidInteger(js_maxElementsInMemory, "'Maximum Elements in Memory'", true, false))
  		{
  			return false;
  		}
  		
  		var js_timeToLiveSeconds = theForm.timeToLiveSeconds;
  		if(!isValidInteger(js_timeToLiveSeconds, "'Time to Live'", false, false))
  		{
  			return false;
  		}
  		
  		
  		var js_timeToIdleSeconds = theForm.timeToIdleSeconds;
  		if(!isValidInteger(js_timeToIdleSeconds,"'Time to Idle'" , false,false))
  		{
  			return false;
  		}
  		var js_maxEntriesLocalDisk = theForm.maxEntriesLocalDisk;
  		if(!isValidInteger(js_maxEntriesLocalDisk,"'Maximum Entries Local Disk'" , false ,false))
  		{
  			return false;
  		}
  		
  		var js_diskExpiryThreadIntervalSeconds = theForm.diskExpiryThreadIntervalSeconds;
  		if(!isValidInteger(js_diskExpiryThreadIntervalSeconds,"'Disk Expiry Thread Intreval'" , false ,true))
  		{
  			return false;
  		}
  		
  		var js_diskSpoolBufferSizeMB = theForm.diskSpoolBufferSizeMB;  
  		if(!isValidInteger(js_diskSpoolBufferSizeMB,"'Disk Spool Buffer Size'" , false,true))
  		{
  			return false;
  		}
  		var js_maxMemoryOffHeapVal = theForm.maxMemoryOffHeap.value;
  		if(js_maxMemoryOffHeapVal.length != 0)
  		{
  			var pattern = /^([1-9])+(([0-9])*)+(m|M|g|G|t|T)$/;
  			if(!(pattern.test(js_maxMemoryOffHeapVal)))
  			{
  				alert("You must specify a valid value for the field : 'Maximum Off-heap'.");
  				theForm.maxMemoryOffHeap.focus();
  				return false;
  			}
  						
  		} 
  		else
  		{
              var _overflowToOffHeap = document.getElementById('overflowToOffHeap');
  			if(_overflowToOffHeap.checked && js_maxMemoryOffHeapVal.length == 0)
  			{
  				alert("You must specify a value for the field : 'Maximum Off-heap'.");
  				theForm.maxMemoryOffHeap.focus();
  				return false;
  			}
  		}
  	
  		var chkBox1 = document.getElementById('enabled');
  		if(chkBox1.checked)
  		{
  			var js_timeoutMillis = theForm.timeoutMillis; 
  			if(!isValidInteger(js_timeoutMillis,"'Timeout'" , false,false))
  			{
  				return false;
  			}
  		}	
  		var js_clustered1 = document.getElementById('clustered');
  		var js_diskPersistent1 = document.getElementById('diskPersistent');
  		var js_overflowToDisk1 = document.getElementById('overflowToDisk');
          if (js_clustered1.checked &&  (js_diskPersistent1.checked || js_overflowToDisk1.checked))
          {
              alert("When a cache is distributed, cannot select OverFlow to Disk or Persist to Disk.")
              return false;
          }
          if (js_diskPersistent1.checked && js_overflowToDisk1.checked)
          {
                  alert("Cannot select both OverFlow to Disk and Persist to Disk.")
                  return false;
          }
          
  		setValueForAllCheckBoxes();
  		return true;
  	}
  	function enableDisableFields(isTSAConfigured,isLicenced)
  	{
  		var bmmd_overflowToOffHeap = document.getElementById('overflowToOffHeap');
  		var bmmd_maxMemoryOffHeap = document.getElementById('maxMemoryOffHeap');
  		isBigMemOverflowtoOffheap=bmmd_overflowToOffHeap.checked;
  		bigMemMaximumOffheap = bmmd_maxMemoryOffHeap.value;
  		var js_clustered = document.getElementById('clustered');
  		var js_consistency = document.getElementById('consistency');
  		var js_synchronousWrites = document.getElementById('synchronousWrites');
  		var js_enabled = document.getElementById('enabled');
  		var js_timeoutMillis = document.getElementById('timeoutMillis');
  		var js_timeoutBehaviorType = document.getElementById('timeoutBehaviorType');
  		var js_immediateTimeout = document.getElementById('immediateTimeout');
  		if('true' == isTSAConfigured && 'true' == isLicenced)
  		{
  			if(!(js_clustered.checked))
  			{
  				js_consistency.disabled = true;
  				js_synchronousWrites.disabled = true;
  				js_timeoutBehaviorType.disabled = true;
  				js_immediateTimeout.disabled = true;
  				js_timeoutMillis.readOnly = true; 
  				js_timeoutMillis.style.color = '#808080';
  				js_enabled.checked = false;
  			}
  			else
  			{
  				js_enabled.checked = true;
  				if(!js_clustered.disabled && js_consistency.value == 'STRONG'){
  					js_synchronousWrites.disabled = false;
  				}else{
  					js_synchronousWrites.checked = false;
  					js_synchronousWrites.disabled = true;
  				}
  			}
  		}
  		else
  		{
  			js_clustered.disabled = true;
  			js_consistency.disabled = true;
  			js_synchronousWrites.disabled = true;
  			js_timeoutBehaviorType.disabled = true;
  			js_immediateTimeout.disabled = true;
  			js_timeoutMillis.readOnly = true;  js_timeoutMillis.style.color = '#808080';
  			js_enabled.checked = false;
  		}
  		showHideBigMemDiv();
  		enableDisableMaximumOffHeapField();
  			
  	}
  
      function disableFieldsIfCacheMgrRunning(cacheMgrRunning)
      {
          //alert('cacheMgrRunning = ' + cacheMgrRunning);
          if (cacheMgrRunning == 'true') {
              document.getElementById('overflowToOffHeap').disabled = true;
              document.getElementById('overflowToDisk').disabled = true;
              document.getElementById('diskPersistent').disabled = true;
              document.getElementById('diskExpiryThreadIntervalSeconds').disabled = true;
              document.getElementById('diskSpoolBufferSizeMB').disabled = true;            
              document.getElementById('memoryStoreEvictionPolicy').disabled = true;
              document.getElementById('clearOnFlush').disabled = true;
              document.getElementById('copyOnRead').disabled = true;
              document.getElementById('copyOnWrite').disabled = true;
              document.getElementById('statistics').disabled = true;
              document.getElementById('logging').disabled = true;
              document.getElementById('maxMemoryOffHeap').disabled = true;
              document.getElementById('clustered').disabled = true;
              document.getElementById('consistency').disabled = true;
              document.getElementById('enabled').disabled = true;
              document.getElementById('timeoutMillis').disabled = true;
              document.getElementById('timeoutBehaviorType').disabled = true;
              document.getElementById('immediateTimeout').disabled = true;
              document.getElementById('synchronousWrites').disabled = true;
          }
      }
  
  	function showHideBigMemDiv()
  	{
  		//alert('1');
  		var bmmd = document.getElementById('bigMemMsgDiv');
  		var bmmd_overflowToOffHeap = document.getElementById('overflowToOffHeap');
  		var bmmd_maxMemoryOffHeap = document.getElementById('maxMemoryOffHeap');
  		if(isCacheManagerAlive) {
              //alert('cacheMgr alive');
              bmmd.style.display = 'block';
              bmmd_overflowToOffHeap.disabled = true;
              bmmd_maxMemoryOffHeap.readOnly = true; 
              bmmd_maxMemoryOffHeap.style.color = '#808080'
          }
          else {
              if(!isBigMemoryLicenced)
              {
                  //alert('2');
                  bmmd.style.display = 'block';
                  bmmd_overflowToOffHeap.disabled = true;
                  bmmd_maxMemoryOffHeap.readOnly = true; 
                  bmmd_maxMemoryOffHeap.style.color = '#808080'
              }
              else
              {
                  //alert('3');
                  var js_clustered = document.getElementById('clustered');
                  if(!js_clustered.checked)
                  {
                      bmmd.style.display = 'none';
                      bmmd_overflowToOffHeap.disabled = false;
                      bmmd_overflowToOffHeap.checked = isBigMemOverflowtoOffheap;
                      if(bmmd_overflowToOffHeap.checked)
                      {
                          bmmd_maxMemoryOffHeap.readOnly = false; 
                          bmmd_maxMemoryOffHeap.style.color = '#000000';
                          bmmd_maxMemoryOffHeap.value = bigMemMaximumOffheap;
                      }
                              
                  }
                  else
                  {
                  //alert('5');
                      bmmd.style.display = 'block';
                      bmmd_overflowToOffHeap.disabled = true;
                      bmmd_maxMemoryOffHeap.readOnly = true; 
                      bmmd_maxMemoryOffHeap.style.color = '#808080';
                      isBigMemOverflowtoOffheap=bmmd_overflowToOffHeap.checked;
                      if(bmmd_overflowToOffHeap.checked)
                          bigMemMaximumOffheap = bmmd_maxMemoryOffHeap.value;
                      bmmd_overflowToOffHeap.checked = false;
                      bmmd_maxMemoryOffHeap.value = "";
                  }
              }
          }
      }
  	function enableDisableClstredFields(isInternal)
  	{
  		var js_clustered = document.getElementById('clustered');
  		var js_consistency = document.getElementById('consistency');
  		var js_maxEntriesInCache = document.getElementById('maxEntriesInCache');
  		var js_synchronousWrites = document.getElementById('synchronousWrites');
  		var js_enabled = document.getElementById('enabled');
  		var js_timeoutMillis = document.getElementById('timeoutMillis');
  		var js_timeoutBehaviorType = document.getElementById('timeoutBehaviorType');
  		var js_immediateTimeout = document.getElementById('immediateTimeout');
		
  		if(!js_clustered.checked)
  		{
  			js_consistency.disabled=true;
  			js_maxEntriesInCache.readOnly = true;
			js_maxEntriesInCache.style.color = '#808080';
			js_synchronousWrites.disabled = true;
  			js_timeoutBehaviorType.disabled = true;
  			js_immediateTimeout.disabled = true;
  			js_timeoutMillis.readOnly = true;
			js_timeoutMillis.style.color = '#808080';
  			js_enabled.checked = false;
  		}
  		else
  		{
  			js_consistency.disabled = false;
  			js_maxEntriesInCache.readOnly = false;
			js_maxEntriesInCache.style.color = '#000000';
  			js_synchronousWrites.disabled = false;
  			js_timeoutBehaviorType.disabled = false;
  			js_immediateTimeout.disabled = false;
  			js_timeoutMillis.readOnly = false;
			js_timeoutMillis.style.color = '#000000';
  			js_enabled.checked = true;
  		}
  		enDisSynchronusWrite();
  		showHideBigMemDiv();
  		parentEnableDisableDiskFields(isInternal,'true');
  	}
  	
  	function isValidInteger(aField, fieldName, isMandatoryField ,validateForZero)
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
  				if(!validateIntValue(aField , fieldName , fieldVal , validateForZero))
  				{
  					return false;
  				}
  			}
  		}		
  		else
  		{	
  			if(!validateIntValue(aField , fieldName , fieldVal , validateForZero))
  			{
  				return false;
  			}
  		}
  		return true;
  	}
  
  	function isValidString(aField ,fieldName , isMandatoryField)
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
  			var invlaidChars = '?[]/\\=+<>:;",*|^@';
  			for(var i=0;i<fieldVal.length; i++)
  			{
  				var ch = fieldVal.charAt(i);
  				if(-1 != invlaidChars.indexOf(ch))
  				{
  					alert('Cache name must not contain these characters: ?[]/\\=+<>:;",*|^@');
  					aField.focus();
  					return false;
  				}
  			}
  		}
  		return true;
  	}
  	function trimStr(str) {
  	  return str.replace(/^\s+|\s+$/g, '');
  	}
  	function checkMutexFields(field0 , field1 ,field2)	
  	{
  		var field1Obj = document.getElementById(field1);
  		var field2Obj = document.getElementById(field2);
  		var field0Obj = document.getElementById(field0);
  		
  		if(field2Obj.checked)
  		{
  			field1Obj.value = '';
  			field0Obj.value = '';
  			field1Obj.disabled = true;
  			field0Obj.disabled = true;
  		}
  		else
  		{
  			field1Obj.disabled = false;
  			field0Obj.disabled = false;
  		}
  		
  	}
  	
  	function setCacheManagerAlive(alive)
  	{
  		if(true == alive || 'true' == alive)
  			isCacheManagerAlive = true;
  		else
  			isCacheManagerAlive = false;
  	}
  	
  	function setBigMemoryLicence(licence)
  	{
  		if(true == licence || 'true' == licence)
  			isBigMemoryLicenced = true;
  		else
  			isBigMemoryLicenced = false;
  	}
  	function setValueForAllCheckBoxes()
  	{
  	    var node_list = document.getElementsByTagName('input');
   
  		for (var i = 0; i < node_list.length; i++) {
  			var node = node_list[i];
  		 
  			if (node.getAttribute('type') == 'checkbox') {
  				node.disabled = false;
  				node.value = node.checked;
  				
  			}
  		} 
  		node_list = document.getElementsByTagName('select');
  		for (var i = 0; i < node_list.length; i++) {
  			var node = node_list[i];
  			node.disabled = false;
  		}
  	}
  	
  	function validateIntValue(aField , fieldName , fieldVal , validateForZero)
  	{
  	   if(!isblank(fieldVal) && (!isInteger(fieldVal) || fieldVal.charAt(0) == '-' || fieldVal.charAt(0) == '+'))
  		{
  			alert("You must specify a valid positive Integer for the field : "+fieldName+".");
  			aField.focus();
  			return false;
  		}
  		else if(validateForZero && !isblank(fieldVal) && !isIntegerGreaterThan(fieldVal, 0))
  		{
  			alert("Specify a valid positive integer for the field : "+fieldName+", The valid values must be between 1 and 2147483647.");
  			aField.focus();
  			return false;
  		}
  		else if(!isblank(fieldVal) && !isIntegerLessThan(fieldVal ,2147483647))
  		{
  			if(validateForZero)
  				alert("Specify a valid positive integer for the field : "+fieldName+", The valid values must be between 1 and 2147483647.");
  			else
  				alert("Specify a valid positive integer for the field : "+fieldName+", The valid values must be between 0 and 2147483647.");
  			aField.focus();
  			return false;
  		}
  		return true;
  	}
  	function enDisSynchronusWrite()
  	{
  		var js_synchronousWrites = document.getElementById('synchronousWrites');
  		var consistencySel = document.getElementById('consistency');
  		var js_clustered = document.getElementById('clustered');
  		if(js_clustered.checked)
  		{
  			if(consistencySel.value == 'STRONG'){
  				js_synchronousWrites.disabled = false;
  			}else{
  				js_synchronousWrites.checked = false;
  				js_synchronousWrites.disabled = true;
  			}
  		}
  	}
  	var gjs_overflowToDisk = false;
  	var gjs_diskPersistent = false;
  	function parentEnableDisableDiskFields(isInternal,flag)
  	{
  		var js_clustered = document.getElementById('clustered');
  		var js_overflowToDisk = document.getElementById('overflowToDisk');
  		var js_diskPersistent = document.getElementById('diskPersistent');
  		
  		if(js_clustered.checked)
  		{
  			if(js_overflowToDisk.checked)
  				populateInitialValues();
  			gjs_overflowToDisk = js_overflowToDisk.checked;
  			gjs_diskPersistent = js_diskPersistent.checked;
  			js_overflowToDisk.checked = false;
  			js_diskPersistent.checked = false;
  			
  		}
  		else
  		{
  			js_overflowToDisk.checked = gjs_overflowToDisk;
  			js_diskPersistent.checked = gjs_diskPersistent;
  		}
  		enableDisableDiskFields(isInternal,flag);
  	}
  	
  	function populateInitialValues()
  	{
  		var js_diskExpiryThreadIntervalSeconds = document.getElementById('diskExpiryThreadIntervalSeconds');
  		var js_diskSpoolBufferSizeMB = document.getElementById('diskSpoolBufferSizeMB');
  		var js_maxEntriesLocalDisk = document.getElementById('maxEntriesLocalDisk');
  		gOldMaxEntLocalDiskVal = js_maxEntriesLocalDisk.value;
  		gOldDiskExpThIntervalVal = js_diskExpiryThreadIntervalSeconds.value;
  		gOldDiskSpoolBufSizeVal = js_diskSpoolBufferSizeMB.value;
  	}
  	function enableDisableDiskFields(isInternal , flag)
  	{
  		var js_clustered = document.getElementById('clustered');
  		var js_overflowToDisk = document.getElementById('overflowToDisk');
  		var js_diskPersistent = document.getElementById('diskPersistent');
  		var js_diskExpiryThreadIntervalSeconds = document.getElementById('diskExpiryThreadIntervalSeconds');
  		var js_diskSpoolBufferSizeMB = document.getElementById('diskSpoolBufferSizeMB');
  		var js_maxEntriesLocalDisk = document.getElementById('maxEntriesLocalDisk');
  		var js_memoryStoreEvictionPolicy = document.getElementById('memoryStoreEvictionPolicy');
  		if(!isInternal || 'false' == isInternal)
  		{
  			if(js_clustered.checked)
  			{
  				js_maxEntriesLocalDisk.readOnly = true;
  				js_maxEntriesLocalDisk.style.color = '#808080';
  				js_maxEntriesLocalDisk.value = gOldMaxEntLocalDiskVal;
  				js_overflowToDisk.disabled = true;
  				js_diskPersistent.disabled = true;
  				js_diskExpiryThreadIntervalSeconds.readOnly = true;
  				js_diskExpiryThreadIntervalSeconds.style.color = '#808080';
  				js_diskExpiryThreadIntervalSeconds.value = "120";
  				js_diskSpoolBufferSizeMB.readOnly = true;
  				js_diskSpoolBufferSizeMB.style.color = '#808080';
  				js_diskSpoolBufferSizeMB.value = "30";
  				deleteOption(js_memoryStoreEvictionPolicy);
  			}
  			else
  			{
  				addOption(js_memoryStoreEvictionPolicy);
  				js_overflowToDisk.disabled = false;
  				js_diskPersistent.disabled = false;
				js_maxEntriesLocalDisk.readOnly = false;
				js_maxEntriesLocalDisk.style.color = '#000000';
				js_maxEntriesLocalDisk.value = gOldMaxEntLocalDiskVal;
  				
  				if(js_overflowToDisk.checked)
  				{	
  					
  					js_diskPersistent.checked = false;
  					js_diskPersistent.disabled = true;
  					js_diskExpiryThreadIntervalSeconds.readOnly = false;
  					js_diskExpiryThreadIntervalSeconds.style.color = '#000000';
  					js_diskExpiryThreadIntervalSeconds.value = gOldDiskExpThIntervalVal;
  					js_diskSpoolBufferSizeMB.readOnly = false;
  					js_diskSpoolBufferSizeMB.style.color = '#000000';
  					js_diskSpoolBufferSizeMB.value = gOldDiskSpoolBufSizeVal;
  				}
  				else if (js_diskPersistent.checked)
  				{
  					js_maxEntriesLocalDisk.readOnly = false;
  					js_maxEntriesLocalDisk.style.color = '#000000';
  					js_maxEntriesLocalDisk.value = gOldMaxEntLocalDiskVal;
  					js_overflowToDisk.checked = false;
  					js_overflowToDisk.disabled = true;
  				}
  				else
  				{
  					js_maxEntriesLocalDisk.readOnly = true;
  					js_maxEntriesLocalDisk.style.color = '#808080';
  					if('true' != flag)
  					{
  						gOldMaxEntLocalDiskVal = js_maxEntriesLocalDisk.value;
  						gOldDiskExpThIntervalVal = js_diskExpiryThreadIntervalSeconds.value;
  						gOldDiskSpoolBufSizeVal = js_diskSpoolBufferSizeMB.value;
  					}
  					js_maxEntriesLocalDisk.value = "0";
  					js_diskExpiryThreadIntervalSeconds.readOnly = true;
  					js_diskExpiryThreadIntervalSeconds.style.color = '#808080';
  					js_diskExpiryThreadIntervalSeconds.value = "120";
  					js_diskSpoolBufferSizeMB.readOnly = true;
  					js_diskSpoolBufferSizeMB.style.color = '#808080';
  					js_diskSpoolBufferSizeMB.value = "30";
  				}
  			}
  		}	
  	}
  	
  	function deleteOption(theSel)
  	{ 
  	  var selLength = theSel.length;
  	  gEvictionPolicyValSelIndex = theSel.selectedIndex;
  	  if(selLength == 3)
  	  {
  		theSel.options[2] = null;
  	  }
  	}
  	
  	function addOption(theSel)
  	{
  		var selLength = theSel.length;
  		var newSelIndex = theSel.selectedIndex;
  		if(selLength == 2)
  		{
  			var newOpt = new Option("FIFO (First In First Out)", "FIFO");
  			theSel.options[selLength] = newOpt;
  		}
  		if(newSelIndex == 0)
  			theSel.options[gEvictionPolicyValSelIndex].selected = true;
  	}
  	function enableDisableMaximumOffHeapField()
  	{
  		var js_maxMemoryOffHeap = document.getElementById('maxMemoryOffHeap');
  		var js_overflowToOffHeap = document.getElementById('overflowToOffHeap');
  		if(js_overflowToOffHeap.checked)
  		{
  			if(js_overflowToOffHeap.disabled)
  			{
  				//do nothing
  			}
  			else if(!(js_maxMemoryOffHeap.readOnly == 'true' || js_maxMemoryOffHeap.readOnly == 'readonly' || js_maxMemoryOffHeap.readOnly == 'readOnly'))
  			{
  				js_maxMemoryOffHeap.readOnly = false;
  				js_maxMemoryOffHeap.style.color = '#000000';
  				js_maxMemoryOffHeap.value = bigMemMaximumOffheap;
  			}
  		}
  		else
  		{
  			bigMemMaximumOffheap = js_maxMemoryOffHeap.value;
  			js_maxMemoryOffHeap.value = "";
  			js_maxMemoryOffHeap.readOnly = true;
  			js_maxMemoryOffHeap.style.color = '#808080';
  		}
  	}
  	
    </script>
    	
    %ifvar operation equals('edit')%
  	<body onLoad="setNavigation('settings-cache-addedit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Cache_Edit');">
    %else%
  	<body onLoad="setNavigation('settings-cache-addedit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Cache_Add');">
    %endif%
    
      <table width="100%">
  		<tr>
  			<td class="menusection-Settings" colspan="2"> 
  				Settings &gt; Caching &gt; %value cacheManagerName% &gt; %ifvar cacheName%%value cacheName% &gt; Edit%else%Add Cache%endif%
  			</td>
  		</tr>
  		%ifvar sync_operation%
  			%invoke wm.server.ehcache.admin:syncCacheConfigToTSA%
  				%ifvar message%
  					<tr><td colspan="2">&nbsp;</td></tr>
  					<tr><td class="message" colspan="2">%value message%</td></tr>
  				%endif%
  				%onerror%
  					<tr><td colspan="2">&nbsp;</td></tr>
  					<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
  			%endinvoke%
  		%endif%
  		%ifvar message%
  			%rename message oldMessage%
  		%endifvar%
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
  		%invoke wm.server.ehcache.admin:getLicenseDetails%
  
  		<tr>
  			<td colspan="2">
  				<ul>
  					<li><a href="settings-cache-manager-view.dsp?managerType=%value -urlencode managerType%&cacheManagerName=%value -urlencode cacheManagerName%">Return to&nbsp;%value cacheManagerName%</a></li>
  					%ifvar configMismatch%
  						<li><a href="settings-cache-diff.dsp?cacheManagerName=%value -urlencode cacheManagerName%&cacheName=%value -urlencode cacheName%">Synchronize Cache Settings from Terracotta Server Array</a></li>
  					%endif%
  				</ul>
  			</td>
  		</tr>
  		<tr>
  			<td>
  				<form name="htmlform_cacheConfig" action="settings-cache-manager-view.dsp" method="POST">
  				<input type="hidden" name="cacheManagerName" value="%value cacheManagerName%">
  				<input type="hidden" name="operation" value="%value operation%">
  				<input type="hidden" name="tempBool" value="false">
  				<table width="100%">
  					<tr>
  						<td width="10px">
  							<img src="images/blank.gif"  border=0>
  						</td>
  						<td valign="top" width="50%">	
  							<table class="tableForm" width="100%">
  								<tr>
  									<td class="heading" colspan="2">Cache Configuration</td>
  								</tr>
  
  								<tr>
  									<td class="oddrow" width="50%" >Cache Name</td>
  									<td class="oddrow-l" width="50%">
  										%ifvar operation equals('add')%
  											<input type="text" name="cacheName" id="cacheName">
  										%endif%	
  										%ifvar operation equals('edit')%
  											<input type="text" name="cacheName" id="cacheName" value="%value cacheName%" readonly="true" style="color:#808080;">
  										%endif%
  									</td>
  								</tr>
  								<tr>
  									<td class="evenrow">Maximum Elements in Memory</td>	
  									<td class="evenrow-l">
  										%ifvar operation equals('add')%
  											<input type="text" name="maxElementsInMemory" id="maxElementsInMemory">
  										%endif%	
  										%ifvar operation equals('edit')%
  											<input type="text" name="maxElementsInMemory" id="maxElementsInMemory" value="%value maxElementsInMemory%">
  										%endif%
  									</td>
  								</tr>
  								<tr>
  									<td class="oddrow">Eternal</td>	
  									<td class="oddrow-l">
  										<input type="checkbox" name="eternal" id="eternal" %ifvar eternal equals('true')%checked%endif% onclick="checkMutexFields('timeToIdleSeconds','timeToLiveSeconds','eternal');">
  									</td>
  								</tr>
  								<tr>
  									<td class="evenrow">Time to Live</td>	
  									<td class="evenrow-l">
  										%ifvar operation equals('add')%
  											<input type="text" name="timeToLiveSeconds" id="timeToLiveSeconds" value="0">
  										%endif%	
  										%ifvar operation equals('edit')%
  											<input type="text" name="timeToLiveSeconds" id="timeToLiveSeconds" value="%value timeToLiveSeconds%">
  										%endif%
  										seconds
  									</td>
  								</tr>
  								<tr>
  									<td class="oddrow" width="50%">Time to Idle</td>	
  									<td class="oddrow-l" width="50%">
  										%ifvar operation equals('add')%
  											<input type="text" name="timeToIdleSeconds" id="timeToIdleSeconds" value="0">
  										%endif%	
  										%ifvar operation equals('edit')%
  											<input type="text" name="timeToIdleSeconds" id="timeToIdleSeconds" value="%value timeToIdleSeconds%">
  										%endif%
  										seconds
  									</td>
  								</tr>
  								<script>checkMutexFields('timeToIdleSeconds','timeToLiveSeconds','eternal');</script>
  								<tr>
  									<td class="evenrow">Overflow to Disk</td>	
  									<td class="evenrow-l">
  									%ifvar operation equals('add')%
  										<input type="checkbox" name="overflowToDisk" id="overflowToDisk" onclick="enableDisableDiskFields('%value isInternal%','false')">	
  									%endif%	
  									%ifvar operation equals('edit')%	
  										<input type="checkbox" name="overflowToDisk" id="overflowToDisk" onclick="enableDisableDiskFields('%value isInternal%','false')" %ifvar overflowToDisk equals('true')% checked %endif%  %ifvar isInternal equals('true')% %ifvar licenseDetails/isTSAConfigured equals('true')% %ifvar terracottaConfiguration/clustered equals('true')% disabled %else% %endif% %endif% %endif%> 
  									%endif%	
  									</td>
  								</tr>
  								<tr>
  									<td class="oddrow">Persist to Disk</td>	
  									<td class="oddrow-l">
  									%ifvar operation equals('add')%
  										<input type="checkbox" name="diskPersistent" id="diskPersistent" onclick="enableDisableDiskFields('%value isInternal%','false')">
  									%endif%	
  									%ifvar operation equals('edit')%	
  										<input type="checkbox" name="diskPersistent" id="diskPersistent" onclick="enableDisableDiskFields('%value isInternal%','false')" %ifvar diskPersistent equals('true')% checked %endif% %ifvar isInternal equals('true')% %ifvar licenseDetails/isTSAConfigured equals('true')% %ifvar terracottaConfiguration/clustered equals('true')% disabled %else% %endif% %endif% %endif%>
  									%endif%		
  									</td>
  								</tr>
  								<tr>
  									<td class="evenrow">Maximum Entries Local Disk</td>	
  									<td class="evenrow-l">
  										%ifvar operation equals('add')%
  											<input type="text" name="maxEntriesLocalDisk" id="maxEntriesLocalDisk" value="0">
  										%endif%	
  										%ifvar operation equals('edit')%
  											<input type="text" name="maxEntriesLocalDisk" id="maxEntriesLocalDisk" value="%value maxEntriesLocalDisk%">
  										%endif%
  									</td>
  								</tr>
  						
  								<tr>
  									<td class="heading" colspan="2">Cache Configuration Advanced Settings (Optional)</td>
  								</tr>
  								
  								<tr>
  									<td class="oddrow" width="50%">Disk Expiry Thread Interval</td>	
  									<td class="oddrow-l" width="50%">
  										%ifvar operation equals('add')%
  											<input type="text" name="diskExpiryThreadIntervalSeconds" id="diskExpiryThreadIntervalSeconds" value="120">
  										%endif%	
  										%ifvar operation equals('edit')%
  											<input type="text" name="diskExpiryThreadIntervalSeconds" id="diskExpiryThreadIntervalSeconds" value="%value diskExpiryThreadIntervalSeconds%" %ifvar isInternal equals('true')%readonly="true" style="color:#808080;"%endif%>
  										%endif%
  										seconds
  									</td>
  								</tr>
  								<tr>
  									<td class="evenrow">Disk Spool Buffer Size</td>	
  									<td class="evenrow-l">
  										%ifvar operation equals('add')%
  											<input type="text" name="diskSpoolBufferSizeMB" id="diskSpoolBufferSizeMB" value="30">
  										%endif%	
  										%ifvar operation equals('edit')%
  											<input type="text" name="diskSpoolBufferSizeMB" id="diskSpoolBufferSizeMB" value="%value diskSpoolBufferSizeMB%" %ifvar isInternal equals('true')%readonly="true" style="color:#808080;"%endif%>
  										%endif%
  										megabytes
  									</td>
  								</tr>
  								<tr>
  									<td class="oddrow">Clear on Flush</td>	
  									<td class="oddrow-l">
  									%ifvar operation equals('add')%	
  										<input type="checkbox" name="clearOnFlush" id="clearOnFlush" checked>
  									%endif%	
  									%ifvar operation equals('edit')%	
  										<input type="checkbox" name="clearOnFlush" id="clearOnFlush" %ifvar clearOnFlush equals('true')%checked%endif% %ifvar isInternal equals('true')%disabled="disabled"%endif%>
  									%endif%	
  									</td>
  								</tr>
  								<tr>
  									<td class="evenrow">Copy on Read</td>	
  									<td class="evenrow-l">
  									%ifvar operation equals('add')%
  										<input type="checkbox" name="copyOnRead" id="copyOnRead">
  									%endif%
  									%ifvar operation equals('edit')%
  										<input type="checkbox" name="copyOnRead" id="copyOnRead" %ifvar copyOnRead equals('true')%checked%endif% %ifvar isInternal equals('true')%disabled="disabled"%endif%>
  									%endif%					
  									</td>
  								</tr>
  								<tr>
  									<td class="oddrow">Copy on Write</td>	
  									<td class="oddrow-l">
  									%ifvar operation equals('add')%	
  										<input type="checkbox" name="copyOnWrite" id="copyOnWrite">
  									%endif%
  									%ifvar operation equals('edit')%
  										<input type="checkbox" name="copyOnWrite" id="copyOnWrite" %ifvar copyOnWrite equals('true')%checked%endif% %ifvar isInternal equals('true')%disabled="disabled"%endif%>
  									%endif%
  									</td>
  								</tr>
  								<tr>
  									<td class="evenrow">Memory Store Eviction Policy</td>	
  									<td class="evenrow-l">
  										%ifvar operation equals('add')%
  											 <select name="memoryStoreEvictionPolicy" id="memoryStoreEvictionPolicy">
  												<option value="LRU">LRU (Least Recently Used)</option>
  												<option value="LFU">LFU (Least Frequently Used)</option>
  												<option value="FIFO">FIFO (First In First Out)</option>
  											 </select>
  										%endif%	
  										%ifvar operation equals('edit')%
  										
  											 <select name="memoryStoreEvictionPolicy" id="memoryStoreEvictionPolicy" %ifvar isInternal equals('true')%disabled="disabled"%endif%>
  												<option %ifvar  memoryStoreEvictionPolicy equals('LRU')%selected %endif% value="LRU">LRU (Least Recently Used)</option>
  												<option %ifvar  memoryStoreEvictionPolicy equals('LFU')%selected %endif% value="LFU">LFU (Least Frequently Used)</option>
  												<option %ifvar  memoryStoreEvictionPolicy equals('FIFO')%selected %endif% value="FIFO">FIFO (First In First Out)</option>
  											 </select>
  										%endif%
  									</td>
  								</tr>
  								<tr>
  									<td class="oddrow">Logging</td>	
  									<td class="oddrow-l">
  									%ifvar operation equals('add')%	
  										<input type="checkbox" name="logging" id="logging">			
  									%endif%	
  									%ifvar operation equals('edit')%	
  										<input type="checkbox" name="logging" id="logging" %ifvar logging equals('true')%checked%endif%>	
  									%endif%
  									</td>
  								</tr>	
  								<script>populateInitialValues();</script>
  								<tr>
  									<td class="heading" colspan="2">BigMemory</td>
  								</tr>
  							
  								<tr>
  									<td class="evenrow" width="50%">Overflow to Off-heap</td>	
  									<td class="evenrow-l" width="50%">
  									%ifvar operation equals('add')%	
  										<input type="checkbox" name="overflowToOffHeap" id="overflowToOffHeap" onclick="enableDisableMaximumOffHeapField();" %ifvar licenseDetails/isTSAConfigured equals('true')%disabled="disabled"%else%%ifvar licenseDetails/isBigMemoryLicensed equals('false')%disabled="disabled"%endif%%endif%>
  									%endif%	
  									%ifvar operation equals('edit')%
  										<input type="checkbox" name="overflowToOffHeap" id="overflowToOffHeap" onclick="enableDisableMaximumOffHeapField();" %ifvar overflowToOffHeap equals('true')%checked%endif% %ifvar licenseDetails/isTSAConfigured equals('true')%disabled="disabled"%else%%ifvar licenseDetails/isBigMemoryLicensed equals('false')%disabled="disabled"%else%%ifvar isInternal equals('true')%%ifvar terracottaConfiguration/clustered equals('true')%disabled="disabled"%endif%%endif%%endif%%endif%>
  									%endif%	
  									</td>
  								</tr>
  								
  								<tr>
  									<td class="oddrow">Maximum Off-heap</td>	
  									<td class="oddrow-l">
  										%ifvar operation equals('add')%
  											<input type="text" name="maxMemoryOffHeap" id="maxMemoryOffHeap" 
                                                  %ifvar licenseDetails/isTSAConfigured equals('true')
                                                      %readonly="true" style="color:#808080;"
                                                  %else%
                                                      %ifvar licenseDetails/isBigMemoryLicensed equals('false')
                                                          %readonly="true" style="color:#808080;"
                                                      %endif%
                                                  %endif% >
  										%endif%	
  										%ifvar operation equals('edit')%
  										    <input type="text" name="maxMemoryOffHeap" id="maxMemoryOffHeap" value="%value maxMemoryOffHeap%" 
                                              %ifvar cacheManagerAlive equals('true')%
                                                  readonly="true" style="color:#808080;"  
                                              %else%
                                                  %ifvar licenseDetails/isTSAConfigured equals('true')%
                                                      readonly="true" style="color:#808080;"
                                                  %else%
                                                      %ifvar licenseDetails/isBigMemoryLicensed equals('false')%
                                                          readonly="true" style="color:#808080;"
                                                      %else%
                                                          %ifvar isInternal equals('true')%
                                                              %ifvar terracottaConfiguration/clustered equals('true')%
                                                                  readonly="true" style="color:#808080;"
                                                              %endif% 
                                                          %endif% 
                                                      %endif%
                                                  %endif%
                                              %endif%
                                              >
  										%endif%
  									<div>
  										<i>Format : <b>&lt;</b>Integer<b>&gt;&lt;</b>m|M|g|G|t|T<b>&gt;</b></i>
  									</div>	
  									</td>
  									
  								</tr>
  							</table>
  							
  							<div name="bigMemMsgDiv" id="bigMemMsgDiv">	
  								
  									%ifvar cacheManagerAlive equals('true')%
                                          <table class="tableForm" width="100%"><tr><td  class="oddrow-l" width="100%" colspan="2"><font color='#808080'><b>
                                                  Off-heap fields can be set when the cache manager has been shut down.</b></font></td></tr></table>
                                      %else%
                                          %ifvar licenseDetails/isBigMemoryLicensed equals('true')%
                                              %ifvar licenseDetails/isTSAConfigured equals('true')%
                                                  <table class="tableForm" width="100%"><tr><td class="oddrow-l" width="100%" colspan="2"><font color='#808080'><b>
                                                      BigMemory for distributed cache is configured on the Terracotta Server Array.
                                                  </b></font></td></tr></table>
                                              %endif%	
                                          %else%	
                                              <table class="tableForm" width="100%"><tr><td  class="oddrow-l" width="100%" colspan="2"><font color='#808080'><b>
                                                      BigMemory license required for configuration.</b></font></td></tr></table>
                                          %endif%
  									%endif%
  									
  							</div>						
  							<script>setCacheManagerAlive('%value encode(javascript) cacheManagerAlive%')</script>
  							<script>setBigMemoryLicence('%value encode(javascript) licenseDetails/isBigMemoryLicensed%')</script>
  								
  												
  						</td>
  						<td valign="top">
  							<table class="tableForm" width="100%" >
  								<tr>
  									<td class="heading" colspan="2">Distributed Cache Configuration</td>
  								</tr>
  							
  								<tr>
  									<td width="50%" class="oddrow">Distributed</td>	
  									<td width="50%"class="oddrow-l">
  									%ifvar operation equals('add')%
  										<input type="checkbox" name="clustered" id="clustered" onclick="enableDisableClstredFields('%value isInternal%');">
  									%endif%	
  									%ifvar operation equals('edit')%
  										<input type="checkbox" name="clustered" id="clustered" %ifvar terracottaConfiguration/clustered equals('true')%checked%endif% onclick="enableDisableClstredFields('%value isInternal%');">
  									%endif%
  									</td>
  								</tr>
  								<tr>
  									<td  width="50%" class="evenrow">Consistency</td>	
  									<td  width="50%" class="evenrow-l">
  										%ifvar operation equals('add')%
  											 <select name="consistency" id="consistency" onchange="enDisSynchronusWrite();">
  												<option value="STRONG" selected>strong</option>
  												<option value="EVENTUAL" >eventual</option>
  											 </select>
  										%endif%	
  										%ifvar operation equals('edit')%
  										
  											 <select name="consistency" id="consistency" onchange="enDisSynchronusWrite();">
  												<option value="STRONG" %ifvar  terracottaConfiguration/consistency equals('STRONG')%selected %endif%>strong</option>
  												<option value="EVENTUAL" %ifvar  terracottaConfiguration/consistency equals('EVENTUAL')%selected %endif%>eventual</option>
  											 </select>
  										%endif%
  									</td>
  								</tr>
  								<tr>
  									<td  width="50%" class="oddrow">Maximum Entries in Cache</td>	
  									<td  width="50%" class="oddrow-l">
  										%ifvar operation equals('add')%
  											 <input type="text" name="maxEntriesInCache" id="maxEntriesInCache" />
  										%endif%	
  										%ifvar operation equals('edit')%
  											 <input type="text" value="%value maxEntriesInCache%" name="maxEntriesInCache" id="maxEntriesInCache" />
  										%endif%
  									</td>
  								</tr>
  								<tr>
  									<td class="evenrow" width="50%">Enable High Availability</td>
  									<td class="evenrow-l">
  									%ifvar operation equals('add')%
  									<input type="checkbox" name="enabled" id="enabled" disabled="disabled">
  									%endif%	
  									%ifvar operation equals('edit')%
  										<input type="checkbox" name="enabled" id="enabled" %ifvar terracottaConfiguration/nonStopConfiguration/enabled equals('true')%checked%endif% disabled="disabled">
  									%endif%
  										
  									</td>
  								</tr>
  								<tr>
  									<td class="oddrow">Timeout</td>	
  									<td class="oddrow-l">
  										%ifvar operation equals('add')%
  											<input type="text" name="timeoutMillis" id="timeoutMillis" value="30000">
  										%endif%	
  										%ifvar operation equals('edit')%
  											<input type="text" name="timeoutMillis" id="timeoutMillis" value="%value terracottaConfiguration/nonStopConfiguration/timeoutMillis%">
  										%endif%
  										milliseconds
  									</td>
  								</tr>
  								<tr>
  									<td class="evenrow" width="50%">Timeout Behavior</td>	
  									<td class="evenrow-l" width="50%">
  										%ifvar operation equals('add')%
  											 <select name="timeoutBehaviorType" id="timeoutBehaviorType">
  												<option value="noop" >noop</option>
  												<option value="exception" selected>exception</option>
  												<option value="localReads" >localReads</option>
  											 </select>
  										%endif%	
  										%ifvar operation equals('edit')%
  										
  											 <select name="timeoutBehaviorType" id="timeoutBehaviorType" >
  												<option value="noop" %ifvar  terracottaConfiguration/nonStopConfiguration/timeoutBehaviorType equals('noop')%selected %endif%>noop</option>
  												<option value="exception" %ifvar  terracottaConfiguration/nonStopConfiguration/timeoutBehaviorType equals('exception')%selected %endif%>exception</option>
  												<option value="localReads" %ifvar  terracottaConfiguration/nonStopConfiguration/timeoutBehaviorType equals('localReads')%selected %endif%>localReads</option>
  											 </select>
  										%endif%
  									</td>
  								</tr>
  								<tr>
  									<td class="oddrow">Immediate Timeout When Disconnected</td>	
  									<td class="oddrow-l">
  									%ifvar operation equals('add')%
  										<input type="checkbox" name="immediateTimeout" id="immediateTimeout">
  									%endif%	
  									%ifvar operation equals('edit')%
  										<input type="checkbox" name="immediateTimeout" id="immediateTimeout" %ifvar terracottaConfiguration/nonStopConfiguration/immediateTimeout equals('true')%checked%endif% >
  									%endif%
  									</td>
  								</tr>
  								<tr>
  									<td class="evenrow">Synchronous Writes</td>	
  									<td class="evenrow-l">
  									%ifvar operation equals('add')%
  										<input type="checkbox" name="synchronousWrites" id="synchronousWrites">
  									%endif%	
  									%ifvar operation equals('edit')%
  										<input type="checkbox" name="synchronousWrites" id="synchronousWrites" %ifvar terracottaConfiguration/synchronousWrites equals('true')%checked%endif%>
  									%endif%
  										
  									</td>
  								</tr>
  								%ifvar licenseDetails/isDistributedCacheLicensed equals('false')%
  									<tr><td class="oddrow-l" colspan=2><font color='#808080'><b>Distributed license required for distributed cache configuration.</b></font></td></tr>
  								%else%
  									%ifvar licenseDetails/isTSAConfigured equals('false')%
  										<tr><td class="oddrow-l" colspan=2><font color='#808080'><b>Distributed cache can be created when the cache manager is configured to connect to Terracotta Server Array.</b></font></td></tr>
  									%endif%
  								%endif%	
  								
  							</table>
                %ifvar isInternal equals('true')%
                %else%   	
                  %include settings-cache-searchable.dsp%
                %endif%  
  						</td>
  						<script>enableDisableFields('%value encode(javascript) licenseDetails/isTSAConfigured%','%value encode(javascript) licenseDetails/isDistributedCacheLicensed%');</script>
  						<script>enableDisableDiskFields('%value encode(javascript) isInternal%','false');</script>
                          %ifvar operation equals('edit')%
                            <script>disableFieldsIfCacheMgrRunning('%value encode(javascript) cacheManagerAlive%');</script>
                          %endif%                        
  					%endinvoke%
  					</tr>
            <tr>
  						<td width="10px">
  							<img src="images/blank.gif"  border=0>
  						</td>
  						<td colspan="2" class="action">
  							<input type="submit" name="submit1" value="Save Changes" onclick="return validate(this.form);">
  						</td>
  					</tr>
  				</table>
  				</form>
  			</td>
  		</tr>
  		
      </table>
  	
    </body> 	
  </head>
