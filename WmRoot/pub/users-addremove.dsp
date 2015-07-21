<html>
    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <META HTTP-EQUIV="Expires" CONTENT="-1">
        <title>ServerUI</title>
        <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
        <base target="_self">
        <style>
            .listbox { width: 100%; }
        </style>

        <script>
			function trim(str)
            {
                var retval = "";
                var start = str.length;
                var end = 0;
                for (i = 0; i < str.length; i++) {
                    if (start > i) {
                        if (! /\s/.test(str.charAt(i))) {
                            start = i;
                        }
                    }

                    if (! /\s/.test(str.charAt(i))) {
                        end = i;
                    }
                }

                if (start <= end) {
                    retval = str.substr(start, (end - start + 1));
                }

                return retval;
            }

            function checkLegalUserName(username)
            {
                var illegalChars = "\"\\\<&";

                for (var i = 0; i < illegalChars.length; i++) {
                    if (username.indexOf(illegalChars.charAt(i)) >= 0) {
                        return illegalChars.charAt(i);
                    }
                }
                return "";
            }

            function containsNonAscii(username)
            {
                // Test for printable ascii characters only and return the opposite.
                var illegalRE = /^[\040-\177]*$/
                return ! illegalRE.test(username);
            }

            function checkPasses()
            {
				if (document.form.allowDigestAuthentication.checked)
				{
					document.form.allowDigestAuth.value = true;
				}
				else
				{
					document.form.allowDigestAuth.value = false;
				}
                var covered = true;
                var passwdProvided = false;

                var userList   = document.form.users.value;
                var passField1 = document.form.pass.value;
                var passField2 = document.form.repass.value;
                var starStart  = /^\*+/;

                if (userList == "") {
                    alert("No users were entered into the list");
                    return false;
                }
                else if (passField1 != passField2) {
                    alert("Password fields do not match");
                    return false;
                }
                else if (passField1 == "" && passField2 == "") {
                    // allow this?
                    passwdProvided = false;
                }
                else if (passField1.search(starStart) >= 0) {
                    covered = false;
                    alert("Passwords must not start with *");
                    return false;
                }
                else if (passField1 != "" && passField2 != "") {
                    passwdProvided = true;
                }

                var userPass = userList.split("\n");
                for (var i = 0; i < userPass.length; i++) {
                    var pair = userPass[i].split(";");

                    if (pair.length < 2) {
                        covered = false;
                    }

                    var userName = trim(pair[0]);

                    var rc = checkLegalUserName(userName);

                    if (rc != "") {
                        alert("Username: " + userName + " contains illegal character \"" + rc + "\"");
                        return false;
                    }

                    if (containsNonAscii(userName)) {
                        alert("Username: " + userName + " contains non-ASCII character(s)");
                        return false;
                    }

                    if (pair.length >= 2) {
                        var password = trim(pair[1]);

                        var rc2 = password.search(starStart);
                        if (rc2 < 0) {
                            //alert("No * found!" + rc2);
                        }
                        else {
                            alert("Passwords must not start with '*'");
                            return false;
                        }

                        if (userName == "" || password == "") {
                            covered = false;
                        }
                    }
                }

                if (!passwdProvided && !covered) {
                    alert("One or more users do not have a password specified");
                }

                return covered || passwdProvided;
            }
        </script>
    </head>

    <SCRIPT SRC="webMethods.js.txt"></SCRIPT>

    <BODY onLoad="setNavigation('users.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_AddRemoveUsersScrn');">
        <table width=100%>
            <tr>
                <td colspan=2 class="menusection-Security">
                    Security &gt;
                    User Management &gt;
                    Add and Remove Users
                </td>
            </tr>

            <form id="revert" name="revert" method="POST" action="users.dsp">
            </form>

            <tr>
                <td colspan=2>
                    <ul>
                        <li><a href="users.dsp">Return to User Management</a></li>
                    </ul>
                </td>
            </tr>

            <tr>
                <td><img src="images/blank.gif" height=10 width=10></td>
                <td>

                    <form id="form" name="form" method="POST" action="users.dsp">
                        <input type="hidden" name="action" value="addusers">
						<input type="hidden" name="allowDigestAuth" value="false">
                        <table class="tableForm" width="60%">
                            <tr>
                                <td class="heading" colspan=2>Create Users</td>
                            </tr>
                            <tr>
                              <td nowrap valign="top" class="oddrow">User Names</td>
                              <td class="oddrow-l">One "username" or <br>"username;password" per line.<br>
                                <textarea style="width:100%;" wrap="off" rows="5" name="users" id="users" cols="20"></textarea></td>
                            </tr>
                            <tr>
                                <td class="evenrow-l" colspan=2>
                                    The password below will apply to all new users that do not have a password specified above.
                                </td>
                            </tr>
                            <tr>
                                <td class="oddrow">Password</td>
                                <td class="oddrow-l">
                                    <input type="password" name="pass" id="pass" autocomplete="off" value=""/>
                                </td>
                            </tr>
                            <tr>
                                <td class="evenrow">Re-Enter Password</td>
                                <td class="evenrow-l">
                                    <input type="password" name="repass" id="repass" autocomplete="off" value=""/>
                                </td>
                            </tr>
							<tr>
							    <td class="oddrow">Allow Digest Authentication</td>
                                <td class="oddrow-l">
                                    <input type="checkbox" name="allowDigestAuthentication" id="allowDigestAuthentication">
                                </td>
                            </tr>

                            <tr>
                            <tr>
                                <td class="action" colspan=2>
                                    <input type="submit" value="Create Users" name="submit" onClick="return checkPasses();" >
                                </td>
                            </tr>
                        </table>
                    </form>

                    <form id="deleteusers" name="deleteusers" method="POST" action="users.dsp">
                        <input type="hidden" name="action" value="removeusers">

                        <table class="tableForm" width="60%">
                            <tr>
                                <td class="heading" colspan=2>Remove Users</td>
                            </tr>

                            <tr>
                                <td nowrap valign="top" class="oddrow">Select Users</td>
                                <td class="oddrow-l">
                                    <table class="tableInline">
                                        %invoke wm.server.access:userList%
                                            %loop users%
                                                <tr>
                                                    <td align="center">
                                                        %switch name%
                                                            %case 'Administrator'%-</td><td class="oddrow-l">Administrator (not removable)
                                                            %case 'Default'%-</td><td class="oddrow-l">Default (not removable)
                                                            %case 'Developer'%-</td><td class="oddrow-l">Developer (not removable)
                                                            %case 'Replicator'%-</td><td class="oddrow-l">Replicator (not removable)
                                                            %case 'SAPUser'%-</td><td class="oddrow-l">SAPUser (not removable)
                                                            %case%
                                                                <input type="checkbox" name="%value name%" value="REMOVE"></td><td>%value name%
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
                                    <input type="submit" value="Remove Users" name="remove" onclick="return confirm('Are you sure you want to remove selected users?');">
                                </td>
                            </tr>
                        </table>
                    </form>
                </td>
            </tr>
        </table>
    </body>
</html>
