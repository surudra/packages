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

function WebFXRadioButtonTreeItem(sText, sAction, bChecked, eParent, sIcon, sOpenIcon, sName, sValue, sClass, sId, sEnabled, sTarget) {
	this.base = WebFXTreeItem;
	this.base(sText, sAction, eParent, sIcon, sOpenIcon);
	this._action=sAction;
	//alert("from WebFXRadioButtonTreeItem:::"+this._action);
	this._checked = bChecked;
	this._name = sName || "dummy";
	this._value = sValue || "dummy";
	this._itemClass = (sClass != null ? sClass: webFXTreeConfig.defaultClass);
	var progressText = "return startProgressBar('Opening " + sText + "');";
	this._onClick = (sClass == webFXTreeConfig.linkClass ? progressText : 'return true;');
	this._id = sId || "dummy";
	this._enabled = (sEnabled != null ? sEnabled: true);
	this._isFolder = (sIcon == webFXTreeConfig.folderIcon ? true : false);
	if(sTarget == null){
		this._target = "propertyFrame";
	}else{
		this._target = sTarget;
	}
}

WebFXRadioButtonTreeItem.prototype = new WebFXTreeItem;

WebFXRadioButtonTreeItem.prototype.toString = function (nItem, nItemCount) {
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
	
	// insert radio button - Use Name/Value scheme for update service
	str += "<input name=" + this._name + " value=" + this._value + " type=\"radio\"" +
		" id=" + this._id + " class=\"tree-radio-button\"" +
		(this._checked ? " checked=\"checked\"" : "") + (this._enabled ? " enabled" : " disabled") +
		" onclick=\"window.open('"+ this._action + "','propertyFrame');\"" +
		" />";
	// end insert radiobutton
	
	str += "<img id=\"" + this.id + "-icon\" class=\"webfx-tree-icon\" src=\"" + ((webFXTreeHandler.behavior == 'classic' && this.open)?this.openIcon:this.icon) + "\" onclick=\"webFXTreeHandler.select(this);\"><a onclick=\"" + this._onClick + "\" target=\"" + this._target + "\" id=\"" + this.id + "-anchor\" onfocus=\"webFXTreeHandler.focus(this);\" onblur=\"webFXTreeHandler.blur(this);\">" + label + "</a></div>";
	str += "<div id=\"" + this.id + "-cont\" class=\"webfx-tree-container\" style=\"display: " + ((this.open)?'block':'none') + ";\">";
	for (var i = 0; i < this.childNodes.length; i++) {
		str += this.childNodes[i].toString(i,this.childNodes.length);
	}
	str += "</div>";
	this.plusIcon = ((this.parentNode._last)?webFXTreeConfig.lPlusIcon:webFXTreeConfig.tPlusIcon);
	this.minusIcon = ((this.parentNode._last)?webFXTreeConfig.lMinusIcon:webFXTreeConfig.tMinusIcon);
	return str;
}
webFXTreeHandler.openLink = function()
{
	alert("this.action:::"+this.icon);
	window.open(this.action, "propertyFrame");
}
WebFXRadioButtonTreeItem.prototype.getChecked = function () {
	var divEl = document.getElementById(this.id);
	var inputEl = divEl.getElementsByTagName("INPUT")[0];
	return this._checked = inputEl.checked;
};

WebFXRadioButtonTreeItem.prototype.setChecked = function (bChecked) {

	this.setNodeChecked(bChecked);

	// Set parent checkbox behavior accordingly
	this.setParentChecked(bChecked);

};

WebFXRadioButtonTreeItem.prototype.setNodeChecked = function (bChecked) {
	var divEl = document.getElementById(this.id);
	var inputEl = divEl.getElementsByTagName("INPUT")[0];

	if (bChecked != this.getChecked()) {
		// Tom change: only toggle the checkbox if its enabled
		if (inputEl.disabled == false)
			this._checked = inputEl.checked = bChecked;
	}
};