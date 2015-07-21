
<HTML>
  <HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">

    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt">
    </SCRIPT>
    <SCRIPT LANGUAGE="JavaScript">
    var currentAcl =  %ifvar acl -notempty% "%value acl%"; 
		      %else% 
			%ifvar effectiveAcl -notempty% "<%value effectiveAcl%> (inherited)"; 
			%else% 
			"<%value parentexecuteaclgroup%> (inherited)";
			%endif%
		      %endif%

    var currentBrowseAcl =  %ifvar browseaclgroup -notempty%  "%value browseaclgroup%"; 
		%else%  
			%ifvar effectiveAclBrowse -notempty% "<%value effectiveAclBrowse%> (inherited)"; 
			%else% 
			"<%value parentbrowseaclgroup%> (inherited)";
			%endif%
		%endif%

    var currentReadAcl =  %ifvar readaclgroup -notempty%  "%value readaclgroup%"; 
		%else%  
			%ifvar effectiveAclRead -notempty%"<%value effectiveAclRead%> (inherited)"; 
			%else% 
			"<%value parentreadaclgroup%> (inherited)";
			%endif%
		%endif%

    var currentWriteAcl =  %ifvar writeaclgroup -notempty%  "%value writeaclgroup%"; 
		%else%  
			%ifvar effectiveAclWrite -notempty%"<%value effectiveAclWrite%> (inherited)"; 
			%else% 
			"<%value parentwriteaclgroup%> (inherited)";
			%endif%
		%endif%
    
	
    function onClick (action)
    {
      if (action == "reset")
      {
        document.forms["aclForm"].reset();
      }
      else if (action == "submit")
      {
        document.forms["aclForm"].submit();
      }
      else
      {
        document.forms["aclForm"].action.value = "xxx";
        document.forms["aclForm"].submit();
      }
    }
    function updateSelector ()
    {
      var sel = document.forms["aclForm"].acl;
      for (var i=0; i<sel.options.length; i++)
      {
        if (sel.options[i].value == currentAcl) sel.selectedIndex = i;
      }
      var selbrowse = document.forms["aclForm"].browseaclgroup;
      for (var i=0; i<selbrowse.options.length; i++)
      {
        if (selbrowse.options[i].value == currentBrowseAcl) selbrowse.selectedIndex = i;
      }
      var selread = document.forms["aclForm"].readaclgroup;
      for (var i=0; i<selread.options.length; i++)
      {
        if (selread.options[i].value == currentReadAcl) selread.selectedIndex = i;
      }
      var selwrite = document.forms["aclForm"].writeaclgroup;
      for (var i=0; i<selwrite.options.length; i++)
      {
        if (selwrite.options[i].value == currentWriteAcl) selwrite.selectedIndex = i;
      }
    }
    </SCRIPT>
  </HEAD>
  <BODY onLoad="setNavigation('package-list.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_SetACLsScrn');updateSelector();">
   <FORM name="aclForm" action="service-list.dsp" METHOD="POST">
      <INPUT type="hidden" name="action" value="aclassign">
      <INPUT type="hidden" name="interface" value="%value parent%">
      %ifvar service%
      <INPUT type="hidden" name="target" value="%value interface%:%value service%">
      %else%
      <INPUT type="hidden" name="target" value="%value interface%">
      %endif%
     <TABLE width=100%>

        <TR>
          <TD class="menusection-Packages" colspan=2>
            Packages &gt;
            Management &gt;
      %value interface% &gt;
            Set ACLs
          </TD>
        </TR>
         <TR>
          <TD colspan=2>
            <UL>
              <!-- <LI><A HREF="service-list.dsp?interface=%value interface%">Return to browsing %value interface%</A></LI> -->
              %ifvar parent -notempty%
              	<LI><A HREF="service-list.dsp?interface=%value parent%">Return to browsing %value parent%</A></LI>
              %else%
                <LI><A HREF="service-list.dsp?interface=%value interface%">Return to browsing %value interface%</A></LI>
              %endif%
            </UL>
          </TD>
        </TR>

    <TR>
          <TD><IMG SRC="images/blank.gif" height=10 width=10 border=0></TD>
          <TD>
            <TABLE class="tableForm">
              <TR>
                <TD class="heading" colspan=2>ACL Information</TD>
              </TR>
              <TR>
                <TD class="oddrow">Target</TD>
                <TD class="oddrow-l"><b>
                  %ifvar service%
                    %value interface%:%value service%
                  %else%
                    %value interface%
                  %endif%</b>
                </TD>
              </TR>

              <TR>
                <TD class="evenrow">List ACL</TD>
                <TD class="evenrow-l">
                  %invoke wm.server.access.adminui:aclList%
                  <SELECT name="browseaclgroup">
                    %ifvar effectiveAclBrowse -notempty%<OPTION value="">&lt;%value effectiveAclBrowse%&gt; (inherited)</OPTION>
                    %else%<OPTION value="">&lt;%value parentbrowseaclgroup%&gt; (inherited)</OPTION>%endif%
                    %loop aclgroups%
                    <OPTION value="%value name%">%value name%</OPTION>
                    %endloop%
                  </SELECT>
                  %endinvoke%
                </TD>
              </TR>

              <TR>
                <TD class="oddrow">Read ACL</TD>
                <TD class="oddrow-l">
                  %invoke wm.server.access.adminui:aclList%
                  <SELECT name="readaclgroup">
                    %ifvar effectiveAclRead -notempty%<OPTION value="">&lt;%value effectiveAclRead%&gt; (inherited)</OPTION>
                    %else% <OPTION value="">&lt;%value parentreadaclgroup%&gt; (inherited)</OPTION>%endif%
                    %loop aclgroups%
                    <OPTION value="%value name%">%value name%</OPTION>
                    %endloop%
                  </SELECT>
                  %endinvoke%
                </TD>
              </TR>

              <TR>
                <TD class="evenrow">Write ACL</TD>
                <TD class="evenrow-l">
                  %invoke wm.server.access.adminui:aclList%
                  <SELECT name="writeaclgroup">
                    %ifvar effectiveAclWrite -notempty%<OPTION value="">&lt;%value effectiveAclWrite%&gt; (inherited)</OPTION>
                    %else%<OPTION value="">&lt;%value parentwriteaclgroup%&gt; (inherited)</OPTION>%endif%
                    %loop aclgroups%
                    <OPTION value="%value name%">%value name%</OPTION>
                    %endloop%
                  </SELECT>
                  %endinvoke%
                </TD>
              </TR>

              <TR>
                <TD class="oddrow">Execute ACL</TD>
                <TD class="oddrow-l">
                  %invoke wm.server.access.adminui:aclList%
                  <SELECT name="acl">
                    %ifvar effectiveAcl -notempty%<OPTION value="">&lt;%value effectiveAcl%&gt; (inherited)</OPTION>
                    %else%<OPTION value="">&lt;%value parentexecuteaclgroup%&gt; (inherited)</OPTION>%endif%
                    %loop aclgroups%
                    <OPTION value="%value name%">%value name%</OPTION>
                    %endloop%
                  </SELECT>
                  %endinvoke%
                </TD>
              </TR>

              %ifvar service%
              <TR>
                %invoke wm.server.services.adminui:serviceInfo%
                <TD class="evenrow">Enforce ACL on Internal Invokes</TD>
                <TD class="evenrow-l">
                        <INPUT type="radio" name="check_internal_acls" value="true"
                        %ifvar check_internal_acls equals('true')% checked %endif% >&nbsp;
                        On
                        </INPUT>
                        <INPUT type="radio" name="check_internal_acls" value="false"
                        %ifvar check_internal_acls equals('false')% checked %endif% >&nbsp;Off (recommended)
                        </INPUT> </TD>
                %endinvoke%
              %endif%
              </TR>
              <TR>
                <TD colspan=2 class="action">
                  <INPUT type="button" value="Save Changes"
                  onclick="onClick('submit')  ;">
              </TR>
            </TABLE>
          </TD>
        </TR>
      </TABLE>
    </FORM>
  </BODY>
</HTML>
