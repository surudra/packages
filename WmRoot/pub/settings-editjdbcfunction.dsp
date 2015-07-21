<HTML>
<HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">

<TITLE>Integration Server Settings</TITLE>
<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
<SCRIPT SRC="webMethods.js.txt"></SCRIPT>
<SCRIPT>
    function add()
    {
      if (!verifyRequiredField("form1","function.name"))
      {
         alert("Function Alias must be specified");
         return false;
      }
      var pool = document.forms["form1"]["pool"].value;
      if (pool.length < 1)
      {
         if (!confirm("Do you really want to add the Functional Alias without an Associated Pool?"))
         {
             return false;
         } 
      }   
      document.forms["form1"]["funct"].value = "UpdateAdd";
      return true;
    }
    function update()
    {
      var pool = document.forms["form1"]["pool"].value;
      if (pool.length < 1)
      {
         if (!confirm("Do you really want to update the Functional Alias without an Associated Pool?"))
         {
             return false;
         } 
      }   
      document.forms["form1"]["origfunct"].value = document.forms["form1"]["funct"].value;
      document.forms["form1"]["funct"].value = "Update";
      document.forms["form1"]["function.pool"].value = pool;
      return true;
    }
    function generate()
    {
      if (!verifyRequiredField("form1","function.name"))
      {
         alert("Function Alias must be specified");
         return false;
      }
      var pool = document.forms["form1"]["pool"].value;
      if (pool.length > 0)
      {
         if (!confirm("Do you really want to generate the .XML file with an Associated Pool?"))
         {
          return false;
         }
      }   
      document.forms["form1"]["origfunct"].value = document.forms["form1"]["funct"].value;
      document.forms["form1"]["funct"].value = "Generate";
      document.forms["form1"]["function.pool"].value = pool;
      return true;
    }
    function deleteFunct(alias)
    {
      var msg = " Delete the Funtional Alias:"+alias;
      if(confirm(msg))
      {
        document.forms["form1"]["funct"].value = "Delete";
        return true;
      }
      return false;
    }
    function updated(alias)
    {
        var newURL = encodeURI("settings-jdbcpool.dsp?message=Functional Alias "+alias+" updated. Please restart the server to make the new settings take effect.");
		if(is_csrf_guard_enabled && needToInsertToken) {
			newURL = encodeURI("settings-jdbcpool.dsp?message=Functional Alias "+alias+" updated. Please restart the server to make the new settings take effect."+"&"+ _csrfTokenNm_ + "=" + _csrfTokenVal_);
		}
        location.href=newURL;
    }
    function added(alias)
    {
        var newURL = encodeURI("settings-jdbcpool.dsp?message=Functional Alias "+alias+" added. Please restart the server to make the new settings take effect.");
		if(is_csrf_guard_enabled && needToInsertToken) {
			newURL = encodeURI("settings-jdbcpool.dsp?message=Functional Alias "+alias+" added. Please restart the server to make the new settings take effect."+"&"+ _csrfTokenNm_ + "=" + _csrfTokenVal_);
		}
        location.href=newURL;
    }
    function deleted(alias)
    {
        var newURL = encodeURI("settings-jdbcpool.dsp?message=Functional Alias "+alias+" deleted.");
		if(is_csrf_guard_enabled && needToInsertToken) {
			newURL = encodeURI("settings-jdbcpool.dsp?message=Functional Alias "+alias+" deleted."+"&"+ _csrfTokenNm_ + "=" + _csrfTokenVal_);
		}
        location.href=newURL;
    }
    function generated(alias)
    {
        var newURL = encodeURI("settings-jdbcpool.dsp?message=Functional Alias "+alias+" generated.");
		if(is_csrf_guard_enabled && needToInsertToken) {
			newURL = encodeURI("settings-jdbcpool.dsp?message=Functional Alias "+alias+" generated."+"&"+ _csrfTokenNm_ + "=" + _csrfTokenVal_);
		}
        location.href=newURL;
    }
    function updatefailed()
    {
        document.forms["form1"]["funct"].value = "Edit";
    }
    function deletefailed()
    {
        document.forms["form1"]["funct"].value = "Edit";
    }
    function generatefailed()
    {
        document.forms["form1"]["funct"].value = document.forms["form1"]["origfunct"].value;
    }
    function addfailed()
    {
        document.forms["form1"]["funct"].value = "Add";
    }
