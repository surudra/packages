<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<SCRIPT src="webMethods.js"></SCRIPT>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<BODY>
<SCRIPT language=JavaScript>
</SCRIPT>

<SCRIPT>
function getAsterisk(value) {
	var pwd = "";
	for (count=0; count<value.length; count++ ) {
		pwd = pwd + "*";
	}
	return w(pwd);
}
	
</SCRIPT>

<TABLE width=100%>
	<TR>
		<TD class="menusection-Deployer">Target Substitutions and Source Values</TD>
	</TR>
</TABLE>

<TABLE width="100%">


<!- Save -> 
%ifvar actionButton equals('Save Substitutions')%
	<!- All fields on form ->	
	%invoke wm.deployer.gui.UIRepository:saveVarSubProperties%
		
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

%ifvar actionButton equals('Save All')%
	<!- All fields on form ->	
	%invoke wm.deployer.gui.UIRepository:saveVarSubProperties%
		
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%
</TABLE>

<!- Clear -> 
%ifvar actionButton equals('Restore Defaults')%
	<!- All fields on form ->
	%invoke wm.deployer.gui.UIRepository:clearVarSubProperties%
		

	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%  

%ifvar actionButton equals('Clear Substitutions')%
	<!- All fields on form ->
	%invoke wm.deployer.gui.UIRepository:clearVarSubProperties%
		

	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if% 
</TABLE>

<TABLE width=100%>
	<FORM NAME="properties" action="varsub-repoasset-page.dsp" method="POST">
	
		<INPUT type="hidden" name="projectName" value="%value projectName%">
		<INPUT type="hidden" name="assetCompositeName" value='%value assetCompositeName%'>
		<INPUT type="hidden" name="componentName" value='%value componentName%'>
                <INPUT type="hidden" name="projectName" value='%value projectName%'>
		<INPUT type="hidden" name="bundleName" value='%value bundleName%'>		
		<INPUT type="hidden" name="mapSetName" value='%value mapSetName%'>				

	<TR>
		<TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
		<TD>
		<TABLE class="tableForm">
		%invoke wm.deployer.gui.UIRepository:getAssetProperties%
		%include error-handler.dsp%
               <INPUT type="hidden" name="depSetName" value='%value depSetName%'>
	       <INPUT type="hidden" name="serverAliasName" value='%value serverAliasName%'>
	       <INPUT type="hidden" name="logicalServer" value='%value logicalServer%'>
		<INPUT type="hidden" name="runtimeType" value='%value runtimeType%'>
		 %ifvar propertiesExists equals('true')%
			<tr width="40"><td class="evenrow">Runtime Type</td>
				<td class="evenrowdata-l" colspan="6"> %value runtimeType%%ifvar logicalServer -notempty% : %value logicalServer%%endif% </td>
				
			</tr>

			 <SCRIPT>swapRows();</SCRIPT>

			<tr width="40"><td class="oddrow">Composite Name</td>
				<td class="oddrowdata-l" > %value assetCompositeName% </td>
				<td class="oddrow">Implementation Type</td>
				<td class="oddrowdata-l" colspan="4"> %value compositeImplType% </td>
				
			</tr>			 

			%ifvar componentName -notempty%

			<tr width="40"><td class="evenrow">Component(s) Name</td>
				<td style="background-color: #F0F0E0;font-weight: bold" width="40"> %value componentDisplayName% </td>
				<td class="evenrow">Type</td>
				<td class="evenrowdata-l" colspan="4"> %value componentImplType% </td>
			</tr>
			 <SCRIPT>swapRows();</SCRIPT>
			%endif%

			<!- This begins the actual Asset fields ->
			<tr>
				<td class="heading" colspan="6">Asset Properties </td>
			</tr>
		%endif%

	<SCRIPT> resetRows(); var count = 0; </SCRIPT>
			<!- Iterate over parameters document and paint fields ->
			 
	 %loop properties%
	          %loop sourceValue%
	          <SCRIPT> count++; </SCRIPT>
		   %ifvar ../../propertyOnlyOne equals('true')%
		  <SCRIPT> if(count == 1 )  document.write('<tr> <td class="oddrow"><b>Property Name <\/TD>'+ 
			  '<td style="background-color:#E0E0C0;text-align:left"><b> New Value  <\/TD>'+ 
			  '<td style="background-color:#E0E0C0;text-align:left" size="30"> <b> Default Value <\/TD>'+ 
			   '<td style="background-color:#E0E0C0;text-align:left">  <\/TD><\/TR>'); 
		  </SCRIPT>
		  %else%
		   <SCRIPT> if(count == 1 )  document.write('<tr> <td class="oddrow"><b>Property Name <\/TD>'+ 
			  '<td style="background-color:#E0E0C0;text-align:left"><b> New Value  <\/TD>'+ 
			  '<td style="background-color:#E0E0C0;text-align:left" size="30"> <b> Default Value <\/TD>'+ 
			  '<td class="oddrow"><b>Property Name <\/TD>'+ 
			  '<td style="background-color:#E0E0C0;text-align:left"> <b>New Value <\/TD>'+ 
			  '<td style="background-color:#E0E0C0;text-align:left"> <b> Default Value <\/TD> <\/TR>'); 
		  </SCRIPT>
		  %endif%
                  <SCRIPT> if(count %2 == 1)  document.write("<tr>");  </SCRIPT>
					  		     
				<SCRIPT> writeTD("row"); </SCRIPT> %value ../propertyDisplayName% </TD>
				<SCRIPT> writeTD("row-l");  </SCRIPT>
		           %ifvar ../propertyType equals('text')%
		           		<textarea id="%value ../propertyName%" name="%value ../propertyName%"  rows="5" cols="50" style="width:70%">%value propertyExistingValue%</textarea>
		           %else%		           
		           		<input id="%value ../propertyName%" name="%value ../propertyName%"  %ifvar ../isSecure equals('false') %value="%value propertyExistingValue%" %endif%
			       			%ifvar ../isSecure equals('true')% 
							type="password"
			       			%endif%  size="40">
			       %endif%
			       </TD>
			       <SCRIPT> document.write('<td style="background-color:#E0E0C0;text-align:left">'); </SCRIPT> 
			       %ifvar ../isSecure equals('true')% ******
			          %else%
				 %value propertyValue%  </TD>
		              
			        %endif% </SCRIPT>
		  <SCRIPT> if(count %2 == 0) { document.write("</tr>");  swapRows(); } </SCRIPT>
		  
		%endloop sourceValue%
	%endloop properties%
	 %ifvar propertiesExists equals('true')%
			<tr>
				<td colspan="6" class="action">
				<input name="actionButton" type="submit" value="Save Substitutions"> 
				<input name="actionButton" type="submit" value="Restore Defaults"> 
			</tr>
			%else%			 
			   %ifvar assetCompositeName equals('')%
			       <tr>
				 There is no selected composite. Please select composite or component for which to view properties.
				</tr>
			     %else%
				       %ifvar componentName -isnull%
					<tr>
					    There are no properties for '%value assetCompositeName%' composite
					</tr>
					%else%
					<tr>
					    There are no properties for '%value componentName%' component of '%value assetCompositeName%' composite
					</tr>

					%endif%
			    %endif%

			%endif%
 %endinvoke getAssetProperties%	
		
    </TABLE>
	</td>
  </TR>
</FORM>
</TABLE>

</BODY>
</HTML>
