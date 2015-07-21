<html>
<head>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


<title>IS Task Scheduler</title>
<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
<SCRIPT SRC="webMethods.js.txt"></SCRIPT>
<SCRIPT SRC="scheduledservicesfilter.js.txt"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
	function confirmPause () {
		return confirm("OK to pause the Scheduler?\nNo scheduled tasks will be initiated until the Scheduler is resumed.");
	}
	function confirmResume() {
		return confirm("OK to resume the Scheduler?\nThe Scheduler will proceed to initiate scheduled tasks.");
	}
</SCRIPT>

</head>

%switch mode%



%case sys%
<body onLoad="setNavigation('scheduler.dsp',  '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Server_ViewSysTaskScrn');">

<!-- =========================== sys =========================== -->

%invoke wm.server.query:getTaskList%
<!-- Server tasks table -->
<table width="100%">

<tr><td class="menusection-Server" colspan=4>
    Server &gt;
    Scheduler &gt;
    View System Tasks
    </td></tr>

<tr><td colspan=2>
    <ul>
        <li><a href="scheduler.dsp">Return to Scheduler</a></li>
        <li><a href="scheduler.dsp?mode=sys">Refresh System Tasks</a></li>
    </ul>
</td></tr>
    <tr>
      <td><img src="images/blank.gif" height=10 width=10 border=0></td>
      <td>
        <table class="tableView" width=100%>
            %ifvar tasks%
            <tr><td class="heading" colspan=4>Simple Interval Tasks</td></tr>
            <TR>
              <td class="oddcol-l">Name</td>
              <td class="oddcol-l" colspan=2>Next Run</td>
              <td class="oddcol-r">Interval</td>
            </tr>
            %endif%
                <script>resetRows();</script>
            %loop tasks%
            <tr>
                <script>writeTD("rowdata-l");</script>%value name%</td>
                <script>writeTD("rowdata");</script><nobr>%value nextRun%</nobr></td>
                <script>writeTD("rowdata-r");</script><nobr>%value msDelta decimal(-3,1)% sec</nobr></td>
                <script>writeTD("rowdata-r");</script><nobr>%value interval decimal(-3,0)% sec</nobr></td>
            </tr>
                <script>swapRows();</script>
            %endloop%

            <tr><td class="space" colspan="4">&nbsp;</td></tr>

            <tr><td class="heading" colspan=4>Complex Repeating Tasks</td></tr>
            <TR>
              <td class="oddcol-l">Name</td>
              <td class="oddcol-l" colspan=2>Last Run</td>
              <td class="oddcol-r">Interval</td>
            </tr>
            %ifvar -notempty extTasks%
                <script>resetRows();</script>
            %loop extTasks%
            <tr>
                <script>writeTD("rowdata-l");</script>%value name%</td>
                <script>writeTD("rowdata-l");</script><nobr>%value msDelta%</nobr></td>
                <script>writeTD("rowdata-r");</script><nobr>%value msDelta decimal(-3,1)% sec</nobr></td>
                <script>writeTD("rowdata-r");</script><nobr>%value interval decimal(-3,0)% sec</nobr></td>
            </tr>
                <script>swapRows();</script>
            %endloop%
          %else%
           %ifvar error%
           <tr><td class="evenrow-l" colspan=11>%value error%</td></tr>
           %else%
             <tr><td class="evenrow-l" colspan=11>No tasks are currently scheduled</td></tr>
           %endif%
          %endif%

            </table>
          </td>
        </tr>
      </table>
    %endinvoke%



%case useradd%
<body onLoad="setNavigation('scheduler.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Server_CreateTaskScrn'); setDefaultSettings()">


<!-- =========================== useradd =========================== -->

<!-- User tasks table -->

<SCRIPT LANGUAGE="JavaScript">

  function onAdd() {

    var type = "";

    // (1) validate service name
    var svc = document.schedule.service.value;
    var idx = svc.lastIndexOf(":");
    if (svc == "" || idx < 0 || idx > svc.length-1) {
      alert (
        "Specify service name in the form:\n\n"+
        "          folder.subfolder:service\n"
      );
      document.schedule.service.focus();
      return false;
    }

   // Validate user, schedule type
   if (document.schedule.runAsUser.value == "" )
   {
	alert("Specify user");
	document.schedule.runAsUser.focus();
	return false;
    }


   // If latenessAction is NOT "Run immediately", then Check for Lateness time
    var latenessActionList = document.schedule.latenessAction;
    var isLatenessActionChecked = false;
    for (var i=0; i<latenessActionList.length; i++) {
	if ( latenessActionList[i].checked)
		isLatenessActionChecked = true;
	if ( (latenessActionList[i].value == 1 && latenessActionList[i].checked) ||
	     (latenessActionList[i].value == 2 && latenessActionList[i].checked))
	{
		var lateness = document.schedule.lateness;
		if ( lateness.value == "")
		{
			alert("Specify lateness (in minutes)");
			lateness.focus();
			return false;
		} else if(isNaN(lateness.value)) {
			alert("lateness (in minutes) is not a valid number");
			lateness.focus();
			return false;
		} else {
			if(parseInt(lateness.value) > 35000) {
				alert("The maximum number of minutes that the if more than xxx minutes late field can accept is 35000");
				lateness.focus();
				return false;
			}				
		}
	}
    }
    if ( !isLatenessActionChecked ) {
	alert("Specify overdue option");
	return false;
    }

    // (3) determine type of service to be added
    var typeList = document.schedule.type;
    document.schedule.schaction.value='Add Task';
    for (var i=0; i<typeList.length; i++) {
      if (typeList[i].checked) type = typeList[i].value;

    }
    if ( type == "" ){
	alert("Specify schedule type");
	return false;
    }

    // (4) check inputs for that type

    // (4a) one-time tasks need a date and time
    if (type == "once") {
      var d = document.schedule.date.value;
      var t = document.schedule.time.value;
      if (d == "") {
        alert (
          "Specify date in the form:\n\n"+
          "          YYYY/MM/DD\n"
        );
        return false;
      }
      if (t == "") {
        alert (
          "Specify time in the form:\n\n"+
          "          HH:MM:SS\n"
        );
        return false;
      }
    }

   // (4b) repeating tasks need an interval
    else if (type == "repeat") {
      var i = document.schedule.interval.value;
      if (i == "") {
        alert ("Specify interval (in seconds)");
	document.schedule.interval.focus();
        return false;
      }
    }

    // (4c) complex tasks don't need anything specified -- if
    // nothing is specified, they'll be run every minute
    else {
	    // if it's complex, we need to copy the start/end values
		// into the fields with the right name.  We can't just specify
		// start-date, etc, twice (once for repeating, and once for
		// complex) because the form will submit both, and the IS will
		// pick up the blank value for repeating and ignore the proper one
		document.schedule['start-date'].value = document.schedule.sd2.value;
		document.schedule['start-time'].value = document.schedule.st2.value;
		document.schedule['end-date'].value = document.schedule.ed2.value;
		document.schedule['end-time'].value = document.schedule.et2.value;
    }




    document.schedule.submit();
  }

  function onUpdate() {
    document.schedule.schaction.value='Update Task';
    document.schedule.submit();
  }

  function validateTypeForLatesnessOpt(latenessAction)
  {
  	if (latenessAction.value == 0)
		document.schedule.lateness.disabled = true;
	else
		document.schedule.lateness.disabled = false;

	// If latenessAction is "Skip and run" option Then "Run Once" schedule type is Invalid
	if (document.schedule.type[0] != null) // Create Mode
	{
		if ( latenessAction.value == 1 )
			document.schedule.type[0].disabled = true;
		else
			document.schedule.type[0].disabled = false;
	}
  }

  function validateLatesnessOptForType(type)
  {
  	// If Schedule type is "Run Once" Then "Skip and run" latenessAction option is Invalid.
	if ( type.value == "once" )
		document.schedule.latenessAction[1].disabled = true;
	else
		document.schedule.latenessAction[1].disabled = false;
  }

  function setDefaultSettings()
  {
	if (document.schedule.type[0] != null)  // Create Mode
	{
		if ( document.schedule.latenessAction[0].checked)
			document.schedule.lateness.disabled = true;
		else
			document.schedule.lateness.disabled = false;
	}
	else
	{
		if ( document.schedule.latenessAction[0].checked)
		document.schedule.lateness.disabled = true;
	}
  }
