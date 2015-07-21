%ifvar mode equals('edit')%
  %ifvar disableport equals('true')%
    %invoke wm.server.net.listeners:disableListener%
    %endinvoke%
  %endif%
%endif%


%invoke wm.server.net.listeners:getListener%

<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
    <LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
    <SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
    <TITLE>Integration Server -- Port Access Management</TITLE>


    <SCRIPT Language="JavaScript">
        function confirmDisable()
        {
          var enabled = "%value ../listening%";

          if(enabled == "primary")
          {
            alert("Port must be disabled to edit these settings.  Primary port cannot be disabled.  To edit these settings, please select a new primary port");
            return false;
          }
          else if(enabled == "true")
          {
            if(confirm("Port must be disabled so that you can edit these settings.  Would you like to disable the port?"))
            {
              document.location.replace("configFilePolling.dsp?listenerKey=%value -urlencode listenerKey%&pkg=%value pkg%%ifvar listenerType%&listenerType=%value -urlencode listenerType%%endif%&mode=edit&disableport=true");
            }
          }
          else
          	document.location.replace("configFilePolling.dsp?listenerKey=%value -urlencode listenerKey%&pkg=%value pkg%%ifvar listenerType%&listenerType=%value -urlencode listenerType%%endif%&mode=edit");


          return false;
        }

      var userndx;

        function setupData() {
            %ifvar port%
            document.properties.operation.value = "update";
            document.properties.oldPkg.value = "%value pkg%";
            %else%
            document.properties.operation.value = "add";
            %endif%

        userndx=-1;
        /*
        // set user to default by default
        for (count=0; count<document.properties.runUser.length; count++ ) {
          if (document.properties.runUser[count].value.toLowerCase()=="default" ) {
          userndx=count;
          break;
          }
        }

        // No default user, so find next user that is not administrator
        if (userndx==-1) {
          for (count=1; count<document.properties.runUser.length; count++ ) {
            if (document.properties.runUser[count].value.toLowerCase()!="administrator" ) {
            userndx=count;
            break;
            }
          }
        }

        // no valid user found
        if (userndx==-1) userndx=0;
        */
        }
