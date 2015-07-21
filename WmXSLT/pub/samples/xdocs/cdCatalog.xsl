<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output indent="yes" />
  <xsl:template match="/">
    <!--
  <html>
  <body>
  <xsl:message>Begin content.</xsl:message>
    -->
    <h2>CD Catalog</h2>
    <table>
      <tr>
	<td>Title</td>
	<td>Artist</td>
      </tr>
      <xsl:for-each select="catalog/cd">
	<tr>
	  <td>
	    <xsl:value-of select="title"/>
	  </td>
	  <td>
	    <xsl:value-of select="artist"/>
	  </td>
	</tr>
      </xsl:for-each>
    </table>
    <!--
  <xsl:message>End content.</xsl:message>
  </body>
  </html>
    -->
  </xsl:template>
</xsl:stylesheet>