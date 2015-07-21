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
<script src="webMethods.js.txt"></script>
<script src="client.js.txt"></script>
<script src="users.js.txt"></script>
<SCRIPT LANGUAGE="JavaScript">
    function checkCDSEnabled(){
    	var e1 = document.getElementById('cds');
    	var e2 = document.getElementById('pool');
    	if (e1.checked == true){
    	    e2.disabled=false;
    	}else{
    	    e2.disabled=true;
    	}
    }

</SCRIPT>




<BODY class="main" onLoad="setNavigation('users.dsp',  '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_UsersAndGroupsScrn');" onbeforeunload="checkDirty();">


<table width=100% >
  <tr>
    <td class="menusection-Security" colspan=2>Security &gt; User Management&nbsp;</td>
  </tr>

%ifvar action equals('editCommonUM')%
    %invoke wm.server.jndi:setCDSSettings%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
            <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value encode(htmlall) message%</TD></TR>
        %endif%
    %endinvoke%
%endif%


%ifvar action equals('update')%
    %invoke wm.server.access:updateUsersGroups%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
            <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value encode(htmlall) message%</TD></TR>
        %endif%
    %endinvoke%
%endif%

%ifvar action equals('addusers')%
  %invoke wm.server.access:addUsers%
    %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
      <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value -htmlall message%</TD></TR>
    %endif%
	%ifvar warning%
      <tr><td colspan="2">&nbsp;</td></tr>
      <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value encode(htmlall) warning%</TD></TR>
    %endif%
  %endinvoke%
%endif%

%ifvar action equals('removeusers')%
  %invoke wm.server.access:removeUsers%
      %ifvar message%
       <tr><td colspan="2">&nbsp;</td></tr>
     <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value encode(htmlall) message%</TD></TR>
      %endif%
  %endinvoke%
%endif%

%ifvar action equals('addgroups')%
  %invoke wm.server.access:addGroups%
    %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
      <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value -htmlall message%</TD></TR>
    %endif%
  %endinvoke%
%endif%

%ifvar action equals('removegroups')%
  %invoke wm.server.access:removeGroups%
      %ifvar message%
       <tr><td colspan="2">&nbsp;</td></tr>
     <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value encode(htmlall) message%</TD></TR>
      %endif%
  %endinvoke%
%endif%

%ifvar action equals('editPassword')%
  %invoke wm.server.admin:setPasswordSettings%
      %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
      <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value encode(htmlall) message%</TD></TR>
      %endif%
  %endinvoke%
%endif%

%ifvar action equals('setPassword')%
  %invoke wm.server.access:userChange%
      %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
      <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value encode(htmlall) message%</TD></TR>
      %endif%
      %ifvar warning%
      <tr><td colspan="2">&nbsp;</td></tr>
      <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value encode(htmlall) warning%</TD></TR>
      %endif%
  %endinvoke%
%endif%
<!------------------------------------------------------------------------------------------------------->
<tr><td>&nbsp;&nbsp;&nbsp;</td></tr>
<tr><td></td>
   <td>

  <table width="100%" cellspacing=0 cellpadding=0 border=0>
    <tr>
      <td class="heading"  colspan=2>Central User Management Configuration</td>
    </tr>

%ifvar edit%
%else%
%endif%

<tr><td style="padding: 0;">
<table>
				      <td>
%ifvar edit%
					<a href="users.dsp">Return to User Management</a></li>
%else%					
<!--					<a href="users.dsp?edit=true">Edit Central User Management Configuration</a></li> -->
%endif%					
				      </td>
				      <tr><td>&nbsp;</td></tr>
		    	<TR><td colspan=2 class="title">
		    	General
			</td></TR>

