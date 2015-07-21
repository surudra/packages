
<HTML>
<HEAD>
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
	<META HTTP-EQUIV="Expires" CONTENT="-1">
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
	</style>

    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt"></script>
    <SCRIPT language="javascript">
	
	var httpMsgAddressingAliases = new Array();
	var httpsMsgAddressingAliases = new Array();
	var jmsMsgAddressingAliases = new Array();

	function disableRMProperties()
	{
		document.getElementById("retransmissionInterval").disabled = true;
		document.getElementById("acknowledgementInterval").disabled = true;
		document.getElementById("exponentialBackoff").disabled = true;
		document.getElementById("maximumRetransmissionCount").disabled = true;
	}
	
	function enableRMProperties()
	{
		document.getElementById("retransmissionInterval").disabled = false;
		document.getElementById("acknowledgementInterval").disabled = false;
		document.getElementById("exponentialBackoff").disabled = false;
		document.getElementById("maximumRetransmissionCount").disabled = false;
	}

	function toggleRMProperties()
	{
		var rmEnabled = document.getElementById("enable").checked;
		if (rmEnabled)
		{
			enableRMProperties();
		}
		else
		{
			disableRMProperties();
		}
	}

	function toggleSoapRoleInput()
	{
		var soapRoleOptions =  document.getElementById("soapRoleOptions"); 
		var soapRoleInputField = document.getElementById("soapRoleInputField"); 

		if(soapRoleOptions.selectedIndex != 3)
		{
			soapRoleInputField.disabled= "disabled";		
			soapRoleInputField.value="";
		}
		else {
			soapRoleInputField.disabled= "";
		}
	}

	function deleteResponseMapRow(rowId) {
		var tableObj = document.getElementById('responseMapTable');
		var tRows = tableObj.rows;

		if(tRows.length==2) {
			alert("Atleast one row is required.");
			return;
		}
		for(var i=0 ; i < tRows.length ; i++) {
			if(tRows[i].id == rowId) {
				tableObj.deleteRow(i);
				break;
			}
		}
		disableFirstResponseMapRowDeleteButton();
	}
	
	var disabledButtonResponseMap;
	var	disabledButtonIDResponseMap;

	function disableFirstResponseMapRowDeleteButton() {
		var tableObj = document.getElementById('responseMapTable');
		var tRows = tableObj.rows;

		if(tRows.length != 2) {
			return;
		}
		
		var reqDel = document.getElementById('deleteElement'+tRows[1].id);
		var reqDelID = tRows[1].id;
		reqDel.setAttribute((document.all ? 'className' : 'class'), "deleteDisableButton");

		if(navigator.appName == "Microsoft Internet Explorer") {
			reqDel.onclick = function(){};
		} else {
			reqDel.setAttribute('onclick', '');
		}
		disabledButtonResponseMap = reqDel;
		disabledButtonIDResponseMap = reqDelID;
	}

	function deleteParamRow(type, tablePrefix, rowId) {
		var tableName = type + tablePrefix + 'Table';
		var tableObj = document.getElementById(tableName);
		var tRows = tableObj.rows;

		if(tRows.length==1) {
			alert("Atleast one parameter is required.");
			return;
		}
		for(var i=0 ; i < tRows.length ; i++) {
			if(tRows[i].id == rowId) {
				tableObj.deleteRow(i);
				break;
			}
		}
		disableFirstRowDeleteButton(type, tablePrefix);
	}

	//to
	var disabledButtonToReferenceParams = null;
	var disabledButtonIDToReferenceParams = null;
	
	var disabledButtonToMetadataElements = null;
	var disabledButtonIDToMetadataElements = null;
	
	var disabledButtonToExtensible = null;
	var disabledButtonIDToExtensible = null;

	//from
	var disabledButtonFromReferenceParams = null;
	var disabledButtonIDFromReferenceParams = null;
	
	var disabledButtonFromMetadataElements = null;
	var disabledButtonIDFromMetadataElements = null;
	
	var disabledButtonFromExtensible = null;
	var disabledButtonIDFromExtensible = null;
	
	//reply to
	var disabledButtonReplyToReferenceParams = null;
	var disabledButtonIDReplyToReferenceParams = null;
	
	var disabledButtonReplyToMetadataElements = null;
	var disabledButtonIDReplyToMetadataElements = null;

	var disabledButtonReplyToExtensible = null;
	var disabledButtonIDReplyToExtensible = null;
	
	//fault to
	var disabledButtonFaultToReferenceParams = null;
	var disabledButtonIDFaultToReferenceParams = null;
	
	var disabledButtonFaultToMetadataElements = null;
	var disabledButtonIDFaultToMetadataElements = null;
	
	var disabledButtonFaultToExtensible = null;
	var disabledButtonIDFaultToExtensible = null;
		
	function disableFirstRowDeleteButton(type, tablePrefix) {

		var tableName = type + tablePrefix + 'Table';
		var tableObj = document.getElementById(tableName);
		var tRows = tableObj.rows;
		
		if(tRows.length != 1) {
			return;
		}
		var reqDel = document.getElementById('deleteElement'+tRows[0].id);
		if (reqDel == null)
			return;
		var reqDelID = tRows[0].id;
		reqDel.setAttribute((document.all ? 'className' : 'class'), "deleteDisableButton");

		if(navigator.appName == "Microsoft Internet Explorer") {
			reqDel.onclick = function(){};
		} else {
			reqDel.setAttribute('onclick', '');
		}
		
		if (tablePrefix == 'ReferenceParams' )
		{
			if (type == "from")
			{
				disabledButtonFromReferenceParams = reqDel;
				disabledButtonIDFromReferenceParams = reqDelID;
			}
			else if (type == "replyTo")
			{
				disabledButtonReplyToReferenceParams = reqDel;
				disabledButtonIDReplyToReferenceParams = reqDelID;
			}
			else if (type == "faultTo")
			{
				disabledButtonFaultToReferenceParams = reqDel;
				disabledButtonIDFaultToReferenceParams = reqDelID;
			}
			else if (type == "to")
			{
				disabledButtonToReferenceParams = reqDel;
				disabledButtonIDToReferenceParams = reqDelID;
			}
		}
		else if (tablePrefix == 'MetadataElements')
		{
			if (type == "from")
			{
				disabledButtonFromMetadataElements = reqDel;
				disabledButtonIDFromMetadataElements = reqDelID;
			}
			else if (type == "replyTo")
			{
				disabledButtonReplyToMetadataElements = reqDel;
				disabledButtonIDReplyToMetadataElements = reqDelID;
			}
			else if (type == "faultTo")
			{
				disabledButtonFaultToMetadataElements = reqDel;
				disabledButtonIDFaultToMetadataElements = reqDelID;
			}
			else if (type == "to")
			{
				disabledButtonToMetadataElements = reqDel;
				disabledButtonIDToMetadataElements = reqDelID;
			}
		}
		
		else if (tablePrefix == 'Extensible')
		{
			if (type == "from")
			{
				disabledButtonFromExtensible = reqDel;
				disabledButtonIDFromExtensible = reqDelID;
			}
			else if (type == "replyTo")
			{
				disabledButtonReplyToExtensible = reqDel;
				disabledButtonIDReplyToExtensible = reqDelID;
			}
			else if (type == "faultTo")
			{
				disabledButtonFaultToExtensible = reqDel;
				disabledButtonIDFaultToExtensible = reqDelID;
			}
			else if (type == "to")
			{
				disabledButtonToExtensible = reqDel;
				disabledButtonIDToExtensible = reqDelID;
			}
		}
	}
	
	function editParamRow(action, type, tablePrefix, paramValue) 
	{
		var tableName = type + tablePrefix + 'Table';
		if(tablePrefix == 'ReferenceParams') {
			if (type == "from" && disabledButtonFromReferenceParams != null)
			{
				disabledButtonFromReferenceParams.setAttribute((document.all ? 'className' : 'class'), "deleteButton");
				if(navigator.appName == "Microsoft Internet Explorer") {
					disabledButtonFromReferenceParams.onclick = function(){deleteParamRow(type,tablePrefix,disabledButtonIDFromReferenceParams);};
				} else {
					disabledButtonFromReferenceParams.setAttribute('onclick', 'deleteParamRow(' + "'" +  type + "'"  + ",'" +  tablePrefix + "'"  + ",'" +disabledButtonIDFromReferenceParams + "'"+')');
				}
			}
			else if (type == "replyTo" && disabledButtonReplyToReferenceParams != null)
			{
				disabledButtonReplyToReferenceParams.setAttribute((document.all ? 'className' : 'class'), "deleteButton");
				if(navigator.appName == "Microsoft Internet Explorer") {
					disabledButtonReplyToReferenceParams.onclick = function(){deleteParamRow(type,tablePrefix,disabledButtonIDReplyToReferenceParams);};
				} else {
					disabledButtonReplyToReferenceParams.setAttribute('onclick', 'deleteParamRow(' + "'" +  type + "'"  + ",'" +  tablePrefix + "'"  + ",'" +disabledButtonIDReplyToReferenceParams + "'"+')');
				}
			}
			else if (type == "faultTo" && disabledButtonFaultToReferenceParams != null)
			{
				disabledButtonFaultToReferenceParams.setAttribute((document.all ? 'className' : 'class'), "deleteButton");
				if(navigator.appName == "Microsoft Internet Explorer") {
					disabledButtonFaultToReferenceParams.onclick = function(){deleteParamRow(type,tablePrefix,disabledButtonIDFaultToReferenceParams);};
				} else {
					disabledButtonFaultToReferenceParams.setAttribute('onclick', 'deleteParamRow(' + "'" +  type + "'"  + ",'" +  tablePrefix + "'"  + ",'" +disabledButtonIDFaultToReferenceParams + "'"+')');
				}
			}
			else if (type == "to" && disabledButtonToReferenceParams != null)
			{
				disabledButtonToReferenceParams.setAttribute((document.all ? 'className' : 'class'), "deleteButton");
				if(navigator.appName == "Microsoft Internet Explorer") {
					disabledButtonToReferenceParams.onclick = function(){deleteParamRow(type,tablePrefix,disabledButtonIDToReferenceParams);};
				} else {
					disabledButtonToReferenceParams.setAttribute('onclick', 'deleteParamRow(' + "'" +  type + "'"  + ",'" +  tablePrefix + "'"  + ",'" +disabledButtonIDToReferenceParams + "'"+')');
				}
			}
		}
		else if(tablePrefix == 'MetadataElements') {
			if (type == "from" && disabledButtonFromMetadataElements != null)
			{
				disabledButtonFromMetadataElements.setAttribute((document.all ? 'className' : 'class'), "deleteButton");
				if(navigator.appName == "Microsoft Internet Explorer") {
					disabledButtonFromMetadataElements.onclick = function(){deleteParamRow(type,tablePrefix,disabledButtonIDFromMetadataElements);};
				} else {
					disabledButtonFromMetadataElements.setAttribute('onclick', 'deleteParamRow(' + "'" +  type + "'"  + ",'" + tablePrefix + "'"  + ",'" + disabledButtonIDFromMetadataElements + "'"+')');
				}
			}
			else if (type == "replyTo" && disabledButtonReplyToMetadataElements != null)
			{
				disabledButtonReplyToMetadataElements.setAttribute((document.all ? 'className' : 'class'), "deleteButton");
				if(navigator.appName == "Microsoft Internet Explorer") {
					disabledButtonReplyToMetadataElements.onclick = function(){deleteParamRow(type,tablePrefix,disabledButtonIDReplyToMetadataElements);};
				} else {
					disabledButtonReplyToMetadataElements.setAttribute('onclick', 'deleteParamRow(' + "'" +  type + "'"  + ",'" + tablePrefix + "'"  + ",'" + disabledButtonIDReplyToMetadataElements + "'"+')');
				}
			}
			else if (type == "faultTo" && disabledButtonFaultToMetadataElements != null)
			{
				disabledButtonFaultToMetadataElements.setAttribute((document.all ? 'className' : 'class'), "deleteButton");
				if(navigator.appName == "Microsoft Internet Explorer") {
					disabledButtonFaultToMetadataElements.onclick = function(){deleteParamRow(type,tablePrefix,disabledButtonIDFaultToMetadataElements);};
				} else {
					disabledButtonFaultToMetadataElements.setAttribute('onclick', 'deleteParamRow(' + "'" +  type + "'"  + ",'" + tablePrefix + "'"  + ",'" + disabledButtonIDFaultToMetadataElements + "'"+')');
				}
			}
			else if (type == "to" && disabledButtonToMetadataElements != null)
			{
				disabledButtonToMetadataElements.setAttribute((document.all ? 'className' : 'class'), "deleteButton");
				if(navigator.appName == "Microsoft Internet Explorer") {
					disabledButtonToMetadataElements.onclick = function(){deleteParamRow(type,tablePrefix,disabledButtonIDToMetadataElements);};
				} else {
					disabledButtonToMetadataElements.setAttribute('onclick', 'deleteParamRow(' + "'" +  type + "'"  + ",'" + tablePrefix + "'"  + ",'" + disabledButtonIDToMetadataElements + "'"+')');
				}
			}
		}
		else if(tablePrefix == 'Extensible') {
			if (type == "from" && disabledButtonFromExtensible != null)
			{
				disabledButtonFromExtensible.setAttribute((document.all ? 'className' : 'class'), "deleteButton");
				if(navigator.appName == "Microsoft Internet Explorer") {
					disabledButtonFromExtensible.onclick = function(){deleteParamRow(type,tablePrefix,disabledButtonIDFromExtensible);};
				} else {
					disabledButtonFromExtensible.setAttribute('onclick', 'deleteParamRow(' + "'" +  type + "'"  + ",'" + tablePrefix + "'"  + ",'" + disabledButtonIDFromExtensible + "'"+')');
				}
			}
			else if (type == "replyTo" && disabledButtonReplyToExtensible != null)
			{
				disabledButtonReplyToExtensible.setAttribute((document.all ? 'className' : 'class'), "deleteButton");
				if(navigator.appName == "Microsoft Internet Explorer") {
					disabledButtonReplyToExtensible.onclick = function(){deleteParamRow(type,tablePrefix,disabledButtonIDReplyToExtensible);};
				} else {
					disabledButtonReplyToExtensible.setAttribute('onclick', 'deleteParamRow(' + "'" +  type + "'"  + ",'" + tablePrefix + "'"  + ",'" + disabledButtonIDReplyToExtensible + "'"+')');
				}
			}
			else if (type == "faultTo" && disabledButtonFaultToExtensible != null)
			{
				disabledButtonFaultToExtensible.setAttribute((document.all ? 'className' : 'class'), "deleteButton");
				if(navigator.appName == "Microsoft Internet Explorer") {
					disabledButtonFaultToExtensible.onclick = function(){deleteParamRow(type,tablePrefix,disabledButtonIDFaultToExtensible);};
				} else {
					disabledButtonFaultToExtensible.setAttribute('onclick', 'deleteParamRow(' + "'" +  type + "'"  + ",'" + tablePrefix + "'"  + ",'" + disabledButtonIDFaultToExtensible + "'"+')');
				}
			}
			else if (type == "to" && disabledButtonToExtensible != null)
			{
				disabledButtonToExtensible.setAttribute((document.all ? 'className' : 'class'), "deleteButton");
				if(navigator.appName == "Microsoft Internet Explorer") {
					disabledButtonToExtensible.onclick = function(){deleteParamRow(type,tablePrefix,disabledButtonIDToExtensible);};
				} else {
					disabledButtonToExtensible.setAttribute('onclick', 'deleteParamRow(' + "'" +  type + "'"  + ",'" + tablePrefix + "'"  + ",'" + disabledButtonIDToExtensible + "'"+')');
				}
			}
		}
		
		var	styleClass = "oddcol";
		var tableObj = document.getElementById(tableName);
		var rowCount = tableObj.rows.length;

		//Create a row at the end 
		var rowObj = tableObj.insertRow(-1); 
		var rowId =  type + tablePrefix + 'row' + rowCount; 

		rowObj.setAttribute((document.all ? 'className' : 'class'), styleClass);
		rowObj.setAttribute('id', rowId);
		rowObj.setAttribute('name', rowId);
		
		//Add XML Input Parameter column
		var xmlParam = document.createElement('textarea');
		xmlParam.setAttribute('id', type + tablePrefix + rowCount);
		xmlParam.setAttribute('name', type + tablePrefix);
		xmlParam.setAttribute('rows', '1');
		xmlParam.setAttribute('cols', '40');
		xmlParam.setAttribute('style', 'width:100%');
		xmlParam.value = paramValue;
		
		if (action == 'view')
		{
			xmlParam.disabled = true;
		}

		colObj = rowObj.insertCell(-1);
		colObj.setAttribute((document.all ? 'className' : 'class'), styleClass + "-l");
		colObj.appendChild(xmlParam);
		
		if (action == 'view')
		{
			//No need to display add and delete row buttons
			return;
		}

		var addElement = document.createElement('input');
		addElement.setAttribute('type', 'button');
		addElement.setAttribute((document.all ? 'className' : 'class'), "addButton");
		if(navigator.appName == "Microsoft Internet Explorer") {
			addElement.onclick = function(){addParamRow(type,tablePrefix);};
		} else {
			addElement.setAttribute('onclick', 'addParamRow(' + "'" + type + "'" +  ",'" +  tablePrefix + "'"  + ')');
		}

		colObj = rowObj.insertCell(-1);
		colObj.setAttribute((document.all ? 'className' : 'class'), styleClass);
		colObj.appendChild(addElement);
		
    	var deleteElement = document.createElement('input');
		deleteElement.setAttribute('id' ,  'deleteElement'+ rowId);
		deleteElement.setAttribute('name', 'deleteElement'+ rowId);
		deleteElement.setAttribute('type', 'button');
		deleteElement.setAttribute((document.all ? 'className' : 'class'), "deleteButton");
		if(navigator.appName == "Microsoft Internet Explorer") {
			deleteElement.onclick = function(){deleteParamRow(type,tablePrefix,rowId);};
			
		} else {
			deleteElement.setAttribute('onclick', 'deleteParamRow(' + "'" + type + "'" + ",'" +  tablePrefix + "'"  + ",'" +rowId + "'" + ')');
		}

		colObj = rowObj.insertCell(-1);
		colObj.setAttribute((document.all ? 'className' : 'class'), styleClass);
		colObj.appendChild(deleteElement);
	}
	
	function removeOptions(selectbox)
	{
		var i;
	    for(i=selectbox.options.length-1;i>=0;i--)
		{
			selectbox.remove(i);
	    }
	}
	
	function toggleMsgAddressingAliases(rowname, rowCount) 
	{
		var row = document.getElementById(rowname + rowCount);
		var url = row.value;
		var protocol = url.substr(0,url.indexOf(":"));
		try
		{	
			var msgAliasList = document.getElementById('responseMapMsgAliasRow' + rowCount);
			removeOptions(msgAliasList);

			if (protocol == "http")
			{
				var option;
				for(var index = 0; index < httpMsgAddressingAliases.length; index++) {
					option = document.createElement("option");
					option.text = httpMsgAddressingAliases[index];
					option.value = httpMsgAddressingAliases[index];
					msgAliasList.add(option);
				}
			}
			else if (protocol == "https")
			{
				var option;
				for(var index = 0; index < httpsMsgAddressingAliases.length; index++) {
					option = document.createElement("option");
					option.text = httpsMsgAddressingAliases[index];
					option.value = httpsMsgAddressingAliases[index];
					msgAliasList.add(option);
				}
			}
			else if (protocol == "jms")
			{
				var option;
				for(var index = 0; index < jmsMsgAddressingAliases.length; index++) {
					option = document.createElement("option");
					option.text = jmsMsgAddressingAliases[index];
					option.value = jmsMsgAddressingAliases[index];
					msgAliasList.add(option);
				}
			}
		}
		catch (e)
		{
		}
	}

	var	responseMapStyleClass = "oddcol";
	function editResponseMapRow(action, addressVal, msgAddressingAliasVal, transportTypeVal)
	{
		var tableName = "responseMapTable";
		if (disabledButtonResponseMap != null)
		{
				disabledButtonResponseMap.setAttribute((document.all ? 'className' : 'class'), "deleteButton");
				if(navigator.appName == "Microsoft Internet Explorer") {
					disabledButtonResponseMap.onclick = function(){deleteResponseMapRow(disabledButtonIDResponseMap);};
				} else {
					disabledButtonResponseMap.setAttribute('onclick', 'deleteResponseMapRow(' + "'" +disabledButtonIDResponseMap + "'" + ')');
				}
		}
		if (action == "view")
		{
			if (responseMapStyleClass == "evencol")
			{
				responseMapStyleClass = "oddcol";
			}
			else
			{
				responseMapStyleClass = "evencol";
			}
		}
		else 
		{
			responseMapStyleClass = "oddcol";
		}

		var tableObj = document.getElementById(tableName);
		var rowCount = tableObj.rows.length;

		//Create a row at the end 
		var rowObj = tableObj.insertRow(-1); 
		var rowId =  'responseMapRow' + rowCount; 

		rowObj.setAttribute((document.all ? 'className' : 'class'), responseMapStyleClass);
		rowObj.setAttribute('id', rowId);
		rowObj.setAttribute('name', rowId);
		
	
		//Add address 
		var address = document.createElement('input');
		address.setAttribute('id', 'responseMapAddressRow' + rowCount);
		address.setAttribute('name', 'responseMapAddress');
		address.setAttribute('style', 'width:100%');
		if(navigator.appName == "Microsoft Internet Explorer") {
			address.onchange = function(){toggleMsgAddressingAliases('responseMapAddressRow', rowCount);};
		} else {
			address.setAttribute('onchange', 'toggleMsgAddressingAliases(\'responseMapAddressRow\',' + rowCount +')');
		}

		colObj = rowObj.insertCell(-1);
		if (action == "view")
		{
			colObj.setAttribute((document.all ? 'className' : 'class'), responseMapStyleClass);
			colObj.innerHTML = addressVal;
		}
		else
		{
			colObj.setAttribute((document.all ? 'className' : 'class'), responseMapStyleClass + "-l");
			address.value = addressVal;
			colObj.appendChild(address);
		}
		
		
		//Message addressing alias dropdown
		var msgAddressingAlias = document.createElement('select');
		msgAddressingAlias.setAttribute('id', 'responseMapMsgAliasRow' + rowCount);
		msgAddressingAlias.setAttribute('name', 'responseMapMsgAlias');
		msgAddressingAlias.setAttribute('style', 'width:100%');

		colObj = rowObj.insertCell(-1);
		if (action == "view")
		{
			colObj.setAttribute((document.all ? 'className' : 'class'), responseMapStyleClass);
			colObj.innerHTML = msgAddressingAliasVal;
		}
		else
		{
			colObj.setAttribute((document.all ? 'className' : 'class'), responseMapStyleClass + "-l");
			if (transportTypeVal == "HTTP")
			{
				var option;
				for(var index = 0; index < httpMsgAddressingAliases.length; index++) {
					option = document.createElement("option");
					option.text = httpMsgAddressingAliases[index];
					option.value = httpMsgAddressingAliases[index];
					if (msgAddressingAliasVal == option.value)
					{
						option.selected = true;
					}
					msgAddressingAlias.add(option);
				}
			}
			else if (transportTypeVal == "HTTPS")
			{
				var option;
				for(var index = 0; index < httpsMsgAddressingAliases.length; index++) {
					option = document.createElement("option");
					option.text = httpsMsgAddressingAliases[index];
					option.value = httpsMsgAddressingAliases[index];
					if (msgAddressingAliasVal == option.value)
					{
						option.selected = true;
					}
					msgAddressingAlias.add(option);
				}
			}
			else if (transportTypeVal == "JMS")
			{
				var option;
				for(var index = 0; index < jmsMsgAddressingAliases.length; index++) {
					option = document.createElement("option");
					option.text = jmsMsgAddressingAliases[index];
					option.value = jmsMsgAddressingAliases[index];
					if (msgAddressingAliasVal == option.value)
					{
						option.selected = true;
					}
					msgAddressingAlias.add(option);
				}
			}
			colObj.appendChild(msgAddressingAlias);
		}

		if (action == "view")
		{
			return;
		}

		//Add Column
		var addElement = document.createElement('input');
		addElement.setAttribute('type', 'button');
		addElement.setAttribute((document.all ? 'className' : 'class'), "addButton");
		if(navigator.appName == "Microsoft Internet Explorer") {
			addElement.onclick = function(){addResponseMapRow();};
		} else {
			addElement.setAttribute('onclick', 'addResponseMapRow()');
		}

		colObj = rowObj.insertCell(-1);
		colObj.setAttribute((document.all ? 'className' : 'class'), responseMapStyleClass);
		colObj.appendChild(addElement);

		// Delete Column
    	var deleteElement = document.createElement('input');
		deleteElement.setAttribute('id' ,  'deleteElement'+ rowId);
		deleteElement.setAttribute('name', 'deleteElement'+ rowId);
		deleteElement.setAttribute('type', 'button');
		deleteElement.setAttribute((document.all ? 'className' : 'class'), "deleteButton");
		if(navigator.appName == "Microsoft Internet Explorer") {
			deleteElement.onclick = function(){deleteResponseMapRow(rowId);};
			
		} else {
			deleteElement.setAttribute('onclick', 'deleteResponseMapRow(' + "'" + rowId  + "'" + ')');
		}

		colObj = rowObj.insertCell(-1);
		colObj.setAttribute((document.all ? 'className' : 'class'), responseMapStyleClass);
		colObj.appendChild(deleteElement);
		
	}

	function addResponseMapRow() {
		var tableName = "responseMapTable";
		
		if (disabledButtonResponseMap != null)
		{
				disabledButtonResponseMap.setAttribute((document.all ? 'className' : 'class'), "deleteButton");
				if(navigator.appName == "Microsoft Internet Explorer") {
					disabledButtonResponseMap.onclick = function(){deleteResponseMapRow(disabledButtonIDResponseMap);};
				} else {
					disabledButtonResponseMap.setAttribute('onclick', 'deleteResponseMapRow(' + "'" +disabledButtonIDResponseMap + "'" + ')');
				}
		}
		
		responseMapStyleClass = "oddcol";

		var tableObj = document.getElementById(tableName);
		var rowCount = tableObj.rows.length;

		//Create a row at the end 
		var rowObj = tableObj.insertRow(-1); 
		var rowId =  'responseMapRow' + rowCount; 

		rowObj.setAttribute((document.all ? 'className' : 'class'), responseMapStyleClass);
		rowObj.setAttribute('id', rowId);
		rowObj.setAttribute('name', rowId);
		
	
		//Add address 
		var address = document.createElement('input');
		address.setAttribute('id', 'responseMapAddressRow' + rowCount);
		address.setAttribute('name', 'responseMapAddress');
		address.setAttribute('style', 'width:100%');
		if(navigator.appName == "Microsoft Internet Explorer") {
			address.onchange = function(){toggleMsgAddressingAliases('responseMapAddressRow', rowCount);};
		} else {
			address.setAttribute('onchange', 'toggleMsgAddressingAliases(\'responseMapAddressRow\',' + rowCount +')');
		}

		colObj = rowObj.insertCell(-1);
		colObj.setAttribute((document.all ? 'className' : 'class'), responseMapStyleClass + "-l");
		colObj.appendChild(address);
		
		//Message addressing alias dropdown
		var msgAddressingAlias = document.createElement('select');
		msgAddressingAlias.setAttribute('id', 'responseMapMsgAliasRow' + rowCount);
		msgAddressingAlias.setAttribute('name', 'responseMapMsgAlias');
		msgAddressingAlias.setAttribute('style', 'width:100%');
		
		var option = document.createElement("option"); 
		msgAddressingAlias.add(option);

		colObj = rowObj.insertCell(-1);
		colObj.setAttribute((document.all ? 'className' : 'class'), responseMapStyleClass + "-l");
		colObj.appendChild(msgAddressingAlias);
		
		
		//Add Column
		var addElement = document.createElement('input');
		addElement.setAttribute('type', 'button');
		addElement.setAttribute((document.all ? 'className' : 'class'), "addButton");
		if(navigator.appName == "Microsoft Internet Explorer") {
			addElement.onclick = function(){addResponseMapRow();};
		} else {
			addElement.setAttribute('onclick', 'addResponseMapRow()');
		}

		colObj = rowObj.insertCell(-1);
		colObj.setAttribute((document.all ? 'className' : 'class'), responseMapStyleClass);
		colObj.appendChild(addElement);

		// Delete Column
    	var deleteElement = document.createElement('input');
		deleteElement.setAttribute('id' ,  'deleteElement'+ rowId);
		deleteElement.setAttribute('name', 'deleteElement'+ rowId);
		deleteElement.setAttribute('type', 'button');
		deleteElement.setAttribute((document.all ? 'className' : 'class'), "deleteButton");
		if(navigator.appName == "Microsoft Internet Explorer") {
			deleteElement.onclick = function(){deleteResponseMapRow(rowId);};
			
		} else {
			deleteElement.setAttribute('onclick', 'deleteResponseMapRow(' + "'" + rowId  + "'" + ')');
		}

		colObj = rowObj.insertCell(-1);
		colObj.setAttribute((document.all ? 'className' : 'class'), responseMapStyleClass);
		colObj.appendChild(deleteElement);
	}


	function changeColumnProperties(wsetype)
	{
		var elem = document.getElementById("fromReplyToFaultToWSADiv");
		var rows = elem.rows;
		var clz;
		var cols;

		if(wsetype == "provider") {
			clz = "odd";
		}else if(wsetype == "consumer") {
			clz = "even";
		}
		else if(wsetype == "addressing") {
			clz = "odd";
		}
		else
			return;

		for(i = 0; i < rows.length; i++)
		{
			cols = rows[i].cells;
			cols[0].setAttribute((document.all ? 'className' : 'class'), clz+"row");
			clz = (clz == "even") ? "odd" : "even";
		}
	}

	/* 
	type = from, replyTo, faultTo
	tablePrefix = ReferenceParams, MetadataElements, Extensible
	*/
	
	
	function addParamRow(type, tablePrefix) 
	{
		var tableName = type + tablePrefix + 'Table';
		
		if(tablePrefix == 'ReferenceParams') {
			if (type == "from" && disabledButtonFromReferenceParams != null)
			{
				disabledButtonFromReferenceParams.setAttribute((document.all ? 'className' : 'class'), "deleteButton");
				if(navigator.appName == "Microsoft Internet Explorer") {
					disabledButtonFromReferenceParams.onclick = function(){deleteParamRow(type,tablePrefix,disabledButtonIDFromReferenceParams);};
				} else {
					disabledButtonFromReferenceParams.setAttribute('onclick', 'deleteParamRow(' + "'" +  type + "'"  + ",'" +  tablePrefix + "'"  + ",'" +disabledButtonIDFromReferenceParams + "'"+')');
				}
			}
			else if (type == "replyTo" && disabledButtonReplyToReferenceParams != null)
			{
				disabledButtonReplyToReferenceParams.setAttribute((document.all ? 'className' : 'class'), "deleteButton");
				if(navigator.appName == "Microsoft Internet Explorer") {
					disabledButtonReplyToReferenceParams.onclick = function(){deleteParamRow(type,tablePrefix,disabledButtonIDReplyToReferenceParams);};
				} else {
					disabledButtonReplyToReferenceParams.setAttribute('onclick', 'deleteParamRow(' + "'" +  type + "'"  + ",'" +  tablePrefix + "'"  + ",'" +disabledButtonIDReplyToReferenceParams + "'"+')');
				}
			}
			else if (type == "faultTo" && disabledButtonFaultToReferenceParams != null)
			{
				disabledButtonFaultToReferenceParams.setAttribute((document.all ? 'className' : 'class'), "deleteButton");
				if(navigator.appName == "Microsoft Internet Explorer") {
					disabledButtonFaultToReferenceParams.onclick = function(){deleteParamRow(type,tablePrefix,disabledButtonIDFaultToReferenceParams);};
				} else {
					disabledButtonFaultToReferenceParams.setAttribute('onclick', 'deleteParamRow(' + "'" +  type + "'"  + ",'" +  tablePrefix + "'"  + ",'" +disabledButtonIDFaultToReferenceParams + "'"+')');
				}
			}
			else if (type == "to" && disabledButtonToReferenceParams != null)
			{
				disabledButtonToReferenceParams.setAttribute((document.all ? 'className' : 'class'), "deleteButton");
				if(navigator.appName == "Microsoft Internet Explorer") {
					disabledButtonToReferenceParams.onclick = function(){deleteParamRow(type,tablePrefix,disabledButtonIDToReferenceParams);};
				} else {
					disabledButtonToReferenceParams.setAttribute('onclick', 'deleteParamRow(' + "'" +  type + "'"  + ",'" +  tablePrefix + "'"  + ",'" +disabledButtonIDToReferenceParams + "'"+')');
				}
			}
		}
		else if(tablePrefix == 'MetadataElements') {
			if (type == "from" && disabledButtonFromMetadataElements != null)
			{
				disabledButtonFromMetadataElements.setAttribute((document.all ? 'className' : 'class'), "deleteButton");
				if(navigator.appName == "Microsoft Internet Explorer") {
					disabledButtonFromMetadataElements.onclick = function(){deleteParamRow(type,tablePrefix,disabledButtonIDFromMetadataElements);};
				} else {
					disabledButtonFromMetadataElements.setAttribute('onclick', 'deleteParamRow(' + "'" +  type + "'"  + ",'" + tablePrefix + "'"  + ",'" + disabledButtonIDFromMetadataElements + "'"+')');
				}
			}
			else if (type == "replyTo" && disabledButtonReplyToMetadataElements != null)
			{
				disabledButtonReplyToMetadataElements.setAttribute((document.all ? 'className' : 'class'), "deleteButton");
				if(navigator.appName == "Microsoft Internet Explorer") {
					disabledButtonReplyToMetadataElements.onclick = function(){deleteParamRow(type,tablePrefix,disabledButtonIDReplyToMetadataElements);};
				} else {
					disabledButtonReplyToMetadataElements.setAttribute('onclick', 'deleteParamRow(' + "'" +  type + "'"  + ",'" + tablePrefix + "'"  + ",'" + disabledButtonIDReplyToMetadataElements + "'"+')');
				}
			}
			else if (type == "faultTo" && disabledButtonFaultToMetadataElements != null)
			{
				disabledButtonFaultToMetadataElements.setAttribute((document.all ? 'className' : 'class'), "deleteButton");
				if(navigator.appName == "Microsoft Internet Explorer") {
					disabledButtonFaultToMetadataElements.onclick = function(){deleteParamRow(type,tablePrefix,disabledButtonIDFaultToMetadataElements);};
				} else {
					disabledButtonFaultToMetadataElements.setAttribute('onclick', 'deleteParamRow(' + "'" +  type + "'"  + ",'" + tablePrefix + "'"  + ",'" + disabledButtonIDFaultToMetadataElements + "'"+')');
				}
			}
			else if (type == "to" && disabledButtonToMetadataElements != null)
			{
				disabledButtonToMetadataElements.setAttribute((document.all ? 'className' : 'class'), "deleteButton");
				if(navigator.appName == "Microsoft Internet Explorer") {
					disabledButtonToMetadataElements.onclick = function(){deleteParamRow(type,tablePrefix,disabledButtonIDToMetadataElements);};
				} else {
					disabledButtonToMetadataElements.setAttribute('onclick', 'deleteParamRow(' + "'" +  type + "'"  + ",'" + tablePrefix + "'"  + ",'" + disabledButtonIDToMetadataElements + "'"+')');
				}
			}
		}	
		else if(tablePrefix == 'Extensible') {
			if (type == "from" && disabledButtonFromExtensible != null)
			{
				disabledButtonFromExtensible.setAttribute((document.all ? 'className' : 'class'), "deleteButton");
				if(navigator.appName == "Microsoft Internet Explorer") {
					disabledButtonFromExtensible.onclick = function(){deleteParamRow(type,tablePrefix,disabledButtonIDFromExtensible);};
				} else {
					disabledButtonFromExtensible.setAttribute('onclick', 'deleteParamRow(' + "'" +  type + "'"  + ",'" +  tablePrefix + "'"  + ",'" +disabledButtonIDFromExtensible + "'"+')');
				}
			}
			else if (type == "replyTo" && disabledButtonReplyToExtensible != null)
			{
				disabledButtonReplyToExtensible.setAttribute((document.all ? 'className' : 'class'), "deleteButton");
				if(navigator.appName == "Microsoft Internet Explorer") {
					disabledButtonReplyToExtensible.onclick = function(){deleteParamRow(type,tablePrefix,disabledButtonIDReplyToExtensible);};
				} else {
					disabledButtonReplyToExtensible.setAttribute('onclick', 'deleteParamRow(' + "'" +  type + "'"  + ",'" +  tablePrefix + "'"  + ",'" +disabledButtonIDReplyToExtensible + "'"+')');
				}
			}
			else if (type == "faultTo" && disabledButtonFaultToExtensible != null)
			{
				disabledButtonFaultToExtensible.setAttribute((document.all ? 'className' : 'class'), "deleteButton");
				if(navigator.appName == "Microsoft Internet Explorer") {
					disabledButtonFaultToExtensible.onclick = function(){deleteParamRow(type,tablePrefix,disabledButtonIDFaultToExtensible);};
				} else {
					disabledButtonFaultToExtensible.setAttribute('onclick', 'deleteParamRow(' + "'" +  type + "'"  + ",'" +  tablePrefix + "'"  + ",'" +disabledButtonIDFaultToExtensible + "'"+')');
				}
			}
			else if (type == "to" && disabledButtonToExtensible != null)
			{
				disabledButtonToExtensible.setAttribute((document.all ? 'className' : 'class'), "deleteButton");
				if(navigator.appName == "Microsoft Internet Explorer") {
					disabledButtonToExtensible.onclick = function(){deleteParamRow(type,tablePrefix,disabledButtonIDToExtensible);};
				} else {
					disabledButtonToExtensible.setAttribute('onclick', 'deleteParamRow(' + "'" +  type + "'"  + ",'" +  tablePrefix + "'"  + ",'" +disabledButtonIDToExtensible + "'"+')');
				}
			}
		}
		
		var	styleClass = "oddcol";
		var tableObj = document.getElementById(tableName);
		var rowCount = tableObj.rows.length;

		//Create a row at the end 
		var rowObj = tableObj.insertRow(-1); 
		var rowId =  type + tablePrefix + 'row' + rowCount; 

		rowObj.setAttribute((document.all ? 'className' : 'class'), styleClass);
		rowObj.setAttribute('id', rowId);
		rowObj.setAttribute('name', rowId);
		
	
		//Add XML Input Parameter column
		var xmlParam = document.createElement('textarea');
		xmlParam.setAttribute('id', type + tablePrefix + rowCount);
		xmlParam.setAttribute('name', type + tablePrefix);
		xmlParam.setAttribute('rows', '1');
		xmlParam.setAttribute('cols', '40');
		xmlParam.setAttribute('style', 'width:100%');

		colObj = rowObj.insertCell(-1);
		colObj.setAttribute((document.all ? 'className' : 'class'), styleClass + "-l");
		colObj.appendChild(xmlParam);
		
		var addElement = document.createElement('input');
		addElement.setAttribute('type', 'button');
		addElement.setAttribute((document.all ? 'className' : 'class'), "addButton");
		if(navigator.appName == "Microsoft Internet Explorer") {
			addElement.onclick = function(){addParamRow(type,tablePrefix);};
		} else {
			addElement.setAttribute('onclick', 'addParamRow(' + "'" + type + "'" +  ",'" +  tablePrefix + "'"  + ')');
		}

		colObj = rowObj.insertCell(-1);
		colObj.setAttribute((document.all ? 'className' : 'class'), styleClass);
		colObj.appendChild(addElement);
		
    	var deleteElement = document.createElement('input');
		deleteElement.setAttribute('id' ,  'deleteElement'+ rowId);
		deleteElement.setAttribute('name', 'deleteElement'+ rowId);
		deleteElement.setAttribute('type', 'button');
		deleteElement.setAttribute((document.all ? 'className' : 'class'), "deleteButton");
		if(navigator.appName == "Microsoft Internet Explorer") {
			deleteElement.onclick = function(){deleteParamRow(type,tablePrefix,rowId);};
			
		} else {
			deleteElement.setAttribute('onclick', 'deleteParamRow(' + "'" + type + "'" + ",'" +  tablePrefix + "'"  + ",'" +rowId + "'" + ')');
		}

		colObj = rowObj.insertCell(-1);
		colObj.setAttribute((document.all ? 'className' : 'class'), styleClass);
		colObj.appendChild(deleteElement);
	}
	
	
		
	var hiddenOptions = new Array();
	
	function setupKeystoreDataForAddressing() {
		// For JMS consumer endpoint, there is no option for transport keystore alias 
		var isTKA = false; 

		if ( document.addform.transportKeyStoreAlias != null )
		{
			isTKA = true;
		}

		%invoke wm.server.security.keystore:listKeyStoresAndConfiguredKeyAliases%
			var ks2 = document.addform.transportKeyStoreAlias.options;

			//Blank KS and ALIAS combination
			ks2.length=ks2.length+1;
			ks2[ks2.length-1] = new Option("","");

			var aliases = new Array();
			aliases[0]= new Option("","");
			hiddenOptions[ks2.length-1] = aliases;

			%loop keyStoresAndConfiguredKeyAliases%
				ks2.length=ks2.length+1;
				ks2[ks2.length-1] = new Option("%value keyStoreName%","%value keyStoreName%");
				var aliases = new Array();
				%loop keyAliases%
					aliases[%value $index%] = new Option("%value%","%value%");
				%endloop%
				if (aliases.length == 0) {
					aliases[0] = new Option("","");
				}
				hiddenOptions[ks2.length-1] = aliases;
			%endloop%
		%endinvoke%

		if ( isTKA) {
			var keyOpts = document.addform.transportKeyStoreAlias.options;
			var key = document.addform.selectedTransportKS.value;
			if ( key != "") {
				for(var i=0; i<keyOpts.length; i++) {
					if(key == keyOpts[i].value) {
						keyOpts[i].selected = true;
					}
				}
			}

			changeval("transportKeyStoreAlias");

			var aliasOpts = document.addform.transportPrivateKeyAlias.options;
			var alias =  document.addform.selectedTransportKA.value;
			if ( alias != "") {
				for(var i=0; i<aliasOpts.length; i++) {
					if(alias == aliasOpts[i].value) {
						aliasOpts[i].selected = true;
					}
				}
			}
		}
		return true;
	}
	
	function setupMsgAddressingAlias() {
		var httpIdx = 0;
		var httpsIdx = 0;
		var jmsIdx = 0;

		%invoke wm.server.ws:listAllMessageAddressingEndpoints%
			%loop endpoints%
				%ifvar transportInfo/transportType equals('HTTP')%
					httpMsgAddressingAliases[httpIdx] = '%value alias%';
					httpIdx = httpIdx + 1;
				%endif%
				%ifvar transportInfo/transportType equals('HTTPS')%
					httpsMsgAddressingAliases[httpsIdx] ='%value alias%';
					httpsIdx = httpsIdx + 1;
				%endif%
				%ifvar transportInfo/transportType equals('JMS')%
					jmsMsgAddressingAliases[jmsIdx] = '%value alias%';
					jmsIdx = jmsIdx + 1;
				%endif%
			%endloop%
		%endinvoke%
		alert(httpMsgAddressingAliases.length);
	}

	function setupKeystoreDataForProvider() {
		%invoke wm.server.security.keystore:listKeyStoresAndConfiguredKeyAliases%
			var ks2 = document.addform.messageKeyStoreAlias.options;

			//Blank KS and ALIAS combination
			ks2.length=ks2.length+1;
			ks2[ks2.length-1] = new Option("","");

			var aliases = new Array();
			aliases[0]= new Option("","");
			hiddenOptions[ks2.length-1] = aliases;

			%loop keyStoresAndConfiguredKeyAliases%
				ks2.length=ks2.length+1;
				ks2[ks2.length-1] = new Option("%value keyStoreName%","%value keyStoreName%");
		    	var aliases = new Array();
		   		%loop keyAliases%
		    		aliases[%value $index%] = new Option("%value%","%value%");
		    	%endloop%
		    	if (aliases.length == 0) {
					aliases[0] = new Option("","");
				}
				hiddenOptions[ks2.length-1] = aliases;
			%endloop%
		%endinvoke%

		var keyOpts = document.addform.messageKeyStoreAlias.options;
		var key = document.addform.selectedMsgKS.value;
		if ( key != "") {
			for(var i=0; i<keyOpts.length; i++) {
				if(key == keyOpts[i].value) {
					keyOpts[i].selected = true;
				}
			}
		}

		changeval("messageKeyStoreAlias");

		var aliasOpts = document.addform.messagePrivateKeyAlias.options;
		var alias =  document.addform.selectedMsgKA.value;
		if ( alias != "") {
			for(var i=0; i<aliasOpts.length; i++) {
				if(alias == aliasOpts[i].value) {
					aliasOpts[i].selected = true;
				}
			}
		}

		return true;
	}
	
	function loadProxyAliasOptions(transportType)
	{
		var proxyAliasOpts = document.addform.proxyAlias.options;
		proxyAliasOpts.length = 0;
		proxyAliasOpts.length = proxyAliasOpts.length + 1;
		proxyAliasOpts[proxyAliasOpts.length-1] = new Option("","");

		%invoke wm.server.proxy:getProxyServerList%
			%loop -struct proxyServerList%
				%scope #$key%
					if (transportType == "%value protocol%") {
						proxyAliasOpts.length = proxyAliasOpts.length + 1;
						proxyAliasOpts[proxyAliasOpts.length-1] = new Option("%value proxyAlias%","%value proxyAlias%");
					}
				%endscope%
			%endloop%
		%endinvoke%

		var alias =  document.addform.selectedProxyAlias.value;
		if ( alias != "") {
			for(var i=0; i<proxyAliasOpts.length; i++) {
				if(alias == proxyAliasOpts[i].value) {
					proxyAliasOpts[i].selected = true;
				}
			}
		}
	}
	
	
	
	function setupKeystoreData()
	{
		var isTKA = false; // For JMS consumer endpoint, there is no option for transport keystore alias 

		if ( document.addform.transportKeyStoreAlias != null )
		{
			isTKA = true;
		}

		%invoke wm.server.security.keystore:listKeyStoresAndConfiguredKeyAliases%
			
			var ks2 = document.addform.messageKeyStoreAlias.options;

			//Blank KS and ALIAS combination
			if ( isTKA) {
				var ks1 = document.addform.transportKeyStoreAlias.options;
				ks1.length=ks1.length+1;
				ks1[ks1.length-1] = new Option("","");
			}

			ks2.length=ks2.length+1;
			ks2[ks2.length-1] = new Option("","");

			var aliases = new Array();
			aliases[0]= new Option("","");
			hiddenOptions[ks2.length-1] = aliases;

			%loop keyStoresAndConfiguredKeyAliases%
				ks2.length=ks2.length+1;
				
				if ( isTKA) {
					ks1.length=ks1.length+1;
					ks1[ks1.length-1] = new Option("%value keyStoreName%","%value keyStoreName%");
				}
				ks2[ks2.length-1] = new Option("%value keyStoreName%","%value keyStoreName%");

				var aliases = new Array();
				%loop keyAliases%
					aliases[%value $index%] = new Option("%value%","%value%");
				%endloop%
				if (aliases.length == 0) {
					aliases[0] = new Option("","");
				}
				hiddenOptions[ks2.length-1] = aliases;
			%endloop%
		%endinvoke%


		if ( isTKA) {
			var keyOpts = document.addform.transportKeyStoreAlias.options;
			var key = document.addform.selectedTransportKS.value;
			if ( key != "") {
				for(var i=0; i<keyOpts.length; i++) {
					if(key == keyOpts[i].value) {
						keyOpts[i].selected = true;
					}
				}
			}

			changeval("transportKeyStoreAlias");

			var aliasOpts = document.addform.transportPrivateKeyAlias.options;
			var alias =  document.addform.selectedTransportKA.value;
			if ( alias != "") {
				for(var i=0; i<aliasOpts.length; i++) {
					if(alias == aliasOpts[i].value) {
						aliasOpts[i].selected = true;
					}
				}
			}
		}

		var keyOpts = document.addform.messageKeyStoreAlias.options;
		var key = document.addform.selectedMsgKS.value;
		if ( key != "") {
			for(var i=0; i<keyOpts.length; i++) {
				if(key == keyOpts[i].value) {
					keyOpts[i].selected = true;
				}
			}
		}
		changeval("messageKeyStoreAlias");

		var aliasOpts = document.addform.messagePrivateKeyAlias.options;
		var alias =  document.addform.selectedMsgKA.value;
		if ( alias != "") {
			for(var i=0; i<aliasOpts.length; i++) {
				if(alias == aliasOpts[i].value) {
					aliasOpts[i].selected = true;
				}
			}
		}

		return true;
	}

	function changeval(field) {

		var ks = "";
		if ( field == "transportKeyStoreAlias")
			ks = document.addform.transportKeyStoreAlias.options;
		else
			ks = document.addform.messageKeyStoreAlias.options;

		var selectedKS =  "";
		if ( field == "transportKeyStoreAlias")
			selectedKS = document.addform.transportKeyStoreAlias.value;
		else
			selectedKS = document.addform.messageKeyStoreAlias.value;

		for(var i=0; i<ks.length; i++) {
			if(selectedKS == ks[i].value) {
				var aliases = hiddenOptions[i];
				if ( field == "transportKeyStoreAlias")
					document.addform.transportPrivateKeyAlias.options.length = aliases.length;
				else
					document.addform.messagePrivateKeyAlias.options.length = aliases.length;

				for(var j=0;j<aliases.length;j++) {
					var opt = aliases[j];
					if ( field == "transportKeyStoreAlias")
						document.addform.transportPrivateKeyAlias.options[j] = new Option(opt.text, opt.value);
					else
						document.addform.messagePrivateKeyAlias.options[j] = new Option(opt.text, opt.value);
				}
			}
		}
	}

	function isIntegerGreaterThanZero (value)
	{
		var a = parseFloat ( value );
		b = a % 1;
		if ( a > 0  && b == 0)	
		{
			return true;
		}
		return false;
	}

	function isPositiveInteger(value){
		for (var i = 0; i < value.length; i++) {
			var ch = value.charAt(i)
			if (ch < "0" || ch > "9") {
				return false
			}
		}
		return true;
	}

	function confirmEdit()
	{
		%ifvar transportType equals('JMS')%
			var reqfield;
			var error;
			%ifvar type equals('consumer')%
				if(document.addform.jmsAliasType[0].checked) {
					// JMS Consumer with JMS Alias
					reqfield = document.addform.jndiProvAlias;
					error = "No JMS Connection Alias have been defined.";
				} else {
					// JMS Consumer with JNDI Alias
					reqfield = document.addform.jmsConnAlias;
					error = "No JNDI Provider Alias have been defined.";
				}
			%else%
				reqfield = document.addform.jmsTriggerName;
				error = "No SOAP-JMS Triggers have been defined.";
				var ttl = document.addform.timeToLive.value;
				if(ttl != null && ttl != "") {
					if(!isPositiveInteger(ttl)) {
						alert ("A number must be provided for Time to Live.");
						return false;
					}
				}
			%endif%
			if(reqfield == null) {
				alert(error);
				return false;
			}
			if(reqfield.value == '') {
				alert(error);
				return false;
			}

			var trigger = reqfield.value;
			if (trigger == "ws endpoint trigger")
			{
				trigger = "wm.namespace.ws:wseTrigger_" + document.addform.alias.value;
				var options = document.addform.jmsTriggerName.options;
				for (i = 0; i < options.length; i++)
				{
					if (options[i].selected && options[i].value == "ws endpoint trigger")
					{
						options[i].value = trigger;
					}
				}
			}
		%else%
			%ifvar type equals('provider')%
				if ((document.addform.host.value == "") || (document.addform.port.value == "")) {
					alert ("You must specify host and port for the Provider web service endpoint.");
					return false;
				}
			%endif%

			if (! checkLegalHostName (document.addform.host, "Host") ) {
				return false;
			}
			if (document.addform.port.value != "" && !isIntegerGreaterThanZero (document.addform.port.value)) {
				alert ("The port number must be an integer greater than zero.");
				return false;
			}
			
			%ifvar type equals('addressing')%
			%else%
				if (document.addform.messageTimestampTimeToLive.value != "" && !isIntegerGreaterThanZero(document.addform.messageTimestampTimeToLive.value)) {
					alert ("The 'Timestamp Time To Live' must be an integer greater than zero.");
					return false;
				}
				
				if (document.addform.messageTimestampMaximumSkew.value != "" && !isPositiveInteger(document.addform.messageTimestampMaximumSkew.value)) {
					alert ("The 'Timestamp Maximum Skew' must be a positive integer.");
					return false;
				}
			%endif%
				
			%ifvar type equals('consumer')%
				if( !confirmPassword(document.addform.transportPassword.value, document.addform.retype_transportPassword.value, "Transport")
					&& !confirmPassword(document.addform.messagePassword.value, document.addform.retype_messagePassword.value, "Message")
					) {
					return false;
				}
			%endif%
			
			%ifvar type equals('addressing')%
			%else%
				var rmEnabled = document.getElementById("enable");
				if (rmEnabled.checked)
				{
					rmEnabled.value = "true";
				}
				else
				{
					rmEnabled.checked = true;
					rmEnabled.value = "false";
				}
				enableRMProperties();
			%endif%
		%endif%
		
		var soapRoleOptions =  document.getElementById("soapRoleOptions"); 
		var soapRoleInputField = document.getElementById("soapRoleInputField"); 

		if(soapRoleOptions.selectedIndex != 3)
		{
			document.getElementById("soapRole").value = soapRoleOptions.value;
		}
		else 
		{
			soapRoleInputField.value = trim(soapRoleInputField.value);
			document.getElementById("soapRole").value = soapRoleInputField.value;
		}

		document.addform.submit();
		return true;
	}

	
	function confirmAdd() {
		if (document.addform.transType[0].checked) {
			document.addform.transportType.value = document.addform.transType[0].value;
		}
		else if (document.addform.transType[1].checked) {
			document.addform.transportType.value = document.addform.transType[1].value;
		}
		else if (document.addform.transType[2].checked) {
			document.addform.transportType.value = document.addform.transType[2].value;
		}

		if (document.addform.wsetype[0].checked) {
			document.addform.type.value = document.addform.wsetype[0].value;
		} else if (document.addform.wsetype[1].checked){
			document.addform.type.value = document.addform.wsetype[1].value;
		}
		else
			document.addform.type.value = document.addform.wsetype[2].value;

		if (! checkLegalName (document.addform.alias, "Alias") ) {
			return false;
		}

		if(document.addform.transType[2].checked) {
			var aliasStr = document.addform.alias.value;

			if (aliasStr == null || aliasStr == "" || aliasStr.length <= 0) {
				alert ("You must specify alias for the web service endpoint.");
				return false;
			}
			if (document.addform.wsetype[0].checked) {
				var reqfield = document.addform.jmsTriggerName;
				if(reqfield == null) {
					alert ("No SOAP-JMS Triggers have been defined.");
					return false;
				}
				var trigger = reqfield.value;
				if (trigger == null || trigger == "" || trigger.length <= 0) {
					alert ("No SOAP-JMS Triggers have been defined.");
					return false;
				}
				var ttl = document.addform.timeToLive.value;
				if(ttl != null && ttl != "") {
					if(!isPositiveInteger(ttl)) {
						alert ("A number must be provided for Time to Live.");
						return false;
					}
				}
				if (trigger == "ws endpoint trigger")
				{
					trigger = "wm.namespace.ws:wseTrigger_" + document.addform.alias.value;
					var options = document.addform.jmsTriggerName.options;
					for (i = 0; i < options.length; i++)
					{
						if (options[i].selected && options[i].value == "ws endpoint trigger")
						{
							options[i].value = trigger;
						}
					}
				}

			} else {
				if (document.addform.jmsAliasType[0].checked) {
					var jndiAlias = document.addform.jndiProvAlias.value;
					if (jndiAlias == null || jndiAlias == "" || jndiAlias.length <= 0) {
						alert ("No JNDI Provider Alias specified.");
						return false;
					}
				} else {
					var jmsAlias = document.addform.jmsConnAlias.value;
					if (jmsAlias == null || jmsAlias == "" || jmsAlias.length <= 0) {
						alert ("No JMS Connection Alias specified.");
						return false;
					}
				}
			}
		} else {
			if ((document.addform.alias.value == "")) {
				alert ("You must specify alias for the web service endpoint.");
				return false;
			} else if( document.addform.type.value  == "provider" && ((document.addform.host.value == "") || (document.addform.port.value == ""))) {
				alert ("You must specify host and port for the Provider web service endpoint.");
				return false;
			} else if (! checkLegalHostName (document.addform.host, "Host") ) {
				return false;
			} else {
				if ( document.addform.type.value  == "consumer") {

					if(!confirmPassword(document.addform.transportPassword.value, document.addform.retype_transportPassword.value, "Transport")
						|| !confirmPassword(document.addform.messagePassword.value, document.addform.retype_messagePassword.value, "Message") ) {
						return false;
					}
				}

			  if (document.addform.port.value != "" && !isIntegerGreaterThanZero (document.addform.port.value)) {
					alert ("The port number must be an integer greater than zero.");
					return false;
				}
				
  			if (document.addform.messageTimestampTimeToLive.value != "" && !isIntegerGreaterThanZero(document.addform.messageTimestampTimeToLive.value)) {
  				alert ("The 'Timestamp Time To Live' must be an integer greater than zero.");
  				return false;
  			}
  			
  			if (document.addform.messageTimestampMaximumSkew.value != "" && !isPositiveInteger(document.addform.messageTimestampMaximumSkew.value)) {
  				alert ("The 'Timestamp Maximum Skew' must be a positive integer.");
  				return false;
  			}
			}
		}

		var soapRoleOptions =  document.getElementById("soapRoleOptions"); 
		var soapRoleInputField = document.getElementById("soapRoleInputField"); 

		if(soapRoleOptions.selectedIndex != 3)
		{
			document.getElementById("soapRole").value = soapRoleOptions.value;
		}
		else 
		{
			soapRoleInputField.value = trim(soapRoleInputField.value);
			document.getElementById("soapRole").value = soapRoleInputField.value;
		}
		
		var rmEnabled = document.getElementById("enable");
		if (rmEnabled.checked)
		{
			rmEnabled.value = "true";
		}
		else
		{
			rmEnabled.checked = true;
			rmEnabled.value = "false";
		}
		enableRMProperties();
		document.addform.submit();
		return true;
	}

	function checkLegalName(field, fieldName) {
		var name = field.value;
		var illegalChars = "- #&@^!%*:$./\\`;,~+=)(|}{][><\"";

		for (var i=0; i<illegalChars.length; i++) {
			if (name.indexOf(illegalChars.charAt(i)) >= 0) {
				alert ("Web Service Endpoint alias contains illegal character: '" + illegalChars.charAt(i) + "'");
				return false;
			}
		}

		return true;
	}


	function checkLegalHostName(field, fieldName) {
		var name = field.value;
		var illegalChars = " #&@^!%$/\\`;,~+=)(|}{][><\"";

		for (var i=0; i<illegalChars.length; i++) {
			if (name.indexOf(illegalChars.charAt(i)) >= 0) {
				alert ("Web Service Endpoint HostName contains illegal character: '" + illegalChars.charAt(i) + "'");
				return false;
			}
		}

		return true;
	}

	function confirmPassword(original, retyped, type) {
		if (original.length > 0 && retyped.length == 0) {
			alert (type + " password must be retyped for confirmation.");
			return false;
		} else if (original != retyped) {
			alert ("The " + type + " passwords entered do not match.");
			return false;
		}
		return true;
	}

	var agent = navigator.userAgent.toLowerCase();
	var ie = (agent.indexOf("msie") != -1);


	function displayRows(elementID)
	{
		elem = document.getElementById(elementID);
		rows = elem.rows;

		for(i = 0; i < rows.length; i++){
			if (ie) {
				rows[i].style.display="block";
			}else{
				rows[i].style.display="block";
				rows[i].style.display="table-row";
			}
		}
	}

	function hideRows(elementID)
	{
		elem = document.getElementById(elementID);
		rows = elem.rows;

		for(i = 0; i < rows.length; i++){
			rows[i].style.display="none";
		}
	}

	function togglePropertiesAtOnLoad(aliasType, transType)
	{	
		if(aliasType == "provider") {
			document.addform.wsetype[0].checked = true;
			document.addform.wsetype[1].checked = false;
		} else {
			document.addform.wsetype[0].checked = false;
			document.addform.wsetype[1].checked = true;
		}
		
		if(transType == "HTTP") {
			document.addform.transType[0].checked = true;
			document.addform.transType[1].checked = false;
			document.addform.transType[2].checked = false;
		} else if(transType == "HTTPS") {
			document.addform.transType[0].checked = false;
			document.addform.transType[1].checked = true;
			document.addform.transType[2].checked = false;
		} else {
			document.addform.transType[0].checked = false;
			document.addform.transType[1].checked = false;
			document.addform.transType[2].checked = true;
		}
		toggleProperties("wsetype");
	}



	function toggleJMSorJNDI() {
		jndi = document.addform.jmsAliasType[0].checked;

		var elem;
		if(jndi) {
			displayRows("consumerJMSDivJNDI");
			hideRows("consumerJMSDivJMS");
		} else {
			displayRows("consumerJMSDivJMS");
			hideRows("consumerJMSDivJNDI");
		}
	}

	function hideAllToBegin() {
		hideRows("transportHTTPDiv");
		hideRows("provConsHTTPDiv");
		hideRows("consumerHTTPDiv");
		hideRows("consumerHTTPSDiv");
		hideRows("transportJMSDiv");
		hideRows("providerJMSDiv");
		hideRows("consumerJMSDiv");
		hideRows("consumerJMSDivJNDI");
		hideRows("consumerJMSDivJMS");
		hideRows("usernameMsgDiv");
		hideRows("muRoleWSADiv");
		hideRows("fromReplyToFaultToWSADiv");
		hideRows("toWSADiv");
		hideRows("responseMapWSADiv");
		hideRows("eprAddressDiv");
		hideRows("eprMetadataDiv");
		hideRows("eprExtensibleDiv");
		hideRows('WSRMPropDiv');
		hideRows("executeACLDiv");
	}

	function showWSSecurityProperties(type) {
		displayRows("spacerMsgDiv");
		displayRows("headerMsgDiv");
		if (type == "provider")
		{
			hideRows("usernameMsgDiv");
			hideRows("partnerCertMsgDiv");
			displayRows("keystoreMsgDiv");
			displayRows("truststoreMsgDiv");
			displayRows("timestampMsgDiv");

		}
		else if (type == "addressing") 
		{
			hideRows("usernameMsgDiv");
			displayRows("partnerCertMsgDiv");
			displayRows("keystoreMsgDiv");
			hideRows("truststoreMsgDiv");
			displayRows("timestampMsgDiv");
			
		}
		else {
			displayRows("usernameMsgDiv");
			displayRows("partnerCertMsgDiv");
			displayRows("keystoreMsgDiv");
			displayRows("truststoreMsgDiv");
			displayRows("timestampMsgDiv");
		}
	}
	
	

	function toggleProperties(caller) {
		
		hideAllToBegin();
		
		provider = document.addform.wsetype[0].checked;
		consumer = document.addform.wsetype[1].checked;
		addressing = document.addform.wsetype[2].checked;

		http = document.addform.transType[0].checked;
		https = document.addform.transType[1].checked;
		jms = document.addform.transType[2].checked;

		if(provider) {
			displayRows("toWSADiv");
			displayRows("responseMapWSADiv");
			hideRows("muRoleWSADiv");
			hideRows("fromReplyToFaultToWSADiv");
			hideRows("eprAddressDiv");
			displayRows("eprMetadataDiv");
			displayRows("eprExtensibleDiv");
			if(http || https) {
				displayRows("WSRMPropDiv");
				displayRows("transportHTTPDiv");
				displayRows("provConsHTTPDiv");
				showWSSecurityProperties("provider");
				if (http) {
					document.getElementById('httpTransportHeader').innerHTML = "HTTP";
					document.getElementById('httpTransportHeaderOpt').innerHTML = "";
				}
				else {
					document.getElementById('httpTransportHeader').innerHTML = "HTTPS";
					document.getElementById('httpTransportHeaderOpt').innerHTML = "";
				}
			} else if(jms) {
				displayRows("transportJMSDiv");
				displayRows("providerJMSDiv");
				showWSSecurityProperties("provider");
			}
			hideRows("usernameMsgDiv");
		} else if(consumer || addressing) {
			hideRows("responseMapWSADiv");
			displayRows("muRoleWSADiv");
			displayRows("eprAddressDiv");

			if (consumer && (http || https))
			{
				displayRows("WSRMPropDiv");
			}

			if (consumer)
			{
				displayRows("executeACLDiv");
				displayRows("provConsHTTPDiv");
				displayRows("fromReplyToFaultToWSADiv");
				displayRows("toWSADiv");
				showWSSecurityProperties("consumer");
			}
			else
			{
				hideRows("executeACLDiv");
				displayRows("fromReplyToFaultToWSADiv");
				hideRows("toWSADiv");
				hideRows("provConsHTTPDiv");
				showWSSecurityProperties("addressing");
			}
			if(http) {
				document.getElementById('httpTransportHeader').innerHTML = "HTTP";
				document.getElementById('httpTransportHeaderOpt').innerHTML = "&nbsp;(optional)";
				displayRows("transportHTTPDiv");
				displayRows("consumerHTTPDiv");
				loadProxyAliasOptions('HTTP');
			} else if (https) {
				document.getElementById('httpTransportHeader').innerHTML = "HTTPS";
				document.getElementById('httpTransportHeaderOpt').innerHTML = "&nbsp;(optional)";
				displayRows("transportHTTPDiv");
				displayRows("consumerHTTPDiv");
				displayRows("consumerHTTPSDiv");
				loadProxyAliasOptions('HTTPS');
			} else if(jms) {
				displayRows("transportJMSDiv");
				displayRows("consumerJMSDiv");
				toggleJMSorJNDI();
			}
		}
		if(provider) {
			changeColumnProperties('provider');
		}
		else if(consumer) {
			changeColumnProperties('consumer');
		}
		else if (addressing)
		{
			changeColumnProperties('addressing');
		}
	}
    </SCRIPT>

    <base target="_self">
	<style>
	  .listbox  { width: 100%; }
	</style>
  </HEAD>

  %ifvar action equals('edit')%
  	<body onLoad="
	toggleSoapRoleInput();
	%ifvar type equals('provider')%
		hideRows('muRoleWSADiv');
		hideRows('eprAddressDiv');
		setupKeystoreDataForProvider();
		changeColumnProperties('provider');
	%else%
		setupKeystoreData();
		%ifvar type equals('consumer')%
		    hideRows('eprMetadataDiv');
			hideRows('eprExtensibleDiv');
			changeColumnProperties('consumer');
		%endif%
		%ifvar type equals('addressing')%
		    hideRows('provConsHTTPDiv');
			%ifvar transportType equals('HTTPS')%
				setupKeystoreDataForAddressing();
			%endif%
			changeColumnProperties('addressing');
		%endif%

		%ifvar transportType equals('JMS')%
		%else%
			loadProxyAliasOptions('%value transportType%');
		%endif% 
	%endif% 
	setNavigation('settings-wsendpoints.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_WebServiceAliasEditScrn');">
  %else%
	  %ifvar action equals('view')%
	  	<BODY onLoad="%ifvar type equals('provider')%
	  		hideRows('muRoleWSADiv');hideRows('eprAddressDiv');
	  	%else%
	  	    %ifvar type equals('addressing')%
	  	    	hideRows('provConsHTTPDiv');
	  	    %else%
	  	 		hideRows('eprMetadataDiv');
				hideRows('eprExtensibleDiv');
	  	 	%endif%
	  	%endif%;
	  	changeColumnProperties('%value type%');setNavigation('settings-wsendpoints.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_WebSvcAliasDetailsScrn');">
	  %else%
	  	<BODY onLoad="setupKeystoreData();
		togglePropertiesAtOnLoad('provider', 'HTTP'); 
		setNavigation('settings-wsendpoints.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_WebServiceAlias');">
	  %endif%
  %endif%

    <TABLE class="table">
      <TR>
        <TD class="menusection-Settings" colspan="2">Settings &gt; Web Services &gt;
            %ifvar action equals('edit')%
                %value alias% &gt; Edit
            %else%
	            %ifvar action equals('view')%
	                %value alias% &gt; View
	            %else%
	                Create Endpoint Alias
	            %endif%
            %endif%
        </TD>
      </TR>
	
		%invoke wm.server.ws:listAllMessageAddressingEndpoints%
			<script>httpIdx=0;httpsIdx=0;jmsIdx=0</script>
			%loop endpoints%
				%ifvar transportInfo/transportType equals('HTTP')%
				<script>
					httpMsgAddressingAliases[httpIdx] = '%value alias%';
					httpIdx = httpIdx + 1;
				</script>
				%endif%
				%ifvar transportInfo/transportType equals('HTTPS')%
				<script>
					httpsMsgAddressingAliases[httpsIdx] ='%value alias%';
					httpsIdx = httpsIdx + 1;
				</script>
				%endif%
				%ifvar transportInfo/transportType equals('JMS')%
				<script>
					jmsMsgAddressingAliases[jmsIdx] = '%value alias%';
					jmsIdx = jmsIdx + 1;
				</script>
				%endif%
			%endloop%
		%endinvoke%

      <TR>
        <TD colspan="2">
          <UL>
            <LI><A HREF="settings-wsendpoints.dsp">Return to Web Services</A></LI>
	          %ifvar action equals('view')%
	            <LI><A HREF="settings-wsendpoints-addedit.dsp?action=edit&alias=%value -urlencode alias%&type=%value type%&transportType=%value -urlencode transportType%">Edit Web Service Endpoint Alias</A></LI>
	          %endif%
          </UL>
        </TD>
      </TR>
      <TR>
        <TD width="0%"><IMG SRC="images/blank.gif" height="10" width="10"></TD>
        <TD width="100%">

	%ifvar action equals('view')%

	<!-- VIEW SECTION START--->
   	<TABLE class="tableForm" width="50%">
		%ifvar type equals('provider')%
			<!-- VIEW PROVIDER START--->
			%invoke wm.server.ws:getProviderEndpoint%
				%scope endpoint%
					%include wsendpoints-common-props.dsp%
					<tr><td colspan=2><IMG SRC="images/blank.gif" height="10" width="10"></td></tr>
					%scope transportInfo%
						%ifvar transportType equals('HTTP')%
							%include wsendpoints-HTTP-props.dsp%
							<script>
								hideRows("consumerHTTPDiv");
								hideRows("consumerHTTPSDiv");
							</script>
						%endif%
						%ifvar transportType equals('HTTPS')%
							%include wsendpoints-HTTP-props.dsp%
							<script>
								hideRows("consumerHTTPDiv");
								hideRows("consumerHTTPSDiv");
							</script>
						%endif%
						%ifvar transportType equals('JMS')%
							%include wsendpoints-JMS-props.dsp%
							<script>
								hideRows("consumerJMSDiv");
								hideRows("consumerJMSDivJNDI");
								hideRows("consumerJMSDivJMS");
							</script>
						%endif%
					%endscope%
					<tbody id="spacerMsgDiv">
						<tr><td colspan=2><IMG SRC="images/blank.gif" height="10" width="10"></td></tr>
					</tbody>
					%scope messageInfo%
						%include wsendpoints-message-props.dsp%
						<script>
							hideRows("usernameMsgDiv");
							hideRows("partnerCertMsgDiv");
						</script>
					%endscope%
					<tr><td colspan=2><IMG SRC="images/blank.gif" height="10" width="10"></td></tr>
					%scope messageAddressingProperties%
						%include wsendpoints-WSA-props.dsp%
						<script>hideRows("fromReplyToFaultToWSADiv");</script>
					%endscope%
					
					%ifvar transportInfo/transportType equals('JMS')%
					%else%
					<tr><td colspan=2><IMG SRC="images/blank.gif" height="10" width="10"></td></tr>
						%scope reliableMessagingProperties%
							%include wsendpoints-RM-props.dsp%
							<script>displayRows("WSRMPropDiv");</script>
						%endscope%
					%endif%
				%endscope%
			%endinvoke%
			<!-- VIEW PROVIDER END--->
		%else%
			%ifvar type equals('addressing')%
				<!-- VIEW WS-ADDRESSING START--->
				%invoke wm.server.ws:getMessageAddressingEndpoint%
				%scope endpoint%
					%include wsendpoints-common-props.dsp%
					<tr><td colspan=2><IMG SRC="images/blank.gif" height="10" width="10"></td></tr>
					%scope transportInfo%
						%ifvar transportType equals('HTTP')%
							%include wsendpoints-HTTP-props.dsp%
							<script>
								displayRows("consumerHTTPDiv");
								hideRows("consumerHTTPSDiv");
								document.getElementById('httpTransportHeaderOpt').innerHTML = "&nbsp;(optional)";
							</script>
						%endif%
						%ifvar transportType equals('HTTPS')%
							%include wsendpoints-HTTP-props.dsp%
							<script>
								displayRows("consumerHTTPDiv");
								displayRows("consumerHTTPSDiv");
								document.getElementById('httpTransportHeaderOpt').innerHTML = "&nbsp;(optional)";
							</script>
						%endif%
						%ifvar transportType equals('JMS')%
							%include wsendpoints-JMS-props.dsp%
							<script>
								hideRows("providerJMSDiv");
								displayRows("consumerJMSDiv");
								%ifvar jmsAliasType equals('JNDI')%
									hideRows("consumerJMSDivJMS");
									displayRows("consumerJMSDivJNDI");
								%else%
									hideRows("consumerJMSDivJNDI");
									displayRows("consumerJMSDivJMS");
								%endif%
							</script>
						%endif%
					%endscope%
					<tbody id="spacerMsgDiv">
						<tr><td colspan=2><IMG SRC="images/blank.gif" height="10" width="10"></td></tr>
					</tbody>
					%scope messageInfo%
						%include wsendpoints-message-props.dsp%
						<script>
							hideRows("usernameMsgDiv");
							hideRows("truststoreMsgDiv");
						</script>
					%endscope%
					<tr><td colspan=2><IMG SRC="images/blank.gif" height="10" width="10"></td></tr>
					%scope messageAddressingProperties%
						%include wsendpoints-WSA-props.dsp%
						<script>hideRows("toWSADiv");hideRows("responseMapWSADiv");</script>
					%endscope%
				%endscope%
			%endinvoke%
			<!-- VIEW WS-ADDRESSING END--->
			%else%
			<!-- VIEW CONSUMER START--->
			%invoke wm.server.ws:getConsumerEndpoint%
				%scope endpoint%
					%include wsendpoints-common-props.dsp%
					<TR>
						<TD class="oddrow">Execute ACL</TD>
						<TD class="oddrow-l">%value executeACL%
						</TD>
					</TR>
					<tr><td colspan=2><IMG SRC="images/blank.gif" height="10" width="10"></td></tr>
					%scope transportInfo%
						%ifvar transportType equals('HTTP')%
							%include wsendpoints-HTTP-props.dsp%
							<script>
								displayRows("consumerHTTPDiv");
								hideRows("consumerHTTPSDiv");
								document.getElementById('httpTransportHeaderOpt').innerHTML = "&nbsp;(optional)";
							</script>
						%endif%
						%ifvar transportType equals('HTTPS')%
							%include wsendpoints-HTTP-props.dsp%
							<script>
								displayRows("consumerHTTPDiv");
								displayRows("consumerHTTPSDiv");
								document.getElementById('httpTransportHeaderOpt').innerHTML = "&nbsp;(optional)";
							</script>
						%endif%
						%ifvar transportType equals('JMS')%
							%include wsendpoints-JMS-props.dsp%
							<script>
								hideRows("providerJMSDiv");
								displayRows("consumerJMSDiv");
								%ifvar jmsAliasType equals('JNDI')%
									hideRows("consumerJMSDivJMS");
									displayRows("consumerJMSDivJNDI");
								%else%
									hideRows("consumerJMSDivJNDI");
									displayRows("consumerJMSDivJMS");
								%endif%
							</script>
						%endif%
					%endscope%
					<tbody id="spacerMsgDiv">
					<tr>
						<td colspan=2>
							<IMG SRC="images/blank.gif" height="10" width="10">
						</td>
					</tr>
					</tbody>
					%scope messageInfo%
						%include wsendpoints-message-props.dsp%
					%endscope%
					<tr><td colspan=2><IMG SRC="images/blank.gif" height="10" width="10"></td></tr>
					%scope messageAddressingProperties%
						%include wsendpoints-WSA-props.dsp%
						<script>hideRows("responseMapWSADiv");</script>
					%endscope%
					%ifvar transportInfo/transportType equals('JMS')%
					%else%
					<tr><td colspan=2><IMG SRC="images/blank.gif" height="10" width="10"></td></tr>
						%scope reliableMessagingProperties%
							%include wsendpoints-RM-props.dsp%
							<script>displayRows("WSRMPropDiv");</script>
						%endscope%
					%endif%
				%endscope%
			%endinvoke%
			<!-- VIEW CONSUMER END--->
			%endif%
        %endif%
	</TABLE>
	<!-- VIEW SECTION END--->

