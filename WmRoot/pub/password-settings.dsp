<html>
  <head>
  <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <META HTTP-EQUIV="Expires" CONTENT="-1">
  <title>ServerUI</title>
  <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
  <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
</head>
<body onLoad="setNavigation('users.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_PasswordSecurityScrn');">
  <table width="100%">
    <TR>
      <TD class="menusection-Security" colspan="2">
        Security &gt;
        User Management &gt;
        Password Security Settings %ifvar doc equals('edit')% &gt; Edit %endif%
      </TD>
    </TR>
    <TR>
      <TD colspan=2>
        <UL>
          <LI><A HREF="users.dsp">Return to User Management</A></LI>

          %ifvar doc equals('edit')%
            <LI><A HREF="password-settings.dsp">View Password Restrictions</A></LI>
          %else%
            <LI><A HREF="password-settings.dsp?doc=edit">Edit Password Restrictions</A></LI>
          %endif%

        </UL>
      </TD>
    </TR>

    <TR>
      <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
      <TD>
        <TABLE class="%ifvar doc equals('edit')%tableForm%else%tableView%endif%">

        %invoke wm.server.query:getPasswordSettings%

        <FORM NAME="password" METHOD="POST" ACTION="users.dsp">
        <INPUT TYPE="hidden" NAME="action" VALUE="editPassword">

          <TR>
            <TD class="heading" colspan=2>Password Restriction Settings</TD>
          </TR>
          <TR>
            <TD class="oddrow">Enable Password Change</TD>
            <TD class="%ifvar ../doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
              %ifvar ../doc equals('edit')%
                %ifvar watt.server.enablePasswordChange equals('true')%
                  <INPUT type="radio" name="watt.server.enablePasswordChange" value="true" CHECKED> Yes</INPUT><BR>
                  <INPUT type="radio" name="watt.server.enablePasswordChange" value="false"> No</INPUT><BR>
                %else%
                  <INPUT type="radio" name="watt.server.enablePasswordChange" value="true"> Yes</INPUT><BR>
                  <INPUT type="radio" name="watt.server.enablePasswordChange" value="false" CHECKED> No</INPUT>
                %endif%
              %else%
                %ifvar watt.server.enablePasswordChange equals('true')%
                  Yes
                %else%
                  No
                %endif%
              %endif%
            </TD>
          </TR>

          <!-- Minimum Password Length -->

          <TR><TD class="evenrow">Minimum Password Length</TD>
            <TD class="%ifvar ../doc equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
              <script>writeEdit("%value ../doc%", "watt.server.password.minLength", "%value watt.server.password.minLength%");</script>
            </TD>
          </TR>

          <!-- Minimum Number of Upper Case Characters -->
          <TR><TD class="oddrow">Minimum Number of Upper Case Characters</TD>
            <TD class="%ifvar ../doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
              <script>writeEdit("%value ../doc%", "watt.server.password.minUpperChars", "%value watt.server.password.minUpperChars%");</script>
            </TD>
          </TR>

          <!-- Minimum Number of Lower Case Characters -->
    <TR><TD class="evenrow">Minimum Number of Lower Case Characters</TD>
      <TD class="%ifvar ../doc equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
        <script>writeEdit("%value ../doc%", "watt.server.password.minLowerChars", "%value watt.server.password.minLowerChars%");</script>
      </TD>
          </TR>

          <!-- Minimum Number of Digits -->
          <TR><TD class="oddrow">Minimum Number of Digits</TD>
            <TD class="%ifvar ../doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
              <script>writeEdit("%value ../doc%", "watt.server.password.minDigits", "%value watt.server.password.minDigits%");</script>
            </TD>
          </TR>

          <!-- Minimum Number of Special Characters -->
          <TR><TD class="evenrow">Minimum Number of Special Characters<br>(neither alphabetic nor digits)</TD>
            <TD class="%ifvar ../doc equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
              <script>writeEdit("%value ../doc%", "watt.server.password.minSpecialChars", "%value watt.server.password.minSpecialChars%");</script>
            </TD>
          </TR>


          %ifvar ../doc equals('edit')%
          <TR>
            <TD class="action" colspan=2>
            <INPUT class="button2" type="submit" onclick="return verifyEntries();" value="Save Password Settings">
            </TD>
          </TR>
          %endif%
        </FORM>

<script>
function verifyEntries()
{
  if ((! verifyRequiredNonNegNumber("password", "watt.server.password.minLength"))        ||
      (! verifyRequiredNonNegNumber("password", "watt.server.password.minUpperChars"))    ||
      (! verifyRequiredNonNegNumber("password", "watt.server.password.minLowerChars"))    ||
      (! verifyRequiredNonNegNumber("password", "watt.server.password.minDigits"))        ||
      (! verifyRequiredNonNegNumber("password", "watt.server.password.minSpecialChars"))    )
  {
    alert ("Field must contain a non-negative number");
    return false;
  }

  return true;
}
</script>



</table>
</td></tr></table>
</body>

</html>


