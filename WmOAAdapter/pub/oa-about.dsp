<HTML>
<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<HEAD>
%include ../../WmRoot/pub/b2bStyle.css%
</HEAD>
<BODY>

<table border=0 cellspacing=0 cellpadding=0 width=100%><tr><td>

<TABLE border=0 cellspacing=3 cellpadding=0 width=100%>
  <TR>
    <TH colspan=2 class="heading">Copyright</TH></TR>
  <TR>
    <TD align=center  width=120><img src="/WmRoot/images/wmlogo.gif" border=0></TD>
    <TD >
     <p>
     webMethods Business Integrator, webMethods workFlow, 
     webMethods Integration Server, webMethods Developer, 
     webMethods Enterprise Server, webMethods Enterprise Integrator, 
     webMethods Mainframe, webMethods Trading Networks, 
     webMethods RosettaNet Module, webMethods EDI Module, 
     webMethods Chem eStandards Module and the webMethods logo 
     are trademarks of webMethods, Inc. 
     <BR>
     <BR>
     "webMethods" is a registered trademark of webMethods, Inc.
     <BR>
     <BR>
     All other marks are the property of their respective owners.
     <BR>
     <BR>
     Copyright &copy; 2001 by webMethods, Inc. All rights reserved, 
     including the right of reproduction in whole or in part in any form
    </TD>
  </TR>
  <TR>
    <TH  colspan=2 class="heading"> Version
    </TH>
  </TR>
  <TR>
    <TD class="rowlabel"> Product
    </TD>
    <TD class="rowdata">
     webMethods Oracle Applications Adapter
    </TD>
  </TR>
  <TR>
    <TD>  
    </TD>
    <TD class="rowdata">
     For use with webMethods Integration Server version 3.1.2 or higher
    </TD>
  </TR>
  <TR>
    <TD class="rowlabel">Version</TD>
    %invoke wm.OracleApps.OAConfig:getVersion%
      <TD class="rowdata">%value version%
        &nbsp;&nbsp;&nbsp;&nbsp;<a href="/OracleApps/ReleaseNotes.html">Release Notes</a>
      </TD>
    %onerror%
      %ifvar localizedMessage%
        <TD class="rowdata">Error retrieving version: %value localizedMessage%</TD>
      %else%
        <TD class="rowdata">Error retrieving version: %value errorMessage%</TD>
      %endif%
    %endinvoke%
  </TR>
  
  <TR>
    <TD class="rowlabel">Build Number</TD>
     %invoke wm.OracleApps.OAConfig:getBuild%
       <TD class="rowdata">%value build%</TD>
    %onerror%
      %ifvar localizedMessage%
        <TD class="rowdata">Error retrieving build: %value localizedMessage%</TD>
      %else%
        <TD class="rowdata">Error retrieving build: %value errorMessage%</TD>
      %endif%
    %endinvoke%
  </TR>
  <TR>
    <TD class="rowlabel">Oracle Applications<br>Versions Supported
    </TD>
    <TD class="rowdata">
     10.7SC, 11.0, and 11.5.3 and higher
    </TD>
  </TR>
</TABLE>

</td></tr></table>

</BODY>
</HTML>