/*----------------------------------------------------------------------------\
|                       Cross Browser Tree Widget 1.17                        |
|-----------------------------------------------------------------------------|
|                          Created by Emil A Eklund                           |
|                  (http://webfx.eae.net/contact.html#emil)                   |
|                      For WebFX (http://webfx.eae.net/)                      |
|-----------------------------------------------------------------------------|
| An object based tree widget,  emulating the one found in microsoft windows, |
| with persistence using cookies. Works in IE 5+, Mozilla and konqueror 3.    |
|-----------------------------------------------------------------------------|
|                   Copyright (c) 1999 - 2002 Emil A Eklund                   |
|-----------------------------------------------------------------------------|
| This software is provided "as is", without warranty of any kind, express or |
| implied, including  but not limited  to the warranties of  merchantability, |
| fitness for a particular purpose and noninfringement. In no event shall the |
| authors or  copyright  holders be  liable for any claim,  damages or  other |
| liability, whether  in an  action of  contract, tort  or otherwise, arising |
| from,  out of  or in  connection with  the software or  the  use  or  other |
| dealings in the software.                                                   |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
| This  software is  available under the  three different licenses  mentioned |
| below.  To use this software you must chose, and qualify, for one of those. |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
| The WebFX Non-Commercial License          http://webfx.eae.net/license.html |
| Permits  anyone the right to use the  software in a  non-commercial context |
| free of charge.                                                             |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
| The WebFX Commercial license           http://webfx.eae.net/commercial.html |
| Permits the  license holder the right to use  the software in a  commercial |
| context. Such license must be specifically obtained, however it's valid for |
| any number of  implementations of the licensed software.                    |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
| GPL - The GNU General Public License    http://www.gnu.org/licenses/gpl.txt |
| Permits anyone the right to use and modify the software without limitations |
| as long as proper  credits are given  and the original  and modified source |
| code are included. Requires  that the final product, software derivate from |
| the original  source or any  software  utilizing a GPL  component, such  as |
| this, is also licensed under the GPL license.                               |
|-----------------------------------------------------------------------------|
| Dependencies: xtree.css (To set up the CSS of the tree classes)             |
|-----------------------------------------------------------------------------|
| 2001-01-10 | Original Version Posted.                                       |
| 2001-03-18 | Added getSelected and get/setBehavior  that can make it behave |
|            | more like windows explorer, check usage for more information.  |
| 2001-09-23 | Version 1.1 - New features included  keyboard  navigation (ie) |
|            | and the ability  to add and  remove nodes dynamically and some |
|            | other small tweaks and fixes.                                  |
| 2002-01-27 | Version 1.11 - Bug fixes and improved mozilla support.         |
| 2002-06-11 | Version 1.12 - Fixed a bug that prevented the indentation line |
|            | from  updating correctly  under some  circumstances.  This bug |
|            | happened when removing the last item in a subtree and items in |
|            | siblings to the remove subtree where not correctly updated.    |
| 2002-06-13 | Fixed a few minor bugs cased by the 1.12 bug-fix.              |
| 2002-08-20 | Added usePersistence flag to allow disable of cookies.         |
| 2002-10-23 | (1.14) Fixed a plus icon issue                                 |
| 2002-10-29 | (1.15) Last changes broke more than they fixed. This version   |
|            | is based on 1.13 and fixes the bugs 1.14 fixed withou breaking |
|            | lots of other things.                                          |
| 2003-02-15 | The  selected node can now be made visible even when  the tree |
|            | control  loses focus.  It uses a new class  declaration in the |
|            | css file '.webfx-tree-item a.selected-inactive', by default it |
|            | puts a light-gray rectangle around the selected node.          |
| 2003-03-16 | Adding target support after lots of lobbying...                |
|-----------------------------------------------------------------------------|
| Created 2000-12-11 | All changes are in the log above. | Updated 2003-03-16 |
\----------------------------------------------------------------------------*/

var webFXTreeConfig = {
	rootIcon        : 'images/foldericon.png',
	openRootIcon    : 'images/openfoldericon.png',
	folderIcon      : 'images/foldericon.png',
	openFolderIcon  : 'images/openfoldericon.png',
	fileIcon        : 'images/file.png',
	iIcon           : 'images/I.png',
	lIcon           : 'images/L.png',
	lMinusIcon      : 'images/Lminus.png',
	lPlusIcon       : 'images/Lplus.png',
	tIcon           : 'images/T.png',
	tMinusIcon      : 'images/Tminus.png',
	tPlusIcon       : 'images/Tplus.png',
	blankIcon       : 'images/blank.png',
	serverIcon		: 'images/server.gif',
	defaultText     : 'Tree Item',
	defaultAction   : 'javascript:void(0);',
	defaultBehavior : 'classic',
  serverDown      :'images/serverDown.gif',
	usePersistence	: true
};

