/*!
* CrushFTP Common methods
*
* Copyright @ SoftwareAG
*
*/

// Various methods that adds form functionalities and prototypes to existing methods

//jQuery function, clears form fields
$.fn.clearForm = function () {
    return this.each(function () {
        var type = this.type,
            tag = this.tagName.toLowerCase();
        if (tag == 'form' || tag == 'div') return $(':input', this).clearForm();
        if (type == 'text' || type == 'password' || tag == 'textarea') this.value = '';
        else if (type == 'checkbox' || type == 'radio') {
            this.checked = false;
        crushFTP.UI.checkUnchekInput($(this), false);
        }
        else if (tag == 'select') this.selectedIndex = -1;
    });
};

jQuery.fn.offsetRelativeTo = function(el){
  var $el=$(el), o1=this.offset(), o2=$el.offset();
  o1.top  -= o2.top  - $el.scrollTop();
  o1.left -= o2.left - $el.scrollLeft();
  return o1;
}

//Create buttons UI
function buildButtons(context){
    $(".button", context).each(function(){
        var icon = $(this).attr("icon");
        if(icon)
        {
            $(this).button(
            {
                icons: {
                    primary: icon
                }
            });
        }
        else
        {
            $(this).button();
        }
    });
}

//Swap 2 array items
Array.prototype.swapItems=function(a, b){
    var temp = this[a];
    this[a] = this[b];
    this[b] = temp;
    return this;
}

// Check if specified array has item
Array.prototype.has = function (value) {
    var i;
    for (var i = 0, loopCnt = this.length; i < loopCnt; i++) {
        if (this[i] === value) {
            return true;
        }
    }
    return false;
};

// Few buggy browsers does not have indexOf for an array, add it if not available
if(!Array.prototype.indexOf)
{
    Array.prototype.indexOf = function (value) {
        var i;
        for (var i = 0, loopCnt = this.length; i < loopCnt; i++) {
            if (this[i] === value) {
                return i;
            }
        }
        return -1;
    };
}

if (!('filter' in Array.prototype)) {
    Array.prototype.filter= function(filter, that /*opt*/) {
        var other= [], v;
        for (var i=0, n= this.length; i<n; i++)
            if (i in this && filter.call(that, v= this[i], i, this))
                other.push(v);
        return other;
    };
}

//Array diff
Array.prototype.diff = function(a) {
    return this.filter(function(i) {return !(a.indexOf(i) > -1);});
};

// Array Remove - By John Resig (MIT Licensed)
Array.prototype.remove = function(from, to) {
  var rest = this.slice((to || from) + 1 || this.length);
  this.length = from < 0 ? this.length + from : from;
  return this.push.apply(this, rest);
};

Array.prototype.removeByVal = function(){
    var what, a= arguments, L= a.length, ax;
    while(L && this.length){
        what= a[--L];
        while((ax= this.indexOf(what))!= -1){
            this.splice(ax, 1);
        }
    }
    return this;
}

Array.prototype.insert = function (index, item) {
  this.splice(index, 0, item);
};

//Max val in array
Array.prototype.max = function() {
    var max = this[0];
    var len = this.length;
    for (var i = 1; i < len; i++) if (this[i] > max) max = this[i];
    return max;
}

// Zero-Fill
String.prototype.zf = function(l) { return '0'.string(l - this.length) + this; }
Number.prototype.zf = function(l) { return this.toString().zf(l); }

// VB-like string
String.prototype.string = function(l) { var s = '', i = 0; while (i++ < l) { s += this; } return s; }

// Capitalize first character
String.prototype.capitalize = function() {
    return this.charAt(0).toUpperCase() + this.slice(1);
}

//Clean array, usage array.clean("");
Array.prototype.clean = function(deleteValue) {
  for (var i = 0; i < this.length; i++) {
    if (this[i] == deleteValue) {
      this.splice(i, 1);
      i--;
    }
  }
  return this;
};

// Date format prototype : http://www.codeproject.com/KB/scripting/dateformat.aspx
Date.prototype.format = function(f)
{
    if (!this.valueOf())
        return ' ';

    var d = this;

    return f.replace(/(yyyy|mmmm|mmm|mm|dddd|ddd|dd|hf|hh|nn|ss|a\/p)/gi,
        function($1)
        {
            switch ($1.toLowerCase())
            {
            case 'yyyy': return d.getFullYear();
            case 'mmmm': return gsMonthNames[d.getMonth()];
            case 'mmm':  return gsMonthNames[d.getMonth()].substr(0, 3);
            case 'mm':   return (d.getMonth() + 1).zf(2);
            case 'dddd': return gsDayNames[d.getDay()];
            case 'ddd':  return gsDayNames[d.getDay()].substr(0, 3);
            case 'dd':   return d.getDate().zf(2);
            case 'hf':   return d.getHours();
            case 'hh':   return ((h = d.getHours() % 12) ? h : 12).zf(2);
            case 'nn':   return d.getMinutes().zf(2);
            case 'ss':   return d.getSeconds().zf(2);
            case 'a/p':  return d.getHours() < 12 ? 'AM' : 'PM';
            }
        }
    );
}

if(!String.prototype.shuffle)
{
    String.prototype.shuffle = function () {
        var a = this.split(""),
            n = a.length;

        for(var i = n - 1; i > 0; i--) {
            var j = Math.floor(Math.random() * (i + 1));
            var tmp = a[i];
            a[i] = a[j];
            a[j] = tmp;
        }
        return a.join("");
    }
}

