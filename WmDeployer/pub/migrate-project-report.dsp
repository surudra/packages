<html>
<head>
<!-- Copyright (c) 2005, webMethods Inc.  All Rights Reserved. -->
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<title>webMethods Deployer</title> 
<link rel="stylesheet" type="text/css" href="webMethods.css">
<style> body { border-top: 1px solid black; } </style>
<script src="webMethods.js"></script>
</head>


<TABLE width="100%">
	<TR>
		<TD class="menusection-DeployerTools" colspan="4"> Project Migration Report
		</TD>
	</TR>

</TABLE>

<FORM NAME="progressForm">
<table width="100%">
	<tr>
		<td><img src="images/blank.gif" height=10 width=10></td>
	</tr>
	
	<td>
	<table width="100%">		
		<tr>
			<td class="heading" colspan=4>Migration Updates</td>
		</tr>

    %invoke wm.deployer.gui.UIUpgrade:getProjectMigrationUpdates%
      %loop progressUpdates% 
            				<SCRIPT>swapRows();</SCRIPT>      
            				 %value progressUpdate encode(none)%
					           
      %endloop progressUpdates%
    %endinvoke%    	
	</table>
	</td>
</table>
</FORM>
</body>
</html>
