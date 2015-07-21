<HTML>
<HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">

<TITLE>Integration Server -- Mobile Support</TITLE>
<LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
<SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
function confirmDelete (aliasName, stage, stageDisplay) {
    var msg = "Delete on-premise account '" + aliasName + "' for stage '" + stageDisplay + "'?";
    if (confirm (msg)) {
        document.deleteform.aliasName.value = aliasName;
		document.deleteform.stage.value = stage;
        document.deleteform.submit();
        return false;
    } 
	else 
		return false;
  }
  
function confirmUpload (aliasName, stage, stageDisplay) {
    var msg = "Upload on-premise account '" + aliasName + "' to stage '" + stageDisplay + "'?";
    if (confirm (msg)) {
        document.uploadform.aliasName.value = aliasName;
		document.uploadform.stage.value = stage;
        document.uploadform.submit();
        return false;
    } 
	else 
		return false;
  }
  
</SCRIPT>
</HEAD>
 
<BODY onLoad="setNavigation('integration-live.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_webMethodsCloud_AccountsScrn');"> 
  <TABLE width="100%">
   <TR>
      <TD class="menusection-Settings" colspan="2">
          webMethods Cloud &gt;
          Accounts
      </TD>
    </TR>
    
%ifvar action%
%switch action%
%case 'test'%
  %invoke wm.client.integrationlive.connections:testUMConnectionAlias%
        %ifvar message%
          <TR><TD class="message" colspan="2">%value message%</TD></TR>
        %endif%
	%onerror%
		<tr><td class="message" colspan=3>%value errorMessage%</td></tr>
	%endinvoke%
%case 'addFrom'%
        %ifvar message%
			<tr><td colspan="2">&nbsp;</td></tr>
			<TR><TD class="message" colspan="2">%value message%</TD></TR>
        %endif%
		%ifvar errorMessage%
			<tr><td colspan="3">&nbsp;</td></tr>
			<tr><td class="message" colspan=3>%value errorMessage%</td></tr>
		%endif%
%case 'editFrom'%
        %ifvar message%
			<tr><td colspan="2">&nbsp;</td></tr>
			<TR><TD class="message" colspan="2">%value message%</TD></TR>
        %endif%
		%ifvar errorMessage%
			<tr><td colspan="3">&nbsp;</td></tr>
			<tr><td class="message" colspan=3>%value errorMessage%</td></tr>
		%endif%
%case 'add'%
  %invoke wm.client.integrationlive.connections:createUMConnection%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message%</TD></TR>
        %endif%
	%onerror%
		<tr><td colspan="3">&nbsp;</td></tr>
		<tr><td class="message" colspan=3>%value errorMessage%</td></tr>
	%endinvoke%
%case 'edit'%
  %invoke wm.client.integrationlive.connections:updateUMConnection%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message%</TD></TR>
        %endif%
	%onerror%
		<tr><td colspan="3">&nbsp;</td></tr>
		<tr><td class="message" colspan=3>%value errorMessage%</td></tr>
	%endinvoke%
%case 'delete'%
  %invoke wm.client.integrationlive.connections:removeUMConnection%
        %ifvar message%
		  <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message%</TD></TR>
        %endif%
	%onerror%
		<tr><td colspan="3">&nbsp;</td></tr>
		<tr><td class="message" colspan=3>%value errorMessage%</td></tr>
	%endinvoke%
%case 'upload'%
  %invoke wm.client.integrationlive.connections:uploadUMConnection%
        %ifvar message%
		  <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message%</TD></TR>
        %endif%
	%onerror%
		<tr><td colspan="3">&nbsp;</td></tr>
		<tr><td class="message" colspan=3>%value errorMessage%</td></tr>
	%endinvoke%
%case 'enable'%  
  %invoke wm.client.integrationlive.connections:enableUMConnection%
        %ifvar message%
		  <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message%</TD></TR>
        %endif%
	%onerror%
		<tr><td colspan="3">&nbsp;</td></tr>
		<tr><td class="message" colspan=3>%value errorMessage%</td></tr>
	%endinvoke%
%case 'disable'%  
  %invoke wm.client.integrationlive.connections:disableUMConnection%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message%</TD></TR>
        %endif%	
  	%onerror%
		<tr><td colspan="3">&nbsp;</td></tr>
		<tr><td class="message" colspan=3>%value errorMessage%</td></tr>
	%endinvoke%
