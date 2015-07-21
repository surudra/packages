<HTML>
<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<HEAD>
%include ../../WmRoot/pub/b2bStyle.css%

<TITLE>B2B Integration Server -- Users</TITLE>
</HEAD>

<BODY>
<table width="100%">
   <tr>
      <td class="menusection-Adapters" colspan=8>Adapters &gt; OracleApps Adapter&gt; Transaction Mgmt</td>
    </tr>
</table>

<TABLE width="100%"><TR><TD>
<TABLE width="100%">
 
<FORM method="POST" name="errform" action="oa-transeditin.dsp">

<SCRIPT LANGUAGE="JavaScript">

	function back() 
    {
		var transactionName = document.errform.transactionName.value;
		var release = document.errform.fOARelease.value;
		document.location='oa-transeditin.dsp?transactionName='+transactionName +
            '&fOARelease='+release;
		return true;
	}
	
	function onSubmit() 
    {
	    var transactionName = document.errform.transactionName.value;
		document.errform.faction.value = 'errSQLSave';
		document.errform.errSQL.value = document.errform.ErrorSQL.value;
        document.errform.submit();        

		return true;
	}  
</SCRIPT>
	<INPUT type="hidden" name="faction" value="none"> 
	<INPUT type="hidden" name="errSQL" value=""> 
	<INPUT type="hidden" name="transactionName" value="%value transactionName%">
	<INPUT type="hidden" name="fOARelease" value="%value fOARelease%">

	<TR><TH class="title" colspan=2>Error Service SQL For %value transactionName%</TH></TR>
	<TR><TD class="action" colspan=2><CENTER>
	<INPUT class="data" type="button" value="Submit" onclick="onSubmit();"></INPUT>
	<INPUT type="button" value="Reset" onclick="document.errform.reset();">
	<INPUT type="button" value="Cancel" onclick="back()"></CENTER></TD></TR>	                    

	<TR class="heading">
	
	<TH colspan=2>Enter or Edit Error SQL for %value transactionName% </TH></TR>
	<TR><TH class="rowlabel" width="28%"> Error SQL </TR>
	<TD class="rowdata">
    %invoke  wm.adapter.wmoa.transaction:getErrorSQL%
        <TEXTAREA name="ErrorSQL" rows=15 cols=69>%value errSQL%</TEXTAREA>
    %onerror%
      <SCRIPT LANGUAGE="JavaScript">
      %ifvar localizedMessage%
        alert("Error encountered retrieving error SQL: %value localizedMessage%");
      %else%
        %ifvar errorMessage%
          alert("Error encountered retrieving error SQL: %value errorMessage%");
        %else%
            %ifvar error%
              alert("Error encountered retrieving error SQL: %value error%");
            %else%
              alert("Error encountered retrieving error SQL.");
            %endif%
        %endif%
      %endif%
      </SCRIPT>
    %endinvoke%
    </TD>
    </TH>	
</FORM>

</TABLE>
</TD></TR></TABLE>
</BODY>

</HTML>