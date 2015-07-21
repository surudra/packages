<HTML>
<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<HEAD>
<TITLE>B2B Integration Server -- Users</TITLE>
%include ../../WmRoot/pub/b2bStyle.css%
%include oa-utils.dsp%

</HEAD>

<SCRIPT LANGUAGE="JavaScript">
%ifvar importFile%
  %ifvar importFile equals('none')%
  %else%
    setIllegalChars();
  %endif%
%endif%

    function releaseChange () 
    {
      document.importform.importtorel.value = 
        document.importform.OARelease[document.importform.OARelease.selectedIndex].value;

      // This indicates a submit after an error
      if(isDefined(document.importform.reseterr))
      {
        document.importform.reseterr.value = "none";
      }
      document.importform.submit();  
      return true;
    }

    //
    // This function sets the proper import file name when the user chooses a new
    // "Import File" selection.
    //
    function fileNameChange() 
    {
        if (document.importform.availableImports.selectedIndex==0)
        {
            document.importform.importFile.value = "none";
        }
        else
        {
            document.importform.importFile.value = 
               document.importform.availableImports[document.importform.availableImports.selectedIndex].value;
        }
        
        // If the user is on the inital screen this variable will not exist.
        if(isDefined(document.importform.importtorel))
        {
          document.importform.importtorel.value = "none";
        }
          
        // This indicates a submit after an error
        if(isDefined(document.importform.reseterr))
        {
          document.importform.reseterr.value = "none";
        }
        
        document.importform.submit();  
        return true;
    }

    //////////////////////////////////
    // Array value access functions //
    //////////////////////////////////
    function getImportName(index)
    {
        // Retrieve the import name
        if(isArray(document.importform.importName))
            return document.importform.importName[index].value;
        else
            return document.importform.importName.value;
    }
    
    function isOverWriteChecked(index)
    {
        if(isArray(document.importform.overwriteExisting))
        {
            return document.importform.overwriteExisting[index].checked;
        }
        else
        {
            return document.importform.overwriteExisting.checked;
        }

    }

    function isUseTranChecked(index)
    {
        if(isArray(document.importform.useTran))
        {
            return document.importform.useTran[index].checked;
        }
        else
        {
            return document.importform.useTran.checked;
        }

    }
    
    //
    // Returns the number of transactions the user selected for import.
    // It returns 0 is none were selected.
    //
    function getNumberToImport()
    {
        var numTrans = 0;
        var numItems;
        
        if(isArray(document.importform.useTran))
        {
            numItems = document.importform.useTran.length;
        }
        else if (isObject(document.importform.useTran))
        {
            numItems = 1;
        }
        else
        {
            numItems = 0;
        }
        
        for(Count = 0; Count < numItems; Count++)
        {
            if(isUseTranChecked(Count))
            {
                numTrans++;
            }
        }
        
        return numTrans;
    }
    
    //
    // This function will use the index sent in to retirve the import name from the 
    // array. It will then search the import array to see if there is another tran 
    // with the same name and is slected for import.
    //
    function importExistsInList(index)
    {
        
        if(isArray(document.importform.importName))
        {
            // Retrieve the import name
            var importName = getImportName(index);
            var len = document.importform.importName.length;
        
            for(i = 0; i < len; i++)
            {
                if ((importName == getImportName(i)) && 
                    (i != index) &&
                    (isUseTranChecked(i)))
                {
                    // We found a duplicate
                    return importName;
                }
            }
        }
        
        // If it's not an array we always return null
        return null;
    }
    
    //
    // This function will use the index sent in to retrieve the import name from the 
    // array. It will search the names of all transactions already defined on 
    // the server.
    //
    function importExistsOnServer(index)
    {
        // Retrieve the import name
        var importName = getImportName(index);
        
        for(i = 0; i < oarelTrans.length; i++)
        {
            if (oarelTrans[i] == importName)
            {
                return importName;
            }
        }

        return null;
    }
    
    function getTranIndex(ckBoxFld)
    {
        return ckBoxFld.ID;
    }

    //
    // This function expects a useTran check box object as input. If the check box
    // is selected it will enable the corresponding import name and overwrite cells.
    // Otherwise it will disable them. 
    //
    function onImportChange(ckBoxFld)
    {
        // Determine if the box was checked
        if (ckBoxFld.checked)
        {
            // Get the array index from the check box field
            var index = getTranIndex(ckBoxFld);
                        
            // If the import name exists then
            var importName = importExistsOnServer(index);
            
            if((importName != null) && 
                (!isOverWriteChecked(index)))
            {
                // Found the tran already named on the server
                alert("A transaction named " + importName + 
                 " is already defined.\n" + 
                 " You will need to change the import name or choose to" +
                 " overwrite the existing transaction.");
            }
            else
            {
                // See if the tran is already listed on the import name
                // and selected for import.
                importName = importExistsInList(index);
                if ((importName != null) && 
                    (!isOverWriteChecked(index)))
                {
                    alert("A transaction named " + importName + 
                     " is already selected for import.\n" + 
                     " You will need to change the import name before importing.");
                }
            }
            
        }
        
        return true;
    }
    
    //
    // This function will loop over the "Import this Transaction" checkboxes and 
    // either select or deselect the import this tran, import name, and overwrite
    // columns. Send true to select and activate the columns and false otherwise.
    //
    function setAllImport(selected)
    {
        setAll(document.importform.useTran, selected);

        if (selected)
        {
            var dupServerTrans = new Array();
            var numServerDups;
            numServerDups = 0;

            var dupListTrans = new Array();
            var numListDups;
            numListDups = 0;

            var numItems;
        
            if(isArray(document.importform.useTran))
            {
                numItems = document.importform.useTran.length;
            }
            else if (isObject(document.importform.useTran))
            {
                numItems = 1;
            }
            else
            {
                numItems = 0;
            }
            
            // If they are checking all then we need to warn them about duplicates.
    
            var currTran = null;
    
            for (Count = 0;Count < numItems; Count++)
            {
                currTran = importExistsOnServer(Count);
                if((currTran != null) && 
                    (!isOverWriteChecked(Count)) &&
                    (inArray(dupServerTrans, currTran) == -1))
                {
                    dupServerTrans[numServerDups] = currTran;
                    numServerDups++;
                }
        
                currTran = importExistsInList(Count);
                if((currTran != null) && 
                    (inArray(dupListTrans, currTran) == -1))
                {
                    dupListTrans[numListDups] = currTran;
                    numListDups++;
                }
            }

            if(dupServerTrans.length != 0)
            {
                var beginStr;
                if(dupServerTrans.length == 1)
                {
                    beginStr = "The following transaction already exists on the server:\n";
                }
                else
                {
                    beginStr = "The following transactions already exist on the server:\n";
                }
        
                var displayStr = beginStr;
        
                for(Count = 0;Count < dupServerTrans.length;Count++)
                {
                    displayStr += "   " + dupServerTrans[Count] + "\n";
                }
        
                alert(displayStr);
        
            }
    
            if (dupListTrans.length != 0)
            {
                var beginStr;
                if(dupListTrans.length == 1)
                {
                    beginStr = "The following transaction has a duplicate import name:\n";
                }
                else
                {
                    beginStr = "The following transactions have duplicate import names:\n";
                }
        
                var displayStr = beginStr;
        
                for(Count = 0;Count < dupListTrans.length;Count++)
                {
                    displayStr += dupListTrans[Count] + "\n";
                }
        
                alert(displayStr);
            }
        }
        return true;
    }
    
    function validateNewTran(tranField, displayTxt)
    {
        if (containsIllegalChars(tranField, displayTxt))
        {
            tranField.focus();
        }
        return;
    }
    
    function onImport() 
    {
        // Make sure there are transactions to import.
        if(getNumberToImport() > 0)
        {
        
            // post an alert confirm
            if (confirm("OK to import the marked transactions?"))
            {
                var numTrans = 0;
                var numItems;
                var origNames = null;
                var newNames = null;
                var overwrite = null;
                
                if(isArray(document.importform.useTran))
                {
                    numItems = document.importform.useTran.length;
                    for(Count = 0; Count < numItems; Count++)
                    {
                        
                        if(isUseTranChecked(Count))
                        {
                            if (numTrans != 0)
                            {
                                origNames += "^";
                                newNames += "^";
                                overwrite += "^";
                                origNames += document.importform.tranName[Count].value;
                                newNames += document.importform.importName[Count].value;
                                if(document.importform.overwriteExisting[Count].checked)
                                    overwrite += true;
                                else
                                    overwrite += false;
                            }
                            else
                            {
                                // We can't concat the first entry.
                                origNames = document.importform.tranName[Count].value;
                                newNames = document.importform.importName[Count].value;
                                if(document.importform.overwriteExisting[Count].checked)
                                    overwrite = true;
                                else
                                    overwrite = false;
                            }                            
                            numTrans++;
                        }
                    }
                }
                else
                {
                    // We know there is at least 1 tran marked for import. So,
                    // this must be it.
                    origNames = document.importform.tranName.value;
                    newNames = document.importform.importName.value;
                    if(document.importform.overwriteExisting.checked)
                        overwrite = true;
                    else
                        overwrite = false;
                    
                }
            
                document.location='oa-transImportExec.dsp?runImport=true'
                        +'&fOARelease='+document.importform.importtorel.value
                        +'&importFile='+document.importform.importFile.value
                        +'&fileImportNames='+origNames
                        +'&newImportNames='+newNames
                        +'&overwrite='+overwrite;
            }
        }
        else
        {
            alert("There are no transactions marked for import.");
        }
        return true;
    }
    
    function cancelTran()
    {
      document.location='oa-transmgmt.dsp?first=true';
      return true;
    }

