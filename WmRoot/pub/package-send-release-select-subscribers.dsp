<HTML>
  <HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


    <TITLE>Integration Server</TITLE>

    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt"></SCRIPT>

  </HEAD>
  <BODY>
    <TABLE width="100%">
      <TR>
        <TD class="menusection-Packages" colspan=2>
          Packages &gt;
          Publishing &gt;
          Send Release
        </TD>
      </TR>
      <TR>
        <TD colspan=2>
          <UL>
            <LI><A HREF="package-exchange.dsp">Return to Publishing</A></LI>
          </UL>
        </TD>
      </TR>
      <TR>
        <TD><IMG src="images/blank.gif" height=10 width=10 border=0></TD>
        <TD>
          <TABLE class="tableView">
            <TR>
              <TD class="heading" colspan=3>Subscribers</TD>
            </TR>
            <TR>
              <TD class="oddrow">Package</TD>
              <TD class="oddrowdata-l" colspan=2>%value package%</TD>
            </TR>
            <TR>
              <TD class="evenrow">Release</TD>
              <TD class="evenrowdata-l" colspan=2>%value release%</TD>
            </TR>

    <script>
    function selectAll(form, checkboxes, checked)
    {
     for (index in checkboxes)
     {
       document.forms[form][checkboxes[index]].checked = checked;
     }
    }

    function onSend(form, checkboxes)
    {
      var cnt = 0;
      for ( index in checkboxes)
      {
        if( document.forms[form][checkboxes[index]].checked == true )
          cnt ++;
      }

      if ( cnt < 1 ) {
        alert("Select a Subscriber first.");
        return false;
      }
      else
        return true;
    }
    var checkboxArray1 = [];

    </script>

            <form action="package-exchange.dsp" name="sendform">
            <input type="hidden" name="action" value="sendrelease">
            <input type="hidden" name="package" value="%value package%">
            <input type="hidden" name="release" value="%value release%">
            <TR>
              <TD class="oddrow">Subscribers</TD>
              <TD class="oddrowdata-l">
                %invoke wm.server.replicator:publishedList%
                    %loop published%
                    %ifvar ../package vequals(package)%
                <script>checkboxArray1 = [%loop subscribers%'sub-%value%'%loopsep ', '%%endloop%];</script>

          %ifvar subscribers%
                      %loop subscribers%
                <input type="checkbox" name="sub-%value%" value="%value%" checked>%value%</input><BR>
                      %endloop%
                     %else%
                     No subscribers
                     %end if%
                    %endloop%

                 %endinvoke%
              </TD>
              <TD class="oddrowdata-l">
                <a href="#" onclick="selectAll('sendform', checkboxArray1, true); return false;">Select All</a><br>
                <a href="#" onclick="selectAll('sendform', checkboxArray1, false); return false;">Un-Select All</a>
              </TD>
            </TR>
            <TR>
              <TD colspan="3" class="action">
                <INPUT type="submit" name="submit" onclick="return onSend('sendform', checkboxArray1); " value="Send Release">
              </TD>
            </TR>
            </form>
          </TABLE>
        </TD>
      </TR>
    </TABLE>
  </BODY>
</HTML>
