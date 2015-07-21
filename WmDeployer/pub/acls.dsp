<html>
<head>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
<base target="_self">
<style>
  .listbox  { width: 120px; }
</style>
</head>

<script src="client.js"></script>
<script src="acls.js"></script>
<script src="webMethods.js"></script>
<BODY>


<table width=100%>
  <tr>
    <td class="menusection-Deployer" colspan="2"> %value projectName% &gt; Authorize
		</TD>
  </tr>

%ifvar action equals('update')%
	%invoke wm.deployer.Wrapper:updateACLs%
		%include error-handler.dsp%

	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%endinvoke%
%invoke wm.deployer.gui.UIAuditLog:auditLogACLChanges%
	%endinvoke%

	%invoke wm.deployer.UIAuthorization:getAllGroups%
		%loop groups%			
			<script>addGroup("%value name%", [%loop membership%"%value%"%loopsep ', '% %endloop%]);</script>
		%endloop%
		%include error-handler.dsp%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%endinvoke%
%endif%

%ifvar action equals('getGroupsOfType')%
	%invoke wm.deployer.UIAuthorization:getAllGroups%
		%loop groups%			
			<script>addGroup("%value name%", [%loop membership%"%value%"%loopsep ', '% %endloop%]);</script>
		%endloop%
		%include error-handler.dsp%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%endinvoke%
%endif%
    <tr>
      <td colspan="2">
        <ul>
          <li><a href="acls.dsp?projectName=%value -htmlcode projectName%&action=getGroupsOfType&groupType=%value -htmlcode groupType%&searchString=%value -htmlcode searchString%">Refresh this Page</a></li>
        </ul>
      </td>
    </tr>
    <tr>
      <td><img src="images/blank.gif" height="10" width="10"></td>
<form id="form" name="form" method="POST" action="acls.dsp" onsubmit="return submitForm();" >
    <input type="hidden" name="acldata" value="">
    <input type="hidden" name="action" value="getGroupsOfType">
    <input type="hidden" name="precedence" value="deny">
    <input type="hidden" name="projectName" value="%value projectName%">

      <td>
        <table class="tableForm" width="100%">
          <tr>
            <td class="heading">Authorize Project</td>
          </tr>
          <tr>
            <td class="evencol">
              <table class="tableInline" border="0" cellspacing="0" cellpadding="0" width="100%">
                <tr>
                  <td><img border="0" src="images/blank.gif" width="5" height="5"></td>
                  <td><img border="0" src="images/blank.gif" width="5" height="5"></td>
                </tr>
                <tr>
                  <td align="center">
                    <table class="oddrow-l"border="0" cellspacing="0" cellpadding="2">
                      <tr>
                      	<td class="oddrow" nowrap>Fetch Groups </td>
                      	<td class="oddrow-1" width="100%">
                      		<select onchange="getGroupsOfType(this);" size="1" name="groupType">
                      			%ifvar groupType equals('local')%
                      			<option selected value="local">Local Integration Server groups</option>
                      			%else%
                      			<option value="local">Local Integration Server groups</option>
                      			%endif%
                      			%ifvar groupType equals('central')%
                      			<option selected value="central">LDAP/Central user management groups</option>
                      			%else%                      			
                      			<option value="central">LDAP/Central user management groups</option>
                      			%endif%
                      		</select>
                      	</td>                      	
                      </tr>
       	            <TR>
                	      <TD class="oddrow">Search String </TD>
        	              <TD class="oddrow-l" width="100%">
        	              %ifvar groupType equals('local')%        	                 
        		      	       <INPUT name="searchString" onchange="getGroupsOfType(this);" size="38" maxlength="32" value="" disabled id="searchString">
        		      	    %else%
        		      	       <INPUT name="searchString" onchange="getGroupsOfType(this);" size="38" maxlength="32" value="%value searchString%" id="searchString">
        		      	    %endif%
        		            </TD>	  
                        <TD class="action">
                  			%ifvar groupType equals('local')%
                  			   <INPUT align="left" type="submit" VALUE="Go" name="submit1" id="go" disabled="true"> 
                  			%else%
                  			   <INPUT align="left" type="submit" VALUE="Go" name="submit2" id="go">
                  			%endif%
                  			</TD>                             		            
                       </TR>                             
                      <tr>
                        <td class="evenrow" nowrap>Select Authorization </td>
                        <td class="evenrow-l" width="100%"><select onchange="changeACL(this.options[this.selectedIndex].value);" size="1" name="acl">
                <option selected>---none---</option>
                <option>placeholder placeholder</option>
                <option>placeholder placeholder</option>
                <option>placeholder placeholder</option>
                <option>placeholder placeholder</option>
                <option>placeholder placeholder</option>
                <option>placeholder placeholder</option>
                <option>placeholder placeholder</option>

              </select></td>
                      </tr>
                    </table>
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
            <td class="oddcol">
              <div align="center">
                <center>
              <table class="tableInline" border="0" cellspacing="1" cellpadding="4" width="100%">
                <tr>
                  <td valign="top" colspan="3">
                    Group associations for this Authorization:
                  </td>
                </tr>
                <tr>
                  <td valign="top" width="33%">
          <table cellspacing="0" cellpading="0" width="100%">
          <tr><td align="center" class="grouping-positive">Allowed</td></tr>
                    <tr><td class="oddcol"  width="100%">
                    <select class="wideselectlist" onchange="unselect(this, deny,groups);" size="10" id="allow" name="allow" multiple>
                   <option>-----none-----</option>
          </select>
                  </td></tr>
                  <tr><td class="oddcol" align="right"><input onclick="moveitem('allowRight');"  type="button" value="-&gt;" name="moveRight1" class="widebuttons" ></td></tr>
                    </table>
                  </td>
                  <td width="33%"  >
                  <table cellspacing="0" cellpading="0" width="100%">
                  <tr><td  colspan=2 class="grouping-neutral" align="center">Not Specified</td></tr>
        		 <tr><td class="oddcol" colspan=2  width="100%">
                    <select class="wideselectlist" onchange="unselect(this, deny,allow);" id="groups" size="10" name="groups" multiple>
                  <option>------none------</option>
                  </select>
                  </td></tr>
                  <tr>
                  <td class="oddcol" align="left"><input onclick="moveitem('groupLeft');" type="button" value="&lt;-" name="moveLeft" class="widebuttons" ></td>
              <td class="oddcol" align="right"><input onclick="moveitem('groupRight');"  type="button" value="-&gt;" name="moveRight" class="widebuttons" ></td>
          </tr>
          </table>
          </center>
                  </td>
                  <td valign="top" width="33%">
                  <table cellspacing="0" cellpading="0"  width="100%">
                  <tr><td align="center" class="grouping-negative">Denied</td></tr>
                  <tr><td class="oddcol">
                       <select class="wideselectlist" onchange="unselect(this, allow,groups);"  size="10" name="deny" multiple>
                  <option>-----none-----</option>
                  </select>
                  </td></tr>
                  <tr><td class="oddcol" align="left"><input onclick="moveitem('denyLeft');" type="button" value="&lt;-" name="moveLeft1" class="widebuttons" ></td></tr>
                </table>
              </td>
                </tr>
        <tr><td colspan=3>
        <center>
                    Resulting users with this Authorization:<br>
                    <textarea class="oddrow-l" onfocus="allowList.focus();" rows="3" name="users" cols="30">-----none----</textarea>
                </center>
        </td></tr>
              </table>
            </td>
          </tr>
          <tr>
            <td class="action" colspan="2">
              <input type="submit" onclick="saveChanges();"  value="Update" name="OK">
            </td>
          </tr>
      </table>

      </form>
    </td>
  </tr>
