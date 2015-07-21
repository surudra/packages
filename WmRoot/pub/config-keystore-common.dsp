<script language="Javascript">
	  // KeyStore related functions  
	  
	  function setupKeystoreData(formObj)
	  {
	  		formObj.enclosedFormName.value = formObj.name;
	  		%ifvar ../mode equals('edit')%
		       	var ks = formObj.keyStore.options;
				%invoke wm.server.security.keystore:listKeyStoresAndConfiguredKeyAliases%
					//Blank KS and ALIAS combination
					ks.length=ks.length+1;
					ks[ks.length-1] = new Option("","");
					var aliases = new Array();
					aliases[0]= new Option("","");
					hiddenOptions[ks.length-1] = aliases;
					
		       	   %loop keyStoresAndConfiguredKeyAliases%
		       			ks.length=ks.length+1;
			       		ks[ks.length-1] = new Option("%value keyStoreName%","%value keyStoreName%");
		           		var aliases = new Array();
		    	   		%loop keyAliases%
		       				aliases[%value $index%] = new Option("%value%","%value%");		
		       			%endloop%
		       			if (aliases.length == 0)
		       			{
							aliases[0] = new Option("","");		
						}
			       		hiddenOptions[ks.length-1] = aliases;
		       	   %endloop%
		       	%endinvoke%
		       	
		       	var keyOpts = formObj.keyStore.options;
    			var key = formObj.selectedKS.value;
				if ( key != "") 
				{
	       			for(var i=0; i<keyOpts.length; i++) 
	       			{
				    	if(key == keyOpts[i].value) {
				    		keyOpts[i].selected = true;
		    			}
			      	}
				}
				
				changeval(formObj.name);
				
				var aliasOpts = formObj.alias.options;
    			var alias = formObj.selectedAlias.value;
				if ( alias != "") 
				{
	       			for(var i=0; i<aliasOpts.length; i++) 
	       			{
				    	if(alias == aliasOpts[i].value) {
				    		aliasOpts[i].selected = true;
		    			}
			      	}
				}
		      	
			%endif%
			return true;
       }
       
       function changeval(formName) {
       		var f = document.getElementsByName(formName);
       		var formObj = f[0];
       		var ks = formObj.keyStore.options;
       		var selectedKS = formObj.keyStore.value;
       		for(var i=0; i<ks.length; i++) {
       			if(selectedKS == ks[i].value) {
		       		var aliases = hiddenOptions[i];
       				formObj.alias.options.length = aliases.length;
       				for(var j=0;j<aliases.length;j++) {
       					var opt = aliases[j];
       					formObj.alias.options[j] = new Option(opt.text, opt.value);
     				}
       			}
       		}
		}
</script>

<input type="hidden" name="enclosedFormName" value=""/>
<input type="hidden" name="selectedKS" value="%value keyStore%"/>
<input type="hidden" name="selectedAlias" value="%value alias%"/>

%ifvar listenerType equals('regularinternal')%
	<!-- Internal Registration LookNFeel -->
	
	<tr>
		<td class="oddrow">Keystore Alias</td>
		<td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
			%ifvar mode equals('view')%
				 %value keyStore%
			%else%
				 <SELECT NAME="keyStore" class="listbox" onchange="changeval(enclosedFormName.value)"></SELECT>
			%endif%
		</td>
	 </tr>
	 
	 <tr>
		<td class="evenrow" valign="top">Key Alias</td>
		<td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
			%ifvar mode equals('view')%
				 %value alias%
			%else%
				<select name="alias" class="listbox"></select>
			%endif%
		</td>
	 </tr>
	 
	 <tr>
		<td class="oddrow">Truststore Alias</td>
		<td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
			%ifvar mode equals('view')%
				 %value trustStore%
			%else%
				<select name="trustStore" class="listbox">
						%invoke wm.server.security.keystore:listTrustStores%
								<option name="" value=""></option>
							%loop trustStores%
								%ifvar isLoaded equals('true')%
									<option name="%value keyStoreName%" value="%value keyStoreName%" %ifvar ../trustStore vequals(keyStoreName)%selected%endif%>%value keyStoreName%</option>
								%endif%
						   %endloop%
						%endinvoke%
				</select>
			%endif%
		</td>
	 </tr>
 
%else%
	<!-- Other Listener Port's LookNFeel -->
	
	%ifvar ssl equals('true')%
	<tr>
			<td class="oddrow">Use JSSE</td>
		    	<td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
		    	%ifvar mode equals('view')%
		        	%switch useJSSE%
		            	    %case 'yes'%Yes
		            	    %case 'true'%Yes
		                    %case%No
		             %endswitch%
		         %else%
				<input type="radio" name="useJSSE" value="yes" %switch useJSSE%
		            	    %case 'yes'%checked
		            	    %case 'true'%checked
							%case%checked
		             %endswitch%>Yes</input>
				<input type="radio" name="useJSSE" value="no" %switch useJSSE%
		            	    %case 'no'%checked
		            	    %case 'false'%checked
		             %endswitch%>No</input>		         
		          %endif%
		       </td>
	</tr>
	%endif%
	
	<tr>
	   	<td class="heading" colspan="2">Listener Specific Credentials (Optional)</td>
	</tr>
	
	
	 <tr>
		<td class="evenrow">Keystore Alias</td>
		<td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
			%ifvar mode equals('view')%
				 %value keyStore%
			%else%
				 <SELECT NAME="keyStore" class="listbox" onchange="changeval(enclosedFormName.value)"></SELECT>
			%endif%
		</td>
	 </tr>
	 
	 <tr>
		<td class="oddrow" valign="top">Key Alias</td>
		<td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
			%ifvar mode equals('view')%
				 %value alias%
			%else%
				<select name="alias" class="listbox"></select>
			%endif%
		</td>
	 </tr>
	 
	 <tr>
		<td class="evenrow">Truststore Alias</td>
		<td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
			%ifvar mode equals('view')%
				 %value trustStore%
			%else%
				<select name="trustStore" class="listbox">
						%invoke wm.server.security.keystore:listTrustStores%
								<option name="" value=""></option>
							%loop trustStores%
								%ifvar isLoaded equals('true')%
									<option name="%value keyStoreName%" value="%value keyStoreName%" %ifvar ../trustStore vequals(keyStoreName)%selected%endif%>%value keyStoreName%</option>
								%endif%
						   %endloop%
						%endinvoke%
				</select>
			%endif%
		</td>
	 </tr>
%endif%

