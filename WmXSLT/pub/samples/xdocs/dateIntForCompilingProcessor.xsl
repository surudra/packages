<?xml version="1.0" ?>
<xsl:stylesheet version="1.1" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xsltc="http://xml.apache.org/xalan/xsltc"
		xmlns:IOutput="com.wm.pkg.xslt.extension.IOutputMap"
		xmlns:Date="java.util.Date"
		xmlns:IntDate="com.wm.pkg.xslt.samples.date.IntDate"
		exclude-result-prefixes="IOutput Date IntDate">

  <xsl:param name="output"/>
  <xsl:variable name="outputVariable" select="xsltc:cast('com.wm.pkg.xslt.extension.IOutputMap', $output)"/>
  <xsl:param name="year"/>
  <xsl:param name="month"/>
  <xsl:param name="day"/>
  <xsl:param name="hour"/>
  <xsl:param name="minute"/>
  <xsl:param name="second"/>
  <xsl:variable name="date" select="IntDate:getDate($year,$month,$day,$hour,$minute,$second)"/>
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

  <xsl:template match="date" >
    <xsl:value-of select="IOutput:put($outputVariable, 'year', $year)" />
    <xsl:value-of select="IOutput:put($outputVariable, 'month', $month)" />
    <xsl:value-of select="IOutput:put($outputVariable, 'day', $day)" />
    <xsl:value-of select="IOutput:put($outputVariable, 'hour', $hour)" />
    <xsl:value-of select="IOutput:put($outputVariable, 'minute', $minute)" />
    <xsl:value-of select="IOutput:put($outputVariable, 'second', $second)" />
    <xsl:value-of select="IOutput:put($outputVariable, 'date', $date)" />
    
    <xsl:text>
    
    </xsl:text>
    <xsl:text>year   : </xsl:text><xsl:value-of select="$year"/>
    <xsl:text>
    </xsl:text>
    <xsl:text>month  : </xsl:text><xsl:value-of select="$month"/>
    <xsl:text>
    </xsl:text>
    <xsl:text>day    : </xsl:text><xsl:value-of select="$day"/>
    <xsl:text>
    </xsl:text>
    <xsl:text>hour   : </xsl:text><xsl:value-of select="$hour"/>
    <xsl:text>
    </xsl:text>
    <xsl:text>minute : </xsl:text><xsl:value-of select="$minute"/>
    <xsl:text>
    </xsl:text>
    <xsl:text>second : </xsl:text><xsl:value-of select="$second"/>
    <xsl:text>
    
    </xsl:text>

    <xsl:text>converts to</xsl:text>
    <xsl:text>
    
    </xsl:text>

    <xsl:value-of select="Date:toString($date)"/>
  </xsl:template>

</xsl:stylesheet>