%ifvar edit%
<FORM id="commonUMForm" name="commonUMForm" method="POST" action="users.dsp" >

	    <TR>
			<TD class="evenrow">Central User Management</TD>
			<TD class="evenrow-l">
				%invoke wm.server.jndi:getCDSSettings%				
				<INPUT id="cds" TYPE="radio" NAME="cds" value="true" onClick="checkCDSEnabled()" %ifvar cds equals('true')%checked%endif%><FONT id='cdsFont'>Configured</FONT>
				<INPUT id="cds2" TYPE="radio" NAME="cds" value="false" onClick="checkCDSEnabled()" %ifvar cds equals('false')%checked%endif%>Not Configured</input>
				%endinvoke%
			</TD>
		</TR>			
		<TR>
			<TD class="oddrow">Central User Management JDBC Pool</TD>
			<TD class="oddrowdata-l">
                %invoke wm.server.jdbcpool:getAvailablePoolDefinitions%
                  %ifvar message%
                    </TD></TR>
                    <TR><TD colspan="2">&nbsp;</TD></TR>
                    <TR><TD class="message" colspan="2">%value encode(htmlall) message%</TD></TR>
                    <TR><TD colspan="2">&nbsp;</TD></TR>
                  %endif%
					
                  <SELECT id=pool NAME="jdbcpool">
<!--                    <OPTION VALUE="" %ifvar function.pool notempty% %else% SELECTED %endif%>None-->

                  %loop pools%
                    <OPTION VALUE="%value pool.name%" %ifvar ../function.pool vequals(pool.name)% SELECTED %endif%>%value pool.name%
                  %endloop%
                  </SELECT>
                  </TD></TR>
                %onerror%
                  </TD></TR>
                  <TR><TD colspan="2">&nbsp;</TD></TR>
                  <TR><TD class="message" colspan="2">%value encode(htmlall) errorMessage%</TD></TR>
                  <TR><TD colspan="2">&nbsp;</TD></TR>
                %endinvoke%

				<SCRIPT>
					checkCDSEnabled();
				</SCRIPT>				
			</TD>
		</TR>


	
		<TR>
            <TD class="action" colspan=2>
              <INPUT TYPE="hidden" NAME="action" VALUE="editCommonUM">
              <INPUT type="submit" id='cdsSubmit' value="Save Changes">
		<SCRIPT>
                  	var poolElem = document.getElementById('pool');
			if (poolElem.length == 0){
	                  	document.getElementById('cds').disabled = true;
	                  	document.getElementById('cdsFont').style.color = 'grey';
	                  	document.getElementById('cds2').checked = true;
			        var newoption = new Option("JDBC Pool is Not Configured", "" );
				poolElem.options[0] = newoption;
                  		document.getElementById('cdsSubmit').disabled = true;
                  	}
		</SCRIPT>
            </TD>

        </TR>	   	
</FORM>
%else%
		%invoke wm.server.jndi:getSettings%				
		    	<TR>
				<TD class="evenrow">Central User Management</TD>
				<TD class="evenrowdata-l">
				%ifvar cdsRunning equals('true')%Configured%else%Not Configured%endif%
				</TD>
			</TR>
		%endinvoke%
%endif%
</table>
</td>
</tr>
<tr><td>&nbsp;&nbsp;&nbsp;</td></tr>



<!------------------------------------------------------------------------------------------------------->
</table>

<tr><td>&nbsp;</td></tr>

<tr>
<td></td><td>
   <table class="tableForm" width="100%" %ifvar edit% style="display:none"%endif%>
    <tr>
      <td class="heading" colspan=2>Local User Management</td>
    </tr>
    <tr>
      <td valign="top">
        <ul>
          <li><a href="users-addremove.dsp">Add and Remove Users</a></li>
          <li><a href="groups-addremove.dsp">Add and Remove Groups</a></li>
          <li><a href="users-disable.dsp">Enable and Disable Users</a></li>
        </ul>
      </td>
      <td valign="top">
        <ul>
          <li><a href="password-settings.dsp">Password Restrictions</a></li>
          
          %invoke wm.server.jndi:getSettings%
          <li><a href="jndi-settings.dsp">LDAP Configuration</a></li>
          %endinvoke%
          
        </ul>
      </td>
    </tr>
    <tr>
      <td width="50%" style="padding: 0;">
        <div align="center">
          <center>

