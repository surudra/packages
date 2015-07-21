<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:key name="depSets" match="Report/messages/message" use="attributes/set/@name"/>
<xsl:key name="servers" match="Report/messages/message" use="concat(attributes/set/@name, '+', attributes/targetserver/@name,'+', attributes/sourceserver/@name)"/>

<xsl:template match="/">

<xsl:variable name="repType"> 
       <xsl:value-of select="Report/@type" />
</xsl:variable>

<xsl:variable name="serverType" select="sourceserver"/> 

<HTML>
<xsl:choose>
    <xsl:when test="$repType = 'Deploy'">
       <TITLE>webMethods Deployer Deployment Report</TITLE>
    </xsl:when>
     <xsl:when test="$repType = 'Build'">
       	 <TITLE>webMethods Deployer Build Report</TITLE>
    </xsl:when>
     <xsl:when test="$repType = 'Simulate'">
       	 <TITLE>webMethods Deployer Simulate Report</TITLE>
    </xsl:when>  
    <xsl:when test="$repType = 'Checkpoint'">
       	 <TITLE>webMethods Deployer Checkpoint Report</TITLE>
    </xsl:when>
  <xsl:otherwise>
        <TITLE>webMethods Deployer Rollback Report</TITLE>
  </xsl:otherwise>
</xsl:choose>
<BODY>
<xsl:choose>
    <xsl:when test="$repType = 'Deploy'">
       <H1><CENTER>Deployment Report</CENTER></H1><BR/>
    </xsl:when>
     <xsl:when test="$repType = 'Simulate'">
       <H1><CENTER>Simulation Report (No changes have been made to the target)</CENTER></H1><BR/>
       <HR width="100%"/>
       <H1><B><FONT size="5">Disclaimer</FONT></B></H1>
	The simulation report does not contain an exhaustive list of 
	potential deployment concerns. Some items, such as issues relating 
	to the synchronization of deployed Publishable Document Types, cannot 
	be identified until you actually deploy.	
    </xsl:when>
     <xsl:when test="$repType = 'Build'">
       <H1><CENTER>Build Report</CENTER></H1><BR/>
    </xsl:when>
     <xsl:when test="$repType = 'Checkpoint'">
       <H1><CENTER>Checkpoint Report</CENTER></H1><BR/>
    </xsl:when>
  <xsl:otherwise>
       <H1><CENTER>Rollback Report</CENTER></H1><BR/>
  </xsl:otherwise>
</xsl:choose>


<HR width="100%"/>
<H1><B><FONT size="5">Overview</FONT></B></H1>
<TABLE border="1" width="42%">
  <TR>
    <TD width="22%" bgcolor="#E0E0C0"><B>Start of Build</B></TD>
    <TD width="78%" bgcolor="#E0E0C0"><xsl:value-of select="Report/startTime"/></TD>
  </TR>
  <TR>
    <TD width="22%" bgcolor="#F0F0E0"><B>Project Name</B></TD>
    <TD width="78%" bgcolor="#F0F0E0"><xsl:value-of select="Report/projectName"/></TD>
  </TR>
  <TR>
    <TD width="22%" bgcolor="#F0F0E0"><B>Project Description</B></TD>
    <TD width="78%" bgcolor="#F0F0E0"><xsl:value-of select="Report/projectDescription"/></TD>
  </TR>
  <TR>
	<xsl:choose>
	    <xsl:when test="$repType = 'Deploy'">
		<TD width="22%" bgcolor="#F0F0E0"><B>Deployed By</B></TD>
	    </xsl:when>
	     <xsl:when test="$repType = 'Simulate'">
		<TD width="22%" bgcolor="#F0F0E0"><B>Simulated By</B></TD>
	    </xsl:when>
	     <xsl:when test="$repType = 'Build'">
		<TD width="22%" bgcolor="#F0F0E0"><B>Built By</B></TD>
	    </xsl:when>
	     <xsl:when test="$repType = 'Checkpoint'">
		<TD width="22%" bgcolor="#F0F0E0"><B>Checkpoint taken By</B></TD>
	    </xsl:when>
	  <xsl:otherwise>
		<TD width="22%" bgcolor="#F0F0E0"><B>Rolledback By</B></TD>
	  </xsl:otherwise>
	</xsl:choose>
    <TD width="78%" bgcolor="#F0F0E0"><xsl:value-of select="Report/user"/></TD>
  </TR>
  <xsl:variable name="buildName"><xsl:value-of select='Report/buildName'/></xsl:variable>
  <xsl:if test="not ($buildName = '') ">
	  <TR>
		<TD width="22%" bgcolor="#F0F0E0"><B>Build Name</B></TD>
		<TD width="78%" bgcolor="#F0F0E0"><xsl:value-of select='$buildName'/></TD>
	  </TR>