</SCRIPT>

<BODY>
<table width="100%">
   <tr>
      <td class="menusection-Adapters" colspan=8>Adapters &gt; OracleApps Adapter&gt; Transaction Mgmt</td>
    </tr>
</table>

<TABLE WIDTH=100%>
<TR>
<TD>
    <TABLE WIDTH=100%>

        <TR><TH class="title" colspan=2>Oracle Applications Transaction Import</TH></TR>
        <FORM name="importform" method="GET" action="oa-transImport.dsp">

%ifvar importFile%
  %ifvar importFile equals('none')%
    <INPUT type="hidden" name="importtorel" value="none"></INPUT>
  %endif%
  <INPUT type="hidden" name="importFile" value="%value importFile%"></INPUT>
%else%
  <INPUT type="hidden" name="importFile" value="none"></INPUT>
  <INPUT type="hidden" name="importtorel" value="none"></INPUT>
%endif%    

%ifvar reseterr%
  %ifvar reseterr equals('none')%
  %else%
  <INPUT type="hidden" name="importtorel" value="none"></INPUT>
  %endif%
%endif%

%comment%
Retrieve the list of available import files in the exchange directory.
%endcomment%
%invoke  wm.adapter.wmoa.exchange:getImportFiles%
        <TR><TH class="rowlabel" width="28%">Import Files</TH>
        <TD class="rowdata">
        <SELECT name="availableImports" onChange="fileNameChange();">
        <OPTION VALUE="none">Select an Import File</OPTION>
        %loop availableImports%
            <OPTION VALUE="%value file%" %ifvar /importFile vequals('file')% SELECTED %endif%> 
            %value file% 
            </OPTION>              
        %endloop%
        </SELECT>
        </TD>
        </TR>

        %ifvar importFile%
            %ifvar importFile equals('none')%
                %comment%
                    The user has not selected a file so just display a Cancel button that 
                    takes them back to the initial transaction mgmt screen.
                %endcomment%
                <TR>
                   <TD class="action" colspan=2><CENTER>
            	    <INPUT type="button" value="Cancel" onclick="document.location='oa-transmgmt.dsp';" >
                   </CENTER></TD>
                </TR>
            %else%
            %invoke wm.adapter.wmoa.exchange:getImportFileContents%

