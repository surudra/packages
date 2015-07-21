<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<SCRIPT src="webMethods.js"></SCRIPT>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<style type="text/css">
.selected{
width:200px;
color: black;
}
.source{
width:200px;
}
</style>
<script>
	function setUpPage()
	{
		if(parent.disablePortUI)
		{
			document.properties.multipleActionButton.disabled = true;
		}
	}
</script> 
</HEAD>
<BODY onLoad="setUpPage();">
<SCRIPT language=JavaScript>

/*function test(){
	window.varSubTop.document.properties.submit();
}*/

function showSelected(){
	document.getElementById("selected").options.length=0;
	var j=0;
	var size = document.getElementById("source").options.length;
	var indexOfFirstStar = 0;
//to fix a bug
	var doesListHaveAStar = false;

	for(var i=0;i<size;i++){
		var value = document.getElementById("source").options[i].text;
		var z = value.substring(0,1);
		if(z == "+"){
			doesListHaveAStar=true;
		}
	}

//to fix a bug
	for(var i=0;i<size;i++){
		var value = document.getElementById("source").options[i].text;
		var z = value.substring(0,1);
		if(z == "+"){
			indexOfFirstStar=i;
			break;
		}
	}
	for(var i=0;i<size;i++){
		if(document.getElementById("source").options[i].selected){
		var value = document.getElementById("source").options[i].text;
		//var z = value.substring(0,1);
		var z = TrimString(value).substring(0,1);

			if (z == "+")
			{
				var index = i+1;
				while((document.getElementById("source").options[index].text.substring(0,1)!="+")){
					document.getElementById("source").options[index].selected=true;
					if(index<size-1){
						index++;
					}
					else{
						break;
					}
				}
			}
			else{
					var k = i;
					var value1 = "";
					if(k>indexOfFirstStar){
						//var z1=document.getElementById("source").options[k].text.substring(0,1);
						var z1= TrimString(document.getElementById("source").options[k].text).substring(0,1);
						var isSelected = true;
						if(doesListHaveAStar){
						while(z1 != "+"){
						//	z1 = document.getElementById("source").options[k-1].text.substring(0,1);
							z1= TrimString(document.getElementById("source").options[k-1].text).substring(0,1);
							if(document.getElementById("source").options[k-1].selected){
								isSelected=false;
							}
							if(z1 != "+"){
							k--;
							}
							value1 = document.getElementById("source").options[k-1].text;
						}

						while(z1 != "+"){
							if(document.getElementById("source").options[k+1].selected){
								isSelected=false;
							}
							if(z1 != "+"){
								if (k<size-1)
								{
									k++;
								}
								else{
									break;
								}
							}
						}
						
						if (isSelected)
						{
							optionParent = new Option(value1,0);
							document.getElementById("selected").options[j] = optionParent;
							j++;
						}
						}							
					}
				}
		option0 = new Option(value,0);
		document.getElementById("selected").options[j] = option0;
		j++;
		}
	}
	return;
    }
	
	function TrimString(sInString) {
	sInString = sInString.replace( /^\s+/g, "" );
	sInString = sInString.replace( /^[\s\xA0]+/, "" );
	sInString = sInString.replace( /[\s\xA0]+$/, "" );
	return sInString.replace( /\s+$/g, "" );
	}

	function listSelected(){
		//alert("invoked");
		var size = document.getElementById("selected").options.length;
		if(size == 0){
			alert("[DEP.0002.0168] Cannot save variable substitutions. There are no servers selected.");
			return;
		}
		var listOfSelectedServers="";
		for(var i=0;i<size;i++){
		//alert("first for");
		var value = document.getElementById("selected").options[i].text;
		// var z = value.substring(0,1);
		var z = TrimString(value).substring(0,1);
			if(z != "+"){
				var trimStringValue = TrimString(value);
				var doesNotContain=true;
				//alert("listOfSelectedServers.length="+listOfSelectedServers.length);
				var lengthSelectedServers = listOfSelectedServers.length;
				var lengthTrimString = trimStringValue.length;
				var difference=lengthSelectedServers-lengthTrimString;
				//alert("lengthSelectedServers="+lengthSelectedServers+"lengthTrimString="+lengthTrimString+"difference="+difference);
				if(lengthSelectedServers >= lengthTrimString){
					for(var j=0;j<difference;j++){
						//alert("second for");
						if((listOfSelectedServers.substring(j,j+lengthTrimString)) == trimStringValue){
							if((listOfSelectedServers.length)>(j+lengthTrimString+1)){
								if((listOfSelectedServers.substring(j+lengthTrimString,j+lengthTrimString+1)) == ","){
									doesNotContain=false;
								}
							}
							//alert("listOfSelectedServers.length="+listOfSelectedServers.length+"j+lengthTrimString="+(j+lengthTrimString+1));
							if ((listOfSelectedServers.length) == (j+lengthTrimString+1))
							{
								//alert("last letter");
								doesNotContain=false;
							}
						}
					}
				}
				if(doesNotContain){
					listOfSelectedServers=listOfSelectedServers+trimStringValue+",";
				}
				//alert("listOfSelectedServers="+listOfSelectedServers);
			}
		}
		listOfSelectedServers=listOfSelectedServers.substring(0,listOfSelectedServers.length-1);
		//alert("listOfSelectedServers=" + listOfSelectedServers);
		
		parent.varSubTop.document.properties.listOfTargetServerAlias.value=listOfSelectedServers;
		/*parent.varSubTop.document.properties.projectName.value=%value projectName%;
		parent.varSubTop.document.properties.deploymentMapName.value=%value deploymentMapName%;
		parent.varSubTop.document.properties.deploymentSetName.value=%value deploymentSetName%;
		parent.varSubTop.document.properties.sourceServerAlias.value=%value sourceServerAlias%;
		parent.varSubTop.document.properties.targetServerAlias.value=%value targetServerAlias%;
		parent.varSubTop.document.properties.key.value=%value key%;
		parent.varSubTop.document.properties.pluginType.value=%value pluginType%;
		parent.varSubTop.document.properties.varSubItemType.value=%value varSubItemType%;
		parent.varSubTop.document.properties.packageName.value=%value packageName%;*/
		//parent.varSubTop.document.properties.asset.value="asset";
		//alert("type=%value type%");
		//parent.varSubTop.document.properties.type.value="%value type%";
		//alert("test");
		parent.varSubTop.document.properties.action.value="saveMultiple";
		parent.varSubTop.document.properties.mode.value="assetListing";
		parent.varSubTop.document.properties.pluginType.value="%value pluginType%";
		parent.varSubTop.document.properties.service.value="%value service%";
		parent.varSubTop.document.forms[0].submit();
		
		//alert("document.properties.listOfTargetServerAlias.value="+document.properties.listOfTargetServerAlias.value);
	}
