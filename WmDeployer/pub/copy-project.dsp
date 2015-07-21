<HTML><HEAD>
<TITLE>Package Exchange</TITLE>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<SCRIPT src="webMethods.js"></SCRIPT>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<BODY>

<SCRIPT language=JavaScript>

function onCopy(sourceProject, targetProject) {

	var src = sourceProject.options[sourceProject.selectedIndex].value;
	var target = targetProject.value

	if (src == "--NONE--") {
		alert("Please specify the Project to copy.");
		return false;
	}
	else if ( trim(target) == "" ) {
		alert("New Project Name is required.");
		return false;
	} 
	else if (!isIllegalName(target)) {
		alert("Invalid Name.\nRefer to Integration Server Administrator's Guide for listed illegal characters.");
		return false;
	}
	else {
		startProgressBar("Copying Project " + src + " to new Project " + target);
		return true;
	}
}

</SCRIPT>

<TABLE width="100%">
	<TR>
		<TD class="menusection-Deployer" colspan="3">Copy Project</TD>
	</TR>
</TABLE>

<TABLE width="100%">
	<TR>
		<TD><IMG height="10" src="images/blank.gif" width="0"></TD>
	</TR>

	<TR>
		<TD><IMG height="0" src="images/blank.gif" width="10"></TD>
		<TD valign="top">
			<TABLE class="tableForm">
				<FORM name="copyProject" target="treeFrame" action=project-list.dsp method=post>
					<INPUT type="hidden" value="copy" name="action">

				<TR>
					<TD class="heading" colspan="2">Copy Project</TD>
				</TR>
				<TR>
					<TD class="evenrow">* Project to Copy</TD>
					<TD class="evenrow-l">
						<P><SELECT size="1" name="sourceProject">
							<OPTION VALUE="--NONE--">-- select a project --</OPTION>
							%invoke wm.deployer.gui.UIProject:listProjects%  
								%ifvar projects%
									%loop projects%
               <OPTION value="%value projectName%">%value projectName%</OPTION>
									%endloop%
								%endif%        
							%endinvoke%        
						</SELECT></P>
					</TD>
				</TR>

				<TR>
					<TD class="oddrow">* New Project Name</TD>
					<TD class="oddrow-l"><INPUT NAME=targetProject size="32" maxlength="32"></TD>
				</TR>

				<TR style="display:none">
					<TD class="evenrow">Description</TD>
					<TD class="evenrow-l"><INPUT name="projectDescription" size="32" maxlength="32"></TD>
				</TR>

         <TR>
           <TD class="subheading" colspan="2">Required fields are indicated by *</TD>
         </TR>
				<TR>
					<TD class="action" colspan="2"><INPUT
						onclick="return onCopy(sourceProject, targetProject);" 
							type="submit" value="Copy Project" name="submit">
					</TD>
				</TR>

				</FORM>
			</TABLE>
		</TD>
	</TR>
</TABLE>

<script>
		document.copyProject.sourceProject.focus();
</script>

</BODY>
</HTML>
