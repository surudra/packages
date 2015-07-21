<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
	<META HTTP-EQUIV="Expires" CONTENT="-1">
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
    <TITLE>Integration Server -- Port Management</TITLE>

  </HEAD>

%ifvar mode equals('edit')%
  %ifvar disableport equals('true')%
    %rename -copy listenerKey2 listenerKey% 
    %invoke wm.server.net.listeners:disableListener%
    %endinvoke%
    %rename -copy listenerKey1 listenerKey% 
    %invoke wm.server.net.listeners:disableListener%
    %endinvoke%
  %endif%
%endif%

%invoke wm.server.net.listeners:getListener%

<SCRIPT Language="JavaScript">
		var hiddenOptions = new Array();   
		
        function confirmDisable()
        {
          if(document.properties1.listening.value=='true'||document.properties2.listening.value=='true')
          {
            if(confirm("Ports must be disabled so that you can edit these settings.  Would you like to disable these ports?"))
            {
				if(is_csrf_guard_enabled && needToInsertToken) {
					document.location.replace("configHTTP.dsp?listenerKey=%value encode(javascript) listenerKey%&listenerKey1="+document.properties1.listenerKey.value+"&listenerKey2="+document.properties2.listenerKey.value+"&pkg=%value pkg%%ifvar listenerType%&listenerType=%value encode(javascript) listenerType%%endif%&mode=edit&disableport=true&"+_csrfTokenNm_+"="+_csrfTokenVal_);
				} else { 
					document.location.replace("configHTTP.dsp?listenerKey=%value encode(javascript) listenerKey%&listenerKey1="+document.properties1.listenerKey.value+"&listenerKey2="+document.properties2.listenerKey.value+"&pkg=%value pkg%%ifvar listenerType%&listenerType=%value encode(javascript) listenerType%%endif%&mode=edit&disableport=true");
				}
            }
          }
          else {
				if(is_csrf_guard_enabled && needToInsertToken) {	
					document.location.replace("configHTTP.dsp?listenerKey=%value encode(javascript) listenerKey%&pkg=%value pkg%%ifvar listenerType%&listenerType=%value encode(javascript) listenerType%%endif%&mode=edit&"+_csrfTokenNm_+"="+_csrfTokenVal_);
				} else {
					document.location.replace("configHTTP.dsp?listenerKey=%value encode(javascript) listenerKey%&pkg=%value pkg%%ifvar listenerType%&listenerType=%value encode(javascript) listenerType%%endif%&mode=edit");
				}
		  }	
          return false;
        }
        
        function submit() {
        
			var externalPortPkg = document.properties1.pkg.value;
			var registrationPortPkg = document.properties2.pkg.value;
			if (externalPortPkg != registrationPortPkg)
			{
				alert("Specify same package name for both Enterprise Gateway External Port and Enterprise Gateway Registration Port.");
				return false;
			}

        	var isValid=validateRevListenerFieds();
        
            if((document.properties1.port.value.length>0) && (document.properties2.port.value>0) && isValid)
            {
                transferInternals( document.properties2, document.properties1 );
		    	document.properties1.submit();
		    }else{
		    	if(!isValid){
		    		alert("The Backlog setting for both the Enterprise Gateway External Port and Enterprise Gateway Registration Port must be positive numbers with a maximum of 65535 milliseconds.");
		    	}else{
	    	    	alert("Enterprise Gateway External port AND Enterprise Gateway Registration port MUST be set correctly before saving.");
	    	    }	    
	    	}
        }
        
        function validateRevListenerFieds(){
        	
        	var extBacklog=document.forms['properties1'].maxQueue.value;
        	
        	var isExtBacklogInt=isInteger(extBacklog);
	        
			extBacklog=isExtBacklogInt?parseInt(extBacklog):extBacklog;
        	        	
			if(!isExtBacklogInt || extBacklog<=0 || extBacklog>65535 ){
        		       		
        		return false;
        	}
        	
        	document.properties1.maxQueue.value=extBacklog; // to trim spaces
        	
        	return true;
        	
        }

	    function transferInternals(inSrc, inDest) {
	        transferOne( inSrc.listenerKey, inDest.internalListenerKey );
	        transferOne( inSrc.port, inDest.internalPort );
	        transferOne( inSrc.portAlias, inDest.internalPortAlias );
	        transferOne( inSrc.portDescription, inDest.internalPortDescription );
	        transferOne( inSrc.clientAuth, inDest.internalClientAuth );
	        transferOne( inSrc.bindAddress, inDest.internalBindAddress );
	        transferOne( inSrc.pkg, inDest.internalPkg );
	        transferOne( inSrc.maxQueue, inDest.internalMaxQueue );
	        transferOne( inSrc.alias, inDest.internalalias );	
	        transferOne( inSrc.keyStore, inDest.internalkeyStore );
	        transferOne( inSrc.trustStore, inDest.internaltrustStore );
	
	        //   radio buttons are treated differently
	        sslFlag = extractRadioValue( inSrc.ssl );
	        if ( sslFlag ) {
	            inDest.internalSsl.value = sslFlag;
	        }

	        enableFlag = extractRadioValue( inSrc.enable );
			inDest.internalEnable.value = enableFlag;
    	}	

	    function transferOne(inSrcFld, inDestFld) {
	        if ( inSrcFld != null && inDestFld != null ) {
	            inDestFld.value = inSrcFld.value;
	        }
	    }
    

	    //  input field MUST represent a radio button
	    function extractRadioValue(inFld) {
	        rc = false;
			try
			{
				for ( var i = 0; i < inFld.length; i++ ) {
	             if ( inFld[ i ].checked ) {
	                 rc = inFld[ i ].value;
	                 break;
	             }
				}	
			}
			catch (e)
			{
			}
	        
	        return rc;
	    }
	
	    function valueOf(inFld) {
	        return ( inFld == null ) ? "n/a" : inFld.value;
	    }

	 	function refreshCA()
		{
			transferInternals( document.properties2, document.properties1 );
			var internalListenerKey = document.properties1.internalListenerKey.value;
			var internalPkg = document.properties2.oldPkg.value;
			newLocation = "configHTTP-revinvoke.dsp?action=refresh&listenerKey=%value -code listenerKey%&pkg=%value pkg%%ifvar listenerType%&listenerType=%value -code listenerType%%endif%&mode=view";
			newLocation = newLocation + "&internalListenerKey=" + internalListenerKey + "&internalPkg=" + internalPkg;
			 if(is_csrf_guard_enabled && needToInsertToken) {		
				document.location.replace(newLocation+"&"+_csrfTokenNm_+"="+_csrfTokenVal_);
			 } else {
				document.location.replace(newLocation);
			 }
			return false;
		}
		
