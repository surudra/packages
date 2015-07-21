<HTML>
<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>

<HEAD>
<TITLE>B2B Integration Server -- Users</TITLE>
%include ../../WmRoot/pub/b2bStyle.css%
</HEAD>

<BODY>
<table width="100%">
   <tr>
      <td class="menusection-Adapters" colspan=8>Adapters &gt; OracleApps Adapter&gt; Transaction Mgmt</td>
    </tr>
</table>

<TABLE width="100%">
<TR><TD>

%ifvar action equals('delete')%
	%invoke wm.adapter.wmoa.transaction:transactionDelete%
	<TR><TH id="message" colspan=2>%value message%</TH></TR>    
	%onerror%
	  <SCRIPT LANGUAGE="JavaScript">
    %ifvar localizedMessage%
      alert("Error encountered deleting transaction: %value localizedMessage%");
    %else%
      %ifvar errorMessage%
        alert("Error encountered deleting transaction: %value errorMessage%");
      %else%
        %ifvar error%
          alert("Error encountered deleting transaction: %value error%");
        %else%
          alert("Error encountered deleting transaction.");
        %endif%
      %endif%
    %endif%
	  </SCRIPT>
	%endinvoke%
%endif%

<SCRIPT LANGUAGE="JavaScript">

	function getSelectedRelease() 
    {
		var opt = document.transactionform.selOARelease;
		return opt[opt.selectedIndex].value;
	}


	function getSelectedTransaction(action) 
    {
		var opt = document.transactionform.transactionList;
		var transactionName = null;
		if (opt.selectedIndex == -1) 
        {
			alert ("Please select a transaction to "+action+".");
		} 
        else 
        {
			transactionName = opt.options[opt.selectedIndex].value;
		}
		return transactionName;
	}

    function editTransaction() 
    {
        var transactionName = getSelectedTransaction ("edit");
        var type = getTransactionType(); 
        if(transactionName  == null) 
        {
            return false; 
        } 
        else 
        {
            if(type == "OUT") 
            {

                document.location=
                    'oa-transeditout.dsp?&transactionName='+transactionName+
                    '&SQLPath='+
                    '&treeLevel=0'+
                    '&fOARelease='+getSelectedRelease();
                return true;

            }
            else
            {
                document.location=
                    'oa-transeditin.dsp?&transactionName='+transactionName+
                    '&fOARelease='+getSelectedRelease();
                return true;
            }
        }
    }

    function deleteTransaction () 
    {
        var transactionName = getSelectedTransaction("delete");
        if (transactionName != null) 
        {
            if (confirm("OK to delete transaction "+transactionName+"?")) 
            {
                document.location = 
                'oa-transconfig.dsp?action=delete'+
                '&ftransactionName='+transactionName+                
                '&transactionName='+transactionName+
                '&transactionType='+document.transactionform.transactionType.value+
                '&fOARelease='+getSelectedRelease()+
                '&OARelease='+getSelectedRelease();
                return true;
            }
        }
        return false;
    }

    function addTransaction () 
    {
         
        document.location=
            'oa-transadd.dsp?faction=add'+
            '&fOARelease='+getSelectedRelease()+
            '&transactionType='+getTransactionType();
        return true;
    }

    function releaseChange () 
    {
        document.transactionform.fOARelease.value = getSelectedRelease();
        document.transactionform.OARelease.value = getSelectedRelease();
        document.transactionform.submit();
        return true;

    } 

    function getTransactionType()
    {
        var checkedButton = "IN";
        if (document.transactionform.selTranType[0].checked) 
        {
            checkedButton = document.transactionform.selTranType[0].value;
        }
        else
        {
            if (document.transactionform.selTranType[1].checked) 
            {
                checkedButton = document.transactionform.selTranType[1].value;
            }
        }
        return checkedButton;
    }
	
	function onRadioChange()  
    {
        document.transactionform.fOARelease.value = getSelectedRelease();
        document.transactionform.OARelease.value = getSelectedRelease();
        document.transactionform.transactionType.value = getTransactionType();
        document.transactionform.submit();

        return true;
			 
	}
	 

</SCRIPT>

<TR><TH class="title" colspan=8>Transaction Configuration</TH></TR>
<FORM method="POST" name="transactionform" action="oa-transconfig.dsp">

<INPUT type="hidden" name="ftransactionName" value="">

%ifvar fOARelease%
    %ifvar fOARelease equals('none')%
        <INPUT type="hidden" name="fOARelease" value="none">
        <INPUT type="hidden" name="OARelease" value="none">
    %else%
        <INPUT type="hidden" name="fOARelease" value="%value fOARelease%">
        <INPUT type="hidden" name="OARelease" value="%value fOARelease%">
    %endif%
