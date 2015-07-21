<html>
<head>
<!-- Copyright (c) 2005, webMethods Inc.  All Rights Reserved. -->
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<title>webMethods Deployer Progress Report</title> 
<link rel="stylesheet" type="text/css" href="webMethods.css">
<style> body { border-top: 1px solid black; } </style>
<script src="webMethods.js"></script>
</head>

<script>
  function submitProgressForm()
  {
	  	document.progressForm.submit();
  }
  </script>
<SCRIPT language=JavaScript>

    window.setInterval("submitProgressForm()",10*1000);
                              
</SCRIPT>

<TABLE width="100%">
	<TR>
		<TD class="menusection-DeployerTools" colspan="4"> Progress Report
		</TD>
	</TR>

</TABLE>

<FORM NAME="progressForm">
<table width="100%">
<input type="hidden" name="type" value="%value type%" />
<input type="hidden" name="projectName" value="%value projectName%" />
<input type="hidden" name="releaseName" value="%value releaseName%" />
<input type="hidden" name="deploymentName" value="%value deploymentName%" />
	<tr>
		<td><img src="images/blank.gif" height=10 width=10></td>
	</tr>
	
	<td>
	<table width="100%">		
		<tr>
			<td class="heading" colspan=4>Updates</td>
		</tr>
	
    %invoke wm.deployer.gui.UIProgress:getProgressUpdates%
      %loop progressUpdates% 
            				<SCRIPT>swapRows();</SCRIPT>      
							<tr>
							<SCRIPT>writeTD('rowdata', 'style="text-align:left;"');</SCRIPT> 
            				 %value progressUpdate%
							 </td>
							 </tr>
      %endloop progressUpdates%
    %endinvoke%    	
	</table>
	</td>
</table>
</FORM>
</body>
</html>
