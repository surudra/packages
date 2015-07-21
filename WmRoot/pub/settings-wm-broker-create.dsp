<HTML>
<HEAD>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <META HTTP-EQUIV="Expires" CONTENT="-1">

  <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
  <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
  
  <SCRIPT LANGUAGE="JavaScript">
    /**
     *
     */         
    function displayTrustore(flag) {
      if ( flag == "true") {
		    document.all.divtruststore.style.display = 'block';
    	}else{
    		document.all.divtruststore.style.display = 'none';
    	}
    }
    
    /**
     *
     */  
    function displaySettings(object) {
      if (object.options[object.selectedIndex].value == "basic") {
        document.all.divbasic.style.display = 'block';
        document.all.divssl.style.display = 'none';   
        document.createform.isEncrypted[1].disabled = false;         
      }else if (object.options[object.selectedIndex].value == "ssl") {
        document.all.divbasic.style.display = 'none';
        document.all.divssl.style.display = 'block';
        document.createform.isEncrypted[0].checked = true;
        document.createform.isEncrypted[1].disabled = true;
        displayTrustore('true');
      }else {
        document.all.divbasic.style.display = 'none';
        document.all.divssl.style.display = 'none';
        document.createform.isEncrypted[1].disabled = false;
      }
    }
    
    /**
     *
     */         
    function loadDocument() {
		  setNavigation('settings-broker-edit.dsp',  '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Messaging_webMMsgingSettings_ConnectionAlias_CreateBrokerScrn');
	  }
    
    /**
     *
     */
    function valueAltered() {
		  document.createform.isChanged.value = "true";
	  }
	
    /**
     *
	   */   	
    function isIllegalName(name) {
    	// according to Enterprise Server Java Client API Reference Guide
    	// '@', '\', '/' are restricted characters
      var illegalChars = "@/\\";

      for (var i=0; i<illegalChars.length; i++) {
        if (name.indexOf(illegalChars.charAt(i)) >= 0)
        	return false;
    	}
    	return true;
    }
	
	  /**
	   *
	   */         	   
    function confirmCreate() {
    	
      if (isblank(document.createform.aliasName.value)) {
			  alert ("Connection Alias Name is required.");
			  return false;
			}else if (isblank(document.createform.description.value)) {
			  alert ("Description is required.");
			  return false;
      }else if ( isblank(document.createform.CLIENTPREFIX.value) ) {
	  		alert("Client Prefix is required.");
  			return false;      
      }else if (isblank(document.createform.brokerHost.value)) {
			  alert ("Broker Host is required.");
			  return false;
			}else if ( isblank(document.createform.brokerName.value) ) {
			  alert ("Broker Name is required.");
  		  return false;
  		}else if ( isblank(document.createform.clientGroupName.value) ) {
  			alert ("Client Group is required.");
  			return false;
  		}else if ( !isblank(document.createform.CLIENTPREFIX.value) &&
         !isIllegalName(document.createform.CLIENTPREFIX.value)) {
         alert("Invalid Client Prefix value:\nRefer to Enterprise Server Java API Client Reference Guide for restricted characters.");
  			return false;
	  	}
			
			//Client authentication Basic check
	  	if ( document.createform.clientAuth.value == "basic") {
	  	  if (document.createform.brokerUser.value == "" || document.createform.brokerPassword.value == "") {
	  		  alert("Broker username and password are required for Basic client authentication");
	  			return false;
  			}
  		}
			
	  	//Client authentication SSL check
		  if ( document.createform.clientAuth.value == "ssl") {
	  	  if (document.createform.certfile.value == "" || document.createform.certfileType.value == "" || document.createform.password.value == "") {
	  		  alert("Keystore file, type and password are required for SSL client authentication");
  				return false;
	  		}
	  	}
			
		  if ( document.createform.isEncrypted[0].checked == true) {
	  		if (document.createform.truststore.value == "" || document.createform.truststoreType.value == "") {
  				alert("Truststore file and type are required for encryption");
	  			return false;
	  		}
	  	}
		  
      //document.createform.submit();
		  //  return true;
        	
	    //}else {
	  	//  document.createform.submit();
  		//  return true;
	  	//}
	  	
	  	return true;
	  }
  
  </SCRIPT>
</HEAD>

