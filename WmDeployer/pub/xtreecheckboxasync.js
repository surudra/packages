/*
 *	Sub class that adds a check box in front of the tree item icon and make it asynchronous.
 *
 *	Created by mosi in SoftwareAG.
 *
 *	Disclaimer:	This is not any official WebFX component.
 *
 *	Notice that you'll need to add a css rule the sets the size of the input box.
 *	Something like this will do fairly good in both Moz and IE
 *	
 *	input.tree-check-box {
 *		width:		auto;
 *		margin:		0;
 *		padding:	0;
 *		height:		14px;
 *		vertical-align:	middle;
 *	}
 *
 */
webFXTreeConfig.loadingText = "Loading...";

function WebFXCheckBoxAsyncTreeItem(sText,invocationSrc, xmlString, sFolder, sEnabled, sAction, bChecked, eParent, sIcon, sOpenIcon, sName, sValue, sClass, sId) {
	this.base = WebFXCheckBoxTreeItem;
	this.isEnabled = (sEnabled != null ? sEnabled: false);
	this.base(sText, sAction, bChecked, eParent, sIcon, sOpenIcon, sName, sValue, sClass, sId, this.isEnabled);
	this.icsrc = invocationSrc;
	this.folder = (sFolder != null ? sFolder: true);
	this.open=false;
	this.loading = false;
	this.loaded = false;
	this._xmlString = xmlString;
	this._finalTreePath = "";
	//this._loadingItem = new WebFXTreeItem(webFXTreeConfig.loadingText);
	this.errorText = "";
	if(invocationSrc != null){
		this._pluginType = invocationSrc.split("?")[1].split("&")[0].split("=")[1];
		this._serverAlias = invocationSrc.split("?")[1].split("&")[1].split("=")[1];
	}
	
}

WebFXCheckBoxAsyncTreeItem.prototype = new WebFXCheckBoxTreeItem;

WebFXCheckBoxAsyncTreeItem.prototype._webfxtreeitem_expand = WebFXCheckBoxTreeItem.prototype.expand;
WebFXCheckBoxAsyncTreeItem.prototype.expand = function() {
	if (this.folder) {
		this.setNodeEnabled();
		if (!this.loaded && !this.loading) {			
			_startACall(this.icsrc, this._xmlString, this);
		}
		else {		
			this._webfxtreeitem_expand();
		}
	}
};

WebFXCheckBoxAsyncTreeItem.prototype.setNodeEnabled = function () {
	var divEl = document.getElementById(this.id);
	var inputEl = divEl.getElementsByTagName("INPUT")[0];
	if (inputEl.disabled == true){		
		inputEl.disabled = false;
		this._enabled = true;
	}
};

function _startACall(sSrc, xmlString, jsNode) {
	if(sSrc == null)
		return;
	if (jsNode.loading || jsNode.loaded)
		return;
	jsNode.loading = true;
	try {
	var xmlHttp;
	if (window.XMLHttpRequest) {
		xmlHttp = new XMLHttpRequest();
	}
	if (window.ActiveXObject) {
		xmlHttp =  new ActiveXObject("Microsoft.XMLHTTP");
	}
	
	if(xmlString != null){
		xmlHttp.setRequestHeader("Content-Type", "text/xml; charset=UTF-8");
	}

	xmlHttp.open("GET", sSrc, false);
	xmlHttp.setRequestHeader("Accept", "text/xml");
	xmlHttp.onreadystatechange = function () {
		if (xmlHttp.readyState == 4) {			
			_processXMLResponse(xmlHttp.responseXML, jsNode);
			//jsNode._loadingItem.remove();
			jsNode.loaded = true;
			jsNode._webfxtreeitem_expand();
		}
	};
	if(xmlString == null){
		xmlHttp.send(null);
	}
	else {
		xmlHttp.send(xmlString);
	}

	
	}
	catch(ex){
		alert(ex.message);
	}
}

