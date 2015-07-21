<html>
<head>
<title>Select User</title>
<LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
<SCRIPT SRC="webMethods.js.txt"></SCRIPT>

<SCRIPT LANGUAGE="JavaScript">

	function nextUsers(){
		start = start + listSize;
		clearList();
		populateList(groupList);
	}

	function prevUsers(){
		start = start - listSize;
		clearList();
		populateList(groupList);
	}


	function select(user){
	window.parent.hideSub(user,'%value notificationNodeName%');}

	function closePopup(){window.parent.hideSub(false);}

	function toggleProvider(index){
		if (currentProvider==getProvider(index)){
			clearList();
			populateList(groupList);
		}else{
			clearList();
			populateList(new Array());
		}
	}


	function getProvider(index){
		if (index==1){
			return server_dir_setting;
		}else{
			return "local"
		}
	}

	function clearList(){
		var startClear;
		elem = document.getElementById("provSelect");
		if(elem==null){
			startClear=1;
		}else{
			startClear=2;
		}
		while (lookUpTable.rows.length>startClear) //deletes all rows of a table
			lookUpTable.deleteRow(startClear) //delete first row of contracting table until there are none left
		}

		function doClick(e,x) {
		e = e || window.event;
		x = x || this;
		select(decodeURIComponent(x.toString()).substring(20)); //1-1U7H0Q
	}


	function queryUsers(){
		var prov1;
		
		if ( document.getElementById("provSelect") == null ) {
		  prov1 = "local";
		}
		else {
		  prov1 = getProvider(document.getElementById("provSelect").selectedIndex);
		}
		
		var query = document.getElementById("query");
		
		window.location='\WmART\subUserLookup.dsp?selectedOption='+prov1+'&query='+ encodeURIComponent(query.value);
	}




  function populateList(array){
       resetRows();swapRows();
   
   //table
     		var tableNode = document.createElement('table');
     		tableNode.style.width='100%';
     		tableNode.style.borderSpacing='0';
     		tableNode.style.borderWidth='0';
     		tableNode.style.borderColor='gray';
     		tableNode.style.borderStyle='solid';
     
     		//row
     		var newRow = tableNode.insertRow(0);
     
     
     		//iconcell
     	        var iconCell = newRow.insertCell(0);
     		iconCell.align='center';
     		iconCell.style.width='50px';
     		
     
     		//namecell
     	        var nameCell = newRow.insertCell(1);
     		var nameNode = document.createTextNode('<None>');
     		nameCell.style.width='80%';
     		nameCell.appendChild(nameNode);		
     
   	
     //
     /////////
     		//a
     		var aNode = document.createElement('a');
     		aNode.onclick = doClick;		
     		aNode.href = "javascript://Select "+"NONE;";
     		aNode.appendChild(tableNode);
     
     		//div
     		var divNode = document.createElement('div');
     		divNode.className="hoverTan";				
  		divNode.appendChild(aNode);
		var outerRow = lookUpTable.insertRow(lookUpTable.rows.length);
		outerRow.style.height='25px';
		outerRow.style.border='0';
		outerRow.style.padding='0';

		//outerCell
		var outerCell = outerRow.insertCell(0);
		outerCell.className = 'even'+"rowdata-l";
		outerCell.colSpan=2;
		outerCell.appendChild(divNode);

       for(var i=start; i<(start+listSize); i++){

  /////////

  	if(i<array.length){

  		//table
  		var tableNode = document.createElement('table');
  		tableNode.style.width='100%';
  		tableNode.style.borderSpacing='0';
  		tableNode.style.borderWidth='0';
  		tableNode.style.borderColor='gray';
  		tableNode.style.borderStyle='solid';

  		//row
  		var newRow = tableNode.insertRow(0);

  //
  		//icon
  		var icon = document.createElement('img');
  		icon.border=0;
  		icon.align='bottom';
  		icon.src='/WmRoot/icons/icon_user.gif';

  		//iconcell
  	        var iconCell = newRow.insertCell(0);
  		iconCell.align='center';
  		iconCell.style.width='50px';
  		iconCell.appendChild(icon);

  		//namecell
  	        var nameCell = newRow.insertCell(1);
  		var nameNode = document.createTextNode(array[i][0]);
  		nameCell.style.width='80%';
  		nameCell.appendChild(nameNode);


  //
  /////////
  		//a
  		var aNode = document.createElement('a');
  		aNode.onclick = doClick;
  		aNode.href = "javascript://Select "+array[i][0];
  		aNode.appendChild(tableNode);

  		//div
  		var divNode = document.createElement('div');
  		divNode.className="hoverTan";
  		divNode.appendChild(aNode);

  //////////
  	}
  	//outerRow
  	var outerRow = lookUpTable.insertRow(lookUpTable.rows.length);
  	outerRow.style.height='25px';
  	outerRow.style.border='0';
  	outerRow.style.padding='0';

  	//outerCell
  	var outerCell = outerRow.insertCell(0);
  	outerCell.className = row+"rowdata-l";
  	outerCell.colSpan=2;
  	if(i<array.length){
  		outerCell.appendChild(divNode);
  	}
  //////////

  	swapRows();
     }



     //navigation

     //navOuterRow
     var navOuterRow = lookUpTable.insertRow(lookUpTable.rows.length);
     navOuterRow.style.height='25px';
     navOuterRow.style.border='0';
     navOuterRow.style.padding='0';

     //blank
     //var navOuterCell = navOuterRow.insertCell(0);
     //navOuterCell.className = row+"rowdata";

     //a prev
     var prevCell = navOuterRow.insertCell(0);
     prevCell.className = row+"rowdata-l";
     if(start>0){
		aNode = document.createElement('a');
		aNode.onclick = window.prevUsers;
		aNode.href = "javascript://Previous "+listSize+" Users"
		aNode.style.textDecoration="none";
		aNode.style.fontWeight="normal";
		nameNode = document.createTextNode("<< Prev");
		aNode.appendChild(nameNode);
		//cell
		prevCell.appendChild(aNode);
     }
     //a next
     var nextCell = navOuterRow.insertCell(1);
     nextCell.className = row+"rowdata-r";

     if(i<array.length){
  	aNode = document.createElement('a');
  	aNode.onclick = window.nextUsers;
  	aNode.href = "javascript://Next "+listSize+" Users"
  	aNode.style.textDecoration="none";
  	aNode.style.fontWeight="normal";
  	nameNode = document.createTextNode("Next >>   ");
  	aNode.appendChild(nameNode);
  	//cell
  	nextCell.appendChild(aNode);
     }
}



  var currentProvider ;
  var server_dir_setting ;
  var listSize = 10;
  var start=0;

