
<HTML>
  <HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt">
    </SCRIPT>
    <base target="_self">
	<style>
	  .listbox  { width: 100%; }
	</style>
  </HEAD>
  %ifvar action equals('edit')%
  <BODY onLoad="loadKeyStoresOptions(); toggleSSL('%value -urlencode ssl%'); setNavigation('settings-remote.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditRemoteSvrAliasScrn');">
  %else%
  <BODY onLoad="loadKeyStoresOptions(); toggleSSL('%value -urlencode ssl%'); setNavigation('settings-remote.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_CreateRemoteSvrAliasScrn');">
  %endif%
    <TABLE width="100%">
      <TR>
        <TD class="menusection-Settings" colspan="2">
            Settings &gt;
            Remote Servers &gt;
            %ifvar action equals('edit')%
                %value alias% &gt; Edit
            %else%
                Create Alias
            %endif%
        </TD>
      </TR>
      <TR>
        <TD colspan="2">
          <UL>
            <LI><A HREF="settings-remote.dsp">Return to Remote Servers</A></LI>
          </UL>
        </TD>
      </TR>
      <TR>
        <TD></TD>
        <TD>
      <TABLE class="tableForm">
        <TR>
            <TD colspan="2" class="heading">Remote Server Alias Properties</TD>
        </TR>
          <FORM NAME="addform" ACTION="settings-remote.dsp" METHOD="POST">
          <SCRIPT LANGUAGE="JavaScript">
          
          var hiddenOptions = new Array();
      
	      function loadKeyStoresOptions()
	      {
			    var ks = document.addform.keyStoreAlias.options
	      		%invoke wm.server.security.keystore:listKeyStoresAndConfiguredKeyAliases%
	      			   ks[ks.length] = new Option("","");
				       hiddenOptions[ks.length-1] = new Array();
				       
			       	   %loop keyStoresAndConfiguredKeyAliases%
			       			ks.length=ks.length+1;
				       		ks[ks.length-1] = new Option("%value encode(javascript) keyStoreName%","%value encode(javascript) keyStoreName%");
			           		var aliases = new Array();
			    	   		%loop keyAliases%
			       				aliases[%value $index%] = new Option("%value%","%value%");		
			       			%endloop%
			       			if (aliases.length == 0)
			       			{
								aliases[0] = new Option("","");		
							}
				       		hiddenOptions[ks.length-1] = aliases;
		       	   %endloop%
			    %endinvoke%
			    
			    var keyOpts = document.addform.keyStoreAlias.options;
    			var key = "%value encode(javascript) keyStoreAlias%";
				if ( key != "") 
				{
	       			for(var i=0; i<keyOpts.length; i++) 
	       			{
				    	if(key == keyOpts[i].value) {
				    		keyOpts[i].selected = true;
		    			}
			      	}
				}
				
				changeval();
				
				var aliasOpts = document.addform.keyAlias.options;
    			var alias = '%value encode(javascript) keyAlias%';
				if ( alias != "") 
				{
	       			for(var i=0; i<aliasOpts.length; i++) 
	       			{
				    	if(alias == aliasOpts[i].value) {
				    		aliasOpts[i].selected = true;
		    			}
			      	}
				}
	      }
	      
	      function changeval() {
       		var ks = document.addform.keyStoreAlias.options;
       		var selectedKS = document.addform.keyStoreAlias.value;
       		for(var i=0; i<ks.length; i++) {
       			if(selectedKS == ks[i].value) {
		       		var aliases = hiddenOptions[i];
       				document.addform.keyAlias.options.length = aliases.length;
       				for(var j=0;j<aliases.length;j++) {
       					var opt = aliases[j];
       					document.addform.keyAlias.options[j] = new Option(opt.text, opt.value);
     				}
       			}
       		}
		}
		
          function confirmEdit ()
          {
            if ((document.addform.alias.value == "") ||
                (document.addform.port.value == "")  ||
                (document.addform.host.value == "")  ||
                (document.addform.user.value == "")  ||
                (document.addform.pass.value == "")  )
            {
              alert ("You must specify the arguments (Alias, Host Name or IP Address, Port Number, User Name, Password) for the remote server.");
            }
            else
            {
				if ( !isHostValid() ) {
					return false;
				}
				
				if ( !isRetryServerValid() ) {
					return false;
				}
				
             	if (document.addform.ssl[0].checked)
             	{
             		if (!checkSSL())
             		{
             			alert("KeyAlias is empty.");
             			return false;
             		}
             	}
             	
   		if (!checkKeepAlive())
			return false;
			 	
            	if (! checkLegalName (document.addform.alias, "Alias") ||
                    (! checkLegalUserName (document.addform.user.value, "User Name")))
            	{
            		return false;
            	}
		
		if ( !checkDuplicateAliases("edit") ) {
			return false;
		}
			 
              document.addform.submit();
              return true;
            }
            return false;
          }
          
          function checkSSL()
          {
       		if ( document.addform.keyStoreAlias.value == "" && document.addform.keyAlias.value == "" ) 
       			return true;
       		else if (document.addform.keyStoreAlias.value == "" || document.addform.keyAlias.value == "" )
       			return false;
       		else
       			return true;
          }
          
		  function isHostValid() {
				var host = addform.host.value;
				
				var invlaidChars = ' ';
				for(var i=0;i<host.length; i++)
				{
					var ch = host.charAt(i);
					if(-1 != invlaidChars.indexOf(ch))
					{
						alert('The specified host name or IP address is invalid. Host names and IP addresses cannot contain spaces.');
						addform.host.focus();
						return false;
					}
				}
				
				return true;
		  }

		  function isRetryServerValid() {
				var host = addform.retryServer.value;
				
				var invlaidChars = ' ';
				for(var i=0;i<host.length; i++)
				{
					var ch = host.charAt(i);
					if(-1 != invlaidChars.indexOf(ch))
					{
						alert('The specified Retry Server is invalid. Retry Server cannot contain spaces.');
						addform.retryServer.focus();
						return false;
					}
				}
				
				return true;
		  }
		  
          function checkDuplicateAliases(addoredit) {
          		
          		if ( addoredit == "edit" ) {
				if (document.addform.oldAlias.value == document.addform.alias.value) {
				   return true;
				}          		
          		}
          
                        var aliasesArray;
	                if (! document.addform.aliases)
	                {
	                  aliasesArray = new Array(0);
	                }
	                else if (! document.addform.aliases.length)
	                {
	                  aliasesArray = new Array(1);
	                  aliasesArray[0] = document.addform.aliases.value;
	                }
	                else
	                {
	                  var aliasesLen = document.addform.aliases.length;
	                  aliasesArray = new Array(aliasesLen);
	                  for (i = 0; i < aliasesLen; i++)
	                  {
	                    aliasesArray[i] = document.addform.aliases[i].value;
	                  }
	                }
	              
	                for (ind = 0; ind < aliasesArray.length; ind++)
	                {
	                  if (aliasesArray[ind] == document.addform.alias.value)
	                  {
	                    var confirmation = confirm("Do you want to overwrite existing alias " + document.addform.alias.value + "?");
	                    if (confirmation == false)
	                    {
	                      return false;
	                    }
	  	        }
	  	      }
		
		      return true;
          }
          
          function confirmAdd ()
          {
            if ((document.addform.alias.value == "") ||
                (document.addform.port.value == "")  ||
                (document.addform.host.value == "")  ||
                (document.addform.user.value == "")  ||
                (document.addform.pass.value == "")  )
            {
              alert ("You must specify the arguments (Alias, Host Name or IP Address, Port Number, User Name, Password) for the remote server.");              return false;
            }
            else if (! checkLegalName (document.addform.alias, "Alias") ||
                    (! checkLegalUserName (document.addform.user.value, "User Name")))
            {
            }
            else
            {
			
				if ( !isHostValid() ) {
					return false;
				}

				if ( !isRetryServerValid() ) {
					return false;
				}

		if ( !checkDuplicateAliases("add") ) {
			return false;
		}

		      if (document.addform.ssl[0].checked)
             {
             	if (!checkSSL())
             	{
             		alert("KeyAlias is empty.");
             		return false;
             	}
             }
			 if (!checkKeepAlive())
			 	return false;
			 	
             document.addform.submit();
           	 return true;
            }
            return true;
          }
          
          function checkKeepAlive()
          {
          	 var regExp = /^[0-9]+$/;
          	 var keepAlive = document.addform.keepalive.value;
          	 if ( keepAlive != "")
          	 {
	          	 if (keepAlive <= 0 || keepAlive.match(regExp) == null)
	          	 {
	          	    alert("Max Keep Alive Connections must be a positive integer greater than 0");
	          	 	document.addform.keepalive.focus();
	          	 	return false;
	          	 }
    		  }      	
	
		 regExp = /^[0-9]*\.?[0-9]+$/;
          	 var timeOut = document.addform.timeout.value;
          	 if ( timeOut != "")
          	 {
	          	 if (timeOut <= 0 || timeOut.match(regExp) == null)
    	      	 {
        	  	 	alert("Keep Alive Timeout must be a positive float value greater than 0");
          		 	document.addform.timeout.focus();
          	 		return false;
          	 	}
          	 }
          	 return true;
          }
          
      	  function checkLegalName(field, fieldName)
      	  {
            var name = field.value;
            var illegalChars = "- #&@^!%*:$./\\`;,~+=)(|}{][><\"";

            for (var i=0; i<illegalChars.length; i++)
            {
              if (name.indexOf(illegalChars.charAt(i)) >= 0)
              {
                alert (fieldName + " contains illegal character: '" + illegalChars.charAt(i) + "'");
                return false;
              }
            }
            return true;
          }
      	  function checkLegalUserName(userName, fieldName)
      	  {
            var illegalChars = " \\\"";

            for (var i=0; i<illegalChars.length; i++)
            {
              if (userName.indexOf(illegalChars.charAt(i)) >= 0)
              {
                alert (fieldName + " contains illegal character: '" + illegalChars.charAt(i) + "'");
                return false;
              }
            }
            return true;
          }
          
		  var agent = navigator.userAgent.toLowerCase();
    	  var ie = (agent.indexOf("msie") != -1);          
    	  
          function toggleSSL(val)
          {
	        elem = document.getElementById('sslSection');
	        rows = elem.rows;
	        if ( val == 'yes') {
		        for(i = 0; i < rows.length; i++)
		        {
		           	if (ie) {
			            rows[i].style.display="block";
			        }
			        else
			        {
			        	rows[i].style.display="block";
			        	rows[i].style.display="table-row";
			        }
	  			}
			}
			else
			{
			   for(i = 0; i < rows.length; i++)
	   			     rows[i].style.display="none";
			}
          }
          
          </SCRIPT>
          <TR>
            <TD class="oddrow">Alias</TD>
            <TD class="oddrow-l">
              <INPUT NAME="alias" VALUE="%value alias%"> </TD>
          </TR>
          <TR>
            <TD class="evenrow">Host Name or IP Address</TD>
            <TD class="evenrow-l">
              <INPUT NAME="host" VALUE="%value host%"> </TD>
          </TR>
          <TR>
            <TD class="oddrow">Port Number</TD>
            <TD class="oddrow-l">
              <INPUT NAME="port" VALUE="%value port%" SIZE=5 MAXLENGTH=5> </TD>
          </TR>
          <TR>
            <TD class="evenrow">User Name</TD>
            <TD class="evenrow-l">
              <INPUT NAME="user" VALUE="%value user%"> </TD>
          </TR>
          <TR>
            <TD class="oddrow">Password</TD>
            <TD class="oddrow-l">
              <INPUT NAME="pass" TYPE="password" autocomplete="off" VALUE="%value pass%"/> </TD>
          </TR>
          <TR>
            <TD class="evenrow">Execute ACL</TD>
            <TD class="evenrow-l">%invoke wm.server.access.adminui:aclList%
              <SELECT name="acl">
