<HTML>
<HEAD>
	<META http-equiv="Pragma" content="no-cache">
	<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
	<META HTTP-EQUIV="Expires" CONTENT="-1">

	<TITLE>Integration Server Settings</TITLE>
	<LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
	<LINK REL="stylesheet" TYPE="text/css" HREF="metadata.css">
	<SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
	<SCRIPT SRC="metadata.js"></SCRIPT>
</HEAD>
 

<BODY onLoad="setNavigation('integration-live-metadata-upload.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_webMethodsCloud_UploadApplicationScrn');">

<FORM id ="applicationForm" NAME="applicationForm" action="integration-live-metadata-share.dsp" method="POST" onsubmit="return submitUploadApplication();">
  <input type="hidden" name="uploadAction" value="yes"/>
  <TABLE WIDTH="100%">

            <TR>
                <TD class="menusection-Settings" colspan="3">
                   webMethods Cloud &gt; Applications &gt; Upload Application 
                </TD>
            </TR>

            <TR>
                <TD colspan="3">
                    <UL>
                        <LI><a href="integration-live-metadata-share.dsp">Return to webMethods Cloud Applications</a></LI>
                    </UL>
                </TD>
            </TR>
            %invoke wm.client.integrationlive.metadatashare:getApplicationForUploadDisplay%
			%endinvoke%
			%ifvar message -notempty%			
				<TR><TD colspan="2">&nbsp;</TD></TR>
				<TR>
				 	<TD width="2%"> &nbsp;</TD>
				 	<TD width="70%"class="message" colspan=2>%value message%</TD>
				 	<TD width="28%">  &nbsp; </TD>
				</TR>
			%endif%
            <TR>
           	 <TD width="2%">
			  &nbsp;
			 </TD>
             <TD width="70%">
           		           		
            	<TABLE WIDTH="100%">
            		<TR>
            			<TD class="heading" colspan="2">Upload Application</TD>
            		</TR>
            		
            		<TR>
            			<TD class="oddrow" nowrap>Name</TD>
            			<TD class="oddrow-l">
            			 		<INPUT NAME="applicationName" id="applicationName" TYPE="TEXT" VALUE="%value applicationName%" SIZE="50" readonly/>
            			 </TD>
            		</TR>
            		<TR>
            			<TD class="evenrow" nowrap>Select Accounts</TD>
            			<TD class="evenrow-l">
            				<TABLE cellpadding=4 cellspacing=4>
            					<TR>
            						<TD class="evenrow-l" nowrap ><B>Select</B></TD>
            						<TD class="evenrow-l" nowrap ><B>Alias</B></TD>
            						<TD class="evenrow-l" nowrap ><B>Stage</B></TD>
            						%loop connections%
	            						<TR>
	            							<TD class="evenrow-l" nowrap >
	            								%ifvar isSelected equals('true')%
	            			 						&nbsp; <INPUT TYPE="CHECKBOX" NAME="connections" CLASS="cbstyle" VALUE="%value connectionName%_%value connectionStage%" CHECKED/>
	            			 					%else%
	            			 						&nbsp; <INPUT TYPE="CHECKBOX" NAME="connections" CLASS="cbstyle" VALUE="%value connectionName%_%value connectionStage%"/>
	            			 					%endif%
	            							</TD>
	            							<TD class="evenrow-l" nowrap > %value connectionName%</TD>
	            							<TD class="evenrow-l" nowrap >%value connectionStageDisplayName%</TD>     							
	            						</TR>
            			 			%endloop%
            					</TR>
            				</TABLE>
            				
            			 </TD>
            		</TR>
            	</TABLE>
             </TD>
             <TD width="28%">
			  &nbsp;
			 </TD>
		    </TR>
            <TR>
            	<TD width="2%">
            	&nbsp;
            	</TD>
				<TD  class="action" >
				%ifvar message -notempty%	
					<input type="submit" name="submit" value="Upload" disabled/>
				%else%
					<input type="submit" name="submit" value="Upload"/>
				%endif%
				</TD>
				 <TD width="28%">
			  	&nbsp;
				</TD>
				</FORM>
			</TR>
    </TABLE>
	


</BODY>

</HTML>