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
      if (!verifyRequiredField("form1","pool"))
      {
         alert("Pool Alias must be specified");
         return false;
      }
	  if (document.forms["form1"]["drivers"].value != "Embedded Database Driver") 
	  {
	      if (!verifyPercentageField("form1", "poolThreshold", "Available Connections Warning Threshold")) 
	      {
	         return false;
	      }
		  if (!verifyRequiredField("form1","url"))
		  {
			 alert("Database URL must be specified");
			 return false;
		  }
		  if (!verifyRequiredNonNegNumber("form1","mincon"))
		  {
			 alert("Minimum connections must be a non-negative integer");
			 return false;
		  }
		  if (!verifyRequiredNonNegNumber("form1","maxcon"))
		  {
			 alert("Maximum connections must be greater than 0");
			 return false;
		  }
		  if (!verifyRequiredNonNegNumber("form1","waitingThread"))
		  {
			 alert("Waiting Thread Threshold Count must be a non-negative integer");
			 return false;
		  }
		  if (document.forms["form1"]["maxcon"].value < 1)
		  {
			document.forms["form1"]["maxcon"].focus;
			alert("Maximum connections must be greater than 0");
			return false;
		  }
		  var ma = parseInt(document.forms["form1"]["maxcon"].value);
		  var mi = parseInt(document.forms["form1"]["mincon"].value);
		  if (mi > ma) {
			document.forms["form1"]["maxcon"].focus
			alert("Minimum connections must be <= maximum connections")
			return false;
		  }
		  if (!verifyRequiredNonNegNumber("form1","idle"))
		  {
			 alert("Idle timeout must be a non-negative integer");
			 return false;
		  }
		  errMsg = getAvailableConnThresholdError();
		  if (errMsg != "") {
		  	alert(errMsg);
			return false;
		  }
	  }

	  // Set the values of the spy and snoop checkboxes to their checked state.
      var spyChecked   = document.forms["form1"]["spyEnabled"].checked;
      var snoopChecked = document.forms["form1"]["snoopEnabled"].checked;
	  document.forms["form1"]["spyEnabled"].value = spyChecked;
	  document.forms["form1"]["snoopEnabled"].value = snoopChecked;
	  
      if (document.forms["form1"]["funct"].value == "Add")
        document.forms["form1"]["funct"].value = "UpdateAdd";
      if (document.forms["form1"]["funct"].value == "Edit")
        document.forms["form1"]["funct"].value = "Update";
	  document.forms["form1"]["url"].value = (document.forms["form1"]["url"].value).trim();
      return true;
    }

	function getAvailableConnThresholdError() {
		error = "";

		var minConns  = parseInt(document.forms["form1"]["mincon"].value);
		var maxConns  = parseInt(document.forms["form1"]["maxcon"].value);
		var threshPct = document.forms["form1"]["poolThreshold"].value / 100;

		if (threshPct > 0 && parseInt(maxConns * threshPct) >= minConns) {
			error = "Available Connections Warning Threshold evaluates to "+ parseInt(maxConns * threshPct)+", which is greater than or equal to Minimum Connections. Available Connections Warning Threshold must be less than Minimum Connections.";
		}
		
		return error;
	}
 	
    function verifyPercentageField(form, field, name)
    {
        var value = document.forms[form][field].value;
      
        if (isblank(value)) {
            alert(name + " is required.");
            return false;
        }
        else if (!isNum(value) || parseInt(value) < 0 || parseInt(value) > 100) {
            alert("Value must be an integer between 0 and 100: "+name);
            return false;
        }
        else {
            return true;
        }
    }
        
 	function testConnection()
 	{
		if (!verifyRequiredField("form1","drivers"))
		{
			alert("Associated Driver Alias must be selected");
			return false;
		}
		if (!verifyRequiredField("form1","url"))
		{
			alert("Database URL must be specified");
			return false;
		}
		document.forms["form1"]["url"].value = (document.forms["form1"]["url"].value).trim();
 		document.forms["form1"]["test"].value = "true";
 		return true;
 	}
 	
    function added(pool)
    {
        var newURL = encodeURI("settings-jdbcpool.dsp?addEditACT=addPool&message="+pool);
		if(is_csrf_guard_enabled && needToInsertToken) {
			newURL = encodeURI("settings-jdbcpool.dsp?addEditACT=addPool&message="+pool+"&"+ _csrfTokenNm_ + "=" + _csrfTokenVal_);
		} 
        location.href=newURL;
    }
    function updated(pool)
    {
        var newURL = encodeURI("settings-jdbcpool.dsp?addEditACT=updatePool&message="+pool);
		if(is_csrf_guard_enabled && needToInsertToken) {
			newURL = encodeURI("settings-jdbcpool.dsp?addEditACT=updatePool&message="+pool+"&"+ _csrfTokenNm_ + "=" + _csrfTokenVal_);
		} 
        location.href=newURL;
    }
    function updatefailed()
    {
        document.forms["form1"]["funct"].value = "Edit";
    }
    function addfailed()
    {
        document.forms["form1"]["funct"].value = "Add";
    }

	function testCompleted()
	{
		document.forms["form1"]["test"].value = "completed";
	}
	
	function setSampleUrl()
	{
		if (document.forms["form1"]["drivers"].value == "DataDirect Connect JDBC DB2 Driver") {
			document.forms["form1"]["sampleUrl"].value = "jdbc:wm:db2://<server>:<50000|port>;databaseName=<value>[;<option>=<value>...]";
		}
		if (document.forms["form1"]["drivers"].value == "DataDirect Connect JDBC Oracle Driver") {
			document.forms["form1"]["sampleUrl"].value = "jdbc:wm:oracle://<server>:<1521|port>;serviceName=<value>[;<option>=<value>...]";
		}
		if (document.forms["form1"]["drivers"].value == "DataDirect Connect JDBC SQL Server Driver") {
			document.forms["form1"]["sampleUrl"].value = "jdbc:wm:sqlserver://<server>:<1433|port>;databaseName=<value>[;<option>=<value>...]";
		}
	}
	
	function toggleSpyParams() {
        if (document.forms["form1"]["spyEnabled"].checked) {
            document.forms['form1'].spyParms.disabled = false;
        } else {
            document.forms['form1'].spyParms.disabled = true;
        }
	}
        
	function toggleSnoopParams() {
        if (document.forms["form1"]["snoopEnabled"].checked) {
            document.forms['form1'].snoopParms.disabled = false;
        } else {
            document.forms['form1'].snoopParms.disabled = true;
        }
	}
	
	function setDatabaseUrl(parms) 
	{
		document.forms["form1"]["url"].value = parms;
	}
	
	previousDriver = "";
	function disableIfDerby()
    {
		if (document.form1.funct.value != "Display") {

			if (document.forms["form1"]["drivers"].value == "Embedded Database Driver") {
				document.forms["form1"]["url"].value = "---";
				document.forms["form1"]["url"].disabled = true;
				document.forms["form1"]["uid"].value = "---";
				document.forms["form1"]["uid"].disabled = true;
				document.forms["form1"]["idle"].value = "---";
				document.forms["form1"]["idle"].disabled = true;
				//document.forms["form1"]["pwd"].type = "text";
				document.forms["form1"]["pwd"].value = "";
				document.forms["form1"]["pwd"].disabled = true;
				document.forms["form1"]["sampleUrl"].value = "---";
				document.forms["form1"]["sampleUrl"].disabled = true;
				document.forms["form1"]["spyEnabled"].disabled = true;
				document.forms["form1"]["spyEnabled"].checked = false;
				document.forms["form1"]["snoopEnabled"].disabled = true;
				document.forms["form1"]["snoopEnabled"].checked = false;
				document.forms["form1"]["spyParms"].disabled = true;
				document.forms["form1"]["snoopParms"].disabled = true;
			} else {
				document.forms["form1"]["url"].disabled = false;
				document.forms["form1"]["uid"].disabled = false;
				document.forms["form1"]["pwd"].disabled = false;
				document.forms["form1"]["idle"].disabled = false;
				document.forms["form1"]["sampleUrl"].disabled = false;
				if (previousDriver == "Embedded Database Driver") {
					document.forms["form1"]["url"].value = "";
					document.forms["form1"]["uid"].value = "";
					document.forms["form1"]["idle"].value = "";
					document.forms["form1"]["pwd"].value = "";
					document.forms["form1"]["sampleUrl"].value = "";
					//document.forms["form1"]["pwd"].type  = "password";
					document.forms["form1"]["spyEnabled"].disabled = false;
					document.forms["form1"]["snoopEnabled"].disabled = false;
				}
				if(previousDriver != document.forms["form1"]["drivers"].value) {
					setSampleUrl();
				}
			}
			previousDriver = document.forms["form1"]["drivers"].value;
		}
	}
