/*!
* CrushFTP VFS Browse Popup
*
* Copyright @ SoftwareAG
*
*/

(function($){
    $.crushFtpVFSBrowserPopup = function(el, options){
        // To avoid scope issues, use 'base' instead of 'this'
        // to reference this class from internal events and functions.
        var base = this;

        // Access to jQuery and DOM versions of element
        base.$el = $(el);
        base.el = el;

        // Add a reverse reference to the DOM object
        base.$el.data("crushFtpVFSBrowserPopup", base);

        base.init = function(){
            base.options = $.extend({},$.crushFtpVFSBrowserPopup.defaultOptions, options);
            if($(document).data("crushftp_version"))
            {
                var versionNo = ($(document).data("crushftp_version")+"").replace( /^\D+/g, '');
                base.crushVersion = parseInt(versionNo);
            }
            //initialization code here
            base.initVFSBrowse(base.options);
        };

        base.initVFSBrowse = function(options)
        {
            var serverDirBrowsePanelPopup = $("#serverDirBrowsePanelPopup");
            if(serverDirBrowsePanelPopup.length==0)
            {
                var htmlToAppend = "<div id=\"serverDirBrowsePanelPopup\">";
                htmlToAppend += "<table style=\"width:100%;\">";
                htmlToAppend += "   <tr>";
                htmlToAppend += "       <td style=\"vertical-align: top;\">";
                htmlToAppend += "           <select id=\"serverDirSelectListPopup\" style=\"width: 250px;\">";
                htmlToAppend += "           </select> <a id='serverDirSelectListPopupRefresh' style='top: 3px;position: relative;left: 5px;' href='javascript:void(0);'><img src='/WebInterface/Resources/images/arrow_refresh_small.png' style='border:0px;' alt='Refresh' /></a>";
                htmlToAppend += "           <br />";
                htmlToAppend += "           <div class=\"LargeListBox ui-corner-all ui-widget-content nobg sideScroll\" style=\"width:315px;height:365px;\">";
                htmlToAppend += "               <ol class=\"nobg selectable multiple sideScroll\" id=\"serverDirListingPanelPopup\" name=\"serverDirListingPanelPopup\">";
                htmlToAppend += "               </ol>";
                htmlToAppend += "           </div>";
                htmlToAppend += "       </td>";
                htmlToAppend += "   </tr>";
                htmlToAppend += "</table>";
                htmlToAppend += "</div>";
                $("body").append(htmlToAppend);
                serverDirBrowsePanelPopup = $("#serverDirBrowsePanelPopup").hide();
                var serverDirSelectList = $("#serverDirSelectListPopup", serverDirBrowsePanelPopup);
                base.dirSelectEventActive(true);
            }
            serverDirBrowsePanelPopup.find(".note").remove();
            if(options.note)
            {
                serverDirBrowsePanelPopup.find("#dirList").after("<div class='note' style='margin-top:10px;'>"+ options.note +"</div>");
            }
            serverDirBrowsePanelPopup.dialog({
                autoOpen: false,
                title : "Select Path",
                height: 520,
                width: 350,
                modal: true,
                resizable: false,
                closeOnEscape: false,
                buttons: {
                    "Cancel" : function(){
                        $(this).dialog("close");
                        var opts = $("#browsePopupFTPDialog").data("options") || base.options;
                        if(opts.callbackClose)
                        {
                            opts.callbackClose();
                        }
                    },
                    "OK": function() {
                        var opts = $("#browsePopupFTPDialog").data("options") || base.options;
                        var clbkMethod = opts.callback;
                        var selected = $("#serverDirListingPanelPopup").find("li.ui-selected");
                        if(selected.length>0)
                        {
                            if(clbkMethod)
                            {
                                if(opts.allowMultiple)
                                {
                                    var selection = [];
                                    selected.each(function(){
                                        selection.push(unescape($(this).attr("hrefpath")));
                                    });
                                    clbkMethod(selection.join("\n"), opts.ftpServerInfo);
                                }
                                else
                                {
                                    var path = unescape(selected.attr("hrefpath"));
                                    path = path.replace("/home/", "");
                                    if(opts.isFTPBrowse)
                                    {
                                        if(path.indexOf("/")==0)
                                            path = path.replace("/", "");
                                        if(opts.ftpServerInfo.url.indexOf(path)<0)
                                        {
                                            opts.ftpServerInfo.url += path;
                                        }
                                        clbkMethod(unescape(selected.attr("hrefpath")), opts.ftpServerInfo);
                                    }
                                    else
                                    {
                                        clbkMethod(unescape(selected.attr("hrefpath")));
                                    }
                                }
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
                            if(opts.type == "dir" || opts.type == "both" || opts.type == "any")
                            {
                                var path = $("#serverDirSelectListPopup").find(":selected").attr("hrefPath");
                                if(!path)
                                {
                                    if(opts.alowRootSelection)
                                        path = "/";
                                    else
                                        return false;
                                }
                                path = path.replace("/home/", "");
                                if(opts.isFTPBrowse)
                                {
                                    if(path.indexOf("/")==0)
                                        path = path.replace("/", "");
                                    if(opts.ftpServerInfo.url.indexOf(path)<0)
                                    {
                                        opts.ftpServerInfo.url += path;
                                    }
                                    clbkMethod(unescape(path), opts.ftpServerInfo);
                                    $("#browsePopupFTPDialog").dialog("close");
                                    $("#browsePopupFTPDialog").remove();
                                }
                                else
                                {
                                    clbkMethod(unescape(path));
                                }
                                $(this).dialog("close");
                            }
                            return false;
                        }
                    }
                },
                beforeClose : function(){
                    return true;
                },
                open : function(){
                    $([document, window]).unbind('.dialog-overlay');
                    base.browseVFSItem();
                }
            });
            $("#serverDirSelectListPopup").empty().append("<option hrefPath ='/'  value='/' path='/'>/</option>");
            serverDirBrowsePanelPopup.attr("pickType", options.type);
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
            }
            else
            {
                serverDirBrowsePanelPopup.dialog("open");
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
                            var serverDirBrowsePanelPopup = $("#serverDirBrowsePanelPopup");
                            serverDirBrowsePanelPopup.removeData("isUNC");
                            serverDirBrowsePanelPopup.data("ftpServerInfo", itemPropertiesJSON);
                            serverDirBrowsePanelPopup.data("ftpServerInfoInit", true);
                            //that.dialog("close");
                            serverDirBrowsePanelPopup.dialog("open");
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
                            curElem.crushFtpVFSBrowserPopup({
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

        base.dirSelectEventActive = function(flag)
        {
            var serverDirSelectList = $("#serverDirSelectListPopup");
            var serverDirSelectListPopupRefresh = $("#serverDirSelectListPopupRefresh");
            serverDirSelectList.unbind();
            serverDirSelectListPopupRefresh.unbind();
            if(flag)
            {
                serverDirSelectList.change(function(){
                    $(this).find("option:selected").nextAll("option").remove();
                    base.browseVFSItem(unescape($(this).val()), true);
                    return false;
                });

                serverDirSelectListPopupRefresh.click(function(event) {
                    serverDirSelectList.trigger('change');
                    return false;
                });
            }
        }

        base.existingVal = function()
        {
            if(base.crushVersion && base.crushVersion>6)
            {
                //Get file extension from file name
                function getFileExtension(filename) {
                    var ext = /^.+\.([^.]+)$/.exec(filename);
                    return ext == null ? "" : ext[1].toLowerCase();
                }
                var opts = $("#browsePopupFTPDialog").data("options") || base.options;
                base.options = opts;
                if(base.options.existingVal)
                {
                    var val = base.options.existingVal;
                    if(getFileExtension(val)!="" || val.lastIndexOf("/")>=0)
                    {
                        delete base.options.existingVal;
                        var opt = $("#browsePopupFTPDialog").data("options");
                        if(opt && opt.existingVal)
                        {
                            delete opt.existingVal;
                            $("#browsePopupFTPDialog").data("options", opt);
                        }
                        return val.substring(0, val.lastIndexOf("/"));
                    }
                }
            }
            return false;
        }

        base.browseVFSItem = function(curDir, fromDD, _hrefPath, init, directLink)
        {
            var opts = $("#browsePopupFTPDialog").data("options") || base.options;
            base.options = opts;
            var serverDirBrowsePanelPopup = $("#serverDirBrowsePanelPopup").block({
                message:  '<div><span style="float: left; margin-right: 0.3em;" class="ui-icon ui-icon-refresh"></span>Please wait..</div>',
                css: {
                    border: 'none',
                    padding: '15px',
                    backgroundColor: '#000',
                    '-webkit-border-radius': '10px',
                    '-moz-border-radius': '10px',
                    opacity: .5,
                    color: '#fff',
                    width: '100px',
                    'text-align':'left'
                }
            });
            var _existingVal = base.existingVal();
            if(_existingVal)
                init = true;
            curDir = curDir || _existingVal || "/";
            var ajaxCallURL = "/WebInterface/function/";
            var serverDirSelectList = $("#serverDirSelectListPopup");
            if(curDir != "/" && !fromDD)
            {
                if(unescape(serverDirSelectList.val()) != "/" && !directLink)
                {
                    if(unescape(serverDirSelectList.val()).lastIndexOf("/")!=unescape(serverDirSelectList.val()).length-1)
                    {
                        curDir = unescape(serverDirSelectList.val()) + "/" + curDir;
                    }
                    else
                        curDir = unescape(serverDirSelectList.val()) + curDir;
                }
                else if(curDir.indexOf("/")<0)
                    curDir = "/" + curDir;
            }
            if(curDir.lastIndexOf("/")!=curDir.length-1)
            {
                curDir = curDir + "/";
            }
            curDir = curDir.replace("\\/", "");
            curDir = curDir.replace("//", "/");
            var itemsPanel = $("#serverDirListingPanelPopup");
            if(opts.isVFSBrowse)
            {
                var obj = {
                    format: "JSON",
                    path: unescape(curDir.replace(/\+/g, "%2B")),
                    random: Math.random()
                };
                obj.serverGroup = $("#userConnectionGroups").val() || "MainUsers";
                obj.username = opts.userNameForVFS || crushFTP.storage("userName");
                obj.command = "getUserXMLListing";
                var perms;
                var panelSetup = window.panelSetup || false;
                if(panelSetup)
                {
                    if(opts.extraVFS)
                        perms = panelSetup.generatePrivsXML(false, false, opts.extraVFS);
                    else
                        perms = panelSetup.generatePrivsXML();

                    if(perms)

                        obj.permissions = perms;
                    var xml;
                    if(opts.extraVFS)
                        xml = panelSetup.generateVFSXML(false, false, opts.extraVFS);
                    else
                        xml = panelSetup.generateVFSXML();
                    if(xml)
                        obj.vfs_items = xml;
                    if(!obj.vfs_items || obj.vfs_items.length == 0)
                    {
                        obj.vfs_items = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><vfs type=\"properties\"></vfs>";
                    }
                    $.ajax({
                        type: "POST",
                        url: ajaxCallURL,
                        data: obj,
                        success: function (msg){
                            serverDirBrowsePanelPopup.unblock();
                            if (msg && msg.childNodes && msg.childNodes.length > 0) {
                                var items = $(msg).find("listing").text();
                                if(items)
                                {
                                    items = items.replace(/\n/g,' ').replace(/\s/g,' ');
                                    eval(items);
                                    if(l && jQuery.isArray(l))
                                    {
                                        var selectedItems;
                                        itemsPanel.empty();
                                        for(var i=0; i<=l.length;i++)
                                        {
                                            var curItem = l[i];
                                            if(curItem && unescape(curItem.name).length>0)
                                            {
                                                var name = unescape(curItem.name.toString());
                                                if(name.indexOf(".")!=0 && curItem.type.toLowerCase() == "dir")
                                                {
                                                    var hrefPath = curDir + name;
                                                    if(curItem.type.toLowerCase() == "dir")
                                                    {
                                                         hrefPath += "/";
                                                    }
                                                    var privs = curItem.privs;
                                                    if(privs.length==0)
                                                        privs = "(comment)";
                                                    var newElem = $("<li style='padding:5px 10px;' hrefPath=\""+escape(hrefPath)+"\" curPath=\""+escape(curItem.href_path)+"\" rootDir=\""+escape(curItem.root_dir)+"\" name=\""+curItem.name+"\" path=\""+escape(curItem.name)+"\" privs=\""+privs+"\" _type='"+curItem.type.toLowerCase()+"'>"+name+"</li>");
                                                    var matchedElem = panelSetup.checkIfCurrentDirIsVFSItem(curItem.root_dir, name);
                                                    newElem.addClass("vfsOrigItem");
                                                    if(matchedElem && matchedElem.url.length == 0)
                                                        newElem.removeClass("vfsOrigItem");
                                                    itemsPanel.append(newElem);
                                                    newElem.data("hrefPath", crushFTP.methods.decodeXML(hrefPath));
                                                }
                                            }
                                        }
                                        if(curDir != "/" || isParentDir)
                                        {
                                            if(serverDirSelectList.find("option[value='"+escape(curDir)+"']").attr("selected", "selected").length==0)
                                            {
                                                if(curDir)
                                                {
                                                    curDir = curDir.replace("\\/", "");
                                                    curDir = curDir.replace("//", "/");
                                                }
                                                if(_hrefPath)
                                                {
                                                    _hrefPath = _hrefPath.replace("\\/", "");
                                                    _hrefPath = _hrefPath.replace("//", "/");
                                                    if(isUNC)
                                                    {
                                                        if(_hrefPath.indexOf("/")!=0)
                                                            curDir = _hrefPath = "/" + _hrefPath;
                                                        curDir = _hrefPath = "/" + _hrefPath;
                                                    }
                                                }
                                                if(isUNC)
                                                {
                                                    if(curDir.indexOf("//")!=0)
                                                        curDir = _hrefPath = "/" + curDir;
                                                }
                                                if(curDir.lastIndexOf("/")!=curDir.length-1)
                                                {
                                                    _hrefPath = curDir = curDir + "/";
                                                }
                                                base.dirSelectEventActive(false);
                                                serverDirSelectList.find("option[value='"+escape(curDir)+"']:first").nextAll("option").remove();
                                                serverDirSelectList.find("option[value='"+escape(curDir)+"']").remove();
                                                serverDirSelectList.append("<option selected hrefPath = '"+_hrefPath+"' value='"+escape(curDir)+"'>"+unescape(curDir)+"</option>");
                                                base.dirSelectEventActive(true);
                                            }
                                        }
                                        if(curDir == "/")
                                        {
                                            base.dirSelectEventActive(false);
                                            serverDirSelectList.find("option[value='"+escape(curDir)+"']:first").nextAll("option").remove();
                                            serverDirSelectList.find("option[value='"+escape(curDir)+"']").remove();
                                            serverDirSelectList.append("<option selected hrefPath = '/' value='"+escape(curDir)+"'>"+unescape(curDir)+"</option>");
                                            base.dirSelectEventActive(true);
                                        }
                                        itemsPanel.prepend("<li style='padding:5px 10px;' curLevel=\""+curDir+"\" class='uplevelLink' upLevel=\"true\">..</li>");

                                        if(itemsPanel.find("li:first").length>0)
                                            itemsPanel.parent().scrollTo(itemsPanel.find("li:first"));

                                        setTimeout(function() {
                                            itemsPanel.find("li").hover(function(){
                                                $(this).addClass("hoverVFS");
                                            }, function(){
                                                $(this).removeClass("hoverVFS");
                                            })
                                        }, 200);

                                        base.formatDirListingItems(itemsPanel);

                                        setTimeout(function(){
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
                                        serverDirBrowsePanelPopup.unblock();
                                    }
                                }
                            }
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            serverDirBrowsePanelPopup.unblock();
                            errorThrown = errorThrown || "The path requested is not accessible or no longer available : \"" + obj.path + "\"";
                            crushFTP.UI.growl("Error : ", errorThrown, true, true);
                            crushFTP.UI.hideIndicator(false, itemsPanel.closest("td"));
                        }
                    });
                }
                else
                {
                    alert("VFS selection is only available for User Manager");
                    return false;
                }
            }
            else
            {
                var obj = {
                    command: "getAdminXMLListing",
                    format: "JSON",
                    path: curDir,
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
                        path: curDir,
                        random: Math.random()
                    };
                }
                if(opts.isFTPBrowse && serverDirBrowsePanelPopup.data("ftpServerInfo"))
                {
                    opts.ftpServerInfo = serverDirBrowsePanelPopup.data("ftpServerInfo");
                    obj.serverGroup = $("#mainServerInstance").val() || "MainUsers";
                    obj.username = crushFTP.storage("username");
                    obj.command = "getUserXMLListing";
                    var isParentDir = false;
                    var isUNC = serverDirBrowsePanelPopup.data("isUNC");
                    if(serverDirBrowsePanelPopup.data("ftpServerInfoInit"))
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
                        serverDirBrowsePanelPopup.removeData("ftpServerInfoInit");
                        isUNC = opts.ftpServerInfo.path.indexOf("//") == 0;
                        if(providedPath && providedPath.indexOf("/")>=0)
                        {
                            serverDirSelectList.empty();
                            var paths = providedPath.split("/");
                            var parent = "";
                            base.dirSelectEventActive(false);
                            serverDirSelectList.append("<option selected hrefPath ='/'  value='/' path='/'>/</option>");
                            for (var i = 0; i < paths.length; i++) {
                                var curPath = paths[i];
                                if(curPath.length>0)
                                {
                                    if(i>0 && paths[i-1].length>0)
                                    {
                                        if(paths[i-1].lastIndexOf("/") != paths[i-1].length - 1)
                                            parent = parent + paths[i-1];
                                        else
                                            parent = parent + "/" + paths[i-1];
                                    }
                                    if(parent.lastIndexOf("/") != parent.length - 1)
                                        parent = parent + "/";
                                    var valLink = "/" + parent + curPath;
                                    valLink = valLink.replace(/\/\//g,'/');
                                    valLink = valLink.replace(/\/\//g,'/');
                                    if(isUNC)
                                        valLink = "/" + valLink;
                                    if(valLink.lastIndexOf("/") != valLink.length - 1)
                                        valLink = valLink + "/";
                                    serverDirSelectList.append("<option selected hrefPath ='"+valLink+"'  value='"+escape(valLink)+"'>"+unescape(valLink)+"</option>");
                                    isParentDir = true;
                                    curDir = valLink;
                                }
                            };
                            base.dirSelectEventActive(true);
                        }
                        if(serverDirSelectList.find("option").length==0)
                        {
                            base.dirSelectEventActive(false);
                            serverDirSelectList.append("<option selected hrefPath ='/'  value='/' path='/'>/</option>");
                            base.dirSelectEventActive(true);
                        }
                        serverDirBrowsePanelPopup.data("isUNC", isUNC);
                    }
                    var item = opts.ftpServerInfo;
                    var xml = "";
                    var isDirBrowse = false;
                    if(item)
                    {
                        var path = item.path || "/";
                        var attr = "url";
                        var itemType = item[attr].toLowerCase().indexOf("file:")==0 ? "DIR" : "";
                        if(typeof itemType != "undefined" && itemType != "DIR")
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
                        else
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
                                                        item.url = val = "FILE:///" +curDir;
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
                }

                obj.path = crushFTP.methods.htmlEncode(unescape(obj.path)).replace(/\+/g, "%2B");
                if(opts.isServerBrowse)
                {
                    obj.path = encodeURIComponent(unescape(obj.path)).replace(/\+/g, "%2B");
                }
                /* Make a call and receive list */
                $.ajax({
                    type: "POST",
                    url: ajaxCallURL,
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
                                    itemsPanel.empty();
                                    for(var i=0; i<=l.length;i++)
                                    {
                                        var curItem = l[i];
                                        if(curItem)
                                        {
                                            var syncedItemClass = (curItem.privs && curItem.privs.indexOf("syncName=")!=-1) ? "syncItem" : "";
                                            if(curItem && unescape(curItem.name).length>0 && curItem.type)
                                            {
                                                var name = unescape(curItem.name.toString());
                                                if(name.indexOf(".")!=0)
                                                {
                                                    var hrefPath = "";
                                                    if(curItem.href_path)
                                                    {
                                                        hrefPath = unescape(curItem.href_path);
                                                        if(isUNC)
                                                        {
                                                            hrefPath = unescape(curDir) + unescape(curItem.name);
                                                        }
                                                        if(curItem.type.toLowerCase() == "dir" && hrefPath.lastIndexOf("/") != hrefPath.length-1)
                                                        {
                                                            hrefPath = hrefPath + "/";
                                                        }
                                                    }
                                                    itemsPanel.append("<li style='padding:5px 10px;' class='"+syncedItemClass+"' hrefPath='"+escape(hrefPath)+"' name='"+unescape(curItem.name)+"' path='"+unescape(curItem.name)+"' privs='"+curItem.privs+"' _type='"+curItem.type.toLowerCase()+"'>"+name+"</li>");
                                                }
                                            }
                                            else if(curItem && unescape(curItem.href_path).length>0 && curItem.type)
                                            {
                                                var name = unescape(curItem.href_path);
                                                name = name.substr(name.lastIndexOf("/") + 1, name.length-1);
                                                if(name.length==0)
                                                {
                                                    name = unescape(curItem.href_path);
                                                    name = name.substr(0, name.lastIndexOf("/"));
                                                }
                                                if(name.indexOf(".")!=0)
                                                {
                                                    var hrefPath = escape(name);
                                                    if(isUNC)
                                                    {
                                                        hrefPath = unescape(curDir) + unescape(curItem.name);
                                                    }
                                                    if(curItem.type.toLowerCase() == "dir" && hrefPath.lastIndexOf("/") != hrefPath.length-1)
                                                    {
                                                        hrefPath = hrefPath + "/";
                                                    }
                                                    itemsPanel.append("<li style='padding:5px 10px;' class='"+syncedItemClass+"' hrefPath='"+escape(hrefPath)+"' name='"+unescape(curItem.name)+"' path='"+name+"' privs='"+curItem.privs+"' _type='"+curItem.type.toLowerCase()+"'>"+name+"</li>");
                                                }
                                            }
                                        }
                                    }
                                    if(curDir != "/" || isParentDir)
                                    {
                                        if(serverDirSelectList.find("option[value='"+escape(curDir)+"']").attr("selected", "selected").length==0)
                                        {
                                            if(curDir)
                                            {
                                                curDir = curDir.replace("\\/", "");
                                                curDir = curDir.replace("//", "/");
                                            }
                                            if(_hrefPath)
                                            {
                                                _hrefPath = _hrefPath.replace("\\/", "");
                                                _hrefPath = _hrefPath.replace("//", "/");
                                                if(isUNC)
                                                {
                                                    if(_hrefPath.indexOf("/")!=0)
                                                        curDir = _hrefPath = "/" + _hrefPath;
                                                    curDir = _hrefPath = "/" + _hrefPath;
                                                }
                                            }
                                            if(isUNC)
                                            {
                                                if(curDir.indexOf("//")!=0)
                                                    curDir = _hrefPath = "/" + curDir;
                                            }
                                            if(curDir.lastIndexOf("/")!=curDir.length-1)
                                            {
                                                _hrefPath = curDir = curDir + "/";
                                            }
                                            base.dirSelectEventActive(false);
                                            serverDirSelectList.find("option[value='"+escape(curDir)+"']:first").nextAll("option").remove();
                                            serverDirSelectList.find("option[value='"+escape(curDir)+"']").remove();
                                            serverDirSelectList.append("<option selected hrefPath = '"+_hrefPath+"' value='"+escape(curDir)+"'>"+unescape(curDir)+"</option>");
                                            base.dirSelectEventActive(true);
                                        }
                                        itemsPanel.prepend("<li style='padding:5px 10px;' isUNC='"+isUNC+"' curLevel=\""+curDir+"\" class='uplevelLink' upLevel=\"true\">..</li>");
                                    }
                                    if(curDir == "/")
                                    {
                                        base.dirSelectEventActive(false);
                                        serverDirSelectList.find("option[value='"+escape(curDir)+"']:first").nextAll("option").remove();
                                        serverDirSelectList.find("option[value='"+escape(curDir)+"']").remove();
                                        serverDirSelectList.append("<option selected hrefPath = '/' value='"+escape(curDir)+"'>"+unescape(curDir)+"</option>");
                                        base.dirSelectEventActive(true);
                                    }
                                    else if(init)
                                    {
                                        base.dirSelectEventActive(false);
                                        var _path = curDir.split("/");
                                        serverDirSelectList.empty();
                                        if(_path.length>0)
                                        {
                                            var items = [];
                                            for (var i = 0; i < _path.length; i++) {
                                                var val = "/" + _path.slice(1, i+1).join("/");
                                                if(val.lastIndexOf("/")!=val.length-1)
                                                {
                                                    val = val + "/";
                                                }
                                                if(serverDirSelectList.find("option[value='"+escape(val)+"']").length==0)
                                                {
                                                    if(i != _path.length-1)
                                                        serverDirSelectList.append("<option selected hrefPath='"+(val)+"' value='" + escape(val) + "'>" + unescape(val) + "</option>");
                                                    else
                                                        serverDirSelectList.append("<option hrefPath='"+(val)+"' value='" + escape(val) + "'>" + unescape(val) + "</option>");
                                                }
                                            };
                                        }
                                        else
                                        {
                                            serverDirSelectList.append("<option hrefPath='/' value='/'>/</option>");
                                        }
                                        base.dirSelectEventActive(true);
                                    }
                                    if(itemsPanel.find("li:first").length>0)
                                        itemsPanel.parent().scrollTo(itemsPanel.find("li:first"));

                                    setTimeout(function() {
                                        itemsPanel.find("li").hover(function(){
                                            $(this).addClass("hoverVFS");
                                        }, function(){
                                            $(this).removeClass("hoverVFS");
                                        })
                                    }, 200);

                                    base.formatDirListingItems(itemsPanel);

                                    setTimeout(function(){
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
                                    serverDirBrowsePanelPopup.unblock();
                                }
                            }
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        serverDirBrowsePanelPopup.unblock();
                        errorThrown = errorThrown ||  obj.command + " failed";
                        if(init)
                        {
                            crushFTP.UI.growl("Error", "Specified path not found, please choose another path.", true, 3000);
                            base.browseVFSItem(false, fromDD);
                        }
                        else
                            alert("Error : " + errorThrown);
                        return false;
                    }
                });
            }
        };

        base.formatDirListingItems = function(list)
        {
            var serverDirBrowsePanel = $("#serverDirListingPanelPopup");
            list.find("li").each(function(){
                var fileName = $(this).text();
                if(fileName.indexOf("/") == 0)
                {
                    fileName = fileName.substr(1, fileName.length-1);
                    $(this).text(fileName);
                }
                $(this).find("span.ui-icon").remove();
                $(this).prepend('<span style="display: inline-block; margin: 0px 3px 0px -7px;float: left;" class="pointer ui-icon"></span>');
                if($(this).attr("upLevel"))
                {
                    $(this).find("span.ui-icon").addClass("ui-icon-arrowreturnthick-1-n");
                }
                else if($(this).attr("_type").toLowerCase()== "dir")
                {
                    $(this).find("span.ui-icon").addClass("ui-icon-folder-collapsed");
                }
                else
                {
                    $(this).find("span.ui-icon").addClass("ui-icon-document");
                }
            }).addClass("wrapword");

            list.selectableAdvanced("destroy");

            list.selectableAdvanced({
                change: function(event, ui) {
                    var selected = $(ui.selection);
                    if(!base.options.allowMultiple)
                    {
                        selected.parent().find(".ui-selected, .ui-state-focus").removeClass("ui-selected ui-state-active ui-state-focus");
                        selected.filter(":last").addClass("ui-selected ui-state-active");
                    }
                    if(selected.is("li"))
                    {
                        try{
                            var events = $(this).data('events');
                            if(events && events.onSelect)
                            {
                                $(this).trigger("onSelect", [$(this), selected]);
                            }
                        }
                        catch(ex){
                            if(ex && ex.toString() != "")
                            {
                                crushFTP.UI.growl("Error", ex, true);
                            }
                        }
                    }
                    return false;
                },
                onEnter : function()
                {
                    list.find("li.ui-selected:last").trigger("dblclick");
                },
                callOnSelection : function(itemLi)
                {
                    /*var parentDiv = itemLi.closest("div")
                    parentDiv.scrollTop(parentDiv.scrollTop() + itemLi.position().top - parentDiv.height()/2 + itemLi.height()/2);*/
                    return false;
                }
            });

            list.unbind("onSelect").bind("onSelect"
                , function(evt, list, selected){
                    if($(selected).is(".uplevelLink"))
                    {
                        evt.stopPropagation();
                        evt.preventDefault();
                        base.serverDirSelected($(selected), true);
                    }
                    else
                    {
                        base.vfsItemSelected(list, selected);
                    }
                    base.makeSelection(selected);
                return false;
            });

            list.find("li").unbind().bind("dblclick", function(){
                base.serverDirSelected($(this), true);
                return false;
            });
            base.makeSelection();
        };

        base.makeSelection = function(selected)
        {
            var serverDirBrowsePanelPopup = $("#serverDirBrowsePanelPopup");
            var pickupType = base.options.type;
            var btn = serverDirBrowsePanelPopup.parent(".ui-dialog").find("button:last");
            btn.attr("disabled", "disabled").addClass("ui-state-disabled")
            if(pickupType == "dir" || pickupType == "both" || pickupType == "any")
            {
                if(!selected && $("#serverDirSelectListPopup").val() == "/")
                {
                    if(!base.options.alowRootSelection)
                        btn.attr("disabled", "disabled").addClass("ui-state-disabled");
                    else
                        btn.removeAttr("disabled").removeClass("ui-state-disabled");
                }
                else
                    btn.removeAttr("disabled").removeClass("ui-state-disabled");

                if(pickupType == "dir" && selected && selected.attr("_type") != "dir")
                {
                    btn.attr("disabled", "disabled").addClass("ui-state-disabled");
                }
            }
            else if(selected && pickupType == "file" && selected.attr("_type") != "dir")
            {
                btn.removeAttr("disabled").removeClass("ui-state-disabled");
            }
        };

        base.serverDirSelected = function(selected)
        {
            if(selected)
            {
                var goToDir = selected.attr("path");
                var hrefPath = selected.attr("hrefpath");
                if(selected.attr("upLevel"))
                {
                    var curDir = selected.attr("curLevel");
                    if(curDir.lastIndexOf("/")==curDir.length-1)
                    {
                        curDir = curDir.substr(0, curDir.lastIndexOf("/"));
                    }
                    goToDir = curDir.substr(0, curDir.lastIndexOf("/"));
                    if(goToDir.length == 0) goToDir = "/";

                    if(selected.attr("isUNC")=="true")
                    {
                        if(goToDir.indexOf("//")!=0)
                            goToDir = "/" + goToDir;
                        if(goToDir.lastIndexOf("/")!=goToDir.length-1)
                        {
                            goToDir = goToDir + "/";
                        }
                    }
                    var dirDropDown = $("#serverDirSelectListPopup");
                    base.dirSelectEventActive(false);
                    dirDropDown.find("option[value='"+escape(goToDir)+"']:first").nextAll("option").remove();
                    dirDropDown.find("option[value='"+escape(goToDir)+"']").remove();
                    base.browseVFSItem(goToDir, false, hrefPath, false, true);
                    base.dirSelectEventActive(true);
                }
                else if(selected.attr("_type") == "dir")
                {
                    base.browseVFSItem(goToDir, false, hrefPath);
                }
            }
        };

        base.vfsItemSelected = function()
        {

        }
        // Run initializer
        base.init();
    };
    $.crushFtpVFSBrowserPopup.defaultOptions = {
        type : 'dir'
    };

    $.fn.crushFtpVFSBrowserPopup = function(options){
        return this.each(function(){
            (new $.crushFtpVFSBrowserPopup(this, options));
        });
    };

})(jQuery);