</SCRIPT>

<table width="100%">

%ifvar smode%
<tr><td class="menusection-Server" colspan=7>
    Server &gt;
    Scheduler &gt;
    User Tasks &gt;
    Modify Task</td></tr>
%else%
<tr><td class="menusection-Server" colspan=7>
    Server &gt;
    Scheduler &gt;
    User Tasks &gt;
    New Task</td></tr>
%endif%

  <form name="schedule" action="scheduler.dsp" method="POST">
    <tr>
      <td colspan=2>
        <ul>
          <li><a href="scheduler.dsp">Return to Scheduler</a></li>
        </ul>

      </td>
    </tr>

    <tr>
      <td><img src="images/blank.gif" height=10 width=10 border=0></td>
      <td>
        <table class="tableForm">
        %invoke wm.server.schedule:getUserTask%

        <script type="text/javascript">
          var trgt = "%value target%";

          // define function to scroll through selections on
          // document.schedule.runAsUser
          function updateTargetSelector () {
            var sel = document.schedule.target;
            for (var i=0; i<sel.options.length; i++) {
              if (sel.options[i].value == trgt) sel.selectedIndex = i;
            }
          }
        </script>

        <tr><td class="heading" colspan=7>Service Information</td></tr>
        <tr>
          <td class="oddrow" colspan=2>Description</td>
          <td class="oddrow-l" colspan=5><input name="description" size=40 value="%value description%"></input></td>
        </tr>
        <tr>
          <td class="evenrow" colspan=2>folder.subfolder:service</td>
          <td class="evenrow-l" colspan=5><input id="service" name="service" size=40 value="%value name%"></input>
		  %rename inputs scheduleData -copy%
		  %invoke wm.server.schedule:getSchedulerInputAsString%
			  <input type="hidden" name="scheduleDataStr" id="scheduleDataStr" value="%value scheduleDataStr encode(html)%"/>
		  %endinvoke%

		  <link rel="stylesheet" type="text/css" href="subUserLookup.css" />
		  <script type="text/javascript" src="subUserLookup.js"></script>
		  <script type="text/javascript">
		  	function showService() {
				var svc = document.getElementById("service").value;
				var idx = svc.lastIndexOf(":");
				if (svc == "" || idx < 0 || idx > svc.length-1) {
				  alert (
					"Specify service name in the form:\n\n"+
					"          folder.subfolder:service\n"
				  );
				  document.schedule.service.focus();
				  return false;
			    } else {
					var width = 280;
					var height = 350;
					if(is_csrf_guard_enabled && needToInsertToken) {
						showSub("scheduler-service-input-dummy.dsp?csrfTokenNm="+_csrfTokenNm_+"&csrfTokenVal="+_csrfTokenVal_+"&"+_csrfTokenNm_+"="+_csrfTokenVal_, width, height, null);
					} else {
						showSub("scheduler-service-input-dummy.dsp", width, height, null);
					}
				}
			}

			function getServiceName() {
				var service = document.getElementById("service");
				return service.value;
			}

			function setInputString(input) {
				document.schedule.scheduleDataStr.value = input;
			}

			function getInputString() {
				var inputStringField = document.getElementById("scheduleDataStr");
				return inputStringField.value;
			}
		  </script>
		  <a id="servicepopup" onClick="javascript:return showService();" onmouseover="this.style.cursor='pointer'">Assign Inputs<img border=0 align="bottom" src="icons/service_input.gif"/></a>
		  </td>
        </tr>

	<!--  RUN AS USER SUB -->
	<SCRIPT>
	  //This function can be changed to do something with the user
	  function callback(val){
	    document.schedule.runAsUser.value=val;
	  }
	</SCRIPT>
        <tr>
          <td class="oddrow" colspan=2>Run As User</td>
          <td class="oddrow-l" colspan=5>
          <input name="runAsUser" size=12 value="%value runAsUser%"></input>
	<link rel="stylesheet" type="text/css" href="subUserLookup.css" />
	<script type="text/javascript" src="subUserLookup.js"></script>
	   <a class="submodal" href="subUserLookup.dsp"><img border=0 align="bottom" src="icons/magnifyglass.gif"/></a>
          </td>
        </tr>
        <!-- END RUN AS USER SUB -->

        <tr>
          <td class="evenrow" colspan=2>Target Node</td>
          <td class="evenrow-l" colspan=5>

		  %invoke wm.server.schedule:getTargetNodeList%
          <SELECT NAME="target">
			<OPTION value="$any"%ifvar target equals('$any')% selected%endif%>Any server</OPTION>
            %ifvar currentlyClustered equals('true')%
			    <OPTION value="$all"%ifvar target equals('$all')% selected%endif%>All servers</OPTION>
            %endif%
            %loop hosts%
            <OPTION value="%value logicalServerName%" %ifvar logicalServerName vequals(../target)% selected %endif%>
                %value logicalServerName%
            </OPTION>
            %endloop%
          </SELECT>
          %endinvoke%
          </td>
        </tr>
		%comment% <!-- if we want it in black -->
		<tr><td class="space" colspan="7">&nbsp;</td></tr>
		<tr><td class="heading" colspan=7>If the Task is Overdue</td></tr>
		%endcomment%
		<tr><td class="subHeading" colspan=7>If the Task is Overdue</td></tr>
		<tr>
		  <td class="oddrow-l" colspan=7><input name="latenessAction" %ifvar mode equals('useradd')% checked %else% %ifvar latenessAction equals(0)% checked%endif%%endif% onclick="validateTypeForLatesnessOpt(this)" value="0"  type="radio">Run immediately</input></td>
		</tr>
		<tr>
		  <td class="evenrow-l" colspan=3><input name="latenessAction" value="1" onclick="validateTypeForLatesnessOpt(this)" type="radio"%ifvar latenessAction equals(1)% checked%endif%>Skip and run at next scheduled interval</input></td>
		  <td class="evenrow-l" colspan=4 rowspan=2>if more than <input name="lateness" size=12 value="%value lateness%"></input> minutes late.</td>
		</tr>
		<tr>
		  <td class="oddrow-l" colspan=3><input name="latenessAction" onclick="validateTypeForLatesnessOpt(this)" value="2"  type="radio"%ifvar latenessAction equals(2)% checked%endif%>Suspend</input></td>
		</tr>
	    %comment%
        <tr>
          <td class="oddrow" colspan=2>Lateness</td>
          <td class="oddrow-l" colspan=5><input name="lateness" size=12 value="%value lateness%"></input> minutes</td>
        <tr>
          <td class="evenrow" colspan=2>Lateness Action</td>
          <td class="evenrow-l" colspan=5>

          <SELECT NAME="latenessAction">
		    <option value="0"%ifvar latenessAction equals(0)% selected%endif%>Original</option>
			<option value="1"%ifvar latenessAction equals(1)% selected%endif%>Now</option>
			<option value="2"%ifvar latenessAction equals(2)% selected%endif%>Suspend</option>
          </SELECT>
          </td>
        </tr>
		%endcomment%

