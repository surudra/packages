
<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
    <TITLE>Integration Server</TITLE>
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
  </HEAD>
  %ifvar release%
    <BODY onLoad="setNavigation('package-exchange.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_CreateRelScrn');">
  %else%
    <BODY onLoad="setNavigation('package-list.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_ArchivePkgsScrn');">
  %endif%
  <SCRIPT LANGUAGE="JavaScript">

  %ifvar release%
  	var ReleaseOrArchive = "Release";
  %else%
  	var ReleaseOrArchive = "Archive";
  %end if%
  

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
	     version = normalize(version);
	     var words = new Array();
		 words = version.split(".");
	     if ( words.length < 2 )
	        return false;
	     for( var i=0; i<words.length; i++ ) {
	       if( isNaN(parseInt(words[i])) )
	         return false;
	     }
	     return true;
    }

    function isJVMFormatValid(jvmver)
    {
      jvmver = normalize(jvmver);
      words = jvmver.split(".");
      if ( words.length < 2 )
        return false;
      for( var i=0; i<words.length; i++ ) {
        if( isNaN(parseInt(words[i])) )
          return false;
      }
      return true;
    }

    function submitForm()
    {
      var name = document.form.name.value;
        var ver = document.form.version.value;
        var build = document.form.build.value;
        var targetver = document.form.target_pkg_version.value;
        var jvm = document.form.jvm_version.value;

      if (( name == null ) || ( name == "" )) {
      	%ifvar release%
        alert("Release Name is required");
        %else%
        alert("Archive Name is required");
        %endif%
        return false;
        } else if (( ver == null ) || ( ver == "" )) {
            alert("Version is required");
            return false;
        } else if (( jvm == null ) || ( jvm == "" )) {
          alert("Minimum Version of JVM is required.");
          return false;
      } else if ( document.form.type[1].checked == true && (( targetver == null ) || ( targetver == "" )) ) {
            alert("Version of Target Package is required for releasing a patch");
            return false;
        } else {

          if ( !isIllegalName ( name ) ) {
            %ifvar release%
            alert("Invalid Release Name:\nRefer to Integration Server Administrator's Guide for listed illegal characters");
            %else%
            alert("Invalid Archive Name:\nRefer to Integration Server Administrator's Guide for listed illegal characters");
            %endif%
            return false;
          }

          if( !isVersionFormatValid(ver) ) {
            alert("Invalid Version format (ex: 1.1)");
            return false;
          }

          if ( (!(build == null || build == "" )) && isNaN(parseInt(normalize(build))) ) {
            alert("Invalid Build format (ex: 6)");
            return false;
          }

          if ( document.form.type[1].checked == true ) {
            if ( !isVersionFormatValid(targetver) ) {
              alert("Invalid Target Package Version format (ex: 1.0)");
              return false;
            }
          }

          if ( !isJVMFormatValid(jvm) ) {
            alert("Invalid JVM version (ex: 1.2)");
            return false;
          }

            document.form.submit();
          return false;
        }
    }
  </SCRIPT>



%ifvar release%
    <FORM NAME="form" action="package-exchange.dsp" method="POST">
      <INPUT type="hidden" name="action" value="release">
      <INPUT type="hidden" name="release" value="true">
%else%
    <FORM NAME="form" action="package-list.dsp" method="POST">
      <INPUT type="hidden" name="action" value="archive">
%end if%



      <INPUT type="hidden" name="package" value="%value package%">
      <TABLE width=100%>
        <TR>
          <TD class="menusection-Packages" colspan=2>
%ifvar release%
  Packages &gt;
  Publishing &gt;
  Create Release &gt;
  %value package%
%else%
  Packages &gt;
  Management &gt;
  %value package% &gt;
  Archive
%end if%


          </TD>
        </TR>
      <TR>
        <TD colspan=2>
          <UL>
%ifvar release%
            <LI><A HREF="package-release-selection.dsp">Return to Create and Delete Releases</a></li>
%else%
            <LI><A HREF="package-list.dsp">Return to Package Management</A></LI>
