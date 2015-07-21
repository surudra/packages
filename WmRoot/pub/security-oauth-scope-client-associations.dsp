<html>

<head>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">



<title>ServerUI</title>
<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
<base target="_self">
<style>
  .listbox  { width: 100%; }
</style>
</head>
<script src="client.js.txt"></script>
<script src="oauth.js.txt"></script>
<script src="webMethods.js.txt"></script>

<BODY class="main" onbeforeunload="checkDirty();" onLoad="setNavigation('security-oauth-tokens.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_OAuthAssociateScopesToClientsScrn');">


<TABLE width=100% >
  <TR>
    <TD class="menusection-Security" colspan=2>Security &gt; OAuth &gt; Scope Management &gt; Associate Scopes to Clients</TD>
  </TR>

	 %ifvar action equals('update')%
    	%invoke wm.server.oauth:updateScopeClientAssociations%
        	%ifvar message%
      			<TR><TD colspan="2">&nbsp;</TD></TR>
      			<TR><TD class="message" colspan="2">%value message%</TD></TR>
        	%endif%
        	%onerror%
				<TR><TD colspan="2">&nbsp;</TD></TR>
				<TR><TD class="message" colspan=2>%value errorMessage%</TD></TR>
    	%endinvoke%
	%endif%

	 <TR>
       <TD colspan="2">
        <UL>
          <LI><A HREF="security-oauth-scope.dsp">Return to Scope Management</A></LI>
        </UL>
      </TD>
    </TR>
    
   
