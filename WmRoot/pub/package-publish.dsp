<HTML>
<HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
<SCRIPT SRC="csrf-guard.js.txt"></SCRIPT>

<TITLE>Integration Server -- Publish Packages</TITLE>
%include webMethods.css%
</HEAD>

<BODY>

<TABLE width="100%"><TR><TD>
<TABLE width="100%">

<TR><td class="title" colspan=2>Package Publication Functions</td></TR>


%ifvar action%
%switch action%
%case 'cancel'%
    %invoke wm.server.replicator.adminui:subscriberCancel%
  <TR><td id="message" colspan=2>
        %ifvar okList%
      %value okcount% subscriptions cancelled
      <BR>
      %value okList%
          %loop okList%
              %value%<BR>
          %endloop%
    %endif%
      %ifvar errList%
    <br>
      %value errcount% errors while unsubscribing
      <BR>
      %value errList%
          %loop errList%
              %value%<BR>
          %endloop%
    %endif%
        </td></TR>
    %endinvoke%
%case 'add'%
    %invoke wm.server.replicator.adminui:subscriberAdd%
    <TR><td id="message" colspan=2>%value none message%</td></TR>
  %onerror%
    <TR><td id="message" colspan=2>%value -htmlcode errorMessage%</td></TR>
    %endinvoke%
%case 'zip'%
    %invoke wm.server.replicator:packageMakeZip%
    <TR><td id="message" colspan=2>%value none message%</td></TR>
  %onerror%
    <TR><td id="message" colspan=2>%value none errorMessage%</td></TR>
    %endinvoke%
%case 'release'%
    %invoke wm.server.replicator:packageRelease%
    <TR><td id="message" colspan=2>%value none message%</td></TR>
        %onerror%
        <TR><td id="message" colspan=2>%value none errorMessage%</td></TR>
    %endinvoke%
%case 'unrelease'%
  %invoke wm.server.replicator:packageUnRelease%
    <TR><td id="message" colspan=2>%value none message%</td></TR>
        %onerror%
        <TR><td id="message" colspan=2>%value none errorMessage%</td></TR>
    %endinvoke%

%case 'send'%
    %invoke wm.server.replicator.adminui:packageSendZip%
    <TR><td id="message" colspan=2>
        %ifvar okList%
      %value okcount% zipfile sent
      <BR>
          %loop okList%
              %value%<BR>
          %endloop%
    %endif%
      %ifvar errList%
      %value errcount% errors
      <BR>
          %value errList%
          %loop errList%
              %value%<BR>
          %endloop%
    %endif%
        </td></TR>
    %endinvoke%
%endswitch%
%endif%


