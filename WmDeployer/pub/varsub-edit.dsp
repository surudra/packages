<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<title>webMethods Deployer - Target Configuration</title>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<SCRIPT src="webMethods.js"></SCRIPT>
</HEAD>

%switch varSubItemType%
%case 'ScheduledService'%
<FRAMESET ID="varSubFrame" rows="50%,*" borderColor="#758EBD">
		<FRAME name="varSubTop" 
			src="varsub-task.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&targetServerAlias=%value targetServerAlias%&service=%value service%&key=%value key%&varSubItemType=%value varSubItemType%&mode=view" marginwidth="0" marginheight="0" scrolling="yes">

		<FRAME name="varSubBottom" 
			src="varsub-task.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&targetServerAlias=%value targetServerAlias%&service=%value service%&key=%value key%&varSubItemType=%value varSubItemType%&mode=edit" marginwidth="0" marginheight="0" scrolling="yes">

	</FRAMESET>

%case 'Port'%
<FRAMESET ID="varSubFrame" rows="50%,*" borderColor="#758EBD">
		<FRAME name="varSubTop" 
			src="varsub-port.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&targetServerAlias=%value targetServerAlias%&service=%value service%&key=%value key%&varSubItemType=%value varSubItemType%&mode=view" marginwidth="0" marginheight="0" scrolling="yes">

		<FRAME name="varSubBottom" 
			src="varsub-port.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&targetServerAlias=%value targetServerAlias%&service=%value service%&key=%value key%&varSubItemType=%value varSubItemType%&mode=edit" marginwidth="0" marginheight="0" scrolling="yes">

	</FRAMESET>

%case 'ExtendedSettings'%
<FRAMESET ID="varSubFrame" rows="50%,*" borderColor="#758EBD">
		<FRAME name="varSubTop" 
			src="varsub-setting.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&targetServerAlias=%value targetServerAlias%&key=%value key%&varSubItemType=%value varSubItemType%&mode=view" marginwidth="0" marginheight="0" scrolling="yes">

		<FRAME name="varSubBottom" 
			src="varsub-setting.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&targetServerAlias=%value targetServerAlias%&key=%value key%&varSubItemType=%value varSubItemType%&mode=edit" marginwidth="0" marginheight="0" scrolling="yes">

	</FRAMESET>

%case 'AdapterConnection'%
<FRAMESET ID="varSubFrame" rows="50%,*" borderColor="#758EBD">
		<FRAME name="varSubTop" 
			src="varsub-connection.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&targetServerAlias=%value targetServerAlias%&service=%value service%&key=%value key%&varSubItemType=%value varSubItemType%&packageName=%value packageName%&mode=view" marginwidth="0" marginheight="0" scrolling="yes">

		<FRAME name="varSubBottom" 
			src="varsub-connection.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&targetServerAlias=%value targetServerAlias%&service=%value service%&key=%value key%&varSubItemType=%value varSubItemType%&packageName=%value packageName%&mode=edit" marginwidth="0" marginheight="0" scrolling="yes">

	</FRAMESET>

%case 'AdapterNotification'%
<FRAMESET ID="varSubFrame" rows="50%,*" borderColor="#758EBD">
		<FRAME name="varSubTop" 
			src="varsub-notification.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&targetServerAlias=%value targetServerAlias%&service=%value service%&key=%value key%&varSubItemType=%value varSubItemType%&mode=view" marginwidth="0" marginheight="0" scrolling="yes">

		<FRAME name="varSubBottom" 
			src="varsub-notification.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&targetServerAlias=%value targetServerAlias%&service=%value service%&key=%value key%&varSubItemType=%value varSubItemType%&mode=edit" marginwidth="0" marginheight="0" scrolling="yes">

	</FRAMESET>

%case%
<FRAMESET ID="varSubFrame" rows="50%,*" borderColor="#758EBD">
		<FRAME name="varSubTop" 
			src="varsub-plugin.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&targetServerAlias=%value targetServerAlias%&key=%value key%&pluginType=%value pluginType%&varSubItemType=%value varSubItemType%&mode=view" marginwidth="0" marginheight="0" scrolling="yes">

		<FRAME name="varSubBottom" 
			src="varsub-plugin.dsp?projectName=%value projectName%&deploymentMapName=%value deploymentMapName%&deploymentSetName=%value deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&targetServerAlias=%value targetServerAlias%&key=%value key%&pluginType=%value pluginType%&varSubItemType=%value varSubItemType%&mode=edit" marginwidth="0" marginheight="0" scrolling="yes">

	</FRAMESET>

%endswitch%

  <noframes>
   	<p>This page requires frames, but your browser does not support them.</p>
  </noframes>
</FRAMESET>
</HTML>
