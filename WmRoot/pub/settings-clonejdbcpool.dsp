<HTML>
<HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">

<TITLE>Integration Server Settings</TITLE>
<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
<SCRIPT SRC="webMethods.js.txt"></SCRIPT>
<SCRIPT>
	String.prototype.trim = function () {
		return this.replace(/^\s*/, "").replace(/\s*$/, "");
	}
    function update()
    {
      if (!verifyRequiredField("form1","clonename"))
      {
         alert("Pool Alias must be specified");
         return false;
      }
      if (document.forms["form1"]["funct"].value == "Clone")
        document.forms["form1"]["funct"].value = "CloneAdd";
	  document.forms["form1"]["url"].value = (document.forms["form1"]["url"].value).trim();
      return true;
    }
    function cloned(pool)
    {
        var newURL = encodeURI("settings-jdbcpool.dsp?addEditACT=clonePool&message="+pool);
		if(is_csrf_guard_enabled && needToInsertToken) {
			newURL = encodeURI("settings-jdbcpool.dsp?addEditACT=clonePool&message="+pool+"&"+ _csrfTokenNm_ + "=" + _csrfTokenVal_);
		} 
        location.href=newURL;
    }
    function clonefailed()
    {
        document.forms["form1"]["funct"].value = "Clone";
    }
    function clonecancel() 
    {
    	document.forms["form1"]["clonename"].value = "";
    }
 	
</SCRIPT>
</HEAD>
 
 
<BODY onLoad="setNavigation('settings-clonejdcbpool.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_CreateJDBC_PoolAliasScrn');">
 
<FORM NAME="form1" method="post" >
  <INPUT NAME="funct" TYPE="hidden" VALUE="%value encode(htmlattr) funct%">

  <TABLE width="100%">
    <TR>
      <TD class="menusection-Settings" colspan="2">
          Settings &gt;
          JDBC Pools &gt;
          Connection Aliases
      </TD>
    </TR>
    %ifvar funct equals(CloneAdd)%
      %invoke wm.server.jdbcpool:clonePoolAlias%
      %ifvar message%
        <SCRIPT>addfailed();</SCRIPT>
        <TR><TD colspan="2">&nbsp;</TD></TR>
        <TR><TD class="message" colspan="2">%value message%</TD></TR>
        <TR><TD colspan="2">&nbsp;</TD></TR>
      %else%
        <SCRIPT>cloned("%value clonename%")</SCRIPT>
      %endif%
      %onerror%
        <SCRIPT>clonefailed();</SCRIPT>
        <TR><TD colspan="2">&nbsp;</TD></TR>
        <TR><TD class="message" colspan="2">%value errorMessage%</TD></TR>
        <TR><TD colspan="2">&nbsp;</TD></TR>
      %endinvoke%
    %endif%
    <TR>
      <TD colspan="2">
        <UL>
          <LI><A HREF="settings-jdbcpool.dsp">Return to JDBC Pool Definitions</A></LI>
          %ifvar funct equals(Display)%
          <LI><A HREF="settings-editjdbcpool.dsp?funct=Edit&pool=%value -urlencode pool%">Edit this JDBC Connection Pool Alias definition</A></LI>
          %endif%     
        </UL>
      </TD>
    </TR>
    <TR> 
       <TD>
        <IMG SRC="images/blank.gif" height=10 width=10 border=0>
      </TD>
          <TR>
            <TD class="heading" colspan="2">JDBC Connection Pool Alias - Copy</TD>
          </TR>
      <TD>
        <TABLE class="tableForm">
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Copy From</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                %invoke wm.server.jdbcpool:getPoolDefinitions%
                  %ifvar message%
                    </TD></TR>
                    <TR><TD colspan="2">&nbsp;</TD></TR>
                    <TR><TD class="message" colspan="2">%value message%</TD></TR>
                    <TR><TD colspan="2">&nbsp;</TD></TR>
                  %endif%
                  <SELECT NAME="pool">
                  %loop pools%
                    <OPTION VALUE="%value pool.name%" %ifvar ../pool vequals(pool.name)% SELECTED %endif%>%value pool.name%
                  %endloop%
                  </SELECT>
                  </TD></TR>
                %onerror%
                  </TD></TR>
                  <TR><TD colspan="2">&nbsp;</TD></TR>
                  <TR><TD class="message" colspan="2">%value errorMessage%</TD></TR>
                  <TR><TD colspan="2">&nbsp;</TD></TR>
                %endinvoke%
            <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Alias Name</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
            <INPUT NAME="clonename" TYPE="TEXT" VALUE="" SIZE="60">
            </TD>    
          </TR>
          <SCRIPT>swapRows();</SCRIPT>
            <TR>
              <TD colspan="2" class="action">
                <INPUT type="submit" value="Copy Settings" onClick="return update();">
                <INPUT type="button" value="Cancel" onClick="return clonecancel();">
              </TD>
            </TR>
         </TABLE>
      </TD>
    </TR>
  </TABLE>      
</FORM>
</BODY>
</HTML>
