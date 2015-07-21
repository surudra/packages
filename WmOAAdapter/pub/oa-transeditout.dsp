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

<FORM method="POST" name="transactionform" onSubmit="return validate()" action="oa-transeditout.dsp">
<TABLE width="100%">
%switch faction%
%case 'addtran'%
    <INPUT type="hidden" name="tOARelease" value="%value fOARelease%">
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
    document.location='oa-transadd.dsp?faction=add'+'&transactionType=OUT&fOARelease='+document.transactionform.tOARelease.value;
  </SCRIPT>
	%endinvoke%
	<INPUT type="hidden" name="falias" value="">
	<INPUT type="hidden" name="newAlias" value=""> 
	<INPUT type="hidden" name="newSQL" value=""> 
	<INPUT type="hidden" name="newRelation" value=""> 
%case 'addalias'%
	%invoke wm.adapter.wmoa.transaction:transactionAliasAdd%
	<TR><TH id="message" colspan=2>%value message%</TH></TR>
	<INPUT type="hidden" name="falias" value="%value newAlias%">
	<INPUT type="hidden" name="newAlias" value="%value newAlias%"> 
	<INPUT type="hidden" name="newSQL" value="%value newSQL%"> 
	<INPUT type="hidden" name="newRelation" value="%value newRelation%"> 
	%onerror%
	  <SCRIPT LANGUAGE="JavaScript">
	  %ifvar localizedMessage%
  	  alert("Error encountered adding alias: %value localizedMessage%");
	  %else%
	    %ifvar errorMessage%
	      alert("Error encountered adding alias: %value errorMessage%");
	    %else%
	      %ifvar error%
	        alert("Error encountered adding alias: %value error%");
	      %else%
	        alert("Error encountered adding alias.");
	      %endif%
	    %endif%
	  %endif%
	  </SCRIPT>
	  <INPUT type="hidden" name="falias" value="">
	  <INPUT type="hidden" name="newAlias" value="%value newAlias%"> 
	  <INPUT type="hidden" name="newSQL" value="%value newSQL%"> 
	  <INPUT type="hidden" name="newRelation" value="%value newRelation%"> 
	%endinvoke%
    
%case 'editalias'%
	%invoke wm.adapter.wmoa.transaction:transactionAliasEdit%
	<TR><TH id="message" colspan=2>%value message%</TH></TR>
	<INPUT type="hidden" name="falias" value="%value newAlias%">
	<INPUT type="hidden" name="newAlias" value="%value newAlias%"> 
	<INPUT type="hidden" name="newSQL" value="%value newSQL%"> 
	<INPUT type="hidden" name="newRelation" value="%value newRelation%"> 
	%onerror%
	  <SCRIPT LANGUAGE="JavaScript">
	    %ifvar localizedMessage%
  	    alert("Error encountered saving sql edits: %value localizedMessage%");
	    %else%
	      %ifvar errorMessage%
	        alert("Error encountered saving sql edits: %value errorMessage%");
	      %else%
	        %ifvar error%
	          alert("Error encountered saving sql edits: %value error%");
	        %else%
	          alert("Error encountered saving sql edits.");
	        %endif%
	      %endif%
	    %endif%
	  </SCRIPT>
	  <INPUT type="hidden" name="falias" value="">
	  <INPUT type="hidden" name="newAlias" value=""> 
	  <INPUT type="hidden" name="newSQL" value=""> 
	  <INPUT type="hidden" name="newRelation" value=""> 
	%endinvoke%