var webFXTreeHandler = {
	idCounter : 0,
	idPrefix  : "webfx-tree-object-",
	all       : {},
	behavior  : null,
	selected  : null,
	onSelect  : null, /* should be part of tree, not handler */
	getId     : function() { return this.idPrefix + this.idCounter++; },
	toggle    : function (oItem) { this.all[oItem.id.replace('-plus','')].toggle(); },
	select    : function (oItem) { this.all[oItem.id.replace('-icon','')].select(); },
	focus     : function (oItem) { this.all[oItem.id.replace('-anchor','')].focus(); },
	blur      : function (oItem) { this.all[oItem.id.replace('-anchor','')].blur(); },
	keydown   : function (oItem, e) { return this.all[oItem.id].keydown(e.keyCode); },
	cookies   : new WebFXCookie(),
	insertHTMLBeforeEnd	:	function (oElement, sHTML) {
		if (oElement.insertAdjacentHTML != null) {
			oElement.insertAdjacentHTML("BeforeEnd", sHTML)
			return;
		}
		var df;	// DocumentFragment
		var r = oElement.ownerDocument.createRange();
		r.selectNodeContents(oElement);
		r.collapse(false);
		df = r.createContextualFragment(sHTML);
		oElement.appendChild(df);
	}
};

/*
 * WebFXCookie class
 */

function WebFXCookie() {
	if (document.cookie.length) { this.cookies = ' ' + document.cookie; }
}

WebFXCookie.prototype.setCookie = function (key, value) {
	document.cookie = key + "=" + escape(value);
}

WebFXCookie.prototype.getCookie = function (key) {
	if (this.cookies) {
		var start = this.cookies.indexOf(' ' + key + '=');
		if (start == -1) { return null; }
		var end = this.cookies.indexOf(";", start);
		if (end == -1) { end = this.cookies.length; }
		end -= start;
		var cookie = this.cookies.substr(start,end);
		return unescape(cookie.substr(cookie.indexOf('=') + 1, cookie.length - cookie.indexOf('=') + 1));
	}
	else { return null; }
}

/*
 * WebFXTreeAbstractNode class
 */

function WebFXTreeAbstractNode(sText, sAction) {
	this.childNodes  = [];
	this.id     = webFXTreeHandler.getId();
	this.text   = sText || webFXTreeConfig.defaultText;
	this.action = sAction || webFXTreeConfig.defaultAction;
	this._last  = false;
	webFXTreeHandler.all[this.id] = this;
}

/*
 * To speed thing up if you're adding multiple nodes at once (after load)
 * use the bNoIdent parameter to prevent automatic re-indentation and call
 * the obj.ident() method manually once all nodes has been added.
 */

WebFXTreeAbstractNode.prototype.add = function (node, bNoIdent) {
	node.parentNode = this;
	this.childNodes[this.childNodes.length] = node;
	var root = this;
	if (this.childNodes.length >= 2) {
		this.childNodes[this.childNodes.length - 2]._last = false;
	}
	while (root.parentNode) { 
  root = root.parentNode; 
  }
	if (root.rendered) {
		if (this.childNodes.length >= 2) {
			document.getElementById(this.childNodes[this.childNodes.length - 2].id + '-plus').src = ((this.childNodes[this.childNodes.length -2].folder)?((this.childNodes[this.childNodes.length -2].open)?webFXTreeConfig.tMinusIcon:webFXTreeConfig.tPlusIcon):webFXTreeConfig.tIcon);
			this.childNodes[this.childNodes.length - 2].plusIcon = webFXTreeConfig.tPlusIcon;
			this.childNodes[this.childNodes.length - 2].minusIcon = webFXTreeConfig.tMinusIcon;
			this.childNodes[this.childNodes.length - 2]._last = false;
		}
		this._last = true;
		var foo = this;
		while (foo.parentNode) {
			for (var i = 0; i < foo.parentNode.childNodes.length; i++) {
				if (foo.id == foo.parentNode.childNodes[i].id) { break; }
			}
			if (i == foo.parentNode.childNodes.length - 1) { foo.parentNode._last = true; }
			else { foo.parentNode._last = false; }
			foo = foo.parentNode;
		}
		webFXTreeHandler.insertHTMLBeforeEnd(document.getElementById(this.id + '-cont'), node.toString());
		if ((!this.folder) && (!this.openIcon)) {
			this.icon = webFXTreeConfig.folderIcon;
			this.openIcon = webFXTreeConfig.openFolderIcon;
		}
		if (!this.folder) { this.folder = true; this.collapse(true); }
		if (!bNoIdent) { this.indent(); }
	}
	return node;
}

