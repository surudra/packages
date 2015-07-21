<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<SCRIPT src="webMethods.js"></SCRIPT>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<BODY>
<SCRIPT language="JavaScript">
function isVersionFormatValid(version) {
	version = normalize(version);
	words = version.split(".");

	if ( words.length < 2 ||  words.length > 5) {
		return false;
	}	
	for( var i=0; i<words.length; i++ ) {	
		if( isNaN(parseInt(words[i])) )
			return false;
	}
	return true;
}

function isJVMFormatValid(jvmver) {
	jvmver = normalize(jvmver);
	words = jvmver.split(".");

	if ( words.length < 2 )
		return false;

	for( var i=0; i<words.length; i++ ) {
		if( isNaN(parseInt(words[i])) )
			return false;
	}
	return true;
}

function setPackageType(pkgType) {

	if (pkgType == "full") {

		document.getElementById("upgradePackage2").style.display  = "none";

		document.getElementById("fullPackage2").style.display  = "";
		document.getElementById("fullPackage3").style.display  = "";
		document.getElementById("fullPackage4").style.display  = "";
		document.getElementById("fullPackage5").style.display  = "";
		document.getElementById("fullPackage6").style.display  = "";
		document.getElementById("fullPackage7").style.display  = "";
		document.getElementById("fullPackage8").style.display  = "";
	}
	else {

		document.getElementById("upgradePackage2").style.display  = "";

		document.getElementById("fullPackage2").style.display  = "";
		document.getElementById("fullPackage3").style.display  = "";
		document.getElementById("fullPackage4").style.display  = "";
		document.getElementById("fullPackage5").style.display  = "";
		document.getElementById("fullPackage6").style.display  = "";
		document.getElementById("fullPackage7").style.display  = "";
		document.getElementById("fullPackage8").style.display  = "";
	}
}

function setSourceProperties(value) {

	if (value == "true") {

		document.getElementById("packageVersion").disabled = true;
		document.getElementById("packageBuildNumber").disabled = true;
		document.getElementById("packagePreviousPatchesIncluded").disabled = true;
		document.getElementById("packageDescription").disabled = true;

		document.getElementById("packageRequiredTargetPackageVersion").disabled = true;
	}
	else {
		document.getElementById("packageVersion").disabled = false;
		document.getElementById("packageBuildNumber").disabled = false;
		document.getElementById("packagePreviousPatchesIncluded").disabled = false;
		document.getElementById("packageDescription").disabled = false;

		document.getElementById("packageRequiredTargetPackageVersion").disabled = false;
	}
}

function submitForm() {        
	var useSourceProperties = document.form.refreshPropertiesDuringBuild[0].checked;
	var pkgTypeFull = document.form.packageReleaseType[0].checked;
	var ver = document.form.packageVersion.value;
	var build = document.form.packageBuildNumber.value;
	var jvm = document.form.packageRequiredJVMVersion.value;
	var targetver = document.form.packageRequiredTargetPackageVersion.value;

	if (pkgTypeFull) {

		// Don't require pkg properties if pulling from source
		if (!useSourceProperties) {
			if (( ver == null ) || ( ver == "" )) {
				alert("Version is required.");
				return false;
			} 

			if( !isVersionFormatValid(ver) ) {
				alert("Invalid package version "+ver+", the accepted format is #.#.#.#.###");
				return false;
			}

			if ( (!(build == null || build == "" )) && isNaN(parseInt(normalize(build))) ) {
				alert("Invalid Build Number (ex: 6).");
				return false;
			}
		}

		if (( jvm == null ) || ( jvm == "" )) {
			alert("Minimum Version of JVM is required.");
			return false;
		} 

		if ( !isJVMFormatValid(jvm) ) {
			alert("Invalid JVM version (ex: 1.2).");
			return false;
		}
	}
	else {

		// Don't require pkg properties if pulling from source
		if (!useSourceProperties) {
			if (( targetver == null ) || ( targetver == "" )) {
				alert("Target Package Version is required.");
				return false;
			} 

			if ( !isVersionFormatValid(targetver) ) {
				alert("Invalid Target Package Version (ex: 1.0).");
				return false;
			}
		}
	}

	return true;
}
</SCRIPT>

