<HTML>
<HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


<TITLE>Integration Server Packages</TITLE>
%include webMethods.css%
<SCRIPT LANGUAGE="JavaScript">

  function confirmReload (pkg,pkgType) {

    var s = "OK to reload the `"+pkg+"' package?\n\nReloading a package may cause sessions currently using\nservices in that package to fail.\n";

    var doReload;
    doReload = confirm (s);

    if(doReload)
    {
      var sNativeWarning = "Warning: This package contains native code\nlibraries.  You must restart the server\nto reload Java services.\n";
      if(pkgType == "2")
        alert(sNativeWarning);
    }

    return doReload;
  }

  function confirmDisable (pkg) {
    var s = "OK to disable the `"+pkg+"' package?\n\nDisabling a package causes all its services to be \nunloaded and marked unavailable for use.\n";
    return confirm (s);
  }

  function confirmEnable (pkg) {
    var s = "OK to enable the `"+pkg+"' package?\n\nEnabling a package causes all its services to be \nloaded and marked available for use.\n";
    return confirm (s);
  }

</SCRIPT>
</HEAD>
<BODY>

<div class="position">
<TABLE WIDTH="100%">

  <TR><td class="title" colspan=5>Packages</td></TR>

%ifvar action%
%switch action%
%case 'enable'%
  %invoke wm.server.packages:packageEnable%
  <TR><td id="message" colspan=5>%value encode(htmlall) message%</td></TR>
  %endinvoke%
%case 'disable'%
  %invoke wm.server.packages:packageDisable%
  <TR><td id="message" colspan=5>%value encode(htmlall) message%</td></TR>
  %endinvoke%
%case 'reload'%
  %invoke wm.server.packages.adminui:packageReload%
  <TR><td id="message" colspan=5>%value encode(htmlall) message%</td></TR>
  %endinvoke%
%endswitch%
%endif action%

%invoke wm.server.packages:packageList%

  <TR class="heading">
    <td width=60%>Package Name</td>
    <td width=10%>Loaded</td>
    <td width=10%>Enabled</td>
  </TR>

  %loop packages%
  <TR>
  <TD class="coltext">
      &nbsp;<A HREF="package-info.dsp?package=%value name%">%value name%</A>
  </TD>
  <TD class="coldata">
      <A HREF="package-info.dsp?package=%value name%">
      %ifvar loaderr equals('0')%
        %ifvar enabled equals('false')%
        <IMG class="alone" SRC="icons/red-ball.gif" border="no" alt="[Disabled]"></A>
        %else%
        <IMG class="alone" SRC="icons/green-ball.gif" border="no" alt="[Loaded]"></A>
        %endif%
      %else%
      %ifvar loadok equals('0')%
      <IMG class="alone" SRC="icons/red-ball.gif" border="no" alt="[Load Errors]"></A>
      %else%
      <IMG class="alone" SRC="icons/yellow-ball.gif" border="no" alt="[Load Errors]"></A>
      %endif%
      %endif%
      </TD>
    <TD class="coldata">
      %ifvar enabled equals('true')%
        <A HREF="package-list.dsp?action=disable&package=%value name%"
          ONCLICK="return confirmDisable('%value name%');">
        <IMG class="alone" SRC="icons/green-ball.gif" border="no" alt="[Disable]"></A>
      %else%
        <A HREF="package-list.dsp?action=enable&package=%value name%"
          ONCLICK="return confirmEnable('%value name%');">
        <IMG class="alone" SRC="icons/red-ball.gif" border="no" alt="[Enable]"></A>
      %endif%
      </TD>
    </TR>
  </TR>
  %invoke wm.server.packages:drawDependencyGraph%
  %ifvar outdepends%
  <TR><TD>%value outdepends%</TD></TR>

  %else%
  <TR><TD>ERROR</TD></TR>
  %endif%
  %endinvoke%

%endloop%

</TABLE>

%endinvoke%

</div></BODY>

</HTML>