%comment%
<!--
        <tr>
          <td class="oddrow" colspan=2>Persistence</td>
          <td class="oddrow-l" colspan=5>
          <input name="persistJob" type="checkbox" value="true"
                 %ifvar custom/persistJob equals(true)%checked%endif%
               %ifvar custom/persistJob%%else%checked%endif%>
          Persist after restart</input>
          </td>
        </tr>
        <tr>
          <td class="evenrow" colspan=2>Clustering</td>
          <td class="evenrow-l" colspan=5>


          %ifvar inCluster%
          <input name="runInCluster" type="checkbox" value="true"
                 %ifvar custom/runInCluster equals(true)%checked%endif%>
          Scheduled for cluster</input>
          %else%
          Not in cluster.
          %endif%
          </td>
        </tr>
-->
%endcomment%



        %ifvar smode%

          %switch type%

          %case 'once'%
<tr><td class="subHeading" colspan=7>One-Time Tasks</td></tr>
%ifvar type equals(once)%<input name="type" type="hidden" value="once" >%endif%
            <tr>
              <td class="oddrow" colspan=1>Date</td>
              <td class="oddrow-l" colspan=6>
              <input name="date" size=12 value="%value start-date%"> YYYY/MM/DD</input>
              </td>
            </tr>
            <tr>
              <td class="evenrow" colspan=1>Time</td>
              <td class="evenrow-l" colspan=6>
              <input name="time" size=12 value="%value start-time%"> HH:MM:SS </input>
              </td>
            </tr>
          %case 'repeat'%
            <tr><td class="subHeading" colspan=7>Repeating Tasks With a Simple Interval</td></tr>
%ifvar type equals(repeat)%<input name="type" type="hidden" value="repeat" >%endif%
            <tr>
              <td class="oddrow" >Start Date</td>
              <td class="oddrow-l" colspan=6>
              <input name="start-date" value="%value start-date%" size=12 > YYYY/MM/DD <i>(optional)</i></input>
              </td>
            </tr>
            <tr>
              <td class="evenrow" >Start Time</td>
              <td class="evenrow-l" colspan=6>
              <input name="start-time" value="%value start-time%" size=12 > HH:MM:SS <i>(optional)</i></input>
              </td>
            </tr>
            <tr>
              <td class="oddrow" >End Date</td>
              <td class="oddrow-l" colspan=6>
              <input name="end-date" value="%value end-date%" size=12 > YYYY/MM/DD <i>(optional)</i></input>
              </td>
            </tr>
            <tr>
              <td class="evenrow" >End Time</td>
              <td class="evenrow-l" colspan=6>
              <input name="end-time" value="%value end-time%" size=12 > HH:MM:SS <i>(optional)</i></input>
              </td>
            </tr>
			<tr>
			  <td class="oddrow" colspan=1>Repeating</td>
			  <td class="oddrow-l" colspan=5>
		  		<input type="checkbox" name="doNotOverlap" %ifvar doNotOverlap equals('true')%checked%endif% size=12 value="true"> Repeat after completion</input>
		  	  </td>

			</tr>
            <tr>
              <td class="evenrow" colspan=1>Interval</td>
              <td class="evenrow-l" colspan=6>
              <input name="interval" size=12 value="%value interval decimal(-3,0)%"> seconds</input><BR>
              </td>
            </tr>

          %case 'complex'%