%ifvar /importtorel%
  %ifvar /importtorel equals('none')%
    <INPUT type="hidden" name="importtorel" value="%value exportInfo/OA_RELEASE%"></INPUT>
  %else%
    <INPUT type="hidden" name="importtorel" value="%value /importtorel%"></INPUT>
  %endif%
%else%
  <INPUT type="hidden" name="importtorel" value="%value exportInfo/OA_RELEASE%"></INPUT>
%endif%
            <TR>
               <TH class="rowlabel" width=28%>Create From Server</TH>
               <TD class="rowdata">%value exportInfo/CREATE_HOST%</TD>
            </TR>
            <TR>
               <TH class="rowlabel" width=28%>Create From Adapter Version</TH>
               <TD class="rowdata">%value exportInfo/CREATE_IM_VER%</TD>
            </TR>
            <TR>
               <TH class="rowlabel" width=28%>Date Created</TH>
               <TD class="rowdata">%value exportInfo/CREATE_DATE%</TD>
            </TR>
            <TR>
               <TH class="rowlabel" width=28%>Create From Oracle Applications Release</TH>
               <TD class="rowdata">%value exportInfo/OA_RELEASE%</TD>
            </TR>
            <TR>
               <TH class="rowlabel" width=28%>Description</TH>
               <TD class="rowdata">%value exportInfo/DESCRIPTION%</TD>
            </TR>
            
            <TR>
            <TH class="rowlabel" width=28%>Import To Oracle Applications Release</TH>
            %comment%
              If importtorel is none then we need to default the value to what is
              read from the file.
            %endcomment%
            %ifvar importtorel equals('none')%
              %invoke wm.adapter.wmoa.exchange:supportedOAReleases%
                %ifvar releases%
                  <TD class="rowdata">
                  <SELECT name="OARelease" onChange="releaseChange();">
                  %loop releases%
                      <OPTION VALUE="%value release%" %ifvar release vequals(/exportInfo/OA_RELEASE)% SELECTED %endif%> 
                      %value displayRelease% 
                      </OPTION>
                  %endloop%
                  </SELECT>
                  </TD>
                %endif%
              %onerror%
                <SCRIPT LANGUAGE="JavaScript">
                %ifvar localizedMessage%
                  alert("Error encountered retrieving supported OA release: %value localizedMessage%");
                %else%
                  %ifvar errorMessage%
                    alert("Error encountered retrieving supported OA release: %value errorMessage%");
                  %else%
                    %ifvar error%
                      alert("Error encountered retrieving supported OA release: %value error%");
                    %else%
                      alert("Error encountered retrieving supported OA release.");
                    %endif%
                  %endif%
                %endif%
                </SCRIPT>
              %endinvoke%
            %else%
              %invoke wm.adapter.wmoa.exchange:supportedOAReleases%
                %ifvar releases%
                  <TD class="rowdata">
                  <SELECT name="OARelease" onChange="releaseChange();">
                  %loop releases%
                      <OPTION VALUE="%value release%" %ifvar release vequals(/importtorel)% SELECTED %endif%> 
                      %value displayRelease% 
                      </OPTION>
                  %endloop%
                  </SELECT>
                  </TD>
                %endif%
              %onerror%
                <TD class="rowdata">%value exportInfo/OA_RELEASE%</TD>
                <SCRIPT LANGUAGE="JavaScript">
                %ifvar localizedMessage%
                  alert("Error encountered retrieving supported OA release: %value localizedMessage%");
                %else%
                  %ifvar errorMessage%
                    alert("Error encountered retrieving supported OA release: %value errorMessage%");
                  %else%
                    %ifvar error%
                      alert("Error encountered retrieving supported OA release: %value error%");
                    %else%
                      alert("Error encountered retrieving supported OA release.");
                    %endif%
                  %endif%
                %endif%
                </SCRIPT>
              %endinvoke%
            %endif%
            </TR>
            
            <TR>
               <TD class="action" colspan=2><CENTER>
            	<INPUT type="button" value="Import" onclick="onImport();">
            	<INPUT type="button" value="Reset" onclick="document.importform.reset();">
            	<INPUT type="button" value="Cancel" 
                    onclick="document.location='oa-transImport.dsp?first=true';" >
               </CENTER></TD>
            </TR>
        </TABLE>

        <SCRIPT LANGUAGE="JavaScript">
            // Set all transaction related variables
            // array of Transaction names
            var oarelTrans = new Array();
    
            %invoke wm.adapter.wmoa.exchange:getAllImportToTranNames%
            numItems = 0;
            %loop AllTransactions -struct%
                oarelTrans[numItems] = '%value $key%';
                numItems++;
            %endloop%
            oarelTrans.length = numItems;
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
    
        </SCRIPT>
                   
        %comment%
            Display the transactions contained in the import file.
        %endcomment%
        <TABLE WIDTH=100%>
            <TR class="heading">
                <TH colspan=5>Choose Transactions to Import</TH>
            </TR>
            <TR class="subheading">
            	<TH>Import this transaction <BR>
            	    <INPUT type="button" value="Set" 
                           onclick="setAllImport(true);" width=10% ALLIGN="RIGHT">
            	    <INPUT type="button" value="Clear" 
                           onclick="setAllImport(false);" width=10% ALLIGN="RIGHT">
                </TH>
            	<TH>Name</TH>
            	<TH width=15%>Transaction <BR>Type</TH>
                <TH>Import Name</TH>
                <TH width=20%>Overwrite <BR>Existing<BR>
            	    <INPUT type="button" value="Set" 
                           onclick="setAll(document.importform.overwriteExisting, true);" 
                           width=10% ALLIGN="RIGHT">
            	    <INPUT type="button" value="Clear" 
                           onclick="setAll(document.importform.overwriteExisting,false);" 
                           width=10% ALLIGN="RIGHT">
                </TH>
            </TR>
            %ifvar FILE_NO_TRANS%
                <TR>
                    <TH id="message" colspan=5>No transactions found in file.</TH>
                </TR>
            
                </TABLE>
            %else%
                <TBODY>
                %loop importFileTrans -struct%     
                <TR>
            	    <TD class="coldata">
            	      <INPUT type="checkbox" name="useTran" onClick="onImportChange(this)">
            	    </TD>
            	    <TD class="coltext">&nbsp;&nbsp;&nbsp;%value $key%</TD>
            	    <INPUT type="hidden" name="tranName" value="%value $key%">
            	    <TD class="coldata">%value%</TD>
            	    <TD class="coltext">
                      <INPUT type="text" name="importName" value="%value $key%"
                        onChange="validateNewTran(this,'Import name');">
                    </TD>
                    <TD class="coldata">
                      <INPUT type="checkbox" name="overwriteExisting">
                    </TD>
                </TR>
                %endloop%
                </TBODY>
                </TABLE>
                <SCRIPT LANGUAGE="JavaScript">
                // This sets the ID for each check box to hold it's array index.
                if (isArray(document.importform.useTran))
                {
                    for(i=0;i<document.importform.useTran.length;i++)
                    {
                        document.importform.useTran[i].ID = i;
                        document.importform.importName[i].ID = i;
                    }
                }
                else
                {
                    document.importform.useTran.ID = 0;
                }
                </SCRIPT>
            %endif%
          %onerror%
              <INPUT type="hidden" name="importtorel" value="none"></INPUT>
              %ifvar localizedMessage%
                <INPUT type="hidden" name="reseterr" value="%value error%: %value localizedMessage%">
                <SCRIPT LANGUAGE="JavaScript">
                alert("Error encountered retrieving import file: %value localizedMessage%");
                </SCRIPT>
              %else%
                <INPUT type="hidden" name="reseterr" value="%value error%: %value errorMessage%">
                <SCRIPT LANGUAGE="JavaScript">
                %ifvar errorMessage%
                  alert("Error encountered retrieving import file: %value errorMessage%");
                %else%
                  %ifvar error%
                    alert("Error encountered retrieving import file: %value error%");
                  %else%
                    alert("Error encountered retrieving import file.");
                  %endif%
                %endif%
                </SCRIPT>
              %endif%
              <TR>
                <TD class="action" colspan=2><CENTER>
                <INPUT type="button" value="Cancel" 
                    onclick="document.location='oa-transmgmt.dsp';" >
                </CENTER></TD>
              </TR>
          %endinvoke%
        %endif%
    %else%
        %comment%
            The user has not selected a file so just display a Cancel button that 
            takes them back to the initial transaction mgmt screen.
        %endcomment%
        <TR>
           <TD class="action" colspan=2><CENTER>
        	<INPUT type="button" value="Cancel" 
                onclick="document.location='oa-transmgmt.dsp';" >
           </CENTER></TD>
        </TR>
    %endif%
           
%onerror%
  <INPUT type="hidden" name="importtorel" value="none"></INPUT>
  %ifvar localizedMessage%
    <INPUT type="hidden" name="reseterr" value="%value error%: %value localizedMessage%">
    <SCRIPT LANGUAGE="JavaScript">
      alert("Error encountered retrieving import files: %value localizedMessage%");
    </SCRIPT>
  %else%
    <INPUT type="hidden" name="reseterr" value="%value error%: %value errorMessage%">
    <SCRIPT LANGUAGE="JavaScript">
    %ifvar errorMessage%
      alert("Error encountered retrieving import files: %value errorMessage%");
    %else%
      %ifvar error%
        alert("Error encountered retrieving import files: %value error%");
      %else%
        alert("Error encountered retrieving import files.");
      %endif%
    %endif%
    </SCRIPT>
  %endif%
%endinvoke%

    </TABLE>
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
</TD>
</FORM>
</TR>
</TABLE>
</BODY>
</HTML>