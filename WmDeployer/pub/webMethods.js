var row = "even";
var other = "odd";
var swap = "";

var path1 = "";
var menu1 = "";
var path1_class = "";


var normal = 1;
var error  = 2;
var serverkey = 4;

//*** CSRF****
var src = "";
var _csrfTokenNm_           =  _csrfTokenNm_;
var _csrfTokenVal_			=  _csrfTokenVal_;	
var is_csrf_guard_enabled   =  is_csrf_guard_enabled;
var needToInsertToken       =  needToInsertToken;

if(is_csrf_guard_enabled != true && is_csrf_guard_enabled != false) {
	is_csrf_guard_enabled = false;
}

if(needToInsertToken != true && needToInsertToken != false) {
	needToInsertToken = false;
}


//**********NEW************
//START
function  confirmDelete(item, not_sure)
{
	return confirm("Are you sure you want to remove " + item + "?")
}
//END
//**********NEW************

function w(text)
{
	document.write(text);
}


function pathInit(css_class)
{
	path1 = "";
	path1_class = css_class;
	
}

function pathAdd(text, url)
{
	path1 += text;
	path1 += " &gt; ";
}

function pathShow()
{
	w("<table width=100% >");
	w("<tr>");
	w("<td class=" + path1_class + ">");
	w(path1);
	w("</td></tr></table>");
}


function menuInit()
{
	menu1 = "";
	
}


function menuAdd(text, url, bonus_text)
{
	menu1 += "<li>";
	menu1 += "<a href=\"" + url + "\">" + text + "</a>";
	if (bonus_text)
	{
		menu1 += "<br>"
		menu1 += bonus_text;
	}
	menu1 += "</li>";

}


function menuShow()
{
	w("<table width=100% >");
	w("<tr>");
	w("<td>");  //class=\"submenu\"
	w("<ul>");
	w(menu1);
	w("</ul>");
	w("</td></tr></table>");

}



function messageInit()
{
	message1 = "";
	
}


function messageAdd(text, message_type)
{
	menu1 += text;

}


function messageShow()
{
	w("<table width=100% >");
	w("<tr>");
	w("<td class=\"message\">");
	w(menu1);
	w("</td>");
	w("</tr>");
	w("</table>");
}



function writeEditPass(mode, name, value)
{
	if(mode == 'edit')
	{
		w("<input type=\"password\" name=\""+name+"\" value=\""+value+"\">");
	}
	else
	{
		if(value == "")
			value = "unspecified";
		w(value);
	}
}

function writeEdit(mode, name, value)
{
	if(mode == 'edit')
	{
		w("<input type=\"text\" name=\""+name+"\" value=\""+value+"\">");
	}
	else
	{
		if(value == "")
			value = "unspecified";
		w(value);
	}
}

function writeMessage(msg)
{
	w("<TR><TD class=\"message\" colspan=4>&nbsp;&nbsp;&nbsp;&nbsp;"+msg+"</TD></TR>");
}

function writeError(msg)
{
	w("<TR><TD class=\"error\" colspan=4>&nbsp;&nbsp;&nbsp;&nbsp;"+msg+"</TD></TR>");
}

function writeWarning(msg)
{
	w("<TR><TD class=\"warning\" colspan=4>&nbsp;&nbsp;&nbsp;&nbsp;"+msg+"</TD></TR>");
}

function reloadTopFrame()
{
	parent.topmenu.location.replace("top.dsp");
}

function writeTD (c)
{
	w("<TD CLASS=\"");
	w(row);
	w(c);
	w("\">");
	return true;
}

function writeTD (c, options)
{
	w("<TD CLASS=\"");
	w(row);
	w(c);
	w("\"" + options + ">");
	return true;
}

function writeTDspan(c,span)
{
	w("<TD CLASS=\"");
	w(row);
	w(c);
	w("\" COLSPAN=");
	w(span);
	w(">");
}

function writeTDrowspan(c,span)
{
	w("<TD CLASS=\"");
	w(row);
	w(c);
	w("\" ROWSPAN=");
	w(span);
	w(">");
}

function swapRows()
{
	swap = row;
	row = other;
	other = swap;
}

function resetRows()
{
	row = "even";
	other = "odd";
	swap = "";
}


function isNum(num) 
{
  	num = num.toString();

  	if (num.length == 0)
  	  	return false;

  	for (var i = 0; i < num.length; i++)
    	if (num.substring(i, i+1) < "0" || num.substring(i, i+1) > "9")
      		return false;

  	return true;
}


function verifyRequiredField(form, field)
{
	if (document.forms[form][field].value == "")
	{
		document.forms[form][field].focus();
		return false;
	}
	return true;
 }

function verifyRequiredNonNegNumber(form, fieldName)
{
	var field = document.forms[form][fieldName];

	if (field.value == "")
	{
		field.focus();
		return false;
	}

	if ( !isNum(field.value))
	{
		field.focus();
		return false;
	}

	if ( field.value < 0)
	{
		field.focus();
		return false;
	}

	return true;
}



function verifyRequiredFieldList(form, fieldList)
{
	for (index in fieldList)
	{
	   if (!verifyRequiredField(form, fieldList[index]))
	   {
		  alert ("Error: The selected field requires valid data.");
		  return false;
	   }
	}
	return true;
 }

function verifyFieldsEqual(form, field1, field2)
{
	if (document.forms[form][field1].value != document.forms[form][field2].value)
	{
		alert("Error: Fields must have the same value.  Try typing them in again.");
		document.forms[form][field1].focus();
		return false;
	}
	return true;
}

function setNavigation(doc_url, help_url, is_doc)
{
 	if(parent == null || parent.frames == null || parent.framebody.frameleft == null || parent.framebody.frameleft.document == null)
 		return false;
 
 	if(parent.framebody.frameleft.moveArrow != null)
 	{
 		if(is_doc != null) parent.framebody.frameleft.moveArrow(doc_url);
 		else
 		parent.framebody.frameleft.moveArrow(doc_url+location.search);
   	}
 
 	if(parent.framebody.frameleft.document.forms["urlsaver"] != null && parent.framebody.frameleft.document.forms["urlsaver"].helpURL != null)
 		parent.framebody.frameleft.document.forms["urlsaver"].helpURL.value = help_url;

    	
        return true;
        
}  


function initMenu(firstImage)
{
	var previousMenuImage = document.images[firstImage];
	previousMenuImage.src="images/selectedarrow.gif";
	return true;
}

function isblank(s)
{
    	for (var i=0; i<s.length; i++ ) {
        	var c  = s.charAt(i);
        	if ((c != ' ') && (c != '\n') && (c != '\t')) 
          		return false;
        }
        return true;
}

function normalize(text) {
        var newstring = "";
        for(var i = 0; i < text.length; i++){
	        if(text.substring(i,i+1) == "\uff11") newstring += "1"; 
	        else if(text.substring(i,i+1) == "\uff12") newstring += "2"; 
	        else if(text.substring(i,i+1) == "\uff13") newstring += "3"; 
	        else if(text.substring(i,i+1) == "\uff14") newstring += "4"; 
	        else if(text.substring(i,i+1) == "\uff15") newstring += "5"; 
	        else if(text.substring(i,i+1) == "\uff16") newstring += "6"; 
	        else if(text.substring(i,i+1) == "\uff17") newstring += "7"; 
	        else if(text.substring(i,i+1) == "\uff18") newstring += "8"; 
	        else if(text.substring(i,i+1) == "\uff19") newstring += "9"; 
	        else if(text.substring(i,i+1) == "\uff10") newstring += "0"; 
                else if(text.substring(i,i+1) == "\uff0e") newstring += ".";
                else if(text.substring(i,i+1) == "\u3002") newstring += ".";
                else newstring += text.substring(i,i+1);
	}
	return newstring;
}

function isIllegalName(name) {
	var illegalChars = "#&@^!%*:$/\\`';,~+=><\"";
	// var illegalChars = "- #&@^!%*:$./\\`;,~+=)(|}{][><\"";

	for (var i=0; i<illegalChars.length; i++) {
		if (name.indexOf(illegalChars.charAt(i)) >= 0)
			return false;
	}
	return true;
}

// This totally depends on the Progress Bar in the menu frame
function startProgressBar(title) {
	return true;
}

// This totally depends on the Progress Bar in the menu frame
function stopProgressBar() {
		return true;
}

function xl(text)
{
    var out = "";
    var t = "";
    for(var i = 0;i < text.length;i++){
	t = text.substring(i, i+1);
	if(t == "<"){
	    out += "&lt;";
	}
	else if(t == ">"){
	    out += "&gt;";
	}
	else{
	    out += t;
	}
    }	
    document.write(out);
}

function trim(s) {
  while (s.substring(0,1) == ' ') {
    s = s.substring(1,s.length);
  }
  while (s.substring(s.length-1,s.length) == ' ') {
    s = s.substring(0,s.length-1);
  }
  return s;
}

function matchRegularExpression(regExpStr, matchStr)
{
	
	if (regExpStr == null)
		return true;

	try
	{
		var Pattern = new RegExp(regExpStr);
		var match = Pattern.exec(matchStr);
		if (match != null)
			return true;
	}
	catch (e)
	{
		// default to matching, just in case things are goofy
		return true;
	}

	return false;
}

function testRegularExpression(regExpStr)
{
	
	if (regExpStr == null)
		return true;

	try
	{
		var Pattern = new RegExp(regExpStr);
		var match = Pattern.exec("My dog has fleas.");
	}
	catch (e)
	{
		return false;
	}

	return true;
}

function isIPv6Address(host){
	var ipv6Pattern = /^\s*((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4}){0,3}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:)))(%.+)?\s*$/;
	var isIPv6Address = false;
	host = trim(host);
	if (host!='') {
		if (host.indexOf('[')==0 && host.lastIndexOf(']')== host.length-1) {
			host = host.substring(1, host.length- 1);
		}
		isIPv6Address = ipv6Pattern.test(host);
	}
		
	return isIPv6Address;
}

function concatHostAndPortString(host,port) {
	var retval = (host == '') ? '' : trim(host);
	if (!isblank(port)) {
	var isIPv6 = isIPv6Address(retval);
		if (isIPv6&&!(retval.indexOf('[')==0 && retval.lastIndexOf(']')== retval.length-1)) {
			retval = '[' + retval +']'; //surround host name with [] 
		}
		retval = retval+':'+port;
	}
	return retval;
}

function splitHostAndPortString(hostwithPortString) {
	var ipDetails = ["",""];

	if (!isblank(hostwithPortString)) {
		hostwithPortString = trim(hostwithPortString);
		ipDetails[0] = hostwithPortString;
		var index = -1;
		// To ensure that the entered String ipAddress has a port number towards the end,
		//if  it doesn't , do not enter the if block returning only the host in 1st index of array ipDetails
		if (!isIPv6Address(hostwithPortString)) {
			if (hostwithPortString.indexOf('[')==0
					&& (index = hostwithPortString.lastIndexOf("]:")) > -1) {
				ipDetails[0] = hostwithPortString.substring(1, index);//ignore the '[' and ']' 
				ipDetails[1] = hostwithPortString.substring(index + 2);
			} else {
				// for IPv4 address- if ipAddress consists only of hostName
				// , indexOf returns -1 and empty port string is returned.
				index = hostwithPortString.lastIndexOf(':');
				if (index > -1) {
					ipDetails[0] = hostwithPortString.substring(0, index);
					ipDetails[1] = hostwithPortString.substring(index + 1);
				}
			}
		}
	}
	return ipDetails;
}
