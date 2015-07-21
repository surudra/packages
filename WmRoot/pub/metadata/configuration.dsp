<?xml version='1.0'?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
    <head>
        <title>Asset Publisher - Configuration</title>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <meta http-equiv="Expires" content="-1">
        <link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css"></link>
        <script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
        <script language="JavaScript1.2">
            //setHelpPage("/WmAssetPublisher/configuration.dsp", "Config.html");
        </script>
    </head>
    
    <BODY onLoad="setNavigation('/metadata/configuration.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Metadata_Config');">
        %scope param(package='WmAssetPublisher')%
            %invoke wm.server.packages:getPackageStatus%
                %ifvar exists equals('false')%
                     <p class="message">WmAssetPublisher must be installed.</p>
                %else%
                    %ifvar enabled equals('false')%
                        <p class="message">WmAssetPublisher must be enabled.</p>
                    %else%
                        %include ../../../WmAssetPublisher/pub/configuration-table.dsp%
                    %endif%
                %endif%
            %onerror%
                <tr><td colspan="2" class="message">error: %value errorMessage%</td></tr>
            %endinvoke%
        %endscope%
    </body>
</html>
