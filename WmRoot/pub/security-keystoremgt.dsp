<HTML>
  <HEAD>

   	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt"></SCRIPT>

    <TITLE>Integration Server -- Keystore Management</TITLE>
    <SCRIPT LANGUAGE="JavaScript">
	    //scrpt to delete the key store with the given name
	    function deleteKeyStore (keyStoreName, typeVal) {
	    	
	        var msg = "";
	        if (typeVal == "key")
	        	msg = "OK to delete keystore alias '"+keyStoreName+"'?";
	        else
		        msg = "OK to delete truststore alias '"+keyStoreName+"'?";
	        if (confirm (msg)) {
	            	document.deleteform.keyStoreName.value = keyStoreName;
	             	document.deleteform.type.value = typeVal;
	                document.deleteform.submit();
	              	return false;
	        } else return false;
	  	}
	  
		function viewKeyStore (errorMessage, keyStoreName,keyStoreType,keyStoreLocation,keyStoreProvider,typeVal) {         
	              document.viewform.keyStoreName.value = keyStoreName;
	              document.viewform.keyStoreType.value = keyStoreType;
	              document.viewform.keyStoreLocation.value = keyStoreLocation;
	              document.viewform.keyStoreProvider.value = keyStoreProvider;
	              document.viewform.type.value = typeVal;
	              document.viewform.errorMessage.value = errorMessage;	              
	              document.viewform.submit();
	              return true;          
	  	}
	  	
	  	function confirmReload(name, type)
	  	{
	  	  	var msg = "";
	        if (type == "key")
	        	msg = "OK to reload keystore alias '"+name+"'?";
	        else
		        msg = "OK to reload truststore alias '"+name+"'?";
		        
  			if (confirm(msg))
			{
				document.reloadform.keyStoreName.value = name;
	            document.reloadform.type.value = type;
				document.reloadform.submit();
				return false;
			}
			else
			 return false;	  				
	  	}
    </SCRIPT>

  </HEAD>

  <BODY onLoad="setNavigation('security-keystoremgt.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_KeystoreScrn');">
    <TABLE width="100%">
      <TR>
        <TD class="menusection-Security" colspan="2"> Security &gt; Keystore </TD>
      </TR>
      
      %ifvar mode%
	      %switch mode%
	      %case 'add'%
	      	  %invoke wm.server.security.keystore:createStore%
	      	        %ifvar message%
	      	      <tr><td colspan="2">&nbsp;</td></tr>
	      	          <TR><TD class="message" colspan="2">%value message%</TD></TR>
	      	        %endif%
	      	  %onerror%
	      	          <tr><td colspan="2">&nbsp;</td></tr>
	      	          <tr><td class="message" colspan=2>%value errorMessage%</td></tr>
	      	  %endinvoke%
	        
	      %case 'edit'%
	      	  	      		
	      	  %invoke wm.server.security.keystore:createStore%
	      	        %ifvar message%
	      	      	<tr><td colspan="2">&nbsp;</td></tr>
	      	          	<TR><TD class="message" colspan="2">%value message%</TD></TR>
	      	        %endif%
	      	  %onerror%
	      	          <tr><td colspan="2">&nbsp;</td></tr>
	      	          <tr><td class="message" colspan=2>%value errorMessage%</td></tr>
	      	  %endinvoke%
	   %case 'edit_add'%
	      	  	      		
	      	  %invoke wm.server.security.keystore:createStore%
	      	        %ifvar message%
	      	      	<tr><td colspan="2">&nbsp;</td></tr>
	      	          	<TR><TD class="message" colspan="2">%value message%</TD></TR>
	      	        %endif%
	      	  %onerror%
	      	          <tr><td colspan="2">&nbsp;</td></tr>
	      	          <tr><td class="message" colspan=2>%value errorMessage%</td></tr>
	      	  %endinvoke%
	     %case 'edit_edit'%
	      	  	      		
	      	  %invoke wm.server.security.keystore:createStore%
	      	        %ifvar message%
	      	      		<tr><td colspan="2">&nbsp;</td></tr>
	      	          	<TR><TD class="message" colspan="2">%value message%</TD></TR>
	      	        %endif%
	      	  %onerror%
	      	          <tr><td colspan="2">&nbsp;</td></tr>
	      	          <tr><td class="message" colspan=2>%value errorMessage%</td></tr>
	      	  %endinvoke%
	     
	     %case 'reload'%
	    	 %invoke wm.server.security.keystore:refreshStore%
	    	 		%ifvar message%
	      	      		<tr><td colspan="2">&nbsp;</td></tr>
	      	          	<TR><TD class="message" colspan="2">%value message%</TD></TR>
	      	        %endif%
			 %onerror%
							 <tr><td colspan="2">&nbsp;</td></tr>
	      	          		<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
	      	 %endinvoke% 

		%case 'delete'%
	    	 %invoke wm.server.security.keystore:deleteStore%
	      	        %ifvar message%
	      	      		<tr><td colspan="2">&nbsp;</td></tr>
	      	          	<TR><TD class="message" colspan="2">%value message%</TD></TR>
	      	        %endif%
	      	 %endinvoke% 
	     %endswitch%
	 %endif%

      <TR>
        <TD colspan="2">
          <UL>
            <LI><A HREF="security-keystoremgt-keystore.dsp?type=key&mode=add">Create Keystore Alias</A></LI>
            <LI><A HREF="security-keystoremgt-keystore.dsp?type=trust&mode=add">Create Truststore Alias</A></LI>
		    <LI><A HREF="add-javasecurity-provider.dsp?">Add Security Provider</A></LI>            
          </UL>
        </TD>
      </TR>
      <TR>
        <TD></TD>
        <TD>
		  <TABLE class="tableView" width="100%">
		   
			    <TR>
			      <TD class="heading" colspan="8">Keystore List</TD>
			    </TR>

			    <TR>
			      <TD class="oddcol-l">Alias</TD>
			      <TD class="oddcol">Type</TD>
			      <TD class="oddcol">Provider</TD>
				  <TD class="oddcol">Location</TD>			      
			      <!-- <TD class="oddcol">Execute ACL</TD> -->
				  <TD class="oddcol">Loaded</TD>			      			      
				  <TD class="oddcol">Reload</TD>			      			      				  
			      <TD class="oddcol">Delete</TD>
			    </TR>
			    
			    %invoke wm.server.security.keystore:listKeyStores%
			    %loop keyStores%
				    <TR>

				      <script>writeTD("rowdata-l");</script>               
					  <A HREF="javascript:viewKeyStore('%value encode(htmlattr) errorMessage%','%value encode(htmlattr) keyStoreName%', '%value encode(htmlattr) keyStoreType%', '%value encode(htmlattr) keyStoreLocation%','%value encode(htmlattr) keyStoreProvider%','key');">
					    %value encode(html) keyStoreName%
					  </A>                
				      </TD>
				      <script>writeTD("rowdata");</script>%value keyStoreType%</TD>
				      <script>writeTD("rowdata");</script>%value keyStoreProvider%</TD>
				      <script>writeTD("rowdata");</script>%value keyStoreLocation% </TD>				                    
   				      <!-- <script>writeTD("rowdata");</script>%value acl%</TD> -->                    				      				      
   				      <script>writeTD("rowdata");</script>%ifvar isLoaded equals('true')%<IMG SRC="images/green_check.gif">Yes%else%No%endif%</TD>                    				      				      
   				      <script>writeTD("rowdata");</script><A class="imagelink" HREF=""  ONCLICK="return confirmReload('%value keyStoreName%', 'key');">
	                  <IMG SRC="icons/icon_reload.gif" border="0"
    	              alt="Reload Keystore"></A></TD>                    				      				         				      
				      <script>writeTD("rowdata");</script>	           
						  <a class="imagelink"  href="security-keystoremgt.dsp" onClick="return deleteKeyStore('%value encode(htmlattr) keyStoreName%','key');">
						  <img src="icons/delete.gif" alt="Delete Keystore : %value keyStoreName%" border="none"></a>
				      </TD>

				    </TR>
				    <script>swapRows();</script>
			    %endloop%
		    	%endinvoke%
	    	    
	    	    <TR><TD colspan="11"><IMG SRC="images/blank.gif" height="10" width="10"></TD></TR>
				<TR><TD class="heading" colspan="11">Truststore List</TD></TR>		    	
				<TR>
      			      <TD class="oddcol-l">Alias</TD>
      			      <TD class="oddcol">Type</TD>
      			      <TD class="oddcol">Provider</TD>
      			      <TD class="oddcol">Location</TD>      			      
				      <!-- <TD class="oddcol">Execute ACL</TD> -->
					  <TD class="oddcol">Loaded</TD>			      			      
					  <TD class="oddcol">Reload</TD>			      			      				  
      			      <TD class="oddcol">Delete</TD>
   			    </TR>
		    	%invoke wm.server.security.keystore:listTrustStores%
			    	
      			    %loop trustStores%
      				    <TR>
      				      <script>writeTD("row-l");</script>               
      					  <A HREF="javascript:viewKeyStore('%value encode(htmlattr) errorMessage%','%value encode(htmlattr) keyStoreName%', '%value encode(htmlattr) keyStoreType%', '%value encode(htmlattr) keyStoreLocation%','%value encode(htmlattr) keyStoreProvider%','trust');">
      					    %value encode(html) keyStoreName%
      					  </A>                
      				      </TD>
      				      <script>writeTD("rowdata");</script>%value keyStoreType%</TD>
      				      <script>writeTD("rowdata");</script>%value keyStoreProvider%</TD>
      				      <script>writeTD("rowdata");</script>%value keyStoreLocation% </TD>
      				      <!-- <script>writeTD("rowdata");</script>%value acl%</TD> -->
	   				      <script>writeTD("rowdata");</script>%ifvar isLoaded equals('true')%<IMG SRC="images/green_check.gif">Yes%else%No%endif%</TD>                    				      				      
	   				      <script>writeTD("rowdata");</script><A class="imagelink" HREF=""  ONCLICK="return confirmReload('%value keyStoreName%', 'trust');">
		                  <IMG SRC="icons/icon_reload.gif" border="0"
	    	              alt="Reload Truststore"></A></TD>                    				      				         				      
      				                          				      
      				      <script>writeTD("rowdata");</script>	           
      						  <a class="imagelink" href="security-keystoremgt.dsp" onClick="return deleteKeyStore('%value encode(htmlattr) keyStoreName%','trust');">
      						  <img src="icons/delete.gif" alt="Delete Truststore : %value keyStoreName%" border="none"></a>
      				      </TD>
      
      				    </TR>
      				    <script>swapRows();</script>
      			    %endloop%
      		    	%endinvoke%
		  </TABLE>
        </TD>
      </TR>
      
      
      
    </TABLE>

    <form name="viewform" action="security-keystoremgt-keystore.dsp" method="POST">
	    <input type="hidden" name="keyStoreName">
		<input type="hidden" name="errorMessage">	    
	    <input type="hidden" name="keyStoreType">
	    <input type="hidden" name="keyStoreLocation">
	    <input type="hidden" name="keyStoreProvider">
	    <input type="hidden" name="mode" value="view">
	    <input type="hidden" name="type">
     </form>

    <form name="reloadform" action="security-keystoremgt.dsp" method="POST">
	    <input type="hidden" name="keyStoreName">
	    <input type="hidden" name="mode" value="reload">
	    <input type="hidden" name="type">
    </form>

    <form name="deleteform" action="security-keystoremgt.dsp" method="POST">
	    <input type="hidden" name="keyStoreName">
	    <input type="hidden" name="mode" value="delete">
	    <input type="hidden" name="type">
    </form>

  </BODY>
</HTML>