<form id="form" name="form" method="POST" action="users.dsp" onsubmit="return submitForm();" >
<input type="hidden" name="action" value="nothing">

  <table class="tableForm" width="100%">
    <tr>
      <td class="title">Users</td>
    </tr>
    <tr>
      <td class="evenrow">
        <table class="tableInline" width="100%" cellpadding="0" cellspacing="0">
          <tr>
            <td><img border="0" src="images/blank.gif" width="5" height="5"></td>
            <td><img border="0" src="images/blank.gif" width="5" height="5"></td>
          </tr>
          <tr>
            <td align="left">
              <table class="tableInline" width="100%">
<!--
                <tr>
                  <td nowrap align="right">Filter List:</td>
                  <td width="100%"><select size="1" name="userFilter" onchange="filterUserList(this.options[this.selectedIndex].value);" >
                <option selected value="0">---- Alll ----</option>
                <option>a</option>
                <option>b</option>
                <option>c</option>
                <option>d</option>
                <option>e</option>
                <option>f</option>
              </select></td>
                </tr>
-->
                <tr>
                  <td class="evenrow" nowrap align="right">
              Select User:</td>
                  <td class="evenrow" width="100%" align=right><select class="listbox" onchange="changeUser(this.options[this.selectedIndex].value);" size="1" name="users">
          <option selected>---none---</option>
          <option>placeholder placeholder</option>
          <option>placeholder placeholder</option>
          <option>placeholder placeholder</option>
          <option>placeholder placeholder</option>
          <option>placeholder placeholder</option>
          <option>placeholder placeholder</option>
          <option>placeholder placeholder</option>

        </select></td></tr>
        <tr><td class="evenrow" colspan=3 align=right>
        <font style="font-size: 85%;">(<a href="user-edit.dsp" onclick="return editPassword(userList.options[userList.selectedIndex].value);">change password</a>)</font></td>
                </tr>
              </table>
            </td>
            <td>
            </td>
          </tr>
          <tr>
            <td><img border="0" src="images/blank.gif" width="5" height="5"></td>
            <td><img border="0" src="images/blank.gif" width="5" height="5"></td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <td class="oddrow">
        <div align="center">
        <table width="100%">
          <tr>
            <td class="grouping-positive" valign="bottom" align="center">
              Groups user <nobr>belongs to</nobr><br>
              <select class="listbox" onchange="unselect(this, availablegroupsList, memberusersList, availableusersList);changeSelectedGroup(this.options[this.selectedIndex].value);" size="10" id="membergroups" name="membergroups" multiple>
          <option>-----none-----</option>
        </select>
            </td>
            <td class="grouping-neutral" valign="bottom" align="center">
              Remaining Groups<br>
              <select class="listbox" onchange="unselect(this, membergroupsList, memberusersList, availableusersList);changeSelectedGroup(this.options[this.selectedIndex].value);" id="availablegroups" size="10" name="availablegroups" multiple>
          <option>------none------</option>
        </select>
        </td>
          </tr>
          <tr>
            <td class="oddcol" valign="bottom" align="center">
              <input onclick="moveitem(membergroupsList, availablegroupsList);"  type="button" value="-&gt;" name="moveRight1" class="widebuttons">
            </td>
            <td class="oddcol" valign="bottom" align="center">
        <input onclick="moveitem(availablegroupsList, membergroupsList);" type="button" value="&lt;-" name="moveLeft1" class="widebuttons">
        </td>
          </tr>
        </table>
        </div>
      </td>
    </tr>
  </table>

          </center>
        </div>
      </td>
      <td width="50%" valign="top"  style="padding: 0;">
        <div align="center">
          <center>
  <table class="tableForm" width="100%">
    <tr>
      <td class="title">Groups</td>
    </tr>
    <tr>
      <td class="evenrow"  style="padding: 0;">
        <table class="tableInline" width="100%" cellpadding="0" cellspacing="0">
          <tr>
            <td><img border="0" src="images/blank.gif" width="5" height="5"></td>
            <td><img border="0" src="images/blank.gif" width="5" height="5"></td>
          </tr>
          <tr>
            <td align="left">
              <table class="tableInline" width="100%">
