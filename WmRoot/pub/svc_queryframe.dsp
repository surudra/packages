<html>
<head>
<META http-equiv="Content-Type" content="text/html;charset=UTF-8">
<link href="webMethods.css" type=text/css rel=stylesheet>
<title>Integration Server</title>
<script language="JavaScript1.3">
	function refreshSearch() {
		document.logform.action = "svc_queryframe.dsp"
		document.logform.target = "query"
		document.logform.submit();			// Submit the page
	}
	var today = new Date();
	var thisMonth = today.getMonth(); 
	var thisYear = today.getFullYear();
	var thisDate = today.getDate();
	var headerExist = false;
	function openCalendar( which ) 
	{
		window.open( "calendar.dsp?month="+thisMonth+"&year="+thisYear+"&date="+thisDate
			+"&which="+escape(which), "calendar", "width=600,height=350,resizable=yes" );
	}
	function getTodayDate() {
		return thisYear + "-" + thisMonth + "-" + thisDate;
	}

</script>
<script src="webMethods.js"></script>
</head>

<body>
	<table width="100%">
	
	<td class="menusection-Server" colspan=6>Monitor &gt;
			Services &gt;
			Service Query &nbsp;
	</td>
	<td valign=top>
	<tr>
	<tr>
		<table>
		<tr>
		<td class=heading colspan=2>Find services:</td>

		<form name="logform" action="svc_resultframe.dsp" target="result" method=post>
			
			<tr>
			<td class=oddrow>Server Name</td>
			<td class=oddrow-l><input name="qserver"> Exact<input type="checkbox" name="qservercheck"></td>
			</tr>

			<tr>
			<td class=evenrow>Service Name</td>
			<td class=evenrow-l><input name="qservicename"> Exact<input type="checkbox" name="qservicenamecheck"></td>
			</tr>

			<tr>
			<td class=oddrow>Service Status</td>
			<td class=oddrow-l>
				<select name="qstatus">
					<option value="" selected></option>
					<option value="1">Started</option>
					<option value="2">Completed</option>
					<option value="4">Failed</option>
					<option value="32">Cached</option>
				</select>
			</td>
			</tr>

			<tr>
			<td class=evenrow>Context ID</td>
			<td class=evenrow-l><input name="qcid"></td>
			</tr>

			<tr>
			<td class=oddrow>User ID</td>
			<td class=oddrow-l><input name="quser"></td>
			</tr>

			<tr>
			<td class=evenrow>Timestamp</td>
			<td class=evenrow-l>
				<select name="qdate">
			 		<option value="" selected></option>
					<option value="Today">Today</option>
					<option value="Yesterday">Yesterday</option>
					<option value="In the last 7 days">In the last 7 days</option>
					<option value="Last week">Last week</option>
					<option value="This week">This week</option>
					<option value="Last month">Last month</option>
					<option value="This month">This month</option>
					<option value="Year to date">Year to date</option>
				</select>
				<br>
				<i> or </i>
				<br>
				<input name="qfromdate">
				<a href="javascript:openCalendar('From Creation Date');">From:</a>
				<br>
				<input name="qtodate">
				<a href="javascript:openCalendar('To Creation Date');">To:</a>
				<br>
				YYYY-MM-DD HH:MM:SS
			</td>
			</tr>
			
			<tr>
			<td class=oddrow>Maximum Results</td>
			<td class=oddrow-l><input name="qmaxresults" size="5" value="100"></td>
			</tr>

		<tr>
		<td class=action colspan=2><INPUT type=submit value="Find"></td>
		</tr>
		
		</form>	
		</table>
	</table>
</body>
</html>