<SCRIPT LANGUAGE="JavaScript">

    var published = new Array();
    var released = new Array();

    // first, add all the packages in as empty lists
    %invoke wm.server.packages:packageList%
        %loop packages%
            published["%value name%"] = new Array("[No subscribers]");
            released["%value name%"] = new Array("[Not available]");
        %endloop%
    %endinvoke%

    // then, add in any published packages as non-empty lists
    %invoke wm.server.replicator:publishedList%
        %loop published%
        published["%value package%"] = new Array ( %loop subscribers% "%value%" %loopsep ', '% %endloop% );
        %endloop%
    %endinvoke%

    // add in any released packages
    %invoke wm.server.replicator:releasedList%
      %loop packages%
            released["%value name%"] = new Array ( %loop released% "%value%" %loopsep ', '% %endloop% );
        %endloop%
    %endinvoke%


    // now get the last mod times of all the zip files for all the packages
    var ziptimes = new Array();
    %invoke wm.server.packages:packageList%
        %loop packages%
            %ifvar zipLastModified%
            ziptimes["%value name%"] = "%value zipLastModified%";
            %else%
            ziptimes["%value name%"] = "[No zip file found]";
            %endif%
        %endloop%
    %endinvoke%

    var oldPack = "hello";

    function packageselect() {
        var pSelect = document.dummy.xxx;
        var newVal = pSelect.options[pSelect.selectedIndex].value;
        return doselect (newVal);
    }

    function doselect(newVal) {

        var sSelect = document.subcancel.subscriber;

        // clear out all subscribers of the old selected package
        // and fill in subscribers of the new package
        sSelect.options.length = 0;
        var newOpts = published[newVal];
        for (var i=0; i<newOpts.length; i++) {
            var opt = new Option (newOpts[i], newOpts[i]);
            sSelect.options[sSelect.options.length] = opt;
        }

        //document.zipform.info.value = ziptimes[newVal];

        // clear out all released packages of the old selected package
        // and fill in all released packages of the new package
        var rSelect = document.zipform.releasedPackages;
        rSelect.options.length = 0;
        var newRelOpts = released[newVal];
        for ( var j=0; j< newRelOpts.length; j++) {
          var relOpt = new Option ( newRelOpts[j], newRelOpts[j]);
          rSelect.options[rSelect.options.length] = relOpt;
        }

        oldPack = newVal;

        return true;

    }

    function deleteReleased () {
      var rOpts = document.zipform.releasedPackages;
      if ( rOpts.selectedIndex < 0 ) {
          alert ("Select a distributable package first.");
      } else {
          var msg1 = "OK to delete this distributable package:\n";
          var msg2 = "  ";
          for ( var i=0; i<rOpts.options.length; i++)
          {
            if ( rOpts.options[i].selected == true )
            {
              msg2 += rOpts.options[i].text + "\n";
            }
          }
          if (confirm(msg1+msg2)) {
            document.zipform.submit();
            return true;
          }
      }
      return false;
    }

    function onCancel () {

        var opts = published[oldPack];
    var sOpts = document.subcancel.subscriber;
        if (opts[0] == "[No subscribers]") {
            alert ("This package has no subscriptions to cancel.");
        } else if (sOpts.selectedIndex < 0) {
            alert ("Select a subscription to cancel first.");
        } else {
            var msg1 = "OK to cancel this subscription:\n";
            var msg2 = "   package = "+oldPack+"\n";
      var msg3 = "";
      var the_select = document.subcancel.subscriber;
      for (loop=0; loop < the_select.options.length; loop++)
      {
        if (the_select.options[loop].selected == true)
        {
           msg3 += "   subscriber = "+the_select.options[loop].text + "\n";
        }
      }
            if (confirm(msg1+msg2+msg3)) {
                document.subcancel.elements[0].value=oldPack;
                document.subcancel.submit();
                return true;
            }
        }
        return false;
    }

    function onAdd () {
        var host = document.subadd.host.value;
    var port = document.subadd.port.value;
    var remoteuser = document.subadd.remoteuser.value;
    var remotepass = document.subadd.remotepass.value;
        if (host == "" || port == "" || remotepass == "" || remoteuser == "") {
            var s1 = "Please specify the subscriber's host, port, user name and password \n";
      alert(s1);
        } else {
            document.subadd.elements[0].value=oldPack;
       //     document.subadd.package.value=oldPack;
            document.subadd.submit();
            return true;
        }
        return false;
    }

    function releasePackage () {
		if(is_csrf_guard_enabled && needToInsertToken) {
			document.location = "package-release.dsp?package="+oldPack+"&"+_csrfTokenNm_+"="+_csrfTokenVal_;
		} else {
			document.location = "package-release.dsp?package="+oldPack;
		}
      return true;
    }



    function sendZip () {
      var rOpts = document.zipform.releasedPackages;
      var sOpts = document.subcancel.subscriber;

      if ( rOpts.selectedIndex < 0 ) {
        alert ("Select a distributable package first.");
      } else if (sOpts.options[0] == "[No subscribers]") {
        alert ("There are no subscribers for this package.");
      } else if (sOpts.selectedIndex < 0 ) {
        alert ("Select a Subscriber first.");
      }else {
        var releaseList = new Array(rOpts.options.length);
        var subscriberList = new Array(sOpts.options.length);
        for (loop=0; loop < rOpts.options.length; loop++)
        {
          if (rOpts.options[loop].selected == true)
          {
            releaseList[loop] = rOpts.options[loop].text;
          }
        }

        for (loop=0; loop < sOpts.options.length; loop++)
        {
          if (sOpts.options[loop].selected == true)
          {
            subscriberList[loop] = sOpts.options[loop].text;
          }
        }
            document.sendform.elements[0].value=oldPack;
        document.sendform.subscriber.value = subscriberList;
        document.sendform.release.value = releaseList;
        document.sendform.submit();
        return true;
      }
      return false;
    }

</SCRIPT>

<FORM NAME="sendform" METHOD="POST" ACTION="package-publish.dsp">
  <INPUT type="hidden" name="package" value="xxx">
  <INPUT type="hidden" name="action" value="send">
    <INPUT type="hidden" name="subscriber" value="">
    <INPUT type="hidden" name="release" value="">