</SCRIPT>

<TABLE width=100%>
	<TR>
		<TD class="menusection-Deployer">%ifvar varSubItemType equals('ScheduledService')%%value service%%else%%value key%%endif% >%value pluginType% Target Substitution and Source Values</TD>
	</TR>
</TABLE>


<TABLE width=100%>
%comment%
	<FORM name="properties" action="under-construction.dsp" method="POST">
%endcomment%
	<FORM NAME="properties" action="%value dspPage%" target="varSubTop" method="POST">
		<INPUT type="hidden" name="projectName" value="%value projectName%">
		<INPUT type="hidden" name="deploymentMapName" value="%value deploymentMapName%">
		<INPUT type="hidden" name="deploymentSetName" value="%value deploymentSetName%">
		<INPUT type="hidden" name="sourceServerAlias" value="%value sourceServerAlias%">
		<INPUT type="hidden" name="targetServerAlias" value="%value targetServerAlias%">
		<INPUT type="hidden" name="key" value="%value key%">
		<INPUT type="hidden" name="pluginType" value="%value pluginType%">
		<INPUT type="hidden" name="listOfTargetServerAlias">
		<INPUT type="hidden" name="varSubItemType" value="%value varSubItemType%">
		<INPUT type="hidden" name="packageName" value="%value packageName%">
		<INPUT type="hidden" name="mode" value="asset">
		<INPUT type="hidden" name="service" value="%value service%">
	<TR>
		<TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
		<TD>
		<TABLE class="tableForm">

			<tr>
				<td class="heading" colspan="2">List Of Target Servers</td>
			</tr>

			<!- Value ->
			<tr><td class="evenrow-l">Variable Substitution Servers </td>
				<td class="evenrow-l">Selected Servers </td>
			</tr>
			<tr><td class="evenrow">
			<select multiple=true class="source" id="source" onkeypress="javascript:showSelected();" onclick="javascript:showSelected();" size=15>
			%rename deploymentMapName mapSetName -copy%	
			%rename deploymentSetName bundleName -copy%
			%invoke wm.deployer.gui.UITarget:listMapsInSet%
			%ifvar maps -notempty%
			%loop maps%
			<option value="%value serverAlias%">%value serverAlias%</option>
			%endloop maps%
			%endif%
			%end invoke%
			%invoke wm.deployer.gui.UITargetGroup:listTargetGroupsInSet%
			%ifvar targetGroups -notempty%
			%loop targetGroups%
			<option value="+%value targetGroupAlias%">+%value targetGroupAlias%</option>
			%rename targetGroupAlias rtgName -copy%
			%rename ../pluginType pluginType -copy%
			%invoke wm.deployer.gui.UITargetGroup:listTargetGroupServers%
			%loop targetGroupServers%
			<option value="&nbsp;&nbsp;&nbsp;%value name%">&nbsp;&nbsp;&nbsp;%value name%</option>
			%endloop%
			
			%loop targetGroupClusters%
			<option value="&nbsp;&nbsp;&nbsp;%value name%">&nbsp;&nbsp;&nbsp;+%value clusterName%</option>
						%loop targetClusterServers%
      			<option value="&nbsp;&nbsp;&nbsp;%value name%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value clusterServer%</option>
      			%endloop%
			%endloop%			
			
			%endinvoke listTargetGroupServers%
			%endloop targetGroups%
			%endif%
			%endinvoke listTargetGroupsInSet%
			</select>
			</td>
			<td class="evenrow-l">
			<select multiple=true class="selected" id="selected" size=15 disabled>
			</select>
			</td>
			</tr>
			
			<TR>
					<TD class="action" colspan="3">
						<INPUT onclick="listSelected();" class="data" name="multipleActionButton" type="button" value="Save Substitutions"> </TD>
			</TR>

		</table>
		</TD>
	</TR>
	</FORM>
</TABLE>
</BODY>
<script>
	if(top.disableUI)
	{
		document.properties.multipleActionButton.disabled = true;
	}
</script>
</HTML>