<TABLE width=100%>
	<TR>
		<TD class="menusection-Deployer">%value bundleName% > Packages > %value serverAliasName%:%value packageName% > Properties</TD>
	</TR>
</TABLE>

<TABLE width="100%">
<!- Save -> 
%ifvar action equals('saveProperties')%
	<!- All fields on form ->
	%invoke wm.deployer.gui.UIBundle:updateBundlePackageInfo%
	%include error-handler.dsp%
	%ifvar Refresh equals('true')%
	<script>
		// refresh Project left-frame 
		startProgressBar("Displaying new Project definition");
		if(is_csrf_guard_enabled && needToInsertToken) {
   		   parent.treeFrame.document.location.href = "bundle-list.dsp?projectName=%value -htmlcode projectName%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
		} else {
		   parent.treeFrame.document.location.href = "bundle-list.dsp?projectName=%value -htmlcode projectName%";
		}
	</script>
	%else%
	<script>
	
	// stop the progress bar that was started during the submit
		stopProgressBar(); 
	</script>
	%endif%	
	
	%ifvar Refresh equals('false')%
	<script>
		if(is_csrf_guard_enabled && needToInsertToken) {
   		   document.location.href = "define-component.dsp?projectName=%value -htmlcode projectName%&bundleName=%value -htmlcode bundleName%&serverAliasName=%value -htmlcode ../serverAlias%&packageName=%value -htmlcode packageName%&regExp=%value -htmlcode /regExp%&regExp2=%value -htmlcode /regExp2%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
		} else {
		   document.location.href = "define-component.dsp?projectName=%value -htmlcode projectName%&bundleName=%value -htmlcode bundleName%&serverAliasName=%value -htmlcode ../serverAlias%&packageName=%value -htmlcode packageName%&regExp=%value /regExp -urlencode%&regExp2=%value -htmlcode /regExp2%";
		}
	</script>
	%endif%	

	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%
</TABLE>

%invoke wm.deployer.gui.UIProject:getProjectInfo%

<!- projectName*, bundleName*, serverAlias, packageName* ->
%rename serverAliasName serverAlias -copy%
%invoke wm.deployer.gui.UIBundle:getBundlePackageInfo%

<TABLE width=100%>
	<TR>
		<TD colspan="2">
			<UL>
%ifvar /defineAuthorized equals('true')%
	%ifvar componentsOrFiles equals('true')%
				<LI><A HREF="define-component.dsp?projectName=%value -htmlcode projectName%&bundleName=%value -htmlcode bundleName%&serverAliasName=%value -htmlcode serverAliasName%&packageName=%value -htmlcode packageName%&mode=properties&bundleMode=%value -htmlcode bundleMode%">Select Components</a></LI>
		%ifvar bundleMode equals('Deploy')%
				<LI><A HREF="define-files.dsp?projectName=%value -htmlcode projectName%&bundleName=%value -htmlcode bundleName%&serverAliasName=%value -htmlcode serverAliasName%&packageName=%value -htmlcode packageName%&mode=properties">Select Files</a></LI>
		%endif%
	%endif%
%endif%

%ifvar /defineAuthorized equals('true')%
%ifvar /stopTriggers equals('selected')%
				<LI><A HREF="suspend-package-triggers.dsp?projectName=%value -htmlcode projectName%&bundleName=%value -htmlcode bundleName%&serverAliasName=%value -htmlcode serverAliasName%&packageName=%value -htmlcode packageName%&partialPackage=%ifvar componentsOrFiles equals('true')%true%else%false%endif%">Suspend Triggers</a></LI>
%endif%

%ifvar /stopAdapters equals('true')%
				<LI><A HREF="suspend-package-adapters.dsp?projectName=%value -htmlcode projectName%&bundleName=%value -htmlcode bundleName%&serverAliasName=%value -htmlcode serverAliasName%&packageName=%value -htmlcode packageName%&partialPackage=%ifvar componentsOrFiles equals('true')%true%else%false%endif%">Suspend Adapter Notifications</a></LI>
