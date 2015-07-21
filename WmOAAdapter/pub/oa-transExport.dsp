<HTML>
<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<HEAD>
<TITLE>B2B Integration Server -- Users</TITLE>
%include ../../WmRoot/pub/b2bStyle.css%
%include oa-utils.dsp%

</HEAD>

<SCRIPT LANGUAGE="JavaScript">

    var release = 'none';
    
%ifvar oarelease%
  %ifvar oarelease equals('none')%
  %else%
  
    setIllegalChars();
      
    // Set all transaction related variables
    %invoke wm.adapter.wmoa.transaction:getAllTranNames%

	release = '%value OARelease%';

	// array of Transaction names
	var origTrans = new Array ();

    // array of transaction types (Oracle-to-B2B, B2B-to-Oracle)
	var origTypes = new Array ();
	var transSelected = new Array();
	
    numItems = 0;
    %loop AllTransactions -struct%
        origTrans[numItems] = '%value $key%';
        origTypes[numItems] = '%value%';
        numItems++;
    %endloop%
    origTrans.length = numItems;
    origTypes.length = numItems;

    %onerror%
      %ifvar localizedMessage%
        alert("Error encountered retrieving transactions <%value error%> %value localizedMessage%");
      %else%
        %ifvar error%
          alert("Error encountered retrieving transactions <%value error%> %value errorMessage%");
        %endif%
      %endif%
    %endinvoke%
  %endif%
