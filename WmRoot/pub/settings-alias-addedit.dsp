
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
  <BODY onLoad="setNavigation('settings-alias.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_URL_Alias_Edit');">
  %else%
  <BODY onLoad="setNavigation('settings-alias.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_URL_Alias_Create');">
  %endif%
    <TABLE width="100%">
      <TR>
        <TD class="menusection-Settings" colspan="2">
            Settings &gt;
            URL Aliases &gt;
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
            <LI><A HREF="settings-alias.dsp">Return to URL Aliases</A></LI>
          </UL>
        </TD>
      </TR>
      <TR>
        <TD><IMG SRC="images/blank.gif" height="10" width="10"></TD>
        <TD>
      <TABLE class="tableForm">
        <TR>
            <TD colspan="2" class="heading">URL Alias Properties</TD>
        </TR>
          <FORM NAME="addform" ACTION="settings-alias.dsp" METHOD="POST">
          <SCRIPT LANGUAGE="JavaScript">
          
          var hiddenOptions = new Array();
      
          function confirmEdit ()
          {
            if ((document.addform.alias.value == "") ||
                (document.addform.urlPath.value == "")  )
            {
              alert ("You must specify the arguments (Alias, URL Path) for the remote server.");
              return false;
            }
             	
   			 if (!checkLegalName(document.addform.alias, "Alias"))
			 	return false;
   			 if (!checkLegalName(document.addform.urlPath, "URL Path"))
			 	return false;

			 if (!checkDuplicate())
			 	return false;

             document.addform.submit();
             return true;
           }
          
          function confirmAdd ()
          {
            if ((document.addform.alias.value == "") ||
                (document.addform.urlPath.value == "")  )
            {
              alert ("You must specify the arguments (Alias, URL Path) for the URL Alias.");
              return false;
            }
            
            if (!checkLegalName (document.addform.alias, "Alias"))
              return false;
              
            if (!checkLegalName (document.addform.urlPath, "URL Path"))
              return false;
              
            if (!checkDuplicate())
              return false;

            document.addform.submit();
           	return true;
          }
          
        function checkDuplicate()
        {
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
      	  function checkLegalName(field, fieldName)
      	  {
            var name = field.value;
            var illegalChars = " #?%'\"<\\";
            
            for (var i=0; i<illegalChars.length; i++)
            {
              if (name.indexOf(illegalChars.charAt(i)) >= 0)
              {
                alert (fieldName + " contains illegal character: '" + illegalChars.charAt(i) + "'");
                return false;
              }
            }
            if (name.indexOf("/") == 0)
            {
              alert (fieldName + " contains illegal leading character: '/'");
              return false;
            }
            if (name.toLowerCase().indexOf("http://") == 0)
            {
              alert (fieldName + " must not start with: 'http://'");
              return false;
            }
            if (name.toLowerCase().indexOf("https://") == 0)
            {
              alert (fieldName + " must not start with: 'https://'");
              return false;
            }
            
            return true;
          }
          
          </SCRIPT>
          <TR>
            <TD class="oddrow">Alias</TD>
            <TD class="oddrow-l">
              <INPUT NAME="alias" size=100 VALUE="%value alias%"> </TD>
          </TR>
          <TR>
            <TD class="evenrow">URL Path</TD>
            %ifvar isDev equals('true')%
              <TD class="evenrowdata-l">%value urlPath%</TD>
              <INPUT TYPE="hidden" NAME="urlPath" VALUE="%value urlPath%">
            %else%
            <TD class="evenrow-l">
              <INPUT NAME="urlPath" size=100 VALUE="%value urlPath%"> </TD>
            %endif%
          </TR>
          <TR>
            <TD class="oddrow">Package</TD>
            <TD class="%ifvar isDev equals('true')%oddrowdata-l%else%oddrow-l%endif%">
              %ifvar isDev equals('false')%
                %invoke wm.server.packages:packageList%
			    <select name="package">
				%loop packages%
			      %ifvar enabled equals('true')%
                    %ifvar ../package -notempty%
                      <option %ifvar ../package vequals(name)%selected %endif%value="%value name%">%value name%</option>
                    %else%
			          <option %ifvar name equals('WmRoot')%selected %endif%value="%value name%">%value name%</option>
                    %endif%
                  %endif%
				%endloop%
				</select>
			    %endinvoke%
			  %else%
                %value package%
			  %endif%
			</TD>
          </TR>
          <TR>
            <TD class="evenrow">Association</TD>
            <TD class="evenrowdata-l">
            %switch association%
		      %case '0'%
		        Package
		      %case '1'%
		        Package
		      %case%
		        %value association%
		      %endif%
            </TD>
          </TR>
          <TR>
          	<TD>
              <INPUT TYPE="hidden" NAME="association" VALUE="%value association%" />
            </TD>
          </TR>
          %invoke wm.server.httpUrlAlias:listAlias%
          <TR>
          %loop aliasList%
            <TD>
              <INPUT TYPE="hidden" NAME="aliases" VALUE="%value alias%" />
            </TD>
          %endloop%
          </TR>
          <TR>
            <TD colspan=2 class="action">
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
