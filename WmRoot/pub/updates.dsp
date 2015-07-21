<HTML>
    <HEAD>
        <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <META HTTP-EQUIV='Content-Type' CONTENT='text/html; CHARSET=UTF-8'>
        <META HTTP-EQUIV="Expires" CONTENT="-1">
        <TITLE>Integration Server Packages</TITLE>
        <LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
        <SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
    </HEAD>

    <BODY onLoad="setNavigation('support.dsp', '');">
        <DIV class="position">
            <TABLE WIDTH="100%">
                <TR>
                    <TD class="menusection-Server" colspan=2>Support &gt; webMethods Packages and Updates</TD>
                </TR>
        
                %invoke wm.server.packages:packageList%
        
	            <TR>
                        %invoke wm.server.query.adminui:getSystemAttributes%
	                %endinvoke%
	                <TABLE class="tableView" width="100%">
                            <TR>
                                <TD class="heading" colspan=1>Updates</TD>
                            </TR>
                            <SCRIPT>resetRows();</SCRIPT>

                            %ifvar patches%
                                <TR>
                                    <TD CLASS="oddcol-l">
		                        %loop patches%
                                            %value%<BR>
                                        %endloop%
		                    </TD>
                                </TR>
		            %else%
          	                <TR><TD>None</TD></TR>
		            %endif%
	                </TABLE>
	            </TR>

                    <TR>
                        <TD><IMG SRC="images/blank.gif" height="10" width="10"></TD>
                        <TD>
                            <TABLE class="tableView" WIDTH="100%">
                                <TR>
                                    <TD CLASS="heading" COLSPAN="4">Installed Packages and Updates</TD>
                                </TR>
                                <SCRIPT>resetRows();</SCRIPT>
                                <TR>
                                    <TD CLASS="oddcol-l">Package Name</TD>
                                    <TD CLASS="oddcol">Version</TD>
                                    <TD CLASS="oddcol">Enabled</TD>
                                    <TD CLASS="oddcol">Loaded</TD>
                                </TR>
                                <SCRIPT>resetRows();</SCRIPT>
                    
                                %loop packages%
		                    %rename name package%
		                    %invoke wm.server.packages:packageInfo%
                                        %scope param(truestr='true') param(falsestr='false') param(showpkg='false')%    
                                            %ifvar publisher equals('webMethods, Inc.')%
                                                %rename truestr showpkg -copy%
                                            %else%
                                                %ifvar publisher equals('Software AG')%
                                                    %rename truestr showpkg -copy%
                                                %endif%
                                            %endif%
    
                                            %ifvar showpkg equals('true')%
                                                <TR>
                                                    <SCRIPT>writeTD('rowdata-l')</SCRIPT>
                                                        <A HREF="/WmRoot/package-info.dsp?package=%value package%">%value package%</A>
                                                    </TD>
                                                    <SCRIPT>writeTD('rowdata');</SCRIPT>%value version%</TD>
                                                    <SCRIPT>writeTD('rowdata');</SCRIPT>%ifvar enabled equals('true')%Yes%else%No%endif%</TD>
                                                    <SCRIPT>writeTD('rowdata');</SCRIPT>
                                                        %ifvar loaderr equals('0')%
                                                            %ifvar enabled equals('false')%
                                                                No
                                                            %else%
                                                                %ifvar loadwarning equals('0')%
                                                                    Yes
                                                                %else%
                                                                    <font color="red">Warnings</font>
                                                                %endif%
                                                            %endif%
                                                        %else%
                                                            %ifvar loadok equals('0')%
                                                                No
                                                            %else%
                                                                <font color="red">Partial</font>
                                                            %endif%
                                                        %endif%
                                                    </TD>
                                                    <SCRIPT>swapRows();</SCRIPT>
                                                </TR>
                                      
                                                %loop patchlist%
                                                    <TR>
                                                        <SCRIPT>writeTD('rowdata-l');</SCRIPT>&nbsp;&nbsp;%value name%</TD>
                                                        <SCRIPT>writeTD('rowdata');</SCRIPT>%value version%</TD>
                                                        <SCRIPT>writeTD('rowdata');</SCRIPT>--</TD>
                                                        <SCRIPT>writeTD('rowdata');</SCRIPT>--</TD>
                                                        <SCRIPT>swapRows();</SCRIPT>
                                                    </TR>
                                                %endloop%
                                            %endif%
		                        %endscope%
		                    %endinvoke%
		                %endloop%
                            </TABLE>
                        </TD>
                    </TR>
                %endinvoke%
            </TABLE>
        </DIV>
    </BODY>
</HTML>
