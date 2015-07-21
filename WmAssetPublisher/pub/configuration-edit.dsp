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
        <script type="text/javascript" src="/WmAssetPublisher/metadata.js"></script>
        <script language="JavaScript1.2">
            // setHelpPage("configuration-edit.dsp", "ConfigEdit.html");
 
            function checkLibrary() {
                // alert("mdl url: " + document.editform.MDL_URL.value);
            }

	    function fillInDefaultURL() {
                document.editform.MDL_URL.value = "http://localhost:53305/CentraSite/CentraSite";
            }
        </script>
    </head>
    
    <BODY onLoad="setNavigation('/WmAssetPublisher/configuration.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Metadata_Config_Edit');">
        <table width="100%">
            <tr>
                <td class="menusection-Settings" colspan="2">
                    Asset Publisher &gt; Configuration &gt; Edit
                </td>
            </tr>
            
            <tr>
                <td colspan="2">
                    <ul>
                        <li><a href="/WmAssetPublisher/configuration.dsp">Return to Configuration</a></li>
                    </ul>
                </td>
            </tr>
            
            <tr>
                <td><img src="/WmRoot/images/blank.gif" height=10 width=0 border=0></td>
                <td>
                    <table class="tableView" width="50%">
                        %invoke wm.server.metadata.Admin:getConfiguration%
                
                            <form name="editform"
                                  action="configuration.dsp"
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
                                    <td class="heading" colspan="2">CentraSite Configuration</td>
                                </tr>

                                <tr>
                                    <script>writeTDWidth("row-l", "20%")</script>IS Identifier</td>
                                    <script>writeTD("rowdata-l")</script>
                                        <input type="text" 
                                               name="IS_IDENTIFIER" 
                                               value="%ifvar IS_IDENTIFIER -notempty%%value IS_IDENTIFIER%%else%IntegrationServer%endif%" 
                                               style="width:100%"/>
                                    </script></td>
                                    <script>swapRows();</script>
                                </tr>

                                <tr>
                                    <script>writeTD("row-l")</script>CentraSite URL</td>
                                    <script>writeTD("rowdata-l")</script>
                                    <input type="text" name="MDL_URL" value="%value MDL_URL%" style="width:100%" onChange="checkLibrary()"/>
                                    (For example: http://localhost:53305/CentraSite/CentraSite)
                                    <script>swapRows();</script>
                                </tr>
                        
                                <tr>
                                    <script>writeTD("row-l")</script>User Name</td>
                                    <script>writeTD("rowdata-l")</script>
                                    <input type="text" name="MDL_USERNAME" value="%value MDL_USERNAME%" style="width:100%"/>
                                    <script>swapRows();</script>
                                </tr>
                        
                                <tr>
                                    <script>writeTD("row-l")</script>Password</td>
                                    <script>writeTD("rowdata-l")</script>
                                    <input type="password" autocomplete="off" name="MDL_PASSWORD" value=%ifvar MDL_PASSWORD -notempty%"********"%else%""%endif% style="width:100%"/>
                                    <script>swapRows();</script>
                                </tr>

                                <tr>
                                    <td class="action" colspan="2">
                                        <input type="hidden" name="action" value="Save">
                                        <input type="submit" value="Save Changes" onclick="return confirmEdit();">
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
