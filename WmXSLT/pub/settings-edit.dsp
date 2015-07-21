<?xml version='1.0'?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title>XSLT - Transformer Factory Settings </title>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<meta http-equiv="Expires" content="-1">
    <link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css"></link>
    <script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
<script>

	function toggleOtherFactory() {
		var editableInput = document.getElementById("otherfactoryinput");
		var other = document.getElementById("TransformerFactoryOtherOption").selected;
		if(other) {
			editableInput.style.cssText = "display: table-row";
			var input = document.getElementById("TransformerFactoryInput").value;
			document.getElementById("TransformerFactory").value = input;
		} else {
			editableInput.style.cssText = "display: none";
			var input = document.getElementById("TransformerFactorySelect").value;
			document.getElementById("TransformerFactory").value = input;
		}
		return true;
	}

	function confirmEdit () {
		document.editform.submit();
		return true;
	}

</script>
</head>

<BODY onLoad="setNavigation('/WmXSLT/settings-edit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_WmXSLTpkg_Scrn', 'foo'); toggleOtherFactory();">
<TABLE width="100%">
<TR>
    <TD class="menusection-Settings" colspan="2">
    WmXSLT &gt;
    Transformer Factory Settings &gt;
    Edit </TD>
</TR>

<TR>
    <TD colspan="2">
        <UL>
            <LI><A HREF="solutions-xslt.dsp">Return to Transformer Factory Settings</A></LI>
        </UL>
    </TD>
</TR>

<TR>
    <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
    <TD>
<DIV class="position">

	%ifvar action equals('change')%
		%invoke wm.xslt.Admin:saveTransformerFactorySettings%
		<script>location.href="/WmXSLT/solutions-xslt.dsp";</script>
		%onerror%
		<table width="100%">
		<tr colspan="2">
			<td class="message" colspan="2">%value errorMessage%</td>
		</tr>
		<tr><td colspan="2">&nbsp;</td></tr>
		</table>
	  	%endinvoke wm.server.Admin:saveTransformerFactorySettings%
	%endif%

<TABLE class="tableView">

	<tr>
		<form name="editform" class="form" action="settings-edit.dsp" method="post" onSubmit="toggleOtherFactory();">
			%invoke wm.xslt.Admin:getTransformerFactorySettings%
			<table class="tableView">
				<TR>
					<TD class="heading" colspan=3>Transformer Factory Settings</TD>
				</TR>
				<tr>
					<td CLASS="oddrow" colspan=2>Transformer Factory</td>
				    <td CLASS="oddrow-1">
				    <select style="width:100%" id="TransformerFactorySelect" onChange="toggleOtherFactory();">
						%invoke wm.xslt.Admin:getAvailableTransformerFactoryClasses%
							%loop TransformerFactoryClasses%
								%ifvar TransformerFactoryClasses vequals(TransformerFactory)%
						    		<option value="%value TransformerFactoryClasses%" selected="true">%value TransformerFactoryClasses%</option>
						    		%rename TransformerFactory knownFactory -copy%
								%else%
						    		<option value="%value TransformerFactoryClasses%">%value TransformerFactoryClasses%</option>
								%endif%
					    	%endloop%
							%ifvar knownFactory -notempty%
						    	<option id="TransformerFactoryOtherOption" value="TransformerFactoryOther">Other</option>
						    %else%
						    	<option id="TransformerFactoryOtherOption" value="TransformerFactoryOther" selected="true">Other</option>
						    %endif%
				    	%end invoke wm.xslt.Admin:getAvailableTransformerFactoryClasses%
				    </select>
	  				</td>
				</tr>
				<tr id="otherfactoryinput">
					<td CLASS="space" colspan=2></td>
					<td CLASS="oddrow-1">
					<input id="TransformerFactoryInput" style="width:100%" type="text" value="%value TransformerFactory%"/>
					</td>
				</tr>

				<tr>
					<td valign="top" CLASS="evenrow" colspan=2>Transformer Factory Attributes</td>
					<td width="75%" CLASS="evenrow-1" ><TEXTAREA title="AttributeName=Value" style="width:100%" wrap="off" rows=13 cols=40 name="FactoryAttributes">%value FactoryAttributes%</TEXTAREA></td>
				</tr>
			  <TR>
				<TD class="action" colspan="3">
					  <INPUT type="hidden" id="TransformerFactory" name="TransformerFactory">
					  <INPUT type="hidden" name="action" value="change">
				  <INPUT class="button" type="submit" name="submit" value="Save Changes">
				</TD>
			  </TR>
			%endinvoke%
			</table>
		</form>
		</td>
	</tr>

</TABLE>
</DIV>
</TR>

</TABLE>

</BODY>
</HTML>
