<HTML>
<HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">

<TITLE>Integration Server Settings</TITLE>
<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
<SCRIPT SRC="webMethods.js.txt"></SCRIPT>
<SCRIPT>
    function update()
    {
      if (!verifyRequiredField("form1","driver"))
      {
         alert("Driver Alias Must be specified");
         return false;
      }
      if (!verifyRequiredField("form1","classname"))
      {
         alert("Driver Class Name Must be specified");
         return false;
      }
      if (document.forms["form1"]["funct"].value == "Add")
        document.forms["form1"]["funct"].value = "UpdateAdd";
      if (document.forms["form1"]["funct"].value == "Edit")
        document.forms["form1"]["funct"].value = "Update";
      return true;
    }
 
    function added(driver)
    {
        var newURL = encodeURI("settings-jdbcpool.dsp?addEditACT=addDriver&message="+driver);
		if(is_csrf_guard_enabled && needToInsertToken) {
			newURL = encodeURI("settings-jdbcpool.dsp?addEditACT=addDriver&message="+driver+"&"+ _csrfTokenNm_ + "=" + _csrfTokenVal_);
		}
        location.href = newURL;
    }
    function updated(driver)
    {
        var newURL = encodeURI("settings-jdbcpool.dsp?addEditACT=updateDriver&message="+driver);
		if(is_csrf_guard_enabled && needToInsertToken) {
			newURL = encodeURI("settings-jdbcpool.dsp?addEditACT=updateDriver&message="+driver+"&"+ _csrfTokenNm_ + "=" + _csrfTokenVal_);
		}
        location.href = newURL;
    }
    function updatefailed()
    {
        document.forms["form1"]["funct"].value = "Edit";
    }
    function addfailed()
    {
        document.forms["form1"]["funct"].value = "Add";
    }
</SCRIPT>
</HEAD>
%ifvar funct equals(Add)%
    
  <BODY onLoad="setNavigation('settings-editjdcbdriver.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_CreateJDBC_DriverAliasScrn');">

%else%
  
  <BODY onLoad="setNavigation('settings-editjdcbdriver.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditJDBC_DriverAliasScrn');">
  
%endif%



<FORM NAME="form1">
  %ifvar funct equals(Add)%
  %else%
  <INPUT NAME="driver" TYPE="hidden" VALUE="%value encode(htmlattr) driver%">  
  %endif%
  <INPUT NAME="funct" TYPE="hidden" VALUE="%value encode(htmlattr) funct%">  
  <TABLE width="100%">
    <TR>
      <TD class="menusection-Settings" colspan="2">
          Settings &gt;
          JDBC Pools &gt;
          Driver Aliases
          %switch funct%
		%case 'Add'%          
		  &gt;
		  New
		%case 'Edit'%  
		&gt Edit
          %endswitch%
      </TD>
    </TR>
    %switch funct%
      %case 'Update'%
        %invoke wm.server.jdbcpool:updateDriverAlias%
          %ifvar message%
            <SCRIPT>updatefailed();</SCRIPT>
            <TR><TD colspan="2">&nbsp;</TD></TR>
            <TR><TD class="message" colspan="2">%value message%</TD></TR>
            <TR><TD colspan="2">&nbsp;</TD></TR>
          %else%  
            <SCRIPT>updated("%value driver%");</SCRIPT>
          %endif%
        %onerror%
          <SCRIPT>updatefailed();</SCRIPT>
          <TR><TD colspan="2">&nbsp;</TD></TR>
          <TR><TD class="message" colspan="2">%value errorMessage%</TD></TR>
          <TR><TD colspan="2">&nbsp;</TD></TR>
        %endinvoke%
      %case 'UpdateAdd'%
        %invoke wm.server.jdbcpool:addDriverAlias%
          %ifvar message%
            <SCRIPT>addfailed();</SCRIPT>
            <TR><TD colspan="2">&nbsp;</TD></TR>
            <TR><TD class="message" colspan="2">%value message%</TD></TR>
            <TR><TD colspan="2">&nbsp;</TD></TR>
          %else%  
            <SCRIPT>added("%value driver%");</SCRIPT>
          %endif%
        %onerror%
          <SCRIPT>addfailed();</SCRIPT>
          <TR><TD colspan="2">&nbsp;</TD></TR>
          <TR><TD class="message" colspan="2">%value errorMessage%</TD></TR>
          <TR><TD colspan="2">&nbsp;</TD></TR>
        %endinvoke%
    %endswitch%

    %ifvar funct equals(Add)%
    %else%
      %invoke wm.server.jdbcpool:getDriverAlias%
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
    %endif%
    <TR>
      <TD colspan="2">
        <UL>
          <LI><A HREF="settings-jdbcpool.dsp">Return to JDBC Pool Definitions</A></LI>
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
             %ifvar funct equals(Add)% 
              	<TD class="heading" colspan="2">Add JDBC Driver Alias</TD>
             %else%
              %ifvar funct equals(Edit)% 
              	<TD class="heading" colspan="2">Edit JDBC Driver Alias</TD>
              %else%
	            <TD class="heading" colspan="2">%value funct% JDBC Driver Alias</TD>              
              %endif%
             %endif%
          	
          </TR>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Alias Name</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
              %ifvar funct equals(Add)%
                <INPUT NAME="driver" TYPE="TEXT" VALUE="" SIZE="60">
              %else%
                %value driver.name%
              %endif%
            </TD>    
          </TR>
          <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Alias Description</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
              %ifvar funct equals(Display)%
                %value driver.description%              
               %else%
                <INPUT NAME="description" TYPE="TEXT" VALUE="%value driver.description%" SIZE="60">
              %endif%
            </TD>
          </TR>
          <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Driver Class Name</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
              %ifvar funct equals(Display)%
                %value driver.class%              
              %else%
                <INPUT NAME="classname" TYPE="TEXT" VALUE="%value driver.class%" SIZE="60">
              %endif%
            </TD>
          </TR>
          <SCRIPT>swapRows();</SCRIPT>
          %ifvar funct equals(Display)%
          %else%
            <TR>
              <TD colspan="2" class="action">
                <INPUT type="submit" value="Save Settings" onClick="return update();">
              </TD>
            </TR>
          %endif%
        </TABLE>
      </TD>
    </TR>
  </TABLE>      
</FORM>
</BODY>
</HTML>
