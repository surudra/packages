<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<SCRIPT src="webMethods.js"></SCRIPT>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<BODY>

<SCRIPT language=JavaScript>

function migrateGlobalSettings()
{
	var host = document.myFormListAliases.host.value;

	if ( trim(host) == "" ) {
		alert("Host is required.");
		return false;
	} 

	var port = document.myFormListAliases.port.value;

	if ( trim(port) == ""  ) {
		alert("Port is required.");
		return false;
	} 
	if (isNaN(port) ) {
		alert("Port Number must be positive integer.");
		return false;
	} 

	var migrationUser = document.myFormListAliases.migrationUser.value;

	if ( trim(migrationUser) == "" ) {
		alert("User is required.");
		return false;
	} 

	var pass = document.myFormListAliases.password.value;

	if ( trim(pass) == "" ) {
		alert("Password is required.");
		return false;
	} 
	document.myFormListAliases.action = "migrate-global-settings.dsp?host="+host+"&port="+port+"&migrationUser="+migrationUser+"&password="+pass;
	document.myFormListAliases.actionName.value = "migrateGlobalSettings";
	document.myFormListAliases.submit();	
		
}

function onRepositoryAliases() 
{
	var name = document.myFormListAliases.host.value;

	if ( trim(name) == "" ) {
		alert("Host is required.");
		return false;
	} 

	name = document.myFormListAliases.port.value;

	if ( trim(name) == ""  ) {
		alert("Port is required.");
		return false;
	} 
	if (isNaN(name) ) {
		alert("Port Number must be positive integer.");
		return false;
	} 

	 name = document.myFormListAliases.migrationUser.value;

	if ( trim(name) == "" ) {
		alert("User is required.");
		return false;
	} 

	name = document.myFormListAliases.password.value;

	if ( trim(name) == "" ) {
		alert("Password is required.");
		return false;
	} 

//	alert(document.myFormGetAliases.pluginType.value);
//	alert(document.myFormGetAliases.pluginType.disabled);
	document.myFormListAliases.action = 	"list-repo-aliases.dsp";
	document.myFormListAliases.actionName.value = "listrepoaliases";
	document.myFormListAliases.submit();
}
function onListAliases() 
{
	var name = document.myFormListAliases.host.value;

	if ( trim(name) == "" ) {
		alert("Host is required.");
		return false;
	} 

	name = document.myFormListAliases.port.value;

	if ( trim(name) == ""  ) {
		alert("Port is required.");
		return false;
	} 
	if (isNaN(name) ) {
		alert("Port Number must be positive integer.");
		return false;
	} 

	 name = document.myFormListAliases.migrationUser.value;

	if ( trim(name) == "" ) {
		alert("User is required.");
		return false;
	} 

	name = document.myFormListAliases.password.value;

	if ( trim(name) == "" ) {
		alert("Password is required.");
		return false;
	} 

//	alert(document.myFormGetAliases.pluginType.value);
//	alert(document.myFormGetAliases.pluginType.disabled);
	document.myFormListAliases.action = 	"list-aliases.dsp";
	document.myFormListAliases.actionName.value = "listaliases";
	document.myFormListAliases.submit();
}

function showOrHideDiv(divElement)
{

	divValue = document.getElementById(divElement).style.display;
	//alert('adf' + divValue);
	if (divValue == 'none')
	{
		document.getElementById(divElement).style.display = 'block';
	}
	else
	{
		document.getElementById(divElement).style.display = 'none';	
	}
}

function listProjects()
{
       var name = document.myFormListAliases.host.value;

	if ( trim(name) == "" ) {
		alert("Host is required.");
		return false;
	} 

	name = document.myFormListAliases.port.value;

	if ( trim(name) == "" ) {
		alert("Port is required.");
		return false;
	} 

	 name = document.myFormListAliases.migrationUser.value;

	if ( trim(name) == "" ) {
		alert("User is required.");
		return false;
	} 

	name = document.myFormListAliases.password.value;

	if ( trim(name) == "" ) {
		alert("Password is required.");
		return false;
	} 

	document.myFormListAliases.action = 	"list-projects.dsp";
	document.myFormListAliases.actionName.value = "listprojects";
	document.myFormListAliases.submit();
}

