%comment%------ List connection factory types ------%endcomment%
<HTML>
    <head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <TITLE>List Adapter Connection Types</TITLE>
    <LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css"></LINK>
    <SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
    </head>
    %invoke wm.art.admin:getAdapterTypeOnlineHelp%
    %onerror%
    %endinvoke%
    %invoke wm.art.admin:retrieveAdapterTypeData%
    %onerror%
    %endinvoke%
	

    <BODY onLoad="setNavigation('ListResources.dsp', '%value encode(javascript) helpsys%', 'foo');">
    
    <input type="hidden" name="searchConnectionName" value="%value searchConnectionName%">
        <table width="100%">  
        <tr>
            <td class="menusection-Adapters" colspan=7>Adapters &gt; %value displayName% &gt; Connection Types</td>
        </tr>
    
        <tr>
        <td colspan=2>
            <ul>
            <li><a href="ListResources.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchConnectionName=%value -urlencode searchConnectionName%&dspName=.LISTRESOURCES">Return to %value displayName% Connections
            </a></ul>
        </td>
        </tr>
  
        <tr>
            <td class="heading" colspan=2>Connection Types</td>
        </tr>
   
        <tr>
            <td class="oddcol-l">Connection Type</td>
            <td class="oddcol-l">Description</td>    
        </tr>
        
        %invoke wm.art.admin.connection:retrieveConnectionTypes%
        %ifvar mgdConnTypes%
            %loop mgdConnTypes%
            <tr>
            <script>writeTD('rowdata-l');</script>     
            <a href="/WmART/GetConnProperties.dsp?adapterTypeName=%value -urlencode adapterTypeName%&connectionFactoryType=%value -urlencode connectionFactoryType%&searchConnectionName=%value -urlencode ../searchConnectionName%">%value mgdConnFactoryDisplay%</a></td>
            <script>writeTD('rowdata-l');swapRows();</script>
            %value mgdConnFactoryDesc%</td>
            </tr>
            %endloop%
        %else%
            <tr>
            <td class="message" colspan=2>No connection types found</td></tr>
        %endif%                       
        
        %onerror%
          %ifvar localizedMessage%
            %comment%-- Localized error message supplied --%endcomment%
            <tr><td class="message">Error encountered <PRE>%value localizedMessage%</PRE></td></tr>
          %else%
            %ifvar error%
              <tr><td class="message">Error encountered <PRE>%value errorMessage%</PRE></td></tr>
            %endif%
          %endif%
       
        %endinvoke%
        </table>
       
    </body>
</HTML>