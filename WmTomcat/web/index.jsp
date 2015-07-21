<!doctype html public "-//w3c//dtd html 4.0 transitional//en" "http://www.w3.org/TR/REC-html40/strict.dtd">
<%@ page session="false" %>
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <title><%= application.getServerInfo() %></title>
    <style type="text/css">
      <!--
        body {
            color: #000000;
            background-color: #FFFFFF;
            font-family: Arial, "Times New Roman", Times;
            font-size: 16px;
        }

        A:link {
            color: blue
        }

        A:visited {
            color: blue
        }

        td {
            color: #000000;
            font-family: Arial, "Times New Roman", Times;
            font-size: 16px;
        }

        .code {
            color: #000000;
            font-family: "Courier New", Courier;
            font-size: 16px;
        }
      -->
    </style>
</head>

<body>

<!-- Header -->
<table width="100%">
    <tr>
        <td align="left" width="130"><a href="http://tomcat.apache.org/">
        <img src="tomcat.gif" height="92" width="130" border="0" alt="The Mighty Tomcat - MEOW!"></td>
        <td align="left" valign="top">
            <table>
                <tr><td align="left" valign="top"><b><%= application.getServerInfo() %></b></td></tr>
            </table>
        </td>
        <td align="right"><a href="http://jakarta.apache.org/">
        <img src="jakarta-banner.gif" height="48" width="505" border="0" alt="The Jakarta Project"></a></td>
    </tr>
</table>

<br>

<table>
    <tr>

        <!-- Table of Contents -->
        <td valign="top">
            <br>
            <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolor="#000000">
                <tr>
                    <td bgcolor="#D2A41C" bordercolor="#000000" align="left" nowrap>
                        <font face="Verdana" size="+1"><i>Documentation</i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font>
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#FFDC75" bordercolor="#000000" nowrap>
                        <a href="RELEASE-NOTES.txt">Release Notes</a><br>
                        <a href="http://tomcat.apache.org/tomcat-6.0-doc/index.html">Tomcat Documentation</a><br>
                        &nbsp;
                    </td>
                </tr>
            </table>
            <br>
            <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolor="#000000">
                <tr>
                    <td bgcolor="#D2A41C" bordercolor="#000000" align="left" nowrap>
                        <font face="Verdana" size="+1"><i>Tomcat Online</i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font>
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#FFDC75" bordercolor="#000000" nowrap>
                        <a href="http://tomcat.apache.org/">Home Page</a><br>
                        <a href="http://tomcat.apache.org/bugreport.html">Bug Database</a><br>
                        <a href="http://tomcat.apache.org/faq/">FAQ</a><br>
                        <a href="http://tomcat.apache.org/lists.html">Mailing Lists</a><br>
                        &nbsp;
                    </td>
                </tr>
            </table>
            <br>
           
            <br>
            <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolor="#000000">
                <tr>
                    <td bgcolor="#D2A41C" bordercolor="#000000" align="left" nowrap>
                        <font face="Verdana" size="+1"><i>Miscellaneous</i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font>
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#FFDC75" bordercolor="#000000" nowrap>
                        <a href="http://java.sun.com/products/jsp">Sun's Java Server Pages Site</a><br>
                        <a href="http://java.sun.com/products/servlet">Sun's Servlet Site</a><br>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </td>

        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>

        <!-- Body -->
        <td align="left" valign="top">
            <p><center><b>If you are viewing this page via a Web browser, it means the embedded Tomcat
                          is successfully running in the webMethods Integration Server. 
                          <br>Congratulations!</b>
               </center>
            </p>

            <p>This is the default WmTomcat home page. It can be found on the local file system at: 
            <blockquote>
                &lt; IntegrationServer_directory &gt; /packages/WmTomcat/web/index.jsp
            </blockquote>
            </p>

            <p>where &lt; IntegrationServer_directory&gt; is the directory where the Integration Server is installed.
            <br>The following lists some information that applies to WmTomcat that is different than a typical Tomcat implementation:
            <ul>
               <li>Each <b>servlet context</b> always corresponds to exactly <b>one IS package</b>.
               <li>Store Web application files in the &lt; IntegrationServer_directory&gt;\packages\&lt;PackageName&gt;\web directory, 
                   where &lt;PackageName&gt; is the name of the package for the Web application.
               <li>Store <b>shared class files</b> in the &lt; IntegrationServer_directory&gt;\packages\WmTomcat\code\classes directory.    
               <li>Store <b>shared jar files</b> in the &lt; IntegrationServer_directory&gt;\packages\WmTomcat\code\jars directory.
               <li>The typical <b>Tomcat work, conf,</b> and <b>webapps</b> directories are in &lt; IntegrationServer_directory&gt;\web directory.
               <li>Tomcat internal, servlet and JSP messages all get directed to the <b>IS server log</b>.
               <li>The URL you use to invoke a Web application is <i>http://&lt;HostName&gt;:&lt;PortNumber&gt;<b>/web/&lt;PackageName&gt;/</b>&lt;FileName.jsp&gt; </i>
                   <br>where HostName is the host name of your Integration Server and PortNumber is the port number on which 
                   it listens for inbound HTTP requests.
               <li>To invoke an <b>IS service from a servlet</b>, invoke it directly, just like in Java Services.
               <li>To invoke an <b>IS service from a JSP</b>, you can use the webMethods JSP tag library or invoke it directly.

             </ul>
             
             For more information about using the WmTomcat package, see the <i>Web Applications Developer's Guide</i>.
             
             <p>For detailed Tomcat setup and administration information please see the 
                <a href="http://tomcat.apache.org/tomcat-6.0-doc/index.html">Tomcat Documentation</a> </p>

            <p>Tomcat mailing lists are available at the Jakarta project web site:</p>

           <ul>
               <li><b><a href="mailto:users@tomcat.apache.org">users@tomcat.apache.org</a></b> for general questions related to configuring and using Tomcat</li>
               <li><b><a href="mailto:dev@tomcat.apache.org">dev@tomcat.apache.org</a></b> for developers working on Tomcat</li>
           </ul>

            <p>Thanks for using WmTomcat!</p>

            <p align="right"><font size=-1><img src="tomcat-power.gif" width="77" height="80"></font><br>
            &nbsp;
            <font size=-1>Copyright &copy; 1999-2011 Apache Software Foundation</font><br>
            <font size=-1>All Rights Reserved</font> <br>
            &nbsp;</p>
            <p align="right">&nbsp;</p>
        </td>

    </tr>
</table>

</body>
</html>
