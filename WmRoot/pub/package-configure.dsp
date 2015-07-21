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

  <TR><td class="title" colspan=3>Startup/Shutdown/Replication Services for %value package%</td>
    </TR>

%ifvar action%
%switch action%
%case 'shdelete'%
  %invoke wm.server.packages:packageRemoveShutdownService%
  <TR><td id="message" colspan=3>%value encode(htmlall) message%</td></TR>
  %endinvoke%
%case 'shadd'%
  %invoke wm.server.packages:packageAddShutdownService%
  <TR><td id="message" colspan=3>%value encode(htmlall) message%</td></TR>
  %endinvoke%
%case 'stdelete'%
  %invoke wm.server.packages:packageRemoveStartupService%
  <TR><td id="message" colspan=3>%value encode(htmlall) message%</td></TR>
  %endinvoke%
%case 'stadd'%
  %invoke wm.server.packages:packageAddStartupService%
  <TR><td id="message" colspan=3>%value encode(htmlall) message%</td></TR>
  %endinvoke%
%case 'rpadd'%
  %invoke wm.server.packages:packageAddReplicationService%
  <TR><td id="message" colspan=3>%value encode(htmlall) message%</td></TR>
  %endinvoke%
%case 'rpdelete'%
  %invoke wm.server.packages:packageRemoveReplicationService%
  <TR><td id="message" colspan=3>%value encode(htmlall) message%</td></TR>
  %endinvoke%
%endswitch%
%endif%

%invoke wm.server.packages.adminui:packageInfo%

  <TR><td class="heading" colspan=3>Startup Services</td>
    </TR>

  <TR><TD valign=top class="coldata">
    <FORM NAME="stdelete" ACTION="package-configure.dsp" METHOD="POST">
      <INPUT TYPE="hidden" NAME="action" VALUE="stdelete">
      <INPUT TYPE="hidden" NAME="package" VALUE="%value package%">
      <SELECT SIZE=7 WIDTH=150 NAME="service" MULTIPLE>
      %loop startupServices%
        <OPTION value="%value%">%value%</OPTION>
      %endloop%
      </SELECT>
    </FORM>
    </TD>

    <TD valign="top" class="rowdata" colspan=2>
    <FORM NAME="stadd" ACTION="package-configure.dsp" METHOD="POST">
      <INPUT TYPE="hidden" NAME="action" VALUE="stadd">
      <INPUT TYPE="hidden" NAME="package" VALUE="%value package%">
      %ifvar loadok equals('0')%
        <B>No services available in this package.</B>
      %else%
        <INPUT TYPE="button" VALUE="Add this service:" ONCLICK="document.stadd.submit();"></INPUT><BR>
        <SELECT WIDTH=150 NAME="service">
        %loop allSvcsMinusStarts%
          <OPTION value="%value%">%value%</OPTION>
        %endloop%
        </SELECT><P>
        <INPUT TYPE="button" VALUE="Delete selected services" ONCLICK="document.stdelete.submit();"></INPUT>
      %endif%
    </FORM>
    </TR>


  <TR class="heading"><td colspan=3>Shutdown Services</td></TR>
  <TR><TD valign=top class="coldata">
    <FORM NAME="shdelete" ACTION="package-configure.dsp" METHOD="POST">
      <INPUT TYPE="hidden" NAME="action" VALUE="shdelete">
      <INPUT TYPE="hidden" NAME="package" VALUE="%value package%">
      <SELECT SIZE=7 WIDTH=150 NAME="service" MULTIPLE>
      %loop shutdownServices%
        <OPTION value="%value%">%value%</OPTION>
      %endloop%
      </SELECT>
    </FORM>
    </TD>
    <TD valign="top" class="data" colspan=2>
    <FORM NAME="shadd" ACTION="package-configure.dsp" METHOD="POST">
      <INPUT TYPE="hidden" NAME="action" VALUE="shadd">
      <INPUT TYPE="hidden" NAME="package" VALUE="%value package%">
      %ifvar loadok equals('0')%
        <B>No services available in this package.</B>
      %else%
        <INPUT TYPE="button" VALUE="Add this service:" ONCLICK="document.shadd.submit();"></INPUT><BR>
        <SELECT WIDTH=150 NAME="service">
        %loop allSvcsMinusShuts%
          <OPTION value="%value%">%value%</OPTION>
        %endloop%
        </SELECT><P>
        <INPUT TYPE="button" VALUE="Delete selected services" ONCLICK="document.shdelete.submit();"></INPUT>
      %endif%
    </FORM>

    </TD>
    </TR>
    <TR>
      <td class="heading" colspan=3>Replication Services</td>
    </TR>
    <TR>
      <TD valign=top class="coldata">
      <FORM NAME="rpdelete" ACTION="package-configure.dsp" METHOD="POST">
        <INPUT TYPE="hidden" NAME="action" VALUE="rpdelete">
        <INPUT TYPE="hidden" NAME="package" VALUE="%value package%">
        <SELECT SIZE=7 WIDTH=150 NAME="service" MULTIPLE>
        %loop replicationServices%
          <OPTION value="%value%">%value%</OPTION>
        %endloop%
        </SELECT>
      </FORM>
      </TD>
      <TD valign="top" class="data" colspan=2>
      <FORM NAME="rpadd" ACTION="package-configure.dsp" METHOD="POST">
        <INPUT TYPE="hidden" NAME="action" VALUE="rpadd">
        <INPUT TYPE="hidden" NAME="package" VALUE="%value package%">
        <INPUT TYPE="button" VALUE="Add this service:" ONCLICK="document.rpadd.submit();"></INPUT><BR>
        <INPUT NAME="service" WIDTH=150>
          <P>
        <INPUT TYPE="button" VALUE="Delete selected services" ONCLICK="document.rpdelete.submit();"></INPUT>
      </FORM>
      </TD>
    </TR>
%endinvoke%

</TABLE>
</TD></TR></TABLE>


</BODY>





</HTML>
