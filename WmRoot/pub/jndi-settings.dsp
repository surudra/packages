<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
    <TITLE>Package Exchange</TITLE>
    <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
  </HEAD>
  <BODY onLoad="setNavigation('users.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_UserMgmtLDAPConfigScrn');">
    <TABLE WIDTH=100%>

    <TR>
      <TD class="menusection-Security" colspan=2>
        Security &gt;
        User Management &gt;
        LDAP Configuration
        %ifvar doc equals('edit')%
        	&gt; Edit
        %endif%
        </TD>
    </TR>

%ifvar action equals('change')%
  %invoke wm.server.jndi:setSettings%
      <tr><td colspan="2">&nbsp;</td></tr>
  <TR><TD class="message" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message%</TD></TR>
  %endinvoke%
%endif%

    %invoke wm.server.jndi:getSettings%

    <SCRIPT LANGUAGE="JavaScript">

      var provider = "%value provider%";
      %ifvar ../doc equals('edit')%
      %else%
        %ifvar provider equals('LDAP')%
        // Only jump to ldap settings for LDAP and only when we're not
        // editing
		 if(is_csrf_guard_enabled && needToInsertToken) {
			document.location="ldap-settings.dsp?" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
		 } else {
			document.location="ldap-settings.dsp";
		 }
        %endif%
      %endif%

      function doWarn (needRestart) {
        var msg = "WARNING: changing your provider settings can\neffectively disable your server if the settings\nyou supply are incorrect.\n\nMake sure your provider settings are correct.";
        if(needRestart) msg += "\nYou will have to restart your server to see\nthe effects of these changes.";
        msg += "\n\nDo you wish to continue?\n";
        return confirm (msg);
      }

      function providerSelect () {
      	
		var proSel = document.forms[0].provider;
		var pro;
		
		for (var i=0; i<proSel.length; i++) {
		          if (proSel[i].checked == true) 
		          	pro=  proSel[i].value;
		          
        	}
		
		
		if(pro=='local'){
			document.forms[0].CacheSize.disabled=true;
			document.forms[0].CacheExpire.disabled=true;
		}else if(pro=='LDAP'){
			document.forms[0].CacheSize.disabled=false;
			document.forms[0].CacheExpire.disabled=false;
		} 

	     
        
      }
      
      function providerSubmit () {      
            	
	      var proSel = document.forms[0].provider;
	      var pro;
	      		
	      	for (var i=0; i<proSel.length; i++) {
	      		          if (proSel[i].checked == true) 
	      		          	pro=  proSel[i].value;
	      		          
        	}
	      var old = document.providerform.provider.value;
	      // we don't need to warn iff pro=LDAP&&old=local || pro=local&&old=LDAP
	      if (doWarn(!((pro=='LDAP'&&old=='local')||
			   (pro=='local'&&old=='LDAP') ))) {
		document.providerform.provider.value = pro;
		//document.providerform.submit();



		return true;
	      }
		setProvider (provider);
		return false;
      }

      function setProvider (pro) {
        var proSel = document.forms[0].provider;        
        for (var i=0; i<proSel.length; i++) {
          if (proSel[i].value == provider) proSel[i].checked = true;
        }
        return true;
      }

    </SCRIPT>

    <FORM name="jndiform" method="POST" action="jndi-settings.dsp">
    <INPUT type="hidden" name="action" value="change">

    <TR>
      <TD colspan=2>
        <UL>
          %ifvar ../doc equals('edit')%
            <LI><A HREF="jndi-settings.dsp">Return to LDAP Configuration</A></LI>
          %else%
      <LI><A HREF="users.dsp">Return to User Management</A></LI>
            <LI><A HREF="jndi-settings.dsp?doc=edit">Edit LDAP Configuration</A></LI>

          %endif%
      </TD>
    </TR>
    <TR>
      <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
      <TD>
        <TABLE class="%ifvar doc equals('edit')%tableForm%else%tableView%endif%">
          <TR>
            <TD class="heading" colspan=2>
              LDAP Configuration
            </TD>
          </TR>
          <TR>
            <TD class="oddrow">Provider</TD>
            <TD class="%ifvar ../doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
              %ifvar ../doc equals('edit')%
                
                <!--
                <SELECT name="provider" onchange="providerSelect();">
                  %switch provider%
                  %case 'local'%
                    <OPTION value="local" SELECTED>Local</OPTION>
                    <OPTION value="LDAP">LDAP</OPTION>                    
                  %case 'LDAP'%
                    <OPTION value="local">Local</OPTION>
                    <OPTION value="LDAP" SELECTED>LDAP</OPTION>                                     
                  %endswitch%
                </SELECT>
                -->
                %switch provider%
			%case 'local'%
			<input type="radio" name="provider" value="local" CHECKED onchange="providerSelect();">Local</input>
			<input type="radio" name="provider" value="LDAP" onchange="providerSelect();">LDAP</input>
		        %case 'LDAP'%
		        <input type="radio" name="provider" value="local" onchange="providerSelect();">Local</input>
			<input type="radio" name="provider" value="LDAP" CHECKED onchange="providerSelect();">LDAP</input>
		%endswitch%
                
                
              %else%
                %switch provider%
                %case 'local'%
                  Local
                %case 'LDAP'%
                  LDAP
                %case 'CDS'%
                  Central User Management                
                %endswitch%
                
              %endif%
            </TD>
          </TR>

          %ifvar properties%
            %loop properties%
              <TR>
                <script>writeTD("row");</script>
                  %value description%
                </TD>
              %ifvar ../doc equals('edit')%
                <script>writeTD("rowdata-l");writeEdit("%value ../doc%","%value -code name%","%value -code value%");</script></TD>
	    %else%
                <script>writeTD("rowdata");writeEdit("%value ../doc%","%value -code name%","%value -code value%");</script></TD>
	    %endif%

                <script>swapRows();</script>
                </TR>
            %endloop%
          %else%
          	<!-- this should be the case where provider is local-->
          	%ifvar ../doc equals('edit')%
		<tr>
		  <td class="evenrow"> Cache Size (Number of Users) </td>
		  <script>writeTD("rowdata-l");writeEdit("edit","CacheSize","10");</script></td>
		  <script>swapRows();</script>
		</tr>

		<tr>
		  <td class="oddrow"> Credential Time-to-Live (Minutes) </td>
		  <script>writeTD("rowdata-l");writeEdit("edit","CacheExpire","60");</script></td>
		  <script>swapRows();</script>
		</tr>
		
		<script>
		document.forms[0].CacheSize.disabled=true;
		document.forms[0].CacheExpire.disabled=true;
		</script>
			
		%endif%
          %endif%

          %endinvoke%

          %ifvar doc equals('edit')%
          <TR>
            <TD class="action" colspan="2">
              <INPUT class="button2" type="submit" name="submit" value="Save Configuration" onclick="return providerSubmit()">
            </TD>
          </TR>
          %endif%
        </TABLE>

        </FORM>

        <FORM name="providerform" method="POST" action="jndi-settings.dsp">
          <INPUT type="hidden" name="action" value="change">
          <INPUT type="hidden" name="provider" value="%value provider%">
          <INPUT type="hidden" name="doc" value="edit">
        </FORM>
        </TD>
      </TR>
    </TABLE>

</BODY>
</HTML>
