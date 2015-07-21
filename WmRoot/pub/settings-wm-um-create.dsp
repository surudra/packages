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
	    //alert('%value certfileType%');
	
		  setNavigation('settings-broker-edit.dsp',  '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Messaging_webMMsgingSettings_ConnectionAlias_CreateUMScrn');
		
		  %switch certfileType%

<!-- Trax 1-1RI0MD - 'JKS' is not supported for Keystore type  -->	
<!--    %case 'JKS'% -->
<!--      document.createform.certfileType.selectedIndex=1; -->
        %case 'PKCS12'%
      	  document.createform.certfileType.selectedIndex=1;
  		%end%

  		%switch truststoreType%
    	  %case 'JKS'%
      	  document.createform.truststoreType.selectedIndex=1;
  		%end%
  		//isSSLAltered();
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
			}else if ( isblank(document.createform.um_rname.value) ) {
			  alert ("Realm URL is required.");
  		  return false;
  		}else if ( !isInt(document.createform.um_tryAgainMaxAttempts.value) ) {
  			alert ("Maximum Reconnection Attempts must be a positive integer or 0.");
  			return false;	
      }else if ( !isInt(document.createform.um_publishWaitTime.value) ) {
	  		alert("Publish Wait must be a positive integer or 0.");
  			return false;
  		}else if ( !isIllegalName(document.createform.CLIENTPREFIX.value)) {
         alert("Invalid Client Prefix value.");
  			return false;
	  	}else	if (document.createform.csqSize.value != "" && document.createform.csqSize.value != "-1" && !isInt(document.createform.csqSize.value)) {
        alert("Maximum CSQ Size must be a positive integer, 0, or -1. A value of -1 indicates that the CSQ Size is unlimited.");
        return false;
      }
	  	return true;
	  }
	  
	  /**
     * isInt
     */ 
    function isInt(value) {
      var strValidChars = "0123456789";
      var strChar;
      var blnResult = true;
      for (i = 0; i < value.length && blnResult == true; i++) {
        strChar = value.charAt(i);
        if (strValidChars.indexOf(strChar) == -1) {
          blnResult = false;
        }
      }
      return blnResult;
    }
  
  </SCRIPT>
</HEAD>

<body onLoad="loadDocument();">

  <TABLE width="100%">
    <TR>
      <TD class="menusection-Settings" colspan="2">Settings &gt; Messaging &gt; webMethods Messaging Settings &gt; Universal Messaging Connection Alias &gt; Create</TD>
    </TR>
    <TR>
      <TD colspan="2">
        <UL>
          <LI><A HREF="settings-wm-messaging.dsp?aliasName=%value aliasName%">Return to webMethods Messaging Settings</A></LI>
        </UL>
      </TD>
    </TR>
    <TR>
      <TD><img src="images/blank.gif" height=10 width=10></TD>
      <TD>
        <FORM name="createform" action="settings-wm-um-detail.dsp" METHOD="POST">
        
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
                %ifvar isClientPrefixShared equals(true)%
						      <INPUT TYPE="checkbox" disabled="true" NAME="isClientPrefixShared" checked="true">
						    %else%
						      <INPUT TYPE="checkbox" disabled="true" NAME="isClientPrefixShared">
					      %endif%
					    %else%
						    %ifvar isClientPrefixShared equals(true)%
						      <INPUT TYPE="checkbox" NAME="isClientPrefixShared" checked="true">
						    %else%
						      <INPUT TYPE="checkbox" NAME="isClientPrefixShared">
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
          
          <!-- Realm URL -->
          <TR>
            <TD class="oddrow-l">Realm URL</TD>
            <TD class="oddrowdata-l"><INPUT NAME="um_rname" size="50" value="%value nullString null=nsp://localhost:9000%"></TD>
          </TR>

          <TR>
            <TD class="evenrow-l">Maximum Reconnection Attempts</TD>
            <TD class="evenrowdata-l"><INPUT NAME="um_tryAgainMaxAttempts" size="50" value="5"></TD>
          </TR>
          
          <!--                     -->
          <!-- Producer Settings   -->
          <!--                     -->
          
          <tr>
            <td class="heading" colspan=2>Producer Settings</td>
          </tr>
    
          <!-- Enable CSQ -->
          <TR>
            <TD class="oddrow-l">Enable CSQ</TD>
            <TD class="evenrowdata-l"><INPUT TYPE="checkbox" NAME="useCSQ" checked="false"></TD>
					</TR>
          
          <!-- Maximum CSQ Size -->
          <TR>
            <TD class="evenrow-l">Maximum CSQ Size (messages)</TD>
            <TD class="evenrowdata-l"><INPUT NAME="csqSize" size="50" value="-1"></TD>
          </TR>

          <!-- Drain CSQ in Order --> 
          <TR>
            <TD class="oddrow-l">Drain CSQ in Order</TD>
            <TD class="oddrowdata-l"><INPUT TYPE="checkbox" NAME="csqDrainInOrder" checked="true"></TD>
					</TR>     

          <!-- Publish Wait Time (while reconnection) -->
          <TR>
            <TD class="evenrow-l">Publish Wait Time while Reconnecting (milliseconds)</TD>
            <TD class="evenrowdata-l"><INPUT NAME="um_publishWaitTime" size="50" value="0"></TD>
          </TR>
          
          <!-- Include All Envelope Data 
          <TR>
            <TD class="oddrow-l">Include All Envelope Fields</TD>
            <TD class="oddrowdata-l"><INPUT TYPE="checkbox" NAME="includeFullEnvelope" checked="true"></TD>
          </TR>   -->
          
          <!--                     -->
          <!-- Consumer Settings   -->
          <!--                     -->
          
          <tr>
            <td class="heading" colspan=2>Consumer Settings</td>
          </tr>    

          <!-- Request-Reply -->  
          <TR>
            <TD class="oddrow-l">Enable Request-Reply Channel and Listener</TD>
            <TD class="oddrowdata-l"><INPUT TYPE="checkbox" NAME="enableRequestReply" checked="true"></TD>
          </TR>  
          
         </table>
         
         <TABLE class="tableView" width="85%">
		       <TR>
        	   <TD class="action" class="row" width="40%">
        	     <INPUT TYPE="hidden" NAME="action" VALUE="create">
        	     <INPUT TYPE="hidden" NAME="type" VALUE="UM">
        	     <INPUT type="submit" value="Save Changes" onClick="javascript:return confirmCreate()">
        	   </TD>
        	 </TR>
         </table>
         
        </FORM>
      </TD>
    </TR>
  </TABLE>
</BODY>
</HTML>