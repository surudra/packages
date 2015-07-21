
function toggle(node, bodyName)    {
	
	var body=document.getElementById(bodyName);
	var applicationName=document.getElementById("applicationName").value;
	var image=document.getElementById('img'+bodyName);
	rows = body.rows;
 	if (image.src.indexOf('plus') !=-1){
 		image.src = "images/minus.gif";
 		if(rows.length!=0 ){
 			
 			for(i = 0; i < rows.length; i++){
				rows[i].style.display="block";
				rows[i].style.display="table-row";
			}
		}else{
			
			loadData(bodyName,applicationName);
		}
	}else{
		image.src = "images/plus.gif";
		for(i = 0; i < rows.length; i++){
			rows[i].style.display = 'none';
		}
	}
}

function loadData(vtbodyName,vappName){

	$.ajax({
		type: 'post',
		url: '/invoke/wm.client.integrationlive.metadatashare/getServicesForDisplay',
		data: {packageName:vtbodyName,applicationName:vappName},
		dataType: 'json',
		async: false,
		success:function(data){
			$.each(data, function(key, value) {
				if(key=='services'){
					if(jQuery.isEmptyObject(value)){
						createEmptyPackageRow(vtbodyName);
					}
			  		$.each(value,function(i,j){
			  			//if(i==0){
			  				//createHeadingRow(vtbodyName);
			  			//}
			  			var size=value.length;
			  			var svcName;
			  			var svcDesc;
			  			var isSelected;
			  			var lastElement=false;
			  			$.each(j,function(k,v){
			  				if(k=='serviceName'){
			  					svcName=v;
			  				}
			  				if(k=='displayName'){
			  					svcDesc=v;
			  				}
			  				if(k=='isShared'){
			  					isSelected=v;
			  				}
			  			});

			  			if(size==1 ||size==i+1){
			  				lastElement="true";
			  			}else{
			  				lastElement="false";
			  			}
			  			createRow(i,vtbodyName,svcName,svcDesc,isSelected,lastElement);
			  		});
			  	}
			});

		}
	});

}

function createEmptyPackageRow(vtbodyName){
	var table = document.getElementById(vtbodyName);
	var row = table.insertRow(0);
	
	var cell = row.insertCell(0);
	cell.setAttribute("width","65%");
	
	var labelElement = document.createElement("label");
	labelElement.setAttribute("id",vtbodyName+"_nodata");
	labelElement.innerHTML="<i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;No services satisfying the metadata share criteria found.</i>";
	cell.appendChild(labelElement);
	
	var cell = row.insertCell(1);
	cell.setAttribute("width","35%");
}


function createHeadingRow(vtbodyName){

	var table = document.getElementById(vtbodyName);
	var row = table.insertRow(0);
	row.setAttribute("class","evenrow-l");

	var imgElement=document.createElement("img");
	imgElement.setAttribute("src","images/T.png");

	var labelElement = document.createElement("label");
	labelElement.innerHTML="<b>&nbsp;&nbsp;Service Name</b>";

	var cell = row.insertCell(0);
	cell.setAttribute("width","65%");
	cell.appendChild(imgElement);
	cell.appendChild(labelElement);
	
	var cell1 = row.insertCell(1);
	cell1.innerHTML = "<b>Display Name</b>";
	cell1.setAttribute("width","35%");
	
}

function createRow(vindex,vtbodyName,vsvcName,vsvcDesc,visSelected,isLastElement){
	
	var table = document.getElementById(vtbodyName);
	var row = table.insertRow(vindex);
	
	var submitForm=document.getElementById("appSubmitForm");
	
	var imgElement=document.createElement("img");

	if(isLastElement=="true"){
		imgElement.setAttribute("src","images/L.png");
	}else{
		imgElement.setAttribute("src","images/T.png");
	}
	

	var cell = row.insertCell(0);
	cell.setAttribute("width","75%");
	cell.appendChild(imgElement);
	
	var imgElement2=document.createElement("img");
	imgElement2.setAttribute("src","images/ns_flow.GIF");
	imgElement2.setAttribute("class","imgStyle");
	cell.appendChild(imgElement2);

	var labelElement=document.createElement("label");
	var cbname="md_"+vsvcName+"_cb";
	var functionName="setDetails('"+vtbodyName+"','"+vsvcName+"');"
	var labelElement = document.createElement("label");
	
	if(visSelected==true){
		labelElement.innerHTML = ' <input type="checkbox" class="cbstyle" name="'+cbname+'" value="'+vsvcName+'" onclick="'+functionName+'" checked> &nbsp;'+ vsvcName;
	}else{
		labelElement.innerHTML = ' <input type="checkbox" class="cbstyle" name="'+cbname+'" value="'+vsvcName+'" onclick="'+functionName+'"> &nbsp;'+ vsvcName;
	}
	
	cell.appendChild(labelElement);
	
	var cell2 = row.insertCell(1);
	
	var txtField=document.createElement("input");
	txtField.setAttribute("type","textfield");
	txtField.setAttribute("name","md_"+vsvcName+"_tf");
	txtField.setAttribute("id","md_"+vsvcName+"_tf");
	txtField.setAttribute("value",vsvcDesc);
	txtField.setAttribute("size","45");
	txtField.setAttribute("onchange",functionName);
	cell2.appendChild(txtField);

	var hiddenField=document.createElement("input");
	hiddenField.setAttribute("type","hidden");
	hiddenField.setAttribute("id",vsvcName);
	hiddenField.setAttribute("name","details");
	hiddenField.setAttribute("value","");
	submitForm.appendChild(hiddenField);
	cell2.setAttribute("width","35%");
	
	if(visSelected==true){
		setDetails(vtbodyName,vsvcName);
	}

}

