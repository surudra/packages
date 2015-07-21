/*!
* CrushFTP Pickup User Popup
*
* Copyright @ SoftwareAG
*
*/

(function($){
    $.crushFtpEncryptPassword = function(el){
        // To avoid scope issues, use 'base' instead of 'this'
        // to reference this class from internal events and functions.
        var base = this;

        // Access to jQuery and DOM versions of element
        base.$el = $(el);
        base.el = el;

        // Add a reverse reference to the DOM object
        base.$el.data("crushFtpEncryptPassword", base);

		base.encryptPassword = function(pass, callback)
		{
			if(!callback)return;
			var obj = {
				command: "encryptPassword",
				password : encodeURIComponent(pass)
			};
			$.ajax({
				type: "POST",
				url: "/WebInterface/function/",
				data: obj,
				success: function (data){
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
		};

        base.init = function(){
			$(base.$el).unbind("focus.crushFTP").bind("focus.crushFTP", function(){
				var elem = $(this);
				if(elem.hasClass("encryptDisabled"))return;
				$(this).select();
			}).mouseup(function (e) {e.preventDefault(); });

			$(base.$el).unbind("textchange.crushFTP").bind("textchange.crushFTP", function(){
				var elem = $(this);
				if(elem.hasClass("encryptDisabled"))return;
				elem.trigger("change").addClass("hasPendingCall");
			});

			$(base.$el).unbind("blur.crushFTP").bind("blur.crushFTP", function(){
				var elem = $(this);
				if(elem.hasClass("encryptDisabled") || !elem.hasClass("hasPendingCall"))return;
				if(elem.val().length>0)
				{
					var blockElem = elem.parent();
					if(elem.is("textarea"))
					{
						blockElem = elem.parent().parent();
					}
					blockElem.block({
						message:  'Wait..',
						css: {
							border: 'none',
							padding: '0px 10px',
							backgroundColor: '#000',
							opacity: .5,
							color: '#fff',
							'text-align':'left'
						}
					});
					elem.addClass("hasPendingCall").attr("disabled", "disabled");
					//setTimeout(function(){
					base.encryptPassword(elem.val(), function(data){
						elem.removeClass("hasPendingCall").removeAttr("disabled");
						blockElem.unblock();
						if(data)
						{
							elem.addClass("encryptDisabled");
							elem.val(unescape(data.response[0].text)).trigger("change").data("lastValue", unescape(data.response[0].text)).trigger("textchange");
							elem.removeClass("encryptDisabled");
							if(window.pendingEncryptionCall)
							{
								setTimeout(function(){
									if(window.pendingEncryptionCall)
									{
										window.pendingEncryptionCall();
										delete window.pendingEncryptionCall;
									}
								}, 100);
							}
							elem.after("<span class='encrptionMsg ui-widget-content ui-corner-all ui-state-highlight'>Password encrypted!</span>");
							elem.parent().find("span.encrptionMsg").effect("highlight", { color: "green" }, 3000, function(){
								$(this).remove();
							});
						}
						else
						{
							elem.val("").trigger("change");
							if(userManager)
							{
								userManager.UI.growl("Error while encrypting password", "Password encryption failed", true);
							}
							else
							{
								growl("Error while encrypting password", "Password encryption failed", true);
							}
						}
					});//}, 5000);
				}
				else
				{
					elem.removeClass("hasPendingCall");
					if(window.pendingEncryptionCall)
					{
						window.pendingEncryptionCall();
						delete window.pendingEncryptionCall;
					}
				}
			});
        };

        // Run initializer
        base.init();
    };

    $.fn.crushFtpEncryptPassword = function(){
        return this.each(function(){
            (new $.crushFtpEncryptPassword(this));
        });
    };

    // This function breaks the chain, but returns
    // the crushFtpEncryptPassword if it has been attached to the object.
    $.fn.getcrushFtpEncryptPassword = function(){
        this.data("crushFtpEncryptPassword");
    };
})(jQuery);