</FORM>


    <TR width=100%>
        <td class="rowlabel">
        Package
        </td>

    %ifvar fpack%

        <TD class="rowdata" width=100%>%value fpack%</TD>

    %else%

    <TD class="rowdata" width=100%>
        <FORM NAME="dummy">
            %invoke wm.server.packages:packageList%
            <SELECT ONCHANGE="packageselect();" NAME="xxx">
                %loop packages%
                <OPTION value="%value name%"
          %ifvar name vequals(/package)%selected%endif%
        >%value name%</OPTION>
                %endloop%
            </SELECT><BR>
            <INPUT type="button" onclick="return releasePackage();" value="Release">
            %endinvoke%
        </FORM>
    %endif%
        </TD>
  </TR>

    <TR>
        <td class="rowlabel">Distributable Packages</td>

        <TD class="rowdata">
        <FORM name="zipform" action="package-publish.dsp" method="POST">
            <INPUT type="hidden" name="package" value="xxx">
            <INPUT type="hidden" name="action" value="unrelease">
            <SELECT SIZE=6 multiple WIDTH=200 NAME="releasedPackages">
              <OPTION value="xxxx">xxxx</OPTION>
            </SELECT><BR>
            <INPUT type="button" onclick="return deleteReleased();" value="Delete">
        </FORM>
        </TD>

    </TR>

  <TR>
    <td  class="rowlabel">Subscribers</td>

        <TD class="rowdata">
        <FORM NAME="subcancel" ACTION="package-publish.dsp" METHOD="POST">
        <INPUT TYPE="hidden" NAME="package" VALUE="xxx">
        <INPUT TYPE="hidden" NAME="action" VALUE="cancel">
    <table>
    <tr>
      <td>
            <SELECT SIZE=6 multiple WIDTH=200 NAME="subscriber">
                <OPTION value="xxxx">xxxx</OPTION>
            </SELECT>

      </td>
    </tr>
    <tr class="data">
      <td >
        <INPUT type="button" onclick="return sendZip();" value="Send zip file">
            <INPUT TYPE="button" VALUE="Delete" ONCLICK="onCancel();"></INPUT>
        </td>
    </tr>
  </table>


    </FORM>
        </TD>

  </TR>
  <TR>


    <td class="rowlabel">Add Subscriber</td>
        <TD class="rowdata">
        <FORM NAME="subadd" ACTION="package-publish.dsp" METHOD="POST">
        <INPUT TYPE="hidden" NAME="package" VALUE="xxx">
        <INPUT TYPE="hidden" NAME="action" VALUE="add">
      <table>
        <tr><td><i>Host Name</i></td><td><INPUT NAME="host" VALUE=""></INPUT></td></tr>
        <tr><td><i>Host Port</i></td><td><INPUT NAME="port" VALUE=""></INPUT></td></tr>
        <tr>
        <td><i>Transport</i></td>
        <TD>
        <SELECT NAME="ssl">
        <OPTION  value="HTTP">HTTP</OPTION>
        <OPTION  value="HTTPS">HTTPS</OPTION>
        </SELECT>
        </TD>
        </tr>
        <tr><td><i>Remote User Name</i></td><td><INPUT NAME="remoteuser" ></INPUT></td></tr>
        <tr><td><i>Remote Password</i></td><td><INPUT TYPE="password" NAME="remotepass" autocomplete="off"></INPUT></td></tr>
        <tr><td><i>Notification Email</i></td>
          <td>
            <INPUT NAME="email"></INPUT>
          </td>
        </tr>

        <tr>
        <td><i>Automatic Pull?</i></td>
          <td>
            <SELECT NAME="autopull">
              <OPTION value="yes">Yes</OPTION>
              <OPTION value="no">No</OPTION>
            </SELECT>
          </td>
        </tr>
        <tr>
          <td>
            <INPUT TYPE="button" VALUE="Add subscriber" ONCLICK="onAdd();">
          </td>
        </tr>
      </table>

        </TD>
    </TR>


       </FORM>
  </table>


  <table>
%ifvar fpack%
    <SCRIPT LANGUAGE="JavaScript">doselect("%value fpack%");</SCRIPT>
%else%
    <SCRIPT LANGUAGE="JavaScript">packageselect();</SCRIPT>
%endif%

</TABLE>
</TD></TR></TABLE>


</BODY>




</HTML>

