/*!
* CrushFTP Session checker
*
* Copyright @ SoftwareAG
*
*/
(function($){
    $.sessionChecker = function(el, options){
        // To avoid scope issues, use 'base' instead of 'this'
        // to reference this class from internal events and functions.
        var base = this;

        // Access to jQuery and DOM versions of element
        base.$el = $(el);
        base.el = el;

        // Add a reverse reference to the DOM object
        base.$el.data("sessionChecker", base);

        base.init = function(){
			base.options = $.extend({},$.sessionChecker.defaultOptions, options);
			base.bindUserInfo(function(response) {
				if(response)
				{
					if(response.getElementsByTagName("crushftp_version") && response.getElementsByTagName("crushftp_version").length>0)
					{
						$(document).data("crushftp_version", base.getTextContent(response.getElementsByTagName("crushftp_version")[0]).textContent);
					}
					if(response.getElementsByTagName("crushftp_enterprise") && response.getElementsByTagName("crushftp_enterprise").length>0)
					{
						$(document).data("crushftp_enterprise", base.getTextContent(response.getElementsByTagName("crushftp_enterprise")[0]).textContent.toString() != "0");
					}
					if(!options.refreshServerInfo)
					{
						// Put your initialization code here
						$(document).data(base.options.dataStorageKey, base.options.startingPointVal);
						base.updateSessionSeconds();
						base.updateTimer();
					}
				}
				base.options.callBack(response);
			});
        };

		base.getTextContent = function(obj) {
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

		base.getActionResponseText = function(msg) {
			var responseText = '';
			try {
				var msgs = msg.getElementsByTagName("commandResult");
				for (var x = 0; x < msgs.length; x++) {
					responseText += base.getTextContent(msgs[x].getElementsByTagName("response")[0]).textContent;
				}
			} catch (ex) {}
			return responseText;
		}

		base.formatTime = function(secs) {
			var remaining = "";
			secs = secs.substring(0, secs.indexOf(".")) * 1;
			var mins = (secs / 60) + ".0";
			mins = mins.substring(0, mins.indexOf(".")) * 1;
			if (mins > 0) {
				secs -= (mins * 60);
				remaining = mins + " min, " + secs + " secs";
			} else {
				if (secs < 0) {
					remaining = "0 secs";
				} else {
					remaining = secs + " secs";
				}
			}
			return remaining;
		}

        // Update timer for local text on document
         base.updateTimer = function(external){
			if(!external)
			{
				setTimeout(function(){
					base.updateTimer();
				}, base.options.localTimerPeriod);
			}
			if ($(document).data(base.options.dataStorageKey) * 1 > 0)
			{
				var s = $(document).data(base.options.dataStorageKey)+".0";
				base.$el.html(base.options.noteTextTemplate.replace("%time%", base.formatTime(s)));
				$(document).data(base.options.dataStorageKey, $(document).data(base.options.dataStorageKey)*1-1);
			}
			var sessionSeconds = $(document).data("sessionSeconds") || 0;
			if(sessionSeconds <= 60 && sessionSeconds > 0)
			{
				if(!base.ajaxCallRunning)
				{
					base.alertLogoutConfirmation(function(){
						var targetUrl = window.location.toString().replace(document.location.hash.toString(), "");
						base.ajaxCallRunning = true;
						base.bindUserInfo(function(response) {
							if (!response) {
								window.location = targetUrl;
								base.ajaxCallRunning = false;
							}
							else
							{
								base.updateSessionSeconds(true);
							}
						});
					});
				}
			}
			else if(sessionSeconds <= 0 && base.initComplete)
			{
				if(window.placeHolder && window.placeHolder.removeData)window.placeHolder.removeData("hasChanged");
				if(window.userManager && window.userManager.methods && window.userManager.methods.itemsChanged)
				{
					userManager.methods.itemsChanged(false);
				}
				if(window.doLogout)
					window.doLogout();
			}
         };

		 // Update timer for value from the server
		 base.updateSessionSeconds = function(external){
			if(!external)
			{
				setTimeout(function(){
					base.updateSessionSeconds();
				}, base.options.sessionTimerPeriod);
			}
			$.ajax({
				type: base.options.requestType,
				url: base.options.ajaxURL,
				data: {
					command: base.options.serverCommand
				},
				success: function (response) {
					base.ajaxCallRunning = false;
					var s = $.trim(base.getActionResponseText(response));
					$(document).data(base.options.dataStorageKey, s);
					base.initComplete = true;
				}
			});
		 };

		base.alertLogoutConfirmation = function(callBack)
		{
			if(!callBack)return;
			if(typeof jAlert == "undefined") //WebInterface
			{
				if($('#alertLogoutConfirmation').is(":visible"))return;
				if ($("#alertLogoutConfirmation").length == 0) {
					var alertLogoutHTML = "<div class='logoutConfirmDialog'><h2>" + getLocalizationKeyExternal("AutoLogOutConfirmationTitle") + "</h2><div class='attention'>" + getLocalizationKeyExternal("AutoLogOutConfirmationDesc") + "</div><div style='width:90px;float:right;border:1px solid #eee;padding:3px 20px;background-position:5px;margin:20px 0px 0px 0px;' class='saveButton'>" + getLocalizationKeyExternal("AutoLogOutButtonText") + "</div><div style='clear:both;'></div></div>";
					$("body").append("<div id='alertLogoutConfirmation'>" + alertLogoutHTML + "</div>");
					$("#alertLogoutConfirmation").hide();
				}
				var $alertBox = $('#alertLogoutConfirmation');
				$.blockUI({
					message: $alertBox,
					css: {
						padding: '10px 10px 20px 30px',
						'background-color': getPopupColorExternal(true),
						'border': "1px solid " + getPopupColorExternal(),
						'-webkit-border-radius': '10px',
						'-moz-border-radius': '10px',
						color: '#000',
						opacity: 0.9,
						top: '30%',
						left: '40%',
						width: '305px'
					}
				});
				$alertBox.find(".saveButton").unbind().click(
					function () {
						$.unblockUI();
						$("#alertLogoutConfirmation").remove();
						callBack();
				});
			}
			else
			{
				if(!window.stayOnlineMsgShown)
				{
					jAlert("You are about to be signed out due to inactivity", "Auto Logout", function(){
						delete window.stayOnlineMsgShown;
						callBack();
					}, {
						okButtonText : "Stay logged in"
					});
					window.stayOnlineMsgShown = true;
				}
			}
		};

		//Bind user info
		base.bindUserInfo = function(callBack, path) {
		/* Data to POST to receive file listing */
			path = path || "/";
			var obj = {
				command: "getUserInfo",
				path : path,
				random: Math.random()
			};
			$.ajax({
				type: "POST",
				url: base.options.ajaxURL,
				data: obj,
				error: function (XMLHttpRequest, textStatus, errorThrown) {
					callBack(false);
				},
				success: function (msg) {
					var responseText = msg;
					try {
						if (callBack) {
							callBack(msg);
						}
					} catch (ex) {
						if (callBack) {
							callBack(false);
							return false;
						}
					}
				}
			});
		};

        // Run initializer
		base.init();
    };

    $.sessionChecker.defaultOptions = {
		dataStorageKey : "sessionSeconds",
		startingPointVal : "-1",
		localTimerPeriod : 1000,
		sessionTimerPeriod : 50000,
		noteTextTemplate : "(Session timeout in %time%.)",
		ajaxURL : "/WebInterface/function/",
		serverCommand : "getSessionTimeout",
		requestType : "GET",
		callBack : function(){}
    };

    $.fn.sessionChecker = function(options){
        return this.each(function(){
            (new $.sessionChecker(this, options));
        });
    };
})(jQuery);