<TR>
	 <TD>	  &nbsp; </TD>
	<TD>
   <TABLE class="tableForm" width="100%" %ifvar edit% style="display:none"%endif%>
   
    <TR>
      <TD width="50%" style="padding: 0;">
        <DIV align="center">
          <CENTER>

			<form id="form" name="form" method="POST" action="security-oauth-scope-client-associations.dsp" >
			<input type="hidden" name="action" value="nothing">

  			<TABLE class="tableForm" width="100%">
    			<TR>
      				<TD class="title">Scopes</TD>
   				</TR>
    
    			<TR>
      				<TD class="evenrow">
        				<TABLE class="tableInline" width="100%" cellpadding="0" cellspacing="0">
          					<TR>
            					<TD><img border="0" src="images/blank.gif" width="5" height="5"></TD>
            					<TD><img border="0" src="images/blank.gif" width="5" height="5"></TD>
          					</TR>
          					<TR>
            					<TD align="left">
              						<TABLE class="tableInline" width="100%">
										<TR>
                  							<TD class="evenrow" nowrap align="right">Select Scope:</TD>
                  							<TD class="evenrow" width="100%" align=right>
                  								<select class="listbox" onchange="changeScope(this.options[this.selectedIndex].value);" size="1" name="scopes">
          										<option selected>---none---</option>
										        </select>
										    </TD>
										</TR>
										<TR><TD class="evenrow" colspan="3" align="right"><font style="font-size: 85%;">&nbsp;</font></TD></td></TR>
              					  </TABLE>
            				 	</TD>
            				 	<TD>  </TD>
          					</TR>
          					<TR>
            					<TD><img border="0" src="images/blank.gif" width="5" height="5"></TD>
            					<TD><img border="0" src="images/blank.gif" width="5" height="5"></TD>
          					</TR>
        				</TABLE>
      				</TD>
    			</TR>
    			<TR>
      				<TD class="oddrow">
        				<DIV align="center">
        				<TABLE width="100%">
          					<TR>
            					<TD width="50%" class="grouping-positive" valign="bottom" align="center">
              						Clients associated with Scope<br>
              						<SELECT class="listbox" onchange="unselect(this, availableclientsList, memberscopesList, availablescopesList);changeSelectedClient(this.options[this.selectedIndex].value);" size="10" id="memberclients" name="memberclients" multiple>
          							<option>-----none-----</option>
        							</select>
            					</TD>
            					<TD width="50%" class="grouping-neutral" valign="bottom" align="center">
              						Remaining Clients<br>
              						<select class="listbox" onchange="unselect(this, memberclientsList, memberscopesList, availablescopesList);changeSelectedClient(this.options[this.selectedIndex].value);" id="availableclients" size="10" name="availableclients" multiple>
          							<option>------none------</option>
        							</select>
        						</TD>
          					</TR>
          					<TR>
            					<TD class="oddcol" valign="bottom" align="center">
              						<input onclick="moveitem(memberclientsList, availableclientsList);"  type="button" value="-&gt;" name="moveRight1" class="widebuttons">
            					</TD>
            					<TD class="oddcol" valign="bottom" align="center">
        							<input onclick="moveitem(availableclientsList, memberclientsList);" type="button" value="&lt;-" name="moveLeft1" class="widebuttons">
        						</td>
          					</TR>
       					</TABLE>
        				</DIV>
      				</TD>
    			</TR>
  			</TABLE>
          </CENTER>
        </DIV>
      </TD>
      <TD width="50%" valign="top"  style="padding: 0;">
      	<DIV align="center">
        	<CENTER>
  				<TABLE class="tableForm" width="100%">
    				<TR>
      					<TD class="title">Clients</TD>
    				</TR>
    				<TR>
      					<TD class="evenrow"  style="padding: 0;">
        					<TABLE class="tableInline" width="100%" cellpadding="0" cellspacing="0">
          						<TR>
            						<TD><img border="0" src="images/blank.gif" width="5" height="5"></TD>
            						<TD><img border="0" src="images/blank.gif" width="5" height="5"></TD>
          						</TR>
          						<TR>
            						<TD align="left">
              							<TABLE class="tableInline" width="100%">
                							<TR>
                  								<TD class="evenrow" nowrap align="right">Select Client:&nbsp;</TD>
                  								<TD class="evenrow" width="100%"><select class="listbox" onchange="changeClient(this.options[this.selectedIndex].value);" size="1" name="clients" id="clients">
          											<option selected>---none---</option>
          											</select>
        										</TD>
        									</TR>
        									<TR><TD class="evenrow" colspan="3" align="right"><font style="font-size: 85%;">&nbsp;</font></TD></TR>
              							</TABLE>
            						</TD>
            						<TD></TD>
          						</TR>
          						<TR>
            						<TD><img border="0" src="images/blank.gif" width="5" height="5"></TD>
            						<TD><img border="0" src="images/blank.gif" width="5" height="5"></TD>
          						</TR>
        					</TABLE>
      					</TD>
    				</TR>
    				<TR>
      					<TD class="oddrow">
        					<DIV align="center">
        						<TABLE width="100%">
          							<TR>
            							<TD class="grouping-positive" valign="bottom" align="center">
              								Scopes in <nobr>this Client</nobr><br>
              								<select class="listbox" onchange="unselect(this, availablescopesList, availableclientsList, memberclientsList);changeSelectedScope(this.options[this.selectedIndex].value);" size="10" id="memberscopes" name="memberscopes" multiple>
          									<option>-----none-----</option>
        									</select>
            							</TD>
            							<TD class="grouping-neutral" valign="bottom" align="center">
              								Remaining Scopes<br>
              								<select class="listbox" onchange="unselect(this, memberscopesList, availableclientsList, memberclientsList);changeSelectedScope(this.options[this.selectedIndex].value);" id="availablescopes" size="10" name="availablescopes" multiple>
          									<option>------none------</option>
        									</select>
        								</TD>
          							</TR>
          							<TR>
            							<TD class="oddcol" valign="bottom" align="center">
              								<input onclick="moveitem(memberscopesList, availablescopesList);"  type="button" value="-&gt;" name="moveRight2" class="widebuttons">
            							</TD>
            							<TD class="oddcol" valign="bottom" align="center">
        									<input onclick="moveitem(availablescopesList, memberscopesList);" type="button" value="&lt;-" name="moveLeft2" class="widebuttons">
        								</TD>
          							</TR>
        						</TABLE>
        					</DIV>
      					</TD>
    				</TR>
  				</TABLE>
          	</CENTER>
        </DIV>
      </TD>
    </TR>
    <TR>
      <TD colspan=2 class="action" align="center" width="100%"><input type="submit" onclick="saveChanges();"  value="Save Changes" name="OK">
        </TD>
    </TR>
  </TABLE>

  <input type="hidden" name="scopeclientdata" value="">
    
  </form>
</TD></TR>

<TR><TD>&nbsp;&nbsp;&nbsp;</TD></TR>
</TABLE>

<script>
  //declare form objects as variables
  var TheForm = document.forms["form"];
  //var userfilterList = TheForm.userFilter;
  var scopeList =  TheForm.scopes;
  var clientList = TheForm.clients;
  var memberclientsList = TheForm.memberclients;
  var availableclientsList = TheForm.availableclients;
  var memberscopesList = TheForm.memberscopes;
  var availablescopesList = TheForm.availablescopes;
  var newScope = TheForm.newscope;
  var hiddenSave = TheForm.scopeclientdata;
  var hiddenAction = TheForm.action;
</script>
<script>


%invoke wm.server.oauth:listAllScopesAndClientsAssociations%
%loop clients%

addClient("%value name% (%value version%)",[%loop scopes%"%value%"%loopsep ','% %endloop%]);%endloop%

%loop scopes%
addScope("%value name%",[%loop clients%"%value name%"%loopsep ','% %endloop%]);%endloop%
</script>


<script>
setupPage();
</script>
</BODY>
</HTML>


