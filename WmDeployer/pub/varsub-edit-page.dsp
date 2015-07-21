<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<title>webMethods Deployer - Target Configuration</title>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<SCRIPT src="webMethods.js"></SCRIPT>
</HEAD>
<SCRIPT>
//alert("projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&service=%value service%&key=%value key%&varSubItemType=%value varSubItemType%&mode=asset");
var disablePortUI = false;
</SCRIPT>

<script type="text/javascript">
var srcVarSubBottom = "";
var srcVarSubTop = "";
function setFrameScheduleService()
{
if(is_csrf_guard_enabled && needToInsertToken) {
   srcVarSubTop="varsub-task-page.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&service=%value service%&key=%value key%&varSubItemType=%value varSubItemType%&pluginType=%value pluginType%&mode=assetListing"+ '&' + _csrfTokenNm_ + "=" + _csrfTokenVal_;
   srcVarSubBottom="list-target-servers.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&service=%value service%&key=%value key%&varSubItemType=%value varSubItemType%&pluginType=%value pluginType%&mode=edit&dspPage=varsub-task-page.dsp"+ '&' + _csrfTokenNm_ + "=" + _csrfTokenVal_;
     
} 
else {
   srcVarSubTop="varsub-task-page.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&service=%value service%&key=%value key%&varSubItemType=%value varSubItemType%&pluginType=%value pluginType%&mode=assetListing";
   srcVarSubBottom="list-target-servers.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&service=%value service%&key=%value key%&varSubItemType=%value varSubItemType%&pluginType=%value pluginType%&mode=edit&dspPage=varsub-task-page.dsp";
   srcPropertyFrame="blank.html";
}
document.getElementsByName("varSubTop")[0].src=srcVarSubTop;
document.getElementsByName("varSubBottom")[0].src=srcVarSubBottom;

}

 function setFramePort()
{
if(is_csrf_guard_enabled && needToInsertToken) {
  srcVarSubTop="varsub-port-page.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&service=%value service%&key=%value key%&varSubItemType=%value varSubItemType%&mode=assetListing"+ '&' + _csrfTokenNm_ + "=" + _csrfTokenVal_;
   srcVarSubBottom="list-target-servers.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&service=%value service%&key=%value key%&varSubItemType=%value varSubItemType%&pluginType=%value pluginType%&mode=edit&dspPage=varsub-port-page.dsp"+ '&' + _csrfTokenNm_ + "=" + _csrfTokenVal_;
     
} 
else {
   srcVarSubTop="varsub-port-page.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&service=%value service%&key=%value key%&varSubItemType=%value varSubItemType%&mode=assetListing";
   srcVarSubBottom="list-target-servers.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&service=%value service%&key=%value key%&varSubItemType=%value varSubItemType%&pluginType=%value pluginType%&mode=edit&dspPage=varsub-port-page.dsp";
   
}
document.getElementsByName("varSubTop")[0].src=srcVarSubTop;
document.getElementsByName("varSubBottom")[0].src=srcVarSubBottom;

}

function setFrameWSD()
{
   if(is_csrf_guard_enabled && needToInsertToken) {
   srcVarSubTop="varsub-wsd-page.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&service=%value service%&key=%value key%&varSubItemType=%value varSubItemType%&pluginType=%value pluginType%&packageName=%value packageName%&mode=assetListing"+ '&' + _csrfTokenNm_ + "=" + _csrfTokenVal_;
   srcVarSubBottom="list-target-servers.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&service=%value service%&key=%value key%&varSubItemType=%value varSubItemType%&pluginType=%value pluginType%&packageName=%value packageName%&mode=edit&dspPage=varsub-notification-page.dsp"+ '&' + _csrfTokenNm_ + "=" + _csrfTokenVal_;
} 
else {
srcVarSubTop="varsub-wsd-page.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&service=%value service%&key=%value key%&varSubItemType=%value varSubItemType%&pluginType=%value pluginType%&packageName=%value packageName%&mode=assetListing";
srcVarSubBottom="list-target-servers.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&service=%value service%&key=%value key%&varSubItemType=%value varSubItemType%&pluginType=%value pluginType%&packageName=%value packageName%&mode=edit&dspPage=varsub-notification-page.dsp";
   
}
document.getElementsByName("varSubTop")[0].src=srcVarSubTop;
document.getElementsByName("varSubBottom")[0].src=srcVarSubBottom;
}

