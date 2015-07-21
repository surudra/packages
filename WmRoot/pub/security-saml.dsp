<HTML>
<HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
<SCRIPT SRC="webMethods.js.txt"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
  function confirmDelete (IssuerName) {
    var msg = "OK to delete saml issuer '"+IssuerName+"' from configuration?";
    if (confirm (msg)) {
        document.deleteform.IssuerName.value = IssuerName;
            document.deleteform.submit();
          return false;
    } else return false;
  }


</SCRIPT>
</HEAD>
<BODY onLoad="setNavigation('security-saml.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_SAMLScrn');">
<TABLE width="100%">
<TR>
    <TD class="menusection-Security" colspan="2">
    Security &gt;
    SAML </TD>
</TR>


%ifvar action%
%switch action%
%case 'add'%
  %invoke wm.server.saml:addIssuer%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message%</TD></TR>
        %endif%
  %endif%
%case 'edit'%
  %invoke wm.server.saml:addIssuer%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message%</TD></TR>
        %endif%
  %endif%
%case 'delete'%
  %invoke wm.server.saml:deleteIssuer%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message%</TD></TR>
        %endif%
  %endif%
%endswitch%
%endif%


<TR>
    <TD colspan="2">
        <UL>
            <LI><A HREF="security-saml-addedit.dsp">Add SAML Token Issuer</A></LI>
        </UL>
    </TD>
</TR>
<TR>
    <TD></TD>
    <TD>
    <TABLE class="tableView" width=100%>

    <TR>
        <TD class="heading" colspan=10>Trusted SAML Token Issuers List</TD>
    </TR>
%invoke wm.server.saml:listIssuers%
<TR>
   <TD class="oddcol-l">Issuer Name</TD>
   <TD class="oddcol">Truststore Alias</TD>
   <TD class="oddcol">Certificate Alias</TD>
   <TD class="oddcol">Clock Skew</TD>
   <TD class="oddcol">Delete</TD>
</TR>

%loop -struct issuers%
%scope #$key%
<TR>
    <script>writeTD("rowdata-l");</script>
        <a
	   href="security-saml-addedit.dsp?action=edit&IssuerName=%value -urlencode IssuerName%&TruststoreAlias=%value -urlencode TruststoreAlias%&CertAlias=%value -urlencode CertAlias%&ClockSkew=%value -urlencode ClockSkew%"
        >%value IssuerName%</a>
    </TD>
    <script>writeTD("rowdata");</script>%value TruststoreAlias%</TD>
    <script>writeTD("rowdata");</script>%value CertAlias%</TD>
    <script>writeTD("rowdata");</script>%value ClockSkew%</TD>
    <script>writeTD("rowdata");</script>
     %ifvar nodelete%
      &nbsp;
     %else%
  <a class="imagelink" href="" onClick="return confirmDelete('%value IssuerName%');">
      <img src="icons/delete.gif" border="none"></a>
     %endif%</TD>

</TR>

    <script>swapRows();</script>
%endscope%
%endloop%
%endinvoke%
</TABLE>
</TD>
</TR>
</TABLE>

<FORM name="deleteform" action="security-saml.dsp" method="POST">
  <INPUT type="hidden" name="action" value="delete">
  <INPUT type="hidden" name="IssuerName">
</FORM>

</BODY>
</HTML>
