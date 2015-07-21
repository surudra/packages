//  TreeTable for IE
//  (c) webMethods
// 
//

var EXPAND = 0;
var COLLAPSE = 1;
var UNKNOWN = null;

// var packages;
var packages = new Array;
var composites = new Array;

// Arrays must be "prepped" to be containers of arrays.
// packages["test"] = ["test", "test2"];
// packages["test"][packages["test"].length] = "more";

function togglePackage(packageName)
{
	var currMode;
	currMode = getCookie(packageName);

	if (currMode == COLLAPSE) {
		for (package in packages[packageName]) {
			resourceName = packageName+packages[packageName][package];
			/*Start: Anurag TraxId # 1-1IAJ07*/
			if(navigator.appName=="Netscape"){
			document.all["resource_"+resourceName].style.display  = "table-row";
			}else if(navigator.appName=="Microsoft Internet Explorer"){
			document.all["resource_"+resourceName].style.display  = "inline";
			}
			/*End: Anurag TraxId # 1-1IAJ07*/
		}

		document.all["tree_"+packageName].src = "images/tree_minus.gif";
		setCookie(packageName, EXPAND);
	}
	else {
		for (package in packages[packageName]) {
			resourceName = packageName+packages[packageName][package];
			document.all["resource_"+resourceName].style.display  = "none";
		}

		document.all["tree_"+packageName].src = "images/tree_plus.gif";
		setCookie(packageName, COLLAPSE);
	}

}

function expandPackage(packageName) {
	if (getCookie(packageName) == COLLAPSE)
			togglePackage(packageName);
}

function setPkgChildren(type, self)
{
	var addPkg = false;

	if (type == "ADD")
		addPkg = confirm("Press OK to select the entire package.\nPress Cancel to select the referenced components.");

	if (addPkg) {

		// Uncheck and disable all resources beneath this folder
		for (package in packages[self.id]) {
			document.all["UNSET"+self.id+packages[self.id][package]].checked  = false;
			document.all["UNSET"+self.id+packages[self.id][package]].disabled = true;

			document.all["ADD"+self.id+packages[self.id][package]].checked  = false;
			document.all["ADD"+self.id+packages[self.id][package]].disabled = true;

			document.all["EXISTS"+self.id+packages[self.id][package]].checked  = false;
			document.all["EXISTS"+self.id+packages[self.id][package]].disabled = true;

			document.all["IGNORE"+self.id+packages[self.id][package]].checked  = false;
			document.all["IGNORE"+self.id+packages[self.id][package]].disabled = true;

		}
		// Expand the tree beneath package if collapsed
		// expandPackage(self.id);
	}
	else {
		// Enable all resources beneath this folder
		for (package in packages[self.id]) {
			document.all["UNSET"+self.id+packages[self.id][package]].disabled = false;
			document.all["ADD"+self.id+packages[self.id][package]].disabled = false;
			document.all["EXISTS"+self.id+packages[self.id][package]].disabled = false;
			document.all["IGNORE"+self.id+packages[self.id][package]].disabled = false;
		}
		setFolderChildren(type, self);

		// Clear parent Package ADD radio if components selected
		if (type == "ADD") {
			self.checked = false;
			// Expand the tree beneath package if collapsed
			expandPackage(self.id);
		}
	}
}

function setFolderChildren(type, self)
{

	// Select all resources beneath this folder - only if enabled
	for (package in packages[self.id]) 
		if (document.all[type+self.id+packages[self.id][package]].disabled == false)
			document.all[type+self.id+packages[self.id][package]].checked  = true;

}

// Decide if you want anything here
function saveProject(projectName)
{
	return true;
}

function setCookie(key, value) 
{
       var today = new Date();
       var expire = new Date();
       year = expire.getYear() + 1;
       expire.setYear(year);
       //Added to fix Tree problem in firefox copied verbatim from xtree.js
	 if (navigator.appName == "Microsoft Internet Explorer")
	 {
       	document.cookie = key + "=" + escape(value) + ";expires=" + expire.toGMTString() ;
	 }
	 else
	 {
		document.cookie = key + "=" + escape(value); 
	 }
}

function getCookie(key) 
{
	if (document.cookie.length) {
		var cookies = ' ' + document.cookie;
		var start = cookies.indexOf(' ' + key + '=');
		if (start == -1) { return null; }
		var end = cookies.indexOf(";", start);
		if (end == -1) { end = cookies.length; }
		end -= start;
		var cookie = cookies.substr(start,end);
		return unescape(cookie.substr(cookie.indexOf('=') + 1, cookie.length - cookie.indexOf('=') + 1));
	}
	else { return null; }
}

function setCompositeChildren(type, self, isPartialDeploymentSupported)
{	
	var addPkg = false;	
	
	if(isPartialDeploymentSupported == null || isPartialDeploymentSupported == '')
	{
		isPartialDeploymentSupported = 'true';
	}
	if(isPartialDeploymentSupported == 'true')
	{
		if (type == "ADD" )
			addPkg = confirm("Press OK to select the entire Composite.\nPress Cancel to select the referenced components.");
		if (addPkg) {
			// Uncheck and disable all resources beneath this folder
			for (package in composites[self.id]) {
				document.all["UNSET"+self.id+composites[self.id][package]].checked  = false;
				document.all["UNSET"+self.id+composites[self.id][package]].disabled = true;

				document.all["ADD"+self.id+composites[self.id][package]].checked  = false;
				document.all["ADD"+self.id+composites[self.id][package]].disabled = true;

				//document.all["EXISTS"+self.id+composites[self.id][package]].checked  = false;
				//document.all["EXISTS"+self.id+composites[self.id][package]].disabled = true;

				document.all["IGNORE"+self.id+composites[self.id][package]].checked  = false;
				document.all["IGNORE"+self.id+composites[self.id][package]].disabled = true;

			}
			// Expand the tree beneath package if collapsed
			// expandPackage(self.id);
		}
		else {
			// Enable all resources beneath this folder
			for (package in composites[self.id]) {
				document.all["UNSET"+self.id+composites[self.id][package]].disabled = false;
				document.all["ADD"+self.id+composites[self.id][package]].disabled = false;
				//document.all["EXISTS"+self.id+composites[self.id][package]].disabled = false;
				document.all["IGNORE"+self.id+composites[self.id][package]].disabled = false;
			}
			setComponentChildren(type, self);

			// Clear parent Package ADD radio if components selected
			if (type == "ADD") {
				self.checked = false;
				// Expand the tree beneath package if collapsed
				expandPackage(self.id);
			}
		}
	}
	else
	{ 	
		for (package in composites[self.id]) {
			document.all["UNSET"+self.id+composites[self.id][package]].checked  = false;
			document.all["UNSET"+self.id+composites[self.id][package]].disabled = true;

			document.all["ADD"+self.id+composites[self.id][package]].checked  = false;
			document.all["ADD"+self.id+composites[self.id][package]].disabled = true;

			//document.all["EXISTS"+self.id+composites[self.id][package]].checked  = false;
			//document.all["EXISTS"+self.id+composites[self.id][package]].disabled = true;
//
		document.all["IGNORE"+self.id+composites[self.id][package]].checked  = false;
		document.all["IGNORE"+self.id+composites[self.id][package]].disabled = true;

		}
	}
}

function setComponentChildren(type, self)
{
	// Select all resources beneath this folder - only if enabled
	for (package in composites[self.id]) 
		if (document.all[type+self.id+composites[self.id][package]].disabled == false)
			document.all[type+self.id+composites[self.id][package]].checked  = true;

}

function toggleComposite(compositeName)
{
	var currMode;
	currMode = getCookie(compositeName);

	if (currMode == COLLAPSE) {
		for (package in composites[compositeName]) {
			resourceName = compositeName+composites[compositeName][package];
			/*Start: Anurag TraxId # 1-1IAJ07*/
			if(navigator.appName=="Netscape"){
			document.all["resource_"+resourceName].style.display  = "table-row";
			}else if(navigator.appName=="Microsoft Internet Explorer"){
			document.all["resource_"+resourceName].style.display  = "inline";
			}
			/*End: Anurag TraxId # 1-1IAJ07*/
		}

		document.all["tree_"+compositeName].src = "images/tree_minus.gif";
		setCookie(compositeName, EXPAND);
	}
	else {
		for (package in composites[compositeName]) {
			resourceName = compositeName+composites[compositeName][package];
			document.all["resource_"+resourceName].style.display  = "none";
		}

		document.all["tree_"+compositeName].src = "images/tree_plus.gif";
		setCookie(compositeName, COLLAPSE);
	}

}

function expandComposite(compositeName) {
	if (getCookie(compositeName) == COLLAPSE)
			toggleComposite(compositeName);
}
