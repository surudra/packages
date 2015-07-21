/*
 *	Sub class that adds a check box in front of the tree item icon
 *
 *	Created by Erik Arvidsson (http://webfx.eae.net/contact.html#erik)
 *
 *	Disclaimer:	This is not any official WebFX component. It was created due to
 *				demand and is just a quick and dirty implementation. If you are
 *				interested in this functionality the contact us
 *				http://webfx.eae.net/contact.html
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

function WebFXCheckBoxTreeItem(sText, sAction, bChecked, eParent, sIcon, sOpenIcon, sName, sValue, sClass, sId, sEnabled) {
	this.base = WebFXTreeItem;
	this.base(sText, sAction, eParent, sIcon, sOpenIcon);
	this._checked = bChecked;
	this._itemName = sText;
	this._name = sName || "dummy";
	this._value = sValue || "dummy";
	this._itemClass = (sClass != null ? sClass: webFXTreeConfig.defaultClass);
	var progressText = "return startProgressBar('Opening " + sText + "');";
	this._onClick = (sClass == webFXTreeConfig.linkClass ? progressText : 'return true;');
	this._id = sId || "dummy";
	this._enabled = (sEnabled != null ? sEnabled: true);
	this._isFolder = (sIcon == webFXTreeConfig.folderIcon ? true : false);
	this._pathTillMine = "";
	this._fqAssetNameStr = "";
	
}

WebFXCheckBoxTreeItem.prototype = new WebFXTreeItem;

WebFXCheckBoxTreeItem.prototype.toString = function (nItem, nItemCount) {
	var foo = this.parentNode;
	
	var indent = '';
	if (nItem + 1 == nItemCount) { this.parentNode._last = true; }
	var i = 0;
	while (foo.parentNode) {
		foo = foo.parentNode;
		indent = "<img id=\"" + this.id + "-indent-" + i + "\" src=\"" + ((foo._last)?webFXTreeConfig.blankIcon:webFXTreeConfig.iIcon) + "\">" + indent;
		i++;
	}
	this._level = i;
	if (this.childNodes.length) { this.folder = 1; }
	else { this.open = false; }
	if ((this.folder) || (webFXTreeHandler.behavior != 'classic')) {
		if (!this.icon) { this.icon = webFXTreeConfig.folderIcon; }
		if (!this.openIcon) { this.openIcon = webFXTreeConfig.openFolderIcon; }
	}
	else if (!this.icon) { this.icon = webFXTreeConfig.fileIcon; }
	var label = this.text.replace(/</g, '&lt;').replace(/>/g, '&gt;');
	var str = "<div id=\"" + this.id + "\" ondblclick=\"webFXTreeHandler.toggle(this);\" class=\"" + this._itemClass + "\" onkeydown=\"return webFXTreeHandler.keydown(this, event)\">";
	str += indent;
	str += "<img id=\"" + this.id + "-plus\" src=\"" + ((this.folder)?((this.open)?((this.parentNode._last)?webFXTreeConfig.lMinusIcon:webFXTreeConfig.tMinusIcon):((this.parentNode._last)?webFXTreeConfig.lPlusIcon:webFXTreeConfig.tPlusIcon)):((this.parentNode._last)?webFXTreeConfig.lIcon:webFXTreeConfig.tIcon)) + "\" onclick=\"webFXTreeHandler.toggle(this);\">"
	
	// insert check box - Use Name/Value scheme for update service
	str += "<input name=" + this._name + " value=" + this._value + " type=\"checkbox\"" +
		" id=" + this._id + " class=\"tree-check-box\"" +
		(this._checked ? " checked=\"checked\"" : "") + (this._enabled ? " enabled" : " disabled") +
		" onclick=\"webFXTreeHandler.all[this.parentNode.id].setChecked(this.checked)\"" +
		" />";
	// end insert checkbox
	
	str += "<img id=\"" + this.id + "-icon\" class=\"webfx-tree-icon\" src=\"" + ((webFXTreeHandler.behavior == 'classic' && this.open)?this.openIcon:this.icon) + "\" onclick=\"webFXTreeHandler.select(this);\"><a onclick=\"" + this._onClick + "\" target=\"propertyFrame\""; 
	if(this.action != "javascript:void(0);"){
	str+="href=\"" + this.action + "\"";
	}
	str+="id=\"" + this.id + "-anchor\" onfocus=\"webFXTreeHandler.focus(this);\" onblur=\"webFXTreeHandler.blur(this);\">" + label + "</a></div>";
	str += "<div id=\"" + this.id + "-cont\" class=\"webfx-tree-container\" style=\"display: " + ((this.open)?'block':'none') + ";\">";
	for (var i = 0; i < this.childNodes.length; i++) {
		str += this.childNodes[i].toString(i,this.childNodes.length);
	}
	str += "</div>";
	this.plusIcon = ((this.parentNode._last)?webFXTreeConfig.lPlusIcon:webFXTreeConfig.tPlusIcon);
	this.minusIcon = ((this.parentNode._last)?webFXTreeConfig.lMinusIcon:webFXTreeConfig.tMinusIcon);
	return str;
}

if(!Array.indexOf) {
  Array.prototype.indexOf = function(obj) {
   for(var i=0; i<this.length; i++) {
    if(this[i]==obj) {
     return i;
    }
   }
   return -1;
  }
}

WebFXCheckBoxTreeItem.prototype.getChecked = function () {
	var divEl = document.getElementById(this.id);
	var inputEl = divEl.getElementsByTagName("INPUT")[0];
	return this._checked = inputEl.checked;
};

WebFXCheckBoxTreeItem.prototype.hasJavaOrCService = function(obj, recurse) {

	if(recurse)
	{
		for(var i = 0; i < obj.childNodes.length; i++)
		{
			if(obj.childNodes[i]._name.indexOf('$JavaService') != -1 || obj.childNodes[i]._name.indexOf('$CService') != -1)
			{
				return true;
			}
			else if(obj.childNodes[i].childNodes.length > 0)
			{
				return obj.childNodes[i].hasJavaOrCService(obj.childNodes[i], true);
			}
		}
		return false;
	}
	else
	{
		for(var i = 0; i < obj.childNodes.length; i++)
		{
			if(obj.childNodes[i]._name.indexOf('$JavaService') != -1 || obj.childNodes[i]._name.indexOf('$CService') != -1)
			{
				return true;
			}
		}
		return false;
	}
}

WebFXCheckBoxTreeItem.prototype.disableChildNodes = function(obj) {	
	for (var i = 0; i < obj.childNodes.length ; i++)
	{
		if (obj.childNodes[i]._name.indexOf('$Folder') != -1)
		{
			if (obj.childNodes[i].hasJavaOrCService(obj.childNodes[i], false))
			{
				var divEl = document.getElementById(obj.childNodes[i].id);
				var inputEl = divEl.getElementsByTagName("INPUT")[0];
				inputEl.name = inputEl.name + 'selectedall';
			}
		}
		else
		{
			if (obj.hasJavaOrCService(obj, false))
			{
				obj.childNodes[i].setNodeChecked(true);
				var divEl = document.getElementById(obj.childNodes[i].id);
				var inputEl = divEl.getElementsByTagName("INPUT")[0];
				inputEl.disabled = true;
			}
		}
		if(obj.childNodes[i].childNodes.length > 0)
		{
			obj.childNodes[i].disableChildNodes(obj.childNodes[i]);
		}
	}
}

WebFXCheckBoxTreeItem.prototype.setChecked = function (bChecked, onload, folderNames) {
	this.setNodeChecked(bChecked);
	if(document.getElementById('bundleMode') != null &&'Deploy' == document.getElementById('bundleMode').value)
	{
		var obj = this;
		if(obj._name.indexOf('$Folder') != -1)
		{
			if(!obj._checked)
			{
				for (var i = 0; i < obj.childNodes.length; i++) 
				{
					if(obj.childNodes[i]._name.indexOf('$Folder') == -1)
					{
						var divEl = document.getElementById(obj.childNodes[i].id);
						var inputEl = divEl.getElementsByTagName("INPUT")[0];
						inputEl.disabled = false;
						obj.childNodes[i].setNodeChecked(bChecked);
					}
				}
			}
			else
			{
				if (obj.hasJavaOrCService(obj, true))
				{
					var message = 'The folder you have selected for deployment or its subfolders contain Java or C services. These services require shared data that ' +
						'is in the folder. You can have Deployer deploy the shared data to the target server along with the services, but doing so might cause problems ' + 
						'with existing assets in the folder on the target server. If you want Deployer to include the shared data and all other assets from the folder in ' + 
						'the deployment set, click OK. If you do not, click Cancel.';

					if (onload || confirm(message))
					{
						if (obj.hasJavaOrCService(obj, false))
						{
							var divEl = document.getElementById(obj.id);
							var inputEl = divEl.getElementsByTagName("INPUT")[0];
							inputEl.name = inputEl.name + 'selectedall';
						}
						obj.disableChildNodes(obj);
					}
				}
			}
		}

		var p = this.parentNode;
		if (p != null) 
		{
			if( (this._name.indexOf('$JavaService') != -1 || this._name.indexOf('$CService') != -1) && this._checked)
			{
				var message = 'You have selected a Java or C service for deployment. This service requires shared data that is in the service\'s folder. ' +
					'You can have Deployer deploy the shared data to the target server along with the service, but it might cause conflicts with existing assets ' + 
					'in the folder on the target server. If you want Deployer to include the shared data and all other assets from the folder in the deployment set, ' +
					'click OK. If you do not, click Cancel.';

				if(onload && folderNames.indexOf(p._name.substring(0, p._name.indexOf('$Folder'))) != -1)
				{
					for (var i = 0; i < p.childNodes.length; i++) 
					{
						if(p.childNodes[i]._name.indexOf('$Folder') == -1)
						{
							p.childNodes[i].setNodeChecked(bChecked);
							var divEl = document.getElementById(p.childNodes[i].id);
							var inputEl = divEl.getElementsByTagName("INPUT")[0];
							inputEl.disabled = true;
						}
					}
					var divEl = document.getElementById(p.id);
					var inputEl = divEl.getElementsByTagName("INPUT")[0];
					inputEl.name = inputEl.name + 'selectedall';
				}
				else if(!onload && confirm(message))
				{
					for (var i = 0; i < p.childNodes.length; i++) 
					{
						if(p.childNodes[i]._name.indexOf('$Folder') == -1)
						{
							p.childNodes[i].setNodeChecked(bChecked);
							var divEl = document.getElementById(p.childNodes[i].id);
							var inputEl = divEl.getElementsByTagName("INPUT")[0];
							inputEl.disabled = true;
						}
					}
					var divEl = document.getElementById(p.id);
					var inputEl = divEl.getElementsByTagName("INPUT")[0];
					inputEl.name = inputEl.name + 'selectedall';
				}
			}
		}
	}
	// Set parent checkbox behavior accordingly
	this.setParentChecked(bChecked);
};

WebFXCheckBoxTreeItem.prototype.setChildrenChecked = function(bChecked) {
	for (var i = 0; i < this.childNodes.length; i++) {

    // Fix for 1-1XC0VF
		var divEl = document.getElementById(this.childNodes[i].id);
		var inputEl = divEl.getElementsByTagName("INPUT")[0];
    if(inputEl.value == "COMPONENT_INCL") {
      inputEl.disabled = false;
    }

		this.childNodes[i].setNodeChecked(bChecked);
	}

	if(!bChecked)
	{
		var divEl = document.getElementById(this.id);
		var inputEl = divEl.getElementsByTagName("INPUT")[0];

		if(inputEl.name.indexOf('selectedall') > 0)
		{
			inputEl.name = inputEl.name.substring(0, inputEl.name.indexOf('selectedall'));
		}
	}
};

WebFXCheckBoxTreeItem.prototype.setNodeChecked = function (bChecked) {
	var divEl = document.getElementById(this.id);
	var inputEl = divEl.getElementsByTagName("INPUT")[0];

	if (bChecked != this.getChecked()) {
		// Tom change: only toggle the checkbox if its enabled
		if (inputEl.disabled == false)
			this._checked = inputEl.checked = bChecked;
	}

	this.setChildrenChecked(bChecked);
};

WebFXCheckBoxTreeItem.prototype.enableNodeAndChecked = function (bChecked) {
	var divEl = document.getElementById(this.id);
	var inputEl = divEl.getElementsByTagName("INPUT")[0];

	if (bChecked != this.getChecked()) {
		inputEl.disabled = false;
		this._checked = inputEl.checked = bChecked;
	}	
};

WebFXCheckBoxTreeItem.prototype.setParentChecked = function(bChecked) {
	var p = this.parentNode;

	if (p != null) {

		// if uncheck, bail out if any other direct children are checked
		if (bChecked == false)
			for (var i = 0; i < p.childNodes.length; i++) 
				if (p.childNodes[i].getChecked())
					return;

		// Otherwise, set the parent checkbox and recurse
		var divEl = document.getElementById(p.id);
		if (divEl != null) {
			var inputEl = divEl.getElementsByTagName("INPUT")[0];
			if (inputEl != null) {
				p._checked = inputEl.checked = bChecked;
	
				if (p.parentNode != null)
					p.setParentChecked(bChecked);
			}
		}
	}
};
