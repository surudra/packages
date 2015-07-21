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
  <script src="webMethods.js.txt"></script>

  <BODY class="main" onLoad="setNavigation('users.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_EnableDisableUsersScrn');">
    <table width=100% >
      <tr>
        <td class="menusection-Security" colspan=2>Security &gt; User Management &gt; Enable and Disable Users</td>
      </tr>

%ifvar action equals('update')%
    %invoke wm.server.access:setMultipleUserDisabled%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
            <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message%</TD></TR>
        %endif%
    %endinvoke%
%endif%

    <tr>
      <td colspan="2">
        <ul>
          <li><a href="users.dsp">Return to User Management</a></li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>
        <img src="images/blank.gif" height="10" width="10">
      </td>
      <td valign="top">

  <form id="form" name="form" method="POST" action="users-disable.dsp">
  <input type="hidden" name="action" value="update">

  <table class="tableForm" width="75%">
    <tr>
      <td class="heading">Enable and Disable Users</td>
    </tr>
    <tr>
      <td class="oddrow">
        <table width="100%">
          <tr>
            <td class="grouping-positive" valign="bottom" align="center">
              Enabled Users<br>
              <select class="listbox" size="10" id="enabledUsers" name="enabledUsers" multiple>
                <option>-----none-----</option>
              </select>
            </td>
            <td class="grouping-negative" valign="bottom" align="center">
              Disabled Users<br>
              <select class="listbox" size="10" id="disabledUsers" name="disabledUsers" multiple>
                <option>------none------</option>
              </select>
        </td>
          </tr>
          <tr>
            <td class="oddcol" valign="bottom" align="center">
              <input onclick="moveItems(enabledUsers, disabledUsers);"  type="button" value="-&gt;" name="moveRight1" class="widebuttons" >
            </td>
            <td class="oddcol" valign="bottom" align="center">
        <input onclick="moveItems(disabledUsers, enabledUsers);" type="button" value="&lt;-" name="moveLeft1" class="widebuttons" >
        </td>
          </tr>
        </table>
      </td>
    </tr>

    <tr>
      <td colspan=2 class="action" align="center" width="100%">
        <input type="submit" value="Save Changes" name="OK" onclick="return saveChanges();">
        <input type="hidden" name="enabled" id="enabled" value="">
        <input type="hidden" name="disabled" id="disabled" value="">
      </td>
    </tr>

  </table>
</table>

  </form>

<script>

  var enabledUsersList = document.form.enabledUsers;
  var disabledUsersList = document.form.disabledUsers;

  var enabledData = document.form.enabled;
  var disabledData = document.form.disabled;

  var enabledList = new Array();
  var disabledList = new Array();

  function saveChanges()
  {
    enabledData.value = "";
    disabledData.value = "";

    for(var i = 0; i < enabledUsersList.options.length; i++)
    {
        enabledData.value = enabledData.value + enabledUsersList.options[i].text + ";";
    }

    for(var i = 0; i < disabledUsersList.options.length; i++)
    {
        disabledData.value = disabledData.value + disabledUsersList.options[i].text + ";";
    }

    document.form.submit();

    return false;
  }

  function quickSave()
  {
  }

  function addEnabled(users)
  {
    enabledList = users;
  }

  function addDisabled(users)
  {
    disabledList = users;
  }

  function setupPage()
  {
      clearList(enabledUsersList);

      for(i in enabledList)
      {
        insertOption(enabledList[i],enabledList[i],enabledUsersList,false);
      }

      clearList(disabledUsersList);

      for(i in disabledList)
      {
        insertOption(disabledList[i],disabledList[i],disabledUsersList,false);
      }

      if(enabledList.length == 0)
      {
        insertOption("----none----","0", enabledUsersList, false);
      }

      if(disabledList.length == 0)
      {
        insertOption("----none----","0", disabledUsersList, false);
      }
  }


  %invoke wm.server.access:getDisabledUserList%
      addEnabled([%loop enabled%'%value%'%loopsep ', '%%endloop%]);

      addDisabled([%loop disabled%'%value%'%loopsep ', '%%endloop%]);

  %endinvoke%

  setupPage();
</script>
</body>
</html>


