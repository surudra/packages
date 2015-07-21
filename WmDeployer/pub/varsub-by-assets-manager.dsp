<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<title>webMethods Deployer Package</title>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<SCRIPT src="webMethods.js"></SCRIPT>
</HEAD>

   <script type="text/javascript">
var srcLeftFrame = "";
var srcPropertyFrame = "";
function setFrame()
{
if(is_csrf_guard_enabled && needToInsertToken) {
   srcLeftFrame="varsub-asset.dsp?projectName=%value projectName%&mapSetName=%value mapSetName%&mapSetDescription=%value mapSetDescription%&pluginType=%value pluginType%&action=%value action%"+ '&' + _csrfTokenNm_ + "=" + _csrfTokenVal_;
   srcPropertyFrame="blank.html";   
} 
else {
   srcLeftFrame="varsub-asset.dsp?projectName=%value projectName%&mapSetName=%value mapSetName%&mapSetDescription=%value mapSetDescription%&pluginType=%value pluginType%&action=%value action%";
   srcPropertyFrame="blank.html";
}
document.getElementsByName("leftFrame")[0].src=srcLeftFrame;
document.getElementsByName("propertyFrame")[0].src=srcPropertyFrame;
}
</script>

	<FRAMESET cols="40%,*" onload="setFrame()">
		<FRAME name="leftFrame" src="#" 
			marginwidth="0" marginheight="0" scrolling="yes">

		<FRAME name="propertyFrame" marginWidth=0 marginHeight=0 
			scrolling=yes src="#">
	</FRAMESET>

  <noframes>
   	<p>This page requires frames, but your browser does not support them.</p>
  </noframes>

</HTML>