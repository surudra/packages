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

<SCRIPT LANGUAGE="JavaScript">

    function clearTableList()
    {
        document.transactionform.tableList.selectedIndex = -1;
        setTableState();        
        return true;
    }

    function setTableState()
    {
        var opt = document.transactionform.tableList;
        // No table selected so clear form values
        if(opt.selectedIndex == -1) 
        {
            document.transactionform.ftableName.value = "";
            document.transactionform.newtableName.value = "";
            document.transactionform.newrequired.value = "";
                
        } 
        else 
        {
            document.transactionform.ftableName.value = 
                opt.options[opt.selectedIndex].value;
            document.transactionform.newtableName.value = 
                document.transactionform.ftableName.value;
                
            if (isArray(document.transactionform.required))
            {
                document.transactionform.newrequired.value = 
                    document.transactionform.required[opt.selectedIndex].value;
                    
            }
            else
            {
                document.transactionform.newrequired.value = 
                    document.transactionform.required.value;
            }
        }
    }
    
    function getSelectedTable()
    {
        var opt = document.transactionform.tableList;
        var tableName = null;
        if(opt.selectedIndex != -1)
        {
            tableName = opt.options[opt.selectedIndex].value;
        }
        return tableName;
    }

    function isTableRequired()
    {
        var opt = document.transactionform.tableList;
        if(opt.selectedIndex != -1) 
        {
            var reqValue;
            if(isArray(document.transactionform.required))
            {
                reqValue = document.transactionform.required[opt.selectedIndex].value;
            }    
            else
            {
                reqValue = document.transactionform.required.value;
            }
            
            if( reqValue == "true")
                return true;
            else
                return false;    
        }
        
        return false;
    }

	function editErrSQL() 
    {
        document.location = 'oa-errservice.dsp?fOARelease='+document.transactionform.fOARelease.value +
                                '&transactionName=' + document.transactionform.transactionName.value;
		return true;
	}
    
    function tableSelect()
    {
        var tableName = getSelectedTable();
        
        if (tableName != null)
        {
            setTableState();
            document.transactionform.faction.value = 'tableSelect';            
            document.transactionform.submit();
            return true;
        }
        else
            alert("Unable to get the selected table name");
        return false;
    }
 	 

    function cancelEdit()
    { 
        if(clearTableList() == false)
            alert("Unable to clear the table list.");
        document.transactionform.editname.value = "";
        document.transactionform.editrequired.checked = false;
        return true;
    }
    
    function deletetable () 
    {
        var tableName = getSelectedTable();

        if (tableName != null) 
        {
            if (confirm("OK to delete table "+tableName+"?")) 
            {
                document.transactionform.faction.value = "deletetable";
                document.transactionform.submit();
                return true;
            }
        }
        else
        {
            alert("Please select a table to delete.");
        }

        return false;
    }
    
    function addTable() 
    {
        
    	if(document.transactionform.editname.value == "")
    	{
    	    alert("Please specify a table name to add.");
    	    return false;
    	}
        
    	document.transactionform.newtableName.value = 
    	    document.transactionform.editname.value;
    	document.transactionform.newrequired.value = 
        	document.transactionform.editrequired.checked;
    	document.transactionform.faction.value = "addtable";
    	document.transactionform.submit();
    	return true;
    	 
    }

    function editTable() 
    {
        
    	if(document.transactionform.editname.value == "")
    	{
    	    alert("The table name is a required field. Please supply a value.");
    	    return false;
    	}
        
    	document.transactionform.newtableName.value = 
    	    document.transactionform.editname.value;
    	document.transactionform.newrequired.value = 
    	    document.transactionform.editrequired.checked;
    	document.transactionform.faction.value = "edittable";
    	document.transactionform.submit();
    	return true;
    	 
    }
    
    function saveEdit()
    {
        var origTable = getSelectedTable();
        var status;
        if (origTable != null)
        {
            // Edit the table
            return editTable();
        }
        else
        {
            // Add the table
            return addTable();
        }
        
    }
    
    function resetEdit()
    {
        if (getSelectedTable() != null)
        {
          // Only reset if the user choose a table to edit
          document.transactionform.reset();
        }
        else
        {
          document.transactionform.editname.value = "";
          document.transactionform.editrequired.checked = false;
        }
    }
    
    function validate()
    {
        if (document.transactionform.faction.value == 'enterPress')
        {
            return saveEdit();
        }
        
        return true;
    }
    
</SCRIPT>

