<HTML><HEAD>
<TITLE>Add Server</TITLE>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<SCRIPT src="webMethods.js"></SCRIPT>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<BODY>
<TABLE width="100%">
	<TR>
		<TD class="menusection-DeployerServers" colspan="3">Configure Repository Server</TD>
	</TR>
</TABLE>

<SCRIPT LANGUAGE="JavaScript">
function onAdd() {

	// Name is always required
	var name = document.addServerForm.aliasName.value;
	if ( trim(name) == "" ) {
		alert("Repository name is required.");
		return false;
	}
	if (!isIllegalName(name)) {
		alert("Invalid Name.\nRefer to Integration Server Administrator's Guide for listed illegal characters.");
		document.addServerForm.aliasName.focus();
		return false;
	}
	return true;
}
function onCheckCentraSite() {

  var repoType = document.getElementById("repositoryType");
  if(document.getElementById("CentraSiteRegistry").checked) {
      repoType.options[repoType.length - 1] = null;
  }
  else {
    repoType.options[repoType.length] = new Option('Flat File', 'FLATFILE');
    repoType.options[2] = null;
  }
}

</SCRIPT>
<TABLE width="100%">
  <TBODY>
    <TR>
      <TD><IMG height="10" src="images/blank.gif" width="10"></TD>
    </TR>
    <TR>
      <TD><IMG height="0" src="images/blank.gif" width="10"></TD>
      <TD valign="top">
        <TABLE class="tableForm">
          <TBODY>
            <TR>
              <TD class="heading" colspan="2">Configure Repository Server</TD>
            </TR>
            <FORM name="addServerForm" target="treeFrame" action=remote-repository-servers.dsp method=post>
            <INPUT type="hidden" VALUE="add" name="action">

	   <SCRIPT>resetRows();</SCRIPT>		

            <TR>
		<script> writeTD("row"); </script>* Name</TD>
		<script> writeTD("rowdata-l"); </script> 
            	<INPUT name="aliasName" size="28" maxlength="32">
            </TR>
		<SCRIPT>swapRows();</SCRIPT>						
            <TR>
              <script>writeTD("row")</script>Repository Type</td>
               <script>writeTD("rowdata-l")</script>
               <input type="hidden" name="repositoryType" id="repositoryType" value="FLATFILE"/> FlatFile
               
               <!--
               <P><SELECT size="1" name="repositoryType" id="repositoryType">			    		  
      			      <OPTION VALUE="SVN">Subversion</OPTION>
      			      <OPTION VALUE="FLATFILE">Flat File</OPTION>                     														                        			
    	     		</SELECT>
    	     	-->
             </TR>         	
		<SCRIPT>swapRows();</SCRIPT>	
    <tr>
	       <script>writeTD("row-l")</script>File Directory</td>
		     <script>writeTD("rowdata-l")</script>
		    <input type="text" name="flatFileDirectory" value="%value flatFileDirectory%"  style="width:100%"/>
		    <script>swapRows();</script>
		</tr>    	             		

            <TR>
              <TD class="action" colspan="2">
		  <INPUT  onclick="return onAdd();" type="submit" VALUE="Configure" name="submit">
		</TD>
            </TR>
		
    </FORM>
   </TBODY>
  </TABLE>
<script>
	document.addServerForm.name.focus();
</script>

</BODY>
</HTML>
