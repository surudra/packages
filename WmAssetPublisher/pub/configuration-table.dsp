<table width="100%">
    <tr>
        <td class="menusection-Settings" colspan="2">
            Asset Publisher &gt; Configuration
        </td>
    </tr>

    %switch action%
    %case 'Test'%
        <tr>
            <td colspan="2">&nbsp;</td>
        </tr>

        %invoke wm.server.metadata.Admin:testSettings%
            <tr>
                <td class="message" colspan=2>
                    %ifvar errorMessage%
                        %value errorMessage%
                    %else%
                        %ifvar successMessage%
                            %value successMessage%
                        %else%
                            %ifvar connected equals('true')%
                                connected
                            %else%
                                not connected
                            %endif%
                        %endif%
                    %endif%
                </td>
            </tr>
        %onerror%
            <tr><td colspan="2" class="message">error: %value errorMessage%</td></tr>
        %endinvoke%
    %case 'Save'%
        <tr>
            <td colspan="2">&nbsp;</td>
        </tr>

        %invoke wm.server.metadata.Admin:setConfiguration%
            %ifvar errorMessage%
                <tr>
                    <td class="message" colspan=2>
                        error: %value errorMessage%
                    </td>
                </tr>
            %else%
                <tr>
                    <td class="message" colspan=2>
                        %value successMessage%
                        %ifvar restartNeeded equals('true')%
                            Please restart the server to make the new settings take effect.</td>
                        %endif%
                    </td>
                </tr>
            %endif%
        %onerror%
            <tr><td colspan="2" class="message">error: %value errorMessage%</td></tr>
        %endinvoke%
    %endif%
    
    <tr>
        <td colspan="2">
            <ul>
                <li><a href="/WmAssetPublisher/configuration-edit.dsp">Edit Configuration</a></li>
            </ul>
        </td>
    </tr>
    
    <tr>
        <td><img src="/WmRoot/images/blank.gif" height=10 width=0 border=0></td>
        <td>
            <table class="tableView" width="50%">
                %invoke wm.server.metadata.Admin:getConfiguration%
                    <form name="editform"
                          action="/WmAssetPublisher/configuration.dsp"
                          method="POST">
                        <tr>
                            <td class="heading" colspan=2>CentraSite Configuration</td>
                        </tr>

                        <tr>
                            <script>writeTDWidth("row-l", "20%")</script>IS Identifier</td>
                            <script>writeTD("rowdata-l")</script>
                                %ifvar IS_IDENTIFIER -notempty%%value IS_IDENTIFIER%%else%IntegrationServer%endif%
                            </td>
                            <script>swapRows();</script>
                        </tr>
    
                        <tr>
                            <script>writeTD("row-l")</script>CentraSite URL</td>
                            <script>writeTDWidth("rowdata-l", "50")</script>%value MDL_URL%</td>
                            <script>swapRows();</script>
                            </td>
                        </tr>

                        <tr>
                            <script>writeTD("row-l")</script>User Name</td>
                            <script>writeTDWidth("rowdata-l")</script>%value MDL_USERNAME%</td>
                            <script>swapRows();</script>
                            </td>
                        </tr>

                        <tr>
                            <script>writeTD("row-l")</script>Password</td>
                            <script>writeTDWidth("rowdata-l", 50)</script>%ifvar MDL_PASSWORD -notempty% ******** %endif%</td>
                            <script>swapRows();</script>
                            </td>
                        </tr>

                        <tr>
                            <td class="action" colspan="2">
                                <input type="hidden" name="action" value="Test">
                                <input type="submit" value="Test Connection" onclick="return true;">
                            </td>
                        </tr>
                    </form>
        %onerror%
            <tr><td colspan="2" class="message">error: %value errorMessage%</td></tr>
                %endinvoke%
            </table>
        </td>
    </tr>
</table>