<!--
                <tr>
                  <td nowrap align="right">Filter List:</td>
                  <td width="100%"><select size="1" name="groupFilter">
                      <option selected>All Groups</option>
                    </select></td>
                </tr>
-->
                <tr>
                  <td class="evenrow" nowrap align="right">Select group:&nbsp;</td>
                  <td class="evenrow" width="100%"><select class="listbox" onchange="changeGroup(this.options[this.selectedIndex].value);" size="1" name="groups">
          <option selected>---none---</option>
          <option>placeholder placeholder</option>+
          <option>placeholder placeholder</option>
          <option>placeholder placeholder</option>
          <option>placeholder placeholder</option>
          <option>placeholder placeholder</option>
          <option>placeholder placeholder</option>
          <option>placeholder placeholder</option>

        </select></td></tr>
        <tr><td class="evenrow" colspan="3" align="right"><font style="font-size: 85%;">&nbsp;</font></td></td>
                </tr>
              </table>
            </td>
            <td>
            </td>
          </tr>
          <tr>
            <td><img border="0" src="images/blank.gif" width="5" height="5"></td>
            <td><img border="0" src="images/blank.gif" width="5" height="5"></td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <td class="oddrow">
        <div align="center">
        <table width="100%">
          <tr>
            <td class="grouping-positive" valign="bottom" align="center">
              Users in <nobr>this Group</nobr><br>
              <select class="listbox" onchange="unselect(this, availableusersList, availablegroupsList, membergroupsList);changeSelectedUser(this.options[this.selectedIndex].value);" size="10" id="memberusers" name="memberusers" multiple>
          <option>-----none-----</option>
        </select>
            </td>
            <td class="grouping-neutral" valign="bottom" align="center">
              Remaining Users<br>
              <select class="listbox" onchange="unselect(this, memberusersList, availablegroupsList, membergroupsList);changeSelectedUser(this.options[this.selectedIndex].value);" id="availableusers" size="10" name="availableusers" multiple>
          <option>------none------</option>
        </select>
        </td>
          </tr>
          <tr>
            <td class="oddcol" valign="bottom" align="center">
              <input onclick="moveitem(memberusersList, availableusersList);"  type="button" value="-&gt;" name="moveRight2" class="widebuttons">
            </td>
            <td class="oddcol" valign="bottom" align="center">
        <input onclick="moveitem(availableusersList, memberusersList);" type="button" value="&lt;-" name="moveLeft2" class="widebuttons">
        </td>
          </tr>
        </table>
        </div>
      </td>
    </tr>
  </table>
          </center>
        </div>
      </td>
    </tr>
    <tr>
      <td colspan=2 class="action" align="center" width="100%"><input type="submit" onclick="saveChanges();"  value="Save Changes" name="OK">
        </td>
    </tr>

  </table>


  <input type="hidden" name="usergroupdata" value="">

  </form>

</td></tr>






<tr><td>&nbsp;&nbsp;&nbsp;</td></tr>













<script>
  //declare form objects as variables
  var TheForm = document.forms["form"];
  //var userfilterList = TheForm.userFilter;
  var userList =  TheForm.users;
  var groupList = TheForm.groups;
  var membergroupsList = TheForm.membergroups;
  var availablegroupsList = TheForm.availablegroups;
  var memberusersList = TheForm.memberusers;
  var availableusersList = TheForm.availableusers;
  var newUser = TheForm.newuser;
  var hiddenSave = TheForm.usergroupdata;
  var hiddenAction = TheForm.action;
</script>


<script>
%invoke wm.server.access:groupList%
%loop groups%
addGroup("%value name%", [%loop membership%"%value%"%loopsep ','% %endloop%]);%endloop%

</script>

<script>
setupPage();
</script>
</body>
</html>