%endswitch%
%endif% 
 	
   <TR>
      <TD colspan="2">
        <UL>
          <LI><A HREF="integration-live-connections-addedit.dsp?action=add" onClick="setNavigation('integration-live-connections-addedit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_WmIntegrationLivepkg_AddConnectionScrn');">Create On-premise Account</A></LI>
        </UL>
      </TD>
    </TR>
   
    <TR> 
    <TD>
			  &nbsp;
	</TD>
    <TD width="98%">
       <TABLE width="75%">
       <TR>      
      <TD class="heading" colspan="8">On-premise Accounts</TD>
    </TR>
    
   	%invoke wm.client.integrationlive.connections:listUMConnections%		
    <TR>     
      <TD class="oddcol-l" nowrap width="20%">Alias</TD>
      <TD class="oddcol" nowrap width="20%">Description</TD>
	  <TD class="oddcol" nowrap width="10%">Stage</TD>
	  <TD class="oddcol" nowrap width="20%">Last Uploaded Time</TD>	  
	  <TD class="oddcol" nowrap width="5%">Upload</TD>
	  <TD class="oddcol" nowrap width="5%">Test</TD>
      <TD class="oddcol" nowrap width="15%">Enabled</TD>
      <TD class="oddcol" nowrap width="5%">Delete</TD>
    </TR>

    %loop UMConnections%
    <TR>
     
      <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%ifvar aliasName%
      <A href="integration-live-connections-addedit.dsp?action=edit&aliasName=%value -urlencode aliasName%&stage=%value -urlencode stage%" onClick="setNavigation('integration-live-connections-addedit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_WmIntegrationLivepkg_EditConnectionScrn');">
       %value aliasName% 
         </A>%else%&nbsp;%endif%
      </TD>

      <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value description% 
      </TD>

      <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value stageDisplay% 
      </TD>

      <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value lastUploadedTimeStr% 
      </TD>
	  
      <SCRIPT>writeTDspan("rowdata","1");</SCRIPT>
  		<A href="" onClick="return confirmUpload('%value aliasName%', '%value stage%', '%value stageDisplay%');">
          <IMG src="/WmRoot/icons/upload.png" border="none">
        </A>
      </TD>     
	  
      <SCRIPT>writeTD("rowdata");</SCRIPT>
        <A href="integration-live.dsp?action=test&aliasName=%value -urlencode aliasName%&stage=%value -urlencode stage%">
          <IMG src="/WmRoot/icons/checkdot.gif" border="none">
        </A>
      </TD>
	  
	  <SCRIPT>writeTDnowrap("rowdata");</SCRIPT>
	  <!-- Enable -->
	  %switch isEnabled%
		%case 'true'%
		<a href="integration-live.dsp?action=disable&aliasName=%value aliasName encode(url)%&stage=%value -urlencode stage%"><img style="width: 13px; height: 13px;" alt="enabled" border="0" src="/WmRoot/images/green_check.gif">Yes</a>
		%case 'false'%
		<a href="integration-live.dsp?action=enable&aliasName=%value aliasName encode(url)%&stage=%value -urlencode stage%">No</a>
	  %endswitch%	  
      </TD>
	  
      <SCRIPT>writeTDspan("rowdata","1");</SCRIPT>
  		<A href="" onClick="return confirmDelete('%value aliasName%', '%value stage%', '%value stageDisplay%');">
          <IMG src="/WmRoot/icons/delete.gif" border="none">
        </A>
      </TD>     
      <SCRIPT>swapRows();</SCRIPT>
    </TR>
    %endloop%
	
    </TABLE>
     </TD>
     </TR>
  </TABLE>
  <form name="integrationLiveConnection" action="integration-live.dsp" method="POST">
  	<input type="hidden" name="aliasName">  	
  </form>  
  <FORM name="deleteform" action="integration-live.dsp" method="POST">
	<INPUT type="hidden" name="action" value="delete">
	<INPUT type="hidden" name="aliasName">
	<INPUT type="hidden" name="stage">
  </FORM>
  <FORM name="uploadform" action="integration-live.dsp" method="POST">
	<INPUT type="hidden" name="action" value="upload">
	<INPUT type="hidden" name="aliasName">
	<INPUT type="hidden" name="stage">
  </FORM>
 </BODY>
</HTML>
