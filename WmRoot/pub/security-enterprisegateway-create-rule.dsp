<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv="'Content-Type'" content="'text/html;" charset="UTF-8'">
  <meta http-equiv="Expires" content="-1">
  <style>
	.deleteButton {
		background:url('icons/IS_Delete.png') no-repeat;
		width: 16px;
		height: 16px;
		cursor:hand;
		cursor:pointer;
		border: none;
	}
	
	.deleteDisableButton {
		background:url('icons/IS_Delete_disabled.png') no-repeat;
		width: 16px;
		height: 16px;
		border: none;
	}
	
	.addButton {
		background:url('icons/IS_Add.png') no-repeat;
		width: 16px;
		height: 16px;
		cursor:hand;
		cursor:pointer;
        border: none;
	}
	
	.addDisableButton {
		background:url('icons/IS_Add_disabled.png') no-repeat;
		width: 16px;
		height: 16px;
		border: none;
	}
  </style>
  <link rel="stylesheet" type="text/css" href="webMethods.css">
  <script src="webMethods.js.txt"></script>

  <script>
  
	  var allDeviceTypes = new Array();
	  var globalDeviceTypeIndex = 0;
	  
	  var allMobileApps = new Array();
	  var globalallMobileAppsIndex = 0;
	  var conditionTableDisabledButton = null;
	  var conditionTableDisabledButtonID = null;
	  var sqlParameterTableDisabledButton = null;
	  var sqlParameterTableDisabledButtonID = null;
	function validate(currentForm)
	{
		
		currentForm.ruleName.value = trim(currentForm.ruleName.value);
		if(isEmpty(currentForm.ruleName.value))
		{
			alert("Please enter a valid Rule Name");
			currentForm.ruleName.focus();
			return false;
		}
		
		if(currentForm.enableRule.checked) {
		currentForm.isRuleEnabled.value = "true";
		} else {
		currentForm.isRuleEnabled.value = "false";
		}
		
		if(currentForm.mobileApplicationProtection.checked) {
		currentForm.isMobileAppProtectionEnabled.value = "true";
		} else {
		currentForm.isMobileAppProtectionEnabled.value = "false";
		}
		//
		if(currentForm.oAuth.checked) {
		currentForm.isOAuthEnabled.value = "true";
		currentForm.isRequireOAuthCredentials.value = "true";
		} else {
		currentForm.isOAuthEnabled.value = "false";
		currentForm.isRequireOAuthCredentials.value = "false";
		}
				
		if(currentForm.messageSize.checked) {
			currentForm.isMessageSizeEnabled.value = "true";
		
			var maximumMessageSize = currentForm.maximumMessageSize.value;
			if( (isEmpty (maximumMessageSize) || isNaN(maximumMessageSize)) || parseInt(maximumMessageSize) < 1 || !isInteger(maximumMessageSize))
			{
				alert("Please enter valid number greater than 0 for Maximum Message size");
				currentForm.maximumMessageSize.focus();
				return false;
			}
		} else {
			currentForm.isMessageSizeEnabled.value = "false";
		}
		var tableObj = document.getElementById('conditionTable');
		var rowCount = tableObj.rows.length;
		//alert(rowCount);
		if(currentForm.mobileApplicationProtection.checked) {
			if(!validateMobAppData()) {
				return false;
			}
		}
		
		
		if(currentForm.sqlInjectionFilter.checked) {
			currentForm.isSQLInjectionFilterEnabled.value = "true";
		} else {
			currentForm.isSQLInjectionFilterEnabled.value = "false";
		}
		
		if(currentForm.databaseSpecificSql.checked) {
			currentForm.isDBSQLInjectionEnabled.value = "true";
		} else {
			currentForm.isDBSQLInjectionEnabled.value = "false";
		}
		
		if(currentForm.standardSql.checked) {
			currentForm.isStdSQLInjectionEnabled.value = "true";
		} else {
			currentForm.isStdSQLInjectionEnabled.value = "false";
		}
		
		processSQLInjectionFilterData();
		if(!validateSQLInjectionFilterData()) {
				return false;
			}
		
		if(currentForm.antiVirusScan.checked){
			currentForm.isAntiVirusScanEnabled.value = "true";
			if(!validateAntiVirusFilter()) {
				return false;
			}
		}
		else{
			currentForm.isAntiVirusScanEnabled.value = "false";
		}
		
		
		
		currentForm.noOfProperties.value  = rowCount-1;
		document.getElementById("fromUI").value = "true";
		return true;
	}
	
	function validateAntiVirusFilter(){
		
			// Validating ICAP Host
			var host = document.getElementById('icapHost').value;
			if(host ==null || isEmpty(host)){
				alert("Please enter a valid ICAP host name/IP.");
				document.getElementById('icapHost').focus();
				return false;
			}
			// Validating ICAP port
			var port = document.getElementById('icapPort').value;
			if(port ==null || isEmpty(port) || isNaN(port) || parseInt(port)<1 || parseInt(port)>65535){
				alert("Invalid ICAP Port " + port);
				document.getElementById('icapPort').focus();
				return false;
			}
			// Validating ICAP Service
			var icapServiceName = document.getElementById('icapService').value;
			if(icapServiceName ==null || isEmpty(icapServiceName) ){
				alert("Please enter a valid ICAP Service.");
				document.getElementById('icapService').focus();
				return false;
			}
			
		
		
		return true;
	}
	
	function validateMobAppData() {
		
		var node_list1 = document.getElementsByTagName('select');
		for (var i = 0; i < node_list1.length; i++) {
			var node1 = node_list1[i];
			var nm = node1.getAttribute('name');
			if(nm.indexOf("applicationName") != -1) {
				var selIndex = node1.selectedIndex;
				if(selIndex == -1) {
					alert("You must specify a value for the field : 'Mobile Application'.");
					node1.focus();
					return false;
				}
				var str = node1.options[node1.selectedIndex].text;
				if(str == null || isEmpty(str)) {
					alert("You must specify a value for the field : 'Mobile Application'.");
					node1.focus();
					return false;
				}
			}

			if(nm.indexOf("deviceType") != -1) {
				var selIndex = node1.selectedIndex;
				if(selIndex == -1) {
					alert("You must specify a value for the field : 'Device Type'.");
					node1.focus();
					return false;
				}
				var str = node1.options[node1.selectedIndex].text;
				if(str == null || isEmpty(str)) {
					alert("You must specify a value for the field : 'Device Type'.");
					node1.focus();
					return false;
				}
			}
			
		}
		
		var node_list = document.getElementsByTagName('input');
 
		for (var i = 0; i < node_list.length; i++) {
			var node = node_list[i];
		 
			if (node.getAttribute('type') == 'text') {
				var nm = node.getAttribute('name');
				if(nm.indexOf("applicationVersion") != -1) {
				
					var str = node.value; 
					var patt1= /(^(\d)+$)|(^(\d)+\.(\d)+$)|(^(\d)+\.(\d)+\.(\d)+$)|(^(\d)+\.(\d)+\.(\d)+\.(\d)+$)/g;
					if(null == str.match(patt1)) {
						alert("You must specify a valid value for field :'Mobile Application Version'.");
						node.focus();
						return false;
					}
				}
				
			}
		}
		
		return true;
	} 
	
	function processSQLInjectionFilterData(){
		//concatenate SQL parameters to a single string variable
		var node_list = document.getElementsByTagName('input');
		var sqlParameterString = "";
		for (var i = 0; i < node_list.length; i++) {
			var node = node_list[i];
		 
			if (node.getAttribute('type') == 'text') {
				var nm = node.getAttribute('name');
				
				if(nm.indexOf("sqlParameterName") != -1) {
					var str = node.value;
					if(str != null && !(isEmpty(str))){
						if(sqlParameterString == null || isEmpty(sqlParameterString)){
							sqlParameterString = str;
						}else{
							sqlParameterString = sqlParameterString + ","+str;
						}
					}	
				}
			}
				
		}
		document.getElementById('SQLInjectionParameters').value = sqlParameterString;
		
		var databases = document.getElementById('databasesForSQLFilter');
		for(var i=0;i<databases.options.length;i++){
			var databaseSelected = databases.options[i];
			if(databaseSelected.selected){
				document.getElementById('SQLInjectionDBList').value = databaseSelected.value;
				if(databaseSelected.value == "SQL Server"){
					document.getElementById('SQLInjectionDBList').value = "SQL_SERVER";
				}else if (databaseSelected.value == "MySQL"){
					document.getElementById('SQLInjectionDBList').value = "MYSQL";
				}else if (databaseSelected.value == "Oracle"){
					document.getElementById('SQLInjectionDBList').value = "ORACLE";
				}else if (databaseSelected.value == "None"){
					document.getElementById('SQLInjectionDBList').value = "NONE";
				}
			}
		}
	}
	function validateSQLInjectionFilterData(){
		var databaseSpecificSQLProt = document.getElementById('databaseSpecificSql').checked;
		var standardSQLProt = document.getElementById('standardSql').checked;
		var sqlInjectionFilter = document.getElementById('sqlInjectionFilter').checked;
		
		//if SQL filter is enabled , atleast one of db specific or standard filter must be selected
		if(sqlInjectionFilter && !databaseSpecificSQLProt && !standardSQLProt){
			alert("Select Database-Specific SQL Injection Protection or Standard SQL Injection Protection or both to enable SQL Injection Protection Filter");
			return false;
		}
		
		if(databaseSpecificSQLProt){
			if(document.getElementById('SQLInjectionDBList').value == "NONE"){
				alert("Select a valid database for the Database-Specific SQL Injection Protection");
				document.getElementById('databasesForSQLFilter').focus();
				return false;
			}
		}
		
		var node_list = document.getElementsByTagName('input');
 
		for (var i = 0; i < node_list.length; i++) {
			var node = node_list[i];
			if (node.getAttribute('type') == 'text') {
				var nm = node.getAttribute('name');
				if(nm.indexOf("sqlParameterName") != -1) {
					var str = node.value; 
					var patt1= /[^a-zA-Z0-9$_]/g;
					if(patt1.test(str)){
						alert("Specify a valid value for the field: 'Parameters'. You can use only $, _, and alphanumeric characters as part of the parameter name.");
						if(databaseSpecificSQLProt){
							node.focus();
						}
						return false;
					}
				}
				
			}
		}
		return true;
	}
	function toggleDBParameters(){
		var tableName = 'sqlParameterTable';
		var tableObj = document.getElementById(tableName);
		var tRows = tableObj.rows;
		var rowCount = tableObj.rows.length;
		var rowcntID = "row"+rowCount;
		
		var dbSpecificFilterEnabled = document.getElementById('databaseSpecificSql').checked;
		
		//if DB Specific filter is disabled -
		//disable dropdown , disable textboxes, then disable the add and delete buttons
		
		if(dbSpecificFilterEnabled){ 
			
			document.getElementById('databasesForSQLFilter').disabled=false;
			
			for(var index=1;index<rowCount;index++){
				var rowID = ""+tRows[index].id;
				
				if(document.getElementById('sqlParameterName'+rowID)){
					document.getElementById('sqlParameterName'+rowID).disabled=false;
				}
				if(document.getElementById('addElementsqlParameterTable'+rowID)){
					var addButtonToEnable = document.getElementById('addElementsqlParameterTable'+rowID);
					addButtonToEnable.setAttribute('class', "addButton");
					if(navigator.appName == "Microsoft Internet Explorer") {
						addButtonToEnable.onclick = function(){addParameterRow();};
					} else {
						addButtonToEnable.setAttribute('onclick', 'addParameterRow()');
					}
				}
				
				if(document.getElementById('deleteElementsqlParameterTable'+rowID)){
					
					var deleteButtonToEnable = document.getElementById('deleteElementsqlParameterTable'+rowID);
					
					deleteButtonToEnable.setAttribute('class', "deleteButton");
					if(navigator.appName == "Microsoft Internet Explorer") {
						deleteButtonToEnable.onclick = function(){deleteRow(tableName,rowID);};
					} else {
						deleteButtonToEnable.setAttribute('onclick', 'deleteRow(' +"'"+tableName+"','"+ rowID+ "'"+')');
					}
				}
			}
		}else{
			
			document.getElementById('databasesForSQLFilter').disabled=true;
			
			for(var index=1;index<rowCount;index++){
				var rowID = ""+tRows[index].id;
				
				if(document.getElementById('sqlParameterName'+rowID)){
					document.getElementById('sqlParameterName'+rowID).disabled=true;
				}
				
				if(document.getElementById('addElementsqlParameterTable'+rowID)){
					var addButtonToDisable = document.getElementById('addElementsqlParameterTable'+rowID);
					addButtonToDisable.setAttribute('class', "addDisableButton");
					if(navigator.appName == "Microsoft Internet Explorer") {
						addButtonToDisable.onclick = function(){};
					} else {
						addButtonToDisable.setAttribute('onclick', '');
					}
				}
				
				if(document.getElementById('deleteElementsqlParameterTable'+rowID)){
					var deleteButtonToEnable = document.getElementById('deleteElementsqlParameterTable'+rowID);
					deleteButtonToEnable.setAttribute('class', "deleteDisableButton");
					if(navigator.appName == "Microsoft Internet Explorer") {
						deleteButtonToEnable.onclick = function(){};
					} else {
						deleteButtonToEnable.setAttribute('onclick', '');
					}
					
					
				}
			}
			
		}
		disableFirstRowDeleteButton(tableName);
	}
	
	function updateRequireOAuthCredentials(currentForm)
	{
		if(currentForm.oAuth.checked) {
			currentForm.requireOAuthCredentials.checked = true;
		}
		else
		{
			currentForm.requireOAuthCredentials.checked = false;
		}
		
	}
	
	function updateOAuth(currentForm)
	{
		if(currentForm.requireOAuthCredentials.checked) {
			currentForm.oAuth.checked = true;
		}
		else
		{
			currentForm.oAuth.checked = false;
		}
		
	}
	function toggleresourcePath()
	{
			var selectOption =  document.getElementById("requestType"); 
			var resourcePath = document.getElementById("resourcePath"); 
			if(selectOption.selectedIndex!=0)
			{
				resourcePath.disabled="";		
			}
			else {
				resourcePath.disabled="disabled";
				resourcePath.value="";
			}
	}

	function toggleErrorMsg(action){
		var customErrorMessage = document.getElementById("customErrorMessage")
		if (action == 'deny')
		{
			customErrorMessage.disabled = false;
		}
		else if (action == 'alert')
		{
			customErrorMessage.disabled = true;
		}
	}
	
	function  deleteRow(tableName,rownum) {
		var tableObj = document.getElementById(tableName);
		var tRows = tableObj.rows;

		if(tRows.length==2) {
			alert("Atleast one condition is required.");
			return;
		}
		for(var i=0 ; i < tRows.length ; i++) {
			if(tRows[i].id == rownum) {
				tableObj.deleteRow(i);
				break;
			}
		}
		//if(tRows.length==2) {
			disableFirstRowDeleteButton(tableName);
		//}	
	}
	function disableFirstRowDeleteButton(tableName) {
		
		var tableObj = document.getElementById(tableName);
		var tRows = tableObj.rows;
		if(tRows.length != 2) {
			return;
		}
		var reqDel = document.getElementById('deleteElement'+tableName+tRows[1].id);
		reqDel.setAttribute('class', "deleteDisableButton");
		if(navigator.appName == "Microsoft Internet Explorer") {
			reqDel.onclick = function(){};
		} else {
			reqDel.setAttribute('onclick', '');
		}
		if(tableName == "conditionTable"){
			conditionTableDisabledButton = reqDel;
			conditionTableDisabledButtonID = tRows[1].id;
		}
		if(tableName == "sqlParameterTable"){
			sqlParameterTableDisabledButton = reqDel;
			sqlParameterTableDisabledButtonID = tRows[1].id;
		}
		
	}
	function addParameterRow()
	{
		var tableName = 'sqlParameterTable';
		
		//populate global vars to keep track of disabled button
		if(sqlParameterTableDisabledButton != null) {
			sqlParameterTableDisabledButton.setAttribute('class', "deleteButton");
			if(navigator.appName == "Microsoft Internet Explorer") {
				sqlParameterTableDisabledButton.onclick = function(){deleteRow(tableName,sqlParameterTableDisabledButtonID);};
			} else {
				sqlParameterTableDisabledButton.setAttribute('onclick', 'deleteRow('+"'"+tableName+"','"+ sqlParameterTableDisabledButtonID + "'"+')');
			}
		}
		
		var	styleClass = "evencol";
		var tableObj = document.getElementById(tableName);
		var rowCount = tableObj.rows.length;
		
		var tRows = tableObj.rows;
		var rowNumToAssign = 1;
		
		//since first row is the table column header row
		if(rowCount>1){
			var rowIDofLastRow = tRows[rowCount-1].id;
			var rowNumOfLastRow = rowIDofLastRow.substring(3,4);
			rowNumToAssign = parseInt(rowNumOfLastRow)+1;
			
		}
		
		//Create a row at the end 
		var rowObj = createRowAtEnd(tableName,rowNumToAssign,styleClass);
		
		//Add Name column
		rowObj = createTextColumn("row"+rowNumToAssign,rowObj,'sqlParameterName',styleClass,"");
		
		//Add addButton
		rowObj = createButtonColumn(tableName,rowNumToAssign,rowObj,"add","addButton",styleClass);
		
		//Add deleteButton
		rowObj = createButtonColumn(tableName,rowNumToAssign,rowObj,"delete","deleteButton",styleClass);
		
	}
	function editParameterRow(){
		var tableName = 'sqlParameterTable';
		var	styleClass = "evencol";
		
		var tableObj = document.getElementById(tableName);
		
		var sqlInjectionParamterString = document.getElementById('SQLInjectionParameters').value;
		var sqlInjectionParameterList = sqlInjectionParamterString.split(",");
		//Create a row for each parameter
		for(var index =0; index < sqlInjectionParameterList.length ; index++){
			var sqlParameterName = sqlInjectionParameterList[index];
			var rowCount = tableObj.rows.length;
			
			if(!isEmpty(sqlParameterName)){
				//Create a row at the end 
				var rowObj = createRowAtEnd(tableName,rowCount,styleClass);
			
				//Add Name column
				rowObj = createTextColumn("row"+rowCount,rowObj,'sqlParameterName',styleClass,sqlParameterName);
				
				//Add addButton
				rowObj = createButtonColumn(tableName,rowCount,rowObj,"add","addButton",styleClass);
				
				//Add deleteButton
				rowObj = createButtonColumn(tableName,rowCount,rowObj,"delete","deleteButton",styleClass);
			}
		}
	}
	
	function addConditionRow() 
	{
		var tableName = 'conditionTable';
		if(conditionTableDisabledButton != null) {
			conditionTableDisabledButton.setAttribute('class', "deleteButton");
			if(navigator.appName == "Microsoft Internet Explorer") {
				conditionTableDisabledButton.onclick = function(){deleteRow(tableName,conditionTableDisabledButtonID);};
			} else {
				conditionTableDisabledButton.setAttribute('onclick', 'deleteRow('+"'"+tableName+"','"+ conditionTableDisabledButtonID + "'"+')');
			}
		}
		var	styleClass = "evencol";
		
		
		var tableObj = document.getElementById(tableName);
		
		var rowCount = tableObj.rows.length;
		
		var tRows = tableObj.rows;
		var rowNumToAssign = 1;
		
		//since first row is the table column header row
		if(rowCount>1){
			var rowIDofLastRow = tRows[rowCount-1].id;
			var rowNumOfLastRow = rowIDofLastRow.substring(3,4);
			rowNumToAssign = parseInt(rowNumOfLastRow)+1;
			
		}
	
		//Create a row at the end 
		var rowObj = createRowAtEnd(tableName,rowNumToAssign,styleClass);
		
		
		//Add Device Type column
		var deviceType = document.createElement('select');
		deviceType.setAttribute('id', 'deviceType'+rowNumToAssign);
		deviceType.setAttribute('name', 'deviceType'+rowNumToAssign);
		deviceType.setAttribute('style', 'width:100%');

		var option;
		
		for(var index = 0; index < allDeviceTypes.length; index++) {
			option = document.createElement("option");
			option.text = allDeviceTypes[index];
			option.value = allDeviceTypes[index];
			deviceType.add(option);
		}
		
		colObj = rowObj.insertCell(-1);
		colObj.setAttribute('class', styleClass + "-l");
		colObj.appendChild(deviceType);

		//Add Application column
		var mobApp = document.createElement('select');
		mobApp.setAttribute('id','applicationName'+rowNumToAssign);
		mobApp.setAttribute('name', 'applicationName'+rowNumToAssign);
		mobApp.setAttribute('style', 'width:100%');

		var option;
		
		for(var index = 0; index < allMobileApps.length; index++) {
			option=document.createElement("option");
			option.text =  allMobileApps[index];
			option.value = allMobileApps[index];
			mobApp.add(option);
		}
		
		colObj = rowObj.insertCell(-1);
		colObj.setAttribute('class', styleClass + "-l");
		colObj.appendChild(mobApp);
		
		//Add Condition column
		var condition = document.createElement('select');
		condition.setAttribute('id', 'condition'+rowNumToAssign);
		condition.setAttribute('name', 'condition'+rowNumToAssign);
	
		
		var option=document.createElement("option");
		
		option.text="";
		option.value="";
		//if(dCondition == "=") {
		//}
		condition.add(option);
		
		option=document.createElement("option");
		option.text="=";
		option.value="=";
		condition.add(option);


		option=document.createElement("option");
		option.text=">";
		option.value=">";
		condition.add(option);

		option=document.createElement("option");
		option.text="<";
		option.value="<";
		condition.add(option);
		
		option=document.createElement("option");
		option.text=">=";
		option.value=">=";
		condition.add(option);

		option=document.createElement("option");
		option.text="<=";
		option.value="<=";
		condition.add(option);
		
		option=document.createElement("option");
		option.text="<>";
		option.value="<>";
		condition.add(option);

		colObj = rowObj.insertCell(-1);
		colObj.setAttribute('class', styleClass + "-l");
		colObj.appendChild(condition);
	
		//Add Version column
		rowObj = createTextColumn(rowNumToAssign,rowObj,'applicationVersion',styleClass,"");
		
		//Add addButton
		rowObj = createButtonColumn(tableName,rowNumToAssign,rowObj,"add","addButton",styleClass);
		
		
		//Add deleteButton
		rowObj = createButtonColumn(tableName,rowNumToAssign,rowObj,"delete","deleteButton",styleClass);

	}
		
	function createRowAtEnd(tableName,rowCount,styleClass)
	{
		var tableObj = document.getElementById(tableName);
		//Create a row at the end 
		var rowObj = tableObj.insertRow(-1); 
		rowObj.setAttribute('class', styleClass);
		var tRows = tableObj.rows;
		rowObj.setAttribute('id','row'+rowCount);
		rowObj.setAttribute('name', 'row'+rowCount);
		return rowObj;
	}
	function createTextColumn(rowCount,rowObj,columnName,styleClass,textColumnValue){
	
		var textField = document.createElement('input');
		textField.setAttribute('type', 'text');
		
		textField.setAttribute('id', columnName+rowCount);
		textField.setAttribute('name', columnName+rowCount);
		textField.setAttribute('style', 'width:50%');

		if(textColumnValue!=""){
			textField.value = textColumnValue;
		}
		colObj = rowObj.insertCell(-1);
		colObj.setAttribute('class', styleClass + "-l");
		colObj.appendChild(textField);
		return rowObj;
		
	}
	
	function createButtonColumn(tableName,rowCount,rowObj,action,buttonStyleClass,columnStyleClass){
		
		var rowcntID = "row"+rowCount;
		
		var newButton = document.createElement('input');
		newButton.setAttribute('type', 'button');
		newButton.setAttribute('class', buttonStyleClass);

		newButton.setAttribute('id', action+"Element"+tableName+rowcntID);
		newButton.setAttribute('name', action+"Element"+tableName+rowcntID);
		
		if(action=="add"){
			if(navigator.appName == "Microsoft Internet Explorer") {
				if(tableName == "conditionTable"){
					newButton.onclick = function(){addConditionRow();};
				}
				if(tableName == "sqlParameterTable"){
					newButton.onclick = function(){addParameterRow();};
				}
			} else {
				if(tableName == "conditionTable"){
					newButton.setAttribute('onclick', 'addConditionRow()');
				}
				if(tableName == "sqlParameterTable"){
					newButton.setAttribute('onclick', 'addParameterRow()');
				}
				
			}
		}
		if(action=="delete"){
			if(navigator.appName == "Microsoft Internet Explorer") {
				newButton.onclick = function(){deleteRow(tableName,rowcntID);};
			} else {
				newButton.setAttribute('onclick', 'deleteRow(' +"'"+tableName+"','"+ rowcntID + "'"+')');
			}
		}

		colObj = rowObj.insertCell(-1);
		colObj.setAttribute('class', columnStyleClass);
		colObj.appendChild(newButton);
		return rowObj;
	}
	
	function editConditionRow(dAppName, dType, dCondition, dVersion) 
	{
		var tableName = 'conditionTable';
		//alert("dType:"+dType+" dCondition:"+dCondition+" dVersion:"+dVersion);
		var	styleClass = "evencol";

		var tableObj = document.getElementById(tableName);
		var rowCount = tableObj.rows.length;
	
		//Create a row at the end 
		var rowObj = createRowAtEnd(tableName,rowCount,styleClass);
		
		//Add Device Type column
		var deviceType = document.createElement('select');
		deviceType.setAttribute('id', 'deviceType'+rowCount);
		deviceType.setAttribute('name', 'deviceType'+rowCount);
		var option;
		
		for(var index = 0; index < allDeviceTypes.length; index++) {
			option = document.createElement("option");
			option.text = allDeviceTypes[index];
			option.value = allDeviceTypes[index];
			if(dType == allDeviceTypes[index]) {
				option.selected = true;
			}
			deviceType.add(option);
		}
		
		colObj = rowObj.insertCell(-1);
		colObj.setAttribute('class', styleClass + "-l");
		colObj.appendChild(deviceType);
		
		//Add Application column
		var mobApp = document.createElement('select');
		mobApp.setAttribute('id','applicationName'+rowCount);
		mobApp.setAttribute('name', 'applicationName'+rowCount);
		var option;
		
		for(var index = 0; index < allMobileApps.length; index++) {
			option = document.createElement("option");
			option.text = allMobileApps[index];
			option.value = allMobileApps[index];
			if(dAppName == allMobileApps[index]) {
				option.selected = true;
			}
			mobApp.add(option);
		}
		
		colObj = rowObj.insertCell(-1);
		colObj.setAttribute('class', styleClass + "-l");

		colObj.appendChild(mobApp);
		
		//Add Condition column
		var condition = document.createElement('select');
		condition.setAttribute('id', 'condition'+rowCount);
		condition.setAttribute('name', 'condition'+rowCount);
		
		var option=document.createElement("option");
		
		option.text="";
		option.value="";
		//if(dCondition == "=") {
		option.selected = true;
		//}
		condition.add(option);
		
		option=document.createElement("option");
		option.text="=";
		option.value="=";
		if(dCondition == "=") {
			option.selected = true;
		}
		condition.add(option);


		option=document.createElement("option");
		option.text=">";
		option.value=">";
		if(dCondition == ">" || dCondition == "&gt;") {
			option.selected = true;
		}
		condition.add(option);

		option=document.createElement("option");
		option.text="<";
		option.value="<";
		if(dCondition == "<" || dCondition == "&lt;") {
			option.selected = true;
		}
		condition.add(option);
		
		option=document.createElement("option");
		option.text=">=";
		option.value=">=";
		if(dCondition == ">=" || dCondition == "&gt;=") {
			option.selected = true;
		}
		condition.add(option);

		option=document.createElement("option");
		option.text="<=";
		option.value="<=";
		if(dCondition == "<=" || dCondition == "&lt;=") {
			option.selected = true;
		}
		condition.add(option);
		
		option=document.createElement("option");
		option.text="<>";
		option.value="<>";
		if(dCondition == "<>" || dCondition == "&lt;&gt;") {
			option.selected = true;
		}
		condition.add(option);
		
		colObj = rowObj.insertCell(-1);
		colObj.setAttribute('class', styleClass + "-l");

		colObj.appendChild(condition);
	
		//Add Version column
		rowObj = createTextColumn(rowCount,rowObj,'applicationVersion',styleClass,dVersion);
				
		//Add addButton
		rowObj = createButtonColumn(tableName,rowCount,rowObj,"add","addButton",styleClass);
		
		
		//Add deleteButton
		rowObj = createButtonColumn(tableName,rowCount,rowObj,"delete","deleteButton",styleClass);
		
		///////////////////
	

	}	
  </script>
