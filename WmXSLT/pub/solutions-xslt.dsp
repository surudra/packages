<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<HTML>
<HEAD>
<LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
<TITLE>VCS</TITLE>
<SCRIPT src="/WmRoot/webMethods.js.txt"></SCRIPT>
   </HEAD>
   <BODY onLoad="setNavigation('/WmXSLT/solutions-xslt.dsp', '/WmRoot/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm#context=is_help&topic=IS_Packages_WmXSLTpkg_Scrn');">
      <DIV class="position">
         <TABLE WIDTH="100%">
            <TR>
               <TD class="menusection-Solutions" colspan=2>WmXSLT &gt; Transformer Factory Settings</TD>
            </TR>

  	   <TR>
               <TD colspan=2>
                    <UL>
                        <LI><A HREF=settings-edit.dsp>Edit Transformer Factory Settings</A>
                        
                    </UL>
               </TD>
  	    </TR>
  	     <TR>
  	        <TD><IMG SRC="/WmRoot/images/blank.gif" height=10 width=10></TD>
        	<TD>
				<TABLE>

					<TR><TD class="heading" colspan=3>Transformer Factory Settings</TD></TR>
					%invoke wm.xslt.Admin:about%
					  %scope systemAttributes%
					<tr>
						<td class="oddrow"><p>TransformerFactory</p></td>
						<td class="oddrow-l"><p>%value TransformerFactory%</p></td>
					</tr>
					  <TR>
						  <td class="evenrow" valign="top"><p>TransformerFactory Attributes</p></td>
						<TD class="evenrow-l" colspan=2>
						  <TABLE width=100%>
							<TR>
								
							  <TD><PRE class="fixedwidth">%value FactoryAttributes%








								</PRE>
							  </TD>
						  </TR>
					  </TABLE>
					  </TD>
					</TR>


					  </tr>
					  %endscope%
			%endinvoke%		
		  
		</TABLE>
		</TD>
	      </TR>	
</TABLE>
</DIV>
</BODY>
</HTML>
