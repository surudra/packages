<HTML>
<HEAD>
<TITLE>Manage VCS Configuration Settings</TITLE>
<LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
</HEAD>
<BODY onLoad="setNavigation('/WmVCS/solutions-vcs-manageVCSSettings.dsp', '/WmRoot/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm#context=is_help&topic=IS_Solutions_VCS_EditConfigScrn');">
      <DIV class="position">
      <FORM NAME="manageVCSForm" METHOD="POST">
         <TABLE WIDTH="100%">
            <TR>
               <TD class="menusection-Solutions" colspan=2>VCS &gt; Configuration &gt; Edit VCS Configuration</TD>
            </TR>
  		%ifvar action equals('change')%
  		   %invoke wm.server.vcsservices:saveVCSType%
  		   <tr><td colspan="2">&nbsp;</td></tr>
  	           <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Settings saved successfully</TD></TR>
  	           %onerror%
		   	 <tr><td colspan="2">&nbsp;</td></tr>
		   	 <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Error in loading settings</TD></TR>
       		   %endinvoke%
  	       %endif%
  		<TR>
		<TD colspan="2">
		  <UL>
		    <LI>
		      <A HREF='solutions-vcs.dsp'>Return to VCS Home</A>
		    </LI>
		    %invoke wm.server.vcsservices:readVCS%
		    			    
		    <LI>
		    	<A HREF='
		    		 
					%ifvar vcsType equals('Microsoft Visual SourceSafe')%
						%ifvar vssList -notempty%
		    					solutions-vcs-manageVCSSettings-configureVSS.dsp
		    				%else%
		    					solutions-vcs-manageVCSSettings-blank.dsp	
		    				%endif%	
		    			%endif%
					%ifvar vcsType equals('ClearCase')%
						%ifvar clearcaseList -notempty%
							solutions-vcs-manageVCSSettings-configureClearCase.dsp
						%else%
							solutions-vcs-manageVCSSettings-blank.dsp	
						%endif%	
					%endif%
                                        %ifvar vcsType equals('Subversion')%
						%ifvar svnList -notempty%
							solutions-vcs-manageVCSSettings-configureSVN.dsp
						%else%
							solutions-vcs-manageVCSSettings-blank.dsp	
						%endif%	
					%endif%
					%ifvar vcsType equals('---None---')%
					solutions-vcs-manageVCSSettings-blank.dsp
					%endif%
					'>Advanced Settings</A>
		      	
		    </LI>
		    %endinvoke%
		  </UL>
		</TD>
	      </TR>
	       <TR>
	       <TD></TD>
	      	<TD>
	      	  <TABLE class="tableForm" cellpadding=5 >
	      	    
	      		<TR>
	      		  <TD class="heading" colspan=2>
	      		  	Select VCS Type
	      		  </TD>
	      		</TR>
	      		<TR>
			    <TD class="oddrow-l">
			   	 <p align=right>Select Version Control System</p>
			    </TD>
			
			    <TD class="oddrow-l" VALIGN="Center" width=60%>
			    
			    %invoke wm.server.vcsservices:readVCS%
			    		<SELECT NAME="vcs">
			    		%ifvar vcsType equals('---None---')%
			    		<OPTION Selected VALUE="none">----None----</OPTION>
			    		%else%
			    		<OPTION VALUE="none">----None----</OPTION>
			    		%endif%
			    	%ifvar clearcaseList -notempty%
			    		%ifvar vcsType equals('ClearCase')%	 
			    		<OPTION Selected VALUE="clearCase">ClearCase</OPTION>	
			    		%else%
			    		<OPTION VALUE="clearCase">ClearCase</OPTION>	
			    		%endif%
			    	%endif%
			    	%ifvar vssList -notempty%
			    		%ifvar vcsType equals('Microsoft Visual SourceSafe')%	
			    		<OPTION SELECTED VALUE="vss">Microsoft Visual SourceSafe</OPTION>     
			    		%else%
			    		<OPTION VALUE="vss">Microsoft Visual SourceSafe</OPTION>     
			    		%endif%
			    	%endif%
                                %ifvar svnList -notempty%
			    		%ifvar vcsType equals('Subversion')%	
			    		<OPTION SELECTED VALUE="svn">Subversion</OPTION>     
			    		%else%
			    		<OPTION VALUE="svn">Subversion</OPTION>     
			    		%endif%
			    	%endif%
                                
			    	       </SELECT>
			     </TD>
			</TR>
			    <TD class="action" colspan=2 >
			    	<INPUT TYPE="hidden" NAME="action" VALUE="change"></INPUT>
			    	<INPUT TYPE="submit" VALUE="Save Changes"></INPUT>
			    	
			   </td>
	      		</tr>
	      		 %onerror%
					   <tr><td colspan="2">&nbsp;</td></tr>
				           <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Error in loading settings</TD></TR>
		  	%endinvoke%
	      	   
	      	  </table>
	      	</TD>
	      </TR>
	    </TABLE>
	   </FORM>
	  </DIV> 
	</BODY>
</HTML>
	