function setFrameExtendedSettings()
{
   if(is_csrf_guard_enabled && needToInsertToken) {
   srcVarSubTop="varsub-setting-page.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&key=%value key%&varSubItemType=%value varSubItemType%&mode=assetListing"+ '&' + _csrfTokenNm_ + "=" + _csrfTokenVal_;
   srcVarSubBottom="list-target-servers.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&key=%value key%&varSubItemType=%value varSubItemType%&pluginType=%value pluginType%&mode=edit&dspPage=varsub-setting-page.dsp"+ '&' + _csrfTokenNm_ + "=" + _csrfTokenVal_;
     
} 
else {
   srcVarSubTop="varsub-setting-page.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&key=%value key%&varSubItemType=%value varSubItemType%&mode=assetListing";
   srcVarSubBottom="list-target-servers.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&key=%value key%&varSubItemType=%value varSubItemType%&pluginType=%value pluginType%&mode=edit&dspPage=varsub-setting-page.dsp";
   
}
document.getElementsByName("varSubTop")[0].src=srcVarSubTop;
document.getElementsByName("varSubBottom")[0].src=srcVarSubBottom;
}

function setFrameAdapterConnection() {

if(is_csrf_guard_enabled && needToInsertToken) {
   
srcVarSubTop="varsub-connection-page.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&service=%value service%&key=%value key%&varSubItemType=%value varSubItemType%&pluginType=%value pluginType%&packageName=%value packageName%&mode=assetListing"+ '&' + _csrfTokenNm_ + "=" + _csrfTokenVal_;
srcVarSubBottom="list-target-servers.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&service=%value service%&key=%value key%&varSubItemType=%value varSubItemType%&packageName=%value packageName%&pluginType=%value pluginType%&mode=edit&type=AdapterConnection&dspPage=varsub-connection-page.dsp"+ '&' + _csrfTokenNm_ + "=" + _csrfTokenVal_;
     
} 
else {

  srcVarSubTop="varsub-connection-page.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&service=%value service%&key=%value key%&varSubItemType=%value varSubItemType%&pluginType=%value pluginType%&packageName=%value packageName%&mode=assetListing";
  
   srcVarSubBottom="list-target-servers.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&service=%value service%&key=%value key%&varSubItemType=%value varSubItemType%&packageName=%value packageName%&pluginType=%value pluginType%&mode=edit&type=AdapterConnection&dspPage=varsub-connection-page.dsp";
   
}
document.getElementsByName("varSubTop")[0].src=srcVarSubTop;
document.getElementsByName("varSubBottom")[0].src=srcVarSubBottom;

}

function setFrameAdapterNotification() {

  if(is_csrf_guard_enabled && needToInsertToken) {
   srcVarSubTop="varsub-notification-page.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&service=%value service%&key=%value key%&varSubItemType=%value varSubItemType%&pluginType=%value pluginType%&packageName=%value packageName%&mode=assetListing"+ '&' + _csrfTokenNm_ + "=" + _csrfTokenVal_;
   srcVarSubBottom="list-target-servers.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&service=%value service%&key=%value key%&varSubItemType=%value varSubItemType%&pluginType=%value pluginType%&packageName=%value packageName%&mode=edit&dspPage=varsub-notification-page.dsp"+ '&' + _csrfTokenNm_ + "=" + _csrfTokenVal_;
     
} 
else {
   srcVarSubTop="varsub-notification-page.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&service=%value service%&key=%value key%&varSubItemType=%value varSubItemType%&pluginType=%value pluginType%&packageName=%value packageName%&mode=assetListing";
   srcVarSubBottom="list-target-servers.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&service=%value service%&key=%value key%&varSubItemType=%value varSubItemType%&pluginType=%value pluginType%&packageName=%value packageName%&mode=edit&dspPage=varsub-notification-page.dsp";
   
}
document.getElementsByName("varSubTop")[0].src=srcVarSubTop;
document.getElementsByName("varSubBottom")[0].src=srcVarSubBottom;

}

function setFrameAdapterListener(){

 if(is_csrf_guard_enabled && needToInsertToken) {
  srcVarSubTop="varsub-listener-page.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&service=%value service%&key=%value key%&varSubItemType=%value varSubItemType%&pluginType=%value pluginType%&packageName=%value packageName%&mode=assetListing"+ '&' + _csrfTokenNm_ + "=" + _csrfTokenVal_;
   srcVarSubBottom="list-target-servers.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&service=%value service%&key=%value key%&varSubItemType=%value varSubItemType%&pluginType=%value pluginType%&packageName=%value packageName%&mode=edit&dspPage=varsub-notification-page.dsp"+ '&' + _csrfTokenNm_ + "=" + _csrfTokenVal_;
} 
else {
   srcVarSubTop="varsub-listener-page.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&service=%value service%&key=%value key%&varSubItemType=%value varSubItemType%&pluginType=%value pluginType%&packageName=%value packageName%&mode=assetListing";
   srcVarSubBottom="list-target-servers.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&service=%value service%&key=%value key%&varSubItemType=%value varSubItemType%&pluginType=%value pluginType%&packageName=%value packageName%&mode=edit&dspPage=varsub-notification-page.dsp";
   
}
document.getElementsByName("varSubTop")[0].src=srcVarSubTop;
document.getElementsByName("varSubBottom")[0].src=srcVarSubBottom;

}