%case 'deletealias'%
	%invoke wm.adapter.wmoa.transaction:transactionAliasDelete%
	<TR><TH id="message" colspan=2>%value message%</TH></TR>
	%onerror%
    <SCRIPT LANGUAGE="JavaScript">
    %ifvar localizedMessage%
      alert("Error encountered deleting alias: %value localizedMessage%");
    %else%
      %ifvar errorMessage%
        alert("Error encountered deleting alias: %value errorMessage%");
      %else%
        %ifvar error%
          alert("Error encountered deleting alias: %value error%");
        %else%
          alert("Error encountered deleting alias.");
        %endif%
      %endif%
    %endif%
    </SCRIPT>
	%endinvoke%
	<INPUT type="hidden" name="falias" value="">
	<INPUT type="hidden" name="newAlias" value=""> 
	<INPUT type="hidden" name="newSQL" value=""> 
	<INPUT type="hidden" name="newRelation" value=""> 

%case 'ackSqlEdit'%
	%invoke wm.adapter.wmoa.transaction:AcknowledgeSQLEdit%
	<TR><TH id="message" colspan=2>%value message%</TH></TR>
	%onerror%
	  <SCRIPT LANGUAGE="JavaScript">
	  %ifvar localizedMessage%
  	  alert("Error encountered saving acknowledgement sql: %value localizedMessage%");
	  %else%
	    %ifvar errorMessage%
  	    alert("Error encountered saving acknowledgement sql: %value errorMessage%");
	    %else%
	      %ifvar error%
	        alert("Error encountered saving acknowledgement sql: %value error%");
	      %else%
  	      alert("Error encountered saving acknowledgement sql.");
	      %endif%
	    %endif%
	  %endif%
	  </SCRIPT>
	%endinvoke%
	<INPUT type="hidden" name="falias" value="">
	<INPUT type="hidden" name="newAlias" value=""> 
	<INPUT type="hidden" name="newSQL" value=""> 
	<INPUT type="hidden" name="newRelation" value=""> 
    
%case 'aliasselect'%
	<INPUT type="hidden" name="falias" value="%value falias%">
	<INPUT type="hidden" name="newAlias" value="%value newAlias%"> 
	<INPUT type="hidden" name="newSQL" value="%value newSQL%"> 
	<INPUT type="hidden" name="newRelation" value="%value newRelation%"> 
    
%case%
	<INPUT type="hidden" name="falias" value="">
	<INPUT type="hidden" name="newAlias" value=""> 
	<INPUT type="hidden" name="newSQL" value=""> 
	<INPUT type="hidden" name="newRelation" value=""> 
%endswitch%