</table>
<script>
  //declare form objects as variables
  var TheForm = document.forms["form"];
  var userBox = TheForm.users;
  var allowList = TheForm.allow;
  var denyList = TheForm.deny;
  var groupList = TheForm.groups;
  var aclList = TheForm.acl;
  var newACL = TheForm.newACL;
  var precedence = TheForm.precedence;
  var hiddenSave = TheForm.acldata;
  var hiddenAction = TheForm.action;

	// Container for different ACLs based on agreed-upon roles
	var projACLs = new Array; 
	var projFriendly = new Array; 

	%scope param(taskName='DEFINE')%
	%invoke wm.deployer.UIAuthorization:getACLName%
	projACLs[projACLs.length] = '%value ACLName%';
	projFriendly[projFriendly.length] = 'Define';
  %endinvoke%

	%scope param(taskName='EXTRACT')%
	%invoke wm.deployer.UIAuthorization:getACLName%
	projACLs[projACLs.length] = '%value ACLName%';
	projFriendly[projFriendly.length] = 'Build';
  %endinvoke%

	%scope param(taskName='MAP')%
	%invoke wm.deployer.UIAuthorization:getACLName%
	projACLs[projACLs.length] = '%value ACLName%';
	projFriendly[projFriendly.length] = 'Map';
  %endinvoke%

	%scope param(taskName='DEPLOY')%
	%invoke wm.deployer.UIAuthorization:getACLName%
	projACLs[projACLs.length] = '%value ACLName%';
	projFriendly[projFriendly.length] = 'Deploy';
  %endinvoke%

	%scope param(taskName='VIEW')%
	%invoke wm.deployer.UIAuthorization:getACLName%
	projACLs[projACLs.length] = '%value ACLName%';
	projFriendly[projFriendly.length] = 'View';
  %endinvoke%

// This is a cheesy function to filter out irrelevant ACLs
function projectACL(aclName) {

	for (j in projACLs) {
		if (aclName == projACLs[j]) {
			return projFriendly[j];
		}
	}
	return null;
}

// From entire list of ACLs, filter out those specific to Project
%invoke wm.deployer.Wrapper:getACLList%
	%loop aclgroups%
		var a = projectACL("%value name%");
		if (a != null)
			addACL("%value name%", a, [%loop allow%"%value%"%loopsep ', '%%endloop%],[%loop deny%"%value%"%loopsep ', '%%endloop%]);
	%endloop%
%endinvoke%

setupPage();
</script>

</body>
</html>
