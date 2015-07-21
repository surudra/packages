<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<title>webMethods Deployer - %value serverAlias% > Configurable Assets</title>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<SCRIPT src="webMethods.js"></SCRIPT>
</HEAD>

<FRAMESET ID="topset" rows="40,*">
	<frame name="topbar" src="top.dsp" scrolling="no"
		frameborder="no" noresize MARGINHEIGHT="0" MARGINWIDTH="0">

	<FRAMESET cols="35%,*" borderColor="#758EBD">
		<FRAME name="treeFrame" 
			src="varsub-list.dsp?projectName=%value projectName%&bundleName=%value bundleName%&mapSetName=%value mapSetName%&serverAlias=%value serverAlias%" marginwidth="0" marginheight="0" scrolling="yes">

		<FRAME name="propertyFrame" marginWidth=0 marginHeight=0 
			scrolling=yes src="%ifvar url%%value url%%else%blank.html%endif%">
	</FRAMESET>

  <noframes>
   	<p>This page requires frames, but your browser does not support them.</p>
  </noframes>
</FRAMESET>

</HTML>
