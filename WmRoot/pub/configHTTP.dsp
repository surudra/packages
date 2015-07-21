<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
    <TITLE>Integration Server -- Port Management</TITLE>
%ifvar listenerType matches('revinvoke*')%
	%include configHTTP-revinvoke.dsp%
%else%
 %ifvar listenerType equals('regularinternal')%
	 %include configHTTP-internal.dsp%
 %else%

  %ifvar mode equals('edit')%
    %ifvar disableport equals('true')%
      %invoke wm.server.net.listeners:disableListener%
      %endinvoke%
    %endif%
  %endif%

%invoke wm.server.net.listeners:getListener%

    <SCRIPT Language="JavaScript">
        var agent = navigator.userAgent.toLowerCase();   
    	var ie = (agent.indexOf("msie") != -1);
        var hiddenOptions = new Array();   
		
       	function setupData() {
            %ifvar listenerKey -notempty%
            document.properties.operation.value = "update";
            document.properties.oldPkg.value = "%value pkg%";
            %else%
            document.properties.operation.value = "add";
            %endif%
            
            %ifvar ssl equals('true')%
				setupKeystoreData(document.properties);
            %endif%
        }

		
        function confirmDisable()
        {
          var enabled = "%value ../listening%";

          if(enabled == "primary")
          {
            alert("Port must be disabled to edit these settings.  Primary port cannot be disabled.  To edit these settings, please select a new primary port");
            return false;
          }
          else if(enabled == "true")
          {
            if(confirm("Port must be disabled so that you can edit these settings.  Would you like to disable the port?"))
            { 
			  var tempLoc = "configHTTP.dsp?listenerKey=%value encode(javascript) listenerKey%&pkg=%value pkg%%ifvar listenerType%&listenerType=%value encode(javascript) listenerType%%endif%&mode=edit&disableport=true";
			  
			  if(is_csrf_guard_enabled && needToInsertToken)
			   {
				try{
					tempLoc = tempLoc+"&"+_csrfTokenNm_+"="+_csrfTokenVal_;
				}catch(e){}	
			   }
			   
			  document.location.replace(tempLoc);
            }
          }
          else {
		     var tempLoc = "configHTTP.dsp?listenerKey=%value encode(javascript) listenerKey%&pkg=%value pkg%%ifvar listenerType%&listenerType=%value encode(javascript) listenerType%%endif%&mode=edit";
			 if(is_csrf_guard_enabled && needToInsertToken)
			 {
				tempLoc = tempLoc+"&"+_csrfTokenNm_+"="+_csrfTokenVal_;
			 }
			 
             document.location.replace(tempLoc);
          }
          return false;
        }
        function setListenerType(form, ltype) {
            form.listenerType.value = ltype;
            if (ltype == "diagnostic")
            {
            setThreadPool(form, 'enable');
            }
            return true;
        }
        
                
        function setThreadpool(checkId, bool) {
		if (bool==true){
		    document.getElementById(checkId).value="true";	
		}else{
		    document.getElementById(checkId).value="false";		
		}
			
	 }
	 
	 function toggleThreadpool(checkId, spanId) {
	  
		if (document.getElementById(checkId).value=="true"){
			elem = document.getElementById(spanId);
			rows = elem.rows;
			for(i = 0; i < rows.length; i++){
			   if (ie) {
	   		     rows[i].style.display="block";
	   		   }else{
	   		     rows[i].style.display="block";
			     rows[i].style.display="table-row";
			   }
			}
			eEnable = document.getElementById(spanId+"enable");
			if(eEnable!=null){
				document.getElementById(spanId+"enable").style.display="none";
			}
		} else {	
			elem = document.getElementById(spanId);
			rows = elem.rows;
			//length = rows.length;
			for(i = 0; i < rows.length; i++){
			   rows[i].style.display="none";
			}
			eEnable = document.getElementById(spanId+"enable");
			if(eEnable!=null){
				document.getElementById(spanId+"enable").style.display="block";
				if (!ie) {
					document.getElementById(spanId+"enable").style.display="table-row";
				}
			}
		}

	  }

        
        function changeAction(form) {
            form.action = "security-ports.dsp"
            return true;              
        }
      

    </SCRIPT>
    <base target="_self">
	<style>
	  .listbox  { width: 100%; }
	</style>
  </HEAD>

  
  <body onLoad="setupData();setNavigation('security-ports.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_%ifvar listenerType equals('Diagnostic')%Diagnostic%endif%%ifvar ssl equals('true')%HTTPS%else%HTTP%endif%_PortConfigScrn');">
    <TABLE width="100%">
      <TR>
        <TD class="menusection-Security" colspan=2>
          Security &gt;
          Ports &gt;
          %ifvar ../mode equals('view')%
            View %ifvar ssl equals('true')%HTTPS%else%HTTP%endif% Port Details
          %else%
            Edit %ifvar ssl equals('true')%HTTPS%else%HTTP%endif% Port Configuration
          %endif% </TD>
      </TR>
       
      <TR>
        <TD colspan="2">
          <UL>
            <LI><A HREF="security-ports.dsp">Return to Ports</A></LI>
            %ifvar ../mode equals('view')%
              %ifvar ../listening equals('primary')%
              %else%
				 %ifvar ../listening equals('quiesce')%
				 %else%
					<LI><A onclick="return confirmDisable();" HREF="">
					  Edit %ifvar ssl equals('true')% HTTPS %else% HTTP %endif% Port Configuration
					</A></LI>
				%endif%	
              %endif%
            %endif%
          </UL>
        </TD>
      </TR>
      <TR>
        <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
        <TD>
          <TABLE class="%ifvar ../mode equals('view')%tableView%else%tableForm%endif%">
            <tr>
                <td class="heading" colspan="2">
                  %switch listenerType%
                    %case 'Regular'%Regular 
                    %case 'revinvoke'%Proxy 
                    %case 'revinvokeinternal'%Registration(P) 
                    %case 'regularinternal'%Registration(I) 
                    %case 'Diagnostic'%Diagnostic
                  %endswitch%  
                  %ifvar ssl equals('true')%
                    HTTPS Listener Configuration
                  %else%
                    HTTP Listener Configuration
                  %endif%
                </td>
            </tr>
            <tr>

            <form onLoad="setupData();" name="properties" action="configHTTP.dsp" method="POST">
            <input type="hidden" name="factoryKey" value="webMethods/HTTP">
            <input type="hidden" name="operation">
            <input type="hidden" name="listenerKey" value="%value listenerKey%">
            <input type="hidden" name="serverType">
            <input type="hidden" name="oldPkg">
            <input type="hidden" id="tpRIGon" name="threadPool" value="%value threadPool%">
            <input type="hidden" name="listening" value="%value listening%">
            <input type="hidden" name="listenerType" value="%value listenerType%">
            <input type="hidden" name="ssl" value="%value ssl%">
            <input type="hidden" name="mode" value="%value mode%">
            <input type="hidden" name="certChain" value="%value certChain%">
            <input type="hidden" name="formName" value="properties">

            %ifvar listenerType%
				%ifvar ../mode equals('edit')%
				<tr>
					<td class="evenrow">Enable</td>
					<td class="evenrow-l">
					  <input type="radio" name="enable" value="yes" >Yes</input>
					  <input type="radio" name="enable" value="no" checked>No</input>
					</td>
				</tr>
				%endif%
               <tr>
                <td class="oddrow">Port</td>
                <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
                  %ifvar ../mode equals('view')%
                    %value port%
                  %else%
                    <input name="port" value="%value port%">
                  %endif%
                </td>
            </tr>
            <tr>
                <td class="evenrow">Alias</td>
                <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
                  %ifvar listenerKey -notempty%
                    %value portAlias% 
                  %else%
                    <input name="portAlias" value="%value portAlias%" size="60">
                  %endif%
                </td>
            </tr>
            <tr>
                <td class="oddrow">Description (optional)</td>
                <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
                  %ifvar ../mode equals('view')%
                    %value portDescription%
                  %else%
                    <input name="portDescription" value="%value portDescription%" size="60">
                  %endif%
                </td>
            </tr>	
            <tr>
                <td class="evenrow">Package Name</td>
                <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">%invoke wm.server.packages:packageList%
                %ifvar ../mode equals('view')%
                  %value pkg%
                %else%
                  %ifvar listenerType equals('Diagnostic')%
                      WmRoot
                      <input type="hidden" name="pkg" value="WmRoot">
                      <input type="hidden" name="threadPriority" value="10">
                  %else%
                  <select name="pkg">
                  %loop packages%
                      %ifvar enabled equals('false')%
                      %else%
                      %ifvar ../pkg -notempty%
                      <option %ifvar ../pkg vequals(name)%selected %endif%value="%value name%">%value name%</option>
                      %else%
                      <option %ifvar name equals('WmRoot')%selected %endif%value="%value name%">%value name%</option>
                      %endif%
                      %endif%
                  %endloop%
                  </select>
                  %endif%
                %endif%
              %endinvoke%
              </td>
            </tr>
 	          <tr>
                <td class="oddrow">Bind Address (optional)</td>
                <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
				        %ifvar ../mode equals('view')%
                  %value bindAddress%
                %else%
                    <input name="bindAddress" value="%value bindAddress%">
                %endif%
              </td>
            </tr>
          <tr>
             <td class="evenrow">Backlog</td>
             <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
				        %ifvar ../mode equals('view')%
                  %value maxQueue%
                %else%
                  %ifvar maxQueue%
                    <input name="maxQueue" value="%value maxQueue%">
                  %else%
                    <input name="maxQueue" value="200">
                  %endif%
                %endif%
              </td>
          </tr>
          <tr>
             <td class="oddrow">Keep Alive Timeout</td>
             <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
				%ifvar ../mode equals('view')%
                  	%value keepAliveTimeout%
                %else%
                  %ifvar keepAliveTimeout%
                    <input name="keepAliveTimeout" value="%value keepAliveTimeout%">
                  %else%
                    <input name="keepAliveTimeout" value="20000">
                  %endif%
                %endif%
              </td>
          </tr>
          %ifvar listenerType equals('revinvoke')%
          <tr>
             <td class="heading" colspan="2">Reverse Invoke Server</td>
           </tr>
            <tr>
              <td class="oddrow">Registration(P) Port</td>
              <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
				         %ifvar ../mode equals('view')%
                   %value internalPort%
                 %else%
                   <input name="internalPort" value="%value internalPort%">
                 %endif%
               </td>
            </tr>
          %endif%  
          
          %ifvar listenerType equals('revinvokeinternal')%
          <tr>
             <td class="heading" colspan="2">Registration Reverse Invoke Server</td>
           </tr>
           <tr>
              <td class="oddrow">Proxy Port</td>
              <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
				         %ifvar ../mode equals('view')%
                   %value proxyPort%
                 %else%
                   <input name="proxyPort" value="%value proxyPort%">
                 %endif%
               </td>
            </tr>
          %endif%
          
          %ifvar listenerType equals('regularinternal')%
              <tr>
                <td class="heading" colspan="2">Registration Internal Server</td>
              </tr>
           <tr>
              <td class="oddrow">Proxy Host</td>
              <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
				         %ifvar ../mode equals('view')%
                   %value proxyHost%
                 %else%
                   <input name="proxyHost" value="%value proxyHost%">
                 %endif%
               </td>
            </tr>
 	          <tr>
                <td class="oddrow">Bind Address (optional)</td>
                <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
				        %ifvar ../mode equals('view')%
                  %value proxybindAddress%
                %else%
                    <input name="proxybindAddress" value="%value proxybindAddress%">
                %endif%
              </td>
            </tr>
           <tr>
              <td class="oddrow">Max Connections</td>
              <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
				         %ifvar ../mode equals('view')%
                   %value maxConnections%
                 %else%
                   %ifvar maxConnections%
                     <input name="maxConnections" value="%value maxConnections%">
                   %else%
                     <input name="maxConnections" value="50">
                   %endif%
                 %endif%
               </td>
            </tr>
          %endif%
          
    %ifvar ../mode equals('view')%
    %else%
    <tr id="tpRIGenable">
      <td class="evenrow">Threadpool</td>
      <td class="evenrow-l">
   	 <a name="anchor_a" href="#anchor_b" onclick="setThreadpool('tpRIGon',true);toggleThreadpool('tpRIGon', 'tpRIG');"><u>Enable</u></a>
      </td>
    </tr>
    %endif%
 <tbody id="tpRIG">
    <tr>
      <td class="heading" colspan="2">Private Threadpool Configuration</td>
 	<input id="tpRIGon" type="hidden" name="threadPool" value="%value threadPool%">
    </tr>
    %ifvar ../mode equals('view')%
    %else%
       <tr>
          <td class="evenrow">Threadpool</td>
          <td class="evenrow-l">
   	     <a href="#anchor_a" name="anchor_b" onclick="setThreadpool('tpRIGon',false);toggleThreadpool('tpRIGon', 'tpRIG');"><u>Disable</u></a>
          </td>
       </tr>
    %endif%
    %include configHTTP-threadpool.dsp%