<SCRIPT LANGUAGE="JavaScript">

    setIllegalChars();
    
    function getSelectedAlias (action) 
    {
        var opt = document.transactionform.aliasList;
        var aliasName = null;
        if(opt.selectedIndex == -1) 
        {
            if(action != null)
                alert ("Please select an alias to "+action+".");
    
        } 
        else 
        {
            aliasName = opt.options[opt.selectedIndex].value;
        }
        return aliasName;
    }

    function isAliasSelected() 
    {
        var opt = document.transactionform.aliasList;
        if(opt.selectedIndex == -1) 
        {
          return false;    
        } 
        else 
        {
          return true;
        }
    }

    function clearSelectedAlias()
    {
        document.transactionform.aliasList.selectedIndex = -1;
        setAliasState();
    }
    
    function setAliasState()
    {
        var opt = document.transactionform.aliasList;
        // No alias selected so clear form values
        if(opt.selectedIndex == -1) 
        {
            document.transactionform.falias.value = "";
            document.transactionform.newAlias.value = "";
            document.transactionform.newSQL.value = "";
            document.transactionform.newRelation.value = "";
                
        } 
        else 
        {
            document.transactionform.falias.value = 
                opt.options[opt.selectedIndex].value;
            document.transactionform.newAlias.value = 
                document.transactionform.falias.value;
            if (isArray(document.transactionform.sqlrelation))
            {
                document.transactionform.newRelation.value = 
                    document.transactionform.sqlrelation[opt.selectedIndex].value;
                    
                document.transactionform.newSQL.value = 
                    document.transactionform.sqlout[opt.selectedIndex].value;
            }
            else
            {
                document.transactionform.newRelation.value = 
                    document.transactionform.sqlrelation.value;
                
                document.transactionform.newSQL.value = 
                    document.transactionform.sqlout.value;
            }
        }
    }
    
    function getSelectedSQL()
    {
        if(!isDefined(document.transactionform.sqlout))
        {
            return null;
        }
        else if(isArray(document.transactionform.sqlout))
        {
            return document.transactionform.sqlout[document.transactionform.aliasList.selectedIndex].value;
        }
        else
        {
            return document.transactionform.sqlout.value;
        }
    }
    
    function nextLevel() 
    {

        var aliasName = getSelectedAlias("traverse");
        if (aliasName == null) 
        {
            return false; 
        }
        else 
        {
            var transactionName = document.transactionform.transactionName.value;
            var SQLPath = document.transactionform.SQLPath.value;
            if(SQLPath == "") 
                SQLPath = aliasName;
            else
                SQLPath = SQLPath + '.'+aliasName;

            var fOARelease = document.transactionform.fOARelease.value;
            var sql = getSelectedSQL();
            if(sql.toLowerCase().search("select ") > -1)
            {

                var treeLevel = document.transactionform.treeLevel.value - 0;
                treeLevel++;
                
                document.location='oa-transeditout.dsp?transactionName='+transactionName+
                  '&fOARelease='+fOARelease +
                  '&SQLPath='+SQLPath+
                  '&treeLevel='+treeLevel;

                return true;
            }
            else 
            {
                alert ("There is no next level for a Stored Procedure call.");
                return false;
            }
        }
        return false;
    }
	
    function gopreviousLevel() 
    {

        var currentLevel = document.transactionform.currentLevel.value;
        var transactionName = document.transactionform.transactionName.value;
        var SQLPath = document.transactionform.previousLevel.value;
        var fOARelease = document.transactionform.fOARelease.value;
        var treeLevel = document.transactionform.treeLevel.value - 0;
        treeLevel--;
        
        if(currentLevel == "")
        {

            document.location='oa-transconfig.dsp?transactionType=OUT'+
            '&fOARelease='+fOARelease+
            '&OARelease='+fOARelease+
            '&transactionName='+transactionName;
        }
        else
        {
            document.location='oa-transeditout.dsp?transactionName='+transactionName+
            '&fOARelease='+fOARelease +
            '&SQLPath='+SQLPath+
            '&aliasName='+currentLevel+
            '&treeLevel='+treeLevel;
        }
        
        return true;

    } 
	
	function deleteAlias() 
  {
    var aliasName = getSelectedAlias("Delete");  
    if (aliasName != null) 
    {
      if (confirm("OK to delete alias "+aliasName+"?")) 
      {
        document.deleteform.falias.value = aliasName;  
        document.deleteform.transactionName.value = 
        document.transactionform.transactionName.value;
        document.deleteform.SQLPath.value = 
          document.transactionform.SQLPath.value;
        document.deleteform.fOARelease.value = 
          document.transactionform.fOARelease.value;
        document.deleteform.treeLevel.value = 
          document.transactionform.treeLevel.value;

     document.deleteform.submit(); 
        return true;
      }

    }
    return false; 

  } 
    
	function onChange() 
  {
    if(getSelectedAlias("Edit") != null)
    {
      setAliasState();
      document.transactionform.faction.value = 'aliasselect';            
     document.transactionform.submit();
    }
    
    return true;
  }  

	function ackservice () 
    {
		var transactionName = document.transactionform.transactionName.value;
		var release = document.transactionform.fOARelease.value;
		if (transactionName != null) 
        {
		    document.location='oa-ackservice.dsp?transactionName='+transactionName+
                '&fOARelease='+release+
                '&treeLevel='+document.transactionform.treeLevel.value;
		    return true;
		}
		return false;
	}

	function editAlias()
	{
	    document.transactionform.faction.value = 'editalias';
	    document.transactionform.newAlias.value =document.transactionform.SQLAlias.value;
	    document.transactionform.newSQL.value =document.transactionform.SQLOut.value;
      if(isDefined(document.transactionform.SQLRelation))
          document.transactionform.newRelation.value = document.transactionform.SQLRelation.value;
      else    
          document.transactionform.newRelation.value = "";        
      document.transactionform.submit();
      return true;        
	}

	function addAlias()
	{
        
	    document.transactionform.faction.value = 'addalias';
	    document.transactionform.newAlias.value =document.transactionform.SQLAlias.value;
	    document.transactionform.newSQL.value =document.transactionform.SQLOut.value;

	    if(isDefined(document.transactionform.SQLRelation))
    	    document.transactionform.newRelation.value = document.transactionform.SQLRelation.value;
        else    
            document.transactionform.newRelation.value = "";        
            
	    document.transactionform.submit();
        return true;
        
	}

	function cancelEdit()
	{ 
	    clearSelectedAlias();
	    document.transactionform.SQLAlias.value = "";
	    document.transactionform.SQLOut.value = "";
        if(isDefined(document.transactionform.SQLRelation))
	        document.transactionform.SQLRelation.value = "";
        
	}
	
	function saveEdit()
	{
	    if(document.transactionform.SQLAlias.value == "")
	    {
	        alert("The alias name is a required field. Please supply a value.");
	        return false;
	    }
      else
      {
        // Validate the alias name
        if(containsIllegalChars(document.transactionform.SQLAlias, 'Alias Name'))
        {
            document.transactionform.SQLAlias.focus();
            return false;
        }
      
      }
	
	    if(document.transactionform.SQLOut.value == "")
	    {
	        alert("The alias SQL is a required field. Please supply a value.");
	        return false;
	    }
        
	    var origAlias = getSelectedAlias();
	    if (origAlias != null)
	    {
	        // Edit the table
	        return editAlias();
	    }
	    else
	    {
	        // Add the table
	        return addAlias();
	    }
	    
	    return false;
	}
	
	function resetEdit()
	{
    if(isAliasSelected())
    {
      document.transactionform.reset();
    }
    else
    {
	    document.transactionform.SQLAlias.value = "";
	    document.transactionform.SQLOut.value = "";
	    if(isDefined(document.transactionform.SQLRelation))
	      document.transactionform.SQLRelation.value = "";
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

	<INPUT type="hidden" name="faction" value="enterPress"> 
	<INPUT type="hidden" name="transactionName" value="%value transactionName%">
	<INPUT type="hidden" name="SQLPath" value="%value SQLPath%">
	<INPUT type="hidden" name="fOARelease" value="%value fOARelease%">
	<INPUT type="hidden" name="treeLevel" value="%value treeLevel%">
    

	<TR><TH class="title" colspan=2>Edit Transaction : %value transactionName% </TH></TR>

	<TR><TD class="action" colspan=2><CENTER>
		 
		<INPUT class="data" type="button" value="Next Level" onclick="nextLevel();"></INPUT> 
		<INPUT class="data" type="button" value="Previous Level" onclick="gopreviousLevel();"></INPUT> 
		<INPUT class="data" type="button" value="Delete Alias" onclick="deleteAlias();"></INPUT>
        %ifvar SQLPath equals('')%  
        <INPUT class="data" type="button" value="Edit Ack SQL" onclick="ackservice();"></INPUT> 
        %endif%
	</CENTER></TD></TR>

	 
	%invoke wm.adapter.wmoa.transaction:SQLAliasList%
	  %comment% Never display the relation field at the top of the SQL tree %end%
	  %ifvar /treeLevel equals('0')%
	  <TR>
      <TH class="heading" width="50%">SQL Tree</TH>
      <TH class="heading" width="50%">Current Level: TOP</TH></TR>
	  %else%
	    %ifvar /treeLevel equals('1')%
	    <TR><TH class="heading" width="50%">SQL Tree</TH>
          <TH class="heading" width="50%">Current Level: %value currentLevel%</TH></TR>
      %else%
	    <TR><TH class="heading" width="50%">SQL Tree</TH>
          <TH class="heading" width="50%">Current Level: %value previousLevel%.%value currentLevel%</TH></TR>
	    %endif%
	  %endif%
	  <TR><TD class="coldata" colspan=2>

		<INPUT type="hidden" name="previousLevel" value="%value previousLevel%">
		<INPUT type="hidden" name="currentLevel" value="%value currentLevel%">
    <CENTER>
		<SELECT NAME="aliasList" size=6 width="400" onChange="onChange();">
		

		%loop SQLAliases%
	 		<OPTION value="%value SQLAlias%" %ifvar /newAlias vequals('SQLAlias')% SELECTED %endif%>%value SQLAlias%</OPTION>
		%endloop%
		
		</SELECT></CENTER></TD></TR>
    %loop SQLAliases%
    <INPUT type="hidden" name="sqlrelation" value="%value SQLRelation%">
    <INPUT type="hidden" name="sqlout" value="%value SQLOut%">
    %endloop%
</TABLE>
<TABLE width="100%">
	
<TR>
    <TH class="subheading" colspan=2>Alias Information</TH>
</TR>

<TR><TD class="action" colspan=2><CENTER>
	<INPUT type="button" value="Submit" onclick="saveEdit();">
	<INPUT type="button" value="Reset" onclick="resetEdit();">
	<INPUT type="button" value="Cancel" onclick="cancelEdit();">
</CENTER></TD></TR>

    %comment%
        Alias information fields will only be filled in with values if the user
        is not deleting an alias.
    %end%
    <TR><TH class="rowlabel" width="28%">Alias Name</TH>
    <TD class="rowdata">
    <INPUT name="SQLAlias" size=43 
        %ifvar /faction equals('deleteTran')%
        %else%
            %ifvar /newAlias%value="%value /newAlias%"%endif%
        %endif%>
    </TD></TR>


    <TR><TH class="rowlabel" width="28%">  SQL  </TR>
    <TD class="rowdata">
	    <TEXTAREA name="SQLOut" rows=6 cols=60
            %ifvar /faction equals('deleteTran')%
            %else%
                %ifvar /newSQL%value="%value /newSQL%"%endif%
            %endif%>%value /newSQL%</TEXTAREA>
    </TH></TD>

    %comment% Never display the relation field at the top of the SQL tree %end%
    %ifvar /treeLevel equals('0')%
    %else%
        <TR><TH class="rowlabel" width="28%">Relations<BR><BR>(Parent: %value currentLevel%)</TH>
        <TD class="rowdata">
	        <TEXTAREA name="SQLRelation" rows=3 cols=60
            %ifvar /faction equals('deleteTran')%
            %else%
                %ifvar /newRelation%value="%value /newRelation%"%endif%
            %endif%>%value /newRelation%</TEXTAREA>
        </TD></TR>
    %endif%

  %onerror%
    <SCRIPT LANGUAGE="JavaScript">
    %ifvar localizedMessage%
      alert("Error encountered retrieving transaction aliases: %value localizedMessage%");
    %else%
      %ifvar errorMessage%
        alert("Error encountered retrieving transaction aliases: %value errorMessage%");
      %else%
        %ifvar error%
          alert("Error encountered retrieving transaction aliases: %value error%");
        %else%
          alert("Error encountered retrieving transaction aliases.");
        %endif%
      %endif%
    %endif%
    </SCRIPT>
	%endinvoke%
</TABLE>
</FORM>

<FORM method="POST" name="deleteform" action="oa-transeditout.dsp">
	<INPUT type="hidden" name="faction" value="deletealias">
	<INPUT type="hidden" name="transactionName" value="">
	<INPUT type="hidden" name="fOARelease" value="">
	<INPUT type="hidden" name="treeLevel" value="">
	<INPUT type="hidden" name="SQLPath" value="">
	<INPUT type="hidden" name="falias" value="">
</FORM>
</BODY>
</HTML>
