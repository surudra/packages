<?xml version='1.0'?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
    <head>
        <title>Asset Publisher - Configuration - Edit</title>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <meta http-equiv="Expires" content="-1">
        <link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css"></link>
        <script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
        <script type="text/javascript" src="/WmRoot/metadata/metadata.js"></script>
        <script language="JavaScript1.2">
            // setHelpPage("configuration-edit.dsp", "ConfigEdit.html");
        </script>
    </head>
    
    <BODY onLoad="setNavigation('/metadata/configuration.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Metadata_Config_Edit');">
        <table width="100%">
            <tr>
                <td class="menusection-Settings" colspan="2">
                    Asset Publisher &gt; Configuration &gt; Edit
                </td>
            </tr>
            
            <tr>
                <td colspan="2">
                    <ul>
                        <li><a href="/WmRoot/metadata/configuration.dsp">Return to Configuration</a></li>
                    </ul>
                </td>
            </tr>
            
            <tr>
                <td><img src="/WmRoot/images/blank.gif" height=10 width=0 border=0></td>
                <td>
                    <table class="tableView">
                        %invoke wm.server.metadata.admin:getConfiguration%
                
                            <form name="editform"
                                  action="/WmRoot/metadata/configuration.dsp"
                                  method="POST">

	                        <script language="JavaScript">function confirmEdit() { 
                                    if (checkMachineName(document.editform.IS_IDENTIFIER, "IS Identifier")) {
                                        if (checkNonNegNumber(document.editform.MDL_PORT)) {
                                            return true;
                                        }
                                        else {
                                            alert("Port field must contain a non-negative number");
                                            return false;
                                        }
                                    }
                                    else {
                                        return false;
                                    }
                                }</script>
                
                                <tr>
                                    <td class="heading" colspan="2">Metadata Library Configuration</td>
                                </tr>

                                <tr>
                                    <script>writeTD("row-l")</script>IS Identifier</td>
                                    <script>
                                        writeTD("rowdata-l"); 
                                        writeInput("text", "IS_IDENTIFIER", "%ifvar IS_IDENTIFIER -notempty%%value IS_IDENTIFIER%%else%IntegrationServer%endif%")
                                    </script></td>
                                    <script>swapRows();</script>
                                </tr>

                                <tr>
                                    <script>writeTD("row-l")</script>Library</td>
                                    <script>writeTD("rowdata-l"); writeInputSize("text", "MDL_URL", "%value MDL_URL%", "200")</script></td>
                                    <script>swapRows();</script>
                                </tr>
                        
                                <tr>
                                    <script>writeTD("row-l")</script>User Name</td>
                                    <script>writeTD("rowdata-l"); writeInput("text", "MDL_USERNAME", "%value MDL_USERNAME%")</script></td>
                                    <script>swapRows();</script>
                                </tr>
                        
                                <tr>
                                    <script>writeTD("row-l")</script>Password</td>
                                    <script>writeTD("rowdata-l"); writeInput("password", "MDL_PASSWORD", "%value MDL_PASSWORD%")</script></td>
                                    <script>swapRows();</script>
                                </tr>
                        
                                <tr>
                                    <td class="action" colspan="2">
                                        <input type="submit" name="action" value="Save Changes" onclick="return confirmEdit();">
                                    </td>
                                </tr>
                            </form>
                        %endinvoke%
                    </table>
                </td>
            </tr>
        </table>    
    </body>
</html>