WebFXTreeAbstractNode.prototype.toggle = function() {
	if (this.folder) {
		if (this.open) { this.collapse(); }
		else { this.expand(); }
}	}

WebFXTreeAbstractNode.prototype.select = function() {
	document.getElementById(this.id + '-anchor').focus();
}

WebFXTreeAbstractNode.prototype.deSelect = function() {
	document.getElementById(this.id + '-anchor').className = '';
	webFXTreeHandler.selected = null;
}

WebFXTreeAbstractNode.prototype.focus = function() {
	if ((webFXTreeHandler.selected) && (webFXTreeHandler.selected != this)) { webFXTreeHandler.selected.deSelect(); }
	webFXTreeHandler.selected = this;
	if ((this.openIcon) && (webFXTreeHandler.behavior != 'classic')) { document.getElementById(this.id + '-icon').src = this.openIcon; }
	document.getElementById(this.id + '-anchor').className = 'selected';
	document.getElementById(this.id + '-anchor').focus();
	if (webFXTreeHandler.onSelect) { webFXTreeHandler.onSelect(this); }
}

WebFXTreeAbstractNode.prototype.blur = function() {
	if ((this.openIcon) && (webFXTreeHandler.behavior != 'classic')) { document.getElementById(this.id + '-icon').src = this.icon; }
	document.getElementById(this.id + '-anchor').className = 'selected-inactive';
}

WebFXTreeAbstractNode.prototype.doExpand = function() {
	if (webFXTreeHandler.behavior == 'classic') { document.getElementById(this.id + '-icon').src = this.openIcon; }
	if (this.childNodes.length) {  document.getElementById(this.id + '-cont').style.display = 'block'; }
	this.open = true;
	if (webFXTreeConfig.usePersistence) {
		webFXTreeHandler.cookies.setCookie(this.id.substr(18,this.id.length - 18), '1');
}	}

WebFXTreeAbstractNode.prototype.doCollapse = function() {
	if (webFXTreeHandler.behavior == 'classic') { document.getElementById(this.id + '-icon').src = this.icon; }
	if (this.childNodes.length) { document.getElementById(this.id + '-cont').style.display = 'none'; }
	this.open = false;
	if (webFXTreeConfig.usePersistence) {
		webFXTreeHandler.cookies.setCookie(this.id.substr(18,this.id.length - 18), '0');
}	}

WebFXTreeAbstractNode.prototype.expandAll = function() {
	this.expandChildren();
	if ((this.folder) && (!this.open)) { this.expand(); }
}

WebFXTreeAbstractNode.prototype.expandChildren = function() {
	for (var i = 0; i < this.childNodes.length; i++) {
		this.childNodes[i].expandAll();
} }

WebFXTreeAbstractNode.prototype.collapseAll = function() {
	this.collapseChildren();
	if ((this.folder) && (this.open)) { this.collapse(true); }
}

WebFXTreeAbstractNode.prototype.collapseChildren = function() {
	for (var i = 0; i < this.childNodes.length; i++) {
		this.childNodes[i].collapseAll();
} }

WebFXTreeAbstractNode.prototype.indent = function(lvl, del, last, level, nodesLeft) {
	/*
	 * Since we only want to modify items one level below ourself,
	 * and since the rightmost indentation position is occupied by
	 * the plus icon we set this to -2
	 */
	if (lvl == null) { lvl = -2; }
	var state = 0;
	for (var i = this.childNodes.length - 1; i >= 0 ; i--) {
		state = this.childNodes[i].indent(lvl + 1, del, last, level);
		if (state) { return; }
	}
	if (del) {
		if ((level >= this._level) && (document.getElementById(this.id + '-plus'))) {
			if (this.folder) {
				document.getElementById(this.id + '-plus').src = (this.open)?webFXTreeConfig.lMinusIcon:webFXTreeConfig.lPlusIcon;
				this.plusIcon = webFXTreeConfig.lPlusIcon;
				this.minusIcon = webFXTreeConfig.lMinusIcon;
			}
			else if (nodesLeft) { document.getElementById(this.id + '-plus').src = webFXTreeConfig.lIcon; }
			return 1;
	}	}
	var foo = document.getElementById(this.id + '-indent-' + lvl);
	if (foo) {
		if ((foo._last) || ((del) && (last))) { foo.src =  webFXTreeConfig.blankIcon; }
		else { foo.src =  webFXTreeConfig.iIcon; }
	}
	return 0;
}

