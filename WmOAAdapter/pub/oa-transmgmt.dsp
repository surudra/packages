<HTML>
<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>

<HEAD>
<TITLE>B2B Integration Server -- Users</TITLE>
%include ../../WmRoot/pub/b2bStyle.css%

<SCRIPT LANGUAGE="JavaScript">
  function callImport()
  {
    document.location='oa-transImport.dsp?importtorel=none';
    return true;
  }

</SCRIPT>
</HEAD>
<INPUT TYPE="HIDDEN" name="helpsys" value="/WmOAAdapter/doc/OnlineHelp/wwhelp.htm?context=Help&topic=OA_TransMgmt">
<BODY>
<table width="100%">
   <tr>
      <td class="menusection-Adapters" colspan=8>Adapters &gt; OracleApps Adapter&gt; Transaction Mgmt</td>
    </tr>
</table>
<TABLE width="100%"><TR><TD>

<FORM method="POST" name="transactionform" action="oa-transmgmt.dsp">

<TR><TH class="title" colspan=8>Transaction Management</TH></TR>

<TR>
<TD class="action" colspan=8><CENTER>
  <INPUT class="data" type="button" value="Transaction Configuration" 
    onclick="document.location='oa-transconfig.dsp';"></INPUT>
  <INPUT class="data" type="button" value="Transaction Import" 
    onclick="callImport();"></INPUT>
  <INPUT class="data" type="button" value="Transaction Export" 
    onclick="document.location='oa-transExport.dsp';"></INPUT>
</CENTER>
</TD>
</TR>
</FORM>
</TABLE>
</BODY>
</HTML>
