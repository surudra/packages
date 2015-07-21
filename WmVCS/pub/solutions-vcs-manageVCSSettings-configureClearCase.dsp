<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<HTML>
<HEAD>
<TITLE>Clear Case Configuration</TITLE>
<LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
<SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
<SCRIPT>

    function check()
    {
    
     if (!verifyRequiredField("configForm","timeout"))
                { 
           		document.configForm.timeout.value=60000;
                }
          
     if(document.configForm.timeout.value==-1)     
          {
          	 	document.configForm.timeout.value=-1;
          }
          
     if (!isNum(document.configForm.timeout.value) && (document.configForm.timeout.value!=-1))
                      {
                                alert("Command Timeout must be a positive number");
                                document.configForm.timeout.value="";
                                document.configForm.timeout.focus();
                               return false;
                      }
    	
     if(!verifyRequiredNonNegNumber("configForm", "timeout") && (document.configForm.timeout.value!=-1))
                		{
                		alert("Command Timeout must be a positive number");
          			document.configForm.timeout.value="";
          	                document.configForm.timeout.focus();
          	                return false;
            		}
    
     if (verifyRequiredField("configForm","cWorkingFolder") &&
     	!(verifyRequiredField("configForm","ccFolder")) || (!verifyRequiredField("configForm","cWorkingFolder") &&
     	(verifyRequiredField("configForm","ccFolder"))))
     	{
     		if(document.configForm.cWorkingFolder.value==null || document.configForm.cWorkingFolder.value=="")
     			{
     				alert("No Working Folder Name was entered");
				document.configForm.cWorkingFolder.focus();
				return false;
			}
		else	
			{
				alert("No ClearCase Folder Name was entered");
				document.configForm.ccFolder.focus();
				return false;
			}
         }        
     else if(!verifyRequiredField("configForm","cWorkingFolder") &&
     	     !(verifyRequiredField("configForm","ccFolder")))
     {
     		return true;
     }
      
     	
     
     }
 </SCRIPT>    
</HEAD>
<BODY onLoad="setNavigation('/WmVCS/solutions-vcs-manageVCSSettings-configureClearCase.dsp', '/WmRoot/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm#context=is_help&topic=IS_Solutions_VCS_ClearCaseConfigScrn');">
       <DIV class="position">
          <TABLE WIDTH="100%">
             <TR>
                <TD class="menusection-Solutions" colspan=2>VCS &gt; Configuration &gt; Edit VCS Configuration &gt; ClearCase Configuration</TD>
             </TR>
              %ifvar actionPerformed equals('change')%
              %invoke wm.server.vcsservices:clearcaseConfiguration%
	     	
	     	       		    <tr><td colspan="2">&nbsp;</td></tr>
	     	       	           <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Settings changed successfully</TD></TR>
	     	 %onerror%
		<tr><td colspan="2">&nbsp;</td></tr>
	        <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Error in loading Settings</TD></TR>
	     	%endinvoke%       	       
 		%endif%
  		<TR>
 		<TD colspan="2">
 		  <UL>
 		    <LI>
 		   <A HREF="solutions-vcs-manageVCSSettings.dsp">Return to Edit VCS Configuration</A>
 		    </LI>
 		  </UL>
 		</TD>
	      </TR>
	       <TR>
	      	<TD></TD>
	      	<TD>
	      	  <TABLE class="tableForm" cellpadding=5>
	      	    <FORM NAME="configForm" ACTION="solutions-vcs-manageVCSSettings-configureClearCase.dsp" METHOD="POST">
	      		
	      		%invoke wm.server.vcsservices:readVCS%
	      		
	      		<TR>
	      		   <TD class="heading" colspan=2>
	      		 	ClearCase Configuration
	      		   </TD>
	      		</TR>
	      		<tr>
			  <TD class="oddrow-l">
			    <p align=right>Command Timeout (msec)</p>
			</TD>
			<TD class="oddrow-l"><INPUT NAME="timeout" VALUE="%value timeout%"></INPUT></td>
	      		</tr>
	      		<tr>
			    <TD class="evenrow-l">
				     <p align=right>ClearCase View Directory
				     </p>
			    </TD>
			    <TD class="evenrow-l">
				    <INPUT NAME="ccFolder" size=70 VALUE="%value clearcaseViewDir%"></INPUT></td>  
			
	      		</tr>
	      		<tr>
				<TD class="oddrow-l">
				     <p align=right>Working Directory
				      </p>
				 </TD>
				 <TD class="oddrow-l">
				 <INPUT NAME="cWorkingFolder" size=70 VALUE="%value clearcaseWorkingFolder%"></INPUT></td>  
				      		    
	      		</tr>
	      		 <TR>
				<TD class="evenrow-l">
					<p align=right>Checkout Mode
					</p>
				 </TD>
				 <TD class="evenrow-l" VALIGN="Center">
					<SELECT NAME="checkOutMode">
					%ifvar checkoutMode equals('reserved')%
					<OPTION SELECTED VALUE="reserved">Reserved</OPTION>
					<OPTION VALUE="unreserved">Unreserved</OPTION>
					<OPTION VALUE="both">Both</OPTION>	      
					%endif%
					%ifvar checkoutMode equals('unreserved')%
					<OPTION VALUE="reserved">Reserved</OPTION>
					<OPTION SELECTED VALUE="unreserved">Unreserved</OPTION>
					<OPTION VALUE="both">Both</OPTION>	      
					%endif%
					%ifvar checkoutMode equals('both')%
					<OPTION VALUE="reserved">Reserved</OPTION>
					<OPTION VALUE="unreserved">Unreserved</OPTION>
					<OPTION SELECTED VALUE="both">Both</OPTION>	      
					%endif%
					%ifvar checkoutMode equals('')%
					<OPTION VALUE="reserved">Reserved</OPTION>
					<OPTION VALUE="unreserved">Unreserved</OPTION>
					<OPTION VALUE="both">Both</OPTION>	      
					%endif%
					%ifvar checkoutMode -isnull%
					<OPTION VALUE="reserved">Reserved</OPTION>
					<OPTION VALUE="unreserved">Unreserved</OPTION>
					<OPTION VALUE="both">Both</OPTION>	      
					%endif%
					</SELECT>
				 </TD>
									      
                          </TR>
	      		<tr>
	      		    <TD class="oddrow-l">
				    <p align=right>ClearCase Branch Name
				    </p>
	      		    </TD>
	      		    <TD class="evenrow-l">
	      		  	     <INPUT NAME="branchName" size=70 VALUE=%value clearcaseBranchName%></INPUT></td>
	      		</tr>
	      		  		
	      		
	      		<tr>
	      		  <TD class="action" colspan=2>
	      		  		<INPUT TYPE="hidden" NAME="actionPerformed" VALUE="change"></INPUT>
	      		    	     <INPUT TYPE="submit" VALUE="Save Changes" ONCLICK="return check();"></INPUT>
	      		    	     </td>
	      		</tr>
	      		 %onerror%
					   <tr><td colspan="2">&nbsp;</td></tr>
				           <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Error in loading settings</TD></TR>
			  %endinvoke%
	      	    </FORM>
	      	  </table>
	      	</TD>
	      </TR>
	    </TABLE>
	  </DIV>
	</BODY>
</HTML>

