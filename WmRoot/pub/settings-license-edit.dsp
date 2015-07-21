<HTML>
    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <meta http-equiv="Expires" content="-1">

        <title>Integration Server Settings</title>
        <link rel="stylesheet" type="text/css" href="webMethods.css">
        <script src="webMethods.js.txt"></script>
    </head>

%ifvar doc equals('edit')%
    <body onLoad="setNavigation('settings-license-edit.dsp',  '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditLicensingScrn');">
%else%
    <body onLoad="setNavigation('settings-license-edit.dsp',  '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_LicensingDetailsScrn');">
%endif%

        <table width="100%">
            <tr>
                <td class="menusection-Settings" colspan="2">
                    Settings &gt; License &gt; License Details
                    %ifvar doc equals('edit')%
                       &gt; Edit
                    %endif%
                </td>
            </tr>
    
    %ifvar action equals('change')%
        <!-- call setSettings to update the partner ip information -->
        %invoke wm.server.admin:setAllLicenseSettings%
            <tr><td colspan="2">&nbsp;</td></tr>
            <tr><td class="message" colspan="2">%value message%</td></tr>
            <script>
                reloadNavigationFrame();
                reloadTopFrame();
                setNavigation('settings-license-edit.dsp',  '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_LicensingDetailsScrn');
            </script>
        %endinvoke%
    %endif%
      
    %ifvar doc equals('edit')%
            <tr>
                <td colspan="2">
                    <ul>
                        <li><a href="settings-license-edit.dsp">Return to Licensing Details</a></li>
                    </ul>
                </td>
            </tr>
    %else%
            <tr>
                <td colspan="2">
                    <ul>
                        <li><a href="settings-license.dsp">Return to License</a></li>
                        <li><a href="settings-license-edit.dsp?doc=edit">Edit Licensing Details</a></li>
                    </ul>
                </td>
            </tr>
    %endif%

    %ifvar doc equals('edit')%
        <form name="editkey" action="settings-license-edit.dsp" method="POST">
            <input type="hidden" name="action" value="change">

            <tr>
                <td><img src="images/blank.gif" height="10" width="10" border="0" /></td>
                <td>
                    <table class="tableForm">
                        <tr>
                            <td class="heading" colspan="2">Edit License File</td>
                        </tr>
                    %invoke wm.server.query:getLicenseSettings%
                        <tr>
                            <td class="evenrow">Integration Server License File</td>
                            <td class="evenrow-l">
                                <input name="LicenseKeyFile" size="100" value="%value LicenseKeyFile%" />
                            </td>
                        </tr>
        
                    %ifvar keyPartner%
                        <tr>
                            <td class="heading" colspan="2">
                                Edit Partner Information
                            </td>
                        </tr>
                        <tr>
                            <td class="oddrow-l" colspan="2">
                                Partner License Key Holders Only
                            </td>
                        </tr>
                        <tr>
                            <td class="evenrow">
                                IP Address
                            </td>
                            <td class="evenrow-l">
                                <input name="watt.server.partner" value="%value watt.server.partner%"></input>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">&nbsp;</td>
                        </tr>
    
                    %endif% 
                    %endinvoke%

                    %invoke wm.server.query:getTerracottaLicenseInformation%
                        <tr>
                            <td class="oddrow">Terracotta License File</td>
                            <td class="oddrow-l">
                                <input name="watt.server.terracotta.license.path" size="100" value="%value terracottaLicenseFileSet%" />
                            </td>
                        </tr>
                    %endinvoke%
        
                        <tr>
                            <td colspan="2">&nbsp;</td>
                       </tr>

                        <tr>
                            <td colspan="2" class="action">
                                <input type="submit" value="Save Changes" />
                            </td>
                        </tr>

                    </table>
                </td>
            </tr>
  
        </form>

    %else%

    %invoke wm.server.query:getLicenseSettings%
        <tr>
            <td><img src="images/blank.gif" height="10" width="10" border="0" /></td>
            <td>
                <table>  
            %invoke wm.server.query:getLicenseDetails%
                %loop LicenseDetails%
                    %loop -struct%
                        <tr>
                            <td class="heading" colspan="2">%value $key%</td>
                        </tr>
                        %loop #$key%
                            %loop -struct%
                                <tr>
                                    <script>writeTD("row");</script>
                                        %ifvar $key equals('ExpirationDate')%
                                            %ifvar ../../../../../keyExpired%
                                                <font color="red">
                                            %endif%
                                        %endif%
                                    %value $key%</td>
                                    <script>writeTD("rowdata-l");</script>
                                    %ifvar $key equals('ExpirationDate')%
                                        %ifvar ../../../../../keyExpired%
                                           <font color="red">
                                        %endif%
                                    %endif%
                                    %value%</td>
    
                                   <script>swapRows();</script>
                                </tr>
                            %endloop%
                       %endloop%
                    %endloop%
                    <tr><td><br/></td></tr>
                %endloop%
            %endinvoke%

           %ifvar keyPartner%
                <!-- calling getSettings returns the value of watt.server.partner -->
                %invoke wm.server.query:getSettings%
                    <tr>
                        <td class="heading" colspan="2">Partner Information</td>
                    </tr>
         
                    <tr>
                        <script>writeTD("row");</script>Partner IP Address</td>
                        <script>writeTD("rowdata-l");</script>%value watt.server.partner%</td>
                    </tr>
         
                    <tr><td><br></td></tr>
                %endinvoke%
            %endif%

            %invoke wm.server.query:getTerracottaLicenseInformation%
                    <tr>
                        <td class="heading" colspan="2">Terracotta</td>
                    </tr>
                 
                    <tr>
                        <script>writeTD("row");</script>License File</td>
                        <script>writeTD("rowdata-l");</script>%value terracottaLicenseFileSet%</td>
                        <script>swapRows();</script>
                    </tr>
                 
                    <tr>
                        <script>writeTD("row");</script>BigMemory</td>
                        
                        <script>writeTD("rowdata-l");</script>
                            %ifvar isBigMemoryLicensed equals('true')%
                                yes
                            %else%
                                no
                            %endif%
                        </td>
                        <script>swapRows();</script>
                    </tr>
                 
                    <tr>
                        <script>writeTD("row");</script>Expiration Date</td>
                        <script>writeTD("rowdata-l");</script>%value expirationDate%</td>
                        <script>swapRows();</script>
                    </tr>
                  
            %endinvoke%
                 
                    <tr><td><br></td></tr>
        
                </table>
            </td>
        </tr>
    %endinvoke%

    %endif%

        </table>
    </body>
</html>