%else%
	<FORM NAME="addform" ACTION="settings-wsendpoints.dsp" METHOD="POST">
		<TABLE class="tableForm" name="addEditTable" width="50%">
			<input type="hidden" name="type" value = "%value type%">
			<input type="hidden" name="transportType" value = "%value transportType%">
			<input type="hidden" name="soapRole" id="soapRole" value = "%value messageAddressingProperties/soapRole%">

	%ifvar action equals('edit')%
		<!-- EDIT  SECTION START--->
		%ifvar type equals('provider')%
			<!-- EDIT PROVIDER START--->
			%invoke wm.server.ws:getProviderEndpoint%
				%scope endpoint%
					%include wsendpoints-common-props.dsp%
					<tr><td colspan=2><IMG SRC="images/blank.gif" height="10" width="10"></td></tr>
					%scope transportInfo%
						<input type="hidden" name="selectedTransportKS" value="%value keyStoreAlias%"/>
						<input type="hidden" name="selectedTransportKA" value="%value keyAlias%"/>
						%ifvar transportType equals('HTTPS')%
							%include wsendpoints-HTTP-props.dsp%
							<script>hideRows("consumerHTTPDiv");</script>
							<script>hideRows("consumerHTTPSDiv");</script>
						%endif%
						%ifvar transportType equals('HTTP')%
							%include wsendpoints-HTTP-props.dsp%
							<script>hideRows("consumerHTTPDiv");</script>
							<script>hideRows("consumerHTTPSDiv");</script>
						%endif%
						%ifvar transportType equals('JMS')%
							%include wsendpoints-JMS-props.dsp%
							<script>
								displayRows("providerJMSDiv");
								hideRows("consumerJMSDiv");
								hideRows("consumerJMSDivJMS");
								hideRows("consumerJMSDivJNDI");
							</script>
						%endif%
					%endscope%
					<tbody id="spacerMsgDiv"><tr><td colspan=2><IMG SRC="images/blank.gif" height="10" width="10"></td></tr></tbody>
					%scope messageInfo%
						<input type="hidden" name="selectedMsgKS" value="%value keyStoreAlias%"/>
						<input type="hidden" name="selectedMsgKA" value="%value keyAlias%"/>
						%include wsendpoints-message-props.dsp%
						<script>
							hideRows("usernameMsgDiv");
							hideRows("partnerCertMsgDiv");
						</script>
					%endscope%
					<tr><td colspan=2><IMG SRC="images/blank.gif" height="10" width="10"></td></tr>
					%scope messageAddressingProperties%
						%include wsendpoints-WSA-props.dsp%
						<script>hideRows("fromReplyToFaultToWSADiv");</script>
					%endscope%
					%ifvar transportInfo/transportType equals('JMS')%
					%else%
						<tr><td colspan=2><IMG SRC="images/blank.gif" height="10" width="10"></td></tr>
						%scope reliableMessagingProperties%
							%include wsendpoints-RM-props.dsp%
							<script>displayRows("WSRMPropDiv");</script>
							%ifvar enable equals('true')%
								<script>enableRMProperties();</script>
							%else%
								<script>disableRMProperties();</script>
							%endif%
						%endscope%
					%endif%
					
				%endscope endpoint%
			%endinvoke%
			<!-- EDIT PROVIDER END--->
		%else%
   			%ifvar type equals('addressing')%
			<!-- EDIT WS-ADDRESSING START--->
				%invoke wm.server.ws:getMessageAddressingEndpoint%
				%scope endpoint%
					%include wsendpoints-common-props.dsp%
					<tr><td colspan=2><IMG SRC="images/blank.gif" height="10" width="10"></td></tr>
					%scope transportInfo%
						<input type="hidden" name="selectedTransportKS" value="%value keyStoreAlias%"/>
						<input type="hidden" name="selectedTransportKA" value="%value keyAlias%"/>
						<input type="hidden" name="selectedProxyAlias" value="%value proxyAlias%"/>

						%ifvar transportType equals('HTTP')%
							%include wsendpoints-HTTP-props.dsp%
							<script>
								displayRows("consumerHTTPDiv");
								hideRows("consumerHTTPSDiv");
								document.getElementById('httpTransportHeaderOpt').innerHTML = "&nbsp;(optional)";
							</script>
						%endif%
						%ifvar transportType equals('HTTPS')%
							%include wsendpoints-HTTP-props.dsp%
							<script>
								displayRows("consumerHTTPDiv");
								displayRows("consumerHTTPSDiv");
								document.getElementById('httpTransportHeaderOpt').innerHTML = "&nbsp;(optional)";
							</script>
						%endif%
						%ifvar transportType equals('JMS')%
							%include wsendpoints-JMS-props.dsp%
							<script>
								hideRows("providerJMSDiv");
								displayRows("consumerJMSDiv");
								%ifvar jmsAliasType equals('JNDI')%
									hideRows("consumerJMSDivJMS");
									displayRows("consumerJMSDivJNDI");
								%else%
									hideRows("consumerJMSDivJNDI");
									displayRows("consumerJMSDivJMS");
								%endif%
							</script>
						%endif%
					%endscope%
					<tbody id="spacerMsgDiv"><tr><td colspan=2><IMG SRC="images/blank.gif" height="10" width="10"></td></tr></tbody>
					%scope messageInfo%
						<input type="hidden" name="selectedMsgKS" value="%value keyStoreAlias%"/>
						<input type="hidden" name="selectedMsgKA" value="%value keyAlias%"/>
						%include wsendpoints-message-props.dsp%
						<script>
							hideRows("usernameMsgDiv");
							hideRows("truststoreMsgDiv");
						</script>
					%endscope%
					<tr><td colspan=2><IMG SRC="images/blank.gif" height="10" width="10"></td></tr>
					%scope messageAddressingProperties%
						%include wsendpoints-WSA-props.dsp%
						<script>hideRows("toWSADiv");hideRows("responseMapWSADiv");</script>
					%endscope%
				%endscope%
			%endinvoke%
			<!-- EDIT WS-ADDRESSING END--->
			%else%
			<!-- EDIT CONSUMER START--->
			%invoke wm.server.ws:getConsumerEndpoint%
				%scope endpoint%
					%include wsendpoints-common-props.dsp%
					<TR>
						<TD class="oddrow">Execute ACL</TD>
						<TD class="oddrow-l">%invoke wm.server.access.adminui:aclList%
							<SELECT name="executeACL">
								%loop aclgroups%
									<OPTION
									%ifvar ../executeACL vequals(name)%selected%endif%
									%ifvar ../executeACL%%else%%ifvar name equals('Internal')%selected%endif%%endif% value="%value name%">%value name%</OPTION>
								%endloop%
							</SELECT> %endinvoke%  
						</TD>
					</TR>
					<tr><td colspan=2><IMG SRC="images/blank.gif" height="10" width="10"></td></tr>
					%scope transportInfo%
						<input type="hidden" name="selectedTransportKS" value="%value keyStoreAlias%"/>
						<input type="hidden" name="selectedTransportKA" value="%value keyAlias%"/>
						<input type="hidden" name="selectedProxyAlias" value="%value proxyAlias%"/>

						%ifvar transportType equals('HTTPS')%
							%include wsendpoints-HTTP-props.dsp%
							<script>
								displayRows("consumerHTTPDiv");
								displayRows("consumerHTTPSDiv");
								document.getElementById('httpTransportHeaderOpt').innerHTML = "&nbsp;(optional)";
							</script>
						%endif%
						%ifvar transportType equals('HTTP')%
							%include wsendpoints-HTTP-props.dsp%

							<script>
								displayRows("consumerHTTPDiv");
								hideRows("consumerHTTPSDiv");
								document.getElementById('httpTransportHeaderOpt').innerHTML = "&nbsp;(optional)";
							</script>
						%endif%
						%ifvar transportType equals('JMS')%
							%include wsendpoints-JMS-props.dsp%
							<script>
								hideRows("providerJMSDiv");
								displayRows("consumerJMSDiv");
								%ifvar jmsAliasType equals('JNDI')%
									hideRows("consumerJMSDivJMS");
									displayRows("consumerJMSDivJNDI");
								%else%
									hideRows("consumerJMSDivJNDI");
									displayRows("consumerJMSDivJMS");
								%endif%
							</script>
						%endif%
					%endscope%
					<tbody id="spacerMsgDiv">
					<tr><td colspan=2><IMG SRC="images/blank.gif" height="10" width="10"></td></tr>
					</tbody>
					%scope messageInfo%
						<input type="hidden" name="selectedMsgKS" value="%value keyStoreAlias%"/>
						<input type="hidden" name="selectedMsgKA" value="%value keyAlias%"/>
						%include wsendpoints-message-props.dsp%
					%endscope%
					<tr><td colspan=2><IMG SRC="images/blank.gif" height="10" width="10"></td></tr>
					%scope messageAddressingProperties%
						%include wsendpoints-WSA-props.dsp%
						<script>
							hideRows("responseMapWSADiv");
						</script>
					%endscope%
					%ifvar transportInfo/transportType equals('JMS')%
					%else%
						<tr><td colspan=2><IMG SRC="images/blank.gif" height="10" width="10"></td></tr>
						%scope reliableMessagingProperties%
							%include wsendpoints-RM-props.dsp%
							<script>displayRows("WSRMPropDiv");</script>
							%ifvar enable equals('true')%
								<script>enableRMProperties();</script>
							%else%
								<script>disableRMProperties();</script>
							%endif%
						%endscope%
					%endif%
					%endscope endpoint%
				%endinvoke%
				<!-- EDIT CONSUMER END--->
			%endif%
		%endif%
		<!-- EDIT SECTION END--->
	%else%
		<!-- ADD SECTION START--->
		<input type="hidden" name="selectedMsgKS" value=""/>
		<input type="hidden" name="selectedMsgKA" value=""/>
		<input type="hidden" name="selectedTransportKS" value=""/>
		<input type="hidden" name="selectedTransportKA" value=""/>
		<input type="hidden" name="selectedProxyAlias" value=""/>
		%include wsendpoints-common-props.dsp%
		<tbody id="executeACLDiv">
			<TR>
				<TD class="oddrow">Execute ACL</TD>
				<TD class="oddrow-l">%invoke wm.server.access.adminui:aclList%
					<SELECT name="executeACL">
					%loop aclgroups%
						<OPTION
						%ifvar ../executeACL vequals(name)%selected%endif%
						%ifvar ../executeACL%%else%%ifvar name equals('Internal')%selected%endif%%endif% value="%value name%">%value name%</OPTION>
						%endloop%
					</SELECT> %endinvoke%  
				</TD>
			</TR>
		</tbody>
		<tr><td colspan=2><IMG SRC="images/blank.gif" height="10" width="10"></td></tr>
		<tbody id="transportHTTPDiv">
			%include wsendpoints-HTTP-props.dsp%
		</tbody>
		<tbody id="transportJMSDiv">
			%include wsendpoints-JMS-props.dsp%
		</tbody>
		<tbody id="spacerMsgDiv">
			<tr><td colspan=2><IMG SRC="images/blank.gif" height="10" width="10"></td></tr>
		</tbody>
		%include wsendpoints-message-props.dsp%
		<tr><td colspan=2><IMG SRC="images/blank.gif" height="10" width="10"></td></tr>
		%include wsendpoints-WSA-props.dsp%
		<tr><td colspan=2><IMG SRC="images/blank.gif" height="10" width="10"></td></tr>
		%include wsendpoints-RM-props.dsp%
		<script>disableRMProperties();</script>
		<!-- ADD SECTION END--->
	%endif%
          <TR>
            <TD colspan=2 class="action">
              <INPUT TYPE="hidden" NAME="args" VALUE="xxx">
            %ifvar action equals('edit')%
              <INPUT TYPE="hidden" NAME="action" VALUE="edit">
              <INPUT TYPE="hidden" NAME="oldAlias" VALUE="%value alias%">
              <INPUT type="button" value="Save Changes" onclick="return confirmEdit();">
            %else%
              <INPUT TYPE="hidden" NAME="action" VALUE="add">
              <INPUT type="button" value="Save Changes" onclick="return confirmAdd();">
            %endif%
            </TD>
          </TR>
	   </TABLE>
    </FORM>
%endif%
    </TD>
  </TR>
</TABLE>

    </BODY>
  </HTML>