function setFramevarSubFrame() {

  if(is_csrf_guard_enabled && needToInsertToken) {
   srcVarSubTop="varsub-plugin-page.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&key=%value key%&pluginType=%value pluginType%&varSubItemType=%value varSubItemType%&mode=assetListing"+ '&' + _csrfTokenNm_ + "=" + _csrfTokenVal_;
   srcVarSubBottom="list-target-servers.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&key=%value key%&pluginType=%value pluginType%&varSubItemType=%value varSubItemType%&pluginType=%value pluginType%&mode=edit&dspPage=varsub-plugin-page.dsp"+ '&' + _csrfTokenNm_ + "=" + _csrfTokenVal_;
} 
else {
   srcVarSubTop="varsub-plugin-page.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&key=%value key%&pluginType=%value pluginType%&varSubItemType=%value varSubItemType%&mode=assetListing";
   srcVarSubBottom="list-target-servers.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&key=%value key%&pluginType=%value pluginType%&varSubItemType=%value varSubItemType%&pluginType=%value pluginType%&mode=edit&dspPage=varsub-plugin-page.dsp";
}
document.getElementsByName("varSubTop")[0].src=srcVarSubTop
document.getElementsByName("varSubBottom")[0].src=srcVarSubBottom;
}

</script>

%switch varSubItemType%
%case 'ScheduledService'%
<FRAMESET ID="varSubFrame" rows="50%,*" borderColor="#758EBD" onload="setFrameScheduleService()">
		<FRAME name="varSubTop" 
			src="#" marginwidth="0" marginheight="0" scrolling="yes">

		<FRAME name="varSubBottom" 
			src="#" marginwidth="0" marginheight="0" scrolling="yes">

	</FRAMESET>

%case 'Port'%
<FRAMESET ID="varSubFrame" rows="50%,*" borderColor="#758EBD" onload="setFramePort()">
		<FRAME name="varSubTop" 
			src="#" marginwidth="0" marginheight="0" scrolling="yes">

		<FRAME name="varSubBottom" 
			src="#" marginwidth="0" marginheight="0" scrolling="yes">

	</FRAMESET>

%case 'ExtendedSettings'%
<FRAMESET ID="varSubFrame" rows="50%,*" borderColor="#758EBD" onload="setFrameExtendedSettings()">
		<FRAME name="varSubTop" 
			src="#" marginwidth="0" marginheight="0" scrolling="yes">

		<FRAME name="varSubBottom" 
			src="#" marginwidth="0" marginheight="0" scrolling="yes">

	</FRAMESET>

%case 'AdapterConnection'%
<FRAMESET ID="varSubFrame" rows="50%,*" borderColor="#758EBD" onload="setFrameAdapterConnection()">
		<FRAME name="varSubTop" 
			src="#" marginwidth="0" marginheight="0" scrolling="yes">

		<FRAME name="varSubBottom" 
			src="#" marginwidth="0" marginheight="0" scrolling="yes">

	</FRAMESET>

%case 'AdapterNotification'%
<FRAMESET ID="varSubFrame" rows="50%,*" borderColor="#758EBD" onload="setFrameAdapterNotification()">
		<FRAME name="varSubTop" 
			src="#" marginwidth="0" marginheight="0" scrolling="yes">

		<FRAME name="varSubBottom" 
			src="#" marginwidth="0" marginheight="0" scrolling="yes">

	</FRAMESET>

%case 'webServiceDescriptor'%
<FRAMESET ID="varSubFrame" rows="50%,*" borderColor="#758EBD" onload="setFrameWSD()">
		<FRAME name="varSubTop" 
			src="#" marginwidth="0" marginheight="0" scrolling="yes">

		<FRAME name="varSubBottom" 
			src="#" marginwidth="0" marginheight="0" scrolling="yes">

	</FRAMESET>

%case 'AdapterListener'%
<FRAMESET ID="varSubFrame" rows="50%,*" borderColor="#758EBD" onload=setFrameAdapterListener()>
		<FRAME name="varSubTop" 
			src="#" marginwidth="0" marginheight="0" scrolling="yes">

		<FRAME name="varSubBottom" 
			src="#" marginwidth="0" marginheight="0" scrolling="yes">

	</FRAMESET>	
	
%case%
<FRAMESET ID="varSubFrame" rows="50%,*" borderColor="#758EBD" onload="setFramevarSubFrame()">
		<FRAME name="varSubTop" 
			src="#" marginwidth="0" marginheight="0" scrolling="yes">

		<FRAME name="varSubBottom" 
			src="#" marginwidth="0" marginheight="0" scrolling="yes">

	</FRAMESET>

%endswitch%

  <noframes>
   	<p>This page requires frames, but your browser does not support them.</p>
  </noframes>
</FRAMESET>
</HTML>
