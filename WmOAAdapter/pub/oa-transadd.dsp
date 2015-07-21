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

%switch transactionType%
%case 'OUT'%
<FORM method="POST" name="newtranform" onSubmit="return validateForm()" action="oa-transeditout.dsp">
%case 'IN'%
<FORM method="POST" name="newtranform" onSubmit="return validateForm()" action="oa-transeditin.dsp">
%endswitch%
<TABLE width="100%">

<TR><TH class="title" colspan=2>New Transaction</TH></TR>

<SCRIPT LANGUAGE="JavaScript">
%ifvar fOARelease%
  %ifvar fOARelease equals('none')%
  %else%
  
    setIllegalChars();
      
    // array of Transaction names
    var origTrans = new Array ();
    numItems = 0;
    
    // Set all transaction related variables
    %invoke wm.adapter.wmoa.transaction:transactionList%
    %ifvar transactionType equals('IN')%
        %loop InTransactions%
            origTrans[numItems] = '%value transactionName%';
            numItems++;
        %endloop%
    %else%
        %loop OutTransactions%
            origTrans[numItems] = '%value transactionName%';
            numItems++;
        %endloop%
    %endif%
    %onerror%
      %ifvar localizedMessage%
        alert("Error encountered retrieving transactions: %value localizedMessage%");
      %else%
        %ifvar errorMessage%
          alert("Error encountered retrieving transactions: %value errorMessage%");
        %else%
          %ifvar error%
            alert("Error encountered retrieving transactions: %value error%");
          %else%
            alert("Error encountered retrieving transactions.");
          %endif%
        %endif%
      %endif%
    %endinvoke%
    
    origTrans.length = numItems;

  %endif%
%endif%

    function duplicateTran(tranName)
    {
        
        if (inArray(origTrans, tranName.value) == -1)
        {
            return false;
        }
        else
        {
            alert('This is a duplicate transaction. Please supply a unique Transaction Name');
            return true;
        }
        
    }
    
    function validateForm() 
    {
        var transactionName = document.newtranform.newName.value;
        var type = document.newtranform.transactionType.value;	
        if (transactionName == null || transactionName == "") 
        {
            alert("Please supply a Transaction Name.");
        }
        else 
        {
            // Check for illegal chars again
            if(containsIllegalChars(document.newtranform.newName, 'Transaction Name'))
            {
                document.newtranform.newName.focus();
                return false;
            }
            
            if(duplicateTran(document.newtranform.newName))
            {
                document.newtranform.newName.focus();
                return false;
            }
                
            document.newtranform.transactionName.value = 
                document.newtranform.newName.value;
            document.newtranform.transactionType.value = type;

            return(true);
            
        }
        return false;
    }

	function onCancel() 
    {
                 
    	document.location='oa-transconfig.dsp?fOARelease='+document.newtranform.fOARelease.value
            +'&transactionType='+document.newtranform.transactionType.value;
		return true;
		 
	}
</SCRIPT>

 

	<INPUT type="hidden" name="fOARelease" value="%value fOARelease%">
	<INPUT type="hidden" name="ftransactionName" value=""> 
	<INPUT type="hidden" name="transactionType" value="%value transactionType%">

	<INPUT type="hidden" name="transactionName" value="">
	<INPUT type="hidden" name="treeLevel" value="0">
	<INPUT type="hidden" name="SQLPath" value="">
	<INPUT type="hidden" name="faction" value="addtran">
        
	<TR><TD class="action" colspan=2><CENTER>
		<INPUT type="submit" value="Submit">
		<INPUT type="button" value="Reset" onclick="document.newtranform.reset();">
		<INPUT type="button" value="Cancel" onclick="onCancel();">
	</CENTER></TD></TR>

	<TR class="heading"><TH colspan=2>Enter the new transaction name</TH></TR>

	<TR>
		<TH class="rowlabel" width="28%">Transaction Name</TH>
		<TD class="rowdata"><INPUT name="newName" size=43 
            onChange="containsIllegalChars(this,'Transaction Name');"></TD>
		</TR>	
</TABLE>     
</FORM>
</BODY>