%end if%
          </UL>
        </TD>
      </TR>

        <TR>
          <TD><IMG SRC="images/blank.gif" width=10></TD><TD><TABLE class="tableForm">
              <TR>
              	%ifvar release%
                <TD class="heading" colspan=3>Specify Files for the Release
                %else%
                <TD class="heading" colspan=3>Specify Files for the Archive
                %endif%
                </TD>
              </TR>
              <TR>
                <TD class="evenrow-l" colspan=3>




                  <TABLE cellspacing="0" cellpadding="0" >
          <tr><td class="evenrow-l">Files available in %value package%:</td></tr>
                    <TR>
                      <TD class="evenrow-l">
                      %invoke wm.server.replicator:packageFileList%
                        <SELECT name="file" size="12" multiple >
                        %loop files%<OPTION value="%value%">%value%</OPTION>%endloop%
                        </SELECT>%endinvoke%  </TD>
                    </TR>
                  </TABLE> </TD>


      </tr>
      <tr>
              <TD valign=top  class="oddrow">Files to Include
              </td>
              <TD valign=top  colspan="2" class="oddrow-l">

                  <TABLE cellspacing="0" cellpadding="0">
                    <tr><td class="oddrow">
                      <INPUT type="radio" name="filter" value="includeall" checked></td><td class="oddrow-l">All files
                    </td></tr>
                    <tr><td class="oddrow">
                        <INPUT type="radio" name="filter" value="include"></td><td class="oddrow-l">Selected files
                    </td></tr>
                    <tr><td class="oddrow">
                        <INPUT type="radio" name="filter" value="exclude"></td><td class="oddrow-l">All <i>except</i> selected files
                    </td></tr>
                    <tr><td class="oddrow">
                        <INPUT type="radio" name="filter" value="include"></td><td class="oddrow-l">Files specified by filter:<br>
                        <INPUT name="includepattern">
                    </td></tr>
                    <tr><td class="oddrow">
                        <INPUT type="radio" name="filter" value="exclude"></td><td class="oddrow-l">All <i>except</i> files specified by filter:<br>
                        <INPUT name="excludepattern"> <BR>
                        (ex: *.java, *.class)
                    </td></tr>
				  </TABLE>
				</TD>
			  </TR>
			  <tr>
			    <td valign="top" class="evenrow">Files to Delete from Target Package<BR>(For distributing upgrades only)
			    </td>
			    <td  class="evenrow-l" colspan="2">One file name per line. <BR>Use ";" to separate multiple file names.<BR>
				<textarea style="width:100%;" wrap="off" rows="5" name="files_to_delete" cols="20"></textarea>
			    </td>
			  </tr>

              <TR>
				%ifvar release%
				<TD class="heading" colspan=5>Package Release Information</TD>
				%else%
				<TD class="heading" colspan=5>Package Archive Information</TD>
				%endif%

              </TR>
              <TR>
              	%ifvar release%
                	<TD class="oddrow">Release Type</TD>
                %else%
                	<TD class="oddrow">Archive Type</TD>
                %endif%
                <TD class="oddrow-l" colspan="2" nowrap>
                  <INPUT type="radio" name="type" value="full" checked>Full <font style="font-weight: normal;">(Including all files is recommended)</font><br>
                  <INPUT type="radio" name="type" value="partial">Patch <font style="font-weight: normal;">(For distributing upgrades)</font>
                  </TD>
              </TR>
              <TR>
				%ifvar release%
				<TD class="evenrow">Release Name</TD>
                %else%
				<TD class="evenrow">Archive Name</TD>
                %endif%
                <TD class="evenrow-l"><INPUT name="name" value="%value package%"></TD>
                <TD class="evenrow" nowrap>(.zip will be appended)</TD>
              </TR>

              <TR>
                <TD class="oddrow">Brief Description</TD>
                <TD class="oddrow-l" colspan="2"><INPUT name="description" value="%value description%"></TD>
              </TR>


              <TR>
                <TD class="evenrow">Version</TD>
                <TD class="evenrow-l"><INPUT name="version" value="%value version%"></TD>
                <TD class="evenrow" nowrap>(current version: %value version%)</TD>
              </TR>
              <TR>
                <TD class="oddrow">Build Number</TD>
                <TD class="oddrow-l"><INPUT name="build" value="%value build%"></TD>
                <TD class="oddrow" nowrap>
                %ifvar build%
                  (current build: %value build%)
                %else%
                  (ex: 6)
                %endif%
                </TD>
              </TR>

              <TR>
                <TD class="evenrow">Previous Patches Included</TD>
                <TD class="evenrow-l"><INPUT name="patch_nums" value="%value patch_nums%"></TD>
                <TD class="evenrow" nowrap>
                %ifvar patch_nums%
                  (current patches: %value patch_nums%)
                %else%
                  (ex: 4, 5)
                %endif%
                </TD>
              </TR>

              <TR>
                <TD class="heading" colspan=4>Recommendations for Subscriber Install</TD>
        </TR>

              <TR>
                <TD class="oddrow">webMethods Integration Server</TD>
                <TD class="oddrow-l"><INPUT name="target_server_version" value="%value server_version%"></TD>
                <TD class="oddrow" nowrap>(ex: 3.1)</TD>
              </TR>
              <TR>
                <TD class="evenrow">Minimum Version of JVM</TD>
                <TD class="evenrow-l"><INPUT name="jvm_version" value="%value jvm_version%"></td>
                 <TD class="evenrow" nowrap>(ex: 1.2)</TD>
              </TR>

              <TR>
                <TD class="heading" colspan=4>Required Settings for Creating a Patch</TD>
        </TR>


              </TR>
                <TD class="oddrow">Version of Target Package</TD>
                <TD class="oddrow-l"><INPUT name="target_pkg_version" value="%value version%"></TD>
                <TD class="oddrow" nowrap>(ex: 1.0)</TD>
              </TR>

              <TR>
                <TD class="action" colspan="5">
                %ifvar release%
                  <INPUT class="data" type="submit" onclick="return submitForm();" value="Create Release">
                %else%
                  <INPUT class="data" type="submit" onclick="return submitForm();" value="Create Archive">
                %endif%
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
