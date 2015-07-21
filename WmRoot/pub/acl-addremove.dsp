<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<meta http-equiv="Expires" content="-1">
<title>ServerUI</title>
<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
<base target="_self">
<style>
  .listbox  { width: 100%; }
</style>
</head>
<SCRIPT SRC="webMethods.js.txt"></SCRIPT>

<BODY class="main" onLoad="setNavigation('acls.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_AddRemoveACLsScrn');">


<table width="100%">
 <tr>
  <td class="menusection-Security" colspan="2">
  Security &gt;
  Access Control Lists &gt;
  Add and Remove ACLs
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
  <input type="hidden" name="action" value="add">

    <tr>
      <td></td>
      <td>
<table width="40%"><tr><td>
        <table class="tableForm" width="100%">
          <tr>
            <td class="heading" colspan=2>Create ACL</td>
          </tr>
            <tr>
              <td nowrap valign="top" class="oddrow">ACL Names</td>
              <td class="oddrow-l">One ACL name per line.<br>
                <textarea style="width:100%;" wrap="off" rows="5" name="acls" cols="20"></textarea></td>
            </tr>


              <td class="action" colspan=2>
                <input type="submit" value="Create ACLs" name="addACL"  >
              </td>
            </tr>
        </table>
          </form>

  <table class="tableForm" width="100%">
    <form id="form" name="form" method="POST" action="acls.dsp"  >
    <input type="hidden" name="action" value="remove">
          <tr>
            <td class="heading" colspan=2>Remove ACLs</td>
          </tr>
          <tr>
            <td nowrap valign="top" class="oddrow">Select ACLs</td>
            <td class="oddrow-l">

            <table class="tableInline">

                  %invoke wm.server.access.adminui:aclList%
                    %loop aclgroups%
        <tr>
        <td align=center>
                  %switch name%
                        %case 'Administrators'%-</td><td class="oddrow-l">Administrators (not removable)
                        %case 'Default'%-</td><td class="oddrow-l">Default (not removable)
                        %case 'Developers'%-</td><td class="oddrow-l">Developers (not removable)
                        %case 'Replicators'%-</td><td class="oddrow-l">Replicators (not removable)
                        %case 'Anonymous'%-</td><td class="oddrow-l">Anonymous (not removable)
                        %case 'Internal'%-</td><td class="oddrow-l">Internal (not removable)
                        %case 'SAPUsers'%-</td><td class="oddrow-l">SAPUsers (not removable)
			%case 'WmPartnersUsers'%-</td><td class="oddrow-l">WmPartnersUsers (not removable)

                        %case%
                          <input type="checkbox" name="%value name%" value="REMOVE"></td><td class="oddrow-l">%value name%
			  %switch inUse%
                              %case 'true'%(in use)
                          %endswitch%
                      %endswitch%
        </td>
        </tr>

                    %endloop%
                  %endinvoke%
	      </table>
            </td>
          </tr>
          <tr>
            <td class="action" colspan=2>
  <input type="submit" value="Remove ACLs" name="removeACL" onclick="return confirm('Are you sure you want to remove selected ACLs? The ACLs will be removed from any services they currently protect.');">
            </td>
          </tr>
        </table>
</td></tr></table>
        </form>
      </td>
    </tr>
  </table>
</body>
</html>
