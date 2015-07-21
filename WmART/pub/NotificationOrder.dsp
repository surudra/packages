<html>
    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <meta http-equiv="Expires" CONTENT="-1">
        <title>Edit Notification Order</title>
        <link rel="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css"></link>    
        <SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
        <script src="artconnjs.txt"></script>

        <SCRIPT>
            function outputList(ar, size) {
                var str = "<SELECT "%ifvar readOnly equals('true')% + "DISABLED "%endif%;
                str += "SIZE=\"" + size + "\" NAME=\"notifList\" STYLE=\"width: 100%\">"
                for (var i = 0; i < ar.length; i++) {
                    str += "<OPTION "
                    %ifvar readOnly equals('false')%if (i == 0) {
                        str += " SELECTED"
                    }%endif%
                    str += " VALUE=\"" + ar[i] + "\">" + ar[i]
                }
                str += "</SELECT>"
                str += "<INPUT NAME=\"" + "notificationNames" + "\" TYPE=\"hidden\">"
                return str
            }
            
            function makeDirectionButton(isUp, val) {
                return "<INPUT TYPE=button VALUE=\"" + val + "\" ONCLICK=\"move(this.form, " + isUp + ")\">"
            }
            
            function move(form, isUp) {
                var el = form.elements["notifList"]
                var index = el.selectedIndex
                if (index == -1) {
                    // nothing
                }
                else {
                    var nextIndex = index + (isUp ? -1 : 1)
            
                    // stop at the top (i.e., don't wrap)
                    if (nextIndex <  0) 
                        nextIndex = 0
            
                    // end at the bottom (i.e., don't wrap)
                    if (nextIndex >= el.length) 
                        nextIndex = el.length - 1
            
                    var oldVal  = el[index].value
                    var oldText = el[index].text
            
                    el[index].value = el[nextIndex].value
                    el[index].text  = el[nextIndex].text
            
                    el[nextIndex].value = oldVal
                    el[nextIndex].text  = oldText
            
                    el.selectedIndex = nextIndex
                }
            }
            
            function processForm(f) {
                for (var i = 0; i < f.length; i++) {
                    var el = f[i]
                    if (el.name == "notifList") {
                        var str = ""
                        for (var j = 0; j < f[i].options.length; j++) {
                            if (j != 0) {
                                str += "|||||"
                            }
                            str += f[i].options[j].value
                        }
                        f.elements["notificationNames"].value = str
                        break
                    }
                }
            }
        </SCRIPT>
    </head>

    <body>
        %ifvar changeOrder%
            %invoke wm.art.ns:setNotificationOrder%
                %onerror%
                    %ifvar localizedMessage%
                        %comment%-- Localized error message supplied --%endcomment%
                        <tp>Error encountered <pre>%value localizedMessage%</pre></p>
                    %else%
                        %ifvar error%
                            <p>Error encountered <pre>%value errorMessage%</pre></p>
                        %else%
                            <p>Error encountered no message</pre></p>
                        %endif%
                    %endif%
            %endinvoke%
        %endif%

        <table width=100%>
            <tr>
            %ifvar readOnly equals('true')%
                <td class="menusection-Adapters" colspan=2>Adapters &gt; %value adapterDisplayName% &gt; View Listener &gt; View Notification Order</td>
            %else%
                <td class="menusection-Adapters" colspan=2>Adapters &gt; %value adapterDisplayName% &gt; Edit Listener &gt; Edit Notification Order</td>
            %endif%
            </tr>
          
            <tr>
                <td colspan=2>
                    <ul>
                        <li>
                        %ifvar readOnly equals('true')%
                            <a href="ListenerDetails.dsp?readOnly=%value readOnly%&adapterTypeName=%value -urlencode adapterTypeName%&listenerNodeName=%value listenerNodeName%&dspName=.LISTRESOURCES">
                                Return to View Listener
                            </a>
                        %else%
                            <a href="ListenerDetails.dsp?readOnly=%value readOnly%&adapterTypeName=%value -urlencode adapterTypeName%&listenerNodeName=%value listenerNodeName%&dspName=.LISTRESOURCES">
                                Return to Edit Listener
                            </a>
                        %endif%
                        </li>
                    </ul>
                </td>
            </tr>

            <tr>
                <td><img src="images/blank.gif" height="10" width="10"></td>
                <td>
                    <FORM METHOD=post ONSUBMIT="processForm(this)">
                        <table width="100%" class="tableForm" cellpadding=2 cellspacing=2>
                            <tr>
                                <td class="heading">%value listenerNodeName% Notification Order</td>
                            </tr>
                
                            <tr>
                                <td class="oddcol">
                                    <tr>
                                        <td valign="top" width="100%" class="oddcol">
                                            <table width="100%" cellspacing=2 cellpadding=2>
                                                    <tr>
                                                        <td valign="top" width="%ifvar readOnly equals('true')%100%else%90%endif%%" halign="right" cellspacing=5 cellpadding=5>
                                                            <SCRIPT>
                                                                var arrList = new Array()
                                                                %invoke wm.art.ns:queryNotificationOrder%
                                                                %loop -struct notificationNames%
                                                                    arrList[%value $key%] = "%value #$key%"
                                                                %endloop%
                                                                %endinvoke%
    
                                                                document.write(outputList(arrList, 25) + "<BR>")
                                                            </SCRIPT>
                                                        </td>
                                                        <td valign="top" height="100%" width="%ifvar readOnly equals('true')%0%else%10%endif%%">
                                                            <table height="100%" width="10%" cellpadding=10 cellspacing=10>
                                                                <tr>
                                                                    <td valign="top">
                                                                        %ifvar readOnly equals('true')%
                                                                        %else%
                                                                        <script>
                                                                            document.write(makeDirectionButton(true,  "Up"))
                                                                        </script>
                                                                        %endif%
                                                                    </td>
                                                                </tr>
                                                                
                                                                <tr>
                                                                    <td valign="bottom">
                                                                        %ifvar readOnly equals('true')%
                                                                        %else%
                                                                        <script>
                                                                             document.write(makeDirectionButton(false,  "Down"))
                                                                        </script>
                                                                        %endif%
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                            </table>
                                       </td>
                                    </tr>
                                </td>
                            </tr>

                            <tr>
                                <td class="action" colspan=2>
                                    %ifvar readOnly equals('true')%
                                    %else%
                                        <INPUT NAME="adapterTypeName"  VALUE="%value adapterTypeName%"  TYPE="hidden">
                                        <INPUT NAME="listenerNodeName" VALUE="%value listenerNodeName%" TYPE="hidden">
                                        <INPUT NAME="changeOrder"      VALUE="Save Changes"             TYPE="submit">
                                    %endif%
                                </td>
                            </tr>
                        </table>
                    </FORM>
                </td>
            </tr>
        </table>
    </body>
</html>
