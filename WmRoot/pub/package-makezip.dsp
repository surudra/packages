<HTML>

<HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


<TITLE>Integration Server -- Make a zip file</TITLE>
%include webMethods.css%
<SCRIPT LANGUAGE="JavaScript">

  function makeZip() {
    document.zipform.submit();
  }

  function doCancel() {
    history.go (-1);
    return true;
  }

</SCRIPT>
</HEAD>

<BODY>

<FORM name="zipform" action="package-publish.dsp" method="POST">
<INPUT type="hidden" name="action" value="zip">
<INPUT type="hidden" name="package" value="%value package%">

<TABLE width=100%>

  <TR><td class="title" colspan=2>Make Zip File for '%value package%' Package</td></TR>

  <TR><TD width=55%>
    <TABLE width=100%>
      <TR><td class="heading">Select Files From '%value package%' Package Directory</td></TR>
      <TR><TD class="data" width=55%>
        %invoke wm.server.replicator:packageFileList%
        <SELECT name="file" size=16 width=310 multiple>
          %loop files%
          <OPTION value="%value%">%value%</OPTION>
          %endloop%
        </SELECT>
        %endinvoke%
        </TD>
        </TR>
    </TABLE>
    </TD>

    <TD valign=top>
    <TABLE width=100%>
      <TR><TD>&nbsp;</TD></TR>
      <TR><TD>
        <INPUT type="radio" name="filter" value="includeall" checked>Include all files</INPUT><BR>
        <INPUT type="radio" name="filter" value="include">Include selected files</INPUT><BR>
        <INPUT type="radio" name="filter" value="exclude">Exclude selected files</INPUT><BR>
        </TD></TR>
        <TR><TD><BR><BR><BR></TD></TR>
        <TR><TD>
          <INPUT type="button" onclick="return makeZip();" width=100 value="Make zip file"><BR>
          <INPUT type="button" onclick="doCancel();" width=100 value="Cancel">
        </TD></TR>
    </TABLE>
    </TD>
  </TR>

</TABLE>
</FORM>

</BODY>
</HTML>
