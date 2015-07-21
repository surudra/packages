<html>
<head>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<meta http-equiv="Expires" content="-1">

<link rel="stylesheet" type="text/css" href="webMethods.css">
<script src="webMethods.js.txt"></script>

%invoke wm.server.jms:getSettings%

<script language ="javascript">
  
  function validateForm(obj) {   
    if (editform.threadPoolThrottle.value == "") {
      alert("Thread Pool Throttle must be specified");
      return false;
    }
    if (!isNumeric(editform.threadPoolThrottle.value) || editform.threadPoolThrottle.value < 1 || editform.threadPoolThrottle.value > 100) {
      alert("Thread Pool Throttle must be an integer between 1 and 100.");
      return false;
    }
    return true;
  }

  function isNumeric(input) {
    var validNums = "0123456789";
    var char;
    var result = true;

    if (input.length == 0) {
      return false;
    }
    for (i = 0; i < input.length && result == true; i++) {
      char = input.charAt(i);
      if (validNums.indexOf(char) == -1) {
        result = false;
      }
    }
    return result;
  }

</script>

</head>

<body onLoad="setNavigation('settings-broker.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Msging_JMS_TriggerMgmtEdit');">

  <table width="100%">
    <tr>
      <td class="menusection-Settings" colspan="2">Settings &gt; Messaging &gt; JMS Settings &gt; Global JMS Trigger Controls &gt; Edit</td>
    </tr>
    <tr>
      <td colspan="2">
        <ul>
          <li><a href="settings-jms-trigger-management.dsp">Return to JMS Trigger Management</a></li>
        </ul>
      </td>
    </tr>
    <tr>
    
    <form name="editform" action="settings-jms-trigger-management.dsp" method="post" onSubmit="return validateForm()">
    
      <td><img src="images/blank.gif" height=10 width=10></TD>
      <td>
        <table class="tableView">

          <tr>
            <TD class="heading" colspan=2>Global JMS Trigger Controls</TD>
          </tr>
          
          <!-- Thread Pool Throttle -->
          
          <tr>
            <td width="40%" class="oddrow-l" nowrap="true">Thread Pool Throttle</td>
            <td class="oddrowdata-l"><INPUT NAME="threadPoolThrottle" size="6" value="%value threadPoolThrottle%">&nbsp;% of Server Thread Pool</td>
          </tr>
          
          <!-- Processing Throttle -->
          
          <tr>  
            <td class="evenrow-l" nowrap>Individual Trigger Processing Throttle</td>
            <td class="evenrowdata-l" nowrap>          
              <select name=processingThrottle size=1>
                <option %ifvar processingThrottle equals('100')% selected="selected" %endif% value="100" > 100% </option>
                <option %ifvar processingThrottle equals('90')% selected="selected" %endif% value="90" > 90% </option>
                <option %ifvar processingThrottle equals('80')% selected="selected" %endif% value="80" > 80% </option>
                <option %ifvar processingThrottle equals('70')% selected="selected" %endif% value="70" > 70% </option>
                <option %ifvar processingThrottle equals('60')% selected="selected" %endif% value="60" > 60% </option>
                <option %ifvar processingThrottle equals('50')% selected="selected" %endif% value="50" > 50% </option>
                <option %ifvar processingThrottle equals('40')% selected="selected" %endif% value="40" > 40% </option>
                <option %ifvar processingThrottle equals('30')% selected="selected" %endif% value="30" > 30% </option>
                <option %ifvar processingThrottle equals('20')% selected="selected" %endif% value="20" > 20% </option>
                <option %ifvar processingThrottle equals('10')% selected="selected" %endif% value="10" > 10% </option>
              </select>&nbsp;of Maximum
            </td>
          </tr>
          
          <tr>
            <td class="action" colspan=2>
              <input name="action" type="hidden" value="setSettings">
              <input type="submit" value="Save Changes">
            </td>
          </tr>
    
    </form>
  </table>
  
  %onerror%
    %value errorService%<br>
    %value error%<br>
    %value errorMessage%<br>
  
</body>
%endinvoke%
</html>