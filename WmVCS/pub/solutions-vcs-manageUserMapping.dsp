<HTML>
<HEAD>
<TITLE>Managing User Mapping</TITLE>
<LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
<SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
<SCRIPT SRC="/WmRoot/users.js.txt"></SCRIPT>
 <SCRIPT LANGUAGE="JavaScript">
function confirmDelete (user)
      {
        
        var s = "Are you sure want to remove selected mapping?\n\n";
         return confirm(s);
        
      }
   	
 </SCRIPT>   
 </HEAD>

<BODY onLoad="setNavigation('/WmVCS/solutions-vcs-manageUserMapping.dsp', '/WmRoot/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm#context=is_help&topic=IS_Solutions_VCS_UserMapScrn');">
      <DIV class="position">
         <TABLE WIDTH="100%">
            <TR>
               <TD class="menusection-Solutions" colspan=2>VCS &gt; User Mapping</TD>
            </TR>
   %ifvar action%
       %switch action%
       %case 'edit'%
       	%invoke wm.server.vcsservices:addUser%
       	  <tr><td colspan="2">&nbsp;</td></tr>
	   <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Changed mapping for user "%value isUsername%"</TD></TR>
   	%onerror%
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Error in loading settings</TD></TR>
       	%endinvoke%	
        %case 'addMultipleUsers'%
        %invoke wm.server.vcsservices:addMultipleUsers%
         <tr><td colspan="2">&nbsp;</td></tr>
	 <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value addedCounts% User mapping(s) added</TD></TR>
	 %onerror%
	    <tr><td colspan="2">&nbsp;</td></tr>
	    <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Error in loading settings</TD></TR>
	%endinvoke%   
        %case 'delete'%
         %invoke wm.server.vcsservices:deleteUser%
         <tr><td colspan="2">&nbsp;</td></tr>
	 <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1 user mapping was deleted</TD></TR>
	  %onerror%
	    <tr><td colspan="2">&nbsp;</td></tr>
	    <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Error in loading settings</TD></TR>
	  %endinvoke%
	%endswitch%
    %endif%   
		<TR>
		<TD colspan="2">
		  <UL>
		     <LI>
		          <A HREF=solutions-vcs-manageUserMapping-createNewUserMapping.dsp>Create New User Mapping</A>
		    </LI>
		  </UL>
		</TD>
	      </TR>
	       <TR>
	       <TD></TD>
	      	<TD>
	      	  <TABLE class="tableForm" cellpadding=5>
	      	    <FORM NAME="manageVCSForm" METHOD="POST">
	      	    <TR>
	      		  <TD class="heading" colspan=4>Manage User Mapping</TD>
	      		</TR>
	      		<tr>
	      		  <TD class="oddcol" WIDTH="200"><p align=center>Integration Server User Name</p></TD>
	      		  <TD class="oddcol" WIDTH="200"><p align=center>VCS User Name</p></TD>
	      		  <TD class="oddcol" WIDTH="40"><p align=center>Edit</p></TD>
	      		  <TD class="oddcol" WIDTH="40"><p align=center>Delete</p></TD>
	      		</tr>
	      		 <script>resetRows();</script>
	      		%invoke pub.vcs.admin:getUsers%
	      		%ifvar users -notempty%
	      		%loop users%
	      		<tr>
			    <script>writeTD('rowdata');</script>%value devName%</td>
                            <script>writeTD('rowdata');</script>%value vcsName%</td>
	      		    <script>writeTD('rowdata');</script><p align=center>
	      		      	<A HREF="solutions-vcs-manageUserMapping-editUserMapping.dsp?action=edit&isUsername=%value devName%&vcsUsername=%value vcsName%">
			  	Edit</A>
			  	</p>
			   </TD>  
			  
			    <script>writeTD('rowdata');swapRows();</script><p align=center>
			    
			    <A class="imagelink" HREF="solutions-vcs-manageUserMapping.dsp?action=delete&isUsername=%value devName%"
                     onclick="return confirmDelete('%value -htmlcode devName%');"><IMG SRC="/WmRoot/icons/delete.gif" alt="Delete this Package" border="0"></A>
			    
			  	</p>
			  	
			  	
			  	</TD>  			
			</tr>	      		
			%endloop%
			%else%
				<TR><TD class="evenrow-l" colspan=4>There are no Integration Server users mapped with the VCS users.</TD>
				</TR>
			%endif%				
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
	