<body onLoad="loadDocument();">

  <TABLE width="100%">
    <TR>
      <TD class="menusection-Settings" colspan="2">Settings &gt; Messaging &gt; webMethods Messaging Settings &gt; Broker Connection Alias &gt; Create</TD>
    </TR>
    <TR>
      <TD colspan="2">
        <UL>
          <LI><A HREF="settings-wm-messaging.dsp">Return to webMethods Messaging Settings</A></LI>
        </UL>
      </TD>
    </TR>
    <TR>
      <TD><img src="images/blank.gif" height=10 width=10></TD>
      <TD>
        <FORM name="createform" action="settings-wm-messaging.dsp" METHOD="POST">
        
         <!--                  -->
         <!-- General Settings -->
         <!--                  -->
         
         <TABLE class="tableView" width="85%">      
          <TR>
            <TD class="heading" colspan=2>General Settings</TD>
          </TR>

          <!-- Connection Alias Name -->
          <TR>
            <TD width="40%" class="oddrow-l" nowrap="true">Connection Alias Name</TD>
            <TD class="oddrowdata-l"><INPUT NAME="aliasName" size="50"></TD>
          </TR>

          <!-- Description -->
          <TR>
            <TD class="evenrow-l">Description</TD>
            <TD class="evenrowdata-l"><INPUT NAME="description" size="50"></TD>
          </TR>
          
          <!-- Client Prefix -->
          <TR>
            <TD class="oddrow-l">Client Prefix</TD>
            <TD class="oddrowdata-l"><INPUT NAME="CLIENTPREFIX" size="50" value="%value CLIENTPREFIX%"></TD>
          </TR>
          
          <!-- Share Client Prefix -->
          <TR>
            <TD class="evenrow-l">Share Client Prefix</TD>
            <TD class="evenrowdata-l">
              %ifvar isISClustered equals(true)%
						    <INPUT TYPE="radio" NAME="isISClustered" VALUE="true" checked disabled onChange="valueAltered()">Yes</INPUT>
						    <INPUT TYPE="radio" NAME="isISClustered" VALUE="false" disabled onChange="valueAltered()">No</INPUT>
					    %else%
						    %ifvar isClientPrefixShared equals(true)%				
							    <INPUT TYPE="radio" NAME="isClientPrefixShared" VALUE="true" checked onChange="valueAltered()">Yes</INPUT>
							    <INPUT TYPE="radio" NAME="isClientPrefixShared" VALUE="false" onChange="valueAltered()">No</INPUT>
						    %else%
							    <INPUT TYPE="radio" NAME="isClientPrefixShared" VALUE="true" onChange="valueAltered()">Yes</INPUT>
							    <INPUT TYPE="radio" NAME="isClientPrefixShared" VALUE="false" checked onChange="valueAltered()">No</INPUT>
						    %endif%	
					    %endif%
					  </TD>
          </TR>
          
          <!--                     -->
          <!-- Connection Settings -->
          <!--                     -->
         
          <TR>
            <TD class="heading" colspan=2>Connection Settings</TD>
          </TR>

          <!-- Broker Host -->
          <TR>
            <TD class="oddrow-l">Broker Host</TD>
            <TD class="oddrowdata-l"><INPUT NAME="brokerHost" size="50" value="localhost:6849"></TD>
          </TR>
          
          <!-- Broker Name -->
          <TR>
            <TD class="evenrow-l">Broker Name</TD>
            <TD class="evenrowdata-l"><INPUT NAME="brokerName" size="50" value="Broker #1"></TD>
          </TR>
          
          <!-- Client Group -->
          <TR>
            <TD class="oddrow-l">Client Group</TD>
            <TD class="oddrowdata-l"><INPUT NAME="clientGroupName" size="50" value="IntegrationServer"></TD>
          </TR>
          
          <!--                                -->
          <!-- Client Authentication Settings -->
          <!--                                -->
         	
           <TR>
				    <TD class="heading" colspan=3>Client Authentication Settings</TD>
			    </TR> 

          <!-- Client Authentication -->
          <TR>
            <TD class="oddrow-l">Client Authentication</TD>
            <TD class="oddrowdata-l">
              <select name="clientAuth" onchange="displaySettings(this.form.clientAuth);valueAltered()">
				      	%ifvar clientAuth equals('none')%
				      		<option value="none" selected>None</option>
				      	%else%
				      		<option value="none">None</option>
				      	%endif%
				      	%ifvar clientAuth equals('basic')%
				      		<option value="basic" selected>Username/Password</option>
				      	%else%
				      		<option value="basic">Username/Password</option>
				      	%endif%
				      	%ifvar clientAuth equals('ssl')%
				      		<option value="ssl" selected>SSL</option>
				      	%else%
				      		<option value="ssl">SSL</option>
				      	%endif%
				      </select>
            </TD>
          </TR>
         </table>
        
         <!-- (DIV) Basic Auth -->
         %ifvar clientAuth equals('basic')%
				 <DIV id="divbasic" STYLE="display: block">
			   %else%
				 <DIV id="divbasic" STYLE="display: none">
			   %endif%
			    <TABLE class="tableView" width="85%">
			      <TR>
					    <TD width="40%" class="evenrow-l">Username</TD>
					    <TD class="evenrowdata-l"><INPUT NAME="brokerUser" VALUE="%value brokerUser%" onChange="valueAltered()"></TD>
				    </TR>
				    <TR>
					    <TD class="oddrow-l">Password</TD>
					   <TD class="oddrowdata-l"><INPUT NAME="brokerPassword" TYPE="password" autocomplete="off" VALUE="%value brokerPassword%" onChange="valueAltered()"/></TD>
				    </TR>
				  </table>
			   </DIV>
			  
			   <!-- (DIV) SSL Auth -->
			   %ifvar clientAuth equals('ssl')%
				 <DIV id="divssl" STYLE="display: block">
			   %else%
				 <DIV id="divssl" STYLE="display: none">
			   %endif%	
				   <TABLE class="tableView" width="85%">
				     <TR>
			 		    <TD width="40%" class="evenrow-l">Keystore</TD>
			 		    <TD class="evenrowdata-l"><INPUT NAME="certfile" VALUE="%value certfile%" onChange="valueAltered()"></TD>
			 	    </TR>
			 	    <TR>
			 		    <TD class="oddrow-l">Keystore Type</TD>
			 		    <TD class="oddrowdata-l">
			 		    	<select name="certfileType" onChange="valueAltered()">
			 		    	  <option value=""></option>
                   <option value="PKCS12" >PKCS12</option>
                 </select>
	     				</TD>
		     		</TR>
		     		<TR>
		     			<TD class="evenrow-l">Keystore Password</TD>
		     			<TD class="evenrowdata-l"><INPUT NAME="password" TYPE="password" autocomplete="off" value="%value password%" onChange="valueAltered()"/></TD>
		     		</TR>
			     </table>
			   </DIV>
			   
			   <!--                     -->
			   <!-- Encryption Settings -->
			   <!--                     -->
			   
			   <TABLE class="tableView" width="85%">
			     <TR>
		 		    <TD class="heading" colspan=2>Encryption Settings</TD>
		 	    </TR>
		 	    <script>swapRows();</script>
		 	    
		 	    <!-- Encryption -->
		 	    <TR>
		 			  <script>writeTDWidth("row-l", "40%");</script>Encryption</TD>
		 			  <script>writeTD("row-l");</script>
		 				%ifvar isEncrypted equals(true)%
		 					<INPUT TYPE="radio" NAME="isEncrypted" VALUE="true" checked onClick="displayTrustore('true');valueAltered()">Yes</INPUT>
			 				<INPUT TYPE="radio" NAME="isEncrypted" VALUE="false" onClick="displayTrustore('false');valueAltered()">No</INPUT>
						%else%
							<INPUT TYPE="radio" NAME="isEncrypted" VALUE="true" onClick="displayTrustore('true');valueAltered()">Yes</INPUT>
							<INPUT TYPE="radio" NAME="isEncrypted" VALUE="false" checked onClick="displayTrustore('false');valueAltered()">No</INPUT>
						%endif%
					  </TD>
		  	  </TR>
			   </table>

         <!-- (DIV divtruststore -->  
         %ifvar isEncrypted equals('true')%
				 <DIV id="divtruststore" STYLE="display: block">
			   %else%
				 <DIV id="divtruststore" STYLE="display: none">
			   %endif%
         	
          <TABLE class="tableView" width="85%">
					  <script>swapRows();</script>
            
            <!-- Truststore --> 				
				    <TR>
					    <script>writeTDWidth("row-l", "40%");</script>Truststore</TD>
					    <script>writeTD("row-l");</script><INPUT NAME="truststore" VALUE="%value truststore%" onChange="valueAltered()" onChange="valueAltered()"></TD>
				    </TR>
				    <script>swapRows();</script>
				    
				    <!-- Truststore Type -->
				    <TR>
					    <script>writeTDWidth("row-l", "40%");</script>Truststore Type</TD>
				    	<script>writeTD("row-l");</script>
			    			<select name="truststoreType" onChange="valueAltered()">
		    				  <option value=""></option>
                  <option value="JKS">JKS</option>
                </select>
		  			  </TD>
	  			  </TR>
		  		</table>
	  		 </DIV>

         <TABLE class="tableView" width="85%">
		      <TR>
        	  <TD class="action" class="row" width="40%">
        	    <INPUT TYPE="hidden" NAME="action" VALUE="create">
        	    <INPUT TYPE="hidden" NAME="type" VALUE="BROKER">
        	    <INPUT type="submit" value="Save Changes" onClick="javascript:return confirmCreate()">
        	  </TD>
        	</TR>
             
        	%ifvar isUpdated equals('true')%
        	<TR>
        	  <TD class="subheading">* Settings have been modified. Server restart is required.</TD>
        	</TR>
        	%endif%	  
          
         </table>

        </FORM>
      </TD>
	    <script>displaySettings(document.createform.clientAuth)</script>
    </TR>
  </TABLE>
</BODY>
</HTML>