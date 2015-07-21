<?xml version="1.0" ?>
<xsl:stylesheet version="1.1" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:Date="java.util.Date"
		exclude-result-prefixes="Date">
  <!-- 
  Binding the extension functions to their respective Java implementations. 
  This is defined in the XSLT 1.1 spec (section 14.4). We do this
  to make the stylesheet more portable across all XSLT 1.1-compliant
  processors.
  <xsl:script implements-prefix="Date" language="java" src="java://java.util.Date" />
  -->

  <xsl:variable name="today" select="Date:new()"/>
  <xsl:output method="xml" indent="yes" />
  
  <xsl:template match="/" >
    <xsl:apply-templates />
  </xsl:template> 

  <!-- Default template. Just copies the element (with attributes) to the output. -->
  <xsl:template match="*">
    <xsl:element name="{name()}">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>

  <xsl:template match="date">
    <xsl:text>Today is: </xsl:text>
    <xsl:value-of select="Date:toString($today)"/>
  </xsl:template>

</xsl:stylesheet>