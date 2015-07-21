<HTML><HEAD>
<TITLE>Add Project</TITLE>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<SCRIPT src="webMethods.js"></SCRIPT>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<BODY>

<SCRIPT language=JavaScript>
function onAdd() {

	var name = document.addProjectForm.projectName.value;

	if ( trim(name) == "" ) {
		alert("Project Name is required.");
		return false;
	} 
	else if (!isIllegalName(name)) {
		alert("Invalid Name.\nRefer to Integration Server Administrator's Guide for listed illegal characters.");
		return false;
	}

	startProgressBar('Creating Project ' + name);
	return true;
}

</SCRIPT>



<TABLE width="100%">
	<TR>
		<TD class="menusection-Deployer" colspan="3">Create Project %value hideACDL%</TD>
	</TR>
</TABLE>
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
              <TD class="heading" colspan="2">Create Project</TD>
            </TR>
            <FORM name="addProjectForm" target="treeFrame" action=project-list.dsp method=post>
            <INPUT type="hidden" VALUE="add" name="action">
            <TR>
              <TD class="oddrow">* Name</TD>
              <TD class="oddrow-l"><INPUT name="projectName" size="28" maxlength="32"></TD>
            </TR>
            <TR>
              <TD class="evenrow">Description</TD>
              <TD class="evenrow-l"><INPUT name="projectDescription" size="32"></TD>
            </TR>
            <script>
                %invoke wm.deployer.gui.UISettings:getSettings%
                %endinvoke%
            </script>
              %ifvar hideACDL equals('false')%
                <TR>
                  <TD class="oddrow">Project Type</TD>
                  <TD class="oddrow-l">
                    %ifvar projectType equals('Runtime')%
          						<INPUT type="radio" name="projectType" value="Runtime" checked >Runtime						
          						<INPUT type="radio" name="projectType" value="Repository">Repository
          					%endif%
          					%ifvar sourceOfTruth equals('FlatFile')%
          						<INPUT type="radio" name="projectType" value="Runtime">Runtime
          						<INPUT type="radio" name="projectType" value="Repository" checked>Repository
          					%else%
          						<INPUT type="radio" name="projectType" value="Runtime" checked >Runtime
          						<INPUT type="radio" name="projectType" value="Repository" onClick="onSelectRepository(true)">Repository
          					%endif%
                  </TD>
                </TR>
              %endif%            

            
            <TR>
              <TD class="subheading" colspan="2">Required fields are indicated by *</TD>
            </TR>
            <TR>
              <TD class="action" colspan="2">
								<INPUT onclick="return onAdd();" type="submit" VALUE="Create" name="submit">
							</TD>
            </TR>
    				</FORM>
          </TBODY>
        </TABLE>
      </TD>
    </TR>
  </TBODY>
</TABLE>

<script>
	document.addProjectForm.projectName.focus();
</script>

</BODY>
</HTML>
