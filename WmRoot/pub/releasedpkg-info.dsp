<HTML>
<HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


<TITLE>Integration Server -- Package Information</TITLE>
%include webMethods.css%
</HEAD>
<BODY>

<TABLE WIDTH="100%">

<SCRIPT LANGUAGE="JavaScript">

  var pub = "%value publisher%";
  var pkg = "%value pkgname%";
  function svcPull()
  {
    document.svcform.pkgname.value = pkg;
    document.svcform.publisher.value = pub;

    document.svcform.package.value = pkg;
    document.svcform.alias.value = pub;

    document.svcform.submit();
    return true;
  }

  function ftpPull()
  {
    document.ftpform.pkgname.value = pkg;
    document.ftpform.publisher.value = pub;
    document.ftpform.submit();

    return true;
  }


</SCRIPT>

  <TR><td class="title" colspan=5>'%value pkgname%' Package Information</td></TR>


  %invoke wm.server.replicator.adminui:queryPublisherForPackageInfo%
  <TR>
    <TD class="rowlabel" width="25%">Package Name</TD>
    <TD class="rowdata">%value name%</TD>
  </TR>

  <TR>
    <TD class="rowlabel" width="25%">Version</TD>
    <TD class="rowdata">%value version%</TD>
  </TR>

  <TR>
    <TD class="rowlabel" width="25%">Build Number</TD>
    <TD class="rowdata">%value build%</TD>
  </TR>

  <TR>
    <TD class="rowlabel" width="25%">Patch Numbers</TD>
    <TD class="rowdata">%value patch_nums%</TD>
  </TR>

  <TR>
    <TD class="rowlabel" width="25%">Brief Description</TD>
    <TD class="rowdata">%value description%</TD>
  </TR>

  <TR>
    <TD class="rowlabel" width="25%">Time Created</TD>
    <TD class="rowdata">%value time%</TD>
  </TR>

  <TR>
    <TD class="rowlabel" width="25%">JVM Version</TD>
    <TD class="rowdata">%value jvm_version%</TD>
  </TR>

  <TR>
    <TD class="rowlabel" width="25%">Publisher Server Version</TD>
    <TD class="rowdata">%value source_server_version%</TD>
  </TR>
  %endinvoke%

</TABLE>

<p>



<TABLE WIDTH=100%>
<TR>

    <TD class="rowlabel" width=25%>Retrieve Package</TD>
    <TD class="rowdata">
      <TABLE>
        <TR>
        <FORM NAME="svcform" action="package-query.dsp" method="POST">
          <INPUT type="hidden" name="action" value="svcPull">
          <INPUT type="hidden" name="pkgname" value="">
          <INPUT type="hidden" name="service" value="">
          <INPUT type="hidden" name="publisher" value="">
          <INPUT type="hidden" name="package" value="">
          <INPUT type="hidden" name="alias" value="">
          <TD>
            <INPUT type="button" value="Service Invoke Retrieve" onClick="svcPull();">
          </TD>
        </FORM>
        </TR>

        <TR>
        <FORM NAME="ftpform" action="package-query.dsp" method="POST">
          <INPUT type="hidden" name="action" value="ftpPull">
          <INPUT type="hidden" name="pkgname" value="">
          <INPUT type="hidden" name="service" value="">
          <INPUT type="hidden" name="publisher" value="">

          %invoke wm.server.replicator:getPublisherInfo%
          <TD>
          <TABLE>
          <TR>
            <TD class="rowlabel" width="25%">Server Host</TD>
            <TD class="rowdata">%value host%</TD>
          </TR>

          <TR>
            <TD class="rowlabel" width="25%">Server Port</TD>
            <TD class="rowdata">
              <INPUT NAME="port"></INPUT>
            </TD>
          </TR>

          <TR>
            <TD class="rowlabel" width="25%">User Name</TD>
            <TD class="rowdata">
              <INPUT NAME="user"></INPUT>
            </TD>
          </TR>

          <TR>
            <TD class="rowlabel" width="25%">Password</TD>
            <TD class="rowdata">
              <INPUT NAME="pass" TYPE="password" autocomplete="off"></INPUT>
            </TD>
          </TR>
          </TABLE>
          </TD>
          %endinvoke%
          <TD>
            <INPUT type="button" value="FTP Retrieve" onClick="ftpPull();">
          </TD>
        </FORM>
        </TR>
      </TABLE>
    </TD>
    </TD>
</TR>
</TABLE>
</DIV>

</BODY>
</HTML>