<!--                <OPTION value="">&lt;Default ACL&gt;</OPTION> -->
                %loop aclgroups%
                <OPTION
                  %ifvar ../acl vequals(name)%selected%endif%
                  %ifvar ../acl%%else%%ifvar name equals('Internal')%selected%endif%%endif% value="%value name%">%value name%</OPTION>
                %endloop%
              </SELECT> %endinvoke%  </TD>
          </TR>
          <TR>
            <TD class="oddrow">Max Keep Alive Connections</TD>
            <TD class="oddrow-l">
              <INPUT NAME="keepalive" VALUE="%value keepalive%" SIZE=5 MAXLENGTH=5> (Default 5)</TD>
          </TR>
          <TR>
            <TD class="evenrow">Keep Alive Timeout (minutes)</TD>
            <TD class="evenrow-l">
              <INPUT NAME="timeout" VALUE="%value timeout%" SIZE=5 MAXLENGTH=5> (Default 1)</TD>
          </TR>
          <TR>
            <TD class="oddrow">Use SSL</TD>
            <TD class="oddrow-l">
				<input type="radio" name="ssl" value="yes" onclick="toggleSSL('yes');" %ifvar ssl equals(yes)%checked%endif%>Yes</input>
				<input type="radio" name="ssl" value="no"  onclick="toggleSSL('no');" %ifvar ssl equals(no)%checked %else% %ifvar action equals('edit')%%else%checked%endif%%endif%>No</input>
			</TD>
          </TR>
          
          <tbody id="sslSection">
	          <TR>
				<TD class="evenrow">Keystore Alias (optional)</TD>
				<TD class="evenrowdata-l">
					<SELECT class="listbox" name="keyStoreAlias" onchange="changeval()"></SELECT>
		        </TD>
			  </TR>
			  <TR>
			   	<TD class="oddrow">Key Alias (optional)</TD>
			    <TD class="oddrowdata-l">
		        	<select class="listbox" name="keyAlias" ></select>  		
		        </TD>
			   </TR>
		 </tbody>			  
		 
          <TR>
            <TD class="evenrow">Retry Server</TD>
            <TD class="evenrow-l">
              <INPUT NAME="retryServer" VALUE="%value retryServer%"> </TD>
          </TR>

          %invoke wm.server.remote:serverList%

          <TR>
          %loop -struct servers%
            %scope #$key%
            <TD>
              <INPUT TYPE="hidden" NAME="aliases" VALUE="%value alias%" />
            </TD>
            %endscope%
          %endloop%
          </TR>

          <TR>
            <TD colspan=2 class="action">
              <INPUT TYPE="hidden" NAME="args" VALUE="xxx">
            %ifvar action equals('edit')%
              <INPUT TYPE="hidden" NAME="action" VALUE="edit">
              <INPUT TYPE="hidden" NAME="oldAlias" VALUE="%value alias%">
              <INPUT type="button" value="Save Changes" onclick="return confirmEdit();">
            %else%
              <INPUT TYPE="hidden" NAME="action" VALUE="add">
              <INPUT type="button" value="Save Changes" onclick="return confirmAdd();">
            %endif%
            </TD>
          </TR>
          
          

          
        </FORM>
      </TABLE>
    </TD>
  </TR>
</TABLE>

    </BODY>
  </HTML>
