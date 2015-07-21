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
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
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
			  if(is_csrf_guard_enabled && needToInsertToken) {
				document.location.replace("configEmail.dsp?listenerKey=%value -code -urlencode listenerKey%&pkg=%value pkg%%ifvar listenerType%&listenerType=%value -code -urlencode listenerType%%endif%&mode=edit&disableport=true&"+_csrfTokenNm_+"="+_csrfTokenVal_);
			  } else {
				document.location.replace("configEmail.dsp?listenerKey=%value -code -urlencode listenerKey%&pkg=%value pkg%%ifvar listenerType%&listenerType=%value -code -urlencode listenerType%%endif%&mode=edit&disableport=true");
			  }
            }
          }
          else {
		   if(is_csrf_guard_enabled && needToInsertToken) {
				document.location.replace("configEmail.dsp?listenerKey=%value -code -urlencode listenerKey%&pkg=%value pkg%%ifvar listenerType%&listenerType=%value -code -urlencode listenerType%%endif%&mode=edit&"+_csrfTokenNm_+"="+_csrfTokenVal_);
		   } else {
				document.location.replace("configEmail.dsp?listenerKey=%value -code -urlencode listenerKey%&pkg=%value pkg%%ifvar listenerType%&listenerType=%value -code -urlencode listenerType%%endif%&mode=edit");
		   }
		  }  
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
        //TODO change the validation according to the new runasuser sub changes
	/*
        // set user to default by default
        for (count=0; count<document.properties.runuser.length; count++ ) {
          if (document.properties.runuser[count].value.toLowerCase()=="default" ) {
          userndx=count;
          break;
          }
        }

        // No default user, so find next user that is not administrator
        if (userndx==-1) {
          for (count=1; count<document.properties.runuser.length; count++ ) {
            if (document.properties.runuser[count].value.toLowerCase()!="administrator" ) {
            userndx=count;
            break;
            }
          }
        }

        // no valid user found
        if (userndx==-1) userndx=0;
        */
        }

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

	  function setUrlEncodedBody() {

        if ( document.properties.authorize[0].checked==true ) {
          alert("Must first disable authorization");
          document.properties.urlEncodedBody[0].checked=true;
          document.properties.urlEncodedBody[1].checked=false;
          return false;
        }
        return true;
	  }

	  function setBreakMPMsg() {
		return true;
	  }

	  function passEmailHdrs() {
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

       		if ( document.properties.urlEncodedBody[0].checked==false ) {
          		alert("Must first enable URL encoded email body");
          		document.properties.authorize[0].checked=false;
          		document.properties.authorize[1].checked=true;
          		return false;
       	 	}
          	//document.properties.runuser.selectedIndex = 0;
          	disableUserSearch();
        } else {
          //document.properties.runuser.selectedIndex = userndx;
          enableUserSearch();
        }
        return true;
      }

      function setUser(newuser) {
	/*
        if ((document.properties.authorize[0].checked==true) &&
          (document.properties.runuser.selectedIndex>0) ) {
          document.properties.runuser.selectedIndex=0;
          alert ("Must turn off authorization before selecting user");
          return false;
        }
        else if ( (document.properties.authorize[0].checked==false)
          && (document.properties.runuser.selectedIndex==0)) {
          alert("Must select valid user if authorization is turned off");
          return false;
        }

        userndx=document.properties.runuser.selectedIndex;
        */
        return true;

      }
  
      function disableUserSearch(){
       obj = document.getElementById("subUserSearchlink");
       obj.style.display = 'none';       
       document.properties.runuser.disabled=true;
       document.properties.runuser.value="";
       
      }
      
      function enableUserSearch(){
       obj = document.getElementById("subUserSearchlink");
       obj.style.display = 'inline';       
       document.properties.runuser.disabled=false;
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
      
      function verify() {

        var e = document.properties.host.value;

        if (( e == null ) || ( e == "" ) || isblank(e)) {
          alert("Host Name required");
          return (false);
        }

        var e = document.properties.user.value;

        if (( e == null ) || ( e == "" ) || isblank(e)) {
          alert("User Name required");
          return (false);
        }

        var e = document.properties.server_port.value;
        if (( e != null ) && ( e != "" ) && !isblank(e)) {

          for (count=0; count<e.length; count++){
            var sstr = e.substring(count,count+1);
            var test = parseInt(sstr);
            if (isNaN(test)) {
              alert("Invalid Port "+e);
              return (false);
            }
          }

        }


        for (count=0; count<document.properties.interval.value.length; count++){
          var sstr = document.properties.interval.value.substring(count,count+1);
          var test = parseInt(sstr);
          if (isNaN(test)) {
            alert("Invalid Time Interval: valid range 1-9999");
            return (false);
          }
        }

        var interval = parseInt(document.properties.interval.value, 10);
        if ((isNaN(interval)) || (interval<1) || (interval>9999)) {
          alert("Invalid Time Interval: valid range 1-9999");
          return (false);
        }


        for (count=0; count<document.properties.num_threads.value.length; count++){
          var sstr = document.properties.num_threads.value.substring(count,count+1);
          var test = parseInt(sstr);
          if (isNaN(test)) {
            alert("Invalid number of threads: valid range 1-99");
            return (false);
          }
        }

        var num_threads = parseInt(document.properties.num_threads.value, 10);
        if ((isNaN(num_threads)) || (num_threads<0) || (num_threads>99)) {
          alert("Invalid number of threads: valid range 1-99");
          return (false);
        }

        if ((num_threads >0) && (document.properties.multithread[0].checked==false) ) {
          alert("Number of threads must be zero if multithreading is turned off" );
          return (false);
        }

	
	if (! checkLegalHostName (document.properties.host, "host") )
	{
	  return false;                 
	}


        document.properties.submit();
        return (true);
        

      }
      
      
      function checkLegalHostName(field, fieldName)
 	        	  {
 	      var name = field.value;
 	      var illegalChars = "#&@^!%$/\\`;,~+=)(|}{][><\"";

 	      for (var i=0; i<illegalChars.length; i++)
 	      {
 		if (name.indexOf(illegalChars.charAt(i)) >= 0)
 		{
 		  alert ("Server Host Name contains illegal character: '" + illegalChars.charAt(i) + "'");
		 return false;
	       }
	     }
	
   	  return true;
      }

    </SCRIPT>
    	<base target="_self">
    		<style>
    	  		.listbox  { width: 100%; }
		</style>

  </HEAD>
  <body onLoad="%ifvar mode equals('edit')%setupData();%endif%setNavigation('security-ports.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_Email_PortConfigScrn');">
    <TABLE width="100%">
      <TR>
        <TD class="menusection-Security" colspan=2>
          Security &gt;
          Ports &gt;
          %ifvar mode equals('view')%
            View Email Client Details
          %else%
            Edit Email Client Configuration
          %endif%
        </TD>
      </TR>
      <TR>
        <TD colspan="2">
          <UL>
            <LI><A HREF="security-ports.dsp">Return to Ports</A></LI>
            %ifvar mode equals('view')%
              %ifvar listening equals('primary')%
              %else%
                <LI><A onclick="return confirmDisable();" HREF="">
                  Edit Email Client Configuration
                </A></LI>
              %endif%
            %endif%
          </UL>
        </TD>
      </TR>
      <TR>
        <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
        <TD>
          <TABLE class="tableForm">

            <tr>
              <td class="heading" colspan="4">Email Client Listener Configuration</td>
            </tr>

            <form name="properties" method="post" action="security-ports.dsp" onsubmit="return verify();">
            <input type="hidden" name="factoryKey" value="webMethods/Email">
            <input type="hidden" name="operation">
            <input type="hidden" name="listenerKey" value="%value listenerKey%">
            <input type="hidden" name="oldPkg">
	    <input type="hidden" name="passwordChanged" value="false">

            <tr>
        <td valign=top>
        <table class="%ifvar ../mode equals('view')%tableView%else%tableForm%endif%" width="100%">

        <tr><td class="heading" colspan=2>Package</td></tr>
        <tr><td class="evenrow">Package Name</td>
          <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
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
          <td class="oddrow">Alias</td>
          <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
            %ifvar listenerKey -notempty%
              %value portAlias% 
            %else%
              <input name="portAlias" value="%value portAlias%" size="60">
            %endif%
          </td>
      </tr>
      <tr>
          <td class="evenrow">Description (optional)</td>
          <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
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

        <tr><td class="heading" colspan=2>Server Information</td></tr>
		  %ifvar ../mode equals('edit')%
			<tr>
				<td class="oddrow">Enable</td>
				<td class="oddrow-l">
				  <input type="radio" name="enable" value="yes" >Yes</input>
				  <input type="radio" name="enable" value="no" checked>No</input>
				</td>
			</tr>
		  %endif%
	    <tr>
	      <td class="evenrow">Type</td>
	      <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
		%ifvar mode equals('view')%
		  %switch type%
		  %case 'imap'%IMAP
		  %case 'pop3'%POP3
		  %endswitch%
		%else%
		  <input type="radio" value="pop3" name="type" onclick="setType(1);"
		    %ifvar type equals('pop3')%checked%endif%>POP3
		      <input type="radio" name="type" value="imap"onclick="setType(2);"
		    %ifvar type equals('pop3')%%else%checked%endif%>IMAP</input>
		%endif%
	      </td>
            </tr>
          
          <tr>
            <td class="oddrow">Host Name</td>
            <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
              <script>writeEdit('%value -htmlall mode%', 'host', '%value -htmlall host%');</script>
            </td>
          </tr>

          <tr>
            <td class="evenrow">Port (optional)</td>
            <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
              <script>writeEdit('%value -htmlall mode%', 'server_port', '%value -htmlall server_port%');</script>
            </td>
          </tr>
          
          <tr>
            <td class="oddrow">User Name</td>
            <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
              <script>writeEdit('%value -htmlall mode%', 'user', '%value -htmlall user%');</script>
            </td>
          </tr>
          <tr>
            <td class="evenrow">Password</td>
            <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
              %ifvar mode equals('view')%
		*****
              %else%
		    %ifvar password%
			   <input type="password" name="password" autocomplete="off" value="*****" onChange="document.properties.passwordChanged.value=true;"/>
		    %else%
			   <input type="password" name="password" autocomplete="off" value=""/>
		    %endif%
              %endif%
            </td>
          </tr>
          
	  <tr>
	    <td class="oddrow">Transport Layer Security</td>
	    <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
		%ifvar mode equals('view')%
		  %switch tlsSettings%
			%case 'None'%None
			%case 'Explicit'%Explicit
			%case 'Implicit'%Implicit
			%case%None
		  %endswitch%
		%else%
		  <select name="tlsSettings">
		  <option %ifvar tlsSettings equals('None')%selected %endif%value="None">None</option>
		  <option %ifvar tlsSettings equals('Explicit')%selected %endif%value="Explicit">Explicit</option>
		  <option %ifvar tlsSettings equals('Implicit')%selected %endif%value="Implicit">Implicit</option>
		  </select>
		%endif%
	    </td>
	  </tr>

	  <tr>
		<td class="evenrow">Truststore Alias (optional)</td>
		<td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
			%ifvar mode equals('view')%
				 %value trustStore%
			%else%
				<select name="trustStore" class="listbox">
						%invoke wm.server.security.keystore:listTrustStores%
								<option name="" value=""></option>
							%loop trustStores%
								%ifvar isLoaded equals('true')%
									<option name="%value keyStoreName%" value="%value keyStoreName%" %ifvar ../trustStore vequals(keyStoreName)%selected%endif%>%value keyStoreName%</option>
								%endif%
						   %endloop%
						%endinvoke%
				</select>
			%endif%
		</td>
	    </tr>

          <tr>
            <td class="oddrow">Time Interval (seconds)</td>
            <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
              <script>writeEdit('%value -htmlall mode%', 'interval', '%value -htmlall interval%');</script>
            </td>
          </tr>

          <tr>
            <td class="evenrow">Log out after each mail check</td>
            <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
            %ifvar mode equals('view')%
              %switch logout%
                %case 'yes'%Yes
                %case% No
              %endswitch%
            %else%
              <input type="radio" value="yes" name="logout"
                %ifvar logout equals('yes')%checked%endif%>Yes
                  <input type="radio" name="logout" value="no"
                %ifvar logout equals('yes')%%else%checked%endif%>No</input>
            %endif%
            </td>
          </tr>
	
          
          <tr><td class="space" colspan="2">&nbsp;</td></tr>
          
          <tr> <td class="heading" colspan=2>Security</td> </tr>
          <!--  RUN AS USER SUB CHANGES-->
	  	<SCRIPT>
	  			function callback(val){      	    
	  			document.properties.runuser.value=val;
	  			}
		</SCRIPT>
          <tr>
          
            <td class="oddrow">Run services as user</td>
            <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
              %ifvar mode equals('view')%
                %value runuser%
              %else%
                <!--  RUN AS USER SUB CHANGES START-->
                		%ifvar authorize equals('no')%
					<input name="runuser" size=12 value="%value runuser%"></input>
				%else%
					<input name="runuser" size=12 value="%value runuser%" DISABLED></input>
				%endif%
				
				
				<link rel="stylesheet" type="text/css" href="subUserLookup.css" />
				<script type="text/javascript" src="subUserLookup.js"></script>
				
				%ifvar authorize equals('no')%
					<a class="submodal" style="display:inline" id=subUserSearchlink href="subUserLookup.dsp"><img border=0 align="bottom" src="icons/magnifyglass.gif"/></a>  
	    			%else%
	    				<a class="submodal" style="display:none" id=subUserSearchlink href="subUserLookup.dsp"><img border=0 align="bottom" src="icons/magnifyglass.gif"/></a>  
	    			%endif%
	    			
	    	<!--  RUN AS USER SUB END-->
              %endif%
            </td>
          </tr>
          <tr>
            <td class="evenrow">Require authentication within message</td>
            <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
              %ifvar mode equals('view')%
                %switch authorize%
                  %case 'no'%No
                  %case%Yes
                %endswitch%
              %else%
                <input id="subUserSearchYes" type="radio" value="yes" name="authorize" onclick="setAuthorize(true);" 
                	%ifvar authorize equals('no')%%else%checked%endif%>Yes</input>
                  <input type="radio" value="no" name="authorize" onclick="setAuthorize(false);"
                %ifvar authorize equals('no')%checked%endif%>No</input>
                <script>
                	obj = document.getElementById("subUserSearchYes");
			if (obj && obj.checked == true) {
				disableUserSearch();
			} else {
			  enableUserSearch();
			}
                </script>
              %endif%
            </td>
          </tr>
          </table>
          </td>
          <!-- END OF LEFT TABLE -->

          <!-- RIGHT TABLE -->
          <td valign=top >
          <table class="%ifvar ../mode equals('view')%tableView%else%tableForm%endif%" width=100% >
          <tr>
            <td class="heading" colspan=2>Message Processing</td>
          </tr>
          <tr>
            <td class="oddrow">Global Service (optional)</td>
            <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
              <script>writeEdit('%value -htmlall mode%', 'gservice', '%value -htmlall gservice%');</script>
            </td>
          </tr>
          <tr>
            <td class="evenrow">Default Service (optional)</td>
            <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
            <script>writeEdit('%value -htmlall mode%', 'dservice', '%value -htmlall dservice%');</script>
            </td>
          </tr>
          <tr>
            <td class="oddrow">Send reply email with service output</td>
            <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
              %ifvar mode equals('view')%
                %switch reply%
                  %case 'yes'%Yes
                  %case%No
                %endswitch%
              %else%
                <input type="radio" value="yes" name="reply"
                %ifvar reply equals('yes')%checked%endif%>Yes
                  <input type="radio" name="reply" value="no"
                %ifvar reply equals('yes')%%else%checked%endif%>No</input>
              %endif%
            </td>
          </tr>

          <tr>
            <td class="evenrow">Send reply email on error</td>
            <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
              %ifvar mode equals('view')%
                %switch replyonerr%
                  %case 'yes'%Yes
                  %case%No
                %endswitch%
              %else%
                <input type="radio" value="yes" name="replyonerr"
                 %ifvar replyonerr equals('yes')%checked%endif%>Yes
                <input type="radio" name="replyonerr" value="no"
                 %ifvar replyonerr equals('yes')%%else%checked%endif%>No</input>
              %endif%
            </td>
          </tr>
          <tr>
            <td class="oddrow">Delete valid messages (IMAP only)</td>
            <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
              %ifvar mode equals('view')%
                %switch remove%
                  %case 'no'%No
                  %case%Yes
                %endswitch%
              %else%
                <input type="radio" value="yes" name="remove"
                %ifvar remove equals('no')%%else%checked%endif%>Yes
                  <input type="radio" value="no" name="remove" onclick="setRemove();"
                %ifvar remove equals('no')%checked%endif%>No</input>
              %endif%
            </td>
          </tr>
          <tr>
            <td class="evenrow">Delete invalid messages (IMAP only)</td>
            <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
              %ifvar mode equals('view')%
                %switch bad_remove%
                  %case 'no'%No
                  %case%Yes
                %endswitch%
              %else%
                <input type="radio" value="yes" name="bad_remove"
                %ifvar bad_remove equals('no')%%else%checked%endif%>Yes
                  <input type="radio" value="no" name="bad_remove" onclick="setBadRemove();"
                %ifvar bad_remove equals('no')%checked%endif%>No</input>
              %endif%
            </td>
          </tr>
          <tr>
            <td class="oddrow">Multithreaded processing (IMAP only)</td>
            <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
              %ifvar mode equals('view')%
                %switch multithread%
                  %case 'yes'%Yes
                  %case%No
                %endswitch%
              %else%
                <input type="radio" value="yes" name="multithread" onclick="setMultithread(true);"
                %ifvar multithread equals('yes')%checked%endif%>Yes
                  <input type="radio" name="multithread" value="no" onclick="setMultithread(false);"
                %ifvar multithread equals('yes')%%else%checked%endif%>No</input>
              %endif%
            </td>
          </tr>
          <tr>
            <td class="evenrow">Number of threads if multithreading turned on</td>
            <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
              %ifvar mode equals('view')%
                %ifvar multithread equals('yes')%
                  %value num_threads%
                %else%
                  0
                %endif%
              %else%
                <input name="num_threads" size="2" MAXLENGTH="2" value="%ifvar multithread equals('yes')%%value num_threads%%else%0%endif%"/>
              %endif%
             </td>
          </tr>

          <tr>
            <td class="oddrow">Invoke service for each part of multipart message</td>
            <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
              %ifvar mode equals('view')%
                %switch break_mmsg%
                  %case 'no'%No
                  %case%Yes
                %endswitch%
              %else%
                <input type="radio" value="yes" name="break_mmsg"
                %ifvar break_mmsg equals('no')%%else%checked%endif%>Yes
                  <input type="radio" value="no" name="break_mmsg" onclick="setBreakMPMsg();"
                %ifvar break_mmsg equals('no')%checked%endif%>No</input>
              %endif%
            </td>
          </tr>

          <tr>
            <td class="evenrow">Include email headers when passing message to content handler</td>
            <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
              %ifvar mode equals('view')%
                %switch includeHdrs%
                  %case 'no'%No
                  %case%Yes
                %endswitch%
              %else%
                <input type="radio" value="yes" name="includeHdrs"
                %ifvar includeHdrs equals('yes')%checked%endif%>Yes
                  <input type="radio" value="no" name="includeHdrs" onclick="passEmailHdrs();"
                %ifvar includeHdrs equals('yes')%%else%checked%endif%>No</input>
              %endif%
            </td>
          </tr>


          <tr>
            <td class="oddrow">Email body contains URL encoded input parameters</td>
            <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
              %ifvar mode equals('view')%
                %switch urlEncodedBody%
                  %case 'no'%No
                  %case%Yes
                %endswitch%
              %else%
                <input type="radio" value="yes" name="urlEncodedBody"
                %ifvar urlEncodedBody equals('no')%%else%checked%endif%>Yes
                  <input type="radio" value="no" name="urlEncodedBody" onclick="setUrlEncodedBody();"
                %ifvar urlEncodedBody equals('no')%checked%endif%>No</input>
              %endif%
            </td>
          </tr>

          </table>

          %ifvar mode equals('view')%
          %else%
          <tr>
            <td colspan="2" class="action">
            <input type="button" value="Save Changes" onclick="verify();">
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
