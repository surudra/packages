var gSubMask = null;
var gSubContainer = null;
var gSubFrame = null;
var gReturnFunc;
var gSubIsShown = false;
var gHideSelects = false;
var gLoading = "";
var gTabIndexes = new Array();
var gTabbableTags = new Array("A","BUTTON","TEXTAREA","INPUT","IFRAME");	
if (!document.all) {document.onkeypress = keyDownHandler;}
function initSub() {
	var body = document.getElementsByTagName('body')[0];
	var submask = document.createElement('div');
	submask.id = 'subMask';
	var subcont = document.createElement('div');
	subcont.id = 'subContainer';
	subcont.innerHTML = '' +
		'<div id="subInner">' +
			'<div id="subTitleBar">' +
				'<div id="subTitle"></div>' +
				'<div id="subControls">' +
					'<a onclick="hideSub(false);"><span>Close</span></a>' +
				'</div>' +
			'</div>' +
			'<iframe src="'+gLoading+'" style="width:100%;height:100%;background-color:transparent;" scrolling="auto" frameborder="0" allowtransparency="true" id="subFrame" name="subFrame" width="100%" height="100%"></iframe>' +
		'</div>';
	body.appendChild(submask);
	body.appendChild(subcont);
	
	gSubMask = document.getElementById("subMask");
	gSubContainer = document.getElementById("subContainer");
	gSubFrame = document.getElementById("subFrame");	
	
	var brsVersion = parseInt(window.navigator.appVersion.charAt(0), 10);
	if (brsVersion <= 6 && window.navigator.userAgent.indexOf("MSIE") > -1) {
		gHideSelects = true;
	}
	
	// Add onclick handlers to 'a' elements of class submodal or submodal-width-height
	var elms = document.getElementsByTagName('a');
	for (i = 0; i < elms.length; i++) {
		if (elms[i].className.indexOf("submodal") >= 0) { 
			elms[i].onclick = function(){
				// default width and height
				var width = 304;
				var height = 409;
				showSub(this.href,width,height,null); return false;
			}
		}
	}
}
addEvent(window, "load", initSub);