<tr><td class="subHeading" colspan=7>Repeating Tasks with Complex Schedules</td></tr>
%ifvar type equals(complex)%<input name="type" type="hidden" value="complex">%endif%
            <tr>
              <td class="oddrow" >Start Date</td>
              <td class="oddrow-l" colspan=6>
              <input name="start-date" value="%value start-date%" size=12 > YYYY/MM/DD <i>(optional)</i></input>
              </td>
            </tr>
            <tr>
              <td class="evenrow" >Start Time</td>
              <td class="evenrow-l" colspan=6>
              <input name="start-time" value="%value start-time%" size=12 > HH:MM:SS <i>(optional)</i></input>
              </td>
            </tr>
            <tr>
              <td class="oddrow" >End Date</td>
              <td class="oddrow-l" colspan=6>
              <input name="end-date" value="%value end-date%" size=12 > YYYY/MM/DD <i>(optional)</i></input>
              </td>
            </tr>
            <tr>
              <td class="evenrow" >End Time</td>
              <td class="evenrow-l" colspan=6>
              <input name="end-time" value="%value end-time%" size=12 > HH:MM:SS <i>(optional)</i></input>
              </td>
            </tr>
			<tr>
			  <td class="oddrow" colspan=1>Repeating</td>
			  <td class="oddrow-l" colspan=5>
		  		<input type="checkbox" name="doNotOverlap" %ifvar doNotOverlap equals('true')%checked%endif% size=12 value="true"> Repeat after completion</input>
		  	  </td>

			</tr>
            <tr>
              <td class="evenrow" rowspan="3" >Run Mask</td><td class="evenrow-l" >Months</td><td class="evenrow-l" >Days</td><td class="evenrow-l" >Weekly Days</td><td class="evenrow-l" >Hours</td><td class="evenrow-l" >Minutes</td>
            </tr>
            <tr>

              <td class="evenrow-l" >
              <select name=month size=7 multiple>
              %loop moMask%<option value="%value idx%" %value selected%>%value name%</option>%endloop%
              </select>
              </td>
              <td class="evenrow-l">
              <select name="mo_day" size=7 multiple>
              %loop dayMoMask%<option value="%value idx%" %value selected%>%value name%</option>%endloop%
              </select>
              </td>
              <td class="evenrow-l">
              <select name="wk_day" size=7 multiple>
              %loop dayWkMask%<option value="%value idx%" %value selected%>%value name%</option>%endloop%
              </select>
              </td>
              <td class="evenrow-l">
              <select name="hour" size=7 multiple>
              %loop hourMask%<option value="%value idx%" %value selected%>%value name%</option>%endloop%
              </select>
              </td>
              <td class="evenrow-l">
              <select name="min" size=7 multiple>
              %loop minMask%<option value="%value idx%" %value selected%>%value name%</option>%endloop%
              </select>
              </td>
            </tr>
            <tr>
              <td class="evenrow" colspan=5>
              <i>Selecting no items is equivalent to selecting all items for a given list</i>
              </td>
            </tr>

          %endswitch%

        %else%
    <tr><td class="space" colspan="7">&nbsp;</td></tr>
    <tr><td class="heading" colspan=7>Schedule Type and Details</td></tr>
        <tr><td class="subHeading" colspan=7>One-Time Tasks</td></tr>
        <tr>
          <td class="oddrow-l" rowspan=2 valign="top">
            <input name="type" type="radio" onclick="validateLatesnessOptForType(this)" value="once" %ifvar type equals(once)%checked%endif%>Run Once</input>
          </td>
          <td class="oddrow" colspan=1>Date</td>
          <td class="oddrow-l" colspan=5>
            <input name="date" size=12 value="%value start-date%"> YYYY/MM/DD</input>
          </td>
        </tr>
        <tr>
          <td class="evenrow" colspan=1>Time</td>
          <td class="evenrow-l" colspan=5>
              <input name="time" size=12 value="%value start-time%"> HH:MM:SS </input>
          </td>
        </tr>
        <tr><td class="subHeading" colspan=7>Repeating Tasks With a Simple Interval</td></tr>
        <tr>
          <td class="oddrow-l" rowspan="6" valign="top">
            <input name="type" type="radio" onclick="validateLatesnessOptForType(this)" value="repeat" %ifvar type equals(repeat)%checked%endif%>Repeating</input>
          </td>
              <td class="oddrow" >Start Date</td>
              <td class="oddrow-l" colspan=6>
              <input name="start-date" value="%value start-date%" size=12 > YYYY/MM/DD <i>(optional)</i></input>
              </td>
    </tr>
            <tr>
              <td class="evenrow" >Start Time</td>
              <td class="evenrow-l" colspan=6>
              <input name="start-time" value="%value start-time%" size=12 > HH:MM:SS <i>(optional)</i></input>
              </td>
            </tr>
            <tr>
              <td class="oddrow" >End Date</td>
              <td class="oddrow-l" colspan=6>
              <input name="end-date" value="%value end-date%" size=12 > YYYY/MM/DD <i>(optional)</i></input>
              </td>
            </tr>
            <tr>
              <td class="evenrow" >End Time</td>
              <td class="evenrow-l" colspan=6>
              <input name="end-time" value="%value end-time%" size=12 > HH:MM:SS <i>(optional)</i></input>
              </td>
            </tr>
    <tr>
    <td class="oddrow" colspan=1>Repeating</td>
          <td class="oddrow-l" colspan=5>
            <input type="checkbox" name="doNotOverlap" size=12 value="true"> Repeat after completion</input>
          </td>

        </tr>
       <tr>
          <td class="evenrow" colspan=1>Interval</td>
          <td class="evenrow-l" colspan=5>
            <input name="interval" size=12 value="%value interval decimal(-3,0)%"> seconds</input><BR>

          </td>
        </tr>

        <tr><td class="subHeading" colspan=7>Repeating Tasks with Complex Schedules</td></tr>
        <tr>
          <td valign="top" class="oddrow-l" rowspan=8 valign="top">
            <input  name="type" type="radio" %ifvar mode equals('useradd')% checked %else% %ifvar type equals(complex)%checked%endif%%endif% onclick="validateLatesnessOptForType(this)" value="complex">Complex Repeating</input>
          </td>
          <td class="oddrow">Start Date</td>
          <td class="oddrow-l" colspan=6>
          <input name="sd2" size=12 > YYYY/MM/DD <i>(optional)</i></input>
          </td>
        </tr>
        <tr>
          <td class="evenrow">Start Time</td>
          <td class="evenrow-l" colspan=5>
          <input name="st2" size=12 > HH:MM:SS <i>(optional)</i></input>
          </td>
        </tr>
        <tr>
          <td class="oddrow">End Date</td>
          <td class="oddrow-l" colspan=6>
          <input name="ed2" size=12 > YYYY/MM/DD <i>(optional)</i></input>
          </td>
        </tr>
        <tr>
          <td class="evenrow">End Time</td>
          <td class="evenrow-l" colspan=6>
          <input name="et2" size=12 > HH:MM:SS <i>(optional)</i></input>
          </td>
        </tr>
		<tr>
          <td class="oddrow" colspan=1>Repeating</td>
          <td class="oddrow-l" colspan=5>
            <input type="checkbox" name="doNotOverlap" size=12 value="true"> Repeat after completion</input>
          </td>

        </tr>
        <tr>
          <td class="evenrow" rowspan=3>Run Mask</td><td class="evenrow-l">Months</td><td class="evenrow-l">Days</td><td class="evenrow-l">Weekly Days</td><td class="evenrow-l">Hours</td><td class="evenrow-l">Minutes</td>
        </tr>
        <tr>
          <td class="evenrow-l">
            <select name=month size=7 multiple>
            %loop moMask%<option value="%value idx%" %value selected%>%value name%</option>%endloop%
            </select>
          </td>
          <td class="evenrow-l">
            <select name="mo_day" size=7 multiple>
            %loop dayMoMask%<option value="%value idx%" %value selected%>%value name%</option>%endloop%
            </select>
          </td>
          <td class="evenrow-l">
            <select name="wk_day" size=7 multiple>
            %loop dayWkMask%<option value="%value idx%" %value selected%>%value name%</option>%endloop%
            </select>
          </td>
          <td class="evenrow-l">
            <select name="hour" size=7 multiple>
            %loop hourMask%<option value="%value idx%" %value selected%>%value name%</option>%endloop%
            </select>
          </td>
          <td class="evenrow-l">
            <select name="min" size=7 multiple>
            %loop minMask%<option value="%value idx%" %value selected%>%value name%</option>%endloop%
            </select>
          </td>
        </tr>
        <tr>
          <td class="evenrow" colspan=5>
          <i>Selecting no items is equivalent to selecting all items for a given list</i>
          </td>
        </tr>

        %endif%

          <tr>
            <td class="action" colspan=7>
              <input type="hidden" id="oid" name="oid" value="%value oid%"></input>
              <input type="hidden" name="schaction"></input>
              %ifvar smode%
              <input type="button" value="Update task" onclick="return onUpdate();"></input>
              %else%
              <input type="button" value="Save Tasks" onclick="return onAdd();"></input>
              %endif%
            </td>
          </tr>



        %endinvoke%

      </form>

    </table>
    </td>
  </tr>
