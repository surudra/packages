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
				<TD class="menusection-Solutions" colspan=2>WmXSLT &gt; Samples &gt; Today Sample</TD>
            </TR>

</TABLE>
</DIV>
	  
    <ul>
      <li><a href="/WmXSLT/samples-xslt.dsp">Back to Samples</a></li>
    </ul>

    <p>This example transforms the empty date element in file <a target="_blank" 
	href="xdocs/date.xml">date.xml</a> into a string representing the current
      date/time. The XSLT stylesheet <a  target="_blank" href="xdocs/date.xsl">date.xsl</a> uses the extension
      mechanism to instantiate Java class <code>java.util.Date</code> and than performs the
      <code>toString</code> method at the instantiated object.</p>
    <p>To invoke service <code>sample.xslt:transformToString</code> with the following
      input values please click on the button below:</p>
    <form class="form" action="todayInvoke.dsp" method="post">
      <table>
	<tr>
	  <td>stylesheetSystemId</td>
	  <td><input class="whiteBackground" type="text" size="70" name="stylesheetSystemId"
	      value="http://localhost:5555/WmXSLT/samples/xdocs/date.xsl"/>
	  </td>
	</tr>
	<tr>
	  <td>systemId</td>
	  <td><input class="whiteBackground" type="text" size="70" name="systemId"
	      value="http://localhost:5555/WmXSLT/samples/xdocs/date.xml"/>
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
