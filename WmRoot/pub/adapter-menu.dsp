<HTML>
<HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
<style>
body {     border-top: 1px solid #97A6CB; }
</style>
<script src="menu.js.txt"></script>
</HEAD>

%invoke wm.server.ui:getMenuTabs%

<BODY CLASS="menu" onload="initMenu('%value -htmlcode buttonUrls[0]/url%')">
<form name="urlsaver">
<input type="hidden" name="helpURL" value="doc/OnlineHelp/WmRoot.htm#help-settings.dsp">
</form>






<TABLE WIDTH="100%" cellspacing=0>

%ifvar buttonUrls%
<script>document.forms["urlsaver"].helpURL.value = '%scope buttonUrls[0]%%value tabhelp%%endscope%';</script>

    <TR><TD CLASS="menusection-Adapters">
       <img src="images/blank.gif" width="5" height="1" border="0">%value text%</TD></TR>
%loop buttonUrls%
    <TR>

        <TD id="i%value url%" class="menuitem" onmouseover="menuMouseOver(this, '%value url%');" onmouseout="menuMouseOut(this);"
            onclick="document.all['a%value url%'].click();">


    <nobr><img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><img valign="middle"
            %ifvar url%name="%value url%"%endif%
            src="images/blank.gif"
            height="8" width="8" border="0">&nbsp;
        %ifvar url equals('none')%<FONT CLASS="fakeanchor">%value name%</FONT>
        %else%<A id="a%value url%" TARGET="body"
           HREF="%value url%"
           onclick="adapterMenuClick('%value url%', '%value tabhelp%');">%value name%</A>%endif%</nobr></TD></TR>

           %endloop%
<tr>
<td class="menuseparator"><img src="images/blank.gif" width="3" height="3" border="0"></td>
</tr>

%endif%
</TABLE>



</BODY>
</HTML>