function listTargetGroups()
{
       var name = document.myFormListAliases.host.value;

	if ( trim(name) == "" ) {
		alert("Host is required.");
		return false;
	} 

	name = document.myFormListAliases.port.value;

	if ( trim(name) == "" ) {
		alert("Port is required.");
		return false;
	} 

	 name = document.myFormListAliases.migrationUser.value;

	if ( trim(name) == "" ) {
		alert("User is required.");
		return false;
	} 

	name = document.myFormListAliases.password.value;

	if ( trim(name) == "" ) {
		alert("Password is required.");
		return false;
	} 

	document.myFormListAliases.action = 	"list-groups.dsp";
	document.myFormListAliases.actionName.value = "listTargetGroups";
	document.myFormListAliases.submit();
}

function enablePluginType()
{
	if(document.myFormListAliases.pluginType.disabled)
	{
		document.myFormListAliases.pluginType.disabled = false;
		document.myFormListAliases.listaliases.disabled = false;
	}
	else
	{
		document.myFormListAliases.pluginType.disabled = true;
		document.myFormListAliases.listaliases.disabled = true;
	}
}

</SCRIPT>



<TABLE width="100%">
	<TR>
		<TD class="menusection-DeployerTools" colspan="4"> Migrate Data(Side-by-Side Upgrade)
		</TD>
	</TR>

</TABLE>

<TABLE width="100%">

</TABLE>
<!- Determine if this user is empowered to project creation/copy stuff ->
%invoke wm.deployer.UIAuthorization:isAuthorized%
%endinvoke%

<TABLE width="100%">
	<BR>

	<TR>		
		<TD valign="top">
		
			<TABLE width="100%" class="tableForm">
				%ifvar /isAuth equals('true')% 
				<TR>
					<TD class="heading" colspan="2">Identify the Deployer from which to migrate data</TD>
				</TR>

				<FORM name="myFormListAliases" target="propertyFrame" method="POST" action="list-aliases.dsp">
	        <INPUT type="hidden" VALUE="" name="actionName">	 
				  <INPUT type="hidden" VALUE="IS" name="pluginType"/>
				 
				 <SCRIPT>resetRows();</SCRIPT>				
				<TR>
					<SCRIPT>writeTD('row-l', 'width="25%" style="text-align:right;"');</SCRIPT>* Host</TD>
					
					<SCRIPT>writeTD('row-l');swapRows();</SCRIPT> <input name="host" size="40"/>
					</TD>
				</TR>

				<TR>
					<SCRIPT>writeTD('row-l', 'width="25%" style="text-align:right;"');</SCRIPT>* Port</TD>
					
					<SCRIPT>writeTD('row-l');swapRows();</SCRIPT> <input name="port" size="40"/>
					</TD>
				</TR>
				<TR>
					<SCRIPT>writeTD('row-l', 'width="25%" style="text-align:right;"');</SCRIPT>* User</TD>
					
					<SCRIPT>writeTD('row-l');swapRows();</SCRIPT> <input name="migrationUser" size="40"/>
					</TD>
				</TR>
				<TR>
					<SCRIPT>writeTD('row-l', 'width="25%" style="text-align:right;"');</SCRIPT>* Password</TD>
					
					<SCRIPT>writeTD('row-l');swapRows();</SCRIPT> <input name="password" type="password" size="40"/>
					</TD>
				</TR>
				<TR>
					<SCRIPT>writeTD('row-l', 'width="25%" style="text-align:right;"');</SCRIPT>Page Size</TD>
					<SCRIPT>writeTD('row-l');swapRows();</SCRIPT>
								<P><SELECT size="1" name="pageSize" >
									<OPTION VALUE="5">5</OPTION>
									<OPTION VALUE="10">10</OPTION>
                  <OPTION VALUE="15" selected>15</OPTION>
                  <OPTION VALUE="20">20</OPTION>
                  <OPTION VALUE="25">25</OPTION>
                  <OPTION VALUE="30">30</OPTION>      
								</SELECT>
								</P>
							</TD>
				</TR>				
				</FORM>
				%endif%

		</TD>
	</TR>
</TABLE>

  <TABLE width="100%" class="action">
      <TR>
					<TD >					
						<INPUT type="button" onclick="return migrateGlobalSettings();" align="center" value="Migrate Default Settings" >
					</TD>
					
					<TD >					
						<INPUT type="button" onclick="return onListAliases();" align="center" name="listaliases" value="Migrate Server Aliases" >
					</TD>
          			<TD>
						   <INPUT type="button" align="center" onclick="return listTargetGroups();" value="Migrate Target Groups">
					</TD>
					<TD >
						<INPUT type="button" align="center" onclick="return listProjects();" value="Migrate Projects">
					</TD>
				</TR>
  </TABLE>

</BODY>
</HTML>
