
<html>
%invoke wm.server.security.certificate:getDetailedInfo%

<head>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt"></SCRIPT>

<script language="JavaScript">

    var mode = "%value operation%";
    var user = "%value user empty=Default%";

    function doSave()
    {
        document.info.action="security-certs.dsp";
        document.info.operation.value="update";
        document.info.oldUsage.value='%value oldUsage%';
        document.info.submit();
        return;
    }

	function startup(nextPage, helpPage)
	{
		document.info.oldUsage.value='%value usage%';
		setNavigation(nextPage, helpPage);
	}

	%comment%
		function setupData() removed as part of LDAP enhancements.
	%end%

</script>
</head>
%ifvar operation equals('edit')%
   <BODY onLoad="startup('security-certificates.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_ClientCertifUserMappingScrn');">
%else%
   <BODY onLoad="startup('security-certificates.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_ClientCertifDetailsScrn');">
%endif%

<TABLE width="100%">
      <TR>
          <TD class="menusection-Security" colspan=2>
      Security &gt;
      Certificates &gt;
      Client Certificates &gt;
            Details
            %ifvar equals('edit') operation%
             &gt; Mapping
            %end if%
          </TD>
        </TR>
        <TR>
          <TD colspan=2>
            <UL>
				%ifvar operation equals('getDetailed')%
				<LI><A HREF="security-certs.dsp">Return to Client Certificates</A></LI>
				<LI><A HREF="cert-detailed.dsp?action=cert-detailed.dsp&issuer=%value -urlencode issuer%&serialNum=%value -urlencode serialNum%&oldUsage=%value -urlencode usage%&usage=%value -urlencode usage%&operation=edit">Change Mapping</A></LI>
				%end if%
				%ifvar operation equals('edit')%
				<LI><A HREF="cert-detailed.dsp?action=cert-detailed.dsp&issuer=%value  -urlencode issuer%&serialNum=%value -urlencode serialNum%&oldUsage=%value -urlencode usage%&usage=%value -urlencode usage%&operation=getDetailed">Return to Details</A>
				</LI>
				%end if%
            </UL>
          </TD>
        </TR>
		<TR>
          <TD></TD>
          <TD>
			<table class="tableView" width="30%">
				<form name="info" method="post">
				<input type="hidden" name="issuer" value="%value issuer%">
				<input type="hidden" name="serialNum" value="%value serialNum%">
				<input type="hidden" name="operation" value="%value operation%">
				<input type="hidden" name="oldUsage" value="%value oldUsage%">

			<tr>
				<td class="heading" colspan="2">Mapping Information</td>
			</tr>

			<!--  RUN AS USER SUB CHANGES-->
			<SCRIPT>
				  function callback(val){
						document.info.user.value=val;
				  }
			</SCRIPT>

			<tr>
				<td class="evenrow-l">User</td>
				%ifvar operation equals('edit')%
				<td class="evenrowdata-l" style="border-left: none;">
					<!--  RUN AS USER SUB CHANGES START-->
					<input name="user" size=12 value="%value user%"></input>
					<link rel="stylesheet" type="text/css" href="subUserLookup.css" />
					<script type="text/javascript" src="subUserLookup.js"></script>
					<a class="submodal" href="subUserLookup.dsp"><img border=0 align="bottom" src="icons/magnifyglass.gif"/></a>
					<!--  RUN AS USER SUB END-->
				</td>
				%else%
				<td class="evenrowdata-l">%value user%</td>
				%endif%
			</tr>

			<TR>
				<TD class="oddrow-l">Usage</TD>
				%ifvar operation equals('edit')%
				<TD class="oddrowdata-l">
					<SELECT NAME="usage" WIDTH=150>
						<OPTION VALUE="SSL Authentication" %ifvar usage equals('SSL Authentication')% SELECTED %endif%>
							SSL Authentication </OPTION>
						<OPTION VALUE="Verify" %ifvar usage equals('Verify')% SELECTED %endif%>
							Verify </OPTION>
						<OPTION VALUE="Encrypt" %ifvar usage equals('Encrypt')% SELECTED %endif%>
							Encrypt </OPTION>
						<OPTION VALUE="Verify and Encrypt" %ifvar usage equals('Verify and Encrypt')% SELECTED %endif%>
							Verify and Encrypt </OPTION>
						<OPTION VALUE="Message Authentication" %ifvar usage equals('Message Authentication')% SELECTED %endif%>
							Message Authentication </OPTION>
					</SELECT>
				</TD>
				%else%
				%switch usage%
					%case 'SSL Authentication'%<TD class="oddrowdata-l">SSL Authentication</TD>
					%case 'Verify'%<TD class="oddrowdata-l">Verify</TD>
					%case 'Encrypt'%<TD class="oddrowdata-l">Encrypt</TD>
					%case 'Verify and Encrypt'%<TD class="oddrowdata-l">Verify and Encrypt</TD>
					%case 'Message Authentication'%<TD class="oddrowdata-l">Message Authentication</TD>
				%endswitch%
				%endif%
			</TR>
			<tr>
				<td class="heading" colspan="2">Detailed Certificate Information</td>
			</tr>
		%scope info%
			<tr>
				<td class="evenrow">Version</td>
				<td class="evenrowdata-l">%value version%</td>
			</tr>
			<tr>
				<td class="oddrow">Serial Number</td>
				<td class="oddrowdata-l">%value serialNumber%</td>
			</tr>
			<tr>
				<td class="evenrow">Issuer</td>
				<td class="evenrowdata-l" style="padding: 0px;">
					<table class="tableInline" cellspacing="1px" width="100%">
						%loop -struct issuer%
						<tr>
							<td>%value $key%</td>
							<td class="evenrowdata-l">%value%</td>
						</tr>
						%endloop%
					</table>
				</td>
			</tr>
			<tr>
				<td class="oddrow">Valid Not Before</td>
				<td class="oddrowdata-l">%value validity/notBefore%</td>
			</tr>
			<tr>
				<td class="evenrow">Valid Not After</td>
				<td class="evenrowdata-l">%value validity/notAfter%</td>
			</tr>
			<tr>
				<td class="oddrow">Public Key Algorithm</td>
				<td class="oddrowdata-l">%value subjectPublicKeyAlgorithm%</td>
			</tr>

			<tr>
				<td class="evenrow">Subject</td>
				<td class="evenrowdata-l" style="padding: 0px;">
					<table class="tableInline" cellspacing="1px" width="100%">
						%loop -struct subject%
						<tr>
							<td>%value $key%</td>
							<td class="evenrowdata-l">%value%</td>
						</tr>
						%endloop%
					</table>
				</td>
			</tr>
		%endscope%
					%ifvar operation equals('edit')%
			<tr>
				<td class="action" colspan=2>
					<input type=button onClick="doSave();" value="Save Changes">
				</td>
			</tr>
					%endif%
		</form>
		</table>

</td>
</tr>
</table>

</body>
%endinvoke%
</html>