%else%
    <INPUT type="hidden" name="fOARelease" value="none">
    <INPUT type="hidden" name="OARelease" value="none">
%endif%

%ifvar transactionType%
    <INPUT type="hidden" name="transactionType" value="%value transactionType%">
%else%
    <INPUT type="hidden" name="transactionType" value="IN">
%endif%    

%comment%
Render the rest of the page if the user has already selected a release.
%endcomment%

%invoke wm.adapter.wmoa.exchange:supportedOAReleases%
    %ifvar releases%
        <TR><TH class="rowlabel" width="28%">Oracle Apps Release</TH>
        <TD class="rowdata">
        
        <SELECT name="selOARelease" onChange="releaseChange();">
        <OPTION VALUE="none">Select a Release</OPTION>
        %loop releases%
            <OPTION VALUE="%value release%" %ifvar /fOARelease vequals('release')% SELECTED %endif%> 
            %value displayRelease% 
            </OPTION>
        %endloop%
        </SELECT>
        </TD>
        </TR>
    %endif%
%onerror%
  <SCRIPT LANGUAGE=JavaScript>
  %ifvar localizedMessage%
    alert("Error encountered retrieving releases: %value localizedMessage%");
  %else%
    %ifvar errorMessage%
      alert("Error encountered retrieving releases: %value errorMessage%");
    %else%
      %ifvar error%
        alert("Error encountered retrieving releases: %value error%");
      %else%
        alert("Error encountered retrieving releases.");
      %endif%
    %endif%
  %endif%
  </SCRIPT>
%endinvoke%

%ifvar fOARelease%
    %ifvar fOARelease equals('none')%
    %else%  
        
        <TR><TH class="rowlabel" width="28%">Transaction Type</TH>
        <TH class="rowdata">
    	    <INPUT type="radio" name="selTranType" value="IN"  
                onclick="onRadioChange();">&nbsp;IS-to-Oracle</INPUT>
    	    <INPUT type="radio" name="selTranType" value="OUT" 
                onclick="onRadioChange();">&nbsp; Oracle-to-IS</INPUT>
                
            <SCRIPT LANGUAGE=JavaScript>
            %ifvar transactionType equals('OUT')%
                document.transactionform.selTranType[1].checked = true;
            %else%
                document.transactionform.selTranType[0].checked = true;
            %endif%
            </SCRIPT>
        </TH></TR>
        <TR>
        <TD class="action" colspan=8><CENTER>
        	<INPUT class="data" type="button" name="add" value="Add" onclick="addTransaction();"></INPUT>
        	<INPUT class="data" type="button" value="Edit" onclick="editTransaction();"></INPUT>
        	<INPUT class="data" type="button" value="Delete" onclick="deleteTransaction();"></INPUT>
        	<INPUT class="data" type="button" value="Cancel" 
        	    onclick="document.location='oa-transmgmt.dsp';" >
        
        </CENTER>
        </TD></TR>


        <TR>
            <TH class="heading" colspan=8>Current %ifvar transactionType equals('OUT')% Oracle-to-IS %else% IS-to-Oracle %endif%  Transactions</TH>
        </TR>
    
        <TR><TD colspan=8><CENTER>
        <SELECT NAME="transactionList" size=6 width=400>
        %invoke wm.adapter.wmoa.transaction:transactionList%
            %ifvar transactionType equals('OUT')%  
                %loop OutTransactions%
        	        <OPTION value="%value transactionName%">%value transactionName%</OPTION>
                %endloop%
            %else%
                %loop InTransactions%
        	        <OPTION value="%value transactionName%">%value transactionName%</OPTION>
                %endloop%
            %endif%
        %onerror%
          <SCRIPT LANGUAGE=JavaScript>
          %ifvar localizedMessage%
            alert("Error encountered retrieving transaction list: %value localizedMessage%");
          %else%
            %ifvar errorMessage%
              alert("Error encountered retrieving transaction list: %value errorMessage%");
            %else%
              %ifvar error%
                alert("Error encountered retrieving transaction list: %value error%");
              %else%
                alert("Error encountered retrieving transaction list.");
              %endif%
            %endif%
          %endif%
          </SCRIPT>
        %endinvoke%
        </SELECT></CENTER></TD></TR>

    %endif%    
%endif%    
	

%comment%
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
%endcomment%
</FORM>
</TD></TR></TABLE>
</BODY>

</HTML>
