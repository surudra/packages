<html>
    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <meta http-equiv="Expires" content="-1">
        <link rel="stylesheet" type="text/css" href="webMethods.css">
        <script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
    </head>

    <body onLoad="setNavigation(broker-sync.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_XXX');">

        <table width="100%">
            <tr>
                <td class="menusection-Settings" colspan="2">Broker &gt; Sync</td>
            </tr>

            <tr>
                <td colspan=2>
                    <ul>
                      <li><a href="settings-broker.dsp">Return to Broker Settings</a></li>
                  </ul>
                </td>
            </tr>

            <tr>
                <td><img src="images/blank.gif" height=10 width=10></td>
                <td>
                    <table class="tableView">
                        <td class="heading" width="50%">Document</td>
                        <td class="heading" width="25%">Direction</td>
                        <td class="heading" width="25%">Status</td>

                        <script>resetRows();</script>
                        %invoke wm.server.ed:syncWithBroker%
                            %loop -struct documents%
                                %scope #$key%
                                    <tr>
                                        <script>writeTD("rowdata-l")</script>%value name%</td>
                                        <script>writeTD("rowdata-l")</script>%ifvar isPull equals('true')% Pull %else% Push %endif%</td>
                                        <script>writeTD("rowdata-l")</script>%ifvar successful equals('true')% Succeeded %else% Failed %endif%</td>
                                        <script>swapRows();</script>
                                    </tr>
                                %endscope%
                            %endloop%
                        %onerror%
                            <tr></td>%value errorMessage%</td></tr>
                        %endinvoke%
                    </table>
               </td>
            </tr>
        </table>
    </body>
</html>
