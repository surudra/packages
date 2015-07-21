<HTML>
  <HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


    <TITLE>Security Certificates</TITLE>
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
    <SCRIPT LANGUAGE="javascript">
      
      var aliasArray = new Array();
      var keyStoreArray = new Array();
      
      function loadKeyStoresOptions()
      {
      		%invoke wm.server.security.keystore:listKeyStoresAndConfiguredKeyAliases%
      			   var idx = 0;
      			   keyStoreArray[idx] = "";
			       aliasArray[idx++] = new Array(0);
		       	   %loop keyStoresAndConfiguredKeyAliases%
				       	keyStoreArray[idx] = "%value keyStoreName%";
			       		var aliases = new Array();
		    	   		%loop keyAliases%
		       				aliases[%value $index%] = "%value%";
		       			%endloop%
			       		aliasArray[idx] = aliases;
			       		idx++;
		       	   %endloop%
		    %endinvoke%
		    setupKeystoreData();
      }
      
      function updateSelected(ks, val)
      {
      	for (var i = 0; i < ks.options.length; i++)
      	{
      		if ( ks.options[i].value == val)
      		{	
      			ks.options[i].selected = true;
      		}
      	}
      }

      
      function setupKeystoreData()
	  {	
	  		
  			var formObj = document.security;
			formObj.sslKeyStore.options.length = keyStoreArray.length;
			formObj.signKeyStore.options.length = keyStoreArray.length;
			formObj.decryptKeyStore.options.length = keyStoreArray.length;
						
			for (var i = 0; i < keyStoreArray.length; i++)
			{
				formObj.sslKeyStore.options[i] = new Option(keyStoreArray[i],keyStoreArray[i]);
				formObj.signKeyStore.options[i] = new Option(keyStoreArray[i],keyStoreArray[i]);
				formObj.decryptKeyStore.options[i] = new Option(keyStoreArray[i],keyStoreArray[i]);				
			}
			
			var x = document.getElementsByName("watt.security.ssl.keyStoreAlias");
			updateSelected(formObj.sslKeyStore, x[0].value);
	
		  	x = document.getElementsByName("watt.security.sign.keyStoreAlias");
			updateSelected(formObj.signKeyStore, x[0].value);

		  	x = document.getElementsByName("watt.security.decrypt.keyStoreAlias");			
			updateSelected(formObj.decryptKeyStore, x[0].value);
			
			changeval(formObj.sslKeyStore , formObj.sslAlias);
			changeval(formObj.signKeyStore , formObj.signAlias);
			changeval(formObj.decryptKeyStore , formObj.decryptAlias);

		  	x = document.getElementsByName("watt.security.ssl.keyAlias");			
			updateSelected(formObj.sslAlias, x[0].value);

			x = document.getElementsByName("watt.security.sign.keyAlias");			
			updateSelected(formObj.signAlias, x[0].value);
			
			x = document.getElementsByName("watt.security.decrypt.keyAlias");			
			updateSelected(formObj.decryptAlias, x[0].value);
			
			return true;
       }
       
       function changeval(ks, alias) {
       
       		var ksOpts = ks.options;
       		var selectedKS = ks.value;
       		for(var i=0; i<ksOpts.length; i++) {
       			if(selectedKS == ksOpts[i].value) {
		       		var aliases = aliasArray[i];
       				alias.options.length = aliases.length;
       				for(var j=0;j<aliases.length;j++) {
       					alias.options[j] = new Option(aliases[j],aliases[j]);
     				}
       			}
       		}
		}
		
		function saveChanges()
		{
			if ( (document.security.sslAlias.value == "" && document.security.sslKeyStore.value != "" )|| 
				 (document.security.signAlias.value == "" && document.security.signKeyStore.value != "") ||
				 (document.security.decryptAlias.value == "" && document.security.decryptKeyStore.value != "")
				)
			{
				alert("Please select Key Alias");
				return false;
			}
			var x = document.getElementsByName("watt.security.ssl.keyStoreAlias");
			x[0].value = document.security.sslKeyStore.value
			
			x = document.getElementsByName("watt.security.ssl.keyAlias");
			x[0].value = document.security.sslAlias.value
    	    
    	    x = document.getElementsByName("watt.security.sign.keyStoreAlias");
			x[0].value = document.security.signKeyStore.value
			
			x = document.getElementsByName("watt.security.sign.keyAlias");
			x[0].value = document.security.signAlias.value
			
			x = document.getElementsByName("watt.security.decrypt.keyStoreAlias");
			x[0].value = document.security.decryptKeyStore.value
           	
			x = document.getElementsByName("watt.security.decrypt.keyAlias");	           	
           	x[0].value = document.security.decryptAlias.value
           	
           	x = document.getElementsByName("watt.security.trustStoreAlias");	
			x[0].value = document.security.trustStore.value
           	
           	document.security.submit();
		}
		
    </SCRIPT>
    <base target="_self">
	<style>
	  .listbox  { width: 100%; }
	</style>
  </HEAD>

  %ifvar doc equals('edit')%
  <BODY onLoad="loadKeyStoresOptions(); setNavigation('security-certificates.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_EditCertificateSettingsScrn');">
  %else%
  <BODY onLoad="setNavigation('security-certificates.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_SecurityCertificatesScrn');">
  %endif%

    <TABLE width="100%">
      <TR>
        %ifvar doc equals('edit')%
        <TD colspan=2 class="menusection-Security">
          Security &gt;
          Certificates &gt;
          Edit </TD>
        %else%
        <TD colspan=2 class="menusection-Security">
	          Security &gt;
          Certificates </TD>
        %endif%
        
      </TR>
      
      %ifvar action equals('change')%
          %invoke wm.server.admin:setSettings%
              %ifvar message%
      			<tr><td colspan="2">&nbsp;</td></tr>
                <TR><TD class="message" colspan="2">%value message%</TD></TR>
              %endif%
          %endinvoke%
      %else%
      		%ifvar action equals('clearSSLCache')%
      			%invoke wm.server.admin:clearSSLCache%
	              %ifvar message%
	      			<tr><td colspan="2">&nbsp;</td></tr>
	                <TR><TD class="message" colspan="2">%value message%</TD></TR>
	              %endif%
          		%endinvoke%
      		%endif%
      %endif%

      <TR>
        <TD colspan=2>
          <UL>
            %ifvar doc equals('edit')%
            <LI><A HREF="security-certificates.dsp">Return to Certificates</A></LI>
            %else%
            <LI><A HREF="security-certs.dsp">Configure Client Certificates</A></LI>
            <LI><A HREF="security-certificates.dsp?doc=edit">Edit Certificates Settings</A></LI>
            <LI><A HREF="security-certificates.dsp?action=clearSSLCache">Clear SSL Cache</A></LI>
            %endif%
          </UL>
        </TD>
      </TR>

      <TR>
        <TD></TD>      
        <TD>
        %invoke wm.server.query:getSettings%
	
          <TABLE class="%ifvar ../doc equals('edit')%tableForm%else%tableView%endif%" width="30%">
             
            %ifvar ../doc equals('edit')%
	           <FORM NAME="security" METHOD="POST" ACTION="security-certificates.dsp">
	            <INPUT TYPE="hidden" NAME="action" VALUE="change">
		        <INPUT TYPE="hidden" NAME="watt.security.ssl.keyStoreAlias" VALUE="%value -code watt.security.ssl.keyStoreAlias%">
	    	    <INPUT TYPE="hidden" NAME="watt.security.ssl.keyAlias" VALUE="%value -code watt.security.ssl.keyAlias%">
	        	<INPUT TYPE="hidden" NAME="watt.security.sign.keyStoreAlias" VALUE="%value -code watt.security.sign.keyStoreAlias%">
	           	<INPUT TYPE="hidden" NAME="watt.security.sign.keyAlias" VALUE="%value -code watt.security.sign.keyAlias%">
	           	<INPUT TYPE="hidden" NAME="watt.security.decrypt.keyStoreAlias" VALUE="%value -code watt.security.decrypt.keyStoreAlias%">
	           	<INPUT TYPE="hidden" NAME="watt.security.decrypt.keyAlias" VALUE="%value -code watt.security.decrypt.keyAlias%">
	           	<INPUT TYPE="hidden" NAME="watt.security.trustStoreAlias" VALUE="%value -code watt.security.trustStoreAlias%">
           %endif%
           
   			  <!-- SSL section -->
	          <TR>
                <td class="heading" colspan=2>SSL Key</TD>
              </TR>
              <TR>
			        <TD class="evenrow">Keystore Alias</TD>
			        <TD class="evenrowdata-l">
			        %ifvar ../doc equals('edit')%
						<SELECT class="listbox" name="sslKeyStore" onchange="changeval(this, document.security.sslAlias)"></SELECT>
	                %else%
		                %ifvar watt.security.ssl.keyStoreAlias equals('')% 
                            unspecified 
                        %else% 
                            %value watt.security.ssl.keyStoreAlias% 
                        %endif%
	                %endif%
	                </TD>
			  </TR>
			  <TR>
			       	<TD class="oddrow">Key Alias</TD>
	                <TD class="oddrowdata-l">
	                  %ifvar ../doc equals('edit')%
		                  <select class="listbox" name="sslAlias" ></select>  		
		              %else%
			              	%ifvar watt.security.ssl.keyAlias equals('')% 
                           		unspecified 
                        	%else% 
                            	%value watt.security.ssl.keyAlias% 
                       		%endif%
		              %endif%
	                </TD>
			  </TR>
			  
			  <TR>
			      	<TD><IMG SRC="images/blank.gif" width=10 height=10 border=0></TD>
			  </TR>			  
              <TR>
                <td class="heading" colspan=2>Signing Key</TD>
              </TR>
			  <TR>
			        <TD class="evenrow">Keystore Alias</TD>
			        <TD class="evenrowdata-l">
			        %ifvar ../doc equals('edit')%
						<SELECT NAME="signKeyStore" class="listbox"  onchange="changeval(this, document.security.signAlias)"></SELECT>
	                %else%
		                %ifvar watt.security.sign.keyStoreAlias equals('')% 
                            unspecified 
                        %else% 
                            %value watt.security.sign.keyStoreAlias% 
                        %endif%
	                %endif%
	                </TD>
			  </TR>
			  <TR>
			       	<TD class="oddrow">Key Alias</TD>
	                <TD class="oddrowdata-l">
	                  %ifvar ../doc equals('edit')%
		                  <select name="signAlias" class="listbox"></select>  		
		              %else%
		                %ifvar watt.security.sign.keyAlias equals('')% 
                            unspecified 
                        %else% 
                            %value watt.security.sign.keyAlias% 
                        %endif%
		              %endif%
	                </TD>
			  </TR>
			  
			  <TR>
			      	<TD><IMG SRC="images/blank.gif" width=10 height=10 border=0></TD>
			  </TR>				                
              <TR>
                <td class="heading" colspan=2>Decryption Key</TD>
              </TR>
              <TR>
			        <TD class="evenrow">Keystore Alias</TD>
			        <TD class="evenrowdata-l">
			        %ifvar ../doc equals('edit')%
						<SELECT NAME="decryptKeyStore" class="listbox" onchange="changeval(this, document.security.decryptAlias)"></SELECT>
	                %else%
		                %ifvar watt.security.decrypt.keyStoreAlias equals('')% 
                            unspecified 
                        %else% 
                            %value watt.security.decrypt.keyStoreAlias% 
                        %endif%
	                %endif%
	                </TD>
			  </TR>
			  <TR>
			       	<TD class="oddrow">Key Alias</TD>
	                <TD class="oddrowdata-l">
	                  %ifvar ../doc equals('edit')%
		                  <select name="decryptAlias" class="listbox"></select>  		
		              %else%
		                %ifvar watt.security.decrypt.keyAlias equals('')% 
                            unspecified 
                        %else% 
                            %value watt.security.decrypt.keyAlias% 
                        %endif%
		              %endif%
	                </TD>
			  </TR>
			  
  			  <!-- TrsutStore section -->
			  <TR>
			      	<TD><IMG SRC="images/blank.gif" width=10 height=10 border=0></TD>
			  </TR>				                
              <TR>
                <td class="heading" colspan=2>Truststore</TD>
              </TR>
			  <TR>
			        <TD class="evenrow">Truststore Alias</TD>
	                <TD class="evenrowdata-l">
	                	%ifvar ../doc equals('edit')%
		                	<select name="trustStore">
							%invoke wm.server.security.keystore:listTrustStores%
									<option name="" value=""></option>
								%loop trustStores%
									%ifvar isLoaded equals('true')%
										<option name="%value keyStoreName%" value="%value keyStoreName%" %ifvar ../watt.security.trustStoreAlias vequals(keyStoreName)%selected%endif%>%value keyStoreName%</option>
									%endif%
							   %endloop%
							%endinvoke%
							</select>
					 	%else%
			                %ifvar watt.security.trustStoreAlias equals('')% 
	                            unspecified 
	                        %else% 
	                            %value watt.security.trustStoreAlias% 
	                        %endif%
					 	%endif%
					</TD>
			  </TR>
			   
			 
              %ifvar ../doc equals('edit')%
              <TR>
                <TD colspan=2  class="action">
                	<INPUT type="button" value="Save Changes" onclick="return saveChanges();">
                </TD>
              </TR>
              %endif%
            </TABLE>
            %endinvoke%
          </TD>

        </TR>
      </TABLE>
    </BODY>
  </HTML>
