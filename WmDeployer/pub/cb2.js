/*
 * This script was created by Erik Arvidsson (http://webfx.eae.net/contact.html#erik)
 * for WebFX (http://webfx.eae.net
 * Copyright 2001
 * 
 * For usage see license at http://webfx.eae.net/license.html	
 *
 * Created: 2001-03-17
 */

/*
 * This file depends on emulateAttachEvent and extendEventObject
 * found in ieemu.js to get Mozilla to work
 * 
 * Styling is currently done in a separate css files
 * cb2.css
 *
 */

/* Set up IE Emualtion for Mozilla */
if (window.moz == true && (typeof window.emulateAttachEvent != "function" || typeof window.extendEventObject != "function"))
	alert("Error! IE Emulation file not included.");

if (window.moz) {
	emulateAttachEvent();
	extendEventObject();
}
/* end Mozilla specific emulation initiation */

function createButton(el, _class) {

	el.attachEvent("onmouseover",	createButton.overCoolButton);
	el.attachEvent("onmouseout",	createButton.outCoolButton);
	el.attachEvent("onmousedown",	createButton.downCoolButton);
	el.attachEvent("onmouseup",		createButton.upCoolButton);
	el.attachEvent("onclick",		createButton.clickCoolButton);
	el.attachEvent("ondblclick",	createButton.clickCoolButton);
	el.attachEvent("onkeypress",	createButton.keypressCoolButton);
	el.attachEvent("onkeyup",		createButton.keyupCoolButton);
	el.attachEvent("onkeydown",		createButton.keydownCoolButton);
	el.attachEvent("onfocus",		createButton.focusCoolButton);
	el.attachEvent("onblur",		createButton.blurCoolButton);
	
	el._class = (_class == null) ? "cool" : _class;

	el.className = el._class + "Button";
	
	el.setEnabled	= createButton.setEnabled;
	el.getEnabled	= createButton.getEnabled;
	el.setValue		= createButton.setValue;
	el.getValue		= createButton.getValue;
	el.setToggle	= createButton.setToggle;
	el.getToggle	= createButton.getToggle;
	el.setAlwaysUp	= createButton.setAlwaysUp;
	el.getAlwaysUp	= createButton.getAlwaysUp;
	el.setSelected	= createButton.setSelected;
	el.clickCoolButton = createButton.clickCoolButton;
	
	el._enabled		= true;
	el._toggle		= false;
	el._value		= false;
	el._alwaysUp	= false;
	// Tom extension
	el._selected	= false;
	
	return el;
}

createButton.LEFT = window.moz ? 0 : 1;

/* event listeners */

createButton.overCoolButton = function () {
	var toEl = createButton.getParentCoolButton(window.event.toElement);
	var fromEl = createButton.getParentCoolButton(window.event.fromElement);
	if (toEl == fromEl || toEl == null) return;
	
	toEl._over = true;
	
	if (!toEl._enabled) return;
	
	createButton.setClassName(toEl);
};

createButton.outCoolButton = function () {
	var toEl = createButton.getParentCoolButton(window.event.toElement);
	var fromEl = createButton.getParentCoolButton(window.event.fromElement);
	if (toEl == fromEl || fromEl == null) return;
	
	fromEl._over = false;
	if (!fromEl._selected)
		fromEl._down = false;
	
	if (!fromEl._enabled) return;	

	createButton.setClassName(fromEl);
};

createButton.downCoolButton = function () {
	if (window.event.button != createButton.LEFT) return;
	
	var el = createButton.getParentCoolButton(window.event.srcElement);
	if (el == null) return;
	
	el._down = true;
	
	if (!el._enabled) return;

	createButton.setClassName(el);
};

createButton.upCoolButton = function () {
	if (window.event.button != createButton.LEFT) return;
	
	var el = createButton.getParentCoolButton(window.event.srcElement);
	if (el == null) return;
	
	// Only pop up if not selected
	if (!el._selected)
		el._down = false;
	
	if (!el._enabled) return;
	
	if (el._toggle)
		el.setValue(!el._value);
	else
		createButton.setClassName(el);
};

createButton.clickCoolButton = function () {
 	var el = createButton.getParentCoolButton(window.event.srcElement);
	el.onaction = el.getAttribute("onaction");
	if (el == null || !el._enabled || el.onaction == "" || el.onaction == null) return;
	
	if (typeof el.onaction == "string")
		el.onaction = new Function ("event", el.onaction);
	
	el.onaction(window.event);
};

