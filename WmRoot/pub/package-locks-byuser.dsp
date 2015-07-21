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
		var str="Locked Elements";
		var aStr="<a href=\"package-locks-details.dsp?node_nsName="+val+"&returnURL=package-locks.dsp&returnName=";
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
					&gt; By User</td>
			</tr>

			%ifvar action equals('unlock')%
				%invoke wm.server.ns.adminui:unLockMultipleNodes%
						<tr>
							<td class="message" colspan=2>
								%value none message%
							</td>
						</tr>
				%endinvoke%
			%endif action%

			<tr>
				<td colspan=2>
					<ul>
						%ifvar mode equals('edit')%
							<li><a href="package-locks-byuser.dsp">Return to Locked Elements By User</a></li>
						%else%
							<li><a href="package-locks.dsp">Return to Locked Elements</a></li>
							<li><a href="package-locks-byuser.dsp?mode=edit">Unlock Elements</a></li>
						%endif%
					</ul>
				</td>
			</tr>
			<tr>
				<td><img src="images/blank.gif" height=10 width=10></td>
				<td width=100%>
					%invoke wm.server.ns.adminui:getLockedNodesForAllUsers%

						%ifvar ../mode equals('edit')%
							<form method="POST" name=unlockNodes action="package-locks-byuser.dsp">
							<input type="hidden" name="action" value="unlock">
						%endif%

						%loop byUser%
						<table width=100%>
							<tr>
								<td class="heading" colspan=4>Locked by %value USER_NAME%</td>
							</tr>
							<tr>
								%ifvar ../../mode equals('edit')%
									<td class="oddcol">Unlock</td>
								%endif%
								<td class="oddcol-l">Locked Element</td>
								<td class="oddcol-l">Host</td>
							</tr>
							<script>resetRows(); var rowcount=0;</script>

							%loop -struct USER_LOCKS%
							<tr>
								%ifvar ../../mode equals('edit')%
									<script>writeTD("rowdata");</script>
										<input type="checkbox" name="unlock" value="%value $key%">
									</td>
								%endif%
								<script>writeTD("rowdata-l");</script>
									%ifvar ../../mode equals('edit')%
										%value $key%
									%else%
										<script>writeTag("%value -urlencode $key%");</script>%value $key%</a>
									%endif%
								</td>
								<script>writeTD("row-l");</script>
									%value HOST%
								</td>
							</tr>
							<script>swapRows(); rowcount++; </script>
							%endloop%

							<script>
								if(rowcount == 0)
									document.write("<tr><td class=evenrow-l colspan=4>No Elements locked by %value USER_NAME%</td></tr>");
							</script>

						</table>
						<br>
						%endloop%

						<table width=100%>
						%ifvar ../mode equals('edit')%
							<tr>
								<td class=action colspan=4>
									<input type=submit name=submit value="Unlock Selected Elements">
								</td>
							</tr>
							</form>
						%endif%
						</table>


					%endinvoke%
				</td>
			</tr>
		</table>
	</body>
</html>
