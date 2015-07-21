<HTML>
  <HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


<TITLE>Integration Server -- Keystore Management -- Keystore/Truststore</TITLE>
<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
<SCRIPT SRC="webMethods.js.txt"></SCRIPT>

<SCRIPT LANGUAGE="JavaScript">
      var isLocationChanged = 'false';

      function confirmAdd () {
	      	var type="%value type%";	     
      		var mode=document.addform.mode.value;
	
		if(mode.search('edit_')==-1){
			if(!checkLegalName(document.addform.keyStoreName, "Alias")){
				return false;
			}
			if (!validateFields()) 
	      		{
	      			alert(errorMsg);
	      			return false;
	      		}  
	      	
			if (!isKeyStorePasswordValid())
	      		{
	      			alert("Please verify the keystore password");
	      			return false;
	      		}

	      		var storeName=document.addform.keyStoreName.value;
	      		if (isDuplicateAlias(storeName)){
	      			var msg="Do you want to overwrite existing alias " + storeName + "?";
	      			if(!confirm(msg))
		  				return false;
      			}
      		}

      		if(type=='key' && mode=='add'){
      			document.addform.mode.value='edit_add';
      		}
      		else if(type=='key' && mode=='edit'){
      			document.addform.mode.value='edit_edit';
      		}
  			
        	document.addform.submit();
           	return true;
      }
      
      var errorMsg = "";
	  function validateFields()
	  {
	  	var type="%value type%";
	  	 if ( document.addform.keyStoreName.value == "")
	  	 {
	  	 	errorMsg = "Please enter the Alias";
	  	 	return false;
	  	 }

		// For Non HSM based keystore, location is must
	  	 if(type == 'key' && document.addform.isHsm[1].checked == true) 
		 {
			if ( document.addform.keyStoreLocation.value == "" ) 
			{
				errorMsg = "Please enter the location";
				return false;
			}
		 }

		 /*
		 var ksType=document.addform.keyStoreType.value;

		if (document.addform.allowNullLocation.checked == false && document.addform.keyStoreLocation.value == "")
		 {
			errorMsg = "Please enter the Location";
			return false;
		 }
		 
		 if (document.addform.allowNullLocation.checked == true)  {
			document.addform.nullKSLocation.value = true;
		}
		else {
			document.addform.nullKSLocation.value = false;
		}

		 if (document.addform.allowNullPasswd.checked == false && document.addform.keyStorePassword.value == "")
		 {
			errorMsg = "Please enter the Password";
			return false;
		 }
		 
		 if (document.addform.allowNullPasswd.checked == true)  {
			document.addform.nullKSPasswd.value = true;
		}
		else {
			document.addform.nullKSPasswd.value = false;
		}
		*/
		return true;	  	 		
	  }
	  
	  
	  function checkLegalName(field, fieldName)
      	  {
            var name = field.value;
            var illegalChars = "- #&@^!%*:$./\\`;,~+=)(|}{][><\"?";

            for (var i=0; i<illegalChars.length; i++)
            {
              if (name.indexOf(illegalChars.charAt(i)) >= 0)
              {
                alert (fieldName + " contains illegal character: '" + illegalChars.charAt(i) + "'");
                return false;
              }
            }
            return true;
          }
	  
      function confirmEdit() {
      var type="%value type%";
      		if(type == 'key' && isLocationChanged == 'true') {
      			document.addform.keyStoreLocationChanged.value=true;
      			if(! confirm('Changing the keystore location will cause older key aliases to be removed from the configuration. OK to change it?')) {
      				return false;
      			}
      		}
      		var mode=document.addform.mode.value;
      		if(mode.search("edit_")==-1)
		{
			if ( !validateFields()) 
	      		{
	      			alert(errorMsg);
	      			return false;
	      		}      		      
	      		if (!isKeyStorePasswordValid())
	      		{
	      			alert("Please verify the keystore password");
	      			return false;
	      		}
		}
      		if (!isAliasPasswordsValid())
      		{
      			var aliases = "";
      			for (var i = 0; i < invalidAlias.length; i++)
      			{
      				aliases = aliases + invalidAlias[i];
      				if (i+1 < invalidAlias.length)
      					aliases = aliases + ",";
      			}
   				alert("Please verify the password(s) for the following aliases:\n " + aliases);
      			return false;
      		}
      		if(type=='key' && mode=='add'){
      			document.addform.mode.value='edit_add';
      		}
      		else if(type=='key' && mode=='edit'){
      			document.addform.mode.value='edit_edit';
      		}
      		
      		document.addform.submit();
           	return true;
      }
      
      function isDuplicateAlias(alias){
      
	      for(var i=0;i<existingStoreAliases.length;i++){
	      	if(existingStoreAliases[i].toLowerCase()==alias.toLowerCase()){
	      		return true;
	      	}
	      }
      	  
      	  return false;
      }

      var invalidAlias = null;
      function isAliasPasswordsValid()
      {
			invalidAlias = new Array();      	
      		var aliases 		= document.getElementsByName('pkAliases');
      		var aliasPasswds 	= document.getElementsByName('pkPasswords');
      		var reAliasPasswds	= document.getElementsByName('re_pkPasswords');
      		
      		var idx = 0;
      		for(var i =0; i <aliasPasswds.length; i++)
      		{
      			if (aliasPasswds[i].value != reAliasPasswds[i].value)
      				invalidAlias[idx++] = aliases[i].value;
      		}
      		if (idx != 0)
      			return false;
      		else
	      		return true;
      }

      function isKeyStorePasswordValid()
      {	
   	   	 if ( document.addform.keyStorePassword.value != document.addform.retype_keyStorePassword.value )
   	   	 	return false;
   	   	 
   	   	 return true
	  }
	  
	  var hiddenOptions = new Array();   
	  var aliasList = new Array();
	  var configuredAliases = new Array();
	  var existingStoreAliases=new Array();
	  var selectedKS="JKS";
	  var selectedPS="Sun";
	  var nullPKpasswds = new Array();

	  function setupKeystoreData()
	  {
	  		var idx = 0;
			%ifvar mode matches('edit_*')%
				%invoke wm.server.security.keystore:loadStore%
					%ifvar type equals('key')%
						%ifvar isError equals('true')%
							%rename oldMode mode -copy%
						%endif%
					%endif%
					%scope keyStore%
							selectedKS = "%value keyStoreType%";
							selectedPS = "%value keyStoreProvider%";
					 		%loop configuredKeyAliases%
					 			aliasArray[idx] = "%value keyAlias%";
					 			configuredAliases[idx] = "%value keyAlias%";
					 			bitArray[idx] = 0;
								nullPKpasswds[idx] = "%value nullPassword%";
					 			idx++;
					 		%endloop%
					 		
					 		%loop nonConfiguredKeyAliases%
						 		aliasArray[idx] = "%value%";
					 			bitArray[idx] = 0;
								nullPKpasswds[idx] = "false";
					 			idx++;
					 		%endloop%
					%endscope%
				%endinvoke%	              	             
			%endif%
			
		  	%ifvar mode matches('edit_*')%
		  	%else%
		       	var ks = document.addform.keyStoreType.options;
		       	%ifvar type equals('key')%
				       	%scope param(type='key')%
				           	%invoke wm.server.security.keystore:listKeyStoreTypes%	
					       	   %loop keyProviderList%
					       			ks.length=ks.length+1;
						       		ks[ks.length-1] = new Option("%value keyStoreType%","%value keyStoreType%");
						       	
						       	   	var providers = new Array();			       		
					    	   		%loop providerList%
					       				providers[%value $index%] = new Option("%value provider%","%value provider%");		
					       			%endloop%
					       			
						       		hiddenOptions[ks.length-1] = providers;
					       	   %endloop%
						    %endinvoke%
					    %endscope%
				  %else%
					  		%scope param(type='trust')%
					           	%invoke wm.server.security.keystore:listKeyStoreTypes%	
						       	   %loop keyProviderList%
						       			ks.length=ks.length+1;
							       		ks[ks.length-1] = new Option("%value keyStoreType%","%value keyStoreType%");
							       	
							       	   	var providers = new Array();			       		
						    	   		%loop providerList%
						       				providers[%value $index%] = new Option("%value provider%","%value provider%");		
						       			%endloop%
						       			
							       		hiddenOptions[ks.length-1] = providers;
						       	   %endloop%
							    %endinvoke%
					    	%endscope%
				  %endif%
						      	var ks = document.addform.keyStoreType.options;
						      	var position=0;
			       				for(var i=0; i<ks.length; i++) {
						      			if(selectedKS == ks[i].value) {
						      				ks[i].selected = true;
						      				position++;
						      			}
						      	}
								changeval();
						      	var ps = document.addform.keyStoreProvider.options;
			       				for(var i=0; i<ps.length; i++) {
						      			if(selectedPS == ps[i].value) {
						      				ps[i].selected = true;
						      			}
						      	}
			%endif%
			
			if(idx>0){
				document.addform.configuredAliases.value = configuredAliases;
				document.addform.bitarray.value = bitArray;
				document.addform.nullPKpasswds.value = nullPKpasswds;
			}
       		
       		%ifvar isError equals('true')%
	       		var tempmode = document.addform.oldMode.value;
	       		if(tempmode != '')
					document.addform.mode.value=tempmode;
			%endif%

			if(document.addform.mode.value=="add"){
				if("%value type%" == "key"){
				  %invoke wm.server.security.keystore:listKeyStoreAliases%
				  	 %loop keyStoreAliasNames%
					  	existingStoreAliases.length=existingStoreAliases.length+1;
				  		existingStoreAliases[existingStoreAliases.length-1] = "%value%";
				  	 %endloop%
				  %endinvoke%
				}
				else{
					%invoke wm.server.security.keystore:listTrustStoreAliases%
					   %loop trustStoreAliasNames%
					  		existingStoreAliases.length=existingStoreAliases.length+1;
				  		    existingStoreAliases[existingStoreAliases.length-1]="%value%";
				  	    %endloop%
				  	%endinvoke%
				}
			}
		
			return true;
       }
       
       function changeval() {
       		
       		var ks = document.addform.keyStoreType.options;
       		var selectedKS = document.addform.keyStoreType.value;
       		
       		for(var i=0; i<ks.length; i++) {
       			if(selectedKS == ks[i].value) {
       				var providers = hiddenOptions[i];
       				document.addform.keyStoreProvider.options.length = providers.length;
       				for(var j=0;j<providers.length;j++) {
       					document.addform.keyStoreProvider.options[j] = providers[j];
       				}
       			}
       		}
		}
		var bitArray = new Array();
		var aliasArray = new Array();
		
		function setNullPassword(alias, checkboxObj)
		{
			for (var i = 0; i < aliasArray.length; i++)
			{
				if (aliasArray[i] == alias)
				{
					if ( checkboxObj.checked == true) {
						nullPKpasswds[i] = "true";
					}
					else
					{
						nullPKpasswds[i] = "false";
					}
				}
			}
			document.addform.aliasarray.value = aliasArray;
			document.addform.nullPKpasswds.value = nullPKpasswds;
		}

		function setPasswdChanged(alias)
		{
			for (var i = 0; i < aliasArray.length; i++)
			{
				if (aliasArray[i] == alias)
				{
					bitArray[i] = 1;
				}
			}
			document.addform.aliasarray.value = aliasArray;
			document.addform.bitarray.value = bitArray;
		}
		
		function confirmLocationChange(){
			isLocationChanged = 'true';
		}
	
  </SCRIPT>
	<base target="_self">
	<style>
	  .listbox  { width: 100%; }
	</style>
  </HEAD>

  			%ifvar mode equals('edit')%
          				%ifvar type equals('key')%
							<BODY onLoad="setupKeystoreData();setNavigation('security-keystoremgt-keystore.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_EditKeystoreAliasScrn');">
  						%else%
							<BODY onLoad="setupKeystoreData();setNavigation('security-keystoremgt-keystore.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_EditTruststoreAliasScrn');">         
       					%endif% 
     		%else%
          		%ifvar mode equals('view')%
			       		%ifvar type equals('key')%
							<BODY onLoad="setNavigation('security-keystoremgt-keystore.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_ViewKeystoreAliasScrn');">
  						%else%
							<BODY onLoad="setNavigation('security-keystoremgt-keystore.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_ViewTruststoreAliasScrn');">
       					%endif%
					
    	  		%else%
			       		%ifvar type equals('key')%
			       			%ifvar mode equals('edit_edit')%
								<BODY onLoad="setupKeystoreData();setNavigation('security-keystoremgt-keystore.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_EditKeystoreAliasScrn');">
							%else%
								<BODY onLoad="setupKeystoreData();setNavigation('security-keystoremgt-keystore.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_CreateKeystoreAliasScrn');">
							%endif%
			  			%else%
							<BODY onLoad="setupKeystoreData();setNavigation('security-keystoremgt-keystore.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_CreateTruststoreAliasScrn');">
			       		%endif%
				%endif%
            %endif%
  
  
    <TABLE width="100%">
	      	          	
      <TR>
        <TD colspan=2 class="menusection-Security">
          	Security &gt;
          	Keystore &gt;
          	
     		%ifvar mode equals('edit')%
          				%ifvar type equals('key')%
							Edit Keystore Alias
  						%else%
							Edit Truststore Alias         
       					%endif% 
     		%else%
          		%ifvar mode equals('view')%
			       		%ifvar type equals('key')%
							View Keystore Alias
  						%else%
							View Truststore Alias         
       					%endif%
					
    	  		%else%
			       		%ifvar type equals('key')%
			       			%ifvar mode equals('edit_edit')%
								Edit Keystore Alias
							%else%
								Create Keystore Alias
							%endif%
			  			%else%
							Create Truststore Alias         
			       		%endif%
				%endif%
            %endif%
        </TD>
        
      </TR>
	  	%ifvar isError equals('true')%
		  	<tr><td colspan="2"></td></tr>
		  	<TR><TD class="message" colspan="2">%value message%</TD></TR>
		  	<TR><TD colspan="2"><IMG SRC="images/blank.gif" width=10 height=10 border=0></TD></TR>
	  	%else%
	  		%ifvar isWarning equals('true')%
		  		<tr><td colspan="2"></td></tr>
		  		<TR><TD class="message" colspan="2">%value message%</TD></TR>
		  		<TR><TD colspan="2"><IMG SRC="images/blank.gif" width=10 height=10 border=0></TD></TR>
	  		%endif%
		%endif%
      
      <TR>
        <TD colspan=2>
          <UL>
            <LI><A HREF="security-keystoremgt.dsp">Return to Keystore</A></LI>
            %ifvar mode equals('view')%
            	<LI><A HREF="security-keystoremgt-keystore.dsp?mode=edit&keyStoreName=%value -urlencode keyStoreName%&type=%value -urlencode type%">Edit 
	            	%ifvar type equals('key')%
		    			Keystore Alias
		      		%else%
		    			Truststore Alias         
	       			%endif%
	            	</A>
            	</LI>            
            %endif%
          </UL>
        </TD>
      </TR>

      <TR>
        <TD><IMG SRC="images/blank.gif" width=10 height=10 border=0></TD>
        <TD>
		%ifvar mode equals('view')%  <!-- View keystore/truststore alias block-->
		   <TABLE class="tableForm">
			%invoke wm.server.security.keystore:getKeyStore%
				%scope keyStore%
			      <TR>
					%ifvar ../type equals('key')%
				        <TD colspan="2" class="heading">Keystore Properties</TD>
				     %else%
					     <TD colspan="2" class="heading">Truststore Properties</TD>
				     %endif%
			      </TR>
		          <TR>
		            <TD class="oddrow"><B>Alias</B></TD>
		            <TD class="oddrow-l"><B>%value keyStoreName%</B></TD>
		          </TR>
				  <TR>
		            <TD class="evenrow"><B>Description(optional)</B></TD>
		            <TD class="evenrow-l">%value keyStoreDescription%</TD>
		          </TR>		          
		          <TR>
		            <TD class="oddrow"><B>Type</B></TD>
		            <TD class="oddrow-l">%value keyStoreType%</TD>
		          </TR>
		          <TR>
		            <TD class="evenrow"><B>Provider</B></TD>
		            <TD class="evenrow-l">%value keyStoreProvider%</TD>
		          </TR>
		          <TR>
		            <TD class="oddrow"><B>Location</B></TD>
		            <TD class="oddrow-l">%value keyStoreLocation%</TD>
		          </TR>
		           %ifvar ../type equals('key')%
			      <tr>
				<td class="evenrow"><B>HSM Based Keystore</B></td>
				<td class="evenrow-l">%value -code isHsm%</td>
		              </tr>		        
		          %endif%  
			  %ifvar ../type equals('key')%
				 <TR>
			            <TD class="oddrow-l" valign="top"><B>Configured Key Aliases</B></TD>
			            <TD class="oddrow-l">	
			            	<TABLE>	
				            	%loop configuredKeyAliases%
				            		<TR>
				            			<TD>%value keyAlias%</TD>
				            		</TR>
			            		%endloop%
			            	</TABLE>
			            </TD>
			          </TR>
		          %else%
				<TR>
					<TD class="evenrow" valign="top"><B>Certificate Aliases</B></TD>
					<TD class="evenrow-l">
						<TABLE>
				            	%loop certficateAliases%
				            		<TR>
				            			<TD>%value%</TD>
				            		</TR>
			            		%endloop%
			            	</TABLE>
					</TD>
				</TR>
		          %endif%
				%endscope%
			%endinvoke%   
			</TABLE> 
			<BR>
			<TABLE class="tableForm" width=100%>
				%ifvar errorMessage equals('')%
				%else%
					<TR>
			        <TD colspan="5" class="heading">Load Error</TD>
				</TR>
					<TD class="oddrow-l">%value errorMessage%</TD>
				%endif%
			</TABLE>
		%else%
		    <TABLE class="tableForm">
			<TR>
					%ifvar type equals('key')%
				        <TD colspan="2" class="heading">Keystore Properties</TD>
				     %else%
					     <TD colspan="2" class="heading">Truststore Properties</TD>
				     %endif%
			 </TR>
		    <FORM NAME="addform" ACTION=
		    							%ifvar type equals('key')% 
		    								%ifvar mode matches('edit_*')%
		    									"security-keystoremgt.dsp"
		    								%else%
		    									"security-keystoremgt-keystore.dsp"
		    								%endif%
		    							%else%
		    								"security-keystoremgt.dsp"
		    							%endif%
		    							 METHOD="POST">
		    	          
		    		<input type="hidden" name="aliasarray" value="">
		    		<input type="hidden" name="bitarray" value="">		    		
		    		<input type="hidden" name="configuredAliases" value="">
				<input type="hidden" name="nullKSPasswd">
				<input type="hidden" name="nullKSLocation">
				<input type="hidden" name="nullPKpasswds" value="">
		    				    		
		    %ifvar mode matches('edit*')% <!-- Edit keystore/truststore alias block-->
		     	%ifvar mode equals('edit')% <!-- Edit keystore/truststore alias block-->
						%invoke wm.server.security.keystore:getKeyStore%
						%scope keyStore%
				        <TR>
				        	<TD class="oddrow">Alias</TD>
				          	<TD class="oddrow-l">
				          	<B>%value keyStoreName%</B>
				          	<INPUT TYPE="hidden" NAME="keyStoreName" VALUE="%value keyStoreName%"> 
				          	</TD>
				        </TR>
				        <TR>
				        	<TD class="evenrow">Description(optional)</TD>
				          	<TD class="evenrow-l"><INPUT NAME="keyStoreDescription" VALUE="%value keyStoreDescription%"> </TD>
				        </TR>
					    <TR>
					        <TD class="oddrow">Type</TD>
					        <TD class="oddrow-l"><SELECT NAME="keyStoreType" class="listbox" onchange="changeval()"></SELECT></TD>		
					    </TR>
					    <TR>
					        <TD class="evenrow">Provider</TD>
					       	<TD class="evenrow-l"><SELECT class="listbox" NAME="keyStoreProvider"></SELECT></TD>
					    </TR>
						<TR>
					        <TD class="oddrow">Location</TD>
					    	<TD class="oddrow-l">
							<INPUT size="40" NAME="keyStoreLocation" VALUE="%value keyStoreLocation%" onChange="confirmLocationChange();">
							<INPUT TYPE="hidden" NAME="keyStoreLocationChanged" VALUE="false">
					    	</TD>
				    	</TR>		          
				        <TR>
				           	<TD class="evenrow">Password </TD>
				           	<TD class="evenrow-l">
						        %ifvar nullKSPassword equals('true')%
					           		<INPUT TYPE="password" NAME="keyStorePassword" autocomplete="off" VALUE="" onChange="document.addform.keyStorePasswordChanged.value=true;"/>
							%else%
					           		<INPUT TYPE="password"  NAME="keyStorePassword" autocomplete="off"  VALUE="******" onChange="document.addform.keyStorePasswordChanged.value=true;"/>
							%endif%
				           		<INPUT TYPE="hidden" NAME="keyStorePasswordChanged" VALUE="false">
				           	</TD>
				        </TR>
				        <TR>
				            <TD class="oddrow">Re-type Password</TD>
					     %ifvar nullKSPassword equals('true')%
					            <TD class="oddrow-l"><INPUT TYPE="password" NAME="retype_keyStorePassword"  autocomplete="off" VALUE=""/></TD>
					     %else%
						    <TD class="oddrow-l"><INPUT TYPE="password" NAME="retype_keyStorePassword"  autocomplete="off" VALUE="******"/></TD>
					     %endif%
				        </TR>
	

				        %ifvar ../type equals('key')%
					    <tr>
						    <td class="oddrow">HSM Based Keystore</td>
						    <td class="oddrow-l">
								%ifvar isHsm equals('true')%
									<INPUT TYPE="radio" NAME="isHsm" VALUE="true" checked>True</INPUT>
							        <INPUT TYPE="radio" NAME="isHsm" VALUE="false">False</INPUT>
							    %else%
									<INPUT TYPE="radio" NAME="isHsm" VALUE="true" >True</INPUT>
							        <INPUT TYPE="radio" NAME="isHsm" VALUE="false" checked>False</INPUT>
								%endif%
						    </td>
						</tr>	
						%endif%
				        <TR>
				           	<TD><IMG SRC="images/blank.gif" width=10 height=10 border=0></TD>
				        </TR>
					%endscope%				
					%endinvoke%
				%else% <!-- edit_add/edit_edit start-->
						%invoke wm.server.security.keystore:loadStore%
					%scope keyStore%
			        <TR>
			        	<TD class="oddrow"><B>Alias</B></TD>
			        	<TD class="oddrow-l">
			        	%value keyStoreName%
			          	<INPUT TYPE="hidden" NAME="keyStoreName" VALUE="%value keyStoreName%"> 
			          	</TD>
			        </TR>
			        <TR>
			        	<TD class="evenrow"><B>Description(optional)</B></TD>
			          	<TD class="evenrow-l">
			          	%value keyStoreDescription%
			          	<INPUT TYPE="hidden" NAME="keyStoreDescription" VALUE="%value keyStoreDescription%"> 
			          	</TD>
			        </TR>
				    <TR>
				        <TD class="oddrow"><B>Type</B></TD>
				        <TD class="oddrow-l">
				        %value keyStoreType%
				        <INPUT TYPE="hidden" NAME="keyStoreType" VALUE="%value keyStoreType%"> 
				        <!-- <SELECT NAME="keyStoreType" class="listbox" onchange="changeval()"></SELECT> -->
				        </TD>		
				    </TR>
				    <TR>
				        <TD class="evenrow"><B>Provider</B></TD>
				       	<TD class="evenrow-l">
				       	%value keyStoreProvider%
				       	<INPUT TYPE="hidden" NAME="keyStoreProvider" VALUE="%value keyStoreProvider%"> 
				       	<!-- <SELECT class="listbox" NAME="keyStoreProvider"></SELECT> -->
				       	</TD>
				    </TR>
					<TR>
				        <TD class="oddrow"><B>Location<B></TD>
				    	<TD class="oddrow-l">
				    	%value keyStoreLocation%
				    	<INPUT TYPE="hidden" NAME="keyStoreLocation" VALUE="%value keyStoreLocation%" onChange="confirmLocationChange();"></TD>
				    	<INPUT TYPE="hidden" NAME="keyStoreLocationChanged" VALUE="%value keyStoreLocationChanged%">
			    	</TR>
			    	<INPUT TYPE="hidden" NAME="keyStorePassword" VALUE="%value keyStorePassword%">
			    	<INPUT TYPE="hidden" NAME="keyStorePasswordChanged" VALUE="%value keyStorePasswordChanged%">
				    <tr>
					    <td class="evenrow"><B>HSM Based Keystore</B></td>
					    <td class="evenrow-l">
							%ifvar isHsm equals('true')%
								true
						    %else%
								false
							%endif%
							<INPUT TYPE="hidden" NAME="isHsm" VALUE="%value isHsm%">
					    </td>
					</tr>	
			        <TR>
			           	<TD><IMG SRC="images/blank.gif" width=10 height=10 border=0></TD>
			        </TR>
			        %ifvar ../type equals('key')%
						       
						%ifvar configuredKeyAliases -isnull%
								%ifvar nonConfiguredKeyAliases -isnull%
								
								%else%
									%ifvar nonConfiguredKeyAliases -notempty%
									<TR>
						            			<TD colspan="2" class="heading" valign="top"><B>Key Aliases</B></TD>
				        				</TR>

									<TR>   
							          	<TD class="oddrow">Alias</TD>
							          	<TD class="oddrow-l" hAlign="left">
							          		<table width="100%">
							          			<tr>
							          				<td class="oddrow-l" width="50%">Password</td>
							          				<td class=""oddrow-l" width="50%">Re-type Password</td>
												<td class=""oddrow-l" width="50%">Null</td>
							          			</tr>
							          		</table>
							          	</TD>
									</TR>
									%else%
																	
									%endif%	
								%endif%
						%else%
								%ifvar configuredKeyAliases -notempty%
								<TR>
									<TD colspan="2" class="heading" valign="top"><B>Key Aliases</B></TD>
								</TR>

								<TR>   
						          	<TD class="oddrow">Alias</TD>
						          	<TD class="oddrow-l" hAlign="left">
						          		<table width="100%">
						          			<tr>
						          				<td class="oddrow-l" width="50%">Password</td>
						          				<td class=""oddrow-l" width="50%">Re-type Password</td>
											<td class=""oddrow-l" width="50%">Null</td>
						          			</tr>
						          		</table>
						          	</TD>
								</TR>
								%else%
									%ifvar nonConfiguredKeyAliases -isnull%
									%else%
										%ifvar nonConfiguredKeyAliases -notempty%
										<TR>
						            				<TD colspan="2" class="heading" valign="top"><B>Key Aliases</B></TD>
						        			</TR>

											<TR>   
									          	<TD class="oddrow">Alias</TD>
									          	<TD class="oddrow-l" hAlign="left">
									          		<table width="100%">
									          			<tr>
									          				<td class="oddrow-l" width="50%">Password</td>
									          				<td class=""oddrow-l" width="50%">Re-type Password</td>
														<td class=""oddrow-l" width="50%">Null</td>
									          			</tr>
									          		</table>
									          	</TD>
											</TR>								
										%endif%	
									%endif%						
								%endif%
						%endif%	
						
				        %loop configuredKeyAliases%
					          <TR>
							  	<script>writeTD("rowdata-r");</script>%value keyAlias%
								  		<INPUT NAME="pkAliases" TYPE="hidden" value="%value keyAlias%"></TD>
					            <script>writeTD("rowdata");</script>
							            <table width="100%">
						          			<tr>
						          				<script>writeTD("rowdata");</script><INPUT TYPE="password" autocomplete="off" ID="%value keyAlias%" %ifvar nullPassword equals('false')% value="******" %else% value="" %endif% NAME="pkPasswords"  onChange="setPasswdChanged(this.id);"/></td>
						          				<script>writeTD("rowdata");</script><INPUT TYPE="password"  autocomplete="off" NAME="re_pkPasswords" %ifvar nullPassword equals('false')% value="******" %else% value="" %endif%/> </td>
											<script>writeTD("rowdata");</script><INPUT TYPE="checkbox" NAME="nullPKPassword" onchange="setNullPassword('%value keyAlias%', this)" %ifvar nullPassword equals('true')% checked %endif%></td>
						          			</tr>
						          		</table>
					             </TD>
				         	 </TR>
				         	 <script>swapRows();</script>
				        %endloop%
	
				        %loop nonConfiguredKeyAliases%
						    <TR>
								  	<script>writeTD("rowdata-r");</script>%value%
								  		<INPUT NAME="pkAliases" TYPE="hidden" value="%value%"></TD>
						            <script>writeTD("rowdata");</script>
						            	<table width="100%">
						          			<tr>
						          				<script>writeTD("rowdata");</script><INPUT TYPE="password" ID="%value%" NAME="pkPasswords" autocomplete="off" VALUE="" onChange="setPasswdChanged(this.id);"/></td>
						          				<script>writeTD("rowdata");</script><INPUT TYPE="password" NAME="re_pkPasswords" autocomplete="off" VALUE=""/></td>
											<script>writeTD("rowdata");</script><INPUT TYPE="checkbox" NAME="nullPKPassword" onchange="setNullPassword('%value%', this)"></td>
						          			</tr>
						          		</table>
						             </TD>
					        </TR>
					        <script>swapRows();</script>	
				        %endloop%
				      %endif%
				%endscope%				
				%endinvoke%
			    %endif%<!-- edit_add/edit_edit end-->
			%else% <!-- Add keystore/truststore alias block-->
				<TR>
			        <TD class="oddrow">Alias</TD>
			        <TD class="oddrow-l"><INPUT NAME="keyStoreName" VALUE="%value keyStoreName%"> </TD>
			    </TR>
				<TR>
			       	<TD class="evenrow">Description(optional)</TD>
			       	<TD class="evenrow-l"><INPUT NAME="keyStoreDescription" VALUE="%value keyStoreDescription%"> </TD>
			    </TR>			    
			    <TR>
			        <TD class="oddrow">Type</TD>
			        <TD class="oddrow-l"><SELECT NAME="keyStoreType" class="listbox" onchange="changeval()"></SELECT></TD>		
			    </TR>
			    <TR>
			        <TD class="evenrow">Provider</TD>
			       	<TD class="evenrow-l"><SELECT class="listbox" NAME="keyStoreProvider"></SELECT></TD>
			    </TR>
				<TR>
			        <TD class="oddrow">Location</TD>
			    	<TD class="oddrow-l">
					<INPUT size="40" NAME="keyStoreLocation" VALUE="%value keyStoreLocation%">
				</TD>
				
		    	</TR>		          
		        <TR>
		           	<TD class="evenrow">Password </TD>
		           	<TD class="evenrow-l">
		           		<INPUT TYPE="password" NAME="keyStorePassword" autocomplete="off" VALUE="%value keyStorePassword%" />
			           	<INPUT TYPE="hidden" NAME="keyStorePasswordChanged" VALUE="true">
			        </TD>
		        </TR>
			<TR>
		           	<TD class="oddrow">Re-type Password</TD>
				<TD class="oddrow-l"><INPUT TYPE="password" NAME="retype_keyStorePassword"  autocomplete="off" VALUE="%value retype_keyStorePassword%"/></TD>
		        </TR>
		        %ifvar type equals('key')%
			    <tr>
				    <td class="oddrow">HSM Based Keystore</td>
					<td class="oddrow-l">				    
						%ifvar isHsm equals('true')%
							<INPUT TYPE="radio" NAME="isHsm" VALUE="true" checked>True</INPUT>
					        <INPUT TYPE="radio" NAME="isHsm" VALUE="false">False</INPUT>
					    %else%
							<INPUT TYPE="radio" NAME="isHsm" VALUE="true" >True</INPUT>
					        <INPUT TYPE="radio" NAME="isHsm" VALUE="false" checked>False</INPUT>
						%endif%
				    </td>
				 </tr>	
			%endif%
			%endif%
			<TR>
		    	<TD colspan=2 class="action">
		              <INPUT TYPE="hidden" NAME="args" VALUE="xxx">
	              %ifvar type equals('key')%
	              	 %ifvar mode matches('edit_*')%
		              <INPUT TYPE="hidden" NAME="mode" VALUE="%value mode%">
		              <INPUT TYPE="hidden" NAME="oldkeyStoreName" VALUE="%value keyStoreName%">
		              <INPUT TYPE="hidden" NAME="type" VALUE="%value type%">
		              <INPUT type="button" value="Save Changes" onclick="return confirmEdit();">
		            %else%
		              %ifvar mode equals('edit')%
		              		<INPUT TYPE="hidden" NAME="oldMode" VALUE="edit">
		              		 <INPUT TYPE="hidden" NAME="mode" VALUE="%value mode%">
		              		<INPUT TYPE="hidden" NAME="type" VALUE="%value type%">
		              		<INPUT type="button" value="Submit" onclick="return confirmEdit();">
		              %else%
		              		<INPUT TYPE="hidden" NAME="oldMode" VALUE="add">
		              		 <INPUT TYPE="hidden" NAME="mode" VALUE="%value mode%">
		              		<INPUT TYPE="hidden" NAME="type" VALUE="%value type%">
		              		<INPUT type="button" value="Submit" onclick="return confirmAdd();">
		              %endif%
		              
		             
		              
		            %endif%
	              %else%
		            %ifvar mode equals('edit')%
		              <INPUT TYPE="hidden" NAME="mode" VALUE="edit">
		              <INPUT TYPE="hidden" NAME="oldkeyStoreName" VALUE="%value keyStoreName%">
		              <INPUT TYPE="hidden" NAME="type" VALUE="%value type%">
		              <INPUT type="button" value="Save Changes" onclick="return confirmEdit();">
		            %else%
		              <INPUT TYPE="hidden" NAME="mode" VALUE="add">
		              <INPUT TYPE="hidden" NAME="type" VALUE="%value type%">
		              <INPUT type="button" value="Save Changes" onclick="return confirmAdd();">
		            %endif%
		         %endif%
		        </TD>
		    </TR>
			</FORM>
		    </TABLE>
	    
        </TD>
        </TR>
        %endif%
      </TABLE>
    </BODY>
  </HTML>
