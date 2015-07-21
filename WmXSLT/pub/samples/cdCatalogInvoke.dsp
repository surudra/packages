<?xml version='1.0'?>
<!--
<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN'
                      '/share/xml/XHTML/dtds/xhtml1-transitional.dtd'>
-->
<html>
  <head>
    <title>webMethods XSLT Package</title>
    <meta http-equiv="Pragma" content="no-cache"></meta>
    <meta http-equiv="Expires" content="-1"></meta>
    <link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css"></link>
  </head>
  <body>
      <DIV class="position">
         <TABLE WIDTH="100%">
            <TR>
				<TD class="menusection-Solutions" colspan=2>WmXSLT &gt; Samples &gt; CD Catalog Sample</TD>
            </TR>

</TABLE>
</DIV>
    
    <ul>
      <li><a href="/WmXSLT/samples-xslt.dsp">Back to Samples</a></li>
      <li><a href="cdCatalog.dsp">Return to CD Catalog Sample</a></li>
    </ul>

    %invoke sample.xslt:transformToString%
	    <textarea rows="19" cols="55" readonly="true">%value string%</textarea>
    %onerror% %include ../error.html%
    %endinvoke%
  </body>
</html>