function _processXMLResponse(oXmlDoc, jsNode) {
	if( oXmlDoc == null || oXmlDoc.documentElement == null) {
		return;
	}
	else {
		var bIndent = false;
		var root = oXmlDoc.documentElement;
		var cs = root.childNodes;
		var l = cs.length;
		if(root.nodeName == "errorMessage"){
			jsNode.errorText = root.firstChild.nodeValue;
		}
		for (var i = 0; i < l; i++) {			
			if (cs[i].tagName == "assets") {
				bIndent = true;
				var subs = cs[i].childNodes;
				var k = subs.length;
				var type = "";
				var id = "";
				var name = "";
				var hasChildren = "";
				var fullName = "null";
				var compositeName = "null";
				var compositeType = "null";
				var assetPath = "null";
				var parentId = "null";
				var status = "null";
							
				for (var m = 0; m < k; m++) {
					if(subs[m].tagName == "type"){
						if(navigator.userAgent.indexOf("MSIE")!=-1){
							type = subs[m].text;	
						}
						else {
							type = subs[m].textContent;				
						}
					}
					else if(subs[m].tagName == "id"){
						if(navigator.userAgent.indexOf("MSIE")!=-1){
							id = subs[m].text;
						}
						else {
							id = subs[m].textContent;	
						}
					}
					else if(subs[m].tagName == "name"){
						if(navigator.userAgent.indexOf("MSIE")!=-1){
							name = subs[m].text;	
						}
						else {							
							name = subs[m].textContent;	
						}
					}
					else if(subs[m].tagName == "hasChildren"){
						if(navigator.userAgent.indexOf("MSIE")!=-1){
							hasChildren = subs[m].text;
						}
						else {
							hasChildren = subs[m].textContent;
						}
					}
					else if(subs[m].tagName == "fullName"){
						if(navigator.userAgent.indexOf("MSIE")!=-1){
							fullName = subs[m].text;
						}
						else {
							fullName = subs[m].textContent;
						}
					}
					else if(subs[m].tagName == "compositeName"){
						if(navigator.userAgent.indexOf("MSIE")!=-1){
							compositeName = subs[m].text;
						}
						else {
							compositeName = subs[m].textContent;
						}
					}
					else if(subs[m].tagName == "compositeType"){
						if(navigator.userAgent.indexOf("MSIE")!=-1){
							compositeType = subs[m].text;
						}
						else {
							compositeType = subs[m].textContent;
						}
					}
					else if(subs[m].tagName == "parentId"){
						if(navigator.userAgent.indexOf("MSIE")!=-1){
							parentId = subs[m].text;
						}
						else {
							parentId = subs[m].textContent;
						}
					}
					else if(subs[m].tagName == "path"){
						if(navigator.userAgent.indexOf("MSIE")!=-1){
							assetPath = subs[m].text;
						}
						else {
							assetPath = subs[m].textContent;
						}
					}
					else if(subs[m].tagName == "status"){
						if(navigator.userAgent.indexOf("MSIE")!=-1){
							status = subs[m].text;
						}
						else {
							status = subs[m].textContent;
						}
					}
				}
				if(k > 1){
					var _finalTreePath = assetPath;
					var nameStr = jsNode._serverAlias+"$$$"+_finalTreePath+"$$$"+id+"$$$"+name+"$$$"+type+"$$$"+compositeName+"$$$"+compositeType+"$$$"+hasChildren+"$$$"+jsNode._pluginType+"$$$"+parentId+"$$$"+status+"$$$"+fullName;
					if(hasChildren == "true"){
						var queryStr = "/rest/wm.deployer.listAssetsRestHook.listAssetsByCategory?pluginType="+jsNode._pluginType+"&serverAlias="+jsNode._serverAlias+
						"&assetIdentifiers.type="+type+"&assetIdentifiers.name="+name+"&assetIdentifiers.id="+id;
						var subNode = new WebFXCheckBoxAsyncTreeItem(name, queryStr ,null,true,false,null,false,null,getACDLIcon(type), getACDLIcon(type),escape(_finalTreePath),"COMPONENT_INCL");
						subNode._fqAssetNameStr = nameStr;
						jsNode.add(subNode,true);
						if(jsNode._checked){
							subNode.enableNodeAndChecked(true);
						}
					}
					else {
						var subNode = new WebFXCheckBoxAsyncTreeItem(name, null,null,false,true,null,false,null,getACDLIcon(type), getACDLIcon(type),escape(_finalTreePath),"COMPONENT_INCL");
						subNode._fqAssetNameStr = nameStr;
						jsNode.add(subNode,true);
						if(jsNode._checked){
							subNode.enableNodeAndChecked(true);
						}
					}
				}
			}
		}
		if (bIndent) {
			jsNode.indent();
		}
		if (jsNode.errorText != "") {
			window.status = jsNode.errorText;
			//var message = "<TR><TD class=\"message\" colspan=4>&nbsp;&nbsp;&nbsp;&nbsp;"+jsNode.errorText+"</TD></TR>"
			window.alert(jsNode.errorText);
			//window.document.write(message);
		}
	}
}