/*
 * WebFXTree class
 */

function WebFXTree(sText, sAction, sBehavior, sIcon, sOpenIcon, sClass, sTarget) {
	this.base = WebFXTreeAbstractNode;
	this.base(sText, sAction);
	this.icon      = sIcon || webFXTreeConfig.rootIcon;
	this.openIcon  = sOpenIcon || webFXTreeConfig.openRootIcon;
	/* Defaults to open */
	if (webFXTreeConfig.usePersistence) {
		this.open  = (webFXTreeHandler.cookies.getCookie(this.id.substr(18,this.id.length - 18)) == '0')?false:true;
	} else { this.open  = true; }
	this.folder    = true;
	this.rendered  = false;
	this.onSelect  = null;
	this._itemClass = (sClass != null ? sClass : webFXTreeConfig.defaultClass);
	var progressText = "return startProgressBar('Opening " + sText + "');";
	this._onClick = (sClass == webFXTreeConfig.propertyClass ? progressText : 'return true;');
	if (!webFXTreeHandler.behavior) {  webFXTreeHandler.behavior = sBehavior || webFXTreeConfig.defaultBehavior; }
	if(sTarget == null){
		this._target = "propertyFrame";
	}else{
		this._target = sTarget;
	}
}

WebFXTree.prototype = new WebFXTreeAbstractNode;

WebFXTree.prototype.setBehavior = function (sBehavior) {
	webFXTreeHandler.behavior =  sBehavior;
};

WebFXTree.prototype.getBehavior = function (sBehavior) {
	return webFXTreeHandler.behavior;
};

WebFXTree.prototype.getSelected = function() {
	if (webFXTreeHandler.selected) { return webFXTreeHandler.selected; }
	else { return null; }
}

WebFXTree.prototype.remove = function() { }

WebFXTree.prototype.expand = function() {
	this.doExpand();
}

WebFXTree.prototype.collapse = function(b) {
	if (!b) { this.focus(); }
	this.doCollapse();
}

WebFXTree.prototype.getFirst = function() {
	return null;
}

WebFXTree.prototype.getLast = function() {
	return null;
}

WebFXTree.prototype.getNextSibling = function() {
	return null;
}

WebFXTree.prototype.getPreviousSibling = function() {
	return null;
}

WebFXTree.prototype.keydown = function(key) {
	if (key == 39) {
		if (!this.open) { this.expand(); }
		else if (this.childNodes.length) { this.childNodes[0].select(); }
		return false;
	}
	if (key == 37) { this.collapse(); return false; }
	if ((key == 40) && (this.open) && (this.childNodes.length)) { this.childNodes[0].select(); return false; }
	return true;
}

WebFXTree.prototype.toString = function() {
	var str = "<div id=\"" + this.id + "\" ondblclick=\"webFXTreeHandler.toggle(this);\" class=\"" + this._itemClass + "\" onkeydown=\"return webFXTreeHandler.keydown(this, event)\">" +
		"<img id=\"" + this.id + "-icon\" class=\"webfx-tree-icon\" src=\"" + ((webFXTreeHandler.behavior == 'classic' && this.open)?this.openIcon:this.icon) + "\" onclick=\"webFXTreeHandler.select(this);\">" +
		"<a onclick=\"" + this._onClick + "\" target=\"" + this._target + "\" href=\"" + this.action + "\" id=\"" + this.id + "-anchor\" onfocus=\"webFXTreeHandler.focus(this);\" onblur=\"webFXTreeHandler.blur(this);\"" +
		(this.target ? " target=\"" + this.target + "\"" : "") +
		">" + this.text + "</a></div>" +
		"<div id=\"" + this.id + "-cont\" class=\"webfx-tree-container\" style=\"display: " + ((this.open)?'block':'none') + ";\">";
	var sb = [];
	for (var i = 0; i < this.childNodes.length; i++) {
		sb[i] = this.childNodes[i].toString(i, this.childNodes.length);
	}
	this.rendered = true;
	return str + sb.join("") + "</div>";
};

/*
 * WebFXTreeItem class
 */