</SCRIPT>
</HEAD>
<BODY onLoad="setNavigation('settings-editjdcbfunction.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditJDBC_FunctionalAliasScrn');">
%comment%
    body
    %loop -struct%
    %value $key% %value%<BR>
    %endloop%
%endcomment%
<FORM NAME="form1">
  <INPUT NAME="function" TYPE="hidden" VALUE="%value encode(htmlattr) function%">  
  <INPUT NAME="funct" TYPE="hidden" VALUE="%value encode(htmlattr) funct%">  
  <INPUT NAME="origfunct" TYPE="hidden" VALUE="%value encode(htmlattr) funct%">  
  <INPUT NAME="internal" TYPE="hidden" VALUE="%value encode(htmlattr) internal%">  
  <TABLE width="100%">
    <TR>
      <TD class="menusection-Settings" colspan="2">
          Settings &gt;
          JDBC Pools &gt;
          Functional Definitions
          %ifvar funct equals(Edit)%	            
	      &gt Edit
          %endif%
      </TD>
    </TR>
    %switch funct%
    %case 'UpdateAdd'%
      %invoke wm.server.jdbcpool:addFunctionalAlias%
        %ifvar message%
          <SCRIPT>addfailed();</SCRIPT>
          %ifvar message%
            <TR><TD colspan="2">&nbsp;</TD></TR>
            <TR><TD class="message" colspan="2">%value message%</TD></TR>
            <TR><TD colspan="2">&nbsp;</TD></TR>
          %endif%
        %else%
          <SCRIPT>added("%value function%");</SCRIPT>
        %endif%
      %onerror%
          <SCRIPT>addfailed();</SCRIPT>
          <TR><TD colspan="2">&nbsp;</TD></TR>
          <TR><TD class="message" colspan="2">%value errorMessage%</TD></TR>
          <TR><TD colspan="2">&nbsp;</TD></TR>
      %endinvoke%
    %case 'Generate'%
      %invoke wm.server.jdbcpool:generateFunctionalAlias%
        %ifvar message%
          <SCRIPT>generatefailed();</SCRIPT>
          %ifvar message%
            <TR><TD colspan="2">&nbsp;</TD></TR>
            <TR><TD class="message" colspan="2">%value message%</TD></TR>
            <TR><TD colspan="2">&nbsp;</TD></TR>
          %endif%
        %else%
          <SCRIPT>generated("%value function%");</SCRIPT>
        %endif%
      %onerror%
          <SCRIPT>generatefailed();</SCRIPT>
          <TR><TD colspan="2">&nbsp;</TD></TR>
          <TR><TD class="message" colspan="2">%value errorMessage%</TD></TR>
          <TR><TD colspan="2">&nbsp;</TD></TR>
      %endinvoke%
    %case 'Update'%
      %invoke wm.server.jdbcpool:updateFunctionalAlias%
        %ifvar message%
          <SCRIPT>updatefailed();</SCRIPT>
          %ifvar message%
            <TR><TD colspan="2">&nbsp;</TD></TR>
            <TR><TD class="message" colspan="2">%value message%</TD></TR>
            <TR><TD colspan="2">&nbsp;</TD></TR>
          %endif%
        %else%
          <SCRIPT>updated("%value function%");</SCRIPT>
        %endif%
      %onerror%
          <SCRIPT>updatefailed();</SCRIPT>
          <TR><TD colspan="2">&nbsp;</TD></TR>
          <TR><TD class="message" colspan="2">%value errorMessage%</TD></TR>
          <TR><TD colspan="2">&nbsp;</TD></TR>
      %endinvoke%
    %case 'Delete'%
      %invoke wm.server.jdbcpool:deleteFunctionalAlias%
        %ifvar message%
          <SCRIPT>deletefailed();</SCRIPT>
          <TR><TD colspan="2">&nbsp;</TD></TR>
          <TR><TD class="message" colspan="2">%value message%</TD></TR>
          <TR><TD colspan="2">&nbsp;</TD></TR>
        %else%
          <SCRIPT>deleted("%value function%");</SCRIPT>
        %endif%
      %onerror%
          <SCRIPT>deletefailed();</SCRIPT>
          <TR><TD colspan="2">&nbsp;</TD></TR>
          <TR><TD class="message" colspan="2">%value errorMessage%</TD></TR>
          <TR><TD colspan="2">&nbsp;</TD></TR>
      %endinvoke%
    %case 'Edit'%
      %invoke wm.server.jdbcpool:getFunctionalAlias%
        %ifvar message%
          <TR><TD colspan="2">&nbsp;</TD></TR>
          <TR><TD class="message" colspan="2">%value message%</TD></TR>
          <TR><TD colspan="2">&nbsp;</TD></TR>
        %endif%
      %onerror%
          <TR><TD colspan="2">&nbsp;</TD></TR>
          <TR><TD class="message" colspan="2">%value errorMessage%</TD></TR>
          <TR><TD colspan="2">&nbsp;</TD></TR>
      %endinvoke%
    %endswitch%
    <TR>
      <TD colspan="2">
        <UL>
          <LI><A HREF="settings-jdbcpool.dsp?">Return to JDBC Pool Definitions</A></LI>
        </UL>
      </TD>
    </TR>
    <TR> 
       <TD>
        <IMG SRC="images/blank.gif" height=10 width=10 border=0>
      </TD>
      <TD>
          <TABLE class="tableForm">
          <TR>
            <TD class="heading" colspan="2">JDBC Functional Alias</TD>
          </TR>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Function Name</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
              %ifvar funct equals(Add)%
                <INPUT NAME="function.name" TYPE="TEXT" VALUE="">
              %else%
                <INPUT NAME="function.name" TYPE="HIDDEN" VALUE="%value encode(htmlattr) function.name%">
                %value function.name%
              %endif%
            </TD>    
          </TR>
          <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Function Description</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
              %ifvar funct equals(Add)%
                <INPUT NAME="function.description" TYPE="TEXT" VALUE="%value encode(htmlattr) function.description%">
               %else%
                 %ifvar funct equals(Edit)%
                   %ifvar internal equals(true)%
                     <INPUT TYPE="TEXT" NAME="function.description" VALUE="%value encode(htmlattr) function.description%">
                   %else%
                     <INPUT NAME="function.description" TYPE="HIDDEN" VALUE="%value encode(htmlattr) function.description%">
                     %value function.description%
                   %endif%                
                 %else%  
                   <INPUT NAME="function.description" TYPE="HIDDEN" VALUE="%value encode(htmlattr) function.description%">
                   %value function.description%
                 %endif%
              %endif%
            </TD>
          </TR>
          <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Associated Pool Alias</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                %invoke wm.server.jdbcpool:getAvailablePoolDefinitions%
                  %ifvar message%
                    </TD></TR>
                    <TR><TD colspan="2">&nbsp;</TD></TR>
                    <TR><TD class="message" colspan="2">%value message%</TD></TR>
                    <TR><TD colspan="2">&nbsp;</TD></TR>
                  %endif%
                  <SELECT NAME="pool">
                    <OPTION VALUE="" %ifvar function.pool notempty% %else% SELECTED %endif%>None
                  %loop pools%
                    <OPTION VALUE="%value pool.name%" %ifvar ../function.pool vequals(pool.name)% SELECTED %endif%>%value pool.name%
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
          %switch funct%
            %case 'Add'%
                <TR>
                  <SCRIPT>writeTDnowrap("row");</SCRIPT>
                    Auto Commit</TD>
                  <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                    <INPUT NAME="function.autocommit" TYPE="checkbox" VALUE="active" %ifvar function.autocommit equals(active)%CHECKED%endif%>
                  </TD>
                </TR>
                <SCRIPT>swapRows();</SCRIPT>
                <TR>
                  <SCRIPT>writeTDnowrap("row");</SCRIPT>
                    Statement Cache</TD>
                  <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                    <INPUT NAME="function.cache" TYPE="checkbox" VALUE="active" %ifvar function.cache equals(active)%CHECKED%endif%>
                  </TD>
                </TR>
                <SCRIPT>swapRows();</SCRIPT>
                <TR>
                  <SCRIPT>writeTDnowrap("row");</SCRIPT>
                    Isolation Level</TD>
                  <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                    <SELECT NAME="isolationlevel">
                      <OPTION VALUE="-1" %ifvar function.isolationlevel equals(-1)%SELECTED%endif%>Database default
                      <OPTION VALUE="0" %ifvar function.isolationlevel equals(0)% SELECTED%endif%>TRANSACTION_NONE
                      <OPTION VALUE="1" %ifvar function.isolationlevel equals(1)% SELECTED%endif%>TRANSACTION_READ_UNCOMMITTED
                      <OPTION VALUE="2" %ifvar function.isolationlevel equals(2)% SELECTED%endif%>TRANSACTION_READ_COMMITTED
                      <OPTION VALUE="4" %ifvar function.isolationlevel equals(4)% SELECTED%endif%>TRANSACTION_REPEATABLE_READ
                      <OPTION VALUE="8" %ifvar function.isolationlevel equals(8)% SELECTED%endif%>TRANSACTION_SERIALIZABLE
                    </SELECT>
                  </TD>
                </TR>
                <SCRIPT>swapRows();</SCRIPT>
                <TR>
                 <TD class="action">
                    <INPUT type="submit" value="Generate .XML" onClick="return generate();">
                  </TD>
                  <TD class="action">
                    <INPUT type="submit" value="Save into Repository" onClick="return add();">
                  </TD>
                 </TR>
            %case 'Edit'%
              %ifvar internal equals(true)%
                <TR>
                  <SCRIPT>writeTDnowrap("row");</SCRIPT>
                    Auto Commit</TD>
                  <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                    <INPUT NAME="function.autocommit" TYPE="checkbox" VALUE="active" %ifvar function.autocommit equals(active)%CHECKED%endif%>
                  </TD>
                </TR>
                <SCRIPT>swapRows();</SCRIPT>
                <TR>
                  <SCRIPT>writeTDnowrap("row");</SCRIPT>
                    Statement Cache</TD>
                  <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                    <INPUT NAME="function.cache" TYPE="checkbox" VALUE="active" %ifvar function.cache equals(active)%CHECKED%endif%>
                  </TD>
                </TR>
                <SCRIPT>swapRows();</SCRIPT>
                <TR>
                  <SCRIPT>writeTDnowrap("row");</SCRIPT>
                    Isolation Level</TD>
                  <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                    <SELECT NAME="isolationlevel">
                      <OPTION VALUE="-1" %ifvar function.isolationlevel equals(-1)%SELECTED%endif%>Database default
                      <OPTION VALUE="0" %ifvar function.isolationlevel equals(0)% SELECTED%endif%>TRANSACTION_NONE
                      <OPTION VALUE="1" %ifvar function.isolationlevel equals(1)% SELECTED%endif%>TRANSACTION_READ_UNCOMMITTED
                      <OPTION VALUE="2" %ifvar function.isolationlevel equals(2)% SELECTED%endif%>TRANSACTION_READ_COMMITTED
                      <OPTION VALUE="4" %ifvar function.isolationlevel equals(4)% SELECTED%endif%>TRANSACTION_REPEATABLE_READ
                      <OPTION VALUE="8" %ifvar function.isolationlevel equals(8)% SELECTED%endif%>TRANSACTION_SERIALIZABLE
                    </SELECT>
                  </TD>
                </TR>
                <SCRIPT>swapRows();</SCRIPT>
                <TR>
                  <TD class="action">
                    <INPUT type="submit" value="Generate .XML" onClick="return generate();">
                  </TD>
                  <TD class="action">
                    <TABLE>
                      <TR>
                        <TD> 
                          <INPUT type="submit" value="Save into Repository" onClick="return update();">
                        </TD>
                        <TD>
                          <INPUT type="submit" value="Delete from Repository" onClick="return deleteFunct('%value function.name%');">
                        </TD>
                      </TR>
                    </TABLE>
                  </TD> 
                </TR>
              %else%
                <TR>
                  <TD colspan="2" class="action">
                    <INPUT type="submit" value="Save Settings" onClick="return update();">
                  </TD>
                </TR>
                <INPUT NAME="isolationlevel" TYPE="hidden" VALUE="%value encode(htmlattr) function.isolationlevel%">
                <INPUT NAME="function.cache" TYPE="hidden" VALUE="%value encode(htmlattr) function.cache%">
                <INPUT NAME="function.autocommit" TYPE="hidden" VALUE="%value encode(htmlattr) function.autocommit%">
                <INPUT NAME="function.pool" TYPE="hidden" VALUE="%value encode(htmlattr) function.pool%">
                <INPUT NAME="function.description" TYPE="HIDDEN" VALUE="%value encode(htmlattr) function.description%">
              %endif%
          %endswitch%
        </TABLE>
      </TD>
    </TR>
  </TABLE>      
</FORM>
</BODY>
</HTML>
