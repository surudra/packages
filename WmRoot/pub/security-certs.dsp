
<HTML>
  <HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">

    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
    <script Language="JavaScript">

    function getDetailed(issuer, serialNum, usage)
    {
      document.certificates.action="cert-detailed.dsp";
      document.certificates.operation.value="getDetailed";
      document.certificates.issuer.value=issuer;
      document.certificates.serialNum.value=serialNum;
      document.certificates.usage.value=usage;
      return true;
    }
    
	function deleteMap(issuer, serialNum, usage, issuerCN, user)
    {
      if (confirm("OK to remove entry from "+issuerCN+" to "+user+"?"))
      {
        document.certificates.operation.value="delete";
        document.certificates.issuer.value=issuer;
        document.certificates.serialNum.value=serialNum;
        document.certificates.usage.value=usage;
        return true;
      }
      return false;
    }
    
    function doImport()
    {
	
	var filePath = document.certificates.certFilePath.value;
	if (document.certificates.certFilePath.value=="")
        {
		alert("A file path must be provided");
		return false;
	}
        document.certificates.operation.value = "import";
	document.certificates.certificatePath.value = filePath;
	return true;
    }
	
    </script>
  </HEAD>
  <BODY onLoad="setNavigation('security-certificates.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_ConfigClientCertifScrn');">
    <FORM name="certificates" method="post" onSubmit=" return doImport();" >
      <INPUT type="hidden" name="operation" value="%value operation%">
      <INPUT type="hidden" name="issuer">
      <INPUT type="hidden" name="serialNum">
      <INPUT type="hidden" name="usage">
      <INPUT type="hidden" name="certificatePath">
      <TABLE width="100%">
        <TR>
          <TD class="menusection-Security" colspan="2">
            Security &gt;
            Certificates &gt;
            Configure Client Certificates
          </TD>
        </TR>

%invoke wm.server.security.certificate:admin%

%invoke wm.server.security.certificate:listMappings%

%ifvar ../message%
	 <tr><td colspan="2">&nbsp;</td></tr>
	<TR><TD class="message" colspan=2>%value ../message%</TD></TR>
%else%
	%ifvar message%
		<tr><td colspan="2">&nbsp;</td></tr>
		<TR><TD class="message" colspan=2>%value message%</TD></TR>
	%endif%
