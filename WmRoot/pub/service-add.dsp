<HTML>
	<HEAD>
	<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
	<META HTTP-EQUIV="Expires" CONTENT="-1">
	<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
	<script src="csrf-guard.js.txt"></script>
<SCRIPT LANGUAGE="JavaScript">

  var pkg = "";
  var svcname = "";

  function confirmAdd () {
    var pkgSelect = document.addform.elements[3];
    pkg = pkgSelect.options[pkgSelect.selectedIndex].value;
    var ifc = document.addform.elements[4].value;
    var svc = document.addform.service.value;
    svcname = "";

    if (svc == "") {
      alert ("Specify service name.");
      return false;
    } else if (svc.indexOf(':') < 0 && ifc == "") {
      var msg = "Specify fully-qualified service name\n(i.e. ifc.ifc:service) or specify\ninterface name.";
      alert (msg);
      return false;
    }

    if (svc.indexOf(':') >= 0)
      svcname = svc;
    else svcname = ifc + ":" + svc;

    var msg = "OK to add '"+svcname+"' service to '"+pkg+"'  package?";
    return confirm (msg);
  }

  function onClick (action) {
    if (action == "reset") {
		if(is_csrf_guard_enabled && needToInsertToken) {
			document.location="service-add.dsp?"+_csrfTokenNm_+"="+_csrfTokenVal_;
		} else {
			document.location="service-add.dsp";
		}
    } else if (action == "submit" && confirmAdd()) {
      document.addform.submit();
    }
  }

  function typeChange () {
    var typeSel = document.forms[0].serviceType;
    var selectedType = typeSel.options[typeSel.selectedIndex].value;
    if (selectedType == "java") {
		if(is_csrf_guard_enabled && needToInsertToken) {
			document.location = "service-add.dsp?type=java&"+_csrfTokenNm_+"="+_csrfTokenVal_;
		} else {
			document.location = "service-add.dsp?type=java";
		}
    } else {
		if(is_csrf_guard_enabled && needToInsertToken) {
			document.location = "service-add.dsp?"+_csrfTokenNm_+"="+_csrfTokenVal_;
		} else {
			document.location = "service-add.dsp";
		}
    }
  }

</SCRIPT>
</HEAD>

<BODY>
	<TABLE width="100%">
		<TR>
			<TD class="menusection-Packages" colspan=2>
				Packages &gt;
				Services &gt;
				Register New Service
			</TD>
		</TR>

<FORM name="addform" action="service-add.dsp" method="POST">
		<tr>
			<td>
				&nbsp;
			</td>
		</tr>
		<TR>
			<TD>
				<TABLE>
		  		<TR>
		  			<td class="heading" colspan=2>
		  				Register New Service
		  			</td>
		  		</TR>

%ifvar action equals('add')%
%invoke wm.server.services:serviceAdd%
  %ifvar message%
  <TR><td id="message" colspan=2>%value message%</td></TR>
  %endif%
%endinvoke%
%endif%

  <TR><td class="rowlabel">Service Class</td>
      <TD class="rowdata">
    <SELECT name="serviceType" onchange="typeChange();">
      <OPTION value="java" %ifvar type equals('java')%selected%endif%>Java Service</OPTION>
      <OPTION value="flow" %ifvar type equals('java')%%else%selected%endif%>Flow Service</OPTION>
    </SELECT>
    </TD>
    </TR>

      <td class="rowlabel" width=28%>Package</td>
    <TD class="rowdata">
    <SELECT name="package">
    %invoke wm.server.packages:packageList%
    %loop packages%
      <OPTION value="%value name%">%value name%</OPTION>
    %endloop%
    %endinvoke%
    </SELECT>
    </TD>
    </TR>

  <TR><td class="rowlabel" width=28%>Interface Name</td>
    <TD class="rowdata">
    <INPUT size=41 name="interface"></INPUT>
    </TD>
    </TR>

  <TR><td class="rowlabel" width=28%>Service Name</td>
    <TD class="rowdata">
    <INPUT size=41 name="service"></INPUT>
    </TD>
    </TR>

%switch type%

%case 'java'%

  <TR class="heading"><td colspan=2>Java-Specific Parameters</td></TR>

  <TR><td class="rowlabel" width=28%>Class</td>
    <TD class="rowdata">
    <INPUT size=41 name="class"></INPUT>
    </TD>
    </TR>

  <TR><td class="rowlabel" width=28%>Method</td>
    <TD class="rowdata">
    <INPUT size=41 name="method"></INPUT>
    </TD>
    </TR>

%endswitch%

				  <TR>
				  	<TD class="action" colspan=2>
    					<INPUT type="button" value="Save Changes" onclick="onClick('submit');"></INPUT>
    				</TD>
    			</TR>
  <INPUT type="hidden" name="action" value="add">

</TABLE>
</TD></TR></TABLE>
</FORM>


</BODY>

</HTML>
