<HTML>
<HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


%include webMethods.css%
</HEAD>

<BODY>



<TABLE width="100%"><TR><TD>
<TABLE width="100%">

<tr><td class="title" colspan=2>Logging</td></tr>

<FORM name="logformstats" action="stats-logging.dsp" method="POST">
<INPUT type="hidden" name="log" value="xxx">
<tr><td class="action" colspan=2>
    <INPUT type="button" value="View server log" onclick="document.logformstats.log.value='server'; document.logformstats.submit();">
    <INPUT type="button" value="View session log" onclick="document.logformstats.log.value='session'; document.logformstats.submit();">
    <INPUT type="button" value="View error log" onclick="document.logformstats.log.value='error'; document.logformstats.submit();">
  </td></tr>

</FORM>


</TABLE>
</TD></TR></TABLE>
<table width=100%><tr><td>
%invoke wm.server.query:getLog%
<tr class="title"><td><code>%value logFile%.log</code></td></tr>
<tr><td class="coltext">
<pre>
%value logText%
</pre>
</td></tr>
</table>

</BODY>



</HTML>
