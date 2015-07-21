<HTML>
<HEAD>
	<META http-equiv="Pragma" content="no-cache">
	<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
	<META HTTP-EQUIV="Expires" CONTENT="-1">

	<TITLE>Integration Server Settings</TITLE>
	<LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
	<LINK REL="stylesheet" TYPE="text/css" HREF="metadata.css">
	<SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
	<SCRIPT SRC="jquery-1.11.1.min.js"></SCRIPT>
	<SCRIPT SRC="metadata.js"></SCRIPT>
</HEAD>
 

<BODY onLoad="setNavigation('integration-live-metadata-applicationadd.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_webMethodsCloud_DefineApplicationScrn');">

<FORM id ="applicationForm" NAME="applicationForm" action="integration-live-metadata-share.dsp" method="POST">

  
	
  <TABLE WIDTH="100%">

            <TR>
                <TD class="menusection-Settings" colspan="3">
                   webMethods Cloud &gt; Applications &gt; Define Application 
                   
                </TD>
            </TR>

            <TR>
                <TD colspan="3">
                    <UL>
                        <LI><a href="integration-live-metadata-share.dsp">Return to webMethods Cloud Applications</a></LI>
                    </UL>
                </TD>
            </TR>
            
            <TR>
           	 <TD width="2%">
			  &nbsp;
			 </TD>
             <TD width="70%">
           		           		
            	<TABLE WIDTH="100%">
            		<TR>
            			<TD class="heading" colspan="2">webMethods Cloud Application</TD>
            		</TR>
            		<TR>
            			<TD class="oddrow" nowrap>Name</TD>
            			<TD class="oddrow-l">
            			 		<INPUT NAME="applicationName" id="applicationName" TYPE="TEXT" SIZE="50" >
            			 </TD>
            		</TR>
            		<TR>
            			<TD class="evenrow" nowrap>Description</TD>
            			<TD class="evenrow-l">
            			 		<INPUT NAME="description" id="description" TYPE="TEXT" SIZE="50" >
            			 </TD>
            		</TR>
            		<TR>
            			<TD class="oddrow" nowrap>Assign Services to Application</TD>
            			<TD class="oddrow-l" nowrap>
            			%invoke wm.client.integrationlive.metadatashare:getPackagesForShare%
            			%endinvoke%
            			<input type="hidden" name="restrictedChars" id="restrictedChars" value="%value encode(htmlattr) restrictedChars%"/>
	           			<TABLE width="100%">
	           				<TR>
 	           					<TD width="75%"><b>Package/Services</b></TD>
 	           					<TD width="25%"><b>Display Name</b></TD>
 	           				</TR>
 	           				<TR>
 	           					<TD width="75%">&nbsp;</TD>
 	           					<TD width="25%">&nbsp;</TD>
 	           				</TR>
	           			%loop packages%
 	           					<TBODY width="100%">
 	           						
 	           						<TR title="%value%">
 	           							<TD colspan="2">
 	           								<a onclick="toggle(this,'%value encode(javascript)%');">
 	           									<img id="img%value%" src="images/plus.gif"/><label class=".label">&nbsp;%value encode(htmlall)% </label>
 	           								</a>
 	           							</TD>
 	           						</TR>
 	           					</TBODY>
 	           					<TBODY id="%value encode(htmlall)%">
 	           					</TBODY>								
						%endloop%
							<TR>
 	           					<TD width="75%">&nbsp;</TD>
 	           					<TD width="25%">&nbsp;</TD>
 	           				</TR>
						</TABLE>	
             			</TD>
           			</TR>
            	</TABLE>
             </TD>
             <TD width="28%">
			  &nbsp;
			 </TD>
			 </FORM>
            </TR>
            <TR>
            	<FORM name="appSubmitForm" id="appSubmitForm"  action="integration-live-metadata-share.dsp" method="POST" onsubmit="return validateData();">
            	
            	<input type="hidden" name="operation" value="save"/>
            	<input type="hidden" name="applicationName" id="submitAppName"/>
            	<input type="hidden" name="description" id="submitDesc" />
            	<input type="hidden" name="isNew" value="true" />
            	
            	<TD width="2%">
            	&nbsp;
            	</TD>
				<TD  class="action" >
					<input type="submit" name="submit" value="Save Changes" onclick="submitForm();"/>
				</TD>
				 <TD width="28%">
			  	&nbsp;
				</TD>
				</FORM>
			</TR>
    </TABLE>
	


</BODY>

</HTML>