<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<title>webMethods Deployer Package</title>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<SCRIPT src="webMethods.js"></SCRIPT>
</HEAD>

<script type="text/javascript">
function setFrame()
{
if(is_csrf_guard_enabled && needToInsertToken) {
   src="map-list.dsp?projectName=%value projectName%&projectType=%value projectType%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
} else {
   src="map-list.dsp?projectName=%value projectName%&projectType=%value projectType%";
}
document.getElementsByName("treeFrame")[0].src=src;
}
</script>

	<FRAMESET cols="50%,*" borderColor="#758EBD" onload="setFrame()">
		<FRAME name="treeFrame" src="#" 
			marginwidth="0" marginheight="0" scrolling="yes">

		<FRAME name="propertyFrame" marginWidth=0 marginHeight=0 
			scrolling=yes src="%ifvar url%%value url%%else%blank.html%endif%">
	</FRAMESET>

  <noframes>
   	<p>This page requires frames, but your browser does not support them.</p>
  </noframes>

</HTML>
