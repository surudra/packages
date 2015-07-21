<HTML>
<HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">

<TITLE>Integration Server Settings</TITLE>
<LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
<SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
<SCRIPT SRC="metadata.js"></SCRIPT>
</HEAD>
 
<BODY onLoad="setNavigation('integration-live-metadata-share.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_webMethodsCloud_ApplicationsScrn');">
  <TABLE width="100%">
   <TR>
      <TD class="menusection-Settings" colspan="2">
          webMethods Cloud &gt; Applications 
      </TD>
    </TR>
     %ifvar operation -notempty%
		%invoke wm.client.integrationlive.metadatashare:saveApplication%
			%ifvar message%
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td class="message" colspan="2">%value message%</td></tr>
			%endif%
			%onerror%
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
			%endinvoke%
 	%endif%

 	%ifvar deleteAction -notempty%
		%invoke wm.client.integrationlive.metadatashare:deleteApplication%
			%ifvar message%
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td class="message" colspan="2">%value message%</td></tr>
			%endif%
			%onerror%
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
			%endinvoke%
 	%endif%
 	
 	%ifvar uploadAction -notempty%
		%invoke wm.client.integrationlive.metadatashare:uploadApplication%
			%ifvar message%
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td class="message" colspan="2">%value message%</td></tr>
			%endif%
			%onerror%
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
			%endinvoke%
 	%endif%
 	
    <TR>
      <TD colspan="2">
        <UL>
          	<LI><A HREF="integration-live-metadata-applicationadd.dsp">Define webMethods Cloud Application</A></LI>
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
     
      <TD class="heading" colspan="5">webMethods Cloud Applications</TD>
    </TR>
    
    %invoke wm.client.integrationlive.metadatashare:getApplications%
   	%endinvoke%
    
    <TR> 
      <TD class="oddcol-l" nowrap width="25%">Name</TD>
      <TD class="oddcol" nowrap width="35%">Description</TD>
      <TD class="oddcol" nowrap width="20%">Last Uploaded Time</TD>
      <TD class="oddcol" nowrap width="10%">Upload</TD>
      <TD class="oddcol" nowrap width="10%">Delete</TD>
    </TR>

    %loop applications%
    <TR>
     
      <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
      	 <A href="javascript:document.forms['applicationForm'].submit()" onClick="return editApplication('%value name%');">
          %value name% 
        </A> 
      </TD>
      
       <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
          %value description% 
       </TD>
       
       <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
          %value uploadedTimeDateStr%
       </TD>
      
      <SCRIPT>writeTDspan("rowdata","1");</SCRIPT>
        <A href="javascript:document.forms['applicationForm'].submit()" onClick="return uploadApplication('%value name%')">
        	%ifvar uploadPending equals('true')%
          		<IMG src="/WmRoot/icons/upload.png" border="none"/>
       		%else%
          		<IMG src="/WmRoot/icons/upload.png" border="none"/>
       	 	%endif%
        </A>          
      </TD>
      
      <SCRIPT>writeTDspan("rowdata","1");</SCRIPT>
       <A href="javascript:document.forms['applicationForm'].submit()" onClick="return removeApplication('%value name%');">
          <IMG src="/WmRoot/icons/delete.gif" border="none"/>
        </A>          
      </TD>
      <SCRIPT>swapRows();</SCRIPT>
      
    </TR>
    %endloop%
	
    </TABLE>
     </TD>
     </TR>
  </TABLE>
  <form name="applicationForm" id="applicationForm" method="POST">
  	<input type="hidden" name="applicationName" id="applicationName"/>
  	<input type="hidden" name="deleteAction" id="deleteAction"/>
  	<input type="hidden" name="uploadAction" id="uploadAction"/>
  </form>      
</BODY>
</HTML>
