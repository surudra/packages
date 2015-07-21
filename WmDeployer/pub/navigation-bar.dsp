<LINK href="cb2.css" type="text/css" rel="stylesheet">
<SCRIPT src="cb2.js"></SCRIPT>
<!--Start: Anurag TraxId # 1-RNADG-->
<script>
function onPressDefinex(){
	document.getElementById("definex").style.backgroundColor="#C1C1C1"
	document.getElementById("definex").style.borderTop="1px solid buttonshadow"
	document.getElementById("definex").style.borderLeft="1px solid buttonshadow"
	document.getElementById("definex").style.borderBottom="1px solid buttonhighlight"
	document.getElementById("definex").style.borderRight="1px solid buttonhighlight"
}
function onPressReleasex(){
	document.getElementById("releasex").style.backgroundColor="#C1C1C1"
	document.getElementById("releasex").style.borderTop="1px solid buttonshadow"
	document.getElementById("releasex").style.borderLeft="1px solid buttonshadow"
	document.getElementById("releasex").style.borderBottom="1px solid buttonhighlight"
	document.getElementById("releasex").style.borderRight="1px solid buttonhighlight"
}
function onPressMapx(){
	document.getElementById("mapx").style.backgroundColor="#C1C1C1"
	document.getElementById("mapx").style.borderTop="1px solid buttonshadow"
	document.getElementById("mapx").style.borderLeft="1px solid buttonshadow"
	document.getElementById("mapx").style.borderBottom="1px solid buttonhighlight"
	document.getElementById("mapx").style.borderRight="1px solid buttonhighlight"
}
function onPressDeployx(){
	document.getElementById("deployx").style.backgroundColor="#C1C1C1"
	document.getElementById("deployx").style.borderTop="1px solid buttonshadow"
	document.getElementById("deployx").style.borderLeft="1px solid buttonshadow"
	document.getElementById("deployx").style.borderBottom="1px solid buttonhighlight"
	document.getElementById("deployx").style.borderRight="1px solid buttonhighlight"
}
</script>
<!--End: Anurag TraxId # 1-RNADG-->
<TR>
	<TD width="25%" align="middle" id="definex" onclick="onPressDefinex()"> 
		<A ID="bundle-list" class="imagelink" target="rightFrame" href="define.dsp?projectName=%value -htmlcode projectName%">
			<IMG align="center" ID="define" src="images/define.gif" border="0" width="20" height="20"
				alt="Define the project by identifying assets to deploy">Define</A> <!-- Anurag TraxId # 1-RNADG : changed "</A>Define" to "Define</A>"-->
	</TD>
	<script> 
		var foo = createButton(document.getElementById("definex"), "nav"); 
		foo.setAlwaysUp(true);
		foo.setToggle(true);
	</script>

	<TD width="25%" align="middle" id="releasex" onclick="onPressReleasex()"> 
		<A ID="release-list" class="imagelink" target="rightFrame" href="release.dsp?projectName=%value -htmlcode projectName%">
			<IMG align="middle" ID="build" src="images/build.gif" border="0" width="16" height="16"
				alt="Build a snapshot of the project to deploy">Build</A> <!-- Anurag TraxId # 1-RNADG : changed "</A>Build" to "Build</A>"-->
	</TD>
	<script> 
		var foo = createButton(document.getElementById("releasex"), "nav"); 
		foo.setAlwaysUp(true);
		foo.setToggle(true);
	</script>

	<TD width="25%" align="middle" id="mapx" onclick="onPressMapx()">
		<A ID="map-list" class="imagelink" target="rightFrame" href="mapset.dsp?projectName=%value -htmlcode projectName%">
			<IMG align="middle" ID="map" src="images/map_transformer.gif" border="0" width="20" height="20"
				alt="Map the project to target Integration Servers">Map</A> <!-- Anurag TraxId # 1-RNADG : changed "</A>Map" to "Map</A>"-->
	</TD>
	<script> 
		var foo = createButton(document.getElementById("mapx"), "nav"); 
		foo.setAlwaysUp(true);
		foo.setToggle(true);
	</script>

	<TD width="25%" align="middle" id="deployx" onclick="onPressDeployx()">
		<A ID="deploy-list" class="imagelink" target="rightFrame" href="deploy.dsp?projectName=%value -htmlcode projectName%">
			<IMG align="middle" ID="deploy" src="images/deploy.gif" border="0" width="18" height="18"
				alt="Deploy a project build to mapped target Integration Servers">Deploy</A> <!-- Anurag TraxId # 1-RNADG : changed "</A>Deploy" to "Deploy</A>"-->
	</TD>
	<script> 
		var foo = createButton(document.getElementById("deployx"), "nav"); 
		foo.setAlwaysUp(true);
		foo.setToggle(true);
	</script>
</TR>
