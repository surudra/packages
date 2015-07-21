<HTML>
<HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


  <TITLE>Integration Server Extended Settings</TITLE>
  <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
  <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
  <SCRIPT>
  
  	function validateSettingsInput(){
  	  		
  		var value=document.forms["extendedForm"]["settings"].value;
  		  		 		
  		if(value==null ||  value=='' ){
  			return true;
  		}
  		
  		var valueArr = value.split("\n");
  		var invalidvalues=null;
  		
  		for(var i = 0;i<valueArr.length;i++){
  			valueArr[i]=valueArr[i].replace(/^\s+/,""); // left trim
  			var tmp=valueArr[i];
  			tmp=tmp.replace(/^\s/,""); //to avoid all spaces
  			
  			if(tmp==''){
  				continue;
  			}
  			  			
  			if(valueArr[i].substr(0,5)!='watt.'){
  				
  				var idx=valueArr[i].indexOf("=");
  				var valueStr=valueArr[i];
  				if(idx>0){
  					valueStr=valueStr.substr(0,idx);
  				}
  				if(invalidvalues==null){
  					invalidvalues=valueStr;
  				}else{
  					invalidvalues=invalidvalues+","+valueStr;
  				}
  			}
		}
		
  		if(invalidvalues!=null){
  			alert('Invalid property names : {'+invalidvalues+'}'+'\n'+'The names of extended properties must begin with "watt.".');  		 		
  			return false;
  		}
  		return true;
  	}
  	
  </SCRIPT>
</HEAD>

%ifvar mode equals('edit')%

   <BODY onLoad="setNavigation('settings-extended.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_ExtendedScrn');">
%else%

   <BODY onLoad="setNavigation('settings-extended.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_ExtendedScrn');">

%endif%
  <TABLE WIDTH="100%">
    <TR>
      <TD class="menusection-Settings" colspan="4">
        Settings &gt;
        Extended </TD>
    </TR>
    <TR>

%ifvar action equals('change')%
  %invoke wm.server.admin:setExtendedSettings%
    %ifvar message%
      <tr><td colspan="4">&nbsp;</td></tr>
      <TR><TD class="message" colspan="4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message%</TD></TR>
    %endif%
  %endinvoke%
%endif%

%ifvar action equals('showhide')%
  %invoke wm.server.admin:setExtendedSettingsVisible%
    %ifvar message%
      <tr><td colspan="4">&nbsp;</td></tr>
      <TR><TD class="message" colspan="4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message%</TD></TR>
    %endif%
  %endinvoke%
%endif%


    <TR>
      <TD colspan=2>
        <UL>
          %ifvar mode equals('edit')%
          <LI><A HREF="settings-extended.dsp">Return to Extended Settings</A></LI>
          %else%
          <LI><A HREF="settings-extended.dsp?mode=edit">Edit Extended Settings</A></LI>
          <LI><A HREF="settings-extended-showhide.dsp">Show and Hide Keys</A></LI>
          %endif%
        </UL>
    </TR>
    <TR>
      <TD><IMG SRC="images/blank.gif" height=10 width=10 border=0></TD>
      <TD>
          <FORM name="extendedForm" action="settings-extended.dsp" method="POST">
          <INPUT type="hidden" name="action" value="change">

        <TABLE class="tableForm" %ifvar mode equals('edit')%width="100%"%endif% >
%invoke wm.server.query:getExtendedSettings%

          <TR>
            <TD class="heading">Extended Settings</TD>
          </TR>

          <TR>
            <TD class="oddcol-l">Key=Value</TD>
          </TR>

          <TR>
            <TD class="evenrow-l">
              %ifvar mode equals('edit')%
              <TEXTAREA style="width:100%" wrap="off" rows=15 cols=40 name="settings">%value settings%</TEXTAREA>
              %else%
              <TABLE width=100%>
                <TR>
                  <TD><PRE class="fixedwidth">%value settings%








</PRE>
                  </TD>
                </TR>
              </TABLE>
              %endif%
            </TD>
          </TR>
          %ifvar mode equals('edit')%
          <TR>
            <TD class="action">
              <INPUT type="submit" name="submit" value="Save Changes" onClick="return validateSettingsInput();">
            </TD>
          </TR>
          %endif%
          </FORM>
          <TR>
%ifvar mode equals('edit')%
            <TD class="oddrow-l">Extended settings are typically provided by webMethods Support</TD>
%else%
            <TD class="oddrow-l">Extended settings are typically provided by webMethods Support</TD>
%end if%
          </TR>

%endinvoke%
        </TABLE>
      </TD>
    </TR>
  </TABLE>
</BODY>