</head>
%ifvar operation equals('createRule')%
	<body onLoad="setNavigation('security-enterprisegateway-create-rule.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_EnterpriseGatewayRules_CreateRuleScrn');">
%endif%
%ifvar operation equals('editRule')%
	<body onLoad="setNavigation('security-enterprisegateway-create-rule.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_EnterpriseGatewayRules_EditRuleScrn');">
%endif%
%ifvar operation equals('copyRule')%
	<body onLoad="setNavigation('security-enterprisegateway-create-rule.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_EnterpriseGatewayRules_CreateRuleScrn');">
%endif%

<form method="post" name="createRule" action="security-enterprisegateway-rules.dsp" id="createRule">

<table width="100%">
	<tr>
		<td class="menusection-Security" colspan="2">Security&nbsp;&gt;&nbsp;Enterprise&nbsp;Gateway&nbsp;Rules&nbsp;&gt;&nbsp;Rules&nbsp;&gt;
			%ifvar operation equals('createRule')%
				Create&nbsp;
			%endif%
			%ifvar operation equals('editRule')%
				%value rule% &gt;&nbsp;Edit&nbsp;
			%endif%
			%ifvar operation equals('copyRule')%
				%value rule%_copy &gt;&nbsp;Create&nbsp;
			%endif%
			</td>
		</tr>
		
		%invoke wm.server.enterprisegateway:listMobileDeviceTypes%
			<script>globalDeviceTypeIndex=0;
				allDeviceTypes[globalDeviceTypeIndex] = '';
				globalDeviceTypeIndex = globalDeviceTypeIndex+1;
			</script>
			
			%loop mobileAppDeviceTypes%
				<script>
					allDeviceTypes[globalDeviceTypeIndex] = '%value%';
					globalDeviceTypeIndex = globalDeviceTypeIndex+1;
				</script>
			%endloop%
			%rename mobileAppDeviceTypes oldMobileAppDeviceTypes%
			<script>globalDeviceTypeIndex=0;</script>
		%endinvoke%
		%invoke wm.server.enterprisegateway:listMobileApplications%
			<script>
				globalallMobileAppsIndex=0;
				allMobileApps[globalallMobileAppsIndex] = '';
				globalallMobileAppsIndex = globalallMobileAppsIndex+1;
			</script>
			%loop mobileApplications%
				<script>
					allMobileApps[globalallMobileAppsIndex] = '%value%';
					globalallMobileAppsIndex = globalallMobileAppsIndex+1;
				</script>
			%endloop%
			%rename mobileApplications oldMobileApplications%
			<script>globalallMobileAppsIndex=0;</script>
		%endinvoke%
			
	<tr>
		<td colspan="2">
			<ul>
				<li><a href="security-enterprisegateway-rules.dsp">Return&nbsp;to&nbsp;Enterprise&nbsp;Gateway&nbsp;Rules</a></li>
			</ul>
		</td>
	</tr>
	<input type="hidden" name="operation" id="operation" value="%value operation%">
	<input type="hidden" name="ruleType" id="ruleType" value="%value ruleType%">
	<input type="hidden" name="rule" id="rule" value="%value rule%">
	<input type="hidden" name="index" id="index" value="%value index%">		
	
	%ifvar operation equals('editRule')%
				
		%invoke wm.server.enterprisegateway:getRuleByName%
			%ifvar message%
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td class="message" colspan="2">%value message%</td></tr>
			%endif%
			%onerror%
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
		%endinvoke%
	%endif%
	
	%ifvar operation equals('copyRule')%
				
		%invoke wm.server.enterprisegateway:getRuleByName%
			%ifvar message%
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td class="message" colspan="2">%value message%</td></tr>
			%endif%
			%onerror%
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
		%endinvoke%
	%endif%
	
	<input type="hidden" name="isRuleEnabled" id="isRuleEnabled" value="%value isRuleEnabled%">
	
	<input type="hidden" name="isOAuthEnabled" id="isOAuthEnabled" value="%value isOAuthEnabled%">
	<input type="hidden" name="isRequireOAuthCredentials" id="isRequireOAuthCredentials" value="%value isRequireOAuthCredentials%">
	<input type="hidden" name="isMessageSizeEnabled" id="isMessageSizeEnabled" value="%value isMessageSizeEnabled%">
	<input type="hidden" name="isMobileAppProtectionEnabled" id="isMobileAppProtectionEnabled" value="%value isMobileAppProtectionEnabled%">
	<input type="hidden" name="noOfProperties" id="noOfProperties">	
	<input type="hidden" name="fromUI" id="fromUI" value="false">	
	
	
	
	<input type="hidden" name="isSQLInjectionFilterEnabled" id="isSQLInjectionFilterEnabled" value="%value isSQLInjectionFilterEnabled%"/>
	<input type="hidden" name="isDBSQLInjectionEnabled" id="isDBSQLInjectionEnabled" value="%value isDBSQLInjectionEnabled%"/>
	<input type="hidden" name="isStdSQLInjectionEnabled" id="isStdSQLInjectionEnabled" value="%value isStdSQLInjectionEnabled%"/>
	<input type="hidden" name="SQLInjectionParameters" id="SQLInjectionParameters" value="%value SQLInjectionParameters%"/>
	<input type="hidden" name="SQLInjectionDBList" id="SQLInjectionDBList" value="%value SQLInjectionDBList%"/>
	
	<input type="hidden" name="isAntiVirusScanEnabled" id="isAntiVirusScanEnabled" value="%value isAntiVirusScanEnabled%"/>
	
	<table class="tableView" width="100%">
		<tr>
			<td width="10px">
				<img src="images/blank.gif"  border=0>
			</td>
			<td>	
				<table class="tableView" width="70%">
					<tr>
						<td class="heading" colspan="2" width="100%"> Rule Properties</td>
					</tr>
					<tr>
						<td class="oddrow" width="20%">Rule Name</td>
						<td class="oddrow-l" width="80%">
						
							%ifvar operation equals('createRule')%
								<input type="text" name="ruleName" id="ruleName" form="createRule" size="57" >
							%else%
								<input type="text" name="ruleName" id="ruleName" %ifvar operation equals('editRule')% value="%value ruleName%" readonly="readonly"%else%  value="%value ruleName%_copy" %endif% form="createRule" size="57">
							%endif%
						</td>
		
					</tr>
					<tr >	
						<td class="evenrow" width="20%">Description</td>
						<td class="evenrow-l" width="80%">
							<textarea name="ruleDescription" rows="4" cols="54" form="createRule">%value ruleDescription%</textarea>
						</td>
					</tr>
					<tr >
						<td class="oddrow" width="20%">&nbsp;&nbsp; Enable</td>
						<td class="oddrow-l" width="80%">&nbsp;<input type="checkbox" name="enableRule" id="enableRule" value="Enable"   %ifvar isRuleEnabled equals('true')%checked%endif%></td></tr>
					<tr>
						<td class="evenrow" width="20%"> 
							 Request Type
						</td>
						<td class="evenrow-l" width="80%">
							<select size="1" name="requestType" id="requestType" onchange="toggleresourcePath()">
								%ifvar operation equals('createRule')%
								<option selected value="ALL">ALL</option>
								%else%
								<option %ifvar requestType equals('ALL')%selected%endif% value="ALL">ALL</option>
								 %endif%
								<option %ifvar requestType equals('SOAP')%selected%endif% value="SOAP">SOAP</option> 
								<option %ifvar requestType equals('REST')%selected%endif% value="REST">REST</option>
								<option %ifvar requestType equals('INVOKE')%selected%endif% value="INVOKE">INVOKE</option> 
							</select>
						</td>
					</tr>
					<tr>
						<td class="oddrow" width="20%">Resource Path
						</td>
						<td class="oddrow-l" width="80%">		
							%ifvar operation equals('createRule')%
								<textarea name="resourcePath" id="resourcePath"  rows="4" cols="54" disabled="disabled"></textarea>
							%else%
								%ifvar requestType equals('ALL')%
									<textarea name="resourcePath" id="resourcePath"  rows="4" cols="54" disabled="disabled"></textarea>
								%else%
									<textarea name="resourcePath" id="resourcePath"  rows="4" cols="54">%value resourcePath%</textarea>
								%endif%
							%endif%
							(ex:folder_name/service_name)
						</td>	
					</tr>
					<tr>		  
						<td class="oddrow" width="20%"/>
						<td class="oddrow-l" width="80%" colspan=2>Enter one resource path per line</TD>						
					</tr>
					<tr >
						<td class="evenrow" width="20%">Action</td>
						<td class="evenrow-l" width="80%">
							<table>
							<tr>
							  <td>
								
								%ifvar operation equals('createRule')%
									<input type="radio" name="action" id="deny" value="DENY"   checked onclick="toggleErrorMsg('deny');">&nbsp; Deny Request and Alert
								%else%
									<input type="radio" name="action" id="deny" value="DENY"  %ifvar action equals('DENY')%checked%endif% onclick="toggleErrorMsg('deny');">&nbsp; Deny Request and Alert
								%endif%
								
							  </td>
							   <td>
								 <input type="radio" name="action" id="alert" value="ALERT"  %ifvar action equals('ALERT')%checked%endif% onclick="toggleErrorMsg('alert');">&nbsp;&nbsp;Alert
							   </td>
							</tr>
							
						  </table>
					 </td>
					</tr>
					<tr>
							<td class="oddrow" width="20%">Error Message</td>
							<td class="oddrow-l" width="80%">
								%ifvar operation equals('createRule')%
									<input type="text" name="customErrorMessage" id="customErrorMessage"  value="Access Denied" size="57" >
								%else%
									<input type="text" name="customErrorMessage" id="customErrorMessage"  value="%value customErrorMessage%" %ifvar action equals('ALERT')% disabled%endif% size="57" >
								%endif%
							</td>
					</tr>
				 </table>
				 <br>
 <!-- Filter Table Starts -->
 <table class="tableView" width="100%">
		<tr>
		    <table class="tableView" width="70%" id="filterTable">
				<TBODY>
					<tr>
						<td class="heading" colspan="2" width="100%">OAuth Filter</td>
					</tr>
					<tr>
						<td  width="20%" class="oddrow">Enable</td>
						<td  width="80%" class="oddrow-l">
							<input type="checkbox" name="oAuth" id="oAuth"  onclick="updateRequireOAuthCredentials(this.form)" %ifvar isOAuthEnabled equals('true')%checked%endif%>
						</td>
					</tr>
					<tr>
						<td  width="20%" class="evenrow">Require OAuth Credentials</td>
						<td  width="70%" class="evenrow-l">
							<input type="checkbox"  name="requireOAuthCredentials" id="requireOAuthCredentials" onclick="updateOAuth(this.form)" %ifvar isRequireOAuthCredentials equals('true')%checked%endif%>
						</td>
					</tr>
					<tr>
						<td class="heading" colspan="2" width="100%">Message Size Filter</td>
					</tr>	
					<tr>
						<td  width="20%" class="oddrow">Enable</td>
						<td  width="80%" class="oddrow-l">
							<input type="checkbox" name="messageSize" id="messageSize"  %ifvar isMessageSizeEnabled equals('true')%checked%endif%>
						</td>
					</tr>
					<tr>				
						<td width="20%" class="evenrow">Maximum Message Size</td>
						<td width="80%" class="evenrow-l">
							%ifvar operation equals('createRule')%
								<input name="maximumMessageSize" id="maximumMessageSize" >&nbsp;MB
							%else%
								<input name="maximumMessageSize" id="maximumMessageSize"  value="%value maximumMessageSize%">&nbsp;MB
							%endif%
						</td>
					</tr>
					<tr>
						<td class="heading" colspan="2" width="100%">Mobile Application Protection Filter</td>
					</tr>	
					<tr>
						<td width="20%" class="oddrow">Enable</td>
						<td  width="80%" class="oddrow-l">
							<input type="checkbox" name="mobileApplicationProtection" id="mobileApplicationProtection"  %ifvar isMobileAppProtectionEnabled equals('true')%checked%endif%>
						</td>
						</tr>
					<tr>	
						<td width="20%" class="evenrow">Conditions</td>
						<td  width="80%" class="oddrow-l">
						  	<table width="100%">
								<tr>
									<td>
										<table id="conditionTable" name="conditionTable" class="table" width="100%">
											<tr>
												<td class="evencol-l">Device Type</td>
												<td class="evencol-l">Mobile Application</td>
												<td class="evencol-l">Condition</td>
												<td class="evencol-l">Mobile Application Version</td>
												<td class="evencol">Add</td>
												<td class="evencol">Delete</td>
											</tr>
											%ifvar operation equals('createRule')%
												<script>addConditionRow();disableFirstRowDeleteButton('conditionTable');</script>
											%endif%	
										</table>
									</td>
									%ifvar operation equals('createRule')%
									%else%
										 %ifvar -notempty mobileApplications%
											%loop mobileApplications%
												<script>editConditionRow('%value applicationName%', '%value deviceType%', '%value condition%','%value applicationVersion%');</script>
											%endloop%
											<script>disableFirstRowDeleteButton('conditionTable');</script>
										%else%	
											<script>addConditionRow();disableFirstRowDeleteButton('conditionTable');</script>
										%endif%
									%endif%
								</tr>
							</table>
						</td>
					</tr>
					<!-- SQL Injection Protection Filter starts -->
					<tr>
						<td class="heading" colspan="2" width="100%">SQL Injection Protection Filter</td>
					</tr>
					<tr>
						<td width="20%" class="oddrow">Enable</td>
						<td  width="80%" class="oddrow-l">
							<input type="checkbox" name="sqlInjectionFilter" id="sqlInjectionFilter"  %ifvar isSQLInjectionFilterEnabled equals('true')%checked%endif%>
						</td>
					</tr>
					<tr>
						<td width="20%" class="evenrow">Database-Specific SQL Injection Protection</td>
						<td  width="80%" class="evenrow-l">
							<input type="checkbox" name="databaseSpecificSql" id="databaseSpecificSql" onclick="toggleDBParameters()" %ifvar isDBSQLInjectionEnabled equals('true')%checked%endif%>
							<label for="databaseSpecificSql">Select check box to specify database and parameters </label>
						</td>
					</tr>
					<tr name="SQLFilterDatabaseRow" id="SQLFilterDatabaseRow" 
					>
						<td width="20%" class="oddrow">Database</td>
						<td width="80%" class="oddrow-l">
							<select size="1" name="databasesForSQLFilter" id="databasesForSQLFilter" 
							%ifvar isDBSQLInjectionEnabled equals('true')% 
							%else%  disabled="disabled"
							%endif%
							>
								%ifvar operation equals('createRule')%
									<option selected value="None">None</option>
								%else%
									<option %ifvar SQLInjectionDBList equals('NONE')%selected%endif% value="None">None</option>
								 %endif%
								<option %ifvar SQLInjectionDBList equals('DB2')%selected%endif% value="DB2">DB2</option> 
								<option %ifvar SQLInjectionDBList equals('ORACLE')%selected%endif% value="Oracle">Oracle</option>
								<option %ifvar SQLInjectionDBList equals('SQL_SERVER')%selected%endif% value="SQL Server">SQL Server</option> 
								<option %ifvar SQLInjectionDBList equals('MYSQL')%selected%endif% value="MySQL">MySQL</option>
							</select>
						</td>
					
					</tr>
					<tr name="SQLFilterParametersRow" id="SQLFilterParametersRow" 
					>
						<td width="20%" class="evenrow">Parameters</td>
						<td  width="80%" class="oddrow-l">
						  	<table width="100%">
								<tr>
									<td>
										<table id="sqlParameterTable" name="sqlParameterTable" class="table" width="100%">
												<tr>
													<td class="evencol-l">Name</td>
													<td class="evencol">Add</td>
													<td class="evencol">Delete</td>
												</tr>
												 %ifvar operation equals('createRule')%
													<script>addParameterRow();toggleDBParameters();disableFirstRowDeleteButton('sqlParameterTable');</script>
												%endif%	 
											</table>
									</td>
									%ifvar operation equals('createRule')%
									%else%
										 %ifvar -notempty SQLInjectionParameters%
											<script>editParameterRow();</script>
											<script>toggleDBParameters();disableFirstRowDeleteButton('sqlParameterTable');</script>
										%else%	
											<script>addParameterRow();toggleDBParameters();disableFirstRowDeleteButton('sqlParameterTable');</script>
										%endif%
									%endif% 
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td width="20%" class="oddrow">Standard SQL Injection Protection</td>
						<td  width="80%" class="oddrow-l">
							<input type="checkbox" name="standardSql" id="standardSql"  %ifvar isStdSQLInjectionEnabled equals('true')%checked%endif%>
						</td>
					</tr>
				<!-- SQL Injection Filter ends -->
				<!-- Anti Virus scan Filter Starts--> 
				<tr>
						<td class="heading" colspan="2" width="100%">Antivirus Scan Filter</td>
				</tr>	
				<tr>
						<td  width="20%" class="oddrow">Enable</td>
						<td  width="80%" class="oddrow-l">
							<input type="checkbox" name="antiVirusScan" id="antiVirusScan"  %ifvar isAntiVirusScanEnabled equals('true')%checked%endif%>
						</td>
				</tr>
				<tr>				
						<td width="20%" class="evenrow">Antivirus ICAP Engine Name</td>
						<td width="80%" class="evenrow-l">
							%ifvar operation equals('createRule')%
								<input name="icapEngineName" id="icapEngineName" >
							%else%
								<input name="icapEngineName" id="icapEngineName"  value="%value icapEngineName%">
							%endif%
						</td>
				</tr>
				<tr>				
						<td width="20%" class="oddrow">ICAP Host Name or IP Address</td>
						<td width="80%" class="oddrow-l">
							%ifvar operation equals('createRule')%
								<input name="icapHost" id="icapHost" >
							%else%
								<input name="icapHost" id="icapHost"  value="%value icapHost%">
							%endif%
						</td>
				</tr>
				<tr>				
						<td width="20%" class="evenrow">ICAP Port Number</td>
						<td width="80%" class="evenrow-l">
							%ifvar operation equals('createRule')%
								<input name="icapPort" id="icapPort" MAXLENGTH="5" >
							%else%
								<input name="icapPort" id="icapPort"  value="%value icapPort%" MAXLENGTH="5">
							%endif%
						</td>
				</tr>
				<tr>				
						<td width="20%" class="oddrow">ICAP Service Name</td>
						<td width="80%" class="oddrow-l">
							%ifvar operation equals('createRule')%
								<input name="icapService" id="icapService" >
							%else%
								<input name="icapService" id="icapService"  value="%value icapService%">
							%endif%
						</td>
				</tr>
				<!-- Anti Virus scan Filter Ends--> 
					<tr class="action">
							<td  colspan="2" width="100%">
								<input type="submit" name="submit" value="Save Changes" onclick="return validate(this.form);">
							</td>
					</tr>
				</TBODY>
			</table>
		</tr>
 </table>
 <!-- Filter Table ends -->

 </p></table>
 </form>
</body>
</html>