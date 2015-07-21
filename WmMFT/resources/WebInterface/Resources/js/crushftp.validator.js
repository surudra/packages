// CrushFTP Validator
(function($){
    $.fn.extend({
        crushValidator: function(options) {
            return this.each(function() {
				var obj = $(this);
				obj.unbind("change.validator").bind("change.validator", function(){
					obj.validateNow(options);
				});
				obj.unbind("blur.validator").bind("blur.validator", function(){
					obj.validateNow(options);
				});
            });
        },
		validateNow: function(options){
			var defaults = {
					messageTemplate: '<span class="validationErrorMessage ui-corner-all ui-state-error">{text}</span>',
					trimValue: true
			};
			options = $.extend(defaults, options);
			var obj = $(this);
			if(!obj.hasClass("notForUserManager"))
			{
				var enabledOpt = obj.closest("fieldset").find("td.checkboxArea").find("input[type='checkbox']").is(":checked");
				if(!enabledOpt || !obj.is(":visible") || obj.hasClass("disableValidation"))
				{
					obj.closest("td").find(".validationErrorMessage").remove();
					obj.removeClass("ui-state-error nobg");
					return false;
				}
			}
			if(options.trimValue)
			{
				obj.val($.trim(obj.val()));
			}
			obj.closest("td").find(".validationErrorMessage").remove();
			obj.removeClass("ui-state-error nobg");
			var valtypes = obj.attr("valtype") || "";
			valtypes = valtypes.split(",");
			var messages = [];
			var curVal = $.trim(obj.val());
			for(var i=0;i<valtypes.length;i++)
			{
				valtype = $.trim(valtypes[i]);
				if(valtype == "required")
				{
					if($.trim(obj.val()).length==0)
					{
						messages.push("This field is required");
					}
				}
				if(valtype == "float")
				{
					curVal = curVal || false;
					if(((curVal - 0) != curVal || curVal.length == 0))
					{
						messages.push("Only numeric value allowed");
					}
				}
				if(valtype == "zeroPlus")
				{
					curVal = curVal || false;
					if((curVal - 0) == curVal)
					{
						var val = parseInt(curVal);
						if(val<=0)
							messages.push("Enter positive number");
					}
				}
				if(valtype == "numeric")
				{
					curVal = curVal || 0;
					var reg = new RegExp("^(0|[0-9][0-9]*)$");
					if(!reg.test(curVal))
					{
						messages.push("Only numeric value allowed");
					}
				}
				if(valtype == "onlyNumber")
				{
					curVal = curVal || 0;
					if((curVal - 0) != curVal || curVal.toString().indexOf(".")>0)
					{
						messages.push("Only numeric value allowed");
					}
				}
				if(valtype == "userName")
				{
					if(crushFTP.methods.hasSpecialCharacters(obj.val(), userManager.notAllowedCharsInUserName))
					{
						messages.push("You can not use these characters in name : \"" + userManager.notAllowedCharsInUserName + "\"");
					}
				}
				if(valtype == "userPass")
				{
					var msgs = userManager.methods.validateUserPassword(obj.val());
					if(msgs && msgs.length>0)
					{
						messages.push(msgs[0]);
					}
				}
				if(valtype == "dirName")
				{
					if(crushFTP.methods.hasSpecialCharacters(obj.val(), userManager.notAllowedCharsInDirName))
					{
						messages.push("You can not use these characters in name : \"" + userManager.notAllowedCharsInUserName + "\"");
					}
				}
				if(valtype == "email")
				{
					if(obj.val().length>0 && !crushFTP.methods.isValidEmail(obj.val()))
					{
						messages.push("Enter valid email address");
					}
				}
				if(valtype == "date")
				{
					if(!crushFTP.methods.isDate(obj.val()))
					{
						messages.push("Enter valid date");
					}
				}
				if(valtype == "dateTime")
				{
					var isValidDT = crushFTP.methods.isDateTime(obj.val());
					if(isValidDT.length>0)
					{
						messages.push(isValidDT);
					}
				}
				if(valtype == "dateTimeExpire")
				{
					if(!crushFTP.methods.isDate(obj.val()) && !crushFTP.methods.isDateTS(obj.val()))
					{
						var isValidDT = crushFTP.methods.isDateTime(obj.val());
						if(isValidDT.length>0)
						{
							messages.push('Enter valid date. Allowed formats : "MM/dd/yyyy hh:mm aa", "MM/dd/yy hh:mm aa", "MM/dd/yyyy", "MMddyyyyHHmm"');
						}
					}
				}
				if(valtype == "hoursOfTheDay")
				{
					var val = obj.val();
					val = val.split(",");
					var invalidHours = false;
					for(var i=0;i<val.length;i++)
					{
						if(!val[i] || !crushFTP.methods.isNumeric(val[i]) || parseInt(val[i])<0 || parseInt(val[i])>24)
						{
							invalidHours = true;
						}
					}
					if(invalidHours)
					{
						messages.push("Enter valid hours of the day. Value must be a comma separated list of integer numbers ranging from 0 to 23");
					}
				}
				if(valtype == "IPAddress")
				{
					if(!crushFTP.methods.isValidIP(obj.val()))
					{
						messages.push("Enter valid IP address");
					}
				}
				if(valtype == "dirPath")
				{
					if(curVal && curVal.length>0)
					{
						if(curVal.indexOf("/") != 0 || curVal.lastIndexOf("/") != curVal.length - 1)
						{
							messages.push("Directory path is not valid. (Valid path example : \"/root/media/\" or \"/downloads/\")");
						}
					}
				}
				if(valtype == "dirPathAllowStar")
				{
					if(curVal && curVal.length>0)
					{
						if(curVal.indexOf("/") != 0 || curVal.lastIndexOf("/") != curVal.length - 1)
						{
							if(curVal.lastIndexOf("*") != curVal.length - 1)
								messages.push("Directory path is not valid. (Valid path example : \"/root/media/\", \"/downloads/\" or \"/documents/*\")");
						}
					}
				}
			}
			if(messages.length>0)
			{
				obj.addClass("ui-state-error nobg");
				if(!obj.hasClass("noMSG"))
				{
					if(messages.length>1)
						obj.parent().parent().append(options.messageTemplate.replace("{text}", " - " + messages.join("<br/> - ")));
					else
						obj.parent().parent().append(options.messageTemplate.replace("{text}", " - " + messages.join("")));
				}
			}
			return messages.length>0;
		}
	});
})(jQuery);