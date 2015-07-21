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
    </ul>

    <p>This example transforms a <a target="_blank" href="xdocs/cdCatalog.xml">CD catalog</a> in XML format
      into a HTML fragment which will than get included into a DSP page for displaying in a
      browser. As input you have to provide the XSLT stylesheet and the XML file which should
      be transformed.</p>
    <p>To invoke service <code>sample.xslt:transformToString</code> with the following
      input values please click on the button below:</p>
    <form class="form" action="cdCatalogInvoke.dsp" method="post">
      <table>
	<tr>
	  <td>stylesheetSystemId</td>
	  <td><input class="whiteBackground" type="text" size="70" name="stylesheetSystemId"
	      value="http://localhost:5555/WmXSLT/samples/xdocs/cdCatalog.xsl"/>
	  </td>
	</tr>
	<tr>
	  <td>systemId</td>
	  <td><input class="whiteBackground" type="text" size="70" name="systemId"
	      value="http://localhost:5555/WmXSLT/samples/xdocs/cdCatalog.xml"/>
	  </td>
	</tr>
	<tr>
	  <td>useCompilingProcessor</td>
	  <td><input type="checkbox" name="useCompilingProcessor"
	      value="true"/>
	  </td>
	</tr>
	<tr>
	  <td>blockExternalEntity</td>
	  <td><input type="checkbox" name="loadExternalEntities"
	     value="false"/>
	  </td>
	</tr>
	<tr>
	  <td colspan="2">
	    <input class="button" type="submit" value="Perform Transformation"/>
	  </td>
	</tr>
      </table>
    </form>
  </body>
</html>
