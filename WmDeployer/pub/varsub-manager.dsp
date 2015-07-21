<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<title>webMethods Deployer Package</title>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<SCRIPT src="webMethods.js"></SCRIPT>
</HEAD>
<script type="text/javascript">
var srcTopFrame = "";
var srcBottomFrame = "";
function setFrame()
{
if(is_csrf_guard_enabled && needToInsertToken) {
   srcTopFrame="varsub-composite-manager.dsp?projectName=%value projectName%&mapSetName=%value mapSetName%&mapSetDescription=%value mapSetDescription%&pluginType=%value pluginType%&action=%value action%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
   srcBottomFrame="varsub-repoasset-page.dsp?projectName=%value projectName%&mapSetName=%value mapSetName%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
} else {
   srcTopFrame="varsub-composite-manager.dsp?projectName=%value projectName%&mapSetName=%value mapSetName%&mapSetDescription=%value mapSetDescription%&pluginType=%value pluginType%&action=%value action%";
   srcBottomFrame="varsub-repoasset-page.dsp?projectName=%value projectName%&mapSetName=%value mapSetName%";
}
document.getElementsByName("topFrame")[0].src=srcTopFrame;
document.getElementsByName("bottomFrame")[0].src=srcBottomFrame;
}
</script>

	<FRAMESET rows="65%,*" onload="setFrame()">
		<FRAME name="topFrame" src="#" 
			marginwidth="0" marginheight="0" scrolling="yes">

		<FRAME name="bottomFrame" marginWidth=0 marginHeight=0 
			scrolling=yes src="#">
	</FRAMESET>

  <noframes>
   	<p>This page requires frames, but your browser does not support them.</p>
  </noframes>

</HTML>