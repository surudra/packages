<HTML>
<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<HEAD>
<TITLE>B2B Integration Server -- Users</TITLE>
%include ../../WmRoot/pub/b2bStyle.css%
%include oa-utils.dsp%
</HEAD>
<BODY>
<table width="100%">
   <tr>
      <td class="menusection-Adapters" colspan=8>Adapters &gt; OracleApps Adapter&gt; Transaction Mgmt</td>
    </tr>
</table>

<TABLE width="100%">
<TR>
<TD>
  <TR><TH class="title" colspan=4>Oracle Applications Transaction Import Results</TH></TR>

  <FORM method="POST" name="importexec" action="oa-transImportExec.dsp">

%ifvar runImport equals(true)%
    <TR class="subheading">
        <TH>Import<BR>Status</TH>
        <TH>Transaction<BR>Name</TH>
        <TH>Import<BR>As</TH>
        <TH>Message</TH>
    </TR>
%invoke wm.adapter.wmoa.exchange:importTrans%
    %loop importStatus%
    <TR>
        <TD class="coldata">
            %ifvar success equals('false')%
            <IMG class="alone" SRC="/WmRoot/icons/red-ball.gif" border="no" alt="Failed"></A>
            %else%
            <IMG class="alone" SRC="/WmRoot/icons/green-ball.gif" border="no" alt="Imported"></A>
            %endif%
        </TD>
        <TD class="coldata">%value fileTranName%</TD>
        <TD class="coldata">%value importTranName%</TD>
        <TD class="coltext">%value message%</TD>
    </TR>
    %endloop%
%onerror%
<SCRIPT LANGUAGE="JavaScript">
  %ifvar localizedMessage%
    alert("Error encountered importing transactions <%value error%> %value localizedMessage%");
  %else%
    %ifvar error%
      alert("Error encountered importing transactions <%value error%> %value errorMessage%");
    %else%
      alert("Error encountered importing transactions.");
    %endif%
  %endif%
</SCRIPT>
%endinvoke%

%endif%

%comment%
%scope param(additional='all')%
<!-- *********************** PIPELINE DEBUGGING INFORMATION  ***************************** -->

<P><h2>Pipeline contents</h2>
<P>
<table border=1>
%loop -struct%

    <tr>
       <td><b>%value $key%</b></td>
       <td>%value%</td>
    </tr>
%endloop%
</table>

<!-- ************************************************************************************* -->
%endscope%
%endcomment%

</FORM>



</TABLE>
</TD></TR></TABLE>
</BODY>

</HTML>