%endif%

    function releaseChange () 
    {
        if (document.exportform.OARelease.selectedIndex==0)
        {
            document.exportform.oarelease.value = "none";
        }
        else
        {
            document.exportform.oarelease.value = 
               document.exportform.OARelease[document.exportform.OARelease.selectedIndex].value;
        }
        release = document.exportform.oarelease.value;
        document.exportform.submit();  
        return true;
    }
    
    function validateFileName(fileName, displayTxt)
    {
        if (containsIllegalChars(fileName, displayTxt))
        {
            fileName.focus();
            return false;
        }
        return true;
    }
    
	function onExport() 
	{
        // Validate the file field was set.
        if(document.exportform.exportFile.value == "")
        {
            alert("Export file name must be specified.");
            return false;
        }
        else if(validateFileName(document.exportform.exportFile, 'Export File') == false)
        {
            return false;
        }
        else
        {
            selectCount=0;

            if(isArray(document.exportform.useTran))
            {
                for(Count=0;Count<document.exportform.useTran.length;Count++)
                {

                    if (document.exportform.useTran[Count].checked)
                    {
                        transSelected[selectCount] = origTrans[Count];
                        selectCount++;
                    }
                }
            }
            else if(isObject(document.exportform.useTran))
            {
                // There's one transaction
                if (document.exportform.useTran.checked)
                {
                    transSelected[selectCount] = origTrans[0];
                    selectCount++;
                }
            }
            else
            {
                // There are no transactions so skip
            }

                              
            if (selectCount == 0)
            {
                alert("No transaction selected for export.");
                return false;
            }
            else
            {
                if(document.exportform.overwrite.checked)
                    document.exportform.overwriteFile.value = true;
                else
                    document.exportform.overwriteFile.value = false;
                            
                document.exportform.transSelected.value = transSelected;
                document.exportform.createExport.value = true;
                document.exportform.submit();
            }
            return true;
        }
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

        <TR><TH class="title" colspan=2>Oracle Applications Transaction Export</TH></TR>
        <FORM name="exportform" method="GET" action="oa-transExport.dsp">
%ifvar createExport equals('true')%
    %invoke wm.adapter.wmoa.exchange:createExport%
    <TR><TH id="message" colspan=2>%value message%</TH></TR>
    %onerror%
      %ifvar localizedMessage%
        %ifvar error%
          <INPUT type="hidden" name="err" value="%value error%: %value localizedMessage%">
        %endif%
      %else%
        %ifvar error%
          <INPUT type="hidden" name="err" value="%value error%: %value errorMessage%">
        %endif%
      %endif%
      <SCRIPT LANGUAGE=JavaScript>
        alert("Error encountered creating export file:" + document.exportform.err.value);
      </SCRIPT>
    %endinvoke%
%endif%

%ifvar oarelease%
    <INPUT type="hidden" name="oarelease" value="%value oarelease%"> 
%else%

    <INPUT type="hidden" name="oarelease" value="none"> 
%endif%    

    <INPUT type="hidden" name="transSelected" value="none"></INPUT>
    <INPUT type="hidden" name="createExport" value="false"> 
    <INPUT type="hidden" name="overwriteFile" value="false"> 

%ifvar serverName%
%else%
    %invoke wm.adapter.wmoa.exchange:getServerName%
    %onerror%
      <SCRIPT LANGUAGE=JavaScript>
      %ifvar localizedMessage%
        alert("Error invoking getServerName: %value localizedMessage%");
      %else%
        alert("Error invoking getServerName: %value errorMessage%");
      %endif%
      </SCRIPT>
    %endinvoke%
%endif%
        
%comment%
Retrieve the list of supported Oracle Applications Release to
populate the drop down list for the Oracle Apps Release field
%endcomment%
%invoke wm.adapter.wmoa.exchange:supportedOAReleases%
    %ifvar releases%
                <TR><TH class="rowlabel" width="28%">Oracle Apps Release</TH>
                <TD class="rowdata">
                <SELECT name="OARelease" onChange="releaseChange();">
                <OPTION VALUE="none">Select a Release</OPTION>
                %loop releases%
                    <OPTION VALUE="%value release%" %ifvar /oarelease vequals('release')% SELECTED %endif%> 
                    %value displayRelease% 
                    </OPTION>
                %endloop%
                </SELECT>
                </TD>
                </TR>
    %endif%

    %comment%
    Display the export file and transaction list info if the user choose a release.
    %endcomment%

    %ifvar oarelease%
        %ifvar oarelease equals('none')%
            %comment%
                The user has not selected a release so just display a Cancel button that 
                takes them back to the initial transaction mgmt screen.
            %endcomment%
            <TR>
               <TD class="action" colspan=2><CENTER>
                <INPUT type="button" value="Cancel" 
                    onclick="document.location='oa-transmgmt.dsp';" >
               </CENTER></TD>
            </TR>
        %else%
            %comment%
                We need to display the export file information
            %endcomment%
            <TR>
               <TH class="rowlabel" width=28%>Export File</TH>
               <TD class="rowdata">
                  <INPUT TYPE="TEXT" name="exportFile" 
                    onChange="validateFileName(this,'Export File');"> <B>Overwrite Existing File</B>
                  <INPUT type="checkbox" name="overwrite"></INPUT>
               </TD>
            </TR>
            <TR>
               <TH class="rowlabel" width=28%>Create Host</TH>
               <TD class="rowdata"><INPUT TYPE="TEXT" name="serverName" value="%value serverName%"></TD>
            </TR>
            <TR>
               <TH class="rowlabel" width=28%>Description</TH>
               <TD class="rowdata"><INPUT TYPE="TEXT" name="description" MAXLENGTH="100"></TD>
            </TR>
            <TR>
               <TD class="action" colspan=2><CENTER>
            	<INPUT type="button" value="Create File" onclick="onExport();">
            	<INPUT type="button" value="Reset" onclick="document.exportform.reset();">
            	<INPUT type="button" value="Cancel" 
                    onclick="document.location='oa-transExport.dsp';" >
                
               </CENTER></TD>
            </TR>
       </TABLE>
        
            %comment%
                The OARelease was set above. We need to get both the inbound 
                and outbound transactions for display.
            %endcomment%
            <TABLE WIDTH=100%>
            <TR class="heading">
                <TH colspan=4>Choose Transactions to Export</TH>
            </TR>
            <TR class="subheading">
            	<TH width=22%>Export this transaction <BR>
            	    <INPUT type="button" value="Set" 
                           onclick="setAll(document.exportform.useTran,true);" width=10% ALLIGN="RIGHT">
            	    <INPUT type="button" value="Clear" 
                           onclick="setAll(document.exportform.useTran, false);" width=10% ALLIGN="RIGHT">
                </TH>
            	<TH>Name</TH>
            	<TH width=15%>Transaction <BR>Type</TH>
            </TR>
            %invoke wm.adapter.wmoa.transaction:getAllTranNames%
            %ifvar NO_TRANS%
                <TR>
                    <TH id="message" colspan=3>No transactions found for export.</TH>
                </TR>
            %else%
            
                %loop AllTransactions -struct%     
                <TR>
            	    <TD class="coldata">
            	    <INPUT type="checkbox" name="useTran"></INPUT>
            	    </TD>
            	    <TD class="coltext">&nbsp;&nbsp;&nbsp;%value $key%</TH>
            	    <TD class="coldata">%value%</TD>
                </TR>
                %endloop%
            %endif%
            </TABLE>
            %onerror%
              %ifvar localizedMessage%
                <INPUT type="hidden" name="err" value="%value error%: %value localizedMessage%">
              %else%
                %ifvar error%
                  <INPUT type="hidden" name="err" value="%value error%: %value errorMessage%">
                %endif%
              %endif%
             <SCRIPT LANGUAGE=JavaScript>
               alert("Error encountered retrieving transactions:" + 
                document.exportform.err.value);
             </SCRIPT>
           %endinvoke%
        %endif%
    %else%
        %comment%
            The user has not selected a release so just display a Cancel button that 
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
    %ifvar localizedMessage%
      <INPUT type="hidden" name="err" value="%value error%: %value localizedMessage%">
      <SCRIPT LANGUAGE=JavaScript>
      %ifvar errorMessage%
        alert("Error encountered retrieving supported releases: %value localizedMessage%");
      %else%
        %ifvar error%
          alert("Error encountered retrieving supported releases: %value error%");
        %else%
          alert("Error encountered retrieving supported releases.");
        %endif%
      %endif%
      </SCRIPT>
    %else%
      <INPUT type="hidden" name="err" value="%value error%: %value errorMessage%">
      <SCRIPT LANGUAGE=JavaScript>
      %ifvar errorMessage%
        alert("Error encountered retrieving supported releases: %value errorMessage%");
      %else%
        %ifvar error%
          alert("Error encountered retrieving supported releases: %value error%");
        %else%
          alert("Error encountered retrieving supported releases.");
        %endif%
      %endif%
      </SCRIPT>
    %endif%
%endinvoke%

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
</TD>
</TR>
</TABLE>
</BODY>
</HTML>