function WebFXTreeItem(sText, sAction, eParent, sIcon, sOpenIcon, sClass, sTarget) {
	this.base = WebFXTreeAbstractNode;
	this.base(sText, sAction);
	/* Defaults to close */
	if (webFXTreeConfig.usePersistence) {
		this.open = (webFXTreeHandler.cookies.getCookie(this.id.substr(18,this.id.length - 18)) == '1')?true:false;
	} else { this.open = false; }
	if (sIcon) { this.icon = sIcon; }
	if (sOpenIcon) { this.openIcon = sOpenIcon; }
	if (eParent) { eParent.add(this); }
	this._itemClass = (sClass != null ? sClass : webFXTreeConfig.defaultClass);
	var progressText = "return startProgressBar('Opening " + sText + "');";
	this._onClick = ((sClass == webFXTreeConfig.linkClass || sClass == webFXTreeConfig.propertyClass) ? progressText : 'return true;');
	if(sTarget == null){
		this._target = "propertyFrame";
	}else{
		this._target = sTarget;
	}
}

WebFXTreeItem.prototype = new WebFXTreeAbstractNode;

WebFXTreeItem.prototype.remove = function() {
	var iconSrc = document.getElementById(this.id + '-plus').src;
	var parentNode = this.parentNode;
	var prevSibling = this.getPreviousSibling(true);
	var nextSibling = this.getNextSibling(true);
	var folder = this.parentNode.folder;
	var last = ((nextSibling) && (nextSibling.parentNode) && (nextSibling.parentNode.id == parentNode.id))?false:true;
	this.getPreviousSibling().focus();
	this._remove();
	if (parentNode.childNodes.length == 0) {
		document.getElementById(parentNode.id + '-cont').style.display = 'none';
		parentNode.doCollapse();
		parentNode.folder = false;
		parentNode.open = false;
	}
	if (!nextSibling || last) { parentNode.indent(null, true, last, this._level, parentNode.childNodes.length); }
	if ((prevSibling == parentNode) && !(parentNode.childNodes.length)) {
		prevSibling.folder = false;
		prevSibling.open = false;
		iconSrc = document.getElementById(prevSibling.id + '-plus').src;
		iconSrc = iconSrc.replace('minus', '').replace('plus', '');
		document.getElementById(prevSibling.id + '-plus').src = iconSrc;
		document.getElementById(prevSibling.id + '-icon').src = webFXTreeConfig.fileIcon;
	}
	if (document.getElementById(prevSibling.id + '-plus')) {
		if (parentNode == prevSibling.parentNode) {
			iconSrc = iconSrc.replace('minus', '').replace('plus', '');
			document.getElementById(prevSibling.id + '-plus').src = iconSrc;
}	}	}

WebFXTreeItem.prototype._remove = function() {
	for (var i = this.childNodes.length - 1; i >= 0; i--) {
		this.childNodes[i]._remove();
 	}
	for (var i = 0; i < this.parentNode.childNodes.length; i++) {
		if (this == this.parentNode.childNodes[i]) {
			for (var j = i; j < this.parentNode.childNodes.length; j++) {
				this.parentNode.childNodes[j] = this.parentNode.childNodes[j+1];
			}
			this.parentNode.childNodes.length -= 1;
			if (i + 1 == this.parentNode.childNodes.length) { this.parentNode._last = true; }
			break;
	}	}
	webFXTreeHandler.all[this.id] = null;
	var tmp = document.getElementById(this.id);
	if (tmp) { tmp.parentNode.removeChild(tmp); }
	tmp = document.getElementById(this.id + '-cont');
	if (tmp) { tmp.parentNode.removeChild(tmp); }
}

WebFXTreeItem.prototype.expand = function() {
	this.doExpand();
	document.getElementById(this.id + '-plus').src = this.minusIcon;
}

WebFXTreeItem.prototype.collapse = function(b) {
	if (!b) { this.focus(); }
	this.doCollapse();
	document.getElementById(this.id + '-plus').src = this.plusIcon;
}

WebFXTreeItem.prototype.getFirst = function() {
	return this.childNodes[0];
}

WebFXTreeItem.prototype.getLast = function() {
	if (this.childNodes[this.childNodes.length - 1].open) { return this.childNodes[this.childNodes.length - 1].getLast(); }
	else { return this.childNodes[this.childNodes.length - 1]; }
}

WebFXTreeItem.prototype.getNextSibling = function() {
	for (var i = 0; i < this.parentNode.childNodes.length; i++) {
		if (this == this.parentNode.childNodes[i]) { break; }
	}
	if (++i == this.parentNode.childNodes.length) { return this.parentNode.getNextSibling(); }
	else { return this.parentNode.childNodes[i]; }
}