createButton.keypressCoolButton = function () {
	var el = createButton.getParentCoolButton(window.event.srcElement);
	if (el == null || !el._enabled || window.event.keyCode != 13) return;
	
	el.setValue(!el._value);
	
	if (el.onaction == null) return;
	
	if (typeof el.onaction == "string")
		el.onaction = new Function ("event", el.onaction);
	
	el.onaction(window.event);
};

createButton.keydownCoolButton = function () {
	var el = createButton.getParentCoolButton(window.event.srcElement);
	if (el == null || !el._enabled || window.event.keyCode != 32) return;
	createButton.downCoolButton();
};

createButton.keyupCoolButton = function () {
	var el = createButton.getParentCoolButton(window.event.srcElement);
	if (el == null || !el._enabled || window.event.keyCode != 32) return;
	createButton.upCoolButton();
	
	//el.setValue(!el._value);	// is handled in upCoolButton()
	
	if (el.onaction == null) return;
	
	if (typeof el.onaction == "string")
		el.onaction = new Function ("event", el.onaction);
	
	el.onaction(window.event);
};

createButton.focusCoolButton = function () {
	var el = createButton.getParentCoolButton(window.event.srcElement);
	if (el == null || !el._enabled) return;
	createButton.setClassName(el);
};

createButton.blurCoolButton = function () {
	var el = createButton.getParentCoolButton(window.event.srcElement);
	if (el == null) return;
	
	createButton.setClassName(el)
};

createButton.getParentCoolButton = function (el) {
	if (el == null) return null;
	if (/Button/.test(el.className))
		return el;
	return createButton.getParentCoolButton(el.parentNode);
};

/* end event listeners */

createButton.setClassName = function (el) {
	var over = el._over;
	var down = el._down;
	var focused;
	try {
		focused = (el == document.activeElement && el.tabIndex > 0);
	}
	catch (exc) {
		focused = false;
	}
	
	if (!el._enabled) {
		if (el._value)
			el.className = el._class + "ButtonActiveDisabled";
		else
			el.className = el._alwaysUp ? el._class + "ButtonUpDisabled" : el._class + "ButtonDisabled";
	}
	else {
		if (el._value) {
			if (over || down || focused)
				el.className = el._class + "ButtonActiveHover";
			else
				el.className = el._class + "ButtonActive";
		}
		else {
			if (down)
				el.className = el._class + "ButtonActiveHover";
			else if (over || el._alwaysUp || focused)
				el.className = el._class + "ButtonHover";
			else
				el.className = el._class + "Button";
		}
	}
};

createButton.setEnabled = function (b) {
	if (this._enabled != b) {
		this._enabled = b;
		createButton.setClassName(this, false, false);
		if (!window.moz) {
			if (b)
				this.innerHTML = this.firstChild.firstChild.innerHTML;
			else
				this.innerHTML = "<span class='" + this._class + "ButtonDisabledContainer'><span class='" + this._class + "ButtonDisabledContainer'>" + this.innerHTML + "</span></span>";
		}
	}
};

createButton.getEnabled = function () {
	return this._enabled;
};

createButton.setValue = function (v, bDontTriggerOnChange) {
	if (this._toggle && this._value != v) {
		this._value = v;
		createButton.setClassName(this, false, false);
		
		this.onchange = this.getAttribute("onchange");
		
		if (this.onchange == null || this.onchange == "" || bDontTriggerOnChange) return;
		
		if (typeof this.onchange == "string")
			this.onchange = new Function("", this.onchange);

		this.onchange();
	}
};

createButton.getValue = function () {
	return this._value;
};

createButton.setToggle = function (t) {
	if (this._toggle != t) {
		this._toggle = t;
		if (!t) this.setValue(false);
	}
};

createButton.getToggle = function () {
	return this._toggle;
};

createButton.setAlwaysUp = function (up) {
	if (this._alwaysUp != up) {
		this._alwaysUp = up;
		createButton.setClassName(this, false, false);
	}
};

createButton.getAlwaysUp = function () {
	return this._alwaysUp;
};

// Tom stuff to make the button selection more obvious
createButton.setSelected = function () {
	this._alwaysUp = false;
	this._down = true;
	this._selected = true;
	this._toggle = true;
	createButton.setClassName(this);
};
