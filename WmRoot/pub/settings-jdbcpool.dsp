<HTML>
<HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">

<TITLE>Integration Server Settings</TITLE>
<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
<SCRIPT SRC="webMethods.js.txt"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
  function confirmDeletePool (alias) {
    var msg = "OK to delete Pool Alias '"+alias+"' ?";
    if (confirm (msg)) {
      return true;
    } else return false;
  }
  function confirmDeleteDriver (alias) {
    var msg = "OK to delete Driver Alias '"+alias+"' ?";
    if (confirm (msg)) {
      return true;
    } else return false;
  }
  function confirmReload (alias) {
    var msg = "OK to restart Functional Alias '"+alias+"' ?";
    if (confirm (msg)) {
      return true;
    } else return false;
  }
</SCRIPT>
</HEAD>
<BODY onLoad="setNavigation('settings-jdcbpool.dsp','/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_JDBC_PoolsScrn');">
<FORM NAME="form1">
  <INPUT NAME="internal" TYPE="hidden" VALUE="%value encode(htmlattr) internal%">  
  <INPUT NAME="isolationlevel" TYPE="hidden" VALUE="%value encode(htmlattr) function.isolationlevel%">
  <INPUT NAME="function.cache" TYPE="hidden" VALUE="%value encode(htmlattr) function.cache%">
  <INPUT NAME="function.autocommit" TYPE="hidden" VALUE="%value encode(htmlattr) function.autocommit%">
  <INPUT NAME="function.pool" TYPE="hidden" VALUE="%value encode(htmlattr) function.pool%">
  <INPUT NAME="function.description" TYPE="hidden" VALUE="%value encode(htmlattr) function.description%">
  <TABLE width="100%">
    <TR>
      <TD class="menusection-Settings" colspan="7">
          Settings &gt;
          JDBC Pools
      </TD>
    </TR>
    %switch funct%
      %case 'DeleteDriver'%
        %invoke wm.server.jdbcpool:deleteDriverAlias%
          %ifvar message%
            <TR><TD colspan="7">&nbsp;</TD></TR>
            <TR><TD class="message" colspan=7>%value message%</TD></TR>
            <TR><TD colspan="7">&nbsp;</TD></TR>
          %endif%  
        %onerror%
          <TR><TD colspan="7">&nbsp;</TD></TR>
          <TR><TD class="message" colspan=7>%value errorMessage%</TD></TR>
          <TR><TD colspan="7">&nbsp;</TD></TR>
        %endinvoke%
      %case 'DeletePool'%
        %invoke wm.server.jdbcpool:deletePoolAlias%
          %ifvar message%
            <TR><TD colspan="7">&nbsp;</TD></TR>
            <TR><TD class="message" colspan=7>%value message%</TD></TR>
            <TR><TD colspan="7">&nbsp;</TD></TR>
          %endif%  
        %onerror%
          <TR><TD colspan="7">&nbsp;</TD></TR>
          <TR><TD class="message" colspan=7>%value errorMessage%</TD></TR>
          <TR><TD colspan="7">&nbsp;</TD></TR>
        %endinvoke%
      %case 'Test'%
        %invoke wm.server.jdbcpool:testPool%
          %ifvar message%
            <TR><TD colspan="7">&nbsp;</TD></TR>
            <TR><TD class="message" colspan=7>%value message%</TD></TR>
            <TR><TD colspan="7">&nbsp;</TD></TR>
          %endif%  
        %onerror%
          <TR><TD colspan="7">&nbsp;</TD></TR>
          <TR><TD class="message" colspan=7>%value errorMessage%</TD></TR>
          <TR><TD colspan="7">&nbsp;</TD></TR>
        %endinvoke%
      %case 'PoolTest'%
        %invoke wm.server.jdbcpool:testPoolAlias%
          %ifvar message%
            <TR><TD colspan="7">&nbsp;</TD></TR>
            <TR><TD class="message" colspan=7>%value message%</TD></TR>
            <TR><TD colspan="7">&nbsp;</TD></TR>
          %endif%  
        %onerror%
          <TR><TD colspan="7">&nbsp;</TD></TR>
          <TR><TD class="message" colspan=7>%value errorMessage%</TD></TR>
          <TR><TD colspan="7">&nbsp;</TD></TR>
        %endinvoke%
      %case 'Apply'%
        %invoke wm.server.jdbcpool:restart%
          %ifvar message%
            <TR><TD colspan="7">&nbsp;</TD></TR>
            <TR><TD class="message" colspan=7>%value message%</TD></TR>
            <TR><TD colspan="7">&nbsp;</TD></TR>
          %endif%  
        %onerror%
          <TR><TD colspan="7">&nbsp;</TD></TR>
          <TR><TD class="message" colspan=7>%value errorMessage%</TD></TR>
          <TR><TD colspan="7">&nbsp;</TD></TR>
        %endinvoke%
      %case%
	    %ifvar message%
		  %ifvar addEditACT%
			%ifvar addEditACT equals('addPool')%
				<TR><TD colspan="7">&nbsp;</TD></TR>
				<TR><TD class="message" colspan=7>Pool Alias %value message% added.</TD></TR>
				<TR><TD colspan="7">&nbsp;</TD></TR>
			%endif%
			%ifvar addEditACT equals('clonePool')%
				<TR><TD colspan="7">&nbsp;</TD></TR>
				<TR><TD class="message" colspan=7>Pool Alias %value message% copied.</TD></TR>
				<TR><TD colspan="7">&nbsp;</TD></TR>
			%endif%
			%ifvar addEditACT equals('updatePool')%
				<TR><TD colspan="7">&nbsp;</TD></TR>
				<TR><TD class="message" colspan=7>Pool Alias %value message% updated. You must restart the Server before the updated settings take effect.</TD></TR>
				<TR><TD colspan="7">&nbsp;</TD></TR>
			%endif%
			%ifvar addEditACT equals('addDriver')%
				<TR><TD colspan="7">&nbsp;</TD></TR>
				<TR><TD class="message" colspan=7>Driver Alias %value message% added.</TD></TR>
				<TR><TD colspan="7">&nbsp;</TD></TR>
			%endif%
			%ifvar addEditACT equals('updateDriver')%
				<TR><TD colspan="7">&nbsp;</TD></TR>
				<TR><TD class="message" colspan=7>Driver Alias %value message% updated. You must restart all affected functions before updated settings will take effect.</TD></TR>
				<TR><TD colspan="7">&nbsp;</TD></TR>
			%endif%
			%rename addEditACT oldAddEditACT%
		  %else%
			 <TR><TD colspan="7">&nbsp;</TD></TR>
			 <TR><TD class="message" colspan=7>%value message%</TD></TR>
			 <TR><TD colspan="7">&nbsp;</TD></TR>
		  %endif%
         
        %endif%  
      %endswitch%

    %invoke wm.server.jdbcpool:getFunctionalDefinitions%
      %ifvar message%
        <TR><TD colspan="7">&nbsp;</TD></TR>
        <TR><TD class="message" colspan=7>%value message%</TD></TR>
        <TR><TD colspan="7">&nbsp;</TD></TR>
      %endif%

    <TR>
      <TD colspan="7">
        <UL>
          <LI><A HREF="settings-editjdbcpool.dsp?funct=Add">Create a new Pool Alias definition</A></LI>
          <LI><A HREF="settings-clonejdbcpool.dsp?funct=Clone">Copy a new Pool Alias definition</A></LI>
          <LI><A HREF="settings-editjdbcdriver.dsp?funct=Add">Create a new Driver Alias definition</A></LI>
          %ifvar internal equals(true)%
          <LI><A HREF="settings-editjdbcfunction.dsp?funct=Add&=%value internal%">Create a new Funtional Alias (webMethods internal use only)</A></LI>
          %endif% 
        </UL>
      </TD>
    </TR>
    <TR> 
    <TD colspan="7">
       <TABLE width="100%">
       <TR> 
      <TD>
        <IMG SRC="images/blank.gif" height=10 width=10 border=0>
      </TD>
      <TD class="heading" colspan="10">Functional Alias Definitions</TD>
    </TR>
    <TR> 
      <TD>
        <IMG SRC="images/blank.gif" height=10 width=10 border=0>
      </TD>
      <TD class="oddcol-l" nowrap>Function Name</TD>
      <TD class="oddcol-l" nowrap>Associated Pool Alias</TD>
      %ifvar internal equals(true)%
        <TD class="oddcol" nowrap>Edit Functional Definition</TD>
      %else%
        <TD class="oddcol" nowrap>Edit Association</TD>
      %endif%
      <TD class="oddcol" nowrap>Test</TD>
      <TD class="oddcol" nowrap>Restart Function</TD>
      <TD class="oddcol-l" nowrap>Function Description</TD>
      <TD class="oddcol" nowrap>Min Connections</TD>
      <TD class="oddcol" nowrap>Max Connections</TD>
      <TD class="oddcol" nowrap>Total Connections</TD>
      <TD class="oddcol" nowrap>Available Connections</TD>
    </TR>

    %loop functions%
    <TR>
       <TD>
        <IMG SRC="images/blank.gif" height=10 width=10 border=0>
      </TD>
      <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value function.name%</TD>
      <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%ifvar function.pool%
         <A href="settings-editjdbcpool.dsp?funct=Display&pool=%value -urlencode function.pool%">
           %value function.pool%
         </A>%else%&nbsp;%endif%
      </TD>
      <SCRIPT>writeTDnowrap("rowdata");</SCRIPT>
        <A href="settings-editjdbcfunction.dsp?funct=Edit&function=%value function.name%&internal=%value ../internal% ">
          Edit
        </A>            
      </TD>
      <SCRIPT>writeTD("rowdata");</SCRIPT>
        <A href="settings-jdbcpool.dsp?funct=Test&function=%value function.name%">
          <IMG src="icons/checkdot.gif" border="none">
        </A>
      </TD>
      <SCRIPT>writeTDnowrap("rowdata");</SCRIPT>
        <A href="settings-jdbcpool.dsp?funct=Apply&function=%value function.name%" onClick="return confirmReload('%value function.name%');">
          Restart
        </A>
      </TD>
      <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value function.description%</TD>      
      <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value function.min%</TD>
      <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value function.max%</TD>      
      <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value function.curr%</TD>
      <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value function.avail%</TD>
      <SCRIPT>swapRows();</SCRIPT>
    </TR>
    %endloop%

    %onerror%
    <TR>
      <TD class="message" colspan="7">%value errorMessage%</TD>
    </TR>
    %endinvoke%
	 </TD>
     </TR>
    </TABLE>
    <TR><TD colspan="7">&nbsp;</TD></TR>
    <TR> 
      <TD>
        <IMG SRC="images/blank.gif" height=10 width=10 border=0>
      </TD>
       <TD class="heading" colspan="6">Pool Alias Definitions</TD>
    </TR>
    <TR>
       <TD>
         <IMG SRC="images/blank.gif" height=10 width=10 border=0>
       </TD>
       <TD class="oddcol-l" nowrap>Pool Alias</TD>
       <TD class="oddcol-l" nowrap>Associated Driver Alias</TD>
       <TD class="oddcol" nowrap>Edit Pool Alias</TD>
       <TD class="oddcol" nowrap>Test</TD>
	   <TD colspan="1" class="oddcol" nowrap>Delete Pool Alias</TD>
       <TD class="oddcol-l" nowrap>Pool Alias Description</TD>
    </TR>
    <SCRIPT>resetRows();</SCRIPT>

    %invoke wm.server.jdbcpool:getPoolDefinitions%
    %ifvar message%
    <TR><TD colspan="7">&nbsp;</TD></TR>
    <TR><TD class="message" colspan=7>%value message%</TD></TR>
    <TR><TD colspan="7">&nbsp;</TD></TR>
    %endif%

    %loop pools%
    <TR>
       <TD>
         <IMG SRC="images/blank.gif" height=10 width=10 border=0>
       </TD>
       <SCRIPT>writeTDnowrap("rowdata-l");</SCRIPT>
         <A href="settings-editjdbcpool.dsp?funct=Display&pool=%value -urlencode pool.name%">
           %value pool.name%
         </A>
       </TD>
       <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value pool.driver%</TD>     
       <SCRIPT>writeTDnowrap("rowdata");</SCRIPT>
         <A href="settings-editjdbcpool.dsp?funct=Edit&pool=%value -urlencode pool.name%">
           Edit
         </A>            
       </TD>
      <SCRIPT>writeTD("rowdata");</SCRIPT>
        <A href="settings-jdbcpool.dsp?funct=PoolTest&pool=%value pool.name%">
          <IMG src="icons/checkdot.gif" border="none">
        </A>
      </TD>
       <SCRIPT>writeTDspan("rowdata","1");</SCRIPT>
         <A href="settings-jdbcpool.dsp?funct=DeletePool&pool=%value -urlencode pool.name%" onClick="return confirmDeletePool('%value pool.name%');">
           <IMG src="icons/delete.gif" border="none">
         </A>
       </TD>
       <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value pool.description%</TD>
    </TR>
    <SCRIPT>swapRows();</SCRIPT>
    %endloop%

    %onerror%
    <TR>
      <TD class="message" colspan="7">%value errorMessage%</TD>
    </TR>
    %endinvoke%

    <TR><TD colspan="7">&nbsp;</TD></TR>
    <TR> 
      <TD>
        <IMG SRC="images/blank.gif" height=10 width=10 border=0>
      </TD>
      <TD class="heading" colspan="6">Driver Alias Definitions</TD>
    </TR>
    <TR>
      <TD>
        <IMG SRC="images/blank.gif" height=10 width=10 border=0>
      </TD>
      <TD class="oddcol-l" nowrap>Driver Alias</TD>
      <TD class="oddcol-l" nowrap>Class Name</TD>
      <TD class="oddcol" nowrap>Edit Driver Alias</TD>
      <TD colspan="1" class="oddcol" nowrap>Delete Driver Alias</TD>
      <TD colspan="2" class="oddcol-l" nowrap>Description</TD>
    </TR>
    <SCRIPT>resetRows();</SCRIPT>

    %invoke wm.server.jdbcpool:getDriverDefinitions%
    %ifvar message%
    <TR><TD colspan="7">&nbsp;</TD></TR>
    <TR><TD class="message" colspan=7>%value message%</TD></TR>
    <TR><TD colspan="7">&nbsp;</TD></TR>
    %endif%

    %loop drivers%
    <TR>
      <TD>
        <IMG SRC="images/blank.gif" height=10 width=10 border=0>
      </TD>
      <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value driver.name%</TD>
      <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value driver.class%</TD>
      <SCRIPT>writeTDnowrap("rowdata");</SCRIPT>
        <A href="settings-editjdbcdriver.dsp?funct=Edit&driver=%value -urlencode driver.name%">
          Edit
        </A>            
      </TD>
      <SCRIPT>writeTDspan("rowdata","1");</SCRIPT>
        <A href="settings-jdbcpool.dsp?funct=DeleteDriver&driver=%value -urlencode driver.name%" onClick="return confirmDeleteDriver('%value driver.name%');">
          <IMG src="icons/delete.gif" border="none">
        </A>
      </TD>
      <SCRIPT>writeTDspan("row-l", "2");</SCRIPT>%value driver.description%</TD>
     </TR>
     <SCRIPT>swapRows();</SCRIPT>
    %endloop%

    %onerror%
    <TR>
      <TD class="message" colspan="7">%value errorMessage%</TD>
    </TR>
    %endinvoke%
     <SCRIPT>resetRows();</SCRIPT>
    </TR>
  </TABLE>      
</FORM>
</BODY>
</HTML>