WebFXTreeItem.prototype.getPreviousSibling = function(b) {
	for (var i = 0; i < this.parentNode.childNodes.length; i++) {
		if (this == this.parentNode.childNodes[i]) { break; }
	}
	if (i == 0) { return this.parentNode; }
	else {
		if ((this.parentNode.childNodes[--i].open) || (b && this.parentNode.childNodes[i].folder)) { return this.parentNode.childNodes[i].getLast(); }
		else { return this.parentNode.childNodes[i]; }
} }

WebFXTreeItem.prototype.keydown = function(key) {
	if ((key == 39) && (this.folder)) {
		if (!this.open) { this.expand(); }
		else { this.getFirst().select(); }
		return false;
	}
	else if (key == 37) {
		if (this.open) { this.collapse(); }
		else { this.parentNode.select(); }
		return false;
	}
	else if (key == 40) {
		if (this.open) { this.getFirst().select(); }
		else {
			var sib = this.getNextSibling();
			if (sib) { sib.select(); }
		}
		return false;
	}
	else if (key == 38) { this.getPreviousSibling().select(); return false; }
	return true;
}

WebFXTreeItem.prototype.toString = function (nItem, nItemCount) {
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
	var str = "<div id=\"" + this.id + "\" ondblclick=\"webFXTreeHandler.toggle(this);\" class=\"" + this._itemClass + "\" onkeydown=\"return webFXTreeHandler.keydown(this, event)\">" +
		indent +
		"<img id=\"" + this.id + "-plus\" src=\"" + ((this.folder)?((this.open)?((this.parentNode._last)?webFXTreeConfig.lMinusIcon:webFXTreeConfig.tMinusIcon):((this.parentNode._last)?webFXTreeConfig.lPlusIcon:webFXTreeConfig.tPlusIcon)):((this.parentNode._last)?webFXTreeConfig.lIcon:webFXTreeConfig.tIcon)) + "\" onclick=\"webFXTreeHandler.toggle(this);\">" +
		"<img id=\"" + this.id + "-icon\" class=\"webfx-tree-icon\" src=\"" + ((webFXTreeHandler.behavior == 'classic' && this.open)?this.openIcon:this.icon) + "\" onclick=\"webFXTreeHandler.select(this);\">" +
		"<a onclick=\"" + this._onClick + "\" target=\"" + this._target + "\"";
		if (this.action != "javascript:void(0);")
		{
			str+="\" href=\"" + this.action + "\"";
		}
		str+="\" id=\"" + this.id + "-anchor\" onfocus=\"webFXTreeHandler.focus(this);\" onblur=\"webFXTreeHandler.blur(this);\"" +
		(this.target ? " target=\"" + this.target + "\"" : "") +
		">" + label + "</a></div>" +
		"<div id=\"" + this.id + "-cont\" class=\"webfx-tree-container\" style=\"display: " + ((this.open)?'block':'none') + ";\">";
	var sb = [];
	for (var i = 0; i < this.childNodes.length; i++) {
		sb[i] = this.childNodes[i].toString(i,this.childNodes.length);
	}
	this.plusIcon = ((this.parentNode._last)?webFXTreeConfig.lPlusIcon:webFXTreeConfig.tPlusIcon);
	this.minusIcon = ((this.parentNode._last)?webFXTreeConfig.lMinusIcon:webFXTreeConfig.tMinusIcon);
	return str + sb.join("") + "</div>";
}

