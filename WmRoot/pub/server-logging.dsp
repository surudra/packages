<HTML>

<HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
<script src="csrf-guard.js.txt"></script>

%include webMethods.css%
</HEAD>

%switch 'doc'%





%case 'edit'%

<FRAMESET rows="100,*" border="0">
  <FRAME src="server-logging.dsp?doc=editbuttons&component=%value component%" scrolling="no">
  <FRAME src="server-logging.dsp?doc=editbody&component=%value component%" name="main">
</FRAMESET>










%case 'editbuttons'%
%scope param(independent='yes') param(title='Logging Settings') param(cancelUrl='server-logging.dsp')%
%include dynamic-formtop.dsp%
%endscope%







%case 'editbody'%

<BODY>

<TABLE width="100%"><TR><TD>
<TABLE width="100%">

%invoke wm.server.query:getSettings%

<SCRIPT LANGUAGE="JavaScript">
  var membership = new Array (%loop Facs% "%value Value%" %loopsep ', '% %endloop%);
  function enableAll()
  {
    var optlist = document.logform.facility.options;
    for (var i=0; i<membership.length; i++) {
          optlist[i].selected = true;
    }
  }
  function disableAll()
  {
    var optlist = document.logform.facility.options;
    for (var i=0; i<membership.length; i++) {
          optlist[i].selected = false;
    }
  }
</SCRIPT>

<FORM name="logform" action="server-logging.dsp" method="POST" target="_parent">

<INPUT type="hidden" name="action" value="change">
<INPUT type="hidden" name="setLogSettings" value="setLogSettings">
<INPUT type="hidden" name="component" value="%value component%">

<tr><td class="heading" colspan=2>Logging</td></tr>

<tr><td class="rowlabel">Log Level (1-10)</td>
  <td class="rowdata" width="70%">
  <INPUT name="watt.debug.level" value="%value DebugLevel%" size=30></INPUT>
  </td>
  </tr>

<tr><td class="rowlabel">Facilities </td>
  <td class="rowdata" width="70%">
  <SELECT name="facility" multiple size=9 width=180>
  %loop Facs%
  <OPTION value="%value Value%" %ifvar Selected% selected %endif%>%value Fac% %value FacDesc%</OPTION>
  %endloop%
  </SELECT>
  </td>
  </tr>

</FORM>

%endinvoke%

</TABLE>
</TD></TR></TABLE>

<FORM>
<div class="position">
    <INPUT type="button" value="Enable all" onclick="enableAll();">
    <INPUT type="button" value="Disable all" onclick="disableAll();">
</div>
</FORM>

</BODY>































%case%

<BODY>

<SCRIPT LANGUAGE="JavaScript">
function typeChange () {
  var typeSel = document.chooseform.selectComponent;
  var selectedType = typeSel.options[typeSel.selectedIndex].value;

  var loc = "server-logging.dsp?component="+selectedType;
  if(is_csrf_guard_enabled && needToInsertToken) {
	document.location = loc+"&"+_csrfTokenNm_+"="+_csrfTokenVal_;
  } else {
	document.location = loc;
  }

}
</SCRIPT>

<SCRIPT LANGUAGE="JavaScript">
function onEdit () {
  var typeSel = document.chooseform.selectComponent;
  var selectedType = typeSel.options[typeSel.selectedIndex].value;

  var loc = "server-logging.dsp?doc=edit&component="+selectedType;
  if(is_csrf_guard_enabled && needToInsertToken) {
	document.location = loc+"&"+_csrfTokenNm_+"="+_csrfTokenVal_;
  } else {
	document.location = loc;
  }
}
</SCRIPT>



<TABLE width="100%"><TR><TD>
<TABLE width="100%">

<tr><td class="title" colspan=2>Logging Settings</td></tr>

<FORM name="logform" action="stats-getlog.dsp" method="POST">
<INPUT type="hidden" name="log" value="xxx">
<tr><td class="action" colspan=2>
    <INPUT type="button" value="Edit these settings" onclick="onEdit();">
  </td></tr>
</FORM>

%ifvar action equals('change')%
%invoke wm.server.admin:setSettings%
<tr><td id="message" colspan=2>%value message%</td></tr>
%endinvoke%
%endif%

%invoke wm.server.query:getSettings%

<tr><td class="heading" colspan=2>Logging</td></tr>

<FORM name="chooseform" action="server-logging.dsp" method="POST">
<TR><TD class="rowlabel">Component</td>
  <TD class="rowdata" width="80%">
    <SELECT name="selectComponent" onchange="typeChange();">
    %loop components%
        <OPTION value="%value dbgComp%" %ifvar selected% selected %endif% >%value dbgComp%</OPTION>
    %endloop%
    </SELECT>
  </TD>
</TR>
</FORM>

<tr><td class="rowlabel">Log Level (1-10)</td>
  <td class="rowdata" width="80%">
  %value DebugLevel%
  </td>
  </tr>

<tr><td class="rowlabel">Facilities </td>
  <td class="rowdata" width="80%">
  %loop Facs% %ifvar Selected% %value Fac% %value FacDesc%<BR> %endif% %endloop%
  </td>
  </tr>


%endinvoke%

</TABLE>
</TD></TR></TABLE>

</BODY>


%endswitch%










</HTML>
