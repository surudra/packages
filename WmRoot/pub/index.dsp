
%invoke wm.server.ui:mainMenu%

<HTML>
   <TITLE>%value $host% - webMethods Integration Server</TITLE>
   <!-- MASTER FRAMESET -->
   <FRAMESET  rows="55,*"  border="0"  framespacing="0"  spacing="0"
   frameborder="0">
   <FRAME  src="top.dsp"
   marginwidth="0"  marginheight="0"  border="0"  name="topmenu" scrolling="no" noresize>
   <FRAMESET  cols="215,*"  border="0"  framespacing="0"  spacing="0"
   frameborder="0">
   <FRAME  src="menu.dsp"  marginwidth="0"
   marginheight="0"  name="menu" scrolling="yes" noresize>
   <FRAME src="stats-general.dsp"  marginwidth="0"  marginheight="0"
   name="body">
   </FRAMESET>
   </FRAMESET>
   <!-- END of FRAMESET -->
   <NOFRAMES>
   <BODY>
	<BLOCKQUOTE>
      <H4>
      Your browser does not support frames.  Support for frames is required to use the webMethods Integration Server interface.
      </H4>
    </BLOCKQUOTE>
   </BODY>
   </NOFRAMES>
</HTML>

%onerror%

<html>
	<head>
		<title>Access Denied</title>
	</head>
  <body>
   	Access Denied.
   	<br>
   	<br>
      Services necessary to show the Integration Server Administrator are currently unavailable on this 
      port.  This is most likely due to port security restrictions.
   	<br>
   	<br>
      If this is the only port available to access the Integration Server, contact webMethods Support.
   </body>
</html>

%endinvoke%