</table>


%case%
<body onLoad="setNavigation('scheduler.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Server_SrvrSchedScrn');">

<!-- =========================== user =========================== -->

<!-- User tasks table -->
<table width="100%">
  <tr>
    <td class="menusection-Server" colspan="2">
      Server &gt;
      Scheduler
    </td>
  </tr>

  %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
	  %ifvar act%
		  %switch act%
			  %case 'CUT'%
				%ifvar msgType equals('success')%
					<tr><td class="message" colspan="2">Cancelled Task ID: %value message%</td></tr>
				%endif%	
				%ifvar msgType equals('error')%
					<tr><td class="message" colspan="2">Error cancelling task: %value message%</td></tr>
				%endif%	
			  %case 'SUT'%
				%ifvar msgType equals('success')%
					<tr><td class="message" colspan="2">Suspended Task ID: %value message%</td></tr>
				%endif%	
				%ifvar msgType equals('error')%
					<tr><td class="message" colspan="2">Error suspending task: %value message%</td></tr>
				%endif%
			  %case 'WUT'%
				%ifvar msgType equals('success')%
					<tr><td class="message" colspan="2">Woke Up Task ID: %value message%</td></tr>
				%endif%	
				%ifvar msgType equals('error')%
					<tr><td class="message" colspan="2">Error waking up task: %value message%</td></tr>
				%endif%
			  %case 'AUT'%
				%ifvar msgType equals('success')%
					<tr><td class="message" colspan="2">Added new task ID: %value message%</td></tr>
				%endif%	
				%ifvar msgType equals('error')%
					<tr><td class="message" colspan="2">Error scheduling task: %value message%</td></tr>
				%endif%
			  %case 'UUT'%
				%ifvar msgType equals('success')%
					<tr><td class="message" colspan="2">Updated task ID: %value message%</td></tr>
				%endif%	
				%ifvar msgType equals('error')%
					<tr><td class="message" colspan="2">Error updating task: %value message%</td></tr>
				%endif%
			  %case 'PSC'%
				%ifvar msgType equals('success')%
					<tr><td class="message" colspan="2">The Scheduler has been paused. No scheduled tasks will be initiated until the Scheduler is resumed.</td></tr>
				%endif%	
				%ifvar msgType equals('error')%
					<tr><td class="message" colspan="2">Error pausing Scheduler.</td></tr>
				%endif%
			  %case 'RSC'%
				%ifvar msgType equals('success')%
					<tr><td class="message" colspan="2">The Scheduler has been resumed.</td></tr>
				%endif%	
				%ifvar msgType equals('error')%
					<tr><td class="message" colspan="2">Error resuming Scheduler.</td></tr>
				%endif%
		  %endswitch%
		  %rename act oldACT%
		%else%
			<tr><td class="message" colspan="2">%value message%</td></tr>
		%endif%
	%endif%

    %ifvar schaction%
    %switch schaction%

    %case 'cancel'%
      <!-- =============== cancel =============== -->
      %invoke wm.server.schedule:cancelUserTask%
        <script>
			if(is_csrf_guard_enabled && needToInsertToken) {
				document.location.replace("scheduler.dsp?act=CUT&msgType=success&message=%value -urlencode oid%&filterTask=%value filterTask%&statusActive=%value statusActive%&thisISOnly=%value thisISOnly%&showAll=true&"+_csrfTokenNm_+"="+_csrfTokenVal_);
			} else {
				document.location.replace("scheduler.dsp?act=CUT&msgType=success&message=%value -urlencode oid%&filterTask=%value filterTask%&statusActive=%value statusActive%&thisISOnly=%value thisISOnly%&showAll=true");
			}
		</script>	
      %onerror%
        <script>
			if(is_csrf_guard_enabled && needToInsertToken) {
				document.location.replace("scheduler.dsp?act=CUT&msgType=error&message=%value -urlencode errorMessage%&"+_csrfTokenNm_+"="+_csrfTokenVal_);
			} else {
				document.location.replace("scheduler.dsp?act=CUT&msgType=error&message=%value -urlencode errorMessage%");
			}
		</script>
      %endinvoke%

    %case 'suspend'%
      <!-- =============== suspend =============== -->
      %invoke wm.server.schedule:suspendUserTask%
       %ifvar taskSuspended equals('true')%
	      <script>
			if(is_csrf_guard_enabled && needToInsertToken) {
				document.location.replace("scheduler.dsp?act=SUT&msgType=success&message=%value -urlencode oid%&filterTask=%value filterTask%&statusActive=%value statusActive&thisISOnly=%value thisISOnly%%&showAll=true&"+_csrfTokenNm_+"="+_csrfTokenVal_);
			} else {	
				document.location.replace("scheduler.dsp?act=SUT&msgType=success&message=%value -urlencode oid%&filterTask=%value filterTask%&statusActive=%value statusActive&thisISOnly=%value thisISOnly%%&showAll=true");
			}
		  </script>
	  %endif%
	  %ifvar taskSuspended equals('false')%
  	  	 <script>
			if(is_csrf_guard_enabled && needToInsertToken) {
				document.location.replace("scheduler.dsp?act=SUT&msgType=error&message=%value -urlencode errorMessage%&"+_csrfTokenNm_+"="+_csrfTokenVal_);
			} else {	
				document.location.replace("scheduler.dsp?act=SUT&msgType=error&message=%value -urlencode errorMessage%");
			}	
		</script>
  	  %endif%
      %onerror%
      <script>
			if(is_csrf_guard_enabled && needToInsertToken) {
				document.location.replace("scheduler.dsp?act=SUT&msgType=error&message=%value -urlencode errorMessage%&"+_csrfTokenNm_+"="+_csrfTokenVal_);
			} else {
				document.location.replace("scheduler.dsp?act=SUT&msgType=error&message=%value -urlencode errorMessage%");
			}	
	  </script>
      %endinvoke%

    %case 'wakeup'%
      <!-- =============== wakeup =============== -->
      %invoke wm.server.schedule:wakeupUserTask%
      <script>
			if(is_csrf_guard_enabled && needToInsertToken) {
				document.location.replace("scheduler.dsp?act=WUT&msgType=success&message=%value -urlencode oid%&filterTask=%value filterTask%&statusActive=%value statusActive%&thisISOnly=%value thisISOnly%&showAll=true&"+_csrfTokenNm_+"="+_csrfTokenVal_);
			} else {
				document.location.replace("scheduler.dsp?act=WUT&msgType=success&message=%value -urlencode oid%&filterTask=%value filterTask%&statusActive=%value statusActive%&thisISOnly=%value thisISOnly%&showAll=true");
			}
	  </script>
      %onerror%
      <script>
			if(is_csrf_guard_enabled && needToInsertToken) {
				document.location.replace("scheduler.dsp?act=WUT&msgType=error&message=%value -urlencode errorMessage%&"+_csrfTokenNm_+"="+_csrfTokenVal_);
			} else {
				document.location.replace("scheduler.dsp?act=WUT&msgType=error&message=%value -urlencode errorMessage%");
			}
 	   </script>
      %endinvoke%

    %case 'Add Task'%
      <!-- =============== Add Task =============== -->
      %invoke wm.server.schedule:addTask%
        <script>
			if(is_csrf_guard_enabled && needToInsertToken) {
				document.location.replace("scheduler.dsp?act=AUT&msgType=success&message=%value -urlencode oid%&"+_csrfTokenNm_+"="+_csrfTokenVal_);
			} else {
				document.location.replace("scheduler.dsp?act=AUT&msgType=success&message=%value -urlencode oid%");
			}
		</script>
      %onerror%
      <script>
			if(is_csrf_guard_enabled && needToInsertToken) {
				document.location.replace("scheduler.dsp?act=AUT&msgType=error&message=%value -urlencode errorMessage%&"+_csrfTokenNm_+"="+_csrfTokenVal_);
			} else {
				document.location.replace("scheduler.dsp?act=AUT&msgType=error&message=%value -urlencode errorMessage%");
			}
	  </script>
      %endinvoke%

    %case 'Update Task'%
      <!-- =============== Update Task =============== -->
      %invoke wm.server.schedule:updateTask%
      <script>
			if(is_csrf_guard_enabled && needToInsertToken) {
				document.location.replace("scheduler.dsp?act=UUT&msgType=success&message=%value -urlencode oid%&"+_csrfTokenNm_+"="+_csrfTokenVal_);
			} else {
				document.location.replace("scheduler.dsp?act=UUT&msgType=success&message=%value -urlencode oid%");
			}
	  </script>
      %onerror%
      <script>
			if(is_csrf_guard_enabled && needToInsertToken) {
				document.location.replace("scheduler.dsp?act=UUT&msgType=error&message=%value -urlencode errorMessage%&"+_csrfTokenNm_+"="+_csrfTokenVal_);
			} else {
				document.location.replace("scheduler.dsp?act=UUT&msgType=error&message=%value -urlencode errorMessage%");
			}
	  </script>
      %endinvoke%

    %case 'Pause Scheduler'%
      <!-- =============== Pause Scheduler =============== -->
      %invoke wm.server.schedule:pauseScheduler%
      <script>
			if(is_csrf_guard_enabled && needToInsertToken) {
				document.location.replace("scheduler.dsp?act=PSC&msgType=success&message=The Scheduler has been paused.  No scheduled tasks will be initiated until the Scheduler is resumed.&"+_csrfTokenNm_+"="+_csrfTokenVal_);
			} else {
				document.location.replace("scheduler.dsp?act=PSC&msgType=success&message=The Scheduler has been paused.  No scheduled tasks will be initiated until the Scheduler is resumed.");
			}
	  </script>
      %onerror%
      <script>
			if(is_csrf_guard_enabled && needToInsertToken) {
				document.location.replace("scheduler.dsp?act=PSC&msgType=error&message=Error pausing Scheduler.&"+_csrfTokenNm_+"="+_csrfTokenVal_);
			} else {
				document.location.replace("scheduler.dsp?act=PSC&msgType=error&message=Error pausing Scheduler.");
			}
	  </script>
      %endinvoke%

    %case 'Resume Scheduler'%
      <!-- =============== Pause Scheduler =============== -->
      %invoke wm.server.schedule:resumeScheduler%
      <script>
			if(is_csrf_guard_enabled && needToInsertToken) {
				document.location.replace("scheduler.dsp?act=RSC&msgType=success&message=The Scheduler has been resumed.&"+_csrfTokenNm_+"="+_csrfTokenVal_);
			} else {
				document.location.replace("scheduler.dsp?act=RSC&msgType=success&message=The Scheduler has been resumed.");
			}
	  </script>
      %onerror%
      <script>
			if(is_csrf_guard_enabled && needToInsertToken) {
				document.location.replace("scheduler.dsp?act=RSC&msgType=error&message=Error resuming Scheduler.&"+_csrfTokenNm_+"="+_csrfTokenVal_);
			} else {
				document.location.replace("scheduler.dsp?act=RSC&msgType=error&message=Error resuming Scheduler.");
			}	
	  </script>
      %endinvoke%

    %endswitch%
    %endif%



    <tr>
      <td colspan=2>
	<ul>
          %invoke wm.server.schedule:getSchedulerState%
          %ifvar state equals('running')%
            <li><a href="scheduler.dsp?schaction=Pause Scheduler" onclick="return confirmPause();">Pause Scheduler</a> (currently Running)</li>
          %else%
            <li><a href="scheduler.dsp?schaction=Resume Scheduler" onclick="return confirmResume();">Resume Scheduler</a> (currently Paused)</li>
		  %endif%
		  %endinvoke%
          <li><a href="scheduler.dsp?mode=sys">View System Tasks</a></li>
          <li><a href="scheduler.dsp?mode=useradd">Create a Scheduled Task</a></li>
	   <!-- 1-1RA0AX: Filter Services functionality -->
	    <li id="showfew" name="showfew"><a href="javascript:showFilterPanel(true)">Filter Services</a></li>
	    <li style="display:none" id="showall" name="showall"><a href="scheduler.dsp">Show All Services</a></li>

	    <DIV id="filterContainer" name="filterContainer" style="display:none;padding-top=2mm;">
				  <br>
				  <table>
				  <tr valign="top">
				  <td>
				  <span >Enter Complete/Part of Service Name</span><br>
				  <input type="text" name="filterTask" id="filterTask" value="%value filterTask%" onKeyPress="filterServices(event)"/>

				<IMG SRC="images/blank.gif" height=20 width=40>
				<input type="checkbox" id="statusActive" name="statusActive" %ifvar statusActive equals('true')%checked%endif% />

				<span id="statustitle" name="statustitle">Status is Active</span>

                <IMG SRC="images/blank.gif" height=20 width=40>
				<input type="checkbox" id="thisISOnly" name="thisISOnly" %ifvar thisISOnly equals('true')%checked%endif% />
				<span id="thisIStitle" name="thisIStitle">Hide Remote Tasks</span>

                </td> <td>
              <IMG SRC="images/blank.gif" height=20 width=40>
			  <input type="Button" id="submit" name="submit" value="Submit" onclick="refreshAndFilter()"/>
			  </td> </tr></table>
			  <TR><TD id="result" name="result" colspan="2" align="right"></TD></TR>
	</DIV><!--End of 1-1RA0AX changes-->

        </ul>
      </td>
    </tr>

    <tr>
      <td><img src="images/blank.gif" height=10 width=10 border=0></td>
      <td>
        <table class="tableView" width=100% id="head" name="head">
          %invoke wm.server.schedule:getUserTaskList%

          <tr><td class="heading" colspan=11>One-Time and Simple Interval Tasks</td></tr>
          <TR>
            <td class="oddcol">ID</td>
            <td class="oddcol">Service</td>
            <td class="oddcol" width="100px">Description</td>
            <td class="oddcol">Queue Name</td>
            <td class="oddcol">Last Error</td>
            <td class="oddcol" nowrap>Run As User</td>
            <td class="oddcol">Target</td>
            <td class="oddcol">Interval (sec)</td>
            <td class="oddcol">Next Run (sec)</td>
            <td class="oddcol">Status</td>
            <td class="oddcol">Remove</td>
          </tr>
          %ifvar -notempty tasks%
              <script>resetRows();</script>
          %loop tasks%
          <tr>
	          %ifvar parentID%%value%
               	<script>writeTD("childrow");</script>
			  %else%
              	<script>writeTD("rowdata-l");</script>
    		  %endif%
              %value oid%</td>

              %ifvar parentID%%value%
               	<script>writeTD("childrow");</script>
	              	%value name%</td>
			  %else%
              	<script>writeTD("rowdata-l");</script>
    	        	<a href="scheduler.dsp?mode=useradd&oid=%value oid%&smode=Edit">%value name%</a></td>
			  %endif%

              %ifvar parentID%%value%
               	<script>writeTD("childrow");</script>
			  %else%
              	<script>writeTD("rowdata-l");</script>
    		  %endif%
              %value description%</td>

              %ifvar parentID%%value%
               	<script>writeTD("childrow");</script>
			  %else%
              	<script>writeTD("rowdata-l");</script>
    		  %endif%
              %ifvar qName%%value qName%%else%N/A%endif%</td>

			  %ifvar parentID%%value%
               	<script>writeTD("childrow");</script>
			  %else%
              	<script>writeTD("rowdata-l");</script>
    		  %endif%
              %ifvar lastError%%value lastError%%else%N/A%endif%</td>

              %ifvar parentID%%value%
               	<script>writeTD("childrow");</script>
			  %else%
              	<script>writeTD("rowdata-l");</script>
    		  %endif%
              %value runAsUser%</td>

              %ifvar target equals('$all')%
	              %ifvar parentID%%value%
	               	<script>writeTD("childrow");</script>
				  %else%
        	      	<script>writeTD("rowdata-l");</script>
    			  %endif%
	              All Servers</td>
	          %else%
	          	 %ifvar target equals('$any')%
	          	 	%ifvar parentID%%value%
		               	<script>writeTD("childrow");</script>
					%else%
	              		<script>writeTD("rowdata-l");</script>
	    		  	%endif%
	              	Any Server</td>
		         %else%
	              %ifvar parentID%%value%
	               	<script>writeTD("childrow");</script>
				  %else%
            	  	<script>writeTD("rowdata-l");</script>
	    		  %endif%
                  %value target%</td>
    	      	%endif%
			  %endif%

              %ifvar parentID%%value%
               	<script>writeTD("childrow");</script>
			  %else%
	          	<script>writeTD("rowdata-l");</script>
	    	  %endif%
              %ifvar interval equals(0)%once%else%%value interval decimal(-3,1)% %endif%</td>

			%ifvar schedState equals('expired')%
              		<script>writeTD("rowdata");</script>--</td>

	              	%ifvar parentID%%value%
		               	<script>writeTD("childrow");</script>
					%else%
	              		<script>writeTD("rowdata-l");</script>
	    		  	%endif%
                  	<a href="javascript:redirectPage('wakeup','%value oid%')" onclick="alert('Cannot activate expired task.  The end date and time must be in the future.'); return false;">Expired</a></td>
		    %else%
              %ifvar execState equals('suspended')%
               		<script>writeTD("rowdata");</script>--</td>

	                %ifvar parentID%%value%
		               	<script>writeTD("childrow");</script>
					%else%
	              		<script>writeTD("rowdata-l");</script>
	    		  	%endif%
                    <a href="javascript:redirectPage('wakeup','%value oid%')" onclick="return confirm('Are you sure you want to activate this task?');">Suspended</a></td>
              %else%
	                %ifvar %value parentID%%
		               	<script>writeTD("childrow");</script>
					%else%
	              		<script>writeTD("rowdata-l");</script>
	    		  	%endif%
                    %ifvar target equals('$all')% N/A %else%  %value msDelta decimal(-3,1)% %endif% </td>

	                %ifvar parentID%%value%
		               	<script>writeTD("childrow");</script>
					%else%
	              		<script>writeTD("rowdata-l");</script>
	    		  	%endif%
                    <a href="javascript:redirectPage('suspend','%value oid%')" onclick="return confirm('Are you sure you want to suspend task?');"><img src="images/green_check.gif" border=0>%ifvar execState equals('running')%Running%else%Active%endif%</a></td>
			  %endif%
            %endif%

            <script>writeTD("rowdata");</script>
                 <a class="imagelink" href="javascript:redirectPage('cancel','%value oid%')" onclick="return confirm('Are you sure you want to remove this task?');"><img src="icons/delete.gif" border=0></a></td>
          </tr>
		  <!--tr>
		  <td class="row" colspan=1></td>
		     <td class="row" colspan=1>%value description%</td>
			 <td class="row" colspan=6>Last Error: %ifvar lastError%%value lastError%%else%N/A%endif%</td>
		  </tr-->
              <script>swapRows();</script>
          %endloop%
          %else%
           %ifvar error%
           <tr><td class="evenrow-l" colspan=11>%value error%</td></tr>
           %else%
             <tr><td class="evenrow-l" colspan=11>No tasks are currently scheduled</td></tr>
           %endif%
          %endif%

          <tr><td class="space" colspan="11">&nbsp;</td></tr>

          <tr><td class="heading" colspan=11>Complex Repeating Tasks</td></tr>
          <TR>
            <td class="oddcol">ID</td>
            <td class="oddcol">Service</td>
            <td class="oddcol" width="100px">Description</td>
            <td class="oddcol">Queue Name</td>
            <td class="oddcol">Last Error</td>
            <td class="oddcol" nowrap>Run As User</td>
            <td class="oddcol">Target</td>
            <td class="oddcol">Interval Masks</td>
            <td class="oddcol">Next Run (sec)</td>
            <td class="oddcol">Status</td>
            <td class="oddcol">Remove</td>
          </tr>
          %ifvar -notempty extTasks%
              <script>resetRows();</script>
          %loop extTasks%
          <tr>
               %ifvar parentID%%value%
               	<script>writeTD("childrow");</script>
			  %else%
              	<script>writeTD("rowdata-l");</script>
    		  %endif%
              %value oid%</td>

              %ifvar parentID%%value%
               	<script>writeTD("childrow");</script>
	              	%value name%</td>
			  %else%
              	<script>writeTD("rowdata-l");</script>
    	        	<a href="scheduler.dsp?mode=useradd&oid=%value oid%&smode=Edit">%value name%</a></td>
			  %endif%

              %ifvar parentID%%value%
               	<script>writeTD("childrow");</script>
			  %else%
              	<script>writeTD("rowdata-l");</script>
    		  %endif%
              %value description%</td>

              %ifvar parentID%%value%
               	<script>writeTD("childrow");</script>
			  %else%
              	<script>writeTD("rowdata-l");</script>
    		  %endif%
			  %ifvar qName%%value qName%%else%N/A%endif%</td>

			  %ifvar parentID%%value%
               	<script>writeTD("childrow");</script>
			  %else%
              	<script>writeTD("rowdata-l");</script>
    		  %endif%
              %ifvar lastError%%value lastError%%else%N/A%endif%</td>

              %ifvar parentID%%value%
               	<script>writeTD("childrow");</script>
			  %else%
              	<script>writeTD("rowdata-l");</script>
    		  %endif%
              %value runAsUser%</td>

              %ifvar target equals('$all')%
	              %ifvar parentID%%value%
	               	<script>writeTD("childrow");</script>
				  %else%
        	      	<script>writeTD("rowdata-l");</script>
    			  %endif%
	              All Servers</td>
	          %else%
	          	 %ifvar target equals('$any')%
	          	 	%ifvar parentID%%value%
	               		<script>writeTD("childrow");</script>
				  	%else%
	              		<script>writeTD("rowdata-l");</script>
	    		  	%endif%
	              	Any Server</td>
		         %else%
	              %ifvar parentID%%value%
	               	<script>writeTD("childrow");</script>
				  %else%
        	      	<script>writeTD("rowdata-l");</script>
    			  %endif%
    	          %value target%</td>
    	      	%endif%
			  %endif%
	      <TD class="rowdata" colspan="1" style="padding: 0px;">
								<table width="100%" class="tableInline" cellspacing="1" style="background-color: #ffffff">
									<tr>
										<script>writeTD("row");</script>
											Months
										</td>
										%ifvar parentID%%value%
	               	<script>writeTD("childrow");</script>
				  %else%
        	      	<script>writeTD("rowdata-l");</script>
    			  %endif%
		    %ifvar monthMaskAlt%
		    %value monthMaskAlt%
		    %else%
		    January..December
		    %endif%
										</td>
									</tr>
									<tr>
										<script>writeTD("row");</script>
											Days
                  	</td>
										%ifvar parentID%%value%
	               	<script>writeTD("childrow");</script>
				  %else%
        	      	<script>writeTD("rowdata-l");</script>
    			  %endif%
		    %ifvar dayOfMonthMaskAlt%
		    %value dayOfMonthMaskAlt%
		    %else%
		    1..31
		    %endif%
										</td>
									</tr>
									<tr>
										<script>writeTD("row");</script>
											Days&nbsp;of Week
										</td>
										%ifvar parentID%%value%
	               	<script>writeTD("childrow");</script>
				  %else%
        	      	<script>writeTD("rowdata-l");</script>
    			  %endif%
		    %ifvar dayOfWeekMaskAlt%
		    %value dayOfWeekMaskAlt%
		    %else%
		    Sunday..Saturday
		    %endif%
										</td>
									</tr>
									<tr>
										<script>writeTD("row");</script>
                  		Hours
                  	</td>
										%ifvar parentID%%value%
	               	<script>writeTD("childrow");</script>
				  %else%
        	      	<script>writeTD("rowdata-l");</script>
    			  %endif%
		    %ifvar hourMaskAlt%
		    %value hourMaskAlt%
		    %else%
		    0..23
		    %endif%
										</td>
									</tr>
									<tr>
										<script>writeTD("row");</script>
											Minutes
                  	</td>
										%ifvar parentID%%value%
	               	<script>writeTD("childrow");</script>
				  %else%
        	      	<script>writeTD("rowdata-l");</script>
    			  %endif%
		    %ifvar minuteMaskAlt%
		    %value minuteMaskAlt%
		    %else%
		    0..59
		    %endif%
										</td>
									</tr>
								</table>
							</td>

			%ifvar schedState equals('expired')%
              <script>writeTD("rowdata");</script>
                  --</td>
              %ifvar parentID%%value%
	               	<script>writeTD("childrow");</script>
				  %else%
        	      	<script>writeTD("rowdata-l");</script>
    			  %endif%
                  <a href="javascript:redirectPage('wakeup','%value oid%')" onclick="alert('Cannot activate expired task.  The end date and time must be in the future.'); return false;">Expired</a></td>
		    %else%
              %ifvar execState equals('suspended')%
                <script>writeTD("rowdata");</script>
                    --</td>
                %ifvar parentID%%value%
	               	<script>writeTD("childrow");</script>
				  %else%
        	      	<script>writeTD("rowdata-l");</script>
    			  %endif%
                    <a href="javascript:redirectPage('wakeup','%value oid%')" onclick="return confirm('Are you sure you want to activate this task?');">Suspended</a></td>
              %else%
                %ifvar parentID%%value%
	               	<script>writeTD("childrow");</script>
				  %else%
        	      	<script>writeTD("rowdata-l");</script>
    			  %endif%
                  %ifvar target equals('$all')% N/A %else%  %value msDelta decimal(-3,1)% %endif% </td>
                %ifvar parentID%%value%
	               	<script>writeTD("childrow");</script>
				  %else%
        	      	<script>writeTD("rowdata-l");</script>
    			  %endif%
                    <a href="javascript:redirectPage('suspend','%value oid%')" onclick="return confirm('Are you sure you want to suspend task?');"><img src="images/green_check.gif" border=0>%ifvar execState equals('running')%Running%else%Active%endif%</a></td>
			  %endif%
            %endif%

              %ifvar parentID%%value%
	               	<script>writeTD("childrow");</script>
				  %else%
        	      	<script>writeTD("rowdata-l");</script>
    			  %endif%
                  <a class="imagelink" href="javascript:redirectPage('cancel','%value oid%')" onclick="return confirm('Are you sure you want to remove this task?');"><img src="icons/delete.gif" border=0></a></td>
          </tr>
              <script>swapRows();</script>
          %endloop%
          %else%
           %ifvar error%
           <tr><td class="evenrow-l" colspan=11>%value error%</td></tr>
           %else%
             <tr><td class="evenrow-l" colspan=11>No tasks are currently scheduled</td></tr>
           %endif%
          %endif%


          %endinvoke%
         <script>filterServicesInternal();</script>
         %ifvar showAll%<script>showFilterPanel()</script>%endif%
          </table>
      %endswitch%

        </td>
      </tr>
    </table>



</body>
</html>

