<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<title>webMethods Deployer - Target Configuration</title>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<SCRIPT src="webMethods.js"></SCRIPT>
</HEAD>
<script type="text/javascript">
var srcvarSubTop = "";
var srcvarSubBottom = "";
function setFrame()
{
if(is_csrf_guard_enabled && needToInsertToken) {
   srcvarSubTop="varsub-list.dsp?projectName=%value projectName%&bundleName=%value bundleName%&mapSetName=%value mapSetName%&serverAlias=%value serverAlias%"+ '&' + _csrfTokenNm_ + "=" + _csrfTokenVal_;
   srcvarSubBottom="blank.html";   
} 
else {
   srcvarSubTop="varsub-list.dsp?projectName=%value projectName%&bundleName=%value bundleName%&mapSetName=%value mapSetName%&serverAlias=%value serverAlias%";
   srcvarSubBottom="blank.html";
}
document.getElementsByName("varSubTop")[0].src=srcvarSubTop;
document.getElementsByName("varSubBottom")[0].src=srcvarSubBottom;
}
</script>
<FRAMESET rows="50%,*" borderColor="#758EBD" onload="setFrame()">
     
       <FRAME name="varSubTop" src="#"
       marginwidth="0" marginheight="0" scrolling="yes">
       <FRAME name="varSubBottom" src="#"
			 marginwidth="0" marginheight="0" scrolling="yes">

</FRAMESET>

  <noframes>
   	<p>This page requires frames, but your browser does not support them.</p>
  </noframes>
</HTML>

