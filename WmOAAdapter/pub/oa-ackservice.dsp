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
 
<FORM method="POST" name="ackform" action="oa-transeditout.dsp">

<SCRIPT LANGUAGE="JavaScript">

    function back() 
    {
        var transactionName = document.ackform.transactionName.value;
        var release = document.ackform.fOARelease.value;
        var level = document.ackform.treeLevel.value;
        document.location='oa-transeditout.dsp?transactionName='+transactionName+
                '&SQLPath=&fOARelease='+release+
                '&treeLevel='+level;
        return true;
    }

    function onSubmit() 
    {
        document.ackform.faction.value = 'ackSqlEdit';
        document.ackform.AcknowledgeSQL.value = document.ackform.ackSQL.value;
        document.ackform.submit(); 
        return true;
    }
</SCRIPT>
	<INPUT type="hidden" name="faction" value=""> 
	<INPUT type="hidden" name="transactionName" value="%value transactionName%">
	<INPUT type="hidden" name="SQLPath" value="">
	<INPUT type="hidden" name="AcknowledgeSQL" value="">
	<INPUT type="hidden" name="treeLevel" value="0">
	<INPUT type="hidden" name="fOARelease" value="%value fOARelease%">

	<TR><TH class="title" colspan=2>Acknowledgement Service SQL For %value transactionName%</TH></TR>
	<TR><TD class="action" colspan=2><CENTER>
	<INPUT class="data" type="button" value="Submit" onclick="onSubmit();"></INPUT>
	<INPUT type="button" value="Reset" onclick="document.ackform.reset();">
	<INPUT type="button" value="Cancel" onclick="back()"></CENTER></TD></TR>	                    

	<TR class="heading">
	
	<TH colspan=2>Enter or Edit Acknowledgement SQL for %value transactionName% </TH></TR>
	<TR><TH class="rowlabel" width="28%"> Acknowledgement SQL </TR>
	<TD class="rowdata">
	
    %invoke wm.adapter.wmoa.transaction:getAcknowledgeSQL%
        <TEXTAREA name="ackSQL" rows=15 cols=69>%value AcknowledgeSQL%</TEXTAREA>
    %onerror%
      <SCRIPT LANGUAGE="JavaScript">
      %ifvar localizedMessage%
        alert("Error encountered retrieving acknowledgement SQL: %value localizedMessage%");
      %else%
        %ifvar errorMessage%
          alert("Error encountered retrieving acknowledgement SQL: %value errorMessage%");
        %else%
            %ifvar error%
              alert("Error encountered retrieving acknowledgement SQL: %value error%");
            %else%
              alert("Error encountered retrieving acknowledgement SQL.");
            %endif%
        %endif%
      %endif%
      </SCRIPT>
    %endinvoke%
    </TD>
    </TH>	
</FORM>
</TD></TR>
</TABLE>
</BODY>

</HTML>