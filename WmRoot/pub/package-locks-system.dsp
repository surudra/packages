<html>
	<head>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<meta http-equiv="Expires" content="-1">
		<title>
			Integration Server Packages
		</title>
		<link rel="stylesheet" type="text/css" href="webMethods.css">
		<script src="webMethods.js.txt"></script>
		<script Language="JavaScript">
		function writeTag(val)
		{
		var str="System Locks";
		var aStr="<a href=\"package-locks-details.dsp?node_nsName="+val+"&returnURL=package-locks-system.dsp&returnName=";
	  w(aStr);
	  w(encodeURI(str));
	  w("\">");
    }
    </script>
	</head>
	<body onLoad="setNavigation('package-list.dsp', 'doc/OnlineHelp/WmRoot.htm#CS_Packages_Mgmt.htm');">
		<table width="100%">
			<tr>
				<td class="menusection-Packages" colspan=2>
					Packages
					&gt; Management
					&gt; Locked Elements
					&gt; System Locks</td>
			</tr>

			<tr>
				<td colspan=2>
					<ul>
							<li><a href="package-locks.dsp">Return to Locked Elements</a></li>
					</ul>
				</td>
			</tr>
			<tr>
				<td><img src="images/blank.gif" height=10 width=10></td>
				<td width=100%>
					%invoke wm.server.ns.adminui:getLockedNodesForUser%
						<table width=100%>
							<tr>
								<td class="heading" colspan=4>Locked by System</td>
							</tr>
							<tr>
								<td class="oddcol-l">Locked Element</td>
								<td class="oddcol-l">Host</td>
							</tr>
							<script>resetRows(); var rowcount=0;</script>

							%loop -struct SYSTEM_LOCKS%
							<tr>
								<script>writeTD("rowdata-l");</script>
									<script>writeTag("%value -urlencode $key%");</script>%value $key%</a>
								</td>
								<script>writeTD("row-l");</script>
									%value HOST%
								</td>
							</tr>
							<script>swapRows(); rowcount++; </script>
							%endloop%

							<script>
								if(rowcount == 0)
								{
									document.write("<tr><td class=evenrow-l colspan=4>No Elements locked by System</td></tr>");
								}
							</script>

						</table>

					%endinvoke%
				</td>
			</tr>
		</table>
	</body>
</html>