function setDetails(vpkgName,vsvcName){

	var appform=document.getElementById("applicationForm");
	var cbName="md_"+vsvcName+"_cb";
	var tfName="md_"+vsvcName+"_tf";
	if(appform.elements[cbName].checked){
	    document.getElementById(vsvcName).value=vpkgName+","+vsvcName+","+document.getElementById(tfName).value+","+"true";
	}else{
	    document.getElementById(vsvcName).value=document.getElementById(vsvcName).value=vpkgName+","+vsvcName+","+document.getElementById(tfName).value+","+"false";;
	}

}

function submitForm(){
	
	document.getElementById("submitAppName").value=document.getElementById("applicationName").value;
	document.getElementById("submitDesc").value=document.getElementById("description").value;
}

function editApplication(varname){
	
   	 document.forms['applicationForm'].applicationName.value=varname;
     document.forms['applicationForm'].action='integration-live-metadata-applicationedit.dsp';
       
    return true;
  
}

function removeApplication(varname){
	
	var msg=confirm("Deleting the application from the on-premise Integration Server removes the application from webMethods Cloud." +"\n"+
			" Are you sure you want to remove the application "+varname+"?");
	
	if(msg==false){
		return false;
	}
	
  	document.getElementById("applicationName").value=varname;
  	document.getElementById("deleteAction").value='yes';
    document.getElementById("applicationForm").action='integration-live-metadata-share.dsp';
      
   return true;
 
}

function uploadApplication(varname){
	
  	document.forms['applicationForm'].applicationName.value=varname;
    document.forms['applicationForm'].action='integration-live-metadata-upload.dsp';
      
   return true;
 
}

function submitUploadApplication(){
	
	var varname=document.forms['applicationForm'].applicationName.value;
	
	if(!validateUploadData()){
		return false;
	}
	
	var msg=confirm("Uploading the application definition will update the application on webMethods Cloud." +"\n"+
			"This might affect the existing integration flows on webMethods Cloud." +"\n"+
			"Are you sure you want to upload the application "+varname+"?");
	
	if(msg==false){
		return false;
	}
	
		
   return true;
}

function validateData(){
	
	if(!validateApplicationName()){
		return false;
	}
	
	if(!validateDescription()){
		return false;
	}
	
	var varDetails=document.getElementsByName("details");
	
	if(varDetails==null || varDetails.size<=0){
		return;
	}
	var dpNamesList=[];
	var dupFlag=false;
	var emptyFlag=false;
	
	for(var i=0;i<varDetails.length;i++){
		
		var fldValue=varDetails[i].value;
		if(fldValue==''){
			continue;
		}
		var valueArray=fldValue.split(",");
		var flag=valueArray[3];
		
		if(flag=='true'){
			
			var varDpName=valueArray[2];
			if(varDpName==''){
				alert("The Display Name is required.");
				return false;
			}
			
			if(!validateRestrictedChars(varDpName,"Display Name "+varDpName+" contains invalid character")){
				return false;
			}
			if(!validateReservedWords(varDpName,"Display Name "+varDpName+" cannot be a reserved word.")){
				return false;
			}

			var value=jQuery.inArray(varDpName,dpNamesList);
			if(value!=-1){
				alert("Duplicate Display Name :"+varDpName);
				return false;
			}else{
				dpNamesList.push(varDpName);
			}
			
		}
		
	}
	
	return true;
	
	
}

function validateApplicationName(){
	
	var appName=document.getElementById("submitAppName").value;
	if(appName==null || appName==''){
		alert("The Name field is required.");
		return false;
	}
	
	if(appName.length>32){
		alert("That application name "+appName+" cannot be more than 32 characters long.");
		return false;
	}
	
	if(!validateRestrictedChars(appName,"The Name field contains invalid character")){
		return false;
	}
	
	if(!validateReservedWords(appName,"The application name "+appName+" cannot be a reserved word.")){
		return false;
	}
	return true;
}

function validateDescription(){
	
	var desr=document.getElementById("submitDesc").value;
	
	if(desr==null || desr==''){
		alert("The Application Description field is required.");
		return false;
	}
	return true;
}


function validateRestrictedChars(varName,msg){
	
	var restrictedChars=document.getElementById("restrictedChars").value;
	var varNameLength=varName.length;
	
	if(!isNaN(varName[0])){
		alert(msg+" ' "+varName[0]+" '");
		return false;
	}
	for(var i=0;i<varNameLength;i++){
		
		if(restrictedChars.indexOf(varName[i])!=-1){
			alert(msg+" "+varName[i]);
			return false;
		}
		
	}
	return true;
}

function validateReservedWords(varName,msg){
	
	var wordsArray=["abstract","assert","boolean","break","byte","byvalue", "case","cast","default","do","double","else", "extends",
	                "false","final","goto","if","implements","import","inner","instanceof","int","operator","outer","package",
	                "private","protected","public","rest","synchronized","this","throw","throws","transient","true","try",
	                "catch", "char","class","const","continue","finally","float","for","future","generic","interface","long",
	                "native","new","null","return","short","static","super","switch","var","void","volatile","while", "clone",
	                "equals","finalize","getClass","hashCode","notify","notifyAll","toString","wait","auto","enum","extern",
	                "register","signed","sizeof","static","struct","typedef","union", "unsigned","asm","delete","friend",
	                "inline","template","virtual"];
	
	var value=jQuery.inArray(varName,wordsArray);
	
	if(value!=-1){
		alert(msg);
		return false;
	}
	
	return true;
}

function validateUploadData(){
	
	var varConnections=document.getElementsByName("connections");
	
	for(var i=0;i<varConnections.length;i++){
		if(varConnections[i].checked){
			return true;
		}
	}

	alert("At least one account must be selected.");
	return false;
	
}
