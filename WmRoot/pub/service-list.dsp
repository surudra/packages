<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <TITLE>Service List</TITLE>

    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
    <SCRIPT LANGUAGE="JavaScript">
    var currentInterface = "";
    function confirmDelete (svc)
    {
      var msg = "OK to delete '"+svc+"' service?";
      return confirm (msg);
    }
    function aclAssign ()
    {
    }
  var effectiveACL = 0;
  var effectiveACLBrowse = 0;
  var effectiveACLRead = 0;
  var effectiveACLWrite = 0;

    </SCRIPT>

  </HEAD>

  <BODY onLoad="setNavigation('package-list.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_BrowseFldrScrn');">
    <TABLE WIDTH=100%>
      <TR>
        <TD class="menusection-Packages" colspan=2>
          Packages &gt;
          Management &gt;
          Folders &gt;
          %ifvar interface% <script>currentInterface="%value interface%";document.write(currentInterface.replace(/\./g, " &gt; "  ));</script> %else% Top Level%endif%
        </TD>
      </TR>
        %ifvar action%
          %switch action%
            %case 'aclassign'%
              %invoke wm.server.access:aclAssign%
                %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
                  <TR><TD class="message" colspan="2">%value message%</TD></TR>
                %endif%
              %endinvoke%
            %endswitch%
          %endif%

          %invoke wm.server.access.adminui:aclList%
          %invoke wm.server.xidl.adminui:getInterfacesPlus%

          %ifvar parent%
            <TR>
              <TD colspan=2>
                <UL>
                  <LI><A href="service-list.dsp"><a href="package-list.dsp">Return to Package Management</A></LI>
                  <LI><A href="service-list.dsp?interface=%value /parent%">Up one level</A> (<script>document.write("%value /parent%".replace(/.*\./g, ""  ));</script>)</LI>
                </UL>
              </TD>
            </TR>
          %else%
            %ifvar interface%
            <TR>
              <TD colspan=2>
                <UL>
                  <LI><A href="service-list.dsp"><a href="package-list.dsp">Return to Package Management</A></LI>
                  <LI><A href="service-list.dsp">Up one level</A> Top Level</LI>
                </UL>
              </TD>
            </TR>
            %else%
            <TR>
              <TD colspan=2>
                <UL>
                  <LI><A href="service-list.dsp"><a href="package-list.dsp">Return to Package Management</A></LI>
                </UL>
              </TD>
            </TR>
            %endif%
          %endif%
      <TR>
        <TD><IMG SRC="images/blank.gif" height=10 width=10 border=0></TD>
        <TD>
          <TABLE class="tableView">
          <TR>
            <TD class="heading" colspan=7>Folder List</TD>
          </TR>
            <TR>
              <TD class="oddcol-l">Folders</TD>
              <TD class="oddcol-l">List ACL</TD>
              <TD class="oddcol-l">Read ACL</TD>
              <TD class="oddcol-l">Write ACL</TD>
              <TD class="oddcol-l">Execute ACL</TD>
              <TD class="oddcol">Folders</TD>
              <TD class="oddcol">Services</TD>
            </TR>

          %ifvar interfaces%
            <script>resetRows();</script>
            %loop interfaces%
            <TR>
              <script>writeTD("rowdata-l");</script><nobr>&nbsp;&nbsp;<A HREF="service-list.dsp?interface=%value fullname%"><IMG src="icons/dir.gif" border=0></A>&nbsp;
                <A HREF="service-list.dsp?interface=%value fullname%"><script>document.write(" %value fullname%".replace(currentInterface + ".", ""  ));</script></A></nobr></TD>

              <script>writeTD("rowdata-l");</script>

                %ifvar browseaclgroup -notempty%
                    <A href="acl-assign.dsp?parent=%value /interface%&interface=%value fullname%&acl=%value acl%&browseaclgroup=%value browseaclgroup%&readaclgroup=%value readaclgroup%&writeaclgroup=%value writeaclgroup%&effectiveAcl=%value effectiveAcl%&effectiveAclBrowse=%value effectiveAclBrowse%&effectiveAclRead=%value effectiveAclRead%&effectiveAclWrite=%value effectiveAclWrite%&parentexecuteaclgroup=%value /parentexecuteaclgroup%&parentbrowseaclgroup=%value /parentbrowseaclgroup%&parentreadaclgroup=%value /parentreadaclgroup%&parentwriteaclgroup=%value /parentwriteaclgroup%">%value browseaclgroup%</A>
                %else%
                   %ifvar effectiveAclBrowse -notempty%
                      <A href="acl-assign.dsp?parent=%value /interface%&interface=%value fullname%&acl=%value acl%&browseaclgroup=%value browseaclgroup%&readaclgroup=%value readaclgroup%&writeaclgroup=%value writeaclgroup%&effectiveAcl=%value effectiveAcl%&effectiveAclBrowse=%value effectiveAclBrowse%&effectiveAclRead=%value effectiveAclRead%&effectiveAclWrite=%value effectiveAclWrite%&parentexecuteaclgroup=%value /parentexecuteaclgroup%&parentbrowseaclgroup=%value /parentbrowseaclgroup%&parentreadaclgroup=%value /parentreadaclgroup%&parentwriteaclgroup=%value /parentwriteaclgroup%">&lt;%value effectiveAclBrowse%&gt;</A>
                   %else%
                      <A href="acl-assign.dsp?parent=%value /interface%&interface=%value fullname%&acl=%value acl%&browseaclgroup=%value browseaclgroup%&readaclgroup=%value readaclgroup%&writeaclgroup=%value writeaclgroup%&effectiveAcl=%value effectiveAcl%&effectiveAclBrowse=%value effectiveAclBrowse%&effectiveAclRead=%value effectiveAclRead%&effectiveAclWrite=%value effectiveAclWrite%&parentexecuteaclgroup=%value /parentexecuteaclgroup%&parentbrowseaclgroup=%value /parentbrowseaclgroup%&parentreadaclgroup=%value /parentreadaclgroup%&parentwriteaclgroup=%value /parentwriteaclgroup%">&lt;%value /parentbrowseaclgroup%&gt;</A>
                   %endif%
                   <script>
	              effectiveACLBrowse++;
	           </script>
                %endif%
              </TD>

              <script>writeTD("rowdata-l");</script>
                %ifvar readaclgroup -notempty%
                    <A href="acl-assign.dsp?parent=%value /interface%&interface=%value fullname%&acl=%value acl%&browseaclgroup=%value browseaclgroup%&readaclgroup=%value readaclgroup%&writeaclgroup=%value writeaclgroup%&effectiveAcl=%value effectiveAcl%&effectiveAclBrowse=%value effectiveAclBrowse%&effectiveAclRead=%value effectiveAclRead%&effectiveAclWrite=%value effectiveAclWrite%&parentexecuteaclgroup=%value /parentexecuteaclgroup%&parentbrowseaclgroup=%value /parentbrowseaclgroup%&parentreadaclgroup=%value /parentreadaclgroup%&parentwriteaclgroup=%value /parentwriteaclgroup%">%value readaclgroup%</A>
                %else%
                   %ifvar effectiveAclRead -notempty%
                      <A href="acl-assign.dsp?parent=%value /interface%&interface=%value fullname%&acl=%value acl%&browseaclgroup=%value browseaclgroup%&readaclgroup=%value readaclgroup%&writeaclgroup=%value writeaclgroup%&effectiveAcl=%value effectiveAcl%&effectiveAclBrowse=%value effectiveAclBrowse%&effectiveAclRead=%value effectiveAclRead%&effectiveAclWrite=%value effectiveAclWrite%&parentexecuteaclgroup=%value /parentexecuteaclgroup%&parentbrowseaclgroup=%value /parentbrowseaclgroup%&parentreadaclgroup=%value /parentreadaclgroup%&parentwriteaclgroup=%value /parentwriteaclgroup%">&lt;%value effectiveAclRead%&gt;</A>
                   %else%
                      <A href="acl-assign.dsp?parent=%value /interface%&interface=%value fullname%&acl=%value acl%&browseaclgroup=%value browseaclgroup%&readaclgroup=%value readaclgroup%&writeaclgroup=%value writeaclgroup%&effectiveAcl=%value effectiveAcl%&effectiveAclBrowse=%value effectiveAclBrowse%&effectiveAclRead=%value effectiveAclRead%&effectiveAclWrite=%value effectiveAclWrite%&parentexecuteaclgroup=%value /parentexecuteaclgroup%&parentbrowseaclgroup=%value /parentbrowseaclgroup%&parentreadaclgroup=%value /parentreadaclgroup%&parentwriteaclgroup=%value /parentwriteaclgroup%">&lt;%value /parentreadaclgroup%&gt;</A>
                   %endif%
                   <script>
	              effectiveACLRead++;
	           </script>
                %endif%
              </TD>

              <script>writeTD("rowdata-l");</script>
                %ifvar writeaclgroup -notempty%
                    <A href="acl-assign.dsp?parent=%value /interface%&interface=%value fullname%&acl=%value acl%&browseaclgroup=%value browseaclgroup%&readaclgroup=%value readaclgroup%&writeaclgroup=%value writeaclgroup%&effectiveAcl=%value effectiveAcl%&effectiveAclBrowse=%value effectiveAclBrowse%&effectiveAclRead=%value effectiveAclRead%&effectiveAclWrite=%value effectiveAclWrite%">%value writeaclgroup%</A>
                %else%
                   %ifvar effectiveAclWrite -notempty%
                      <A href="acl-assign.dsp?parent=%value /interface%&interface=%value fullname%&acl=%value acl%&browseaclgroup=%value browseaclgroup%&readaclgroup=%value readaclgroup%&writeaclgroup=%value writeaclgroup%&effectiveAcl=%value effectiveAcl%&effectiveAclBrowse=%value effectiveAclBrowse%&effectiveAclRead=%value effectiveAclRead%&effectiveAclWrite=%value effectiveAclWrite%">&lt;%value effectiveAclWrite%&gt;</A>
                   %else%
                      <A href="acl-assign.dsp?parent=%value /interface%&interface=%value fullname%&acl=%value acl%&browseaclgroup=%value browseaclgroup%&readaclgroup=%value readaclgroup%&writeaclgroup=%value writeaclgroup%&effectiveAcl=%value effectiveAcl%&effectiveAclBrowse=%value effectiveAclBrowse%&effectiveAclRead=%value effectiveAclRead%&effectiveAclWrite=%value effectiveAclWrite%">&lt;%value /parentwriteaclgroup%&gt;</A>
                   %endif%
                   <script>
	              effectiveACLWrite++;
	           </script>
                %endif%
              </TD>

              <script>writeTD("rowdata-l");</script>
                %ifvar acl -notempty%
                    <A href="acl-assign.dsp?parent=%value /interface%&interface=%value fullname%&acl=%value acl%&browseaclgroup=%value browseaclgroup%&readaclgroup=%value readaclgroup%&writeaclgroup=%value writeaclgroup%&effectiveAcl=%value effectiveAcl%&effectiveAclBrowse=%value effectiveAclBrowse%&effectiveAclRead=%value effectiveAclRead%&effectiveAclWrite=%value effectiveAclWrite%&parentexecuteaclgroup=%value /parentexecuteaclgroup%&parentbrowseaclgroup=%value /parentbrowseaclgroup%&parentreadaclgroup=%value /parentreadaclgroup%&parentwriteaclgroup=%value /parentwriteaclgroup%">%value acl%</A>
                %else%
                   %ifvar effectiveAcl -notempty%
                      <A href="acl-assign.dsp?parent=%value /interface%&interface=%value fullname%&acl=%value acl%&browseaclgroup=%value browseaclgroup%&readaclgroup=%value readaclgroup%&writeaclgroup=%value writeaclgroup%&effectiveAcl=%value effectiveAcl%&effectiveAclBrowse=%value effectiveAclBrowse%&effectiveAclRead=%value effectiveAclRead%&effectiveAclWrite=%value effectiveAclWrite%&parentexecuteaclgroup=%value /parentexecuteaclgroup%&parentbrowseaclgroup=%value /parentbrowseaclgroup%&parentreadaclgroup=%value /parentreadaclgroup%&parentwriteaclgroup=%value /parentwriteaclgroup%">&lt;%value effectiveAcl%&gt;</A>
                   %else%
                      <A href="acl-assign.dsp?parent=%value /interface%&interface=%value fullname%&acl=%value acl%&browseaclgroup=%value browseaclgroup%&readaclgroup=%value readaclgroup%&writeaclgroup=%value writeaclgroup%&effectiveAcl=%value effectiveAcl%&effectiveAclBrowse=%value effectiveAclBrowse%&effectiveAclRead=%value effectiveAclRead%&effectiveAclWrite=%value effectiveAclWrite%&parentexecuteaclgroup=%value /parentexecuteaclgroup%&parentbrowseaclgroup=%value /parentbrowseaclgroup%&parentreadaclgroup=%value /parentreadaclgroup%&parentwriteaclgroup=%value /parentwriteaclgroup%">&lt;%value /parentexecuteaclgroup%&gt;</A>
                   %endif%
                   <script>
	              effectiveACL++;
	           </script>
                %endif%
              </TD>

              <script>writeTD("rowdata");</script>%value numIfc%</TD>
              <script>writeTD("rowdata");</script>%value numSvc%</TD>
            </TR>
              <script>swapRows();</script>
            %endloop%
         %else%
          <TR>
            <TD class="evenrow-l" colspan=7>No sub-folders</TD>
          </TR>
         %endif%
       </TABLE>
      <BR>
      <TABLE class="tableView">
      <TR>
        <TD class="heading" colspan=6>Service List</TD>
      </TR>
      <TR>
        <TD class="oddcol-l">Service Name</TD>
        <TD class="oddcol-l">List ACL</TD>
        <TD class="oddcol-l">Read ACL</TD>
        <TD class="oddcol-l">Write ACL</TD>
        <TD class="oddcol-l">Execute ACL</TD>
        <TD class="oddcol">Test</TD>
      </TR>

      %ifvar services%
      <script>resetRows();</script>
      %loop services%
      <TR>
        <script>writeTD("rowdata-l");</script>
         <nobr><A HREF="service-info.dsp?service=%value /interface%:%value name%&browsefolders=true"><IMG src="icons/file.gif" border=0></A>&nbsp;<A valign="middle" HREF="service-info.dsp?service=%value /interface%:%value name%&browsefolders=true">%value name%</A></nobr></TD>

        <script>writeTD("rowdata-l");</script>
        %ifvar browseaclgroup -notempty%
	   <A href="acl-assign.dsp?parent=%value /interface%&interface=%value /interface%&service=%value name%&acl=%value acl%&browseaclgroup=%value browseaclgroup%&readaclgroup=%value readaclgroup%&writeaclgroup=%value writeaclgroup%&effectiveAcl=%value effectiveAcl%&effectiveAclBrowse=%value effectiveAclBrowse%&effectiveAclRead=%value effectiveAclRead%&effectiveAclWrite=%value effectiveAclWrite%&parentexecuteaclgroup=%value /parentexecuteaclgroup%&parentbrowseaclgroup=%value /parentbrowseaclgroup%&parentreadaclgroup=%value /parentreadaclgroup%&parentwriteaclgroup=%value /parentwriteaclgroup%">%value browseaclgroup%</A>
        %else%
           %ifvar effectiveAclBrowse -notempty%
              <A href="acl-assign.dsp?parent=%value /interface%&interface=%value /interface%&service=%value name%&acl=%value acl%&browseaclgroup=%value browseaclgroup%&readaclgroup=%value readaclgroup%&writeaclgroup=%value writeaclgroup%&effectiveAcl=%value effectiveAcl%&effectiveAclBrowse=%value effectiveAclBrowse%&effectiveAclRead=%value effectiveAclRead%&effectiveAclWrite=%value effectiveAclWrite%&parentexecuteaclgroup=%value /parentexecuteaclgroup%&parentbrowseaclgroup=%value /parentbrowseaclgroup%&parentreadaclgroup=%value /parentreadaclgroup%&parentwriteaclgroup=%value /parentwriteaclgroup%">&lt;%value effectiveAclBrowse%&gt;</A>
           %else%
  	      <A href="acl-assign.dsp?parent=%value /interface%&interface=%value /interface%&service=%value name%&acl=%value acl%&browseaclgroup=%value browseaclgroup%&readaclgroup=%value readaclgroup%&writeaclgroup=%value writeaclgroup%&effectiveAcl=%value effectiveAcl%&effectiveAclBrowse=%value effectiveAclBrowse%&effectiveAclRead=%value effectiveAclRead%&effectiveAclWrite=%value effectiveAclWrite%&parentexecuteaclgroup=%value /parentexecuteaclgroup%&parentbrowseaclgroup=%value /parentbrowseaclgroup%&parentreadaclgroup=%value /parentreadaclgroup%&parentwriteaclgroup=%value /parentwriteaclgroup%">&lt;%value /parentbrowseaclgroup%&gt;</A>
           %endif%
           <script>
	      effectiveACLBrowse++;
	   </script>
        %endif%
        </TD>

        <script>writeTD("rowdata-l");</script>
        %ifvar readaclgroup -notempty%
	   <A href="acl-assign.dsp?parent=%value /interface%&interface=%value /interface%&service=%value name%&acl=%value acl%&browseaclgroup=%value browseaclgroup%&readaclgroup=%value readaclgroup%&writeaclgroup=%value writeaclgroup%&effectiveAcl=%value effectiveAcl%&effectiveAclBrowse=%value effectiveAclBrowse%&effectiveAclRead=%value effectiveAclRead%&effectiveAclWrite=%value effectiveAclWrite%&parentexecuteaclgroup=%value /parentexecuteaclgroup%&parentbrowseaclgroup=%value /parentbrowseaclgroup%&parentreadaclgroup=%value /parentreadaclgroup%&parentwriteaclgroup=%value /parentwriteaclgroup%">%value readaclgroup%</A>
        %else%
           %ifvar effectiveAclRead -notempty%
              <A href="acl-assign.dsp?parent=%value /interface%&interface=%value /interface%&service=%value name%&acl=%value acl%&browseaclgroup=%value browseaclgroup%&readaclgroup=%value readaclgroup%&writeaclgroup=%value writeaclgroup%&effectiveAcl=%value effectiveAcl%&effectiveAclBrowse=%value effectiveAclBrowse%&effectiveAclRead=%value effectiveAclRead%&effectiveAclWrite=%value effectiveAclWrite%&parentexecuteaclgroup=%value /parentexecuteaclgroup%&parentbrowseaclgroup=%value /parentbrowseaclgroup%&parentreadaclgroup=%value /parentreadaclgroup%&parentwriteaclgroup=%value /parentwriteaclgroup%">&lt;%value effectiveAclRead%&gt;</A>
           %else%
  	      <A href="acl-assign.dsp?parent=%value /interface%&interface=%value /interface%&service=%value name%&acl=%value acl%&browseaclgroup=%value browseaclgroup%&readaclgroup=%value readaclgroup%&writeaclgroup=%value writeaclgroup%&effectiveAcl=%value effectiveAcl%&effectiveAclBrowse=%value effectiveAclBrowse%&effectiveAclRead=%value effectiveAclRead%&effectiveAclWrite=%value effectiveAclWrite%&parentexecuteaclgroup=%value /parentexecuteaclgroup%&parentbrowseaclgroup=%value /parentbrowseaclgroup%&parentreadaclgroup=%value /parentreadaclgroup%&parentwriteaclgroup=%value /parentwriteaclgroup%">&lt;%value /parentreadaclgroup%&gt;</A>
           %endif%
           <script>
	      effectiveACLRead++;
	   </script>
        %endif%
        </TD>

        <script>writeTD("rowdata-l");</script>
        %ifvar writeaclgroup -notempty%
	   <A href="acl-assign.dsp?parent=%value /interface%&interface=%value /interface%&service=%value name%&acl=%value acl%&browseaclgroup=%value browseaclgroup%&readaclgroup=%value readaclgroup%&writeaclgroup=%value writeaclgroup%&effectiveAcl=%value effectiveAcl%&effectiveAclBrowse=%value effectiveAclBrowse%&effectiveAclRead=%value effectiveAclRead%&effectiveAclWrite=%value effectiveAclWrite%&parentexecuteaclgroup=%value /parentexecuteaclgroup%&parentbrowseaclgroup=%value /parentbrowseaclgroup%&parentreadaclgroup=%value /parentreadaclgroup%&parentwriteaclgroup=%value /parentwriteaclgroup%">%value writeaclgroup%</A>
        %else%
           %ifvar effectiveAclWrite -notempty%
              <A href="acl-assign.dsp?parent=%value /interface%&interface=%value /interface%&service=%value name%&acl=%value acl%&browseaclgroup=%value browseaclgroup%&readaclgroup=%value readaclgroup%&writeaclgroup=%value writeaclgroup%&effectiveAcl=%value effectiveAcl%&effectiveAclBrowse=%value effectiveAclBrowse%&effectiveAclRead=%value effectiveAclRead%&effectiveAclWrite=%value effectiveAclWrite%&parentexecuteaclgroup=%value /parentexecuteaclgroup%&parentbrowseaclgroup=%value /parentbrowseaclgroup%&parentreadaclgroup=%value /parentreadaclgroup%&parentwriteaclgroup=%value /parentwriteaclgroup%">&lt;%value effectiveAclWrite%&gt;</A>
           %else%
  	      <A href="acl-assign.dsp?parent=%value /interface%&interface=%value /interface%&service=%value name%&acl=%value acl%&browseaclgroup=%value browseaclgroup%&readaclgroup=%value readaclgroup%&writeaclgroup=%value writeaclgroup%&effectiveAcl=%value effectiveAcl%&effectiveAclBrowse=%value effectiveAclBrowse%&effectiveAclRead=%value effectiveAclRead%&effectiveAclWrite=%value effectiveAclWrite%&parentexecuteaclgroup=%value /parentexecuteaclgroup%&parentbrowseaclgroup=%value /parentbrowseaclgroup%&parentreadaclgroup=%value /parentreadaclgroup%&parentwriteaclgroup=%value /parentwriteaclgroup%">&lt;%value /parentwriteaclgroup%&gt;</A>
           %endif%
           <script>
	      effectiveACLWrite++;
	   </script>
        %endif%
        </TD>

        <script>writeTD("rowdata-l");</script>
        %ifvar acl -notempty%
	   <A href="acl-assign.dsp?parent=%value /interface%&interface=%value /interface%&service=%value name%&acl=%value acl%&browseaclgroup=%value browseaclgroup%&readaclgroup=%value readaclgroup%&writeaclgroup=%value writeaclgroup%&effectiveAcl=%value effectiveAcl%&effectiveAclBrowse=%value effectiveAclBrowse%&effectiveAclRead=%value effectiveAclRead%&effectiveAclWrite=%value effectiveAclWrite%&parentexecuteaclgroup=%value /parentexecuteaclgroup%&parentbrowseaclgroup=%value /parentbrowseaclgroup%&parentreadaclgroup=%value /parentreadaclgroup%&parentwriteaclgroup=%value /parentwriteaclgroup%">%value acl%</A>
        %else%
           %ifvar effectiveAcl -notempty%
              <A href="acl-assign.dsp?parent=%value /interface%&interface=%value /interface%&service=%value name%&acl=%value acl%&browseaclgroup=%value browseaclgroup%&readaclgroup=%value readaclgroup%&writeaclgroup=%value writeaclgroup%&effectiveAcl=%value effectiveAcl%&effectiveAclBrowse=%value effectiveAclBrowse%&effectiveAclRead=%value effectiveAclRead%&effectiveAclWrite=%value effectiveAclWrite%&parentexecuteaclgroup=%value /parentexecuteaclgroup%&parentbrowseaclgroup=%value /parentbrowseaclgroup%&parentreadaclgroup=%value /parentreadaclgroup%&parentwriteaclgroup=%value /parentwriteaclgroup%">&lt;%value effectiveAcl%&gt;</A>
           %else%
  	      <A href="acl-assign.dsp?parent=%value /interface%&interface=%value /interface%&service=%value name%&acl=%value acl%&browseaclgroup=%value browseaclgroup%&readaclgroup=%value readaclgroup%&writeaclgroup=%value writeaclgroup%&effectiveAcl=%value effectiveAcl%&effectiveAclBrowse=%value effectiveAclBrowse%&effectiveAclRead=%value effectiveAclRead%&effectiveAclWrite=%value effectiveAclWrite%&parentexecuteaclgroup=%value /parentexecuteaclgroup%&parentbrowseaclgroup=%value /parentbrowseaclgroup%&parentreadaclgroup=%value /parentreadaclgroup%&parentwriteaclgroup=%value /parentwriteaclgroup%">&lt;%value /parentexecuteaclgroup%&gt;</A>
           %endif%
           <script>
	      effectiveACL++;
	   </script>
        %endif%
        </TD>

        <script>writeTD("rowdata");</script>
          <A href="service-test.dsp?interface=%value /interface%&service=%value name%">
          <IMG src="icons/checkdot.gif" border=0>
          </A>
        </TD>

      </TR>
        <script>swapRows();</script>
      %endloop%
         %else%
          <TR>
            <TD class="evenrow-l" colspan=6>No services in this folder</TD>
          </TR>

      %endif%
      </TABLE>
    <script>
    if ((effectiveACL > 0) || (effectiveACLBrowse > 0) || (effectiveACLRead > 0) || (effectiveACLWrite > 0))
    {
      document.write("<BR>");
        document.write("<> ACL setting inherited from parent.");
    }
    </script>
      </TD></TR>

    </TABLE> %endinvoke%  %endinvoke%
  </BODY>
</HTML>
