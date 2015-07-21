<html>
<head>
<!-- Copyright (c) 2005, webMethods Inc.  All Rights Reserved. -->
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<title>About webMethods Deployer</title> 
<link rel="stylesheet" type="text/css" href="webMethods.css">
<style> body { border-top: 1px solid black; } </style>
<script src="webMethods.js"></script>
</head>

<table width="100%">
	<tr>
		<td><img src="images/blank.gif" height=10 width=10></td>
	</tr>

	<td>
		<img src="images/blank.gif" height=10 width=10>
	</td>
	<td>
	<table width="100%" >
		<tr>
			<td class="heading" colspan=4>Copyright</td>
		</tr>
		<tr class="evenrow-l">
          <td valign="top" class="evenrow-l" colspan="2">
			<table class="tableInline" border="0" width="100%"  cellspacing="0px" cellpadding="0px">
                 <tr>
                    <td valign="top" ><IMG SRC="images/blank.gif" height=0 width=7><img src="/WmRoot/images/SAG_BlueFlag_100x36.png" border="0">&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    <td>
      	            <b>webMethods Deployer</b>
					<br>
					<font style="font-family: trebuchet ms;">Copyright &copy; 2004 - 2014 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and or/its affiliates and/or their licensors.
      	<br><br>
	     The name Software AG and all Software AG product names are either trademarks or registered trademarks of Software AG and/or Software AG USA Inc. and/or its subsidiaries and or/its affiliates and/or their licensors. Other company and product names mentioned herein may be trademarks of their respective owners. 	
	     <br><br>
	     Detailed information on trademarks and patents owned by Software AG and/or its subsidiaries is located at <a href="http://documentation.softwareag.com/legal/">http://documentation.softwareag.com/legal/</a>.
	     <br><br>
	     This software may include portions of third-party products. For third-party copyright notices and license terms, please refer to "License Texts, Copyright Notices and Disclaimers of Third Party Products". This document is part of the product documentation, located at <a href="http://documentation.softwareag.com/legal/">http://documentation.softwareag.com/legal/</a> and/or in the root installation directory of the licensed product(s).
	     <br><br>
	     Use, reproduction, transfer, publication or disclosure is prohibited except as specifically provided for in your License Agreement with Software AG.	
	</font><br>      	
				</td>  	
		       </tr>
			</table>
		</td>
       </tr>		
		<tr>
			<td class="heading" colspan=4>Product Information</td>
		</tr>

		<tr>
			<td class="oddrow" width="20%">Name</td>
			<td class="oddrowdata-l" colspan=3> webMethods Deployer </td>
		</tr>

%scope param(package='WmDeployer')%
%invoke wm.deployer.Wrapper:getPackageInfo%
		<tr>	    
			<td class="evenrow">Version</td>
			<td class="evenrowdata-l" colspan=3>%value version%</td>
		</tr>

		<tr>	    
			<td class="oddrow">Build</td>
			<td class="oddrowdata-l" colspan=3>%value build%</td>
		</tr>

		<tr>	    
			<td class="evenrow">Patches Applied</td>
			<td class="evenrowdata-l" colspan=3>%value patch_nums%</td>
		</tr>
%endscope%

		<tr>
			<td class="heading" colspan=4>Environment</td>
		</tr>

		<tr>
			%invoke wm.deployer.Wrapper:getCurrentUser%
			<td class="oddrow" valign=top>Current User</td>
			<td class="oddrowdata-l" colspan=3>%value username%&nbsp;</td>
			%endinvoke%
		</tr>

		<tr>
			<td class="evenrow" valign=top>Web Host</td>
			<td class="evenrowdata-l" colspan=3>
				<a href="/WmRoot/server-environment.dsp">webMethods Integration Server</a> running on %sysvar host% at port %sysvar property(watt.server.port)% </td>
		</tr>
	</table>
	</td>
</table>
</body>
</html>