</SCRIPT>
 	<base target="_self">
	<style>
	  .listbox  { width: 100%; }
	</style>

  <body onload="setupKeystoreData(document.properties1);setupKeystoreData(document.properties2);setNavigation('security-ports.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_EditEnterpriseGatewayPortScrn');">
    <TABLE width="100%">
      <TR>
        <TD class="menusection-Security" colspan=2>
          Security &gt;
          Ports &gt;
          %ifvar ../mode equals('view')%
            View Enterprise Gateway Server Details
          %else%
            Edit Enterprise Gateway Server Configuration
          %endif% </TD>
      </TR>
      
      %ifvar action equals('refresh')%
          %invoke wm.server.net.listeners:refreshCACache%
              %ifvar message%
      			    <tr><td colspan="2">&nbsp;</td></tr>
                    <TR><TD class="message" colspan="2">%value message%</TD></TR>
              %endif%
          %endinvoke%
      %endif%
      
      <TR>
        <TD colspan="2">
          <UL>
            <LI><A HREF="security-ports.dsp">Return to Ports</A></LI>
            %ifvar ../mode equals('view')%
              %ifvar ../listening equals('primary')%
              %else%
                <LI><A onclick="return confirmDisable();" HREF="">
                  Edit %ifvar ssl equals('true')% HTTPS %else% HTTP %endif% Port Configuration
                </A></LI>
              %endif%
            %endif%
            %ifvar ../mode equals('view')%
                %ifvar ssl equals('true')%
            		<LI><A onclick="return refreshCA();" HREF="">Refresh Trusted CA Certificates Cache
                	</A></LI>
                %endif%
            %endif%
            
          </UL>
        </TD>
      </TR>
      
      <TR>
        <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
        <TD>
		   	<TABLE border="0" cellpadding="0" cellspacing="0">
		   	
            <tr>
				<td valign="top">
				
		      	<TABLE class="%ifvar ../mode equals('view')%tableView%else%tableForm%endif%">
		    	<form name="properties1" action="security-ports.dsp" method="POST">
				<input type="hidden" name="internalListenerKey" value="%value internalListenerKey%">
				<input type="hidden" name="internalPort" value="%value internalPort%">
				<input type="hidden" name="internalPortAlias" value="%value internalPortAlias%">
				<input type="hidden" name="internalPortDescription" value="%value internalPortDescription%">
				<input type="hidden" name="internalEnable" value="%value internalEnable%">
				<input type="hidden" name="internalSsl" value="%value internalSsl%">
				<input type="hidden" name="internalClientAuth" value="%value internalClientAuth%">
				<input type="hidden" name="internalBindAddress" value="%value internalBindAddress%">
				<input type="hidden" name="internalPkg" value="%value internalPkg%">

				<input type="hidden" name="internalalias" value="%value internalalias%">
				<input type="hidden" name="internalkeyStore" value="%value internalkeyStore%">
				<input type="hidden" name="internaltrustStore" value="%value internaltrustStore%">
				
				%ifvar internalPort equals('-1')%
					  	%rename port holdPort -copy%
		     			  	%rename pkg holdPkg -copy%
					  	%scope rparam(blankScope={listenerType='revinvoke'})%
					  		%scope blankScope%
								%rename ../mode mode -copy%
					  			%include configHTTP-revinvokegateway.dsp%
							%endscope%
					  	%endscope%
					  	%rename holdPort internalPort%
		     		  	%rename holdPkg pkg%
				%else%

				    	%include configHTTP-revinvokegateway.dsp%
				%endif%
		    	</form>
		    	</TABLE>
			</td>
			
			<td valign="top">
				<TABLE class="%ifvar ../mode equals('view')%tableView%else%tableForm%endif%">
			    <form name="properties2" action="security-ports.dsp" method="POST">
					%scope param(internalScopeVar='tagged')%
					  %ifvar internalPort%
					   %invoke wm.server.net.listeners:listListeners%
					
					     %loop listeners%
							%ifvar listenerType equals('revinvokeinternal')%
						        %ifvar port vequals(../internalPort)%
								    %rename -copy key listenerKey% 
								    %invoke wm.server.net.listeners:getListener%
									    %rename -copy ../../mode mode% 
										%include configHTTP-revinvokeregistration.dsp%
								    %endinvoke%	
								    %rename ../internalScopeVar noScopeVar%
								%endif%
							%endif%
					     %endloop%
					   %endinvoke%
					  %endif%
					
					  
					   %ifvar internalScopeVar%
					  	%scope rparam(blankScope={listenerType='revinvokeinternal'})%
					  		%scope blankScope%
							%rename ../mode mode -copy%
							%rename ../returnHSMBasedKS returnHSMBasedKS -copy%
					  		%include configHTTP-revinvokeregistration.dsp%
							%endscope%
						%endscope%
					   %endif%
					%endscope%
			    </form>
    			</TABLE>
			</td>

			%ifvar mode equals('view')%
			%else%
			    <tr><td colspan="2">
			    <TABLE width="100%" class="%ifvar ../mode equals('view')%tableView%else%tableForm%endif%">
			    <tr>
			        <td class="action">
			            <input type="submit" value="Save Changes" onClick="submit();" >
			        </td>
			     </tr>
			     </TABLE>
			     </td></tr>
			 %endif%


        </table>
      </td>
    </tr>
    </table>
  </body>
%endinvoke%
</html>