</tbody>
	<SCRIPT>toggleThreadpool('tpRIGon', 'tpRIG');</SCRIPT>
	%include config-common-sec-properties.dsp%
          %ifvar ssl equals('true')%
          <!-- Include Common KeyStore section --->
          %include config-keystore-common.dsp%
          
		  
        %endif%
            
            %ifvar mode equals('view')%
            %else%
            <tr>
                <td colspan="2" class="action">
                    <input type="submit" onClick="return changeAction(document.properties);" value="Save Changes">
                </td>
            </tr>
            %endif%

            %else%
            <td class="space" colspan="2">&nbsp;</td>
          </tr>
          <tr>
              <td class="heading" colspan="2">Select Type of Port to Configure</td>
          </tr>
          <tr>
               <td class="oddrow">Type</td>
               <td class="oddrow-1">
                  <a HREF="javascript:document.properties.submit();" onclick="return setListenerType(document.properties, 'Regular');">Regular</a><BR>
                  <a HREF="javascript:document.properties.submit();" onclick="return setListenerType(document.properties, 'revinvoke');">Reverse Invoke Proxy</a><BR>
                     %invoke wm.server.net.listeners:getServerType%
                     %ifvar serverType equals('proxy')%
                        <a HREF="javascript:document.properties.submit();" onclick="return setListenerType(document.properties, 'revinvokeinternal');">Proxy Registration</a><BR>
                     %else%
                        <a HREF="javascript:document.properties.submit();" onclick="return setListenerType(document.properties, 'regularinternal');">Internal Registration</a><BR>
                     %endif%
                     %endinvoke%
                    <a HREF="javascript:document.properties.submit();" onclick="return setListenerType(document.properties, 'Diagnostic');">Diagnostic</a>
                  </td>
               </tr>
            %endif%
          </form>
        </table>
      </td>
    </tr>
    </table>
  </body>
</html>
%endinvoke%

 %endif%
%endif%
