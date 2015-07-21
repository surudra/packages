<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<LINK href="xtree.css" type="text/css" rel="stylesheet">
<SCRIPT src="webMethods.js"></SCRIPT>
<SCRIPT src="xtree.js"></SCRIPT>

<script type="text/javascript">
var srcLeftFrame = "";
var srcMiddleFrame = "";
var srcRightFrame = "";

function setFrame()
{
if(is_csrf_guard_enabled && needToInsertToken) {
   srcLeftFrame="varsub-targetservers.dsp?projectName=%value projectName%&mapSetName=%value mapSetName%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
   srcMiddleFrame="varsub-composite.dsp?projectName=%value projectName%&mapSetName=%value mapSetName%&mapSetDescription=%value mapSetDescription%&pluginType=%value pluginType%&action=%value action%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
   srcRightFrame="varsub-component.dsp?" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
} else {
   srcLeftFrame="varsub-targetservers.dsp?projectName=%value projectName%&mapSetName=%value mapSetName%";
   srcMiddleFrame="varsub-composite.dsp?projectName=%value projectName%&mapSetName=%value mapSetName%&mapSetDescription=%value mapSetDescription%&pluginType=%value pluginType%&action=%value action%";
   srcRightFrame="varsub-component.dsp";
}
document.getElementsByName("leftFrame")[0].src=srcLeftFrame;
document.getElementsByName("middleFrame")[0].src=srcMiddleFrame;
document.getElementsByName("rightFrame")[0].src=srcRightFrame;
}
</script>

<FRAMESET cols="25%,40%,*" onload="setFrame()">

         <FRAME name="leftFrame" marginWidth=0 marginHeight=0 
			scrolling=yes src="#">
			
		<FRAME name="middleFrame" src="#" 
			marginwidth="0" marginheight="0" scrolling="auto">

		<FRAME name="rightFrame" marginWidth=0 marginHeight=0 
			scrolling=yes src="#">
		
</FRAMESET>

</HTML>
