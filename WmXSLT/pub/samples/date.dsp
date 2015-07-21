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
    
    
<script>
	function toggleStylesheet() {
		if(document.transformForm.useCompilingProcessor.checked) {
			document.transformForm.stylesheetSystemId.value = "http://localhost:5555/WmXSLT/samples/xdocs/dateIntForCompilingProcessor.xsl";
		} else {
			document.transformForm.stylesheetSystemId.value = "http://localhost:5555/WmXSLT/samples/xdocs/dateInt.xsl";
		}
		
		return true;
	}
</script>
    
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
    </ul>

    <p>In this example the empty date element in file <a  target="_blank" href="xdocs/date.xml">date.xml</a>
      gets converted to a string representing the date/time based on input parameters
      provided. The XSLT stylesheets <a  target="_blank" href="xdocs/dateInt.xsl">dateInt.xsl</a> and 
      <a  target="_blank" href="xdocs/dateIntForCompilingProcessor.xsl">dateIntForCompilingProcessor.xsl</a> use the
      extension mechanism to build a <code>java.util.Date</code> object using method
      <code>getDate</code> from class <code>com.wm.pkg.xslt.samples.date.IntDate</code>. This
      method requires the values from record <code>xslParamInput</code> as
      parameters. Furthermore the XSLT engine creates an <code>xslParamOutput</code> object for
      further processing. This object contains all input parameters plus the resulting
      date/time string.</p>
    <p>To invoke service <code>sample.xslt:transformIntDate</code> with the following
      input values please click on the button below:</p>
    <form name="transformForm" class="form" action="dateInvoke.dsp" method="post">
      <table>
	<tr>
	  <td>stylesheetSystemId</td>
	  <td><input class="whiteBackground" type="text" size="80" name="stylesheetSystemId"
	      value="http://localhost:5555/WmXSLT/samples/xdocs/dateInt.xsl"/>
	  </td>
	</tr>
	<tr>
	  <td>systemId</td>
	  <td><input class="whiteBackground" type="text" size="80" name="systemId"
	      value="http://localhost:5555/WmXSLT/samples/xdocs/date.xml"/>
	  </td>
	</tr>
	<tr>
	  <td>xslParamInput</td>
	  <td>
	    <table>
	      <tr>
		<td>year</td>
		<td><input class="whiteBackground" type="text" name="year" value="1997" size="4"/></td>
	      </tr>
	      <tr>
		<td>month</td>
		<td><input class="whiteBackground" type="text" name="month" value="5" size="2"/></td>
	      </tr>
	      <tr>
		<td>day</td>
		<td><input class="whiteBackground" type="text" name="day" value="21" size="2"/></td>
	      </tr>
	      <tr>
		<td>hour</td>
		<td><input class="whiteBackground" type="text" name="hour" value="12" size="2"/></td>
	      </tr>
	      <tr>
		<td>minute</td>
		<td><input class="whiteBackground" type="text" name="minute" value="12" size="2"/></td>
	      </tr>
	      <tr>
		<td>second</td>
		<td><input class="whiteBackground" type="text" name="second" value="12" size="2"/></td>
	      </tr>
	    </table>
	  </td>
	</tr>
	<tr>
	  <td>useCompilingProcessor</td>
	  <td>
	  	<input type="checkbox" name="useCompilingProcessor" value="true" onClick="toggleStylesheet();"/>
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