function showSub(url, width, height, returnFunc) {
	gSubIsShown = true;
	if (document.all) {
		var i = 0;
		for (var j = 0; j < gTabbableTags.length; j++) {
			var tagElements = document.getElementsByTagName(gTabbableTags[j]);
			for (var k = 0 ; k < tagElements.length; k++) {
				gTabIndexes[i] = tagElements[k].tabIndex;
				tagElements[k].tabIndex="-1";
				i++;
			}
		}
	}
	gSubMask.style.display = "block";
	gSubContainer.style.display = "block";
	centerSub(width, height);
	var titleBarHeight = parseInt(document.getElementById("subTitleBar").offsetHeight, 10);
	gSubContainer.style.width = width + "px";
	gSubContainer.style.height = (height+titleBarHeight) + "px";
	gSubFrame.style.width = parseInt(document.getElementById("subTitleBar").offsetWidth, 10) + "px";
	gSubFrame.style.height = (height) + "px";
	gSubFrame.src = url;
	gReturnFunc = returnFunc;
	if (gHideSelects == true) {
	  for(var i = 0; i < document.forms.length; i++) {
		for(var e = 0; e < document.forms[i].length; e++){
			if(document.forms[i].elements[e].tagName == "SELECT") {
				document.forms[i].elements[e].style.visibility="hidden";
			}
		}
	  }
	}

	window.setTimeout("setSubTitleAndRewriteTargets();", 100);
}
var gi = 0;
function centerSub(width, height) {
	if (gSubIsShown == true) {
		if (width == null || isNaN(width)) {
			width = gSubContainer.offsetWidth;
		}
		if (height == null) {
			height = gSubContainer.offsetHeight;
		}
		var fullHeight = window.undefined;
		if (window.innerHeight!=window.undefined) fullHeight = window.innerHeight;
		if (document.compatMode=='CSS1Compat') fullHeight = document.documentElement.clientHeight;
		if (document.body) fullHeight = document.body.clientHeight; 
		
		var fullWidth = window.undefined;

		if (window.innerWidth!=window.undefined) fullWidth = window.innerWidth; 
		if (document.compatMode=='CSS1Compat') fullWidth = document.documentElement.clientWidth; 
		if (document.body) fullWidth = document.body.clientWidth;
		
		var scLeft,scTop;
		if (self.pageYOffset) {
			scLeft = self.pageXOffset;
			scTop = self.pageYOffset;
		} else if (document.documentElement && document.documentElement.scrollTop) {
			scLeft = document.documentElement.scrollLeft;
			scTop = document.documentElement.scrollTop;
		} else if (document.body) {
			scLeft = document.body.scrollLeft;
			scTop = document.body.scrollTop;
		} 
		gSubMask.style.height = fullHeight + "px";
		gSubMask.style.width = fullWidth + "px";
		gSubMask.style.top = scTop + "px";
		gSubMask.style.left = scLeft + "px";
		window.status = gSubMask.style.top + " " + gSubMask.style.left + " " + gi++;
		var titleBarHeight = parseInt(document.getElementById("subTitleBar").offsetHeight, 10);
		var topMargin = scTop + ((fullHeight - (height+titleBarHeight)) / 2);
		if (topMargin < 0) { topMargin = 0; }
		gSubContainer.style.top = topMargin + "px";
		gSubContainer.style.left =  (scLeft + ((fullWidth - width) / 2)) + "px";
	}
}
addEvent(window, "resize", centerSub);
window.onscroll = centerSub;
function hideSub(callReturnFunc) {
	gSubIsShown = false;

	if (document.all) {
		var i = 0;
		for (var j = 0; j < gTabbableTags.length; j++) {
			var tagElements = document.getElementsByTagName(gTabbableTags[j]);
			for (var k = 0 ; k < tagElements.length; k++) {
				tagElements[k].tabIndex = gTabIndexes[i];
				tagElements[k].tabEnabled = true;
				i++;
			}
		}
	}

	if (gSubMask == null) {
		return;
	}
	gSubMask.style.display = "none";
	gSubContainer.style.display = "none";
	if (callReturnFunc != false) {
		callback(callReturnFunc);
	}
	gSubFrame.src = gLoading;
	if (gHideSelects == true) {
	  for(var i = 0; i < document.forms.length; i++) {
		for(var e = 0; e < document.forms[i].length; e++){
			if(document.forms[i].elements[e].tagName == "SELECT") {
			document.forms[i].elements[e].style.visibility="visible";
			}
		}
	  }
	}
}
function setSubTitleAndRewriteTargets() {
	if (window.frames["subFrame"].document.title == null) {
		window.setTimeout("setSubTitleAndRewriteTargets();", 10);
	} else {
		var subDocument = window.frames["subFrame"].document;
		document.getElementById("subTitle").innerHTML = subDocument.title;
		if (subDocument.getElementsByTagName('base').length < 1) {
			var aList  = window.frames["subFrame"].document.getElementsByTagName('a');
			for (var i = 0; i < aList.length; i++) {
				if (aList.target == null) aList[i].target='_parent';
			}
			var fList  = window.frames["subFrame"].document.getElementsByTagName('form');
			for (i = 0; i < fList.length; i++) {
				if (fList.target == null) fList[i].target='_parent';
			}
		}
	}
}
function keyDownHandler(e) {
    if (gSubIsShown && e.keyCode == 9)  return false;
}
function addEvent(obj, evType, fn){
 if (obj.addEventListener){
    obj.addEventListener(evType, fn, false);
    return true;
 } else if (obj.attachEvent){
    var r = obj.attachEvent("on"+evType, fn);
    return r;
 } else {
    return false;
 }
}
