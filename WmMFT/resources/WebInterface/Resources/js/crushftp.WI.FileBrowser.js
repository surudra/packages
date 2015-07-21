/*!
 * CrushFTP WebInterface File Browsing
 *
* Copyright @ SoftwareAG
*
*/

(function($) {
    $.crushFtpLocalFileBrowserPopup = function(el, options) {
        var base = this;
        base.$el = $(el);
        base.el = el;
        base.ajaxCallURL = "/WebInterface/function/";
        base.$el.data("crushFtpLocalFileBrowserPopup", base);
        base.getFileExtension = function(filename) {
            var ext = /^.+\.([^.]+)$/.exec(filename);
            return ext == null ? "" : ext[1].toLowerCase();
        }
        base.init = function() {
            base.options = $.extend({}, $.crushFtpLocalFileBrowserPopup.defaultOptions, options);
            base.htmlTemplate = "";
            var html = [];
            html.push('<div class="safari7Help"><div class="helpItem"><div class="ui-priority-primary">Java is blocked by your browser settings. Follow these steps to fix it :</div><div style="margin-top:10px;">Go to the Safari menu, Preferences, Security, Manage Website Settings…</div><div class="imgDiv"><img src="/WebInterface/Resources/images/java_safari_help1.jpg?1" style="border:0px;" alt="Safari Java Help 1" /></div><div style="margin-top:10px;">Select the site from the currently open websites, and change from allow to “Run in Unsafe mode”.  Click trust to trust the site…and then reload the web page.</div><div class="imgDiv"><img src="/WebInterface/Resources/images/java_safari_help2.png" style="border:0px;" alt="Safari Java Help 1" /></div></div></div><div class="loadingFS"></div><table class="localFileBrowser">');
            html.push('<tr>');
            html.push('<td colspan="2">');
            html.push('<select class="dropdown dirSelect">');
            html.push('</select>');
            html.push('<a class="refreshImg" href="javascript:void(0);">');
            html.push('<img src="/WebInterface/Resources/images/arrow_refresh_small.png" style="border:0px;" alt="Refresh" />');
            html.push('</a>');
            html.push('<span class="systemFilesPanel"><label><input class="showSystemFiles" type="checkbox" />Show system files?</label></span>');
            html.push('<span class="filterPanelPopup">Filter : <input class="filter" /><img src="/WebInterface/jQuery/images/cancel.png" style="border:0px;" alt="Clear" class="clearFilter" /></span>');
            html.push('</td>');
            html.push('</tr>');
            html.push('<tr>');
            html.push('<td class="firstColumn">');
            html.push('<div class="ui-corner-all ui-widget-content nobg contentDiv">');
            html.push('<div class="sideScroll quickAccessLinks">');
            html.push('<div class="quickLinksHolder">');
            html.push('<div class="ui-priority-primary ui-widget-content panelHeader">Quick Access</div>');
            html.push('<ul>');
            html.push('<li class="_home" rel="~/">Home</li>');
            html.push('<li class="_documents" rel="~/Documents">Documents</li>');
            html.push('<li class="_desktop" rel="~/Desktop">Desktop</li>');
            html.push('<li class="_downloads" rel="~/Downloads">Downloads</li>');
            html.push('<li class="_pictures" rel="~/Pictures">Pictures</li>');
            html.push('<li class="_videos" rel="~/Videos">Videos</li>');
            html.push('</ul>');
            html.push('</div>');
            html.push('<div class="deviceListHolder">');
            html.push('<div class="ui-priority-primary ui-widget-content panelHeader">Devices</div>');
            html.push('<ul class="devices">');
            html.push('</ul>');
            html.push('</div>');
            html.push('</div>');
            html.push('</div>');
            html.push('</td>');
            html.push('<td class="secondColumn">');
            html.push('<div class="ui-corner-all ui-widget-content nobg contentDiv">');
            html.push('<table class="listing">');
            html.push('<thead>');
            html.push('<tr class="ui-widget-content">');
            html.push('<td class="chekbox"><input type="checkBox" class="chkBoxAll" /></td>');
            html.push('<td class="name">Name</td>');
            html.push('<td class="size">Size</td>');
            html.push('<td class="date">Date Modified</td>');
            html.push('</tr>');
            html.push('</thead>');
            html.push('</table>');
            html.push('<div class="sideScroll scrollableList">');
            html.push('<table class="listing files">');
            html.push('<tbody>');
            html.push('</tbody>');
            html.push('</table>');
            html.push('</div>');
            html.push('</div>');
            html.push('</td>');
            html.push('</tr>');
            html.push('</table>');
            base.htmlTemplate = html.join("");
            base.thisElemId = "BrowsePanel_" + Math.random().toString(36).substring(7);
            base.initBrowses(base.options);
        };

        base.initBrowses = function(options) {
            var browsePanel = $("#" + base.thisElemId);
            var dialogHeight = 660;
            if (browsePanel.length == 0) {
                var htmlToAppend = "<div id=\"" + base.thisElemId + "\" style='overflow:hidden;'>";
                htmlToAppend += base.htmlTemplate;
                htmlToAppend += "</div>";
                $("body").append(htmlToAppend);
                browsePanel = $("#" + base.thisElemId).hide();
                if(base.options.note)
                {
                    browsePanel.prepend("<div class='notes ui-state-highlight ui-corner-all' style='margin:1px;padding:5px;'>"+ base.options.note +"</div>");
                    dialogHeight += 30;
                }
                else
                {
                    dialogHeight = 660;
                    browsePanel.find("div.notes").remove();
                }
            };
            browsePanel.dialog({
                autoOpen: false,
                title: "Select Files :",
                dialogClass: "localFileBrowserPopup",
                height: dialogHeight,
                width: 840,
                modal: true,
                resizable: false,
                closeOnEscape: true,
                buttons: {
                    "Cancel": function() {
                        $(this).dialog("close");
                        if (options.callbackClose) {
                            options.callbackClose();
                        }
                    },
                    "OK": function() {
                        var opts = browsePanel.data("options") || base.options;
                        var clbkMethod = opts.callback;
                        if(base.options.singleSelection)
                        {
                            var dir = false;
                            var hasSelection = false;
                            var selected = browsePanel.find("table.listing.files").find(".selected:visible:first").each(function() {
                                hasSelection = true;
                                dir = $(this).data("curData").path;
                            });
                            if(dir == 0)
                            {
                                dir = base.curLoadedPath;
                            }
                            if(dir.indexOf("~")==0)
                            {
                                if(typeof window.runAppletCommand != "undefined")
                                {
                                    dir = runAppletCommand(true, "COMMAND=RESOLVE:::PATH=" + dir);
                                }
                            }
                            else
                            {
                                if(base.options.inJavaFormat)
                                {
                                    dir = "path=" + dir + ":::name"+ dir + ";;;";
                                }
                            }
                            if(!base.options.allowRootSelection && dir == "/")
                            {
                                $.growlUI("Not allowed", "Can not select this path", 2000, "growlError", false);
                                return false;
                            }
                            if(opts.isFTPBrowse)
                            {
                                var path = dir;
                                if(!hasSelection && base.remoteLoadedPath)
                                {
                                    path = base.remoteLoadedPath;
                                }
                                path = path.replace("/home/", "");
                                if(path.indexOf("/")==0)
                                    path = path.replace("/", "");
                                var ftpServerInfo = browsePanel.data("ftpServerInfo");
                                if(ftpServerInfo && ftpServerInfo.url.indexOf(path)<0)
                                {
                                    ftpServerInfo.url += path;
                                }
                                clbkMethod("", ftpServerInfo);
                            }
                            else
                            {
                                if (base.options.callback)
                                    base.options.callback(dir);
                            }
                            $(this).dialog("close");
                            if(opts.isFTPBrowse)
                            {
                                $("#browsePopupFTPDialog").dialog("close");
                                $("#browsePopupFTPDialog").remove();
                            }
                        }
                        else
                        {
                            var items = [];
                            browsePanel.find("table.listing.files").find("input[checked]:visible").each(function() {
                                items.push($(this).closest('tr').data('curData'));
                            });
                            if (base.options.callback)
                                base.options.callback(items);
                            $(this).dialog("close");
                        }
                    }
                },
                beforeClose: function() {
                    return true;
                },
                open: function() {
                    $([document, window]).unbind('.dialog-overlay');
                    base.listDevices();
                    if(base.options.existingVal)
                    {
                        var val = base.options.existingVal;
                        if(base.getFileExtension(val)!="" || val.lastIndexOf("/")>=0)
                        {
                            val = val.substring(0, val.lastIndexOf("/"));
                        }
                        if(val.lastIndexOf("/")!=val.length-1)
                        {
                            val = val + "/";
                        }
                        base.listItems(val, true);
                    }
                    else
                        base.listItems();
                }
            });
            if(base.options.isFTPBrowse)
            {
                if($("#browsePopupFTPDialog").length==0)
                {
                    var ftpDialogHTML = $('<div id="browsePopupFTPDialog"></div>');
                    crushFTP.UI.showIndicator(false, false, "Please wait..");
                    ftpDialogHTML.load("/WebInterface/Resources/templates/remoteVFSItemForm.html", function(){
                        $("body").append(ftpDialogHTML);
                        var browsePopupFTPDialog = $("#browsePopupFTPDialog").form().hide();
                        var attr = base.$el.attr("rel");
                        browsePopupFTPDialog.find("[_name='destPath']").attr("_name", attr);
                        browsePopupFTPDialog.find(".button").button();
                        base.bindFTPFormEvents(browsePopupFTPDialog, base.options.existingData);
                        browsePopupFTPDialog.dialog("open");
                        crushFTP.UI.hideIndicator();
                    });
                }
                else
                {
                    var browsePopupFTPDialog = $("#browsePopupFTPDialog");
                    base.bindFTPFormEvents(browsePopupFTPDialog, base.options.existingData);
                    browsePopupFTPDialog.dialog("open");
                }
                browsePanel.find(".firstColumn").hide().css("width","0px");
                browsePanel.find(".secondColumn").css("width","800px");
                browsePanel.find("table.files").parent().css("width","802px");
                browsePanel.find("table").css("width","800px");
            }
            else
            {
                browsePanel.dialog("open");
                base.bindListingEvents();
                browsePanel.find(".showSystemFiles").unbind().bind('change', function() {
                    base.showHideSystemFiles();
                });
                browsePanel.find(".firstColumn").show().css("width","200px");
                browsePanel.find(".secondColumn").css("width","600px");
                browsePanel.find("table.files").css("width","600px");
            }
        };

        base.bindFTPFormEvents = function(fieldPropertiesDialog){
            var opts = base.options;
            var notAllowedCharsInDirName = ":/\\&#?<>";
            function showHideItemPropertiesSettings()
            {
                var ftpCredentials = $(".ftpCredentials", fieldPropertiesDialog).show();
                var noFileOption = $(".noFileOption", fieldPropertiesDialog).show();
                var ftpOptions = $(".ftpOptions", fieldPropertiesDialog).hide();
                var s3Credentials = $(".s3Credentials", fieldPropertiesDialog).hide();
                var HAOptions = $(".HAOptions", fieldPropertiesDialog).show();
                var SSLOptions = $(".SSLOptions", fieldPropertiesDialog).hide();
                var privateOptions = $(".privateOptions", fieldPropertiesDialog).hide();

                ftpOptions.find("select").unbind().change(function(){
                    if($(this).val() == "true")
                    {
                        SSLOptions.show();
                    }
                    else
                    {
                        SSLOptions.hide();
                    }
                }).trigger("change");

                var remoteVFSItem_option_itemType = $("#remoteVFSItem_option_itemType", fieldPropertiesDialog).val();
                var remoteVFSItem_option_port = $("#remoteVFSItem_option_port", fieldPropertiesDialog);
                if(remoteVFSItem_option_itemType == "file")
                {
                    ftpCredentials.hide();
                    HAOptions.hide();
                    noFileOption.hide();
                    remoteVFSItem_option_port.val("");
                }
                if(remoteVFSItem_option_itemType == "s3")
                {
                    ftpCredentials.hide();
                    s3Credentials.show();
                    remoteVFSItem_option_port.val("");
                }
                if(remoteVFSItem_option_itemType == "sftp")
                {
                    privateOptions.show();
                    if(remoteVFSItem_option_port.val()=="")
                        remoteVFSItem_option_port.val("22");
                }
                if(remoteVFSItem_option_itemType == "ftps" || remoteVFSItem_option_itemType == "https")
                {
                    SSLOptions.show();
                }
                if(remoteVFSItem_option_itemType == "ftp")
                {
                    ftpOptions.show();
                    if(remoteVFSItem_option_port.val()=="")
                        remoteVFSItem_option_port.val("21");
                }
                if(remoteVFSItem_option_itemType == "http" || remoteVFSItem_option_itemType == "webdav" || remoteVFSItem_option_itemType == "s3")
                {
                    if(remoteVFSItem_option_port.val()=="")
                        remoteVFSItem_option_port.val("80");
                }
                if(remoteVFSItem_option_itemType == "https" || remoteVFSItem_option_itemType == "webdavs")
                {
                    if(remoteVFSItem_option_port.val()=="")
                        remoteVFSItem_option_port.val("443");
                }
                if(remoteVFSItem_option_itemType == "ftps")
                {
                    if(remoteVFSItem_option_port.val()=="")
                        remoteVFSItem_option_port.val("989");
                }
            };

            function buildPropertiesURL()
            {
                var remoteVFSItem_option_url = fieldPropertiesDialog.find("#remoteVFSItem_option_url");
                var curUrl = remoteVFSItem_option_url.val();
                var staticURL = curUrl;
                if(staticURL.indexOf("://")>=0)
                {
                    staticURL = staticURL.substr(staticURL.indexOf("://") + 3, staticURL.length);
                    if(staticURL.indexOf("@")>=0)
                    {
                        staticURL = staticURL.substr(staticURL.indexOf("@") + 1, staticURL.length);
                    }
                }
                else if(staticURL.indexOf(":/")>=0)
                {
                    staticURL = staticURL.substr(staticURL.indexOf(":/") + 3, staticURL.length);
                    if(staticURL.indexOf("@")>=0)
                    {
                        staticURL = staticURL.substr(staticURL.indexOf("@") + 1, staticURL.length);
                    }
                }
                var remoteVFSItem_option_itemType = $("#remoteVFSItem_option_itemType", fieldPropertiesDialog).val();
                var fileSelected = remoteVFSItem_option_itemType == "file";
                var ftpSelected = remoteVFSItem_option_itemType == "ftp";

                var httpSelected = remoteVFSItem_option_itemType == "http";
                var httpsSelected = remoteVFSItem_option_itemType == "https";
                var webdavSelected = remoteVFSItem_option_itemType == "webdav";
                var webdavsSelected = remoteVFSItem_option_itemType == "webdavs";

                var ftpsSelected = remoteVFSItem_option_itemType == "ftps";
                var ftpesSelected = remoteVFSItem_option_itemType == "ftpes";
                var sftpSelected = remoteVFSItem_option_itemType == "sftp";
                var s3Selected = remoteVFSItem_option_itemType == "s3";

                function addUserPassToURL(url, protocol, addUP)
                {
                    url = url.replace("s3.amazonaws.com/", "");
                    if(addUP)
                    {
                        var userName = $("#remoteVFSItem_option_user_name", fieldPropertiesDialog).val();
                        var pass = $("#remoteVFSItem_option_password", fieldPropertiesDialog).val();
                        if(userName.length>0)
                        {
                            url = userName + ":" + pass + "@" + url;
                        }
                    }
                    return protocol + url;
                }

                function addUserPassToURLS3(url, protocol)
                {
                    url = url.replace("s3.amazonaws.com/", "");
                    var userName = $("#remoteVFSItem_option_secretKeyID", fieldPropertiesDialog).val();
                    var pass = $("#remoteVFSItem_option_secretKey", fieldPropertiesDialog).val();
                    if(userName.length>0)
                    {
                        url = userName + ":" + pass + "@s3.amazonaws.com/" + url;
                    }
                    else
                        url = "s3.amazonaws.com/" + url;
                    return protocol + url;
                }

                if(fileSelected)
                {
                    remoteVFSItem_option_url.val(addUserPassToURL(staticURL, "FILE://"));
                }
                else if(ftpSelected)
                {
                    remoteVFSItem_option_url.val(addUserPassToURL(staticURL, "FTP://", true));
                }
                else if(httpSelected)
                {
                    remoteVFSItem_option_url.val(addUserPassToURL(staticURL, "HTTP://", true));
                }
                else if(httpsSelected)
                {
                    remoteVFSItem_option_url.val(addUserPassToURL(staticURL, "HTTPS://", true));
                }
                else if(webdavSelected)
                {
                    remoteVFSItem_option_url.val(addUserPassToURL(staticURL, "WEBDAV://", true));
                }
                else if(webdavsSelected)
                {
                    remoteVFSItem_option_url.val(addUserPassToURL(staticURL, "WEBDAVS://", true));
                }
                else if(ftpsSelected)
                {
                    remoteVFSItem_option_url.val(addUserPassToURL(staticURL, "FTPS://", true));
                }
                else if(ftpesSelected)
                {
                    remoteVFSItem_option_url.val(addUserPassToURL(staticURL, "FTPES://", true));
                }
                else if(sftpSelected)
                {
                    remoteVFSItem_option_url.val(addUserPassToURL(staticURL, "SFTP://", true));
                }
                else if(s3Selected)
                {
                    remoteVFSItem_option_url.val(addUserPassToURLS3(staticURL, "s3://"));
                }
                curUrl = remoteVFSItem_option_url.val();
                var path = $("#remoteVFSItem_option_path", fieldPropertiesDialog).val();
                path = path || "/";
                if(base.options.existingData)
                {
                    base.options.existingData.path = path;
                }
                if(curUrl.toLowerCase().indexOf("file:/")==0)
                {
                    curUrl = "FILE:/" + path;
                }
                else
                {
                    var port = $("#remoteVFSItem_option_port", fieldPropertiesDialog).val();
                    var host = $("#remoteVFSItem_option_host", fieldPropertiesDialog).val();
                    var _url = URI(curUrl);
                    if(host)
                        _url.hostname(host);
                    if(typeof path != "undefined")
                        _url.path(path);
                    _url.port(""+port);
                    curUrl = unescape(_url.toString());
                }
                remoteVFSItem_option_url.val(curUrl);
            };

            function bindFTPFormData()
            {
                var attr = base.$el.attr("rel");
                var matchedElem = base.options.existingData || {
                    name : "",
                    path : "/",
                    type : "DIR",
                    url : "FILE:/"
                };
                if(matchedElem)
                {
                    var item_option_itemType = $("#remoteVFSItem_option_itemType", fieldPropertiesDialog);
                    fieldPropertiesDialog.clearForm();
                    var url = matchedElem[attr];
                    if($.isArray(url))
                        url = url[0].text;
                    if(!url)
                    {
                        url = "file://";
                    }
                    var lowCaseURL = url.toLowerCase();

                    if(lowCaseURL.indexOf("file:") == 0)
                    {
                        item_option_itemType.val("file");
                    }
                    else if(lowCaseURL.indexOf("ftp:") == 0)
                    {
                        item_option_itemType.val("ftp");
                        fieldPropertiesDialog.find("#remoteVFSItem_option_pasv").attr('checked', 'checked').trigger('change');
                    }
                    else if(lowCaseURL.indexOf("http:") == 0)
                    {
                        item_option_itemType.val("http");
                    }
                    else if(lowCaseURL.indexOf("https:") == 0)
                    {
                        item_option_itemType.val("https");
                    }
                    else if(lowCaseURL.indexOf("webdav:") == 0)
                    {
                        item_option_itemType.val("webdav");
                    }
                    else if(lowCaseURL.indexOf("webdavs:") == 0)
                    {
                        item_option_itemType.val("webdavs");
                    }
                    else if(lowCaseURL.indexOf("ftps:") == 0)
                    {
                        item_option_itemType.val("ftps");
                    }
                    if(lowCaseURL.indexOf("ftpes:") == 0)
                    {
                        item_option_itemType.val("ftpes");
                    }
                    else if(lowCaseURL.indexOf("sftp:") == 0)
                    {
                        item_option_itemType.val("sftp");
                    }
                    else if(lowCaseURL.indexOf("custom") == 0)
                    {
                        item_option_itemType.val("custom");
                    }
                    else if(lowCaseURL.indexOf("s3") == 0)
                    {
                        item_option_itemType.val("s3");
                    }
                    var val = URI(url);
                    matchedElem.path = val.path();
                    matchedElem.host = val.hostname();
                    matchedElem.port = val.port();
                    if(url.toLowerCase().indexOf("file:/")==0)
                        matchedElem.path = url.substr(url.indexOf(":")+2, url.length);
                    if(typeof window.userManager != "undefined")
                        window.userManager.data.bindValuesFromJson(fieldPropertiesDialog, matchedElem, "_name");
                    else if(typeof window.adminPanel != "undefined")
                        window.adminPanel.data.bindValuesFromJson(fieldPropertiesDialog, matchedElem, "_name");
                    else if(typeof window.bindValuesFromJson != "undefined")
                        window.bindValuesFromJson(fieldPropertiesDialog, matchedElem, "_name");

                    if(lowCaseURL && lowCaseURL.indexOf("s3") == 0)
                    {
                        $("#remoteVFSItem_option_secretKeyID", fieldPropertiesDialog).trigger("textchange");
                    }
                    url = fieldPropertiesDialog.find("#remoteVFSItem_option_url").trigger("change").val();
                    if(url && url.indexOf("file:") != 0)
                    {
                        if(url.indexOf("://")>=0)
                        {
                            url = url.substr(url.indexOf("://") + 3, url.length);
                            if(url.indexOf("@")>=0)
                            {
                                url = url.substr(0, url.indexOf("@"));
                                if(url && url.indexOf(":")>=0)
                                {
                                    var cred = url.split(":");
                                    if(cred.length>0)
                                    {
                                        $("#remoteVFSItem_option_user_name", fieldPropertiesDialog).val(cred[0]);
                                    }
                                    if(cred.length>1)
                                    {
                                        $("#remoteVFSItem_option_password", fieldPropertiesDialog).val(cred[1]);
                                    }
                                }
                            }
                        }
                    }
                    setTimeout(function() {
                        if(matchedElem.port != "" && matchedElem.port != $("#remoteVFSItem_option_port", fieldPropertiesDialog).val())
                        {
                            $("#remoteVFSItem_option_port", fieldPropertiesDialog).val(matchedElem.port).trigger("change");
                        }
                    }, 100);
                }
            }

            fieldPropertiesDialog.dialog({
                autoOpen: false,
                width: 700,
                modal: true,
                resizable: false,
                closeOnEscape: false,
                title : "Browse Remote Item : ",
                buttons: {
                    "Cancel" : function(){
                        $("#browsePopupFTPDialog").dialog("close");
                        $("#browsePopupFTPDialog").remove();
                        $(this).dialog("close");
                    },
                    "Connect": function() {
                        fieldPropertiesDialog.data("options", opts);
                        var that = $(this);
                        function continueProcess()
                        {
                            var name = $("#remoteVFSItem_option_name_static", fieldPropertiesDialog).val();
                            var newName = $("#remoteVFSItem_option_name", fieldPropertiesDialog).val();
                            var urlField = $("#remoteVFSItem_option_url", fieldPropertiesDialog);
                            var url = unescape(urlField.val());
                            if(url.lastIndexOf("/") != url.length - 1)
                            {
                                url = url + "/";
                            }
                            urlField.val(url);

                            var path = unescape($("#remoteVFSItem_option_path", fieldPropertiesDialog).val());
                            if(path.lastIndexOf("/") != path.length - 1)
                            {
                                path = path + "/";
                            }
                            path = path.replace(/\\/g,'/');
                            var isUNC = path.indexOf("//") == 0;
                            path = path.replace(/\/\//g,'/');
                            if(isUNC)
                            {
                                path = "/" + path;
                                url = "FILE:/" + path;
                                urlField.val(url);
                                $("#remoteVFSItem_option_path", fieldPropertiesDialog).val(path);
                            }
                            $("#remoteVFSItem_option_path", fieldPropertiesDialog).val(path);
                            var expireDate = $("#vfs_expire", fieldPropertiesDialog).val();
                            $("#remoteVFSItem_option_itemType", fieldPropertiesDialog).trigger("change");
                            if(crushFTP.methods.hasSpecialCharacters(newName, notAllowedCharsInDirName))
                            {
                                jAlert("You can not use these characters in name : \"" + notAllowedCharsInDirName + "\"", "Invalid name", function(){
                                    $("#remoteVFSItem_option_name", fieldPropertiesDialog).focus();
                                });
                                return false;
                            }
                            if(expireDate && expireDate.length>0)
                            {
                                if(crushFTP.methods.isDateTime(expireDate).length>0)
                                {
                                    jAlert("Please enter expiry date in valid format", "Invalid expire date", function(){
                                        $("#vfs_expire", fieldPropertiesDialog).focus();
                                    });
                                    return false;
                                }
                            }
                            var S3Selected = $("#remoteVFSItem_option_itemType", fieldPropertiesDialog).val() == "s3";
                            if(S3Selected)
                            {
                                fieldPropertiesDialog.find(".privateOptions").find("input").addClass("excludeXML");
                                fieldPropertiesDialog.find("*[name*='s3']").removeClass("excludeXML");
                            }
                            else
                            {
                                fieldPropertiesDialog.find("*[name*='s3']").addClass("excludeXML");
                                fieldPropertiesDialog.find(".privateOptions").find("input").removeClass("excludeXML");
                            }
                            var SSLOptionSelected = $("#remoteVFSItem_option_itemType", fieldPropertiesDialog).val() == "ftps" || $("#remoteVFSItem_option_itemType", fieldPropertiesDialog).val() == "https";
                            var ftpSelected = $("#remoteVFSItem_option_itemType", fieldPropertiesDialog).val() == "ftp";
                            if(SSLOptionSelected || (ftpSelected && $("#remoteVFSItem_option_ftpEncryption", fieldPropertiesDialog).val() == "true"))
                            {
                                fieldPropertiesDialog.find(".SSLOptions").find("input").removeClass("excludeXML");
                            }
                            else
                            {
                                fieldPropertiesDialog.find(".SSLOptions").find("input").addClass("excludeXML");
                            }

                            if(ftpSelected)
                            {
                                fieldPropertiesDialog.find(".ftpOptions").find("select, input").removeClass("excludeXML");
                            }
                            else
                            {
                                fieldPropertiesDialog.find(".ftpOptions").find("select, input").addClass("excludeXML");
                            }
                            var urlFieldName = urlField.attr("_name");
                            urlField.attr("_name", "url");
                            var itemProperties;
                            if(typeof window.userManager != "undefined")
                                itemProperties = userManager.data.buildXMLToSubmitForm(fieldPropertiesDialog, true, "_name");
                            else if(typeof window.adminPanel != "undefined")
                                itemProperties = adminPanel.data.buildXMLToSubmitForm(fieldPropertiesDialog, true, "_name");
                            else if(typeof window.buildXMLToSubmitForm != "undefined")
                                itemProperties = buildXMLToSubmitForm(fieldPropertiesDialog, true, "_name");
                            else
                            {
                                alert("No library available for : buildXMLToSubmitForm");
                                return false;
                            }
                            var type = "DIR";
                            if(url.lastIndexOf("/") != url.length - 1 && url.lastIndexOf("\\") != url.length - 1)
                                type = "FILE";
                            var itemPropertiesJSON = $.xml2json("<item>" +  unescape(itemProperties) + "<type>" + type + "</type>" + "</item>");
                            url = unescape(url);
                            if(url.toLowerCase().indexOf("file:")==0)
                            {
                                itemPropertiesJSON.path = unescape($("#remoteVFSItem_option_path", fieldPropertiesDialog).val());
                            }
                            else
                            {
                                var val = URI(url);
                                itemPropertiesJSON.path = val.path();
                            }
                            if(urlFieldName != "url")
                                itemPropertiesJSON[urlFieldName] = itemPropertiesJSON.url;
                            var browsePanel = $("#" + base.thisElemId);
                            browsePanel.removeData("isUNC");
                            browsePanel.data("ftpServerInfo", itemPropertiesJSON);
                            browsePanel.data("ftpServerInfoInit", true);
                            browsePanel.dialog("open");
                            urlField.attr("_name", urlFieldName);
                        }
                        if(fieldPropertiesDialog.find(".hasPendingCall").length>0)
                        {
                            window.pendingEncryptionCall = function(){
                                continueProcess();
                            };
                        }
                        else
                        {
                            continueProcess();
                        }
                    }
                },
                beforeClose : function(){
                    return true;
                },
                open: function(){
                    $([document, window]).unbind('.dialog-overlay');
                    bindFTPFormData();
                    showHideItemPropertiesSettings();
                    fieldPropertiesDialog.find(".tabs").tabs();
                    $("a.serverFilePickButton", fieldPropertiesDialog).each(function(){
                        $(this).unbind().click(function(){
                            var curElem = $(this);
                            var opts = $("#browsePopupFTPDialog").data("options");
                            $("#browsePopupFTPDialog").removeData("options");
                            curElem.crushFtpLocalFileBrowserPopup({
                                type : curElem.attr("PickType") || 'dir',
                                existingVal : $("#" + curElem.attr("rel"), fieldPropertiesDialog).val(),
                                callback : function(selectedPath){
                                    $("#" + curElem.attr("rel"), fieldPropertiesDialog).val(selectedPath).trigger("change");
                                    $("#browsePopupFTPDialog").data("options", opts);
                                },
                                callbackClose : function(){
                                    $("#browsePopupFTPDialog").data("options", opts);
                                }
                            });
                            return false;
                        });
                    });
                    fieldPropertiesDialog.dialog("option", "position", "center");
                }
            });

            $("#remoteVFSItem_option_itemType", fieldPropertiesDialog).unbind().change(function(){
                showHideItemPropertiesSettings();
                buildPropertiesURL();
            });

            fieldPropertiesDialog.find("#remoteVFSItem_option_user_name, #remoteVFSItem_option_password, #remoteVFSItem_option_secretKeyID, #remoteVFSItem_option_secretKey, #remoteVFSItem_option_path, #remoteVFSItem_option_port, #remoteVFSItem_option_host").unbind().bind("textchange", function(){
                buildPropertiesURL();
            });
        };

        base.listDevices = function() {
            var browsePanel = $("#" + base.thisElemId);
            var listElem = browsePanel.find('ul.devices');
            var deviceListHolder = listElem.parent().hide();
            if(base.options.isFTPBrowse || base.options.syncOpts)
            {
                base.bindListingEvents();
                return false;
            }
            if (base.options.useApplet && typeof window.runAppletCommand != "undefined") {
                if(!!navigator.userAgent.match(' Safari/') && !navigator.userAgent.match(' Chrom'))
                {
                    var apps = runAppletCommand(true, "COMMAND=LIST:::PATH=/Applications") + "";
                    if($.trim(apps).length==0)
                    {
                        var browsePanel = $("#" + base.thisElemId);
                        browsePanel.find(".loadingFS").hide();
                        browsePanel.find(".safari7Help").show();
                        return false;
                    }
                }
                var items = runAppletCommand(true, "COMMAND=LIST:::PATH=/Volumes");
                if (items && items.length > 0) {
                    items = items.split(";;;");
                    for (var i = 0; i < items.length; i++) {
                        items[i] = items[i].split(":::");
                    }
                    for (var j = 0; j < items.length; j++) {
                        var strItem = items[j];
                        var item = {};
                        for (var i = 0; i < strItem.length; i++) {
                            var curItem = strItem[i];
                            if (curItem) {
                                var ind = curItem.indexOf("=");
                                if (ind >= 0) {
                                    var key = curItem.substring(0, ind);
                                    var val = curItem.substring(ind + 1, curItem.length);
                                    item[key] = val;
                                }
                            }
                        };
                        items[j] = item;
                    }
                    if (items && items.length > 0) {
                        items = items.sort(function(a,b){return a.name.toLowerCase()<b.name.toLowerCase();});
                        for (var i = 0; i < items.length; i++) {
                            var curItem = items[i];
                            if(curItem.name.indexOf(".")!=0)
                            {
                                var curHTML = $('<li rel="' + curItem.path + '">' + curItem.name + '</li>');
                                curHTML.data("curData", curItem);
                                listElem.append(curHTML);
                            }
                        };
                        deviceListHolder.slideDown('slow');
                    }
                }
            }
            else
            {
                var path = "/Volumes/";
                if($.CrushFTPOS == "windows")
                    path = "/";
                else if($.CrushFTPOS == "linux")
                    path = "/mnt/";
                else if($.CrushFTPOS == "mac")
                    path = "/Volumes/";
                else
                {
                    deviceListHolder.hide();
                    return false;
                }
                var obj = {
                    command: "getAdminXMLListing",
                    format: "JSON",
                    path: path,
                    random: Math.random()
                };
                obj.path = crushFTP.methods.htmlEncode(unescape(obj.path)).replace(/\+/g, "%2B");
                $.ajax({
                    type: "POST",
                    url: base.ajaxCallURL,
                    data: obj,
                    success: function (msg){
                        if (msg && msg.childNodes && msg.childNodes.length > 0) {
                            var items = $(msg).find("listing").text();
                            if(items)
                            {
                                items = items.replace(/\n/g,' ').replace(/\s/g,' ');
                                eval(items);
                                if(l && jQuery.isArray(l))
                                {
                                    items = l;
                                    if (items && items.length > 0) {
                                        for (var i = 0; i < items.length; i++) {
                                            var curItem = items[i];
                                            if(curItem.name.indexOf(".")!=0)
                                            {
                                                var curHTML = $('<li rel="' + curItem.href_path + '">' + curItem.name + '</li>');
                                                curHTML.data("curData", curItem);
                                                listElem.append(curHTML);
                                            }
                                        };
                                        deviceListHolder.slideDown('slow');
                                        base.bindListingEvents();
                                    }
                                }
                            }
                        }
                    }
                });
            }
        }

        base.listItems = function(pathToLoad, quickAccess) {
            $("#cluetip").hide();
            pathToLoad = pathToLoad || "/";
            var browsePanel = $("#" + base.thisElemId);
            var dropdown = browsePanel.find(".dropdown");
            if (pathToLoad == "/") {
                dropdown.empty().append("<option value='/'>/</option>");
            }
            var okBtn = $("div.localFileBrowserPopup:visible").find(".ui-dialog-buttonset").find("button:last");
            base.curLoadedPath = pathToLoad;
            var opts = options;
            if (opts.useApplet && typeof window.runAppletCommand != "undefined") {
                browsePanel.find(".loadingFS").show();
                setTimeout(function() {
                    if(quickAccess)
                    {
                        dropdown.find("option[value='/']:first").nextAll("option").remove();
                    }
                    var items = runAppletCommand(true, "COMMAND=LIST:::PATH=" + pathToLoad);
                    if (items && items.length > 0) {
                        items = items.split(";;;");
                        for (var i = 0; i < items.length; i++) {
                            items[i] = items[i].split(":::");
                        }
                        for (var j = 0; j < items.length; j++) {
                            var strItem = items[j];
                            var item = {};
                            for (var i = 0; i < strItem.length; i++) {
                                var curItem = strItem[i];
                                if (curItem) {
                                    var ind = curItem.indexOf("=");
                                    if (ind >= 0) {
                                        var key = curItem.substring(0, ind);
                                        var val = curItem.substring(ind + 1, curItem.length);
                                        item[key] = val;
                                    }
                                }
                            };
                            items[j] = item;
                        }
                        base.renderListing(items, pathToLoad);
                    } else {
                        base.renderListing([], pathToLoad);
                    }
                    var _path = pathToLoad.split("/");
                    dropdown.empty();
                    if(_path.length>0)
                    {
                        var items = [];
                        for (var i = 0; i < _path.length; i++) {
                            var calPath = "/" + _path.slice(1, i+1).join("/");
                            if(calPath.lastIndexOf("/")!=calPath.length-1)
                            {
                                calPath = calPath + "/";
                            }
                            if(dropdown.find("option[value='"+escape(calPath)+"']").length==0)
                            {
                                if(i == _path.length-1)
                                    dropdown.append("<option selected value='" + escape(calPath) + "'>" + unescape(calPath) + "</option>");
                                else
                                    dropdown.append("<option value='" + escape(calPath) + "'>" + unescape(calPath) + "</option>");
                            }
                            else
                            {
                                dropdown.find("option[value='"+escape(calPath)+"']").attr('selected', 'selected');
                            }
                        };
                    }
                    else
                    {
                        dropdown.append("<option value='/'>/</option>");
                    }

                    if(!quickAccess)
                    {
                        browsePanel.find(".quickLinkActive").removeClass('quickLinkActive');
                    }
                    if(base.options.type == "file")
                    {
                        okBtn.attr("disabled","disabled").addClass("ui-state-disabled");
                    }
                    else
                    {
                        okBtn.removeAttr("disabled").removeClass("ui-state-disabled");
                    }
                    setTimeout(function() {
                        browsePanel.find(".loadingFS").hide();
                    }, 10);
                }, 10);
            }
            else if(opts.isFTPBrowse || opts.syncOpts)
            {
                browsePanel.find(".loadingFS").show();
                var obj = {
                    command: "getAdminXMLListing",
                    format: "JSON",
                    path: pathToLoad,
                    random: Math.random()
                };
                if(opts.isServerBrowse)
                {
                    obj.command = "getXMLListing";
                }
                else if(opts.syncOpts)
                {
                    obj = {
                        command: "getAdminXMLListing",
                        format: "JSON",
                        get_from_agentid : opts.syncOpts.syncData.clientid,
                        admin_password : opts.syncOpts.password,
                        path: pathToLoad,
                        random: Math.random()
                    };
                }
                if(opts.isFTPBrowse && browsePanel.data("ftpServerInfo"))
                {
                    opts.ftpServerInfo = browsePanel.data("ftpServerInfo");
                    obj.serverGroup = $("#mainServerInstance").val() || "MainUsers";
                    obj.username = crushFTP.storage("username");
                    obj.command = "getUserXMLListing";
                    var isParentDir = false;
                    var isUNC = browsePanel.data("isUNC");
                    if(browsePanel.data("ftpServerInfoInit"))
                    {
                        var providedPath = opts.ftpServerInfo.path;
                        if(providedPath)
                        {
                            if(providedPath.lastIndexOf("/") != providedPath.length - 1)
                            {
                                providedPath = opts.ftpServerInfo.path = opts.ftpServerInfo.path + "/";
                            }
                            if(providedPath.indexOf("/") != 0)
                                providedPath = "/" + providedPath;
                            obj.path = providedPath;
                        }
                        browsePanel.removeData("ftpServerInfoInit");
                        isUNC = opts.ftpServerInfo.path.indexOf("//") == 0;
                        browsePanel.data("isUNC", isUNC);
                    }
                    var item = opts.ftpServerInfo;
                    var xml = "";
                    var isDirBrowse = false;
                    if(item)
                    {
                        var path = item.path || "/";
                        var attr = "url";
                        var itemType = item[attr].toLowerCase().indexOf("file:")==0 ? "DIR" : "";
                        if(typeof itemType != "undefined" && itemType != "DIR" && path.indexOf("/home/")<0)
                            path = "/home" + path;
                        if(typeof itemType != "undefined")
                            delete item.type;
                        path = path.replace(/\/\//g,'/');
                        if(itemType == "DIR")
                        {
                            item.url = item[attr] = "FILE:/" +item.path;
                            if(typeof item.host != "undefined")
                                delete item.host;
                            if(typeof item.port != "undefined")
                                delete item.port;
                        }
                        var urlAdded = false;
                        if(item.url && item.url.toLowerCase().indexOf("file:")==0)
                        {
                            var _path = unescape(obj.path);
                            item[attr] = item.url = "FILE:/" + _path;
                            obj.path = "/home/";
                        }
                        else if(obj.path.indexOf("/home/")<0)
                        {
                            obj.path = "/home" + obj.path;
                        }
                        xml += "\r\n<vfs_items_subitem type=\"properties\">";
                            xml += "\r\n<name>"+crushFTP.methods.htmlEncode(unescape(crushFTP.methods.decodeXML("home"))).replace(/\+/g, "%2B")+"</name>";
                            xml += "\r\n<path>"+crushFTP.methods.htmlEncode(unescape(crushFTP.methods.decodeXML("/"))).replace(/\+/g, "%2B")+"</path>";
                            xml += "\r\n<vfs_item type=\"vector\">";
                                xml += "\r\n<vfs_item_subitem type=\"properties\">";
                                    for(var prop in item)
                                    {
                                        if(prop != "name" && prop != "path")
                                        {
                                            var val = crushFTP.methods.htmlEncode(unescape(crushFTP.methods.decodeXML(item[prop]))).replace(/\+/g, "%2B");
                                            if(prop == "url" || prop == "destPath" || prop == "findUrl")
                                            {
                                                if(!urlAdded)
                                                {
                                                    prop = "url";
                                                    if(!isUNC)
                                                    {
                                                        if(itemType != "DIR")
                                                        {
                                                            var url = URI(val);
                                                            val = val.substr(0, val.lastIndexOf(url.path())) + "/";
                                                        }
                                                        else
                                                        {
                                                            xml += "\r\n<type>DIR</type>";
                                                            isDirBrowse = true;
                                                        }
                                                        item.url = val;
                                                    }
                                                    else
                                                    {
                                                        item.url = val = "FILE:///" +path;
                                                    }
                                                    xml += "\r\n<"+prop+">" + val + "</"+prop+">";
                                                    urlAdded = true;
                                                }
                                            }
                                            else if(prop != "type" && prop != "findUrl" && prop != "destPath")
                                            {
                                                xml += "\r\n<"+prop+">" + val + "</"+prop+">";
                                            }
                                        }
                                    }
                                xml += "\r\n</vfs_item_subitem>";
                            xml += "\r\n</vfs_item>";
                        xml += "\r\n</vfs_items_subitem>";
                    }
                    if(isUNC)
                        obj.path = "/home/";
                    obj.path = obj.path.replace(/\/\//g,'/');
                    obj.permissions = '<?xml version="1.0" encoding="UTF-8"?><VFS type="properties"><item name="/">(read)(view)(resume)</item></VFS>';
                    obj.vfs_items = '<?xml version="1.0" encoding="UTF-8"?><vfs_items type="vector">'+xml+'</vfs_items>';

                    browsePanel.data("ftpServerInfo", obj.ftpServerInfo);
                }

                obj.path = crushFTP.methods.htmlEncode(unescape(obj.path)).replace(/\+/g, "%2B");
                if(opts.isServerBrowse)
                {
                    obj.path = encodeURIComponent(unescape(obj.path)).replace(/\+/g, "%2B");
                }
                base.remoteLoadedPath = obj.path;
                /* Make a call and receive list */
                $.ajax({
                    type: "POST",
                    url: base.ajaxCallURL,
                    data: obj,
                    success: function (msg){
                        setTimeout(function() {
                            browsePanel.find(".loadingFS").hide();
                        }, 10);
                        if (msg && msg.childNodes && msg.childNodes.length > 0) {
                            var items = $(msg).find("listing").text();
                            if(items)
                            {
                                items = items.replace(/\n/g,' ').replace(/\s/g,' ');
                                eval(items);
                                if(l && jQuery.isArray(l))
                                {
                                    setTimeout(function() {
                                        if(quickAccess)
                                        {
                                            dropdown.find("option[value='/']:first").nextAll("option").remove();
                                        }
                                        items = l;
                                        if (items && items.length > 0) {
                                            base.renderListing(items, path);
                                        } else {
                                            base.renderListing([], path);
                                        }
                                        var _path = obj.path.split("/");
                                        dropdown.empty();
                                        if(_path.length>0)
                                        {
                                            var items = [];
                                            for (var i = 0; i < _path.length; i++) {
                                                var calPath = "/" + _path.slice(1, i+1).join("/");
                                                if(calPath.lastIndexOf("/")!=calPath.length-1)
                                                {
                                                    calPath = calPath + "/";
                                                }
                                                if(dropdown.find("option[value='"+escape(calPath)+"']").length==0)
                                                {
                                                    if(i == _path.length-1)
                                                        dropdown.append("<option selected value='" + escape(calPath) + "'>" + unescape(calPath) + "</option>");
                                                    else
                                                        dropdown.append("<option value='" + escape(calPath) + "'>" + unescape(calPath) + "</option>");
                                                }
                                                else
                                                {
                                                    dropdown.find("option[value='"+escape(calPath)+"']").attr('selected', 'selected');
                                                }
                                            };
                                        }
                                        else
                                        {
                                            dropdown.append("<option value='/'>/</option>");
                                        }

                                        if(!quickAccess)
                                        {
                                            browsePanel.find(".quickLinkActive").removeClass('quickLinkActive');
                                        }

                                        if(base.options.type == "file")
                                        {
                                            okBtn.attr("disabled","disabled").addClass("ui-state-disabled");
                                        }
                                        else
                                        {
                                            okBtn.removeAttr("disabled").removeClass("ui-state-disabled");
                                        }
                                    }, 10);
                                }
                            }
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        setTimeout(function() {
                            browsePanel.find(".loadingFS").hide();
                        }, 10);
                        errorThrown = errorThrown ||  obj.command + " failed";
                        if(crushFTP && crushFTP.UI && crushFTP.UI.growl)
                        {
                            crushFTP.UI.growl("Error", "Specified path not found, please choose another path.", true, 3000);
                        }
                        else
                            alert("Error : " + errorThrown);
                        base.listItems();
                        return false;
                    }
                });
            }
            else
            {
                var obj = {
                    command: "getAdminXMLListing",
                    format: "JSON",
                    path: pathToLoad,
                    random: Math.random()
                };
                obj.path = crushFTP.methods.htmlEncode(unescape(obj.path)).replace(/\+/g, "%2B");
                if(opts.isServerBrowse)
                {
                    obj.path = encodeURIComponent(unescape(obj.path)).replace(/\+/g, "%2B");
                }
                browsePanel.find(".loadingFS").show();
                /* Make a call and receive list */
                $.ajax({
                    type: "POST",
                    url: base.ajaxCallURL,
                    data: obj,
                    success: function (msg){
                        setTimeout(function() {
                            browsePanel.find(".loadingFS").hide();
                        }, 10);
                        if (msg && msg.childNodes && msg.childNodes.length > 0) {
                            var items = $(msg).find("listing").text();
                            if(items)
                            {
                                items = items.replace(/\n/g,' ').replace(/\s/g,' ');
                                eval(items);
                                if(l && jQuery.isArray(l))
                                {
                                    setTimeout(function() {
                                        if(quickAccess)
                                        {
                                            dropdown.find("option[value='/']:first").nextAll("option").remove();
                                        }
                                        items = l;
                                        if (items && items.length > 0) {
                                            base.renderListing(items, pathToLoad);
                                        } else {
                                            base.renderListing([], pathToLoad);
                                        }
                                        var _path = pathToLoad.split("/");
                                        dropdown.empty();
                                        if(_path.length>0)
                                        {
                                            var items = [];
                                            for (var i = 0; i < _path.length; i++) {
                                                var calPath = "/" + _path.slice(1, i+1).join("/");
                                                if(calPath.lastIndexOf("/")!=calPath.length-1)
                                                {
                                                    calPath = calPath + "/";
                                                }
                                                if(dropdown.find("option[value='"+escape(calPath)+"']").length==0)
                                                {
                                                    if(i == _path.length-1)
                                                        dropdown.append("<option selected value='" + escape(calPath) + "'>" + unescape(calPath) + "</option>");
                                                    else
                                                        dropdown.append("<option value='" + escape(calPath) + "'>" + unescape(calPath) + "</option>");
                                                }
                                                else
                                                {
                                                    dropdown.find("option[value='"+escape(calPath)+"']").attr('selected', 'selected');
                                                }
                                            };
                                        }
                                        else
                                        {
                                            dropdown.append("<option value='/'>/</option>");
                                        }

                                        if(!quickAccess)
                                        {
                                            browsePanel.find(".quickLinkActive").removeClass('quickLinkActive');
                                        }

                                        if(base.options.type == "file")
                                        {
                                            okBtn.attr("disabled","disabled").addClass("ui-state-disabled");
                                        }
                                        else
                                        {
                                            okBtn.removeAttr("disabled").removeClass("ui-state-disabled");
                                        }
                                    }, 10);
                                }
                            }
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        setTimeout(function() {
                            browsePanel.find(".loadingFS").hide();
                        }, 10);
                        errorThrown = errorThrown ||  obj.command + " failed";
                        if(crushFTP && crushFTP.UI && crushFTP.UI.growl)
                        {
                            crushFTP.UI.growl("Error", "Specified path not found, please choose another path.", true, 3000);
                        }
                        else
                            alert("Error : " + errorThrown);
                        base.listItems();
                        return false;
                    }
                });
            }
        };

        base.utils = {
            formatBytes: function(bytes) {
                if ((bytes / 1024).toFixed(0) == 0) return bytes + " bytes";
                else if ((bytes / 1024 / 1024).toFixed(0) == 0) return (bytes / 1024).toFixed(1) + " KB";
                else if ((bytes / 1024 / 1024 / 1024).toFixed(0) == 0) return (bytes / 1024 / 1024).toFixed(1) + " MB";
                else if ((bytes / 1024 / 1024 / 1024 / 1024).toFixed(0) == 0) return (bytes / 1024 / 1024 / 1024).toFixed(1) + " GB";
                else if ((bytes / 1024 / 1024 / 1024 / 1024 / 1024).toFixed(0) == 0) return (bytes / 1024 / 1024 / 1024 / 1024).toFixed(1) + " TB";
            },
            formatDate: function(d, f) {
                var zf = function(n, width, z) {
                    z = z || '0';
                    n = n + '';
                    return n.length >= width ? n : new Array(width - n.length + 1).join(z) + n;
                }
                return f.replace(/(yyyy|mmmm|mmm|mm|dddd|ddd|dd|hf|hh|nn|ss|a\/p)/gi,
                    function($1) {
                        switch ($1.toLowerCase()) {
                            case 'yyyy':
                                return d.getFullYear();
                            case 'mmmm':
                                return gsMonthNames[d.getMonth()];
                            case 'mmm':
                                return gsMonthNames[d.getMonth()].substr(0, 3);
                            case 'mm':
                                return zf((d.getMonth() + 1), 2);
                            case 'dddd':
                                return gsDayNames[d.getDay()];
                            case 'ddd':
                                return gsDayNames[d.getDay()].substr(0, 3);
                            case 'dd':
                                return zf(d.getDate(), 2);
                            case 'hf':
                                return d.getHours();
                            case 'hh':
                                return zf(((h = d.getHours() % 12) ? h : 12), 2);
                            case 'nn':
                                return zf(d.getMinutes(), 2);
                            case 'ss':
                                return zf(d.getSeconds(), 2);
                            case 'a/p':
                                return d.getHours() < 12 ? 'AM' : 'PM';
                        }
                    }
                );
            },
            clearRangeSelection: function() {
                setTimeout(function() {
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
                }, 100);
            }
        };

        base.bindListingEvents = function() {
            var browsePanel = $("#" + base.thisElemId);
            var delay = (function() {
                var timer = 0;
                return function(callback, ms) {
                    clearTimeout(timer);
                    timer = setTimeout(callback, ms);
                };
            })();

            var listing = browsePanel.find("table.listing.files");

            function filterListing(phrase) {
                if (base.last_search_item && base.last_search_item === phrase) {
                    return false;
                }
                if (!phrase)
                    listing.find("tr").show();
                else {
                    listing.find("tr").hide();
                    listing.find("td.name:Contains(" + phrase + ")").parent().show();
                }
            }

            var fltr = browsePanel.find('.filter').unbind("keyup").keyup(function(evt) {
                var evt = (evt) ? evt : ((event) ? event : null);
                var val = this.value;

                function startFilter() {
                    setTimeout(function() {
                        filterListing(val);
                    }, 10);
                }
                if (evt.keyCode == 13) {
                    startFilter();
                } else if (evt.keyCode == 27) {
                    $(this).val("");
                    val = "";
                    startFilter();
                } else {
                    delay(function() {
                        startFilter();
                    }, 700);
                }
            });

            browsePanel.find('.clearFilter').unbind().click(function(event) {
                fltr.val("").trigger('keyup');
                return false;
            });

            var dropdown = browsePanel.find('.dropdown').unbind().change(function(event) {
                base.listItems(unescape($(this).val()));
                base.utils.clearRangeSelection();
                return false;
            });

            browsePanel.find('.refreshImg').unbind().click(function(event) {
                dropdown.trigger('change');
                return false;
            });

            browsePanel.find('.chkBoxAll').unbind().change(function(event) {
                if ($(this).is(":checked")) {
                    listing.find('input:checkbox:not(:disabled)').attr('checked', 'checked');
                } else {
                    listing.find('input:checkbox').removeAttr('checked');
                }
                return false;
            });

            browsePanel.find('.quickAccessLinks').find("li").unbind().click(function(event) {
                var rel = $(this).attr("rel");
                if(rel)
                {
                    if (options.useApplet)
                    {
                        if(rel.indexOf("~")==0)
                        {
                            rel = runAppletCommand(true, "COMMAND=RESOLVE:::PATH=" + rel);
                            var items = rel.split(";;;");
                            for (var i = 0; i < items.length; i++) {
                                items[i] = items[i].split(":::");
                            }
                            for (var j = 0; j < items.length; j++) {
                                var strItem = items[j];
                                var item = {};
                                for (var i = 0; i < strItem.length; i++) {
                                    var curItem = strItem[i];
                                    if (curItem) {
                                        var ind = curItem.indexOf("=");
                                        if (ind >= 0) {
                                            var key = curItem.substring(0, ind);
                                            var val = curItem.substring(ind + 1, curItem.length);
                                            item[key] = val;
                                        }
                                    }
                                };
                                items[j] = item;
                            }
                            rel = items[0].path;
                        }
                        base.listItems(rel, true);
                    }
                    else
                    {
                        if(rel.lastIndexOf("/")!=rel.length-1)
                        {
                            rel = rel + "/";
                        }
                        base.listItems(rel, true);
                    }
                    browsePanel.find(".quickLinkActive").removeClass('quickLinkActive');
                    $(this).addClass('quickLinkActive');
                }
                return false;
            }).hover(function(){
                $(this).addClass('quickLinkHover');
            },function(){
                $(this).removeClass('quickLinkHover');
            });
        }

        base.showHideSystemFiles = function() {
            var browsePanel = $("#" + base.thisElemId);
            if (browsePanel.find(".showSystemFiles").is(":checked"))
                browsePanel.find("table.listing.files").removeClass('NoHiddenFiles');
            else
                browsePanel.find("table.listing.files").addClass('NoHiddenFiles');
        }

        base.bindRowEvents = function() {
            var browsePanel = $("#" + base.thisElemId);
            var listing = browsePanel.find("table.listing.files");
            if(base.options.type == "dir")
            {
                listing.find('td._file').parent().addClass('ui-state-disabled').find('input:checkbox').removeAttr('checked').attr('disabled', 'disabled');
            }
            if(base.options.singleSelection)
            {
                browsePanel.find('input:checkbox:not(.showSystemFiles)').css("visibility", "hidden");
                var okBtn = $("div.localFileBrowserPopup:visible").find(".ui-dialog-buttonset").find("button:last");
                listing.find('td._dir, td._file').parent().bind('click', function() {
                    listing.find('.selected').removeClass('selected');
                    if(base.options.type == "dir" && $(this).find("td._file").length>0)
                    {
                        okBtn.attr("disabled","disabled").addClass("ui-state-disabled");
                    }
                    else if(base.options.type == "file" && $(this).find("td._dir").length>0)
                    {
                        okBtn.attr("disabled","disabled").addClass("ui-state-disabled");
                    }
                    else
                    {
                        okBtn.removeAttr("disabled").removeClass("ui-state-disabled");
                    }
                    $(this).addClass('selected');
                    base.utils.clearRangeSelection();
                    return false;
                });
            }
            listing.find('td._dir').parent().bind('dblclick', function() {
                var curData = $(this).data("curData");
                if (curData && curData.path) {
                    base.listItems(curData.path);
                    base.utils.clearRangeSelection();
                }
                return false;
            });

            if(typeof $.cluetip != "undefined")
            {
                listing.find(".vtip").cluetip({
                    splitTitle: '^',
                    showTitle: false,
                    width: 'auto',
                    cluetipClass: 'default',
                    clickThrough : true,
                    arrows: true,
                    tracking: true,
                    positionBy: 'mouse',
                    mouseOutClose: true,
                    dropShadowSteps: 2,
                    dynamicLeftOffset: true,
                    leftOffset: -250,
                    topOffset: 0
                });
            }

            listing.find('td._parent').parent().bind('click', function() {
                var dropdown = browsePanel.find('.dropdown');
                dropdown.find(':selected').removeAttr('selected').prev().attr('selected', 'selected');
                dropdown.trigger("change");
                return false;
            });

            listing.find('input:checkbox').click(function(evt) {
                if (evt.shiftKey) {
                    if (typeof base.lastSelected != "undefined") {
                        var baseElem = $(listing.find('tr').get(base.lastSelected));
                        var curIndex = $(this).closest('tr').index();
                        var isChecked = baseElem.find('input:checkbox').is(":checked");
                        var start = curIndex < base.lastSelected ? curIndex : base.lastSelected;
                        var end = curIndex < base.lastSelected ? base.lastSelected : curIndex;
                        for (var i = start; i < end; i++) {
                            if (isChecked)
                                $(listing.find('tr').get(i)).find('input:checkbox').attr('checked', 'checked');
                            else
                                $(listing.find('tr').get(i)).find('input:checkbox').removeAttr('checked');
                        };
                        listing.find('input:checkbox:first').trigger('change');
                    }
                }
                base.lastSelected = $(this).closest('tr').index();
            });

            listing.find('input:checkbox').change(function(event) {
                if (listing.find("input:not([checked]):visible").length > 0)
                    browsePanel.find(".chkBoxAll").removeAttr('checked');
                else
                    browsePanel.find(".chkBoxAll").attr('checked', 'checked');
            });
        }

        base.renderListing = function(items, path) {
            var browsePanel = $("#" + base.thisElemId);
            var listElem = browsePanel.find("table.listing.files").find("tbody").empty();
            if (items && items.length > 0) {
                function dynamicSort(property) {
                    var sortOrder = 1;
                    if (property[0] === "-") {
                        sortOrder = -1;
                        property = property.substr(1);
                    }
                    return function(a, b) {
                        var result = (a[property].toUpperCase() < b[property].toUpperCase()) ? -1 : (a[property].toUpperCase() > b[property].toUpperCase()) ? 1 : 0;
                        return result * sortOrder;
                    }
                }

                function dynamicSortMultiple() {
                    var props = arguments;
                    return function(obj1, obj2) {
                        var i = 0,
                            result = 0,
                            numberOfProperties = props.length;
                        while (result === 0 && i < numberOfProperties) {
                            result = dynamicSort(props[i])(obj1, obj2);
                            i++;
                        }
                        return result;
                    }
                }
                items = items.sort(dynamicSortMultiple("type", "name"));
                var nameLength = 35;
                for (var i = 0; i < items.length; i++) {
                    var curItem = items[i];
                    if(curItem.type)
                        curItem.type = curItem.type.toLowerCase();
                    if(curItem.href_path)
                    {
                        curItem.path = curItem.href_path;
                        if(curItem.type == "dir" && curItem.path.lastIndexOf("/")!=curItem.path.length-1)
                        {
                            curItem.path = curItem.path + "/";
                        }
                    }
                    var size = base.utils.formatBytes(curItem.size);
                    var date = base.utils.formatDate(new Date(parseInt(curItem.modified)), "mm/dd/yyyy");
                    var sysFile = curItem.name.indexOf(".") == 0 ? "class=sysFile" : "";
                    var name = curItem.name;
                    if (name && name.length >= nameLength) {
                        if(curItem.type == "file")
                        {
                            name = name.substr(0, nameLength-4) + ".." + base.getFileExtension(curItem.name);
                        }
                        else
                            name = name.substr(0, nameLength) + "...";
                    }
                    var curHTML = $('<tr ' + sysFile + '><td class="chekbox"><input class="chkBox" type="checkbox"></td><td title="'+(curItem.name)+'" class="vtip name lft _' + curItem.type + '">' + name + '</td><td class="size">' + size + '</td><td class="date">' + date + '</td></tr>');
                    curHTML.data("curData", curItem);
                    listElem.append(curHTML);
                };
            }
            if (path != "/") {
                var listElem = browsePanel.find("table.listing.files").find("tbody");
                listElem.prepend('<tr><td colspan="4" class="name lft _parent">..</td></tr>')
            }
            listElem.closest('.scrollableList').scrollTop(0);
            base.showHideSystemFiles();
            base.bindRowEvents()
        };

        // Run initializer
        base.init();
    };

    $.crushFtpLocalFileBrowserPopup.defaultOptions = {
        type: 'file',
        singleSelection : true,
        allowRootSelection : false
    };

    $.fn.crushFtpLocalFileBrowserPopup = function(options) {
        return this.each(function() {
            (new $.crushFtpLocalFileBrowserPopup(this, options));
        });
    };
})(jQuery);

jQuery.expr[':'].Contains = function(a, i, m) {
    return (a.textContent || a.innerText || "").toUpperCase().indexOf(m[3].toUpperCase()) >= 0;
};