</SCRIPT>
</HEAD>
 
 
%ifvar funct equals(Add)%
  <BODY onLoad="setNavigation('settings-editjdcbpool.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_CreateJDBC_PoolAliasScrn');">
%else%
    <BODY onLoad="setNavigation('settings-editjdcbpool.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditJDBC_PoolAliasScrn');">
%endif%
 
<FORM NAME="form1" method="post" >
  %ifvar funct equals(Add)%
  %else%
    %ifvar funct equals(UpdateAdd)%
    %else%
         <INPUT NAME="pool" TYPE="hidden" VALUE="%value encode(htmlattr) pool%">
    %endif%    
  %endif%
  <INPUT NAME="funct" TYPE="hidden" VALUE="%value encode(htmlattr) funct%">
  %ifvar test equals(true)%
  	<INPUT NAME="test" TYPE="hidden" VALUE="true">
  %else%
  	%ifvar test equals(completed)%
  		<INPUT NAME="test" TYPE="hidden" VALUE="completed">
  	%else%
  		<INPUT NAME="test" TYPE="hidden" VALUE="false">
  	%endif%
  %endif%

  <TABLE width="100%">
    <TR>
      <TD class="menusection-Settings" colspan="2">
          Settings &gt;
          JDBC Pools &gt;
          Connection Aliases
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
      %invoke wm.server.jdbcpool:updatePoolAlias%
      %ifvar message%
        <SCRIPT>updatefailed();</SCRIPT>
        <TR><TD colspan="2">&nbsp;</TD></TR>
        <TR><TD class="message" colspan="2">%value message%</TD></TR>
        <TR><TD colspan="2">&nbsp;</TD></TR>
      %else%
        <SCRIPT>updated("%value pool%");</SCRIPT>
      %endif%
      %onerror%
        <SCRIPT>updatefailed();</SCRIPT>
        <TR><TD colspan="2">&nbsp;</TD></TR>
        <TR><TD class="message" colspan="2">%value errorMessage%</TD></TR>
        <TR><TD colspan="2">&nbsp;</TD></TR>
      %endinvoke%

    %case 'UpdateAdd'%
      %invoke wm.server.jdbcpool:addPoolAlias%
      %ifvar message%
        <SCRIPT>addfailed();</SCRIPT>
        <TR><TD colspan="2">&nbsp;</TD></TR>
        <TR><TD class="message" colspan="2">%value message%</TD></TR>
        <TR><TD colspan="2">&nbsp;</TD></TR>
      %else%
        <SCRIPT>added("%value pool%")</SCRIPT>
      %endif%
      %onerror%
        <SCRIPT>addfailed();</SCRIPT>
        <TR><TD colspan="2">&nbsp;</TD></TR>
        <TR><TD class="message" colspan="2">%value errorMessage%</TD></TR>
        <TR><TD colspan="2">&nbsp;</TD></TR>
      %endinvoke%
    %endswitch%
    
    %ifvar test equals(true)%
      %invoke wm.server.jdbcpool:testPoolAlias%
      <SCRIPT>testCompleted();</SCRIPT>
      %ifvar message%
        <TR><TD colspan="2">&nbsp;</TD></TR>
        <TR><TD class="message" colspan="2">%value message%</TD></TR>
        <TR><TD colspan="2">&nbsp;</TD></TR>
      %else%
      %endif%
      %onerror%
        <TR><TD colspan="2">&nbsp;</TD></TR>
        <TR><TD class="message" colspan="2">%value errorMessage%</TD></TR>
        <TR><TD colspan="2">&nbsp;</TD></TR>
      %endinvoke%
	%endif%    

    %ifvar funct equals(Add)%
    %else%
    %ifvar test equals(completed)%
    %else%
      %invoke wm.server.jdbcpool:getPoolAlias%
	<SCRIPT>previousDriver = "%value pool.driver%";</SCRIPT>
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
            <TD class="heading" colspan="2">JDBC Connection Pool Alias</TD>
          </TR>
      <TD>
        %ifvar funct equals(Display)%
          <TABLE class="tableView">
        %else%
          <TABLE class="tableForm">
        %endif%
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Alias Name</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
            %ifvar funct equals(Add)%
            	%ifvar test equals(completed)%
            		<INPUT NAME="pool" TYPE="TEXT" VALUE="%value  pool%" SIZE="60">
            	%else%
            		<INPUT NAME="pool" TYPE="TEXT" VALUE="" SIZE="60">
            	%endif%
            %else%
                %ifvar test equals(completed)%
              	  %value pool%
                %else%
              	  %value pool.name%
              %endif%
            %endif%
            </TD>    
          </TR>
          <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Alias Description</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
              %ifvar funct equals(Display)%               
                %value pool.description%
              %else%
              	%ifvar test equals(completed)%
              		<INPUT NAME="description" TYPE="TEXT" VALUE="%value  description%" SIZE="60">
              	%else%
                	<INPUT NAME="description" TYPE="TEXT" VALUE="%value  pool.description%" SIZE="60">
                %endif%
              %endif%
            </TD>
          </TR>
          <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Associated Driver Alias</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
              %ifvar funct equals(Display)%               
                %value pool.driver%
                </TD></TR>
              %else%
                %invoke wm.server.jdbcpool:getDriverDefinitions%
                  %ifvar message%
                    </TD></TR>
                    <TR><TD colspan="2">&nbsp;</TD></TR>
                    <TR><TD class="message" colspan="2">%value message%</TD></TR>
                    <TR><TD colspan="2">&nbsp;</TD></TR>
                  %endif% 
		  <SELECT NAME="drivers" ONCHANGE="disableIfDerby()" %ifvar ../pool.name equals('Embedded Database Pool')% DISABLED %endif%>
			%ifvar test equals(completed)%
				<OPTION VALUE="" %ifvar driver notempty% %else% SELECTED %endif%>None
				%loop drivers%
				<OPTION VALUE="%value driver.name%" %ifvar ../driver vequals(driver.name)% SELECTED %endif%>%value driver.name%
				%endloop%
					  %else%                  
				%loop drivers%
				<OPTION VALUE="%value driver.name%" %ifvar ../pool.driver vequals(driver.name)% SELECTED %endif%>%value driver.name%
				%endloop%
	                  %endif%
                  </SELECT>
                  </TD></TR>
                %onerror%
                    </TD></TR>
                    <TR><TD colspan="2">&nbsp;</TD></TR>
                    <TR><TD class="message" colspan="2">%value errorMessage%</TD></TR>
                    <TR><TD colspan="2">&nbsp;</TD></TR>
                %endinvoke%
              %endif%
            <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Database URL</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
              %ifvar funct equals(Display)%               
                %ifvar pool.driver equals('Embedded Database Driver')% %else% %value pool.url% %end%
              %else%
              	%ifvar test equals(completed)%
              		<TEXTAREA NAME="url"  cols="60" rows="1">%value url%</TEXTAREA>
              	%else%
                	<TEXTAREA NAME="url" cols="60" rows="1">%value pool.url%</TEXTAREA>
                %endif%
              %endif%
            </TD>
          </TR>
          <SCRIPT>swapRows();</SCRIPT>
			%ifvar funct equals(Display)%
			%else%
			<TR>
				<SCRIPT>writeTDnowrap("row");</SCRIPT>
					Sample Database URL</TD>
				<SCRIPT>writeTDnowrap("row-l");</SCRIPT>
					<TEXTAREA NAME="sampleUrl" TYPE="text" readonly="readonly" STYLE="background-color: #CCCCCC;" VALUE="%value sampleUrl%" cols="60" tabindex="60"></TEXTAREA></TD>
			</TR>
			<SCRIPT>swapRows();</SCRIPT>
			<SCRIPT>setSampleUrl();</SCRIPT>
			%endif%
			<TR>
              <SCRIPT>writeTDnowrap("row");</SCRIPT>
            	Diagnostics</TD>
              <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
	              %ifvar funct equals(Display)%
	                  <input type="checkbox" name=spyEnabled   %ifvar pool.spyEnabled   equals('true')% checked %endif% disabled onclick="toggleSpyParams();">Spy &nbsp;&nbsp;&nbsp;&nbsp; 
	                  <input type="checkbox" name=snoopEnabled %ifvar pool.snoopEnabled equals('true')% checked %endif% disabled onclick="toggleSnoopParams();">Snoop</TD>
	              %else%
				       %ifvar pool.name equals('Embedded Database Pool')%
	                      <input type="checkbox" name=spyEnabled disabled>Spy &nbsp;&nbsp;&nbsp;&nbsp; 
	                      <input type="checkbox" name=snoopEnabled disabled>Snoop</TD>
					   %else%
	                      <input type="checkbox" name=spyEnabled   %ifvar pool.spyEnabled   equals('true')% checked %endif% onclick="toggleSpyParams();">Spy &nbsp;&nbsp;&nbsp;&nbsp; 
	                      <input type="checkbox" name=snoopEnabled %ifvar pool.snoopEnabled equals('true')% checked %endif% onclick="toggleSnoopParams();">Snoop</TD>
                      %endif%
                  %endif%
			</TR>

			<SCRIPT>swapRows();</SCRIPT>
			<TR>
              <SCRIPT>writeTDnowrap("row");</SCRIPT>
			    Spy Attributes</TD>
              <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
              %ifvar funct equals(Display)%
			      <TEXTAREA name="spyParms" type="text" disabled STYLE="background-color: #CCCCCC;" cols="60" rows="1">%ifvar pool.spyParms -isnull%%value defaultSpyParms%%else%%value pool.spyParms%%endif%</TEXTAREA></TD>
              %else%
                %ifvar funct equals(Add)%
				      <TEXTAREA name="spyParms" type="text" disabled STYLE="background-color: #CCCCCC;" cols="60" rows="1">%value defaultSpyParms%</TEXTAREA></TD>
				%else%
			        %ifvar pool.spyEnabled equals('true')%
				      <TEXTAREA name="spyParms" type="text" STYLE="background-color: #CCCCCC;" cols="60" rows="1">%ifvar pool.spyParms -isnull%%value defaultSpyParms%%else%%value pool.spyParms%%endif%</TEXTAREA></TD>
				    %else%
				      <TEXTAREA name="spyParms" type="text" disabled STYLE="background-color: #CCCCCC;" cols="60" rows="1">%ifvar pool.spyParms -isnull%%value defaultSpyParms%%else%%value pool.spyParms% %endif%</TEXTAREA></TD>
			        %endif%
			      %endif%
	         %endif%
			</TR>

			<SCRIPT>swapRows();</SCRIPT>
            <TR>
	          <SCRIPT>writeTDnowrap("row");</SCRIPT>
			    Snoop Logging Parameters</TD>
	          <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
	          %ifvar funct equals(Display)%
				  <TEXTAREA name="snoopParms" type="text" disabled STYLE="background-color: #CCCCCC;" cols="60" rows="1">%ifvar pool.snoopParms -isnull%%value defaultSnoopParms%%else%%value pool.snoopParms% %endif%</TEXTAREA></TD>
	          %else%
	            %ifvar funct equals(Add)%
				      <TEXTAREA name="snoopParms" type="text" disabled STYLE="background-color: #CCCCCC;" cols="60" rows="1">%value defaultSnoopParms%</TEXTAREA></TD>
				%else%
				    %ifvar pool.snoopEnabled equals('true')%
				      <TEXTAREA name="snoopParms" type="text" STYLE="background-color: #CCCCCC;" cols="60" rows="1">%ifvar pool.snoopParms -isnull%%value defaultSnoopParms%%else%%value pool.snoopParms%%endif%</TEXTAREA></TD>
				    %else%
				      <TEXTAREA name="snoopParms" type="text" disabled STYLE="background-color: #CCCCCC;" cols="60" rows="1">%ifvar pool.snoopParms -isnull%%value defaultSnoopParms%%else%%value pool.snoopParms%%endif%</TEXTAREA></TD>
				    %endif%
				  %endif%
		     %endif%
 		  %ifvar funct equals(Add)%
		  	<SCRIPT>toggleSpyParams();</SCRIPT>
		  	<SCRIPT>toggleSnoopParams();</SCRIPT>
          %endif%
		  </TR>

          <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              User ID</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
              %ifvar funct equals(Display)%               
                %ifvar pool.driver equals('Embedded Database Driver')% %else% %value pool.uid% %end%
              %else%
              	%ifvar test equals(completed)%
                	<INPUT NAME="uid" TYPE="TEXT" VALUE="%value  uid%" SIZE="12">
                %else%
                	<INPUT NAME="uid" TYPE="TEXT" VALUE="%value  pool.uid%" SIZE="12">
                %endif%
              %endif%
            </TD>
          </TR>
          <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Password</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
              %ifvar funct equals(Display)%               
				  %ifvar pool.driver equals('Embedded Database Driver')% %else% ***** %end%
              %else%
              	%ifvar test equals(completed)%
					<INPUT NAME="pwd" TYPE="PASSWORD" autocomplete="off" VALUE="%value encode(htmlattr) pwd%" SIZE="12" />
				%else%
				  %ifvar funct equals(Add)%
					<INPUT NAME="pwd" TYPE="PASSWORD" autocomplete="off" VALUE="" SIZE="12" />
				  %else%
				    	<INPUT NAME="pwd" TYPE="PASSWORD" autocomplete="off" VALUE="********" SIZE="12" />
				  %endif%
				%endif%
              %endif%
            </TD>
          </TR>
          <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Minimum Connections</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
              %ifvar funct equals(Display)%               
                %value pool.mincon%
              %else%
              	%ifvar test equals(completed)%
                	<INPUT NAME="mincon" TYPE="TEXT" VALUE="%value  mincon%" SIZE="10">
                %else%
                	<INPUT NAME="mincon" TYPE="TEXT" VALUE="%value  pool.mincon%" SIZE="10">
                %endif%
              %endif%
            </TD>
          </TR>
          <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Maximum Connections</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
              %ifvar funct equals(Display)%               
                %value pool.maxcon% 
              %else%
              	%ifvar test equals(completed)%
                	<INPUT NAME="maxcon" TYPE="TEXT" VALUE="%value  maxcon%" SIZE="10">
                %else%
                	<INPUT NAME="maxcon" TYPE="TEXT" VALUE="%value  pool.maxcon%" SIZE="10">
                %endif%
              %endif%
            </TD>
          </TR>
          <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Available Connections Warning Threshold</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
              %ifvar funct equals(Display)%               
                %value pool.poolThreshold% 
              %else%
              	%ifvar test equals(completed)%
                	<INPUT NAME="poolThreshold" TYPE="TEXT" VALUE="%value  poolThreshold%" SIZE="10">
                %else%
                	<INPUT NAME="poolThreshold" TYPE="TEXT" VALUE="%value  pool.poolThreshold%" SIZE="10">
                %endif%
              %endif%
            %
            </TD>
          </TR>
          <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Waiting Thread Threshold Count</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
              %ifvar funct equals(Display)%               
                %value pool.waitingThread% 
              %else%
              	%ifvar test equals(completed)%
                	<INPUT NAME="waitingThread" TYPE="TEXT" VALUE="%value  waitingThread%" SIZE="10">
                %else%
                	<INPUT NAME="waitingThread" TYPE="TEXT" VALUE="%value  pool.waitingThread%" SIZE="10">
                %endif%
              %endif%
            </TD>
          </TR>
          <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Idle Timeout</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
              %ifvar funct equals(Display)%               
                %ifvar pool.driver equals('Embedded Database Driver')% %else% %value pool.idle% milliseconds %end% 
              %else%
              	%ifvar test equals(completed)%
                	<INPUT NAME="idle" TYPE="TEXT" VALUE="%value  idle%" SIZE="10"> milliseconds 
                %else%
                	<INPUT NAME="idle" TYPE="TEXT" VALUE="%value  pool.idle%" SIZE="10"> milliseconds 
                %endif%
              %endif%
            </TD>
          </TR>
		  <SCRIPT>disableIfDerby();</SCRIPT>
          <SCRIPT>swapRows();</SCRIPT>
          %ifvar funct equals(Display)%
          %else%
            <TR>
              <TD colspan="2" class="action">
              	%ifvar pool.driver equals('Embedded Database Driver')%
              	%else%
              		<INPUT type="submit" value="Test Connection" onClick="return testConnection();">
              	%endif%
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