<FORM method="POST" name="transactionform" onSubmit="return validate()" action="oa-transeditin.dsp">
<TABLE width="100%">
%switch faction%
%case 'addtran'%
    <INPUT type="hidden" name="tempOARelease" value="%value fOARelease%">
	%invoke wm.adapter.wmoa.transaction:transactionAdd%
	%onerror%
	  <SCRIPT LANGUAGE="JavaScript">
    %ifvar localizedMessage%
      alert("Error encountered adding transaction: %value localizedMessage%");
    %else%
      %ifvar errorMessage%
        alert("Error encountered adding transaction: %value errorMessage%");
      %else%
        %ifvar error%
          alert("Error encountered adding transaction: %value error%");
        %else%
          alert("Error encountered adding transaction.");
        %endif%
      %endif%
    %endif%

	  %comment%
	    Return to the previous tran add screen if the tran add failed.
	  %endcomment%
	      document.location='oa-transadd.dsp?faction=add'+'&transactionType=IN&fOARelease='+document.transactionform.tempOARelease.value;
      
	  </SCRIPT>
	%endinvoke%
    <INPUT type="hidden" name="ftableName" value="">
    <INPUT type="hidden" name="newtableName" value="">
    <INPUT type="hidden" name="newrequired" value="">
%case 'addtable'%
	%invoke wm.adapter.wmoa.transaction:transactionTableAdd%
	<TR><TH id="message" colspan=2>%value message%</TH></TR>
	<INPUT type="hidden" name="ftableName" value="%value newtableName%">
    <INPUT type="hidden" name="newtableName" value="%value newtableName%">
    <INPUT type="hidden" name="newrequired" value="%value newrequired%">
	%onerror%
    <SCRIPT LANGUAGE=JavaScript>
      %ifvar localizedMessage%
        alert("Error encountered adding table: %value localizedMessage%");
      %else%
        %ifvar errorMessage%
          alert("Error encountered adding table: %value errorMessage%");
        %else%
          %ifvar error%
            alert("Error encountered adding table: %value error%");
          %else%
            alert("Error encountered adding table.");
          %endif%
        %endif%
      %endif%
    </SCRIPT>
    <INPUT type="hidden" name="ftableName" value="">
    <INPUT type="hidden" name="newtableName" value="">
    <INPUT type="hidden" name="newrequired" value="">
	%endinvoke%
%case 'edittable'%
	%invoke wm.adapter.wmoa.transaction:transactionTableEdit%
	<TR><TH id="message" colspan=2>%value message%</TH></TR>
	<INPUT type="hidden" name="ftableName" value="%value newtableName%">
	<INPUT type="hidden" name="newtableName" value="%value newtableName%">
	<INPUT type="hidden" name="newrequired" value="%value newrequired%">
	%onerror%
	  <SCRIPT LANGUAGE="JavaScript">
	    %ifvar localizedMessage%
  	    alert("Error encountered saving table edits: %value localizedMessage%");
	    %else%
	      %ifvar errorMessage%
  	      alert("Error encountered saving table edits: %value errorMessage%");
	      %else%
	        %ifvar error%
	          alert("Error encountered saving table edits: %value error%");
	        %else%
  	        alert("Error encountered saving table edits.");
	        %endif%
	      %endif%
	    %endif%
    </SCRIPT>
	  <INPUT type="hidden" name="ftableName" value="">
	  <INPUT type="hidden" name="newtableName" value="">
	  <INPUT type="hidden" name="newrequired" value="">
	%endinvoke%
%case 'deletetable'%
	%invoke wm.adapter.wmoa.transaction:transactionTableDelete%
	<TR><TH id="message" colspan=2>%value message%</TH></TR>
	%onerror%
	  <SCRIPT LANGUAGE="JavaScript">
      %ifvar localizedMessage%
        alert("Error encountered deleting table: %value localizedMessage%");
      %else%
        %ifvar errorMessage%
          alert("Error encountered deleting table: %value errorMessage%");
        %else%
          %ifvar error%
            alert("Error encountered deleting table: %value error%");
          %else%
            alert("Error encountered deleting table.");
          %endif%
        %endif%
      %endif%
    </SCRIPT>
	%endinvoke%
	<INPUT type="hidden" name="ftableName" value="">
	<INPUT type="hidden" name="newtableName" value="">
	<INPUT type="hidden" name="newrequired" value="">
