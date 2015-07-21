
<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
    <TITLE>Integration Server -- Package Release</TITLE>
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
  </HEAD>
  <BODY>
  <SCRIPT LANGUAGE="JavaScript">

    function isIllegalName(name)
    {
      var illegalChars = "- #&@^!%*:$./\\`;,~+=)(|}{][><\"";

        for (var i=0; i<illegalChars.length; i++)
        {
      if (name.indexOf(illegalChars.charAt(i)) >= 0)
        return false;
    }
    return true;

    }

    function isVersionFormatValid(version)
    {
      words = version.split(".");
      if ( words.length != 2 )
        return false;
        if ((!isNaN(parseInt(words[0]))) && (!isNaN(parseInt(words[1]))))
          return true;
        else
          return false;
    }

    function isJVMFormatValid(jvmver)
    {
      words = jvmver.split(".");
      if ( words.length < 2 )
        return false;
      for( var i=0; i<words.length; i++ ) {
        if( isNaN(parseInt(words[i])) )
          return false;
      }
      return true;
    }

    function onRelease()
    {
      var name = document.release.name.value;
        var ver = document.release.version.value;
        var build = document.release.build.value;
        var targetver = document.release.target_pkg_version.value;
        var jvm = document.release.jvm_version.value;

      if (( name == null ) || ( name == "" )) {
        alert("Release Name is required");
        return false;
        } else if (( ver == null ) || ( ver == "" )) {
            alert("Version is required");
            return false;
        } else if (( build == null ) || ( build == "" )) {
          alert("Build Number is required");
          return false;
        } else if (( jvm == null ) || ( jvm == "" )) {
          alert("Minimum Version of JVM is required.");
          return false;
      } else if ( document.release.type[1].checked == true && (( targetver == null ) || ( targetver == "" )) ) {
            alert("Version of Target Package is required for releasing a patch");
            return false;
        } else {

          if ( !isIllegalName ( name ) ) {
            alert("Invalid Release Name:\nRefer to Integration Server Administrator's Guide for listed illegal characters");
            return false;
          }

          if( !isVersionFormatValid(ver) ) {
            alert("Invalid Version format (ex: 1.1)");
            return false;
          }

          if ( isNaN(parseInt(build)) ) {
            alert("Invalid Build format (ex: 6)");
            return false;
          }

          if ( document.release.type[1].checked == true ) {
            if ( !isVersionFormatValid(targetver) ) {
              alert("Invalid Target Package Version format (ex: 1.0)");
              return false;
            }
          }

          if ( !isJVMFormatValid(jvm) ) {
            alert("Invalid JVM version (ex: 1.2)");
            return false;
          }

            document.release.submit();
          return true;
        }
    }
  </SCRIPT>

    <FORM NAME="release" action="package-exchange.dsp" method="POST">
      <INPUT type="hidden" name="action" value="release">
      <INPUT type="hidden" name="package" value="%value package%">
      <TABLE width=100%>
        <TR>
          <TD class="menusection-Packages" colspan=2>
            Packages &gt;
            Publishing &gt;
            Create Release &gt;
            %value package%
          </TD>
        </TR>
      <TR>
        <TD colspan=2>
          <UL>
            <LI><A HREF="package-release-selection.dsp">Return to Create and Delete Releases</A></LI>
          </UL>
        </TD>
      </TR>

        <TR>
          <TD><IMG SRC="images/blank.gif" width=10></TD><TD><TABLE>
              <TR>
                <TD class="heading" colspan=3>Specify Files for the Release
                </TD>
              </TR>
              <TR>
                <TD class="oddrow-l">
                  <TABLE cellspacing="1" cellpadding="0">
          <tr><td>Files available in %value package%:</td></tr>
                    <TR>
                      <TD class="data">

                      %invoke wm.server.replicator:packageFileList%
                        <SELECT name="file" size=12 multiple> %loop files%

                          <OPTION value="%value%">%value%</OPTION> %endloop%
                        </SELECT> %endinvoke%  </TD>
                    </TR>
                  </TABLE> </TD>
                <TD valign=top  colspan="2" class="oddrow-l">

                  <TABLE cellspacing="1" cellpadding="0">
                    <tr><td  colspan="3">Files to include in this release:</td></tr>
                    <tr><td colspan="3"><img src="images/blank.gif" height="10"></td><td></tr>
                    <tr><td><img src="images/blank.gif" width="10"></td><td>
                      <INPUT type="radio" name="filter" value="includeall" checked></td><td>Include all files.
                    </td></tr>
                    <tr><td><img src="images/blank.gif" width="10"></td><td>
                        <INPUT type="radio" name="filter" value="include"></td><td>Include only selected files.
                    </td></tr>
                    <tr><td><img src="images/blank.gif" width="10"></td><td>
                        <INPUT type="radio" name="filter" value="exclude"></td><td>Include all <i>except</i> selected files.
                    </td></tr>
                    <tr><td><img src="images/blank.gif" width="10"></td><td valign=top>
                        <INPUT type="radio" name="filter" value="include"></td><td>Include only files specified by filter:<br>
                        <INPUT name="includepattern">
                    </td></tr>
                    <tr><td><img src="images/blank.gif" width="10"></td><td valign=top>
                        <INPUT type="radio" name="filter" value="exclude"></td><td>Include all <i>except</i> files specified by filter:<br>
                        <INPUT name="excludepattern">
                    </td></tr>
          <tr><td></td><td></td><td><img src="images/blank.gif" height="5"></td></tr>
          <tr><td></td><td></td><td>Example filter: *.java, *.class</td></tr>
                  </TABLE>

                  </TD>
              </TR>
              <TR>
                <TD class="heading" colspan=5>Package Release Information</TD>
              </TR>
              <TR>
                <TD class="evenrow">Release Type</TD>
                <TD class="evenrowdata-l" colspan="2" nowrap>
                  <INPUT type="radio" name="type" value="full" checked>Full <font style="font-weight: normal;">(Including all files is recommened)</font><br>
                  <INPUT type="radio" name="type" value="partial">Patch <font style="font-weight: normal;">(For distributing upgrades)</font>
                  </TD>
              </TR>
              <TR>
                <TD class="oddrow">Release Name</TD>
                <TD class="oddrowdata-l" colspan="2"><INPUT name="name"></TD>
              </TR>


              <TR>
                <TD class="evenrow">Brief Description</TD>
                <TD class="evenrowdata-l" colspan="2"><INPUT name="description"></TD>
              </TR>



              <TR>
                <TD class="oddrow">Version</TD>
                <TD class="oddrowdata-l"><INPUT name="version"></TD>
                <TD class="oddrow" nowrap>(ex: 1.1)</TD>
              </TR>
              <TR>
                <TD class="evenrow">Build Number</TD>
                <TD class="evenrowdata-l"><INPUT name="build"></TD>
                <TD class="evenrow" nowrap>(ex: 6)</TD>
              </TR>

              <TR>
                <TD class="oddrow">List Patches Included</TD>
                <TD class="oddrowdata-l"><INPUT name="patch_nums"></TD>
                <TD class="oddrow" nowrap>(ex: 4, 5)</TD>
              </TR>

              <TR>
                <TD class="heading" colspan=4>Recommendations for Subscriber Install</TD>
        </TR>

              <TR>
                <TD class="evenrow">Version of webMethods Integration Server</TD>
                <TD class="evenrowdata-l"><INPUT name="target_server_version"></TD>
                <TD class="evenrow" nowrap>(ex: 3.1)</TD>
              </TR>
              <TR>
                <TD class="oddrow">Minimum Version of JVM</TD>
                <TD class="oddrowdata-l"><INPUT name="jvm_version"></td>
                 <TD class="oddrow" nowrap>(ex: 1.2)</TD>
              </TR>

              <TR>
                <TD class="heading" colspan=4>Required Settings for Creating a Patch</TD>
        </TR>


              </TR>
                <TD class="evenrow">Version of Target Package</TD>
                <TD class="evenrowdata-l"><INPUT name="target_pkg_version"></TD>
                <TD class="evenrow"nowrap>(ex: 1.0)</TD>
              </TR>

              <TR>
                <TD class="action" colspan="5">
                  <INPUT class="data" type="button" onclick="onRelease()"
                  ;" value="Create Release">
                  </TD>
              </TR>
            </TABLE>
          </TD>
        </TR>
      </TD>
     </TABLE>
    </FORM>
  </BODY>
</HTML>
