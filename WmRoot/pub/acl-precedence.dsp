<html>
  <head>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


    <title>ServerUI</title>
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
  </head>
<SCRIPT SRC="webMethods.js.txt"></SCRIPT>

  <BODY>

    <script>
    function writeCheckBox(value)
    {
      document.write("<input type=\"checkbox\" name=\"" + value + "\" value=\"REMOVE\">" + value + "<br>");
    }
    </script>


    <table width=100%>
      <tr>
        <td class="menusection-security" colspan=2>
            Security &gt;
            Access Control Lists &gt;
            Precedence
        </td>
      </tr>
      <tr>
        <td colspan=2>
          <ul>
            <li><a href="acls.dsp">Return to ACLs</a></li>
          </ul>
        </td>
      </tr>
    <form id="form" name="form" method="POST" action="acls.dsp">
    <input type="hidden" name="action" value="changePrecedence">
      <tr>
        <TD><IMG SRC="images/blank.gif" height=10 width=10 border=0></TD>
        <TD>
          <TABLE>
            <TR>
              <td class="heading" colspan=2>Precedence Setting</td>
            </tr>
            <tr>
              <td nowrap class="oddrow">Precedence</td>
              <td class="oddrow-l">
              %invoke wm.server.access:getDefaultAccess%
                <input type="radio" value="allow" name="precedence" %ifvar defaultAccess equals('allow')% checked %endif%>Allow: Users in a group that are in either both "Allowed" and "Denied" or neither "Allowed" nor "Denied" will have access.</input><BR><BR>
Allow: Users in either both or neither Allowed and Denied will be Allowed.  (Default)
                <input type="radio" value="deny"  name="precedence" %ifvar defaultAccess equals('deny')% checked %endif%>Deny: Users in groups that are in either both "Allowed" and "Denied" or neither "Allowed" nor "Denied" will not have access.</input>
              %endinvoke%
              </td>
            </tr>
            <tr>
              <td class="evenrow-l" colspan="2"> Warning: This setting is server-wide and
                drasticaly changes how ACLs work. If this setting is
                changed, all ACL's may need to be updated. </td>
            </tr>
            <tr>
              <td colspan="2" class="action"><input type="submit" value="Change Precedence" name="changePrecedence"></td>
            </tr>
          </table>
          </td>
        </tr>
    </table>

    </form>
</body>
</html>
