<HTML>
<HEAD>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <META HTTP-EQUIV="Expires" CONTENT="-1">

  <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">                                                                                                       
  <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
  
  %invoke wm.server.messaging:getConnectionAliasReport%
    
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
        document.editform.isEncrypted[1].disabled = false;         
      }else if (object.options[object.selectedIndex].value == "ssl") {
        document.all.divbasic.style.display = 'none';
        document.all.divssl.style.display = 'block';
        document.editform.isEncrypted[0].checked = true;
        document.editform.isEncrypted[1].disabled = true;
        displayTrustore('true');
      }else {
        document.all.divbasic.style.display = 'none';
        document.all.divssl.style.display = 'none';
        document.editform.isEncrypted[1].disabled = false;
      }
    }
    
    /**
     *
     */         
    function loadDocument() {
	    //alert('%value certfileType%');
	
		  setNavigation('settings-broker-edit.dsp',  '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Messaging_webMMsgingSettings_ConnectionAlias_EditUMScrn');
		
		  %switch certfileType%

<!-- Trax 1-1RI0MD - 'JKS' is not supported for Keystore type  -->	
<!--    %case 'JKS'% -->
<!--      document.editform.certfileType.selectedIndex=1; -->
        %case 'PKCS12'%
      	  document.editform.certfileType.selectedIndex=1;
  		%end%

  		%switch truststoreType%
    	  %case 'JKS'%
      	  document.editform.truststoreType.selectedIndex=1;
  		%end%
  		//isSSLAltered();
	  }
    
    /**
     *
     */
    function valueAltered() {
		  document.editform.isChanged.value = "true";
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
    function confirmEdit() {
    
    	if (isblank(document.editform.description.value)) {
			  alert ("Description is required.");
			  return false;
      }else if ( isblank(document.editform.CLIENTPREFIX.value) ) {
	  		alert("Client Prefix is required.");
  			return false;      
			}else if ( isblank(document.editform.um_rname.value) ) {
			  alert ("Realm URL is required.");
  		  return false;
  		}else if ( !isInt(document.editform.um_tryAgainMaxAttempts.value) ) {
  			alert ("Maximum Reconnection Attempts must be a positive integer or 0.");
  			return false;	
      }else if ( !isInt(document.editform.um_publishWaitTime.value) ) {
	  		alert("Publish Wait must be a positive integer or 0.");
  			return false;
  		}else if ( !isIllegalName(document.editform.CLIENTPREFIX.value)) {
         alert("Invalid Client Prefix value.");
  			return false;
	  	}else	if (document.editform.csqSize.value != "" && document.editform.csqSize.value != "-1" && !isInt(document.editform.csqSize.value)) {
        alert("Maximum CSQ Size must be a positive integer, 0, or -1. A value of -1 indicates that the CSQ Size is unlimited.");
        return false;
      }
    
    
	        //must be a positive integer, 0, or -1. A value of -1 indicates that the CSQ Size is unlimited.

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
      <TD class="menusection-Settings" colspan="2">Settings &gt; Messaging &gt; webMethods Messaging Settings &gt; Universal Messaging Connection Alias &gt; Edit</TD>
    </TR>
    <TR>
      <TD colspan="2">
        <UL>
          <LI><A HREF="settings-wm-um-detail.dsp?aliasName=%value aliasName%">Return to Universal Messaging Connection Alias</A></LI>
        </UL>
      </TD>
    </TR>
    <TR>
      <TD><img src="images/blank.gif" height=10 width=10></TD>
      <TD>
        <FORM name="editform" action="settings-wm-um-detail.dsp" METHOD="POST">
        
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
            <TD class="oddrowdata-l"><INPUT NAME="aliasName" size="50" value="%value aliasName%" DISABLED></TD>
          </TR>

          <!-- Description -->
          <TR>
            <TD class="evenrow-l">Description</TD>
            <TD class="evenrowdata-l"><INPUT NAME="description" size="50" value="%value description%"></TD>
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
            <TD class="oddrowdata-l"><INPUT NAME="um_rname" size="50" value="%value um_rname%"></TD>
          </TR>

          <TR>
            <TD class="evenrow-l">Maximum Reconnection Attempts</TD>
            <TD class="evenrowdata-l"><INPUT NAME="um_tryAgainMaxAttempts" size="50" value="%value um_tryAgainMaxAttempts%"></TD>
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
            <TD class="oddrow-l">
              %ifvar useCSQ equals(true)%
						    <INPUT TYPE="checkbox" NAME="useCSQ" checked="true">
						  %else%
						    <INPUT TYPE="checkbox" NAME="useCSQ">
					    %endif%
					  </TD>
		      </TR>

          <!-- Maximum CSQ Size -->
          <TR>
            <TD class="evenrow-l">Maximum CSQ Size (messages)</TD>
            <TD class="evenrowdata-l"><INPUT NAME="csqSize" size="50" value="%value csqSize%"></TD>
          </TR>
          
          <!-- Drain CSQ in Order -->
          <TR>
            <TD class="oddrow-l">Drain CSQ in Order</TD>
            <TD class="oddrowdata-l">
					    %ifvar csqDrainInOrder equals(true)%
						    <INPUT TYPE="checkbox" NAME="csqDrainInOrder" checked="true">
						  %else%
						    <INPUT TYPE="checkbox" NAME="csqDrainInOrder">
					    %endif%
					  </TD>
		      </TR>     
          
          <!-- Publish Wait Time (while reconnection) -->
          <TR>
            <TD class="evenrow-l">Publish Wait Time while Reconnecting (milliseconds)</TD>
            <TD class="evenrow-l"><INPUT NAME="um_publishWaitTime" size="50" value="%value um_publishWaitTime%"></TD>
          </TR>
          
          <!-- Include All Envelope Data 
          <TR>
            <TD class="oddrow-l">Include All Envelope Fields</TD>
            <TD class="oddrowdata-l">
					    %ifvar includeFullEnvelope equals(true)%
						    <INPUT TYPE="checkbox" NAME="includeFullEnvelope" checked="true">
						  %else%
						    <INPUT TYPE="checkbox" NAME="includeFullEnvelope">
					    %endif%
					  </TD>
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
            <TD class="oddrowdata-l">
					    %ifvar enableRequestReply equals(true)%
						    <INPUT TYPE="checkbox" NAME="enableRequestReply" checked="true">
						  %else%
						    <INPUT TYPE="checkbox" NAME="enableRequestReply">
					    %endif%
					  </TD>
          </TR>  
          
         </table>
         
         <TABLE class="tableView" width="85%">
		       <TR>
        	   <TD class="action" class="row" width="40%">
        	     <INPUT TYPE="hidden" NAME="action" VALUE="edit">
        	     <INPUT TYPE="hidden" NAME="aliasName" VALUE="%value aliasName%">
        	     <INPUT TYPE="hidden" NAME="type" VALUE="UM">
        	     <INPUT type="submit" value="Save Changes" onClick="javascript:return confirmEdit()">
        	   </TD>
        	 </TR>
         </table>
         
        %endinvoke%
        </FORM>
      </TD>
    </TR>
  </TABLE>
</BODY>
</HTML>