function getTextFromXML(doc)
{
    var string = "";
    //for IE
    if ($.browser.msie && parseInt(jQuery.browser.version) == 10) {
       string = (new XMLSerializer()).serializeToString(doc);
    }
    else
    {
        if (window.ActiveXObject) {
            string = doc.xml;
        } else {
            string = (new XMLSerializer()).serializeToString(doc);
        }
    }
    return string;
}

// Adding in-case sensitive filter
jQuery.expr[':'].Contains = function(a,i,m){
    return (a.textContent || a.innerText || "").toUpperCase().indexOf(m[3].toUpperCase())>=0;
};

//A Delay method based on timeout
var delay = (function () {
    var timer = 0;
    return function (callback, ms) {
        clearTimeout(timer);
        timer = setTimeout(callback, ms);
    };
})();

(function() {
  function DateDiff(date1, date2) {
    this.days = null;
    this.hours = null;
    this.minutes = null;
    this.seconds = null;
    this.date1 = date1;
    this.date2 = date2;
    this.init();
  }

  DateDiff.prototype.init = function() {
    var data = new DateMeasure(this.date1 - this.date2);
    this.days = data.days;
    this.hours = data.hours;
    this.minutes = data.minutes;
    this.seconds = data.seconds;
  };

  function DateMeasure(ms) {
    var d, h, m, s;
    s = Math.floor(ms / 1000);
    m = Math.floor(s / 60);
    s = s % 60;
    h = Math.floor(m / 60);
    m = m % 60;
    d = Math.floor(h / 24);
    h = h % 24;

    this.days = d;
    this.hours = h;
    this.minutes = m;
    this.seconds = s;
  };

  Date.diff = function(date1, date2) {
    return new DateDiff(date1, date2);
  };

  Date.prototype.diff = function(date2) {
    return new DateDiff(this, date2);
  };
})();

var crushFTP = {
    ajaxCallURL : "/WebInterface/function/",
    indicatorHTML : "<div class='loadingIndicator'><img src='/WebInterface/Resources/images/process_indicator.gif' alt='loding indicator' /></div>",
    buggyBrowser : $.browser.msie && $.browser.version <= 8,
    notAllowedChars : "!@#$%^&*()+=-[]\\\';,./{}|\":<>?~_ ",
    placeHolder : $("#placeHolder"),
    defaultRequestType : "POST",
    UI :
    {
        addItem : function(listing, newControl, data, callback)
        {
            listing.append(newControl);
            newControl.data("controlData", data);
            newControl.parent().find(".ui-widget-header").removeClass("ui-widget-header").removeClass("ui-selected");
            newControl.addClass("ui-widget-header").addClass("ui-selected");
            listing.closest("div.sideScroll").scrollTo(newControl);
            if(callback)
                callback(newControl);
        },
        replaceItem : function(oldControl, newControl, data, callback)
        {
            oldControl.replaceWith(newControl);
            newControl.data("controlData", data);
            newControl.parent().find(".ui-widget-header").removeClass("ui-widget-header").removeClass("ui-selected");
            newControl.addClass("ui-widget-header").addClass("ui-selected");
            if(callback)
                callback(newControl);
        },
        removeItem : function(listing, callback, noConfirm, classToAdd)
        {
            var selected = listing.find("li.ui-selected");
            if(selected.length==0)return;
            function continueRemove(flag)
            {
                var toFocus = [];
                if(selected.next("li").length>0)
                {
                    toFocus = selected.next("li");
                }
                else if(selected.prev("li").length>0)
                {
                    toFocus = selected.prev("li");
                }
                selected.remove();
                if(toFocus.length>0)
                {
                    toFocus.parent().find(".ui-widget-header").removeClass("ui-widget-header").removeClass("ui-selected");
                    if(!classToAdd)
                        toFocus.addClass("ui-widget-header").addClass("ui-selected");
                    else
                        toFocus.addClass(classToAdd);
                    if(callback)
                        callback(toFocus, selected);
                }
                else
                {
                    if(callback)
                        callback(toFocus, selected);
                }
            }

            if(!noConfirm)
            {
                jConfirm("Are you sure you wish to remove this item?","Confirm", function(flag){
                    if(flag)
                    {
                        continueRemove();
                    }
                });
            }
            else
            {
                continueRemove();
            }
        },
        copyItem : function(item, callback)
        {
            if(item.length>0)
            {
                var copy = item.clone(true);
                item.parent().append(copy);
                copy.parent().find(".ui-widget-header").removeClass("ui-widget-header").removeClass("ui-selected");
                copy.addClass("ui-widget-header").addClass("ui-selected");
                if(callback)
                    callback(copy);
            }
        },
        moveItem : function(item, up, autoScroll, callback)
        {
            if(item.length>0)
            {
                if(up)
                {
                    if(item.prev().length>0)
                        item.prev().before(item);
                }
                else
                {
                    if(item.next().length>0)
                        item.next().after(item);
                }
                if(autoScroll)
                    item.closest("div.sideScroll").scrollTo(item);
                if(callback)
                    callback(item);
            }
        },
        showIndicator : function(loaderOnly, blockElement, message)
        {
            if(loaderOnly)
            {
                blockElement = blockElement || $(".mainContentPanel");
                if(blockElement.length>0)
                {
                    blockElement.find("div.loadingIndicator").remove();
                    blockElement.prepend(crushFTP.indicatorHTML);
                }
            }
            else
            {
                crushFTP.placeHolder = $("#placeHolder");
                blockElement = blockElement || crushFTP.placeHolder;
                message = message || "Loading...";
                blockElement.block({
                    message:  '<div><span style="float: left; margin-right: 0.3em;" class="ui-icon ui-icon-refresh"></span>'+message+'</div>',
                    css: {
                        border: 'none',
                        padding: '15px',
                        backgroundColor: '#000',
                        '-webkit-border-radius': '10px',
                        '-moz-border-radius': '10px',
                        opacity: .5,
                        color: '#fff',
                        width: '100px',
                        'text-align':'left',
                        zIndex : 9999
                    },
                    overlayCSS : {
                      zIndex : "9999"
                    }
                });
            }
        },
        hideIndicator : function(loaderOnly, blockElement)
        {
            if(loaderOnly)
            {
                blockElement = blockElement || $(".mainContentPanel");
                if(blockElement.length>0)
                {
                    blockElement.find("div.loadingIndicator").remove();
                }
            }
            else
            {
                blockElement = blockElement || crushFTP.placeHolder;
                blockElement.unblock();
            }
        },
        initLoadingIndicator : function()
        {
            $("#loadingIndicator").dialog({
                autoOpen: false,
                dialogClass: "loadingIndicatorWindow",
                closeOnEscape: false,
                draggable: false,
                width: 150,
                minHeight: 50,
                modal: true,
                buttons: {},
                resizable: false,
                open: function() {
                    $('body').css('overflow','hidden');
                },
                close: function() {
                    $('body').css('overflow','auto');
                }
            });
        },
        showLoadingIndicator : function(data)
        {
            if(!data)return;
            $("#loadingIndicator").html(data.message && '' != data.message ? data.message : 'Please wait...');
            $("#loadingIndicator").dialog('option', 'title', data.title && '' != data.title ? data.title : 'Loading');
            $("#loadingIndicator").dialog('open');
        },
        hideLoadingIndicator : function()
        {
            $("#loadingIndicator").dialog('close');
        },
        checkUnchekInput : function(input, flag)
        {
            if(flag)
            {
                if(input.attr("type") == "radio")
                {
                    var selected = input.closest(".customForm").find("input[name='"+input.attr("name")+"']:checked");
                    if(input == selected)return;
                    input.closest(".customForm").find("input[name='"+input.attr("name")+"']").each(function(){
                        var _parent = $(this).parent().next();
                        $(_parent).removeClass("ui-state-active").removeClass("ui-icon-radio-off").removeClass("ui-icon ui-icon-circle-check").addClass("ui-icon-radio-off");
                        $(_parent).find("span").removeClass("ui-state-active").removeClass("ui-icon-radio-off").removeClass("ui-icon ui-icon-circle-check").addClass("ui-icon-radio-off");
                    });

                    input.attr("checked","checked").parent("label").next().find("span").removeClass("ui-icon-radio-off").addClass("ui-icon ui-icon-circle-check");
                }
                else if(input.attr("type") == "checkbox")
                {
                    input.attr("checked","checked").parent("label").next().find("span").addClass("ui-icon ui-icon-check");
                }
            }
            else
            {
                if(input.attr("type") == "radio")
                {
                    var selected = input.closest(".customForm").find("input[name='"+input.attr("name")+"']:checked");
                    if(input == selected)return;
                    input.removeAttr("checked").parent("label").next().find("span").addClass("ui-icon-radio-off").removeClass("ui-icon ui-icon-circle-check");
                }
                else if(input.attr("type") == "checkbox")
                {
                    input.removeAttr("checked").parent("label").next().find("span").removeClass("ui-icon").removeClass("ui-icon-check");
                }
            }
            return input;
        },
        isScrolledIntoView : function(elem) {
            if(!elem ||  elem.length ==0) return;
            var docViewTop = $(window).scrollTop();
            var docViewBottom = docViewTop + $(window).height();

            var elemTop = $(elem).offset().top;
            var elemBottom = elemTop + $(elem).height();

            return ((elemBottom >= docViewTop) && (elemTop <= docViewBottom));
        },
        growl : function(title, content, warning, expires){
            $("#growlContainer").notify({
                speed: 500,
                expires: expires
            });
            var handler = $("#growlContainer")
                .notify({ custom:true })
                .notify("create", { title:title, text:content });
            $(handler.element).removeClass("ui-state-error ui-state-highlight");
            if(warning)
            {
                $(handler.element).addClass("ui-state-error");
            }
            else
            {
                $(handler.element).addClass("ui-state-highlight");
            }
        },
        notification : function(msg, error){
            if(!msg)
            {
                $("#notification").hide();
                return;
            }
            if(error)
            {
                $("#notification").removeClass("ui-state-highlight").removeClass("ui-state-error").empty().html(msg).show().addClass("ui-state-error").prepend('<span style="float: left; margin-right: 0.3em;" class="ui-icon ui-icon-alert"></span>');
            }
            else
            {
                $("#notification").removeClass("ui-state-highlight").removeClass("ui-state-error").empty().html(msg).show().addClass("ui-state-highlight").prepend('<span style="float: left; margin-right: 0.3em;" class="ui-icon ui-icon-info"></span>');
            }
        }
    },
    data:
    {
        serverRequest: function(dataToSubmit, callback, url, requestType, dataType)
        {
            requestType = requestType || crushFTP.defaultRequestType;
            url = url || crushFTP.ajaxCallURL;
            var obj = {
                type: requestType
                , url: url
                , data: dataToSubmit
                , success: function(msg){
                    callback(msg);
                }
                , error: function(XMLHttpRequest, textStatus, errorThrown)
                {
                    callback(false, XMLHttpRequest, textStatus, errorThrown);
                }
            };
            if(dataType)
                obj.dataType = dataType;
            $.ajax(obj);
        },
        getValueFromJson : function(item, node)
        {
            if(item && item[node])
            {
                return item[node];
            }
            else
            {
                return "";
            }
        },
        getTextContentFromPrefs : function(item, node)
        {
            if(item && item[node])
            {
                return item[node];
            }
            else
            {
                return "";
            }
        },
        getTextValueFromXMLNode : function(item, text)
        {
            if(item && item.length>0 && item[0] && item[0].text)
            {
                return item[0].text;
            }
            else
            {
                return text || "";
            }
        },
        getServerItem : function(key, callback, url)
        {
            url = url || crushFTP.ajaxCallURL;
            var obj = {command:"getServerItem",key:key};
            crushFTP.data.serverRequest(obj, callback, url);
        },
        encryptPass : function(pass, callback, url)
        {
            url = url || crushFTP.ajaxCallURL;
            var obj = {
                command: "encryptPassword",
                password : encodeURIComponent(pass)
            };
            $.ajax({
                type: "POST"
                , url: url
                , data: obj
                , success: function(data){
                    if(data)
                    {
                        callback($.xml2json(data, true));
                    }
                    else
                    {
                        callback(false);
                    }
                },
                error : function()
                {
                    callback(false);
                }
            });
        },
        loadAllPrefs : function(callback)
        {
            this.getServerItem("server_settings", callback);
        },
        getXMLPrefsDataFromServer : function(dataKey, callback)
        {
            var items = [];
            crushFTP.data.loadAllPrefs(function(data){
                if(data.getElementsByTagName("result_value") && data.getElementsByTagName("result_value").length > 0)
                {
                    data = data.getElementsByTagName("result_value")[0];
                    items = $.xml2json(data);
                    crushFTP.storage(dataKey, items);
                    crushFTP.storage(dataKey + "_RAW", data);
                    if(callback){
                        callback(data);
                    }
                }
            });
        },
        setXMLPrefs : function(dataKey, dataType, dataAction, entryData, callback)
        {
            var obj = {
                command:"setServerItem",
                key: dataKey,
                data_type: dataType,
                data_action: dataAction,
                data: entryData
            };
            $.ajax({
                type: "POST"
                , url: crushFTP.ajaxCallURL
                , data: obj
                , success: function(msg)
                {
                    callback(msg);
                }
            });
        },
        updateLocalPrefs : function(data, key)
        {
            var dataJson = $.xml2json(data, true);
            if(dataJson)
            {
                var prefs = $(document).data("GUIXMLPrefs");
                if(key == "server_prefs")
                {
                    for(var item in dataJson)
                    {
                        if(item.length && item.length>0 && dataJson[item].length && dataJson[item].length>0)
                        {
                            prefs[item] = dataJson[item];
                        }
                    }
                }
                else
                {
                    prefs[key] = [dataJson];
                }
                $(document).data("GUIXMLPrefs", prefs);
            }
        },
        getSubValueFromPrefs : function(node)
        {
            var prefs = $(document).data("GUIXMLPrefs");
            if(prefs && prefs[node] && prefs[node][node + "_subitem"])
            {
                return prefs[node][node + "_subitem"];
            }
            else
            {
                return [];
            }
        },
        getTextContent : function(obj) {
            if ($.browser.msie && parseInt(jQuery.browser.version) == 10) {
                var itm = {};
                itm.textContent = $(obj).text();
                return itm;
            }
            else
            {
                if (window.ActiveXObject) {
                    var obj2 = {};
                    try {
                        if(typeof obj.text != "undefined")
                            obj2.textContent = obj.text;
                        else
                            obj2.textContent = $(obj).text();
                    } catch (ex) {}
                    return obj2;
                } else {
                    return obj;
                }
            }
        }
    },
    storage : function(key, val)
    {
        if(key)
        {
            if(val)
            {
                crushFTP.storageData = crushFTP.storageData || [];
                if(!crushFTP.storageData.has(key))
                    crushFTP.storageData.push(key);
                return $(document).data(key, val);
            }
            else
            {
                return $(document).data(key);
            }
        }
        else
        {
            return false;
        }
    },
    removeStorage : function(key)
    {
        if($(document).data(key))
        {
            crushFTP.storageData = crushFTP.storageData || [];
            if(crushFTP.storageData.has(key))
                crushFTP.storageData.removeByVal(key);
            $(document).removeData(key);
        }
    },
    userLogin :
    {
        //Login status thread
        userLoginStatusCheckThread : function () {
            if (!crushFTP.loginStatusThreadInterval) {
                crushFTP.loginStatusThreadInterval = setInterval(
                function () {
                    var targetUrl = window.location.toString();
                    crushFTP.userLogin.bindUserName(function (response, username) {
                        if (response == "failure") {
                            if(crushFTP.placeHolder)
                            {
                                crushFTP.placeHolder.removeData("hasChanged");
                            }
                            window.location = targetUrl;
                        }
                    });
                }, 300000);
            }
        },
        //Bind user name
        bindUserName : function (callBack) { /* Data to POST to receive file listing */
            var obj = {
                command: "getUsername",
                random: Math.random()
            }; /* Make a call and receive list */
            var username = "anonymous";
            $.ajax({
                type: "POST",
                url: crushFTP.ajaxCallURL,
                data: obj,
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    errorThrown = errorThrown || "getUsername failed";
                    crushFTP.UI.growl("Error : ", errorThrown, true, true);
                    callBack("failure", username);
                },
                success: function (msg) {
                    var responseText = msg;
                    try {
                        var response = msg.getElementsByTagName("response");
                        response = crushFTP.data.getTextContent(response[0]).textContent;
                        if (response == "success") {
                            username = msg.getElementsByTagName("username");
                            username = crushFTP.data.getTextContent(username[0]).textContent;
                        }
                        if (username == "anonymous" || username == "") {
                            callBack("failure", username);
                            return false;
                        } else {
                            $(document).data("username", username);
                        }
                        if($("#loggedInAs").length>0)
                            $("#loggedInAs").html("Logged in as : <span class='ui-priority-primary'>" + username + "</span>");
                    } catch (ex) {
                        if (callBack) {
                            callBack("failure", username);
                            return false;
                        }
                    }
                    if (callBack) {
                        callBack(response, username);
                    }
                }
            });
        }
    },
    methods :
    {
        //Generate random code based on length, numeric flag restricts code to be numbers only
        generateRandomPassword : function(length, numeric, possible){
            length = length || 8;
            var randomId = "";
            possible = possible || "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            if(numeric)
            {
                possible = "0123456789";
            }
            for( var i=0; i < length; i++ )
                randomId += possible.charAt(Math.floor(Math.random() * possible.length));
            return randomId;
        },
        dottedQuadToInt : function(ip)
        {
            if(!ip)return false;
            var parts = ip.split('.', 4);
            if(parts.length<4)return 0;
            var result = 0, base = 1;
            for (var i = 3;i>=0;i--)
            {
               //validation
               if (parts[i].length == 0 || parts[i].length > 3) return -1;
               var segment = parseInt(parts[i],10);
               if (isNaN(segment) || segment<0 || segment > 255) return -1;

               //compute next segment
               result += base * segment;
               base = base << 8;
            }
            return result;
        },
        // Validate IP Address
        isValidIP : function(ip){
            if(ip == "0.0.0.0") return true;
           ip = crushFTP.methods.dottedQuadToInt(ip);
           if (ip <= 0) return false;

           //mulitcast range:
           if (ip >= 3758096384 && ip <= 4026531839) return false;

           //alternate way to check multicast:
           if (ip >= crushFTP.methods.dottedQuadToInt('224.0.0.0') && ip <= crushFTP.methods.dottedQuadToInt('239.255.255.255')) return false;

           return true;
        },
        isValidAnyIPAddress : function(ip, allowedIPs)
        {
            if(!ip || ip.length==0)return false;
            if(allowedIPs.has(ip.toLowerCase()))return true;
            ip = ip.split(".");
            var result = true;
            if(ip.length!=4) return false;
            for(var i=0;i<ip.length;i++)
            {
                if(!crushFTP.methods.isNumeric(ip[i]))
                {
                    result = false;
                    i = ip.length;
                }
            }
            return result;
        },
        //Validate numbers
        isNumeric : function(input){
            return ((input - 0) == input && input.length > 0);
        },
        //Validate Email address
        isValidEmail : function(email)
        {
            return (email.indexOf("@") > 0 && email.lastIndexOf(".") > email.indexOf("@"));
        },
        formatBytes : function(bytes) {
            if ((bytes / 1024).toFixed(0) == 0) return bytes + " bytes";
            else if ((bytes / 1024 / 1024).toFixed(0) == 0) return (bytes / 1024).toFixed(1) + " KB";
            else if ((bytes / 1024 / 1024 / 1024).toFixed(0) == 0) return (bytes / 1024 / 1024).toFixed(1) + " MB";
            else if ((bytes / 1024 / 1024 / 1024 / 1024).toFixed(0) == 0) return (bytes / 1024 / 1024 / 1024).toFixed(1) + " GB";
            else if ((bytes / 1024 / 1024 / 1024 / 1024 / 1024).toFixed(0) == 0) return (bytes / 1024 / 1024 / 1024 / 1024).toFixed(1) + " TB";
        },
        formatTime : function(secs) {
            var remaining = "";
            if(!secs) return "";
            if(secs.indexOf(".")<0)
                secs = secs + ".0";
            secs = secs.substring(0, secs.indexOf(".")) * 1;
            var mins = (secs / 60) + ".0";
            mins = mins.substring(0, mins.indexOf(".")) * 1;
            if (mins > 0) {
                secs -= (mins * 60);
                remaining = mins + " min, " + secs + " secs";
            } else {
                if (secs < 0) {
                    remaining = "Calculating";
                } else {
                    remaining = secs + " secs";
                }
            }
            return remaining;
        },
        isDate : function(str, uk) {
          var parms = str.split(/[\.\-\/]/);
          var yyyy = parseInt(parms[2],10);
          var mm   = parseInt(parms[1],10);
          var dd   = parseInt(parms[0],10);
          if(uk)
          {
            mm   = parseInt(parms[0],10);
            dd   = parseInt(parms[1],10);
          }
          var date = new Date(yyyy,mm-1,dd,0,0,0,0);
          return mm === (date.getMonth()+1) &&
                 dd === date.getDate() &&
               yyyy === date.getFullYear();
        },
        isDateTS : function(dt) {
            var isvalid = true;
            if(dt.length!=12)
                isvalid = false;

            if(!crushFTP.methods.isNumeric(dt))
                isvalid = false;

            if(isvalid)
            {
                var mm = parseInt(dt.substr(0,2));
                var dd = parseInt(dt.substr(2,2));
                var yyyy = parseInt(dt.substr(4,4));
                var hh = parseInt(dt.substr(8,2));
                var _mm = parseInt(dt.substr(10,2));
                if(mm<1 || mm>12)
                    isvalid=false;
                if(dd<1 || dd>31)
                    isvalid=false;
                if(hh<1 || hh>24)
                    isvalid=false;
                if(_mm<1 || _mm>60)
                    isvalid=false;
            }
            return isvalid;
        },
        isDateTime : function(str){
            if(!str || str.length==0)
                return "";
            var errormessage = "";
            var isvalid = false;
            var dt = str;
            var parts = dt.split(" ");
            if(parts.length == 3){
             var date = parts[0];
             var time = parts[1];
             var ampm = parts[2];
             if(ampm.length == 2 && (ampm.toLowerCase() == "am" || ampm.toLowerCase() == "pm")){
                var validformatdate=/^\d{2}\/\d{2}\/\d{4}$/;
                var validformatdate2=/^\d{2}\/\d{2}\/\d{2}$/;
                if (validformatdate.test(date) || validformatdate2.test(date)){
                    var validformattime = /^\d{1,2}:\d{2}$/;
                    if (validformattime.test(time)){
                         isvalid = true;
                    }else{errormessage = "Time is not in the format HH:MM";}
                }else{errormessage = "Date is not in the format dd/mm/yyyy";}
             }else{errormessage = "DateTime does not have AM/PM at the end";}
            }else{errormessage = "DateTime is not in the format mm/dd/yyyy hh:mm am/pm";}
            return errormessage;
        },
        //Check if input has special characters
        hasSpecialCharacters: function (input, charset){
            if(input)
            {
                charset = charset || crushFTP.notAllowedChars;
                for (var i = 0; i < input.length; i++) {
                    if (charset.indexOf(input.charAt(i)) != -1) {
                        return true;
                    }
                }
            }
            return false;
        },
        removeSpecialChars : function(strVal)
        {
            return strVal.replace(/[^a-zA-Z 0-9]+/g,'');
        },
        //Check if input starts with number
        startsWithNumber : function(input){
           input = input.replace(/(^\d+)(.+$)/i,'$1');
           return !isNaN(input);
        },
        rebuildSubItems: function(item, name){
            if(item && name)
            {
                if(!item[name  + "_subitem"])
                {
                    item[name  + "_subitem"] = [];
                }
                else if(!item[name  + "_subitem"].push)
                {
                    var slab = item[name  + "_subitem"];
                    item[name  + "_subitem"] = [slab];
                }
            }
        },
        logout : function (elem) {
            $.ajax({
                type: "POST",
                url: crushFTP.ajaxCallURL,
                data: {
                    command: "logout",
                    random: Math.random()
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.cookie("CrushAuth", "", {
                        path: '/',
                        expires: -1
                    });
                    document.location = document.location;
                },
                success: function (msg) {
                    //Remove CrushAuth cookie and redirect to login page
                    $.cookie("CrushAuth", "", {
                        path: '/',
                        expires: -1
                    });
                    document.location = document.location;
                }
            });
        },
        getInputValue : function(id, panel)
        {
            if(panel && $("#"+id, panel).length>0)
            {
                var type = $("#"+id, panel).attr("type");
                type = type || "";
                type = type.toLowerCase();
                if(type == "checkbox" || type == "radio")
                {
                    return $("#"+id, panel).is(":checked");
                }
                else
                {
                    return $("#"+id, panel).val();
                }
            }
            else if($("#"+id).length>0)
            {
                var type = $("#"+id).attr("type");
                type = type || "";
                type = type.toLowerCase();
                if(type == "checkbox" || type == "radio")
                {
                    return $("#"+id).is(":checked");
                }
                else
                {
                    return $("#"+id).val();
                }
            }
            else
            {
                return "";
            }
        },
        sortObjectsRefKey : function(a,b) {
          if (a.key < b.key)
             return -1;
          if (a.key > b.key)
            return 1;
          return 0;
        },
        jsonToXML : function(json, flag, reverseEncode, noEncode, asIs, asIs2)
        {
            if(!json) return "";
            var xml = [];
            for(var item in json)
            {
                var curItem = json[item];
                if(!$.isFunction(curItem))
                {
                    if(curItem[0] && curItem[0][item + "_subitem"])
                    {
                        var subItem = curItem[0][item + "_subitem"];
                        xml.push("<"+item+"  type=\"vector\">");
                        if(subItem && subItem.length>0)
                        {
                            var itemTypeText = "";
                            var subItemType = subItem[0].type;
                            if(subItemType)
                            {
                                if($.isArray(subItemType) && subItemType.length>1)
                                {
                                    itemTypeText = "type =\""+subItemType[1]+"\"";
                                }
                                else if(typeof subItemType === "string")
                                {
                                    itemTypeText = "type =\""+subItemType+"\"";
                                }
                            }
                            if($.isArray(subItem) && subItem.length>1)
                            {
                                for(var subSubItem in subItem)
                                {
                                    var curSubItem = subItem[subSubItem];
                                    if(!$.isFunction(curSubItem))
                                    {
                                        xml.push("<"+item+"_subitem "+itemTypeText+">" + crushFTP.methods.jsonToXML(curSubItem, true, reverseEncode, noEncode, asIs, asIs2) + "</"+item+"_subitem>");
                                    }
                                }
                            }
                            else
                            {
                                xml.push("<"+item+"_subitem "+itemTypeText+">" + crushFTP.methods.jsonToXML(subItem, true, reverseEncode, noEncode, asIs, asIs2) + "</"+item+"_subitem>");
                            }
                        }
                        xml.push("</"+item+">");
                    }
                    else
                    {
                        var textVal = curItem;
                        if($.isArray(textVal))
                        {
                            if(textVal.length>0)
                            {
                                textVal = textVal[0];
                                if(typeof textVal.text != "undefined")
                                {
                                    textVal = textVal.text;
                                }
                                else if(typeof textVal != "string")
                                {
                                    textVal = "";
                                }
                            }
                            else
                            {
                                textVal = "";
                            }
                        }
                        else if(flag)
                        {
                            xml.push(crushFTP.methods.jsonToXML(curItem, false, reverseEncode, noEncode, asIs, asIs2));
                        }

                        if(item.toLowerCase() != "type" && typeof curItem != "string")
                        {
                            if(typeof textVal =="string" && textVal != "undefined")
                            {
                                if(reverseEncode)
                                    xml.push("<"+item+">" + crushFTP.methods.htmlEncode(crushFTP.methods.decodeXML(textVal)) + "</"+item+">");
                                else if(noEncode)
                                    xml.push("<"+item+">" + crushFTP.methods.decodeXML(textVal) + "</"+item+">");
                                else if(asIs)
                                    xml.push("<"+item+">" + crushFTP.methods.htmlEncode2(textVal).replace(/(%2B|%25)/g,  function(str, item) {return crushFTP.methods.xmlUnSafeCharsMappingReverse[item];}) + "</"+item+">");
                                else if(asIs2)
                                    xml.push("<"+item+">" + crushFTP.methods.htmlEncode2(textVal) + "</"+item+">");
                                else
                                    xml.push("<"+item+">" + crushFTP.methods.htmlEncode(textVal) + "</"+item+">");
                            }
                        }
                        else
                        {
                            if(typeof curItem != "string")
                            {
                                textVal = curItem[0].text;
                                if(textVal && typeof textVal == "string"  && textVal != "undefined")
                                {
                                    if(reverseEncode)
                                        xml.push("<"+item+">" + crushFTP.methods.htmlEncode(crushFTP.methods.decodeXML(textVal)) + "</"+item+">");
                                    else if(noEncode)
                                        xml.push("<"+item+">" + crushFTP.methods.decodeXML(textVal) + "</"+item+">");
                                    else if(asIs)
                                        xml.push("<"+item+">" + crushFTP.methods.htmlEncode2(textVal).replace(/(%2B|%25)/g,function(str, item) { return crushFTP.methods.xmlUnSafeCharsMappingReverse[item];}) + "</"+item+">");
                                    else if(asIs2)
                                        xml.push("<"+item+">" + crushFTP.methods.htmlEncode2(textVal) + "</"+item+">");
                                    else
                                        xml.push("<"+item+">" + crushFTP.methods.htmlEncode(textVal) + "</"+item+">");
                                }
                            }
                        }
                    }
                }
            }
            return xml.join("\r\n");
        },
        setPageTitle : function(title, append){
            if(title)
            {
                if(append)
                {
                    title =  $(document).data("pageTitle") + " :: " + title;
                }
                document.title = title;
            }
            else if($(document).data("pageTitle"))
            {
                document.title = $(document).data("pageTitle");
            }
        },
        xmlUnSafeCharsMapping : {
            '&': '&amp;',
            '"': '&quot;',
            "'" : '&apos;',
            '<': '&lt;',
            '>': '&gt;'
        },
        xmlUnSafeCharsMapping2 : {
            '&': '&amp;',
            '"': '&quot;',
            "'" : '&apos;',
            '<': '&lt;',
            '>': '&gt;',
            '%': '%25',
            '+': '%2B'
        },
        xmlUnSafeCharsMappingReverse : {
            '&amp;' : '&',
            '&quot;' : '"',
            '&apos;' : "'",
            '&lt;' : '<',
            '&gt;' : '>',
            '%2B' : '+',
            '%25' : '%'
        },
        xmlEncode : function(value)
        {
            if (value == undefined || value.length == 0) return value;
             return value.replace(/([\&'"<>])/g, function(str, item) {
                return crushFTP.methods.xmlUnSafeCharsMapping[item];
            }).replace(/\%/g, "%25").replace(/\+/g, "%2B");
        },
        xmlEncode2 : function(value)
        {
            if (value == undefined || value.length == 0) return value;
            value = value.replace(/(%2B|%25)/g,
                function(str, item) {
                    return crushFTP.methods.xmlUnSafeCharsMappingReverse[item];
            });
            return value.replace(/([\&'"<>%+])/g, function(str, item) {
                return crushFTP.methods.xmlUnSafeCharsMapping2[item];
            });
        },
        decodeXML : function(value)
        {
            try{
            if (value == undefined || value.length == 0) return value;
             return value.replace(/(&quot;|&lt;|&gt;|&amp;|&apos;|%2B|%25)/g,
                function(str, item) {
                    return crushFTP.methods.xmlUnSafeCharsMappingReverse[item];
            });
            }catch(ex){
                console.log(value, ex);
            }
        },
        htmlEncode : function(value, encodeVal, ignore) {
            if(ignore)return value.replace(/\&/g,"&amp;").replace(/\</g,"&lt;").replace(/\>/g,"&gt;");
            if(value != undefined && value.length>0)
            {
                var lines = value.split(/\r\n|\r|\n/);
                for (var i = 0; i < lines.length; i++) {
                    if(lines[i] && typeof lines[i] == "string")
                    lines[i] = crushFTP.methods.xmlEncode(lines[i]);
                }
                if(encodeVal)
                    return encodeURIComponent(lines.join('\r\n'));
                else
                    return lines.join('\r\n');
            }
            else
                return value;
        },
        htmlEncode2 : function(value, encodeVal, ignore) {
            if(ignore)return value.replace(/\&/g,"&amp;").replace(/\</g,"&lt;").replace(/\>/g,"&gt;");
            if(value != undefined && value.length>0)
            {
                var lines = value.split(/\r\n|\r|\n/);
                for (var i = 0; i < lines.length; i++) {
                    if(lines[i] && typeof lines[i] == "string")
                    lines[i] = crushFTP.methods.xmlEncode2(lines[i]);
                }
                if(encodeVal)
                    return encodeURIComponent(lines.join('\r\n'));
                else
                    return lines.join('\r\n');
            }
            else
                return value;
        },
        encode : function(value) {
            return $('<div/>').text(value).html();
        },
        decode : function(value){
            return $('<div/>').html(value).text();
        },
        round : function(number, digits) {
            var multiple = Math.pow(10, digits);
            var rndedNum = Math.round(number * multiple) / multiple;
            return rndedNum;
        },
        createCSSClass : function(selector, style) {
            if (!document.styleSheets) {
                return;
            }
            if (document.getElementsByTagName("head").length == 0) {
                return;
            }
            var stylesheet;
            var mediaType;
            if (document.styleSheets.length > 0) {
                for (i = 0; i < document.styleSheets.length; i++) {
                    if (document.styleSheets[i].disabled) {
                        continue;
                    }
                    var media = document.styleSheets[i].media;
                    mediaType = typeof media;
                    if (mediaType == "string") {
                        if (media == "" || (media.indexOf("screen") != -1)) {
                            styleSheet = document.styleSheets[i];
                        }
                    } else if (mediaType == "object") {
                        if (media.mediaText == "" || (media.mediaText.indexOf("screen") != -1)) {
                            styleSheet = document.styleSheets[i];
                        }
                    }
                    if (typeof styleSheet != "undefined") {
                        break;
                    }
                }
            }
            if (typeof styleSheet == "undefined") {
                var styleSheetElement = document.createElement("style");
                styleSheetElement.type = "text/css";
                document.getElementsByTagName("head")[0].appendChild(styleSheetElement);
                for (i = 0; i < document.styleSheets.length; i++) {
                    if (document.styleSheets[i].disabled) {
                        continue;
                    }
                    styleSheet = document.styleSheets[i];
                }
                var media = styleSheet.media;
                mediaType = typeof media;
            }
            if (mediaType == "string") {
                for (i = 0; i < styleSheet.rules.length; i++) {
                    if (styleSheet.rules[i].selectorText.toLowerCase() == selector.toLowerCase()) {
                        styleSheet.rules[i].style.cssText = style;
                        return;
                    }
                }
                styleSheet.addRule(selector, style);
            } else if (mediaType == "object") {
                for (i = 0; i < styleSheet.cssRules.length; i++) {
                    if (styleSheet.cssRules[i].selectorText.toLowerCase() == selector.toLowerCase()) {
                        styleSheet.cssRules[i].style.cssText = style;
                        return;
                    }
                }
                styleSheet.insertRule(selector + "{" + style + "}", 0);
            }
        },
        getOppositeColor : function(color)
        {
            function decimalToHex(decimal) {
              var hex = decimal.toString(16);
              if (hex.length == 1) hex = '0' + hex;
              return hex;
            }
            function hexToDecimal(hex) {return parseInt(hex,16);}

            function returnOpposite(colour) {
              return decimalToHex(255 - hexToDecimal(colour.substr(0,2)))
                + decimalToHex(255 - hexToDecimal(colour.substr(2,2)))
                + decimalToHex(255 -  hexToDecimal(colour.substr(4,2)));
            }
            return returnOpposite(color.replace("#",""));
        },
        getTextRangeSelection : function()
        {
            var text = "";
            if (window.getSelection && window.getSelection().toString() && $(window.getSelection()).attr('type') != "Caret") {
                text = window.getSelection();
                return text.toString();
            } else if (document.getSelection && document.getSelection().toString() && $(document.getSelection()).attr('type') != "Caret") {
                text = document.getSelection();
                return text.toString();
            } else {
                var selection = document.selection && document.selection.createRange();

                if (!(typeof selection === "undefined") && selection.text && selection.text.toString()) {
                    text = selection.text;
                    return text.toString();
                }
            }
            return false;
        },
        getHTMLRangeSelection : function()
        {
          var range;
          if (document.selection && document.selection.createRange) {
            range = document.selection.createRange();
            return range.htmlText;
          }
          else if (window.getSelection) {
            var selection = window.getSelection();
            if (selection.rangeCount > 0) {
              range = selection.getRangeAt(0);
              var clonedSelection = range.cloneContents();
              var div = document.createElement('div');
              div.appendChild(clonedSelection);
              return div.innerHTML;
            }
            else {
              return '';
            }
          }
          else {
            return '';
          }
        },
        removeTextRangeSelection : function()
        {
            // Remove selection range, it messes up UI as all the text came between selection highlights in native browser selection manner
            if (window.getSelection) // Modern Browsers
            {
                var selection = window.getSelection();
                if (selection.removeAllRanges) {
                    selection.removeAllRanges();
                }
            }
            if (document.getSelection) // IE
            {
                var selection = document.getSelection();
                if (selection.removeAllRanges) {
                    selection.removeAllRanges();
                }
            }
        },
        queryString : function(name)
        {
            if(!name)return false;
            name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regexS = "[\\?&]" + name + "=([^&#]*)";
            var regex = new RegExp(regexS);
            var results = regex.exec(window.location.search);
            if(results == null)
                return "";
            else
                return decodeURIComponent(results[1].replace(/\+/g, " "));
        },
        isVisibleOnScreen : function(elem) {
            if(!elem ||  elem.length ==0) return;
            var docViewTop = $(window).scrollTop();
            var docViewBottom = docViewTop + $(window).height();
            var elemTop = $(elem).offset().top;
            var elemBottom = elemTop + $(elem).height();
            return ((elemBottom >= docViewTop) && (elemTop <= docViewBottom));
        }
    }
};