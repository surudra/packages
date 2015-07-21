<html>
  <!-- Copyright (c) 2003, webMethods Inc.  All Rights Reserved. -->
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<link rel="stylesheet" type="text/css" href="webMethods.css">
<SCRIPT src="menu.js"></SCRIPT>

<style>
	body { border-top: 1px solid #97A6CB; }
	#stk {position:absolute; visibility:hidden;}
</style>
</head>

<SCRIPT language=JavaScript>
var ie5 = (document.getElementById && document.all);
var ns6 = (document.getElementById && !document.all);

var rightPos = 1;  // how much pixel before left
var bottomPos = 1; // how much pixel before bottom 

function statik(){
    	if(ie5){
        	pageYOffset = document.body.scrollTop;
		innerWidth = document.body.offsetWidth;
		innerHeight = document.body.offsetHeight;
	}
	if(ie5 || ns6){
        	statikLayer = document.getElementById('stk');
		statikLayer.style.left = 0 + rightPos;
		statikLayer.style.visibility = 'visible';
		statikLayer.style.top = (innerHeight - statikLayer.offsetHeight - bottomPos) + pageYOffset;
		setTimeout ('statik()', 10);
	}
}

var progressEnd = 7;						// set to number of progress <span>'s.
var progressColor = '#800080'; 	// set to progress bar color
var progressInterval = 500;			// set to time between updates (milli-seconds)

var progressAt = progressEnd;
var progressTimer;

function _progress_clear() {
	for (var i = 1; i <= progressEnd; i++) top.menu.document.getElementById('progress'+i).style.backgroundColor = 'transparent';
	progressAt = 0;
}

function _progress_start() {
	progressAt++;
	if (progressAt > progressEnd) _progress_clear();
	else document.getElementById('progress'+progressAt).style.backgroundColor = progressColor;
	progressTimer = setTimeout('_progress_start()',progressInterval);
}

function _startProgressBar() {
	//_stopProgressBar();
	//top.menu.document.all["progressBar"].style.display  = "inline";
	//_progress_start();
}

function _stopProgressBar() {
	//clearTimeout(progressTimer);
	//_progress_clear();
	//top.menu.document.all["progressBar"].style.display  = "none";
}
</script>

<body class="menu" onload="statik();">

	<table width="100%" cellspacing=0 cellpadding=1 border=0>
		<tr>
			<td class="menusection-Deployer">
				<img src="images/blank.gif" width="2" height="1" border="0">Deployer
			</td>
		</tr>

		%scope param(itemName='Projects')%
		<tr>
			<td id="%value itemName%" class="menuitem"
				onmouseover="menuMouseOver(this, '%value itemName%');"
				onmouseout="menuMouseOut(this);"
				onclick="document.all['a%value itemName%'].click();"
				<nobr>
				<img valign="middle" src="images/blank.gif" width="2" height="1" border="0">
				<img valign="middle" id="%value itemName%" name="%value itemName%" src="images/blank.gif" height="8" width="8" border="0">

				<a id="a%value itemName%" target="rightFrame" href="project-manager.dsp"
					onclick="return moveArrow('%value itemName%')" >
				<span class="menuitemspan">%value itemName%</span></a>
				</nobr>
			</td>
		</tr>
		%endscope%
		
		<tr>
			<td id="Repository" class="menuitem"
				onmouseover="menuMouseOver(this, 'Repository');"
				onmouseout="menuMouseOut(this);"
				onclick="document.all['aRepository'].click();"
				<nobr>
				<img valign="middle" src="images/blank.gif" width="2" height="1" border="0">
				<img valign="middle" id="Repository" name="Repository" src="images/blank.gif" height="8" width="8" border="0">

				<a id="aRepository" target="rightFrame" href="remote-repository-manager.dsp"
					onclick="_startProgressBar(); return moveArrow('Repository')" >
				<span class="menuitemspan">Repository</span></a>
				</nobr>
			</td>
		</tr>

		%scope param(itemName='Settings')%
		<tr>
			<td id="%value itemName%" class="menuitem"
				onmouseover="menuMouseOver(this, '%value itemName%');"
				onmouseout="menuMouseOut(this);"
				onclick="document.all['a%value itemName%'].click();"
				<nobr>
				<img valign="middle" src="images/blank.gif" width="2" height="1" border="0">
				<img valign="middle" id="%value itemName%" name="%value itemName%" src="images/blank.gif" height="8" width="8" border="0">

				<a id="a%value itemName%" target="rightFrame" href="settings-manager.dsp"
					onclick="return moveArrow('%value itemName%')" >
				<span class="menuitemspan">%value itemName%</span></a>
				</nobr>
			</td>
		</tr>
		%endscope%
		
		%scope param(itemName='PasswordStore')%
		<tr>
			<td id="%value itemName%" class="menuitem"
				onmouseover="menuMouseOver(this, '%value itemName%');"
				onmouseout="menuMouseOut(this);"
				onclick="document.all['a%value itemName%'].click();"
				<nobr>
				<img valign="middle" src="images/blank.gif" width="2" height="1" border="0">
				<img valign="middle" id="%value itemName%" name="%value itemName%" src="images/blank.gif" height="8" width="8" border="0">

				<a id="a%value itemName%" target="rightFrame" href="passstore-manager.dsp"
					onclick="return moveArrow('%value itemName%')" >
				<span class="menuitemspan">Password Store</span></a>
				</nobr>
			</td>
		</tr>
		%endscope%

		<tr>
			<td class="menuseparator"><img src="images/blank.gif" width="3" height="3" border="0"></td>
		</tr>

	

		<tr>
			<td class="menusection-DeployerServers">
				<img src="images/blank.gif" width="2" height="1" border="0">Servers
			</td>
		</tr>



		%scope param(itemName='Servers')%
		<tr>
			<td id="%value itemName%" class="menuitem"
				onmouseover="menuMouseOver(this, '%value itemName%');"
				onmouseout="menuMouseOut(this);"
				onclick="document.all['a%value itemName%'].click();"
				<nobr>
				<img valign="middle" src="images/blank.gif" width="2" height="1" border="0">
				<img valign="middle" id="%value itemName%" name="%value itemName%" src="images/blank.gif" height="8" width="8" border="0">

				<a id="a%value itemName%" target="rightFrame" href="remote-server-manager.dsp"
					onclick="_startProgressBar(); return moveArrow('%value itemName%')" >
				<span class="menuitemspan">IS & TN</span></a>
				</nobr>
			</td>
		</tr>
		%endscope%




%invoke wm.deployer.gui.UIPlugin:listPlugins%
	%loop plugins%
		<tr>
			<td nowrap id="%value pluginType%" class="menuitem"
				onmouseover="menuMouseOver(this, '%value pluginType%');"
				onmouseout="menuMouseOut(this);"
				onclick="document.all['a%value pluginType%'].click();"
				<nobr>
				<img valign="middle" src="images/blank.gif" width="2" height="1" border="0">
				<img valign="middle" id="%value pluginType%" name="%value pluginType%" src="images/blank.gif" height="8" width="8" border="0">

				<a id="a%value pluginType%" target="rightFrame" href="plugin-server-manager.dsp?pluginType=%value -htmlcode pluginType%&pluginLabel=%value -htmlcode pluginLabel%"
					onclick="_startProgressBar(); return moveArrow('%value pluginType%')">
				<span class="menuitemspan">%value pluginLabel%</span></a>
				</nobr>
			</td>
		</tr>
	%endloop%
%endinvoke%

<tr>
			<td class="menuseparator"><img src="images/blank.gif" width="3" height="3" border="0"></td>
		</tr>

		<tr>
			<td class="menusection-Server">
				<img src="images/blank.gif" width="2" height="1" border="0">Target Groups
			</td>
		</tr>

%scope param(itemName='TargetGroup')%
		<tr>
			<td id="%value itemName%" class="menuitem"
				onmouseover="menuMouseOver(this, '%value itemName%');"
				onmouseout="menuMouseOut(this);"
				onclick="document.all['a%value itemName%'].click();"
				<nobr>
				<img valign="middle" src="images/blank.gif" width="2" height="1" border="0">
				<img valign="middle" id="%value itemName%" name="%value itemName%" src="images/blank.gif" height="8" width="8" border="0">

				<a id="a%value itemName%" target="rightFrame" href="targetIS-group-manager.dsp?pluginType=IS"
					onclick="_startProgressBar(); return moveArrow('%value itemName%')" >
				<span class="menuitemspan">IS & TN</span></a>
				</nobr>
			</td>
		</tr>
		%endscope%

%invoke wm.deployer.gui.UIPlugin:listPlugins%
	%loop plugins%
		<tr>
			<td nowrap id="%value pluginType%1" class="menuitem"
				onmouseover="menuMouseOver(this, '%value pluginType%1');"
				onmouseout="menuMouseOut(this);"
				onclick="document.all['a%value pluginType%1'].click();"
				<nobr>
				<img valign="middle" src="images/blank.gif" width="2" height="1" border="0">
				<img valign="middle" id="%value pluginType%1" name="%value pluginType%1" src="images/blank.gif" height="8" width="8" border="0">

				<a id="a%value pluginType%1" target="rightFrame" href="target-group-manager.dsp?pluginType=%value -htmlcode pluginType%&pluginLabel=%value -htmlcode pluginLabel%&action=default"
					onclick="_startProgressBar(); return moveArrow('%value pluginType%1')">
				<span class="menuitemspan">%value pluginLabel%</span></a>
				</nobr>
			</td>
		</tr>
	%endloop%
%endinvoke%

<tr>
			<td class="menuseparator"><img src="images/blank.gif" width="3" height="3" border="0"></td>
		</tr>
		<tr>
			<td class="menusection-Logs">
				<img src="images/blank.gif" width="2" height="1" border="0">Logs
			</td>
		</tr>
%scope param(itemName='Audit')%
		<tr>
			<td id="%value itemName%" class="menuitem"
				onmouseover="menuMouseOver(this, '%value itemName%');"
				onmouseout="menuMouseOut(this);"
				onclick="document.all['a%value itemName%'].click();"
				<nobr>
				<img valign="middle" src="images/blank.gif" width="2" height="1" border="0">
				<img valign="middle" id="%value itemName%" name="%value itemName%" src="images/blank.gif" height="8" width="8" border="0">

				<a id="a%value itemName%" target="rightFrame" href="audit-log.dsp"
					onclick="return moveArrow('%value itemName%')" >
				<span class="menuitemspan">%value itemName%</span></a>
				</nobr>
			</td>
		</tr>
%endscope%

		
				
		<tr>
			<td class="menuseparator"><img src="images/blank.gif" width="3" height="3" border="0"></td>
		</tr>
		
	  <tr>
			<td class="menusection-DeployerTools">
				<img src="images/blank.gif" width="2" height="1" border="0">Tools
			</td>
		</tr>


		%scope param(itemName='Import')%
		<tr>
			<td id="%value itemName%" class="menuitem"
				onmouseover="menuMouseOver(this, '%value itemName%');"
				onmouseout="menuMouseOut(this);"
				onclick="document.all['a%value itemName%'].click();"
				<nobr>
				<img valign="middle" src="images/blank.gif" width="2" height="1" border="0">
				<img valign="middle" id="%value itemName%" name="%value itemName%" src="images/blank.gif" height="8" width="8" border="0">

				<a id="a%value itemName%" target="rightFrame" href="import-project.dsp"
					onclick="return moveArrow('%value itemName%')" >
				<span class="menuitemspan">Import Build</span></a>
				</nobr>
			</td>
		</tr>
		%endscope%

		%scope param(itemName='Migrate')%
		<tr>
			<td id="%value itemName%" class="menuitem"
				onmouseover="menuMouseOver(this, '%value itemName%');"
				onmouseout="menuMouseOut(this);"
				onclick="document.all['a%value itemName%'].click();"
				<nobr>
				<img valign="middle" src="images/blank.gif" width="2" height="1" border="0">
				<img valign="middle" id="%value itemName%" name="%value itemName%" src="images/blank.gif" height="8" width="8" border="0">

				<a id="a%value itemName%" target="rightFrame" href="migrate-project-manager.dsp"
					onclick="return moveArrow('%value itemName%')" >
				<span class="menuitemspan">Migrate Data</span></a>
				</nobr>
			</td>
		</tr>
		%endscope%

		%scope param(itemName='Export To Project Automataor')%
		<tr>
			<td id="%value itemName%" class="menuitem"
				onmouseover="menuMouseOver(this, '%value itemName%');"
				onmouseout="menuMouseOut(this);"
				onclick="document.all['a%value itemName%'].click();"
				<nobr>
				<img valign="middle" src="images/blank.gif" width="2" height="1" border="0">
				<img valign="middle" id="%value itemName%" name="%value itemName%" src="images/blank.gif" height="8" width="8" border="0">

				<a id="a%value itemName%" target="rightFrame" href="exportToProjectAutomator.dsp"
					onclick="return moveArrow('%value itemName%')" >
				<span class="menuitemspan">Export to Project Automator</span></a>
				</nobr>
			</td>
		</tr>
		%endscope%
<tr>		<td class="menuseparator"><img src="images/blank.gif" width="3" height="3" border="0"></td></tr></table>
<SCRIPT>
	window.open("project-manager.dsp", "rightFrame");
</SCRIPT>
<div style="height=0; width=0">
<form name="urlsaver">
%comment%
<input type="hidden" name="helpURL" value="doc/OnlineHelp/WmDeployer.htm">
%endcomment%
<input type="hidden" name="helpURL" value="under-construction.dsp">
</form>
</div>

<!-- Progress Bar -->
<div id="stk">
<table width="100%" id="progressBar" style="display:none" align="center" border="0">
<TR> <TD align="center"><div id="resolve" style="visibility:hidden">This process may take several seconds.</div></TD> </TR>
<TR> <TD id="progressTitle" align="center">Please wait... </TD> </TR>
<tr><td>
<div style="font-size:6pt;padding:1px;border:solid black 1px">
<span id="progress1">&nbsp; &nbsp;</span>
<span id="progress2">&nbsp; &nbsp;</span>
<span id="progress3">&nbsp; &nbsp;</span>
<span id="progress4">&nbsp; &nbsp;</span>
<span id="progress5">&nbsp; &nbsp;</span>
<span id="progress6">&nbsp; &nbsp;</span>
<span id="progress7">&nbsp; &nbsp;</span>
</div> </td></tr>
</table>
</div>

<!-- Hidden input field to start progress Bar -->
<INPUT type="hidden" id="_startProgressBar" onclick="_startProgressBar();">
<INPUT type="hidden" id="_stopProgressBar" onclick="_stopProgressBar();">

</body>
</html>
