<html>
<head>
<title>Select Role/Group</title>
<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
<SCRIPT SRC="webMethods.js.txt"></SCRIPT>
	<style type="text/css" rel="stylesheet">
		.hovertan a { text-decoration: none }		
		.hovertan a:hover { color: white; background-color: gray; }		
		.hovertan tr:hover { color: white; background-color: black;opacity:.70;filter: alpha(opacity=50); -moz-opacity: 0.5;border:1px solid black;  }		
	</style>


</head>
<body style="border-spacing: 0; border-width:0">
	
	<SCRIPT>
	if(navigator.userAgent.indexOf("Firefox")!=-1){
		document.write("<form action='javascript://Query Users;'>");

	}
	</SCRIPT>

        <table id="lookUpTable" width="100%" style="cell-spacing:0 border-spacing: 0; border-collapse:collapse; border-width:1; border-style:solid; border-color:gray">
	<tr><th class="title" style="width:40px"></th>
	<th class="title" align=left style="width:190px">Role/Group Name</th>
	<td class="title" align=left style="width:45px">Type</td></tr>

	%invoke wm.server.jndi:getSettings%	
	<script languroup nameage="javascript">
		var prov_setting = "%value provider%";
	</script>
	%ifvar provider equals('local')%
	%else%
	<tr>
	<td class="evenrow-l" colspan=3>&nbsp;Provider:&nbsp;
	<select onChange="toggleProvider(this.selectedIndex);" id="prov" name="prov" class="listbox">
               <option value="local" %ifvar prov equals('local')%selected%endif%>Local</option>
               %ifvar provider equals('CDS')%
               	<option value="CDS" %ifvar prov equals('CDS')%selected%endif%>Central</option>
               %else%
               	<option value="LDAP" %ifvar prov equals('LDAP')%selected%endif%>LDAP</option>
               %endif%
         </select>
         </td>
	</tr>
        %endif%
        %endinvoke%

	</table>
	<table width="100%">	
          <tr>
            <td>&nbsp;&nbsp;&nbsp;</td>
            <td>Search:</td>
            <td><input id="query" name="query" value="%value query%" size=12></input>
            <a style="text-decoration: none" onclick="window.queryUsers()" href="javascript://Query Users;"><BUTTON type="submit" STYLE="">Go</BUTTON></a>
            </td>
          </tr>
              <tr class="action">
                <td colspan=3>
			<a style="text-decoration: none" onclick="closePopup()"  href="javascript://window.parent.hidePopWin(false)"><button style="">close</button></a>
                </td>
              </tr>

	</table>
	
	<SCRIPT>

	if(navigator.userAgent.indexOf("Firefox")!=-1){
		document.write("</form>");

	}

	</SCRIPT>
	
</body>

<SCRIPT LANGUAGE="JavaScript">
  var listSize=10;
  var start=0;
  var currentProvider=%ifvar prov equals('CDS')% "CDS" %else% %ifvar prov equals('LDAP')% "LDAP" %else% "local"%endif%%endif%;

  function getProvider(index){
	if (index==1){
		return prov_setting;
	}else{
		return "local";
	}
  }

  function nextUsers(){
//  	var startFrom = %value startFrom% + listSize + 1;
//  	window.location='subGroupLookup.dsp?startFrom='+startFrom;
	start = start + listSize;
	clearList();
	populateList(groupList);
  }

  function prevUsers(){
//  	var startFrom = %value startFrom% - listSize - 1;
//  	window.location='subGroupLookup.dsp?startFrom='+startFrom;
	start = start - listSize;
	clearList();
	populateList(groupList);
  }
  function queryUsers(){
	if (document.getElementById("prov") == null) {
		var prov = 'local';
	} else {
		var prov = getProvider(document.getElementById("prov").selectedIndex);
	}
  	var query = document.getElementById("query");
	if(is_csrf_guard_enabled && needToInsertToken) {
		window.location='subGroupLookup.dsp?prov='+prov+'&name='+ encodeURIComponent(query.value)+"&"+_csrfTokenNm_+"="+_csrfTokenVal_;
	} else {
		window.location='subGroupLookup.dsp?prov='+prov+'&name='+ encodeURIComponent(query.value);
	}
  }
  
  function select(user){window.parent.hideSub(decodeURIComponent(user));}
  
  function closePopup(){window.parent.hideSub(false);}


  function toggleProvider(index){
	if (currentProvider==getProvider(index)){
		clearList();
		start = 0;
		populateList(groupList);
	}else{
		clearList();
		start = 0;
		populateList(new Array());
	}
  }


    function wrap(s, n) {
        var ret='';
        while(true) {
            var len = s.length;
            if(len <= n) {
                ret += s;
                return ret;
            }
            ret+= ((s.substring(0,n))+' ');
            s = s.substring(n);
        }
    }



  var lookUpTable = document.getElementById("lookUpTable");

  var groupList = new Array();

	%rename provider varProvider%
	%rename prov provider%

  %invoke wm.server.jndi:searchGroups%  	
  %loop results%groupList[%value $index%]=new Array('%value name%','%value type%');%endloop%
  %endinvoke%

	%rename provider prov1%
	%rename varProvider provider%

  function populateList(array){
     resetRows();swapRows();
        
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
		icon.src='icons/icon_user.gif';

		//iconcell
	        var iconCell = newRow.insertCell(0);
		iconCell.align='center';
		iconCell.style.width='40px';
		iconCell.appendChild(icon);

		//namecell
	        var nameCell = newRow.insertCell(1);
	        
	        //1-1NBHHD-for ldap group we are appending DN with group name. For display purpose group name is sufficient.
		//var nameNode = document.createTextNode(array[i][0]);
		var groupName=array[i][0];
		var len = groupName.indexOf("[");
		if(len>=0)
			groupName=groupName.substring(0,len);
		
		var nameNode = document.createTextNode(wrap(groupName, 24));
		//END 1-1NBHHD
		
		nameCell.style.width='200px';
		nameCell.appendChild(nameNode);		

		//typecell
	        var typeCell = newRow.insertCell(2);
		typeCell.style.width='65px';

		var typeNode = document.createTextNode(array[i][1]);
		typeCell.appendChild(typeNode);		
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
	outerCell.colSpan=3;
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
   var navOuterCell = navOuterRow.insertCell(0);
   navOuterCell.className = row+"rowdata";

   //a prev
   var prevCell = navOuterRow.insertCell(1);
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
   var nextCell = navOuterRow.insertCell(2);
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

function doClick(e,x) {
	e = e || window.event;
	x = x || this;
	select(decodeURIComponent(x.toString()).substring(20)); //1-1U7H0Q
}


  function clearList(){
  	var startClear;
  	elem = document.getElementById("prov");
  	if(elem==null){
  		startClear=1;
  	}else{
  		startClear=2;
  	}
	while (lookUpTable.rows.length>startClear) //deletes all rows of a table
		lookUpTable.deleteRow(startClear) //delete first row of contracting table until there are none left
  }


   populateList(groupList);  
</SCRIPT>


</html>