%endif%
%endif%
				<LI><A HREF="package-properties.dsp?projectName=%value -htmlcode projectName%&bundleName=%value -htmlcode bundleName%&serverAliasName=%value -htmlcode serverAliasName%&packageName=%value -htmlcode packageName%">Refresh this Page</a></LI>
			</UL>
		</TD>
	</TR>
	</TBODY>
</TABLE>


<TABLE width=100%>
	%comment%
	<FORM NAME="form" action="under-construction.dsp" method="POST">
	%endcomment%
	<FORM NAME="form" action="package-properties.dsp" method="POST">
		<INPUT type="hidden" name="projectName" value="%value projectName%">
		<INPUT type="hidden" name="bundleName" value="%value bundleName%">
		<INPUT type="hidden" name="serverAliasName" value="%value serverAliasName%">
		<INPUT type="hidden" name="serverAlias" value="%value serverAliasName%">
		<INPUT type="hidden" name="packageName" value="%value packageName%">
		<INPUT type="hidden" VALUE="saveProperties" name="action">

		<TR>
			<TD><IMG SRC="images/blank.gif" width=10></TD>
			<TD><TABLE class="tableForm">

				<TR>
					<TD class="heading" colspan=5>%value serverAliasName%:%value packageName% Properties</TD>
				</TR>

				<TR>
					<TD class="evenrow">Package Type</TD>
					<TD class="evenrowdata-l" colspan="2" nowrap>
					%ifvar /defineAuthorized equals('true')% 
						<INPUT onclick="setPackageType('full');" type="radio" name="packageReleaseType" value="full"
						%ifvar packageReleaseType equals('full')% checked %endif% > Full
						<INPUT onclick="setPackageType('partial');" type="radio" name="packageReleaseType" value="partial" 
						%ifvar packageReleaseType equals('partial')% checked %endif% > Patch
					%else%
						%ifvar packageReleaseType equals('full')% Full %else% Patch %endif% 
					%endif%
					</TD>
				</TR>

				<TR id="fullPackage2">
					<TD class="oddrow">Version</TD>
					<TD class="oddrowdata-l">
				%ifvar /defineAuthorized equals('true')% 
					<INPUT name="packageVersion" value="%value packageVersion%"></TD>
				%else% 	
					%value packageVersion%
				%endif%
					</TD>
				</TR>

				<TR id="fullPackage3">
					<TD class="evenrow">Build</TD>
					<TD class="evenrowdata-l" colspan="1">
				%ifvar /defineAuthorized equals('true')% 
					<INPUT name="packageBuildNumber" value="%value packageBuildNumber%"></TD>
				%else% 	
					%value packageBuildNumber%
				%endif%
					</TD>
				</TR>

				<TR id="fullPackage4">
					<TD class="oddrow">Patches Included</TD>
					<TD class="oddrowdata-l" colspan="1">
				%ifvar /defineAuthorized equals('true')% 
						<INPUT name="packagePreviousPatchesIncluded" 
							value="%value packagePreviousPatchesIncluded%">
				%else% 	
							%value packagePreviousPatchesIncluded%
				%endif%
					</TD>
				</TR>

				<TR id="fullPackage5">
					<TD class="evenrow">Brief Description</TD>
					<TD class="evenrowdata-l" colspan="2">
				%ifvar /defineAuthorized equals('true')% 
						<INPUT name="packageDescription" value="%value packageDescription%">
				%else% 	
						%value packageDescription%
				%endif%
					</TD>
				</TR>

				<TR id="upgradePackage2">
					<TD class="oddrow">Version of Target Package</TD>
					<TD class="oddrowdata-l" colspan="1">
				%ifvar /defineAuthorized equals('true')% 
						<INPUT name="packageRequiredTargetPackageVersion" 
							value="%value packageRequiredTargetPackageVersion%">
				%else% 	
							%value packageRequiredTargetPackageVersion%
				%endif%
					</TD>
				</TR>

				<TR id="fullPackage6">
					<TD class="heading" colspan=4>Recommendations for Target</TD>
				</TR>

				<TR id="fullPackage7">
					<TD class="evenrow">Version of Integration Server</TD>
					<TD class="evenrowdata-l">
				%ifvar /defineAuthorized equals('true')% 
						<INPUT name="packageRequiredISVersion" value="%value packageRequiredISVersion%">
				%else% 	
						%value packageRequiredISVersion%
				%endif%
					</TD>
				</TR>

				<TR id="fullPackage8">
					<TD class="oddrow">Minimum Version of JVM</TD>
					<TD class="oddrowdata-l" colspan="1">
				%ifvar /defineAuthorized equals('true')% 
						<INPUT name="packageRequiredJVMVersion" value="%value packageRequiredJVMVersion%"></td>
				%else% 	
						%value packageRequiredJVMVersion%
				%endif%
				</TR>

				<TR>
					<TD class="heading" colspan=4>Package Build Options</TD>
				</TR>

				<TR>
					<TD class="evenrow">Refresh Source Properties</TD>
					<TD colspan="2" class="evenrowdata-l">
					%ifvar /defineAuthorized equals('true')%
						<INPUT onclick="setSourceProperties('true');" type=radio name="refreshPropertiesDuringBuild" value="true" 
						%ifvar refreshPropertiesDuringBuild equals('true')% CHECKED %endif% >Yes
						<INPUT onclick="setSourceProperties('false');" type=radio name="refreshPropertiesDuringBuild" value="false"
						%ifvar refreshPropertiesDuringBuild equals('false')% CHECKED %endif% >No
					%else%
						%ifvar refreshPropertiesDuringBuild equals('true')% Yes %else% No %endif% 
					%endif%
					</TD>
				</TR>

				<TR>
					<TD class="heading" colspan=4>Package Deployment Options</TD>
				</TR>

				<TR>
					<TD class="oddrow">Action After Deployment</TD>
					<TD colspan="2" class="oddrowdata-l">
					%ifvar /defineAuthorized equals('true')%
						<INPUT type=radio name="actionOnDeploy" value="activate" 
						%ifvar actionOnDeploy equals('activate')% CHECKED %endif% >Activate
						<INPUT type=radio name="actionOnDeploy" value="install"
						%ifvar actionOnDeploy equals('install')% CHECKED %endif% >Install Only
						<INPUT type=radio name="actionOnDeploy" value="none"
						%ifvar actionOnDeploy equals('none')% CHECKED %endif% >Inbound Only					
					%else%
						%switch actionOnDeploy%
							%case 'activate'% Activate/Install
							%case 'install'% Install Only
							%case% No Action
						%endif% 
					%endif%
					</TD>
				</TR>

				<TR>
					<TD class="oddrow">Sync Document Types</TD>
					<TD colspan="2" class="oddrowdata-l">
					%ifvar /defineAuthorized equals('true')%
						<INPUT type=radio name="synchronizeDocumentTypes" value="new" 
						%ifvar synchronizeDocumentTypes equals('new')% CHECKED %endif% >New
						<INPUT type=radio name="synchronizeDocumentTypes" value="all"
						%ifvar synchronizeDocumentTypes equals('all')% CHECKED %endif% >All
						<INPUT type=radio name="synchronizeDocumentTypes" value="none"
						%ifvar synchronizeDocumentTypes equals('none')% CHECKED %endif% >None
					%else%
						%switch synchronizeDocumentTypes%
							%case 'new'% New 
							%case 'all'% All
							%case% None
						%endif%
					%endif%
					</TD>
				</TR>

				%ifvar /defineAuthorized equals('true')%
				<TR>
					<TD class="action" colspan="5">
						<INPUT class="data" name="submit2" type="submit" onclick="return submitForm()" value="Save"/>
					</TD>
				</TR>
				%endif%

			</TD></TABLE>
		</TR>
	</FORM>
</TABLE>
%endinvoke%
%endinvoke%

<script> 
setPackageType("%value packageReleaseType%");
setSourceProperties("%value refreshPropertiesDuringBuild%");
stopProgressBar();
</script> 

</BODY>
</HTML>