</xsl:if>

<xsl:if test="not ($repType = 'Build') ">
  <TR>
    <TD width="22%" bgcolor="#F0F0E0"><B>Deployment Map Name</B></TD>
    <TD width="78%" bgcolor="#F0F0E0"><xsl:value-of select="Report/depCandidate"/></TD>
  </TR>
</xsl:if>
</TABLE>     
    
<HR width="100%"/>
<xsl:for-each select="Report/messages/message[count(. | key('servers', concat(attributes/set/@name, '+', attributes/targetserver/@name,'+', attributes/sourceserver/@name))[1]) = 1]">
		<P align="left"><B><FONT size="5">Deployment Set:<xsl:value-of select="attributes/set/@name" /></FONT></B></P>
		<TABLE border="1" width="99%">
		      <TR>
			<TD colspan="3" bgcolor="#E0E0C0">
				<xsl:choose>
				     <xsl:when test="$repType = 'Build'">
					  <P align="center"><B><FONT size="5">Source Server: <xsl:value-of select="attributes/sourceserver/@name" /></FONT></B></P>
				    </xsl:when>
				  <xsl:otherwise>
					  <P align="center"><B><FONT size="5">Target Server: <xsl:value-of select="attributes/targetserver/@name" /></FONT></B></P>
				  </xsl:otherwise>
				</xsl:choose>
			</TD>
		      </TR>

		  <xsl:for-each select="key('servers', concat(attributes/set/@name, '+', attributes/targetserver/@name,'+', attributes/sourceserver/@name))">		      
			    <xsl:variable name="type"> 
			       <xsl:value-of select="@type"/>
			     </xsl:variable>
			     
                          
			  <xsl:if test="not ($type = '')">
			      <TR>
			     <xsl:choose>
			     <xsl:when test="$type = 'WARNING'">
			     	 <TD width="17%" bgcolor="#FFFFCC"><xsl:value-of select="@timeStamp"/></TD>					  
				     <TD width="17%" bgcolor="#FFFFCC"><xsl:value-of select="@type"/></TD>
				     <TD width="66%" bgcolor="#FFFFCC"><xsl:value-of select="messagebody"/></TD>
			    </xsl:when>
			     <xsl:when test="$type = 'ERROR'">
			    <TD width="17%" bgcolor="#FFE5E9"><xsl:value-of select="@timeStamp"/></TD>			        	
				<TD width="17%" bgcolor="#FFE5E9"><xsl:value-of select="@type"/></TD>
				<TD width="66%" bgcolor="#FFE5E9"><xsl:value-of select="messagebody"/></TD>
			     </xsl:when>
			     <xsl:when test="$type = 'MESSAGE'">
			    <TD width="17%" bgcolor="#F0F0E0"><xsl:value-of select="@timeStamp"/></TD>			        	
				<TD width="17%" bgcolor="#F0F0E0"><xsl:value-of select="@type"/></TD>
				<TD width="66%" bgcolor="#F0F0E0"><xsl:value-of select="messagebody"/></TD>
			     </xsl:when>
                          <xsl:otherwise>
			       <TD width="17%" bgcolor="#E5FFE9"><xsl:value-of select="@timeStamp"/></TD>
			       <TD width="17%" bgcolor="#E5FFE9"><xsl:value-of select="@type"/></TD>
			       <TD width="66%" bgcolor="#E5FFE9"><xsl:value-of select="messagebody"/></TD>
                          </xsl:otherwise>
                        </xsl:choose>
				
				
			      </TR> 
			    </xsl:if>
		   </xsl:for-each>
		</TABLE>
</xsl:for-each>


<BR/>
<BR/><BR/><HR WIDTH="100%"/>

<xsl:choose>
    <xsl:when test="$repType = 'Deploy'">
       <B>End of Deployment: </B><xsl:value-of select="Report/endTime"/><BR/>
    </xsl:when>
     <xsl:when test="$repType = 'Simulate'">
       <B>End of Simulation: </B><xsl:value-of select="Report/endTime"/><BR/>
    </xsl:when>
     <xsl:when test="$repType = 'Build'">
       <B>End of Build: </B><xsl:value-of select="Report/endTime"/><BR/>
    </xsl:when>
     <xsl:when test="$repType = 'Checkpoint'">
       <B>End of Checkpoint: </B><xsl:value-of select="Report/endTime"/><BR/>
    </xsl:when>
    <xsl:otherwise>
      <B>End of Rollback: </B><xsl:value-of select="Report/endTime"/><BR/>
    </xsl:otherwise>
</xsl:choose>

<HR WIDTH="100%"/>
</BODY>
</HTML>
</xsl:template>
</xsl:stylesheet>