// Deployer customizations - XP Look
webFXTreeConfig.rootIcon    = "images/tree/xp/folder.png";
webFXTreeConfig.openRootIcon  = "images/tree/xp/openfolder.png";
webFXTreeConfig.folderIcon    = "images/tree/xp/folder.png";
webFXTreeConfig.openFolderIcon  = "images/tree/xp/openfolder.png";
webFXTreeConfig.fileIcon    = "images/tree/xp/file.png";
webFXTreeConfig.lMinusIcon    = "images/tree/xp/Lminus.png";
webFXTreeConfig.lPlusIcon   = "images/tree/xp/Lplus.png";
webFXTreeConfig.tMinusIcon    = "images/tree/xp/Tminus.png";
webFXTreeConfig.tPlusIcon   = "images/tree/xp/Tplus.png";
webFXTreeConfig.iIcon     = "images/tree/xp/I.png";
webFXTreeConfig.lIcon     = "images/tree/xp/L.png";
webFXTreeConfig.tIcon     = "images/tree/xp/T.png";
webFXTreeConfig.blankIcon = 'images/tree/blank.png';
webFXTreeConfig.TNicon = 'images/tn_icon.gif';
webFXTreeConfig.TNiconX = 'images/tn_icon_x.gif';
webFXTreeConfig.TNprofile = 'images/btn_profile_large.gif';
webFXTreeConfig.TNprofileFld = 'images/btn_extd_fields.gif';
webFXTreeConfig.TNattribute = 'images/btn_docattrs.gif';
webFXTreeConfig.TNrule = 'images/btn_routing.gif';
webFXTreeConfig.TNfp = 'images/tn_fp.gif';
webFXTreeConfig.TNdls = 'images/tn_dls.gif';
webFXTreeConfig.TNArchivalSvc = 'images/tn_archiveschedule.gif';
webFXTreeConfig.TNtype = 'images/btn_doctypes.gif';
webFXTreeConfig.TNagreement = 'images/btn_tpa.gif';
webFXTreeConfig.TNcertificate = 'images/certificate_icon.gif';
webFXTreeConfig.TNqueue = 'images/tn_queue.gif';
webFXTreeConfig.BPMicon = 'images/modeler_icon.gif';
webFXTreeConfig.BPMmodel = 'images/bpm.gif';
webFXTreeConfig.ISTask = 'images/sc_task.gif';
webFXTreeConfig.ISPort = 'images/port.gif';
webFXTreeConfig.ISUser = 'images/user.gif';
webFXTreeConfig.ISGroup = 'images/group.gif';
webFXTreeConfig.ISAcl = 'images/key.gif';
webFXTreeConfig.ISPackage = 'images/ns_package.gif';
webFXTreeConfig.ISPackageX = 'images/ns_package_x.gif';
webFXTreeConfig.ISPartialPackage = 'images/ns_partial_package.gif';
webFXTreeConfig.ISExtended = 'images/extended.gif';
webFXTreeConfig.ISWSD = 'images/webServiceDescriptor.gif';
webFXTreeConfig.serverIcon = 'images/server_new.gif';
webFXTreeConfig.clusterServer = 'images/cluster.gif';
webFXTreeConfig.targetGroupIcon = 'images/TargetGroupServer_03.gif';
webFXTreeConfig.logicalServerIcon = 'images/logical_server.gif';
webFXTreeConfig.ISIcon = 'images/is.gif';
webFXTreeConfig.ISIconX = 'images/is_x.gif';
webFXTreeConfig.devIcon = 'images/developer_icon.gif';
webFXTreeConfig.devIconX = 'images/developer_icon_x.gif';
webFXTreeConfig.mapSetIcon = 'images/map_transformer.gif';
webFXTreeConfig.previousIcon = 'images/previous.gif';

webFXTreeConfig.defaultClass = 'webfx-tree-item';
webFXTreeConfig.linkClass = 'webfx-link-item';
webFXTreeConfig.propertyClass = 'webfx-property-item';
webFXTreeConfig.compositeIcon = 'images/composite.png';
webFXTreeConfig.componentIcon = 'images/component.gif';
webFXTreeConfig.runtimeIcon = 'images/runtime_type.png';
webFXTreeConfig.partialCompositeIcon = 'images/partial_composite.png';

function getNSIcon(type) {
	switch (type) {
	case 'Package' :
		return(webFXTreeConfig.ISPackage);
	case 'Document' :
		return("images/ns_record.gif");
	case 'Schema' :
		return("images/schema.gif");
	case 'Specification' :
		return("images/ns_spec.gif");
	case 'FlowService' :
		return("images/ns_flow.gif");
	case 'JavaService' :
		return("images/ns_java.gif");
	case 'dotNetService' :
		return("images/dotnet_service.gif");
	case 'CService' :
		return("images/ns_c.gif");
	case 'WebService' :
		return("images/ns_ws.gif");
	case 'Trigger' :
		return("images/ns_trigger.gif");
	case 'AdapterService' :
		return("images/adapter_service.gif");
	case 'AdapterNotification' :
		return("images/adapter_notification.gif");
	case 'AdapterConnection' :
		return("images/ns_conn.gif");
	case 'AdapterListener' :
		return("images/ns_listener.gif");
	case 'FlatFileDictionary' :
		return("images/ffdictionary.gif");
	case 'FlatFileSchema' :
		return("images/ffnode.gif");
	case 'ISPackageFile' :
		return("images/ns_pkg_file.gif");
	case 'PackageFile' :
		return("images/ns_pkg_file.gif");
	case 'ISFile' :
		return("images/ns_pkg_file.gif");
	case 'PackageFiles' :
		return("images/ns_pkg_files.gif");
	case 'PackageDeleteFile' :
		return("images/ns_pkg_delete_file.gif");
	case 'MainframeTransactionService' :
		return("images/mi_tran.gif");
	case 'MainframeTransactionGroupService' :
		return("images/mi_group.gif");
	case 'Mainframe3270Pool' :
		return("images/mi_3270.gif");
	case 'MainframeHostPool' :
		return("images/mi_pool.gif");
	case 'XSLTService' :
		return("images/xsltservice.gif");
	case 'BlazeRuleService' :
		return("images/blazetreeicon.gif");
	case 'Group' :
		return(webFXTreeConfig.ISGroup);
	case 'ACL' :
		return(webFXTreeConfig.ISAcl);
	case 'User' :
		return(webFXTreeConfig.ISUser);
	case 'Port' :
		return(webFXTreeConfig.ISPort);
	case 'ScheduledService' :
		return(webFXTreeConfig.ISTask);
	case 'TNDocumentType' :
		return(webFXTreeConfig.TNtype);
	case 'TNDocumentAttribute' :
		return(webFXTreeConfig.TNattribute);
	case 'TNProcessingRule' :
		return(webFXTreeConfig.TNrule);
	case 'TNFp' :
		return(webFXTreeConfig.TNfp);
	case 'TNDls' :
		return(webFXTreeConfig.TNdls);    
	case 'TNArchivalSvcs' :
		return(webFXTreeConfig.TNArchivalSvc);
	case 'archSvcs' :
		return(webFXTreeConfig.TNArchivalSvc);
	case 'TNFieldDefinition' :
		return(webFXTreeConfig.TNprofileFld);
	case 'TNFieldGroup' :
		return(webFXTreeConfig.TNprofileFld);
	case 'TNProfile' :
		return(webFXTreeConfig.TNprofile);
	case 'TNProfileGroup' :
		return(webFXTreeConfig.TNprofile);
	case 'TNIdType' :
		return(webFXTreeConfig.TNprofileFld);
	case 'TNContactType' :
		return(webFXTreeConfig.TNprofileFld);
	case 'TNBinaryType' :
		return(webFXTreeConfig.TNprofileFld);
	case 'TNExtendedField' :
		return(webFXTreeConfig.TNprofileFld);
	case 'TNSecurityData' :
		return(webFXTreeConfig.TNcertificate);
	case 'TNQueue' :
		return(webFXTreeConfig.TNqueue);
	case 'TNTPA' :
		return(webFXTreeConfig.TNagreement);
	case 'File' :
		return(webFXTreeConfig.fileIcon);
	case 'Folder' :
		return(webFXTreeConfig.folderIcon);
	case 'webServiceDescriptor' :		
		return("images/webServiceDescriptor.gif");
	default :
		return("images/ns_unknown_node.gif");
	}
}

function getNSFolderName(type) {
	switch (type) {
	case 'Group' :
		return("Groups");
	case 'ACL' :
		return("ACLs");
	case 'User' :
		return("Users");
	case 'Port' :
		return("Ports");
	case 'ScheduledService' :
		return("Scheduled Tasks");
	default :
		return("Unknown Type");
	}
}

// Return xtree node representing server parent
function getServerTree(name, serverList, serverTreeList) {
	for (s in serverList) {
		if (serverList[s] == name)
			return (serverTreeList[s]);
	}
	return null;
}

// Return xtree node representing parent of current folder
function getFolderParent(name, folderList, folderTreeList) {

	if (name == null) {
		return (folderTreeList[0]);
	}
	else {
		for (f in folderList) {
			if (folderList[f] == name) {
				return (folderTreeList[f]);
			}
		}
	}
	return (folderTreeList[0]);
}

// Dynamically remove empty folders from tree
function trimTree(root) {

	
	if (root == null)
		return null;

	// Recurse if not an orphan - move from last to first
	if (root.childNodes.length > 0) {
		for (var i = root.childNodes.length - 1; i >= 0; i--) {
			var child = root.childNodes[i];
			trimTree(child);
		}
	}

	if (root.childNodes.length == 0) {
		if (root._isFolder)
			root._remove();
	}

	return null;
}

function getACDLIcon(type) {
		return("images/ACDL/"+type+".gif");
}