%endif%

        <TR>
          <TD colspan="2">
            <UL>
              <LI><A HREF="security-certificates.dsp">Return to Certificates</A></LI>
            </UL>
          </TD>
        </TR>
        <TR>
          <TD></TD>
          <TD>
            <TABLE class="tableForm" width=100%>
              <TR>
                <TD class="heading" colspan="3">Import Certificate</TD>
              </TR>
              <TR>
                <TD class="oddrow">Certificate Path</TD>
                <TD class="oddrowdata-l">
                  <INPUT type="text" name="certFilePath" style="width:100%">
                </td>
              </TR>
              <TR> 
			<TD class="evenrow">Example Paths</td> 
				<TD class="evenrow-l">
					<div id="unixCommentDiv" style="display:none">
					C:/folder/file.der<BR>
					//server/folder/file.der<BR> 
					folder/file.der (relative to install directory)
					</div>
					<div id="windowsCommentDiv" style="display:none">
					C:\folder\file.der<BR>
					\\server\folder\file.der<BR> 
					folder\file.der (relative to install directory)
					</div>

				<script language="javascript">
					var OSName="Unknown OS";
					if (navigator.appVersion.indexOf("Win")!=-1) OSName="Windows";
					if (navigator.appVersion.indexOf("Mac")!=-1) OSName="MacOS";
					if (navigator.appVersion.indexOf("X11")!=-1) OSName="UNIX";
					if (navigator.appVersion.indexOf("Linux")!=-1) OSName="Linux";
					
					if(OSName == "Windows") {
						document.getElementById('windowsCommentDiv').style.display = "block";
					}
					else {
						document.getElementById('unixCommentDiv').style.display = "block";
					}
					
				</script>
		                </TD>
              </TR>
              <TR>
				<!--  RUN AS USER SUB CHANGES-->
				<SCRIPT>
					  function callback(val){      	    
							document.certificates.certificateUser.value=val;
					  }
				</SCRIPT>				  
                <TD class="oddrow">User</TD>
                <TD class="oddrowdata-l">
				<!--
					%invoke wm.server.access:userList%
					<select name="certificateUser" style="width:50%">
					%loop users%
						<option value="%value name%" %ifvar name vequals(../user)% SELECTED %endif%>%value name%</option>
					%endloop%
					</select>
					%endinvoke%				  
				-->
				<!--  RUN AS USER SUB CHANGES START-->
				<input name="certificateUser" size=12 value="%value name%"></input>
				<link rel="stylesheet" type="text/css" href="subUserLookup.css" />
				<script type="text/javascript" src="subUserLookup.js"></script>
				<a class="submodal" href="subUserLookup.dsp"><img border=0 align="bottom" src="icons/magnifyglass.gif"/></a> 
				<!--  RUN AS USER SUB END-->				
                </td>
              </TR>
              <TR>
                <TD class="evenrow">Usage</TD>
                <TD class="evenrowdata-l">
					<SELECT NAME="certificateUsage" style="width:50%"> 
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
                </td>
              </TR>
              <TR>
                <TD class="action"  colspan=2>
                  <INPUT type="submit" value="Import Certificate">
                </TD>
              </TR>
            </TABLE>
            <BR>
            <TABLE class="tableView" width=100%>
              <TR>
                <TD class="heading" colspan="6">Current Certificates</TD>
              </TR>
                <TR>
                  <TD class="oddcol-l">Subject CN</TD>
                  <TD class="oddcol">Issuer CN</TD>
                  <TD class="oddcol">Serial Number</TD>
                  <TD class="oddcol">User</TD>
                  <TD class="oddcol">Usage</TD>
                  <TD class="oddcol">Remove</TD>
                </TR>
     
                <script>resetRows();</script>
                %ifvar mappings%
                %loop mappings%
                <TR>
                  <script>writeTD("rowdata-l");</script>
                    <A href="javascript:document.certificates.submit();"
                       onClick="return getDetailed('%value -code certificateInfo/issuer%','%value -code certificateInfo/serialNum%','%value usage%')"
                        >
                       %ifvar certificateInfo/subjectCN -notempty% 
                          %value certificateInfo/subjectCN%
                       %else%
                          (None)
                       %endifvar%
                    </A></TD>
                  <script>writeTD("rowdata");</script>
                    %value certificateInfo/issuerCN%</TD>
                  <script>writeTD("rowdata");</script>
                    %value certificateInfo/serialNum%</TD>
                  %ifvar user -isnull%<TD BGCOLOR="#758EBD"> 
				                %else%<script>writeTD("rowdata");</script>%end%
                    %value user%</TD>
                  <script>writeTD("rowdata");</script>
                    %switch usage%
                      %case 'SSL Authentication'%SSL Authentication</TD>
                      %case 'Verify'%Verify</TD>
                      %case 'Encrypt'%Encrypt</TD>
                      %case 'Verify and Encrypt'%Verify and Encrypt</TD>
                      %case 'Message Authentication'%Message Authentication</TD>
                    %endswitch%
                  <script>writeTD("rowdata");</script>
                    <A class="imagelink" href="javascript:document.certificates.submit();"
                       onClick="return deleteMap('%value -code certificateInfo/issuer%','%value -code certificateInfo/serialNum%','%value usage%','%value -code certificateInfo/subjectCN%','%value user%')"
                       ><IMG class="position" border="0" src="icons/delete.gif"></A>
                  </TR>
<script>swapRows();</script>
                %endloop%
                %else%
                  <TR>
                    <TD class="evenrow-l" colspan=6>No Certificates have been imported</TD>
                  </TR>
                %endif%
                </TABLE>
            
              </TD>
            </TR>
%endinvoke%
%endinvoke%
          </TABLE>
        </FORM>
      </BODY>
    </HTML>