%case 'errSQLSave'%
	%invoke wm.adapter.wmoa.transaction:transactionErrSQLEdit%
	<TR><TH id="message" colspan=2>%value message%</TH></TR>
	%onerror%
	  <SCRIPT LANGUAGE="JavaScript">
	    %ifvar localizedMessage%
  	    alert("Error encountered saving error SQL: %value localizedMessage%");
	    %else%
	      %ifvar errorMessage%
	        alert("Error encountered saving error SQL: %value errorMessage%");
	      %else%
	        %ifvar error%
	          alert("Error encountered saving error SQL: %value error%");
	        %else%
	          alert("Error encountered saving error SQL.");
	        %endif%
	      %endif%
	    %endif%
    </SCRIPT>
	%endinvoke%
	<INPUT type="hidden" name="ftableName" value="">
	<INPUT type="hidden" name="newtableName" value="">
	<INPUT type="hidden" name="newrequired" value="">
%case 'tableSelect'%
	<INPUT type="hidden" name="ftableName" value="%value ftableName%">
    <INPUT type="hidden" name="newtableName" value="%value newtableName%">
    <INPUT type="hidden" name="newrequired" value="%value newrequired%">
%case%
	<INPUT type="hidden" name="ftableName" value="">
	<INPUT type="hidden" name="newtableName" value="">
	<INPUT type="hidden" name="newrequired" value="">
%endswitch%

<INPUT type="hidden" name="faction" value="enterPress">
<INPUT type="hidden" name="transactionName" value="%value transactionName%">
<INPUT type="hidden" name="transactionType" value="IN">
<INPUT type="hidden" name="fOARelease" value="%value fOARelease%">

<TR><TH class="title" colspan=2>Edit  %value transactionName% Transaction</TH></TR>
<TR><TD class="action" colspan=2><CENTER>
	<INPUT type="button" value="Delete Table" onclick="deletetable();">
	<INPUT type="button" value="Edit Error SQL" onclick="editErrSQL();">
	<INPUT type="button" value="Back" onclick="document.location='oa-transconfig.dsp?transactionType=IN&fOARelease='+document.transactionform.fOARelease.value+'&OARelease='+document.transactionform.fOARelease.value;">
</CENTER></TD></TR>


<TR class="heading">
    <TH colspan=2>Current Tables</TH>
</TR>

%invoke wm.adapter.wmoa.transaction:tableList%
<TR>
<TD colspan=2>
<CENTER>
<SELECT NAME="tableList" size=6 width="300" onchange="tableSelect();">
	%loop tables%
	    <OPTION value="%value tableName%" %ifvar /newtableName vequals('tableName')%SELECTED%endif%>
        %value tableName%
	%endloop%
</SELECT>
%loop tables%
    <INPUT type="hidden" name="required" value="%value required%">
%endloop%   
</CENTER>
</TD>
</TR>

<TR>
    <TH class="subheading" colspan=2>Table Information<BR></TH>
</TR>
<TR><TD class="action" colspan=2><CENTER>
	<INPUT type="button" value="Submit" onclick="saveEdit();">
	<INPUT type="button" value="Reset" onclick="resetEdit();">
	<INPUT type="button" value="Cancel" onclick="cancelEdit();">
</CENTER></TD></TR>

<TR>
    <TH class="rowlabel" width=28%>Table Name</TH>
    <TD class="coltext">
        <INPUT name="editname" size=50 
        %ifvar /faction equals('deletetable')%
        %else%
            %ifvar /newtableName%value="%value /newtableName%"%endif%
        %endif%>        
</TD>
</TR>

<TR>
    <TH class="rowlabel" width=28%>Required</TH>
    <TD class="coltext"><INPUT type="checkbox" name="editrequired" 
        %ifvar /faction equals('deletetable')%
        %else%
            %ifvar /newrequired equals('true')%CHECKED%endif%
        %endif%></TD>
</TR>
%onerror%
	<SCRIPT LANGUAGE="JavaScript">
	  %ifvar localizedMessage%
  	  alert("Error encountered retrieving current tables: %value localizedMessage%");
	  %else%
	    %ifvar errorMessage%
  	    alert("Error encountered retrieving current tables: %value errorMessage%");
	    %else%
	      %ifvar error%
	        alert("Error encountered retrieving current tables: %value error%");
	      %else%
  	      alert("Error encountered retrieving current tables.");
	      %endif%
	    %endif%
	  %endif%
	</SCRIPT>
%endinvoke%  
</TABLE>
</FORM>
</BODY>

</HTML>
