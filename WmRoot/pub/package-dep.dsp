<HTML>

<HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


%include webMethods.css%
</HEAD>

<BODY>

<TABLE width="100%"><TR><TD>
<TABLE width="100%">

<TR><td class="title" colspan=3>Dependencies for '%value package%' Package</td>
    </TR>

%ifvar action%
%switch action%
%case 'add'%
  %invoke wm.server.packages:addDepend%
  <TR><td id="message" colspan=3>%value none message%</td></TR>
  %endinvoke%
%case 'delete'%
  %invoke wm.server.packages:delDepend%
  <TR><td id="message" colspan=3>%value none message%</td></TR>
  %endinvoke%
%case%
  %invoke wm.server.packages:delDepend%
  <TR><td id="message" colspan=3>%value none message%</td></TR>
  %endinvoke%
%endswitch%
%endif%

%invoke wm.server.packages.adminui:packageInfo%

<SCRIPT LANGUAGE="JavaScript">
  function confirmIt (verb, list)
  {
    var isAdd = (verb == "add");
    var isDeny = (list == "deny");
    if (isAdd) {
      var form = document.allowadd;
      var elt = form.allow;
      if (elt.value == "") {
        alert ("Specify package name and version number to add\nto dependency list.");
      } else {
        form.submit();
        return true;
      }
    } else {
      var form = document.allowdelete;
      var elt = form.depends;
      if (elt.selectedIndex < 0) {
        alert ("Select package to remove\nfrom dependency list.");
      } else {
        form.submit();
        return true;
      }
    }
    return false;
  }
</SCRIPT>

  <TR class="heading"><td colspan=3>Edit Package Dependencies</td>
    </TR>
  <TR><TD valign=top width=24% class="coldata">
    <FORM NAME="allowdelete" ACTION="package-dep.dsp" METHOD="POST">
    <INPUT TYPE="hidden" NAME="action" VALUE="delete">
    <INPUT type="hidden" name="package" value="%value package%">

      <SELECT SIZE=8 WIDTH=150 NAME="depends" MULTIPLE>
      %loop successors%
        <OPTION value="%value%">%value%</OPTION>
      %endloop%
      </SELECT><BR>

    </FORM>
    </TD>

    <TD class="coltext" valign="top" colspan=2>
    <FORM NAME="allowadd" ACTION="package-dep.dsp" METHOD="POST">
    <INPUT TYPE="hidden" NAME="action" VALUE="add">
      <INPUT type="hidden" name="package" value="%value package%">

      <INPUT TYPE="button" VALUE="Add dependency" ONCLICK="confirmIt('add', 'allow');"></INPUT><BR>
      <INPUT NAME="allow" VALUE=""></INPUT>&nbsp;Example: <i>package_name</i>; <i>version number</i><P>
      <P>&nbsp;<P>
      <INPUT TYPE="button" VALUE="Delete selected dependency"
        ONCLICK="confirmIt ('delete', 'allow');">
      </INPUT>
    </FORM><P>
    </TD>
    </TR>

</TABLE>
</TD></TR></TABLE>

</BODY>

</HTML>
