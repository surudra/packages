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
				<TD class="menusection-Solutions" colspan=2>WmXSLT &gt; Samples &gt; Integer Date Sample</TD>
            </TR>

</TABLE>
</DIV>
  
    <ul>
      <li><a href="/WmXSLT/samples-xslt.dsp">Back to Samples</a></li>
      <li><a href="date.dsp">Return to Integer Date Sample</a></li>
    </ul>

    %invoke sample.xslt.helpers:setXslParamInput%
    %onerror% %include ../error.html%
    %endinvoke%
    %invoke sample.xslt:transformIntDate%
    <form class="form">
      <table>
	<tr>
	  <td colspan="2">
	    <textarea rows="19" cols="55" readonly="true">%value string%</textarea>
	  </td>
	</tr>
	<tr>
	  <td>xslParamOutput</td>
	  <td>
	    <table>
	      <!-- %loop xslParamOutput -struct% -->
	      <tr>
		<td>%value $key%</td>
		<td>%value%</td>
	      </tr>
	      <!-- %endloop% -->
	    </table>
	  </td>
	</tr>
      </table>
    </form>

    %onerror% %include ../error.html%
    %endinvoke%
  </body>
</html>