</SCRIPT>
</head>
<body style="border-spacing: 0; border-width:0">
	<SCRIPT>
	if(navigator.userAgent.indexOf("Firefox")!=-1){
		document.write("<form action='javascript://Query Users;'>");

	}
	</SCRIPT>

        <table  id="lookUpTable" width="250" style="cell-spacing:0 border-spacing: 0; border-collapse:collapse; border-width:0; border-style:solid; border-color:gray">
	<tr><th  class="heading" colspan=2 align="left">User Name</th></tr>

	%invoke wm.server.jndi:getSettings%
		<script language="javascript">
			server_dir_setting = "%value provider%";
			currentProvider=%ifvar selectedOption equals('CDS')% "CDS" %else% %ifvar selectedOption equals('LDAP')% "LDAP" %else% "local"%endif% %endif%;;

		</script>
		%ifvar provider equals('local')%
		%else%
		<tr>
		<td class="evenrow">Provider</td>
		<td class="evenrow-l">
		<select onChange="toggleProvider(this.selectedIndex);" id="provSelect" name="provSelect" class="listbox">
	               <option value="local" %ifvar selectedOption equals('local')%selected%endif%>Local</option>
	               %ifvar provider equals('CDS')%
	               	<option value="CDS" %ifvar selectedOption equals('CDS')%selected%endif%>Central</option>
	               %else%
	               	<option value="LDAP" %ifvar selectedOption equals('LDAP')%selected%endif%>LDAP</option>
	               %endif%
	         </select>
	         </td>
		</tr>
	        %endif%

        %endinvoke%

	<style type="text/css" rel="stylesheet">
		.hovertan a { text-decoration: none }
		.hovertan a:hover { color: white; background-color: gray; }
		.hovertan tr:hover { color: white; background-color: black;opacity:.70;filter: alpha(opacity=50); -moz-opacity: 0.5;border:1px solid black;  }
	</style>

	<SCRIPT LANGUAGE="JavaScript">
	var lookUpTable = document.getElementById("lookUpTable");

	var groupList = new Array();


	%rename provider varProvider%
	%rename selectedOption provider%

	%invoke wm.server.access:allUserList%
	%loop users%groupList[%value $index%]=new Array('%value name%');%endloop%
	%endinvoke%

	%rename varProvider provider%

	populateList(groupList);

	</SCRIPT>

	<table width="100%" border="0">
          <tr>
          <!-- Search is not working 
            <td>&nbsp;&nbsp;&nbsp;</td>
            <td>Search:</td>
            <td><input id="query" name="query" value="%value query%" size=12></input>
            <a style="text-decoration: none" onclick="window.queryUsers()" href="javascript://Query Users;"><BUTTON type="submit" STYLE="">Go</BUTTON></a>
            </td>-->
          </tr>
              <tr class="action">
                <td colspan=3>
			<a style="text-decoration: none" onclick="closePopup()"  href="javascript://window.parent.hidePopWin(false)"><button style="">Close</button></a>
                </td>
              </tr>
	</table>

	<SCRIPT>

	if(navigator.userAgent.indexOf("Firefox")!=-1){
		document.write("</form>");

	}

	</SCRIPT>

</body>
</html>