/*
      function setMultithread(value) {

        if ( value == true ) {
          if ( document.properties.type[0].checked==true ) {
            alert("Cannot use multithreading for POP3 servers");
            document.properties.multithread[0].checked=false;
            document.properties.multithread[1].checked=true;
            return false;
          }
          document.properties.num_threads.value = 3;
        }
        else {
          document.properties.num_threads.value = 0;
        }

        return true;

      }
*/
/*
      // build an obfuscation string for the password
      // when displayed in view mode
      function getAsterisk(value) {

        var pwd = "";
        for (count=0; count<value.length; count++ ) {
          pwd = pwd + "*";
        }
        return w(pwd);
      }

      function setLogout(value) {

        if ( value == true ) {
          if ( document.properties.type[0].checked==false ) {
            alert("Log out only supported for POP3 servers");
            document.properties.logout[0].checked=false;
            document.properties.logout[1].checked=true;
            return false;
          }
        }

        return true;

      }

      function setThreads() {

        if (document.properties.multithread[0].checked == false) {
          document.properties.num_threads.value="0";
          return false;
        }

        return true;

      }

      function setRemove() {

        if ( document.properties.type[0].checked==true ) {
          alert("Messages from POP3 servers are always deleted");
          document.properties.remove[0].checked=true;
          document.properties.remove[1].checked=false;
          return false;
        }
        return true;
      }

      function setBadRemove() {

        if ( document.properties.type[0].checked==true ) {
          alert("Messages from POP3 servers are always deleted");
          document.properties.bad_remove[0].checked=true;
          document.properties.bad_remove[1].checked=false;
          return false;
        }
        return true;
      }

      function setAuthorize(value) {
        if (value == true) {
          //document.properties.runUser.selectedIndex = 0;
        } else {
          //document.properties.runUser.selectedIndex = userndx;
        }
        return true;
      }

      function setUser(newuser) {
      
        if ((document.properties.authorize[0].checked==true) &&
          (document.properties.runUser.selectedIndex>0) ) {
          document.properties.runUser.selectedIndex=0;
          alert ("Must turn off authorization before selecting user");
          return false;
        }
        else if ( (document.properties.authorize[0].checked==false)
          && (document.properties.runUser.selectedIndex==0)) {
          alert("Must select valid user if authorization is turned off");
          return false;
        }

        userndx=document.properties.runUser.selectedIndex;
        
        return true;

      }

      function setType(server_type) {
        if (server_type == 1) { // pop3
          document.properties.multithread[0].checked=false;
          document.properties.multithread[1].checked=true;
        }

        if (server_type == 1) { // pop3
          document.properties.remove[0].checked=true;
          document.properties.remove[1].checked=false;
        }

        if (server_type == 1) { // pop3
          document.properties.bad_remove[0].checked=true;
          document.properties.bad_remove[1].checked=false;
        }

        if (server_type == 2) {  // imap
          document.properties.logout[0].checked=false;
          document.properties.logout[1].checked=true;
        }

      }
*/
      function isblank(s)
      {

        for (var i=0; i<s.length; i++ ) {
          var c  = s.charAt(i);
          if ((c != ' ') && (c != '\n') && (c != '\t')) return false;
        }
        return true;
      }

      function verify(listenerKey) {

        // monitorDir
        var e = document.properties.monitorDir.value;

        if (( e == null ) || ( e == "" ) || isblank(e)) {
          alert("Monitoring Directory required");
          document.properties.monitorDir.focus();
          return (false);
        }

        /*
        var e = document.properties.workDir.value;

        if (( e == null ) || ( e == "" ) || isblank(e)) {
          alert("Working Directory required");
          document.properties.workDir.focus();
          return (false);
        }
        */
        
        var index =  document.properties.runUser.selectedIndex;
        //if (document.properties.runUser[index].value== "") {
        if (document.properties.runUser.value== "") {
          alert("Must select a valid user");
          document.properties.runUser.focus();
          return (false);
        }

        var e = document.properties.processingService.value;
        if (( e == null ) || ( e == "" ) || isblank(e)) {
          alert("Processing Service required");
          document.properties.processingService.focus();
          return (false);
        }

        //fileAge
        var e = document.properties.fileAge.value;
        if (( e != null ) && ( e != "" ) && !isblank(e)) {

          for (count=0; count<document.properties.fileAge.value.length; count++){
            var sstr = document.properties.fileAge.value.substring(count,count+1);
            var test = parseInt(sstr);
            if (isNaN(test)) {
              alert("Invalid File Age: valid range 1-9999");
              document.properties.fileAge.focus();
              return (false);
            }
          }

          var interval = parseInt(document.properties.fileAge.value, 10);
          if ((isNaN(interval)) || (interval<1) || (interval>9999)) {
            alert("Invalid File Age: valid range 1-9999");
            document.properties.fileAge.focus();
            return (false);
          }
        }

        //filePollingInterval
        for (count=0; count<document.properties.filePollingInterval.value.length; count++){
          var sstr = document.properties.filePollingInterval.value.substring(count,count+1);
          var test = parseInt(sstr);
          if (isNaN(test)) {
            alert("Invalid File Polling Interval: valid range 1-9999");
            document.properties.filePollingInterval.focus();
            return (false);
          }
        }

        var interval = parseInt(document.properties.filePollingInterval.value, 10);
        if ((isNaN(interval)) || (interval<1) || (interval>9999)) {
          alert("Invalid File Polling Interval: valid range 1-9999");
          document.properties.filePollingInterval.focus();
          return (false);
        }

        //cleanUpFileAge
        var e = document.properties.cleanUpFileAge.value;
        if (( e != null ) && ( e != "" ) && !isblank(e)) {

          for (count=0; count<document.properties.cleanUpFileAge.value.length; count++){
            var sstr = document.properties.cleanUpFileAge.value.substring(count,count+1);
            var test = parseInt(sstr);
            if (isNaN(test)) {
              alert("Invalid Cleanup File Age: valid range 1-9999");
              document.properties.cleanUpFileAge.focus();
              return (false);
            }
          }

          var interval = parseInt(document.properties.cleanUpFileAge.value, 10);
          if ((isNaN(interval)) || (interval<1) || (interval>9999)) {
            alert("Invalid Cleanup File Age: valid range 1-9999");
            document.properties.cleanUpFileAge.focus();
            return (false);
          }
        }
        
        //cleanUpInterval
        var e = document.properties.cleanUpInterval.value;
        if (( e != null ) && ( e != "" ) && !isblank(e)) {

          for (count=0; count<document.properties.cleanUpInterval.value.length; count++){
            var sstr = document.properties.cleanUpInterval.value.substring(count,count+1);
            var test = parseInt(sstr);
            if (isNaN(test)) {
              alert("Invalid Cleanup Interval: valid range 1-9999");
              document.properties.cleanUpInterval.focus();
              return (false);
            }
          }

          var interval = parseInt(document.properties.cleanUpInterval.value, 10);
          if ((isNaN(interval)) || (interval<1) || (interval>9999)) {
            alert("Invalid Cleanup Interval: valid range 1-9999");
            document.properties.cleanUpInterval.focus();
            return (false);
          }
        }
        
        //maxThreads
        for (count=0; count<document.properties.maxThreads.value.length; count++){
          var sstr = document.properties.maxThreads.value.substring(count,count+1);
          var test = parseInt(sstr);
          if (isNaN(test)) {
            alert("Invalid Maximum Number of Invocation: valid range 1-10");
            document.properties.maxThreads.focus();
            return (false);
          }
        }

        var num_threads = parseInt(document.properties.maxThreads.value, 10);
        if ((isNaN(num_threads)) || (num_threads<1) || (num_threads>10)) {
          alert("Invalid Maximum Number of Invocation: valid range 1-10");
          document.properties.maxThreads.focus();
          return (false);
        }
        
        var e = document.properties.maxFilesPerCycle.value;
        if (( e != null ) && ( e != "" ) && !isblank(e)) {
			var num_files = parseInt(document.properties.maxFilesPerCycle.value, 10);
			if ((isNaN(num_files)) || (num_files<1)) {
				  alert("Invalid Maximum Number of Files to process per Interval.");
				  document.properties.maxFilesPerCycle.focus();
				  return (false);
			}
		}
        
	document.properties.listenerKey.value=listenerKey;
        document.properties.submit();
        return (true);

      }

    </SCRIPT>

  </HEAD>
  <body onLoad="%ifvar mode equals('edit')%setupData();%endif%setNavigation('/WmRoot/security-ports.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_FilePoll_PortConfigScrn');">
    <TABLE width="100%">
      <TR>
        <TD class="menusection-Security" colspan=2>
          Security &gt;
          Ports &gt;
          %ifvar mode equals('view')%
            View File Polling Details
          %else%
            Edit File Polling Configuration
          %endif%
        </TD>
      </TR>
      <TR>
        <TD colspan="2">
          <UL>
            <LI><A HREF="/WmRoot/security-ports.dsp">Return to Ports</A></LI>
            %ifvar mode equals('view')%
              %ifvar listening equals('primary')%
              %else%
                <LI><A onclick="return confirmDisable();" HREF="">
                  Edit File Polling Configuration
                </A></LI>
              %endif%
            %endif%
          </UL>
        </TD>
      </TR>
      <TR>
        <TD><IMG SRC="/WmRoot/images/blank.gif" height=10 width=10></TD>
        <TD>
          <TABLE class="tableForm">

            <tr>
              <td class="heading" colspan="4">File Polling Listener Configuration</td>
            </tr>

            <form name="properties" method="post" action="/WmRoot/security-ports.dsp" onsubmit="return verify('%value encode(htmlattr) listenerKey%');">
            <input type="hidden" name="factoryKey" value="webMethods/FilePolling">
            <input type="hidden" name="operation">
            <input type="hidden" name="listenerKey" value="%value encode(htmlattr) listenerKey%">
            <input type="hidden" name="oldPkg">

            <tr>
        <td valign=top>
        <table class="%ifvar ../mode equals('view')%tableView%else%tableForm%endif%" width="100%">

        <tr><td class="heading" colspan=2>Package</td></tr>
        <tr><td class="oddrow">Package Name</td>
          <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">

            %ifvar mode equals('view')%
              %value pkg%
            %else%
              %invoke wm.server.packages:packageList%
              <select name="pkg" width=30%>
              %loop packages%
              %ifvar enabled equals('false')%
              %else%
              %ifvar ../pkg -notempty%
                <option size="15" width=30% %ifvar ../pkg vequals(name)%selected %endif%value="%value name%">%value name%</option>
              %else%
                <option size="15" width=30% %ifvar name equals('WmRoot')%selected %endif%value="%value name%">%value name%</option>
              %endif%
              %endif%
              %endloop%
              </select>
              </td>
              </tr>
              %endinvoke%
            %endif%
            <tr>
                <td class="evenrow">Alias</td>
                <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
                  %ifvar listenerKey -notempty%
                    %value portAlias% 
                  %else%
                    <input name="portAlias" value="%value portAlias%" size="60">
                  %endif%
                </td>
            </tr>
            <tr>
                <td class="oddrow">Description (optional)</td>
                <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
                  %ifvar ../mode equals('view')%
                    %value portDescription%
                  %else%
                    <input name="portDescription" value="%value portDescription%" size="60">
                  %endif%
                </td>
            </tr>
            <tr>
              <td class="space" colspan="2">&nbsp;</td>
            </tr>

        <tr><td class="heading" colspan=2>Polling Information</td></tr>
          <tr>
            <td class="oddrow">Monitoring Directory</td>
            <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
              <script>writeEdit('%value encode(htmlattr) mode%', 'monitorDir', '%value -code monitorDir%');</script>
            </td>
          </tr>
          <tr>
            <td class="evenrow">Working Directory (optional)</td>
            <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
              <script>writeEdit('%value encode(htmlattr) mode%', 'workDir', '%value -code workDir%');</script>
            </td>
          </tr>
          <tr>
            <td class="oddrow">Completion Directory (optional)</td>
            <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
              <script>writeEdit('%value encode(htmlattr) mode%', 'completionDir', '%value -code completionDir%');</script>
            </td>
          </tr>
          <tr>
            <td class="evenrow">Error Directory (optional)</td>
            <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
              <script>writeEdit('%value encode(htmlattr) mode%', 'errorDir', '%value -code errorDir%');</script>
            </td>
          </tr>
          <tr>
            <td class="oddrow">File Name Filter (optional)</td>
            <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
              <script>writeEdit('%value encode(htmlattr) mode%', 'fileNameFilter', '%value encode(htmlattr) fileNameFilter%');</script>
            </td>
          </tr>
          <tr>
            <td class="evenrow">File Age (optional) (seconds)</td>
            <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
              <script>writeEdit('%value encode(htmlattr) mode%', 'fileAge', '%value -code fileAge%');</script>
            </td>
          </tr>
          <tr>
            <td class="oddrow">Content Type (optional)</td>
            <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
              <script>writeEdit('%value encode(htmlattr) mode%', 'defaultContentType', '%value -code defaultContentType%');</script>
            </td>
          </tr>
          <tr>
            <td class="evenrow">Allow Recursive Polling</td>
            <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
            %ifvar mode equals('view')%
              %switch recursive%
                %case 'yes'%Yes
                %case% No
              %endswitch%
            %else%
              <input type="radio" value="yes" name="recursive"
                %ifvar recursive equals('yes')%checked%endif%>Yes
                  <input type="radio" name="recursive" value="no"
                %ifvar recursive equals('yes')%%else%checked%endif%>No
            %endif%
            </td>
          </tr>
          <tr>
            <td class="oddrow">Enable Clustering</td>
            <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
            %ifvar mode equals('view')%
              %switch clusterEnabled%
                %case 'yes'%Yes
                %case% No
              %endswitch%
            %else%
              <input type="radio" value="yes" name="clusterEnabled"
                %ifvar clusterEnabled equals('yes')%checked%endif%>Yes
                  <input type="radio" name="clusterEnabled" value="no"
                %ifvar clusterEnabled equals('yes')%%else%checked%endif%>No
            %endif%
            </td>
          </tr>
          <tr>
            <td class="evenrow">Lock File Extension (optional)</td>
            <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
              <script>writeEdit('%value encode(htmlattr) mode%', 'lockFileExtension', '%value -code lockFileExtension%');</script>
            </td>
          </tr>
          <tr>
			<td class="oddrow">Number of files to process per Interval (optional)</td>
			<td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
			  <script>writeEdit('%value encode(htmlattr) mode%', 'maxFilesPerCycle', '%value -code maxFilesPerCycle%');</script>
			</td>
          </tr>
          </table>
          </td>
          <!-- END OF LEFT TABLE -->

          <!-- RIGHT TABLE -->
          <td valign=top >
          <table class="%ifvar ../mode equals('view')%tableView%else%tableForm%endif%" width=100% >

          <tr>
            <td class="heading" colspan=2>Security</td>
          </tr>
          <!--  RUN AS USER SUB CHANGES-->
	 	<SCRIPT>
	        	  function callback(val){      	    
	        	    	document.properties.runUser.value=val;
	        	  }
    		</SCRIPT>
          <tr>
            <td class="oddrow">Run services as user</td>
            <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
              %ifvar mode equals('view')%
                %value runUser%
              %else%
                <!--  RUN AS USER SUB CHANGES START-->
		           	<input name="runUser" size=12 value="%value runUser%"></input>
			    	<link rel="stylesheet" type="text/css" href="subUserLookup.css" />
			    	<script type="text/javascript" src="subUserLookup.js"></script>
			    	<a class="submodal" href="subUserLookup.dsp"><img border=0 align="bottom" src="icons/magnifyglass.gif"/></a>  
	    	<!--  RUN AS USER SUB END-->                
              %endif%
            </td>
          </tr>
          <tr>
            <td class="space" colspan="2">&nbsp;</td>
          </tr>
          <tr>
            <td class="heading" colspan=3>Message Processing</td>
          </tr>
			%ifvar ../mode equals('edit')%
				<tr>
					<td class="evenrow">Enable</td>
					<td class="evenrow-l">
					  <input type="radio" name="enable" value="yes" >Yes</input>
					  <input type="radio" name="enable" value="no" checked>No</input>
					</td>
				</tr>
			%endif%
          <tr>
            <td class="oddrow">Processing Service</td>
            <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
              <script>writeEdit('%value encode(htmlattr) mode%', 'processingService', '%value -code processingService%');</script>
            </td>
          </tr>

          <tr>
            <td class="evenrow">File Polling Interval (seconds)</td>
            <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
              <script>writeEdit('%value encode(htmlattr) mode%', 'filePollingInterval', '%value encode(htmlattr) filePollingInterval%');</script>
            </td>
          </tr>
          <tr>
            <td class="oddrow">Log only when directory availability changes</td>
            <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
            %ifvar mode equals('view')%
              %switch logMinMessage%
                %case 'yes'%Yes
                %case% No
              %endswitch%
            %else%
              <input type="radio" name="logMinMessage" value="yes"
                %ifvar logMinMessage equals('yes')%checked%endif%>Yes
              <input type="radio" name="logMinMessage" value="no"
                %ifvar logMinMessage equals('yes')%%else%checked%endif%>No
            %endif%
            </td>
          </tr>
          <tr>
            <td class="evenrow">Directories are NFS mounted file system</td>
            <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
            %ifvar mode equals('view')%
              %switch NFSDirectories%
                %case 'yes'%Yes
                %case% No
              %endswitch%
            %else%
              <input type="radio" name="NFSDirectories" value="yes" 
                %ifvar NFSDirectories equals('yes')%checked%endif%>Yes
              <input type="radio" name="NFSDirectories" value="no"
                %ifvar NFSDirectories equals('yes')%%else%checked%endif%>No
            %endif%
            </td>
          </tr>
          <tr>
            <td class="oddrow">Cleanup Service (optional)</td>
            <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
              <script>writeEdit('%value encode(htmlattr) mode%', 'cleanUpService', '%value encode(htmlattr) cleanUpService%');</script>
            </td>
          </tr>
          <tr>
            <td class="evenrow">Cleanup At Startup</td>
            <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
            %ifvar mode equals('view')%
              %switch cleanupAtStartup%
                %case 'no'%No
                %case% Yes
              %endswitch%
            %else%
              <input type="radio" name="cleanupAtStartup" value="yes"
                %ifvar cleanupAtStartup equals('no')%%else%checked%endif%>Yes
              <input type="radio" name="cleanupAtStartup" value="no"
                %ifvar cleanupAtStartup equals('no')%checked%endif%>No
            %endif%

            </td>
          </tr>
          <tr>
            <td class="oddrow">Cleanup File Age (optional) (days)</td>
            <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
              <script>writeEdit('%value encode(htmlattr) mode%', 'cleanUpFileAge', '%value encode(htmlattr) cleanUpFileAge%');</script>
            </td>
            
          </tr>
          <tr>
            <td class="evenrow">Cleanup Interval (optional) (hours)</td>
            <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
              <script>writeEdit('%value encode(htmlattr) mode%', 'cleanUpInterval', '%value encode(htmlattr) cleanUpInterval%');</script>
            </td>
          </tr>
          <tr>
            <td class="oddrow">Maximum Number of Invocation Threads</td>
            <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
              <script>writeEdit('%value encode(htmlattr) mode%', 'maxThreads', '%value encode(htmlattr) maxThreads%');</script>
            </td>
          </tr>

			

          </table>

          %ifvar mode equals('view')%
          %else%
          <tr>
            <td colspan="2" class="action">
            <input type="button" value="Save Changes" onclick="verify('%value encode(htmlattr) listenerKey%');">
            </td>
          </tr>
          %endif%
          </form>
          </table>
        </td>
      </tr>
    </table>
  </body>
</html>
%endinvoke%
