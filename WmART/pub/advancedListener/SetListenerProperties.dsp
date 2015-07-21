%comment%----- Displays Listener Parameters and Properties -----%endcomment%

<html> 
    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <META HTTP-EQUIV="Expires" CONTENT="-1">
        <title>Listener Properties</title>
        <LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css"></LINK>
        <SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
        <script SRC="artconnjs.txt"></script>
    </head>
    
    <body>
        <form name="form" action="ListAdvancedListeners.dsp" method="POST">
            <input type="hidden" name="action" value="saveListener">
	    %comment%----- LG TRAX 1-MHXP3 -----%endcomment%
	    %comment%----- Added passwordChange flag -----%endcomment%
	    %comment%----- THIS IS REQUIRED BY ARTAdmin.java -----%endcomment%
	    <input type="hidden" name="passwordChange" value="false">
         
            %invoke wm.art.admin:retrieveAdapterTypeData%
            %onerror%
            %endinvoke%
        
            <table width="100%">  
                <tr>
                   <td class="menusection-Adapters" colspan=7>Adapters &gt; %value displayName% &gt; Configure Listener Type</td>
                </tr>

                <script>resetRows();</script>
              
                <tr>
                    <td colspan=2>
                        <ul>
                            <li>
                                <a href="ListAdapterListenerTypes.dsp?adapterTypeName=%value -urlencode adapterTypeName%">
                                    Return to %value displayName% Listener Types
                                </a>
                            </li>
                        </ul>
                    </td>
                </tr>
               
                %comment%----------------------Listener Properties--------------%endcomment%     
                %invoke wm.art.ns:getListenerProperties% 
                    <tr>
                        <td class="heading" colspan=2>Configure Listener Type &gt; %value displayName%</td>
                    </tr>

                    %include ConfigureListenerProperties.dsp%
                %onerror%
                    <tr>
                        <td class="heading" colspan=2>Configure Listener Type</td>
                    </tr>
                    %ifvar localizedMessage%
                        %comment%-- Localized error message supplied --%endcomment%
                        <tr><td class="message">Error: <pre>%value localizedMessage%</pre></td></tr>
                    %else%
                        %ifvar error%
                            <tr><td class="message">Error: <pre>%value errorMessage%</pre></td></tr>
                        %endif%
                    %endif%
                %endinvoke%      
            </table>
            
            <table width=100%>
                <tr>
                    <td class="action" colspan="2">
                        <input type="submit" name="SUBMIT" value="Save Listener"  onclick="return validateForm(this.form)"></input>
                        <input type="hidden" name="adapterTypeName"    value="%value adapterTypeName%">
                        <input type="hidden" name="listenerTypeName"   value="%value listenerTypeName%">
                        <input type="hidden" name="requiresConnection" value="%value requiresConnection%">
                    </td>
                </tr>
            </table>
        </form>    
    </body>
</html>
