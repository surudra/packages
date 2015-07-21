/*!
* CrushFTP DND integration in WebInterface
*
* Copyright @ SoftwareAG
*
*/
$(function () {
    'use strict';
	 if (!$.CrushFTP) {
        $.CrushFTP = new Object();
    };

	var is_MacOs = navigator.userAgent.indexOf('Mac') > -1;
	$.CrushFTP.iOS = navigator.userAgent.match(/(iPad|iPhone|iPod)/g) ? true : false;
	$.CrushFTP.maxFileSizeAllowedInNormalUploadInMB = 500;
	$.CrushFTP.browserSupportsDND = function()
	{
		var flag = false;
		var is_chrome = navigator.userAgent.indexOf('Chrome') > -1;
		var is_explorer = navigator.userAgent.indexOf('MSIE') > -1;
		var is_firefox = navigator.userAgent.indexOf('Firefox') > -1;
		var is_safari = navigator.userAgent.indexOf("Safari") > -1;
		var is_Opera = navigator.userAgent.indexOf("Presto") > -1;

		if ((is_chrome)&&(is_safari)) {is_safari=false;}

		if(is_chrome)
		{
			flag = true;
		}
		else if(is_safari && is_MacOs)
		{
			flag = true;
		}
		else if(is_firefox)
		{
			var ua = navigator.userAgent;
			var version = /Firefox\/([0-9\.A-z]+)/.exec(ua)[1];
			if(version && parseInt(version))
			{
				if(parseInt(version)>3.5)
					flag = true;
			}
		}
		else if(is_explorer)
		{
			flag = parseInt(jQuery.browser.version) >= 10;
		}
		/*else if(is_Opera)
		{
			var version = $.browser.version;
			if(version && parseInt(version))
			{
				if(parseInt(version)>=11)
					flag = true;
			}
		}*/
		return flag;
	}

	$.CrushFTP.formatBytes = function(bytes) {
		if(!bytes || bytes<0) return "*";
		else if ((bytes / 1024).toFixed(0) == 0) return bytes.toFixed(1) + " " + localizations.dataFormatBytes;
		else if ((bytes / 1024 / 1024).toFixed(0) == 0) return (bytes / 1024).toFixed(1) + " " + localizations.dataFormatKiloBytes;
		else if ((bytes / 1024 / 1024 / 1024).toFixed(0) == 0) return (bytes / 1024 / 1024).toFixed(1) + " " + localizations.dataFormatMegaBytes;
		else if ((bytes / 1024 / 1024 / 1024 / 1024).toFixed(0) == 0) return (bytes / 1024 / 1024 / 1024).toFixed(1) + " " + localizations.dataFormatGigaBytes;
		else if ((bytes / 1024 / 1024 / 1024 / 1024 / 1024).toFixed(0) == 0) return (bytes / 1024 / 1024 / 1024 / 1024).toFixed(1) + " " + localizations.dataFormatTeraBytes;
	}

	var IsNumeric = function(input) {
		return !((input - 0) == input && input.length > 0);
	}

	$.CrushFTP.secondsToTime = function(secs)
	{
	    var hours = Math.floor(secs / (60 * 60));
	    var divisor_for_minutes = secs % (60 * 60);
	    var minutes = Math.floor(divisor_for_minutes / 60);
	    var divisor_for_seconds = divisor_for_minutes % 60;
	    var seconds = Math.ceil(divisor_for_seconds);
	    var obj = {
	        "h": hours,
	        "m": minutes,
	        "s": seconds
	    };
	    return obj;
	}

	function padNumber(number) {
	  if (number<=99) { number = ("0"+number).slice(-2); }
	  return number;
	}

	$.CrushFTP.formatTime = function(secs) {
		var remaining = "";
		if(!secs)return "";
		secs = secs.substring(0, secs.indexOf(".")) * 1;
		if (secs <= 0) {
			remaining = getLocalizationKeyExternal("BrowserUploaderSpeedTimeCalculatingText");
		} else {
			var secsToTime = $.CrushFTP.secondsToTime(secs);
			if(secsToTime.h !=0)
			{
				remaining = padNumber(secsToTime.h) + ":" + padNumber(secsToTime.m) + ":" + padNumber(secsToTime.s) + " hours"
			}
			else if(secsToTime.m !=0)
			{
				remaining = padNumber(secsToTime.m) + ":" + padNumber(secsToTime.s) + " mins"
			}
			else if(secsToTime.s !=0)
			{
				remaining = padNumber(secsToTime.s) + " secs"
			}
		}
		return remaining;
	}

	$.CrushFTP.formatFileSize = function (bytes) {
		return $.CrushFTP.formatBytes(bytes);
	}

	var fileRepo = $("#fileRepo");
	var fileQueueInfo = $("#fileQueueInfo");
	var browseFileButtonPanel = $("#browseFileButtonPanel");
	var AdvancedBrowseResumeOption = $('#AdvancedBrowseResumeOption');
	var javaAppletDiv = $("#javaAppletDiv");
	var overwriteAllLinkBtn = fileRepo.find("#overwriteAllLinkBtn");
	var clearUploadedAll = fileRepo.find("a.uploadedAll");
	var shareAllUploaded = fileRepo.find("a.shareAllUploaded").hide();
	var remvoeErrorAllLinkBtn = fileRepo.find("#remvoeErrorAllLinkBtn");
	var totalFilesText = fileRepo.find("span.totalFiles");
	var totalSizeText = fileRepo.find("span.totalSize");
	var viewFileQueue = fileQueueInfo.find("#viewFileQueue");
	var globalProgressBar = $("#globalProgressBar");
	var fileUploadBar = $("#fileUploadBar");
	var fileUploadBarHolder = $("#fileUploadBarHolder");

	if(!$.CrushFTP.browserSupportsDND())
	{
		totalSizeText.prev().remove();
		totalSizeText.remove();
	}

	$.CrushFTP.buildQueueInfo = function(){
		var itemsSelected = fileRepo.find("li");
		if(itemsSelected && itemsSelected.length>0)
		{
			var totalSize = 0;
			itemsSelected.each(function(){
				if($(this).find(".noCount").length==0)
					totalSize += parseFloat($(this).attr("size"));
			});
			totalFilesText.text(itemsSelected.length);
			totalSizeText.text($.CrushFTP.formatBytes(totalSize));
			fileRepo.show().trigger("visibilityChange").data("totalSize", totalSize);
			viewFileQueue.show();
		}
		else
		{
			totalFilesText.text("");
			totalSizeText.text("");
			if(!$.CrushFTP.uploadBarHidden)
			{
				fileRepo.hide();
				if(window.fileWindowAsDialog)
				{
					$.unblockUI();
				}
				fileRepo.trigger("visibilityChange");
				viewFileQueue.hide();
			}
		}
		$.CrushFTP.bindUploadItemEvents();
		if(fileRepo.find("ul").find("a.overwriteLink:visible").length>0)
			overwriteAllLinkBtn.show();
		else
			overwriteAllLinkBtn.hide();

		if(fileRepo.find("li.uploaded").length>0)
			clearUploadedAll.show();
		else
			clearUploadedAll.hide();

		if(fileRepo.find("ul").find("li.hasError").length>0)
			remvoeErrorAllLinkBtn.show();
		else
			remvoeErrorAllLinkBtn.hide();

		if($.CrushFTP.UploadProgressing && $.CrushFTP.uploadAllQueued)
			$.CrushFTP.getNextQueuedItem();

		if(fileRepo.find("a.shareUploadedItem:visible").length>0)
			shareAllUploaded.show();
		else
			shareAllUploaded.hide();
	};

	var getFileExtension = function(filename) {
		var ext = /^.+\.([^.]+)$/.exec(filename);
		return ext == null ? "" : ext[1].toLowerCase();
	}

	$.CrushFTP.showIconsForFiles = function()
	{
		fileRepo.find("li:not(.appletItem)").each(function(){
			var item = $(this);
			if(item.hasClass("iconSet"))return;
			item.addClass("iconSet");
			var ext = getFileExtension(item.find("div.name").text());
			/*if(ext == "jpg" || ext == "jpeg" || ext == "gif" || ext == "png" || ext == "bmp")
				return;*/
			var imgSrc = "";
			if ($.CrushFTP.Options.availableFileExtensionImages.has(ext)) {
				imgSrc = $.CrushFTP.Options.FileExtensionImageFilePath + ext + "_32.png";
			} else {
				imgSrc = $.CrushFTP.Options.fileLarge + "_32.png";
			}
			if(imgSrc.length>0)
				item.find("div.previewIconUpload").find("span.fade").empty().append("<img style='margin-top:5px;' src='"+imgSrc+"'/>");
		});
	};

	$.CrushFTP.bindUploadEvents = function() {
		overwriteAllLinkBtn.unbind().bind("click", function(){
			fileRepo.find("ul").find("a.overwriteLink").trigger("click");
			$(this).hide();
			return false;
		});

		remvoeErrorAllLinkBtn.unbind().bind("click", function(){
			fileRepo.find("li.hasError").find("a.cancelUpload").trigger("click");
			$(this).hide();
			return false;
		});

		viewFileQueue.unbind().click(function(){
			var cluetipTitle = $("#cluetip-title");
			if($(this).hasClass("close"))
			{
				if(window.fileWindowAsDialog)
				{
					$.unblockUI();
				}
				setTimeout(function(){
					fileRepo.slideUp("fast", function(){
						fileRepo.trigger("visibilityChange");
					});
					$(this).removeClass("close");
				}, 100);
			}
			else
			{
				if(window.fileWindowAsDialog)
				{
					fileRepo.show().trigger("visibilityChange");
				}
				else
				{
					fileRepo.slideDown("fast", function(){
						fileRepo.trigger("visibilityChange");
					});
				}
				$(this).addClass("close");
			}
			$(this).blur();
			return false;
		}).hide();

		fileRepo.find("#toggleFileList").click(function(){
			viewFileQueue.trigger("click");
		});

		fileRepo.find("a.cancelUploading").unbind().click(function(){
			if($(this).hasClass("uploadedAll"))
			{
				fileRepo.find("li.uploaded").find("a.cancelUpload").trigger("click");
			}
			else
				$(fileRepo.find("li").get().reverse()).each(function(){
					$(this).find("a.cancelUpload").trigger("click");
				});
			return false;
		});

		fileRepo.find("a.startUploading").unbind().click(function(){
			var startBtn = $.CrushFTP.getNextQueuedItem();
			if(startBtn)
				startBtn.trigger("click", [{allInQueue:true}]);
			return false;
		});

		shareAllUploaded.unbind().click(function(){
			var itemsUploaded = fileRepo.find("a.shareUploadedItem");
			if(itemsUploaded.length==0)
			{
				$(this).hide();
				return false;
			}
			var paths = [];
			var files = [];
			itemsUploaded.each(function(){
				var elem = $(this).closest("li");
				var privs = elem.attr("privs");
				if(!privs || typeof window.shareFile == "undefined")return;
				privs = unescape(privs);
				if(privs.toLowerCase().indexOf("(share)")>=0)
				{
					var fileName = unescape(elem.attr("fileName"));
					paths.push(unescape(unescape(elem.attr("path"))) + fileName);
					files.push(fileName);
				}
			});
			var shareMethodUploadedItem = $(document).data("shareMethodUploadedItem");
			if(paths.length>0 && files.length>0)
			{
				if(shareMethodUploadedItem && shareMethodUploadedItem.toLowerCase() == "quick")
				{
					window.quickShareFile(false, paths.join("\r\n"), false, files.join("\r\n"));
				}
				else
					window.shareFile(false, paths.join("\r\n"), files.join("\r\n"));
			}
			else
				$(this).hide();
			return false;
		});
	}

	$.CrushFTP.getNextQueuedItem = function(notBatchUpload) {
		var startBtn = false;
		var hasBtns = false;
		if(!notBatchUpload)
		{
			fileRepo.find("li:not(.uploaded, .error, .skipped, .ui-state-highlight, .hasError, .warning)").each(function(){
				var startUploadBtn = $(this).find("a.startUpload");
				if(startUploadBtn)
				{
					if(!startBtn)
						startBtn = startUploadBtn;
					else
					{
						startUploadBtn.text(window.locale.fileupload.waiting);
						hasBtns = true;
					}
				}
			});
			if($.CrushFTP.uploadAllQueued && !startBtn && !hasBtns)
			{
				$.growlUI(locale.fileupload.uploadCompletedText, locale.fileupload.uploadedMultipleFilesText, $.CrushFTP.Options.GrowlTimeout);
				if(window.hideUploadBarAfterUpload)
				{
					viewFileQueue.addClass("close").trigger("click");
				}
				fileRepo.find(".curQueue").removeClass("curQueue");
				$.CrushFTP.removeGlobalProgressInfo();
				var autoShareUploadedItem = $(document).data("autoShareUploadedItem");
				if(autoShareUploadedItem && autoShareUploadedItem.toLowerCase()=="true")
				{
					shareAllUploaded.trigger("click");
				}
				if(window.autoRemoveUploadedItemFromList)
				{
					fileRepo.find("a.clearCompleted:first").trigger('click');
				}
			}
		}
		else
		{
			var fileItem = fileRepo.find("li.queued:not(.uploaded, .error, .skipped, .ui-state-highlight, .hasError, .warning):first");
			if(fileItem.length>0)
			{
				fileItem.removeClass("queued");
				startBtn = fileItem.find("a.startUpload");
			}
		}
		return startBtn;
	}

	$.CrushFTP.bindUploadItemEvents = function()
	{
		//Native upload items
		var allItems = fileRepo.find("li");
		allItems.find("a.cancelUpload").unbind().click(function(){
			var elem = $(this).closest("li");
			if(elem.hasClass("uploadProgress"))
			{
				var _confirm = getLocalizationKeyExternal("uploadConfirmCancelUploadText") || "Are you sure you wish to cancel this upload?";
				if(confirm(_confirm))
				{
					if(elem.hasClass("appletItem"))
					{
						var resume = elem.find("a.pause").hasClass("resume");
						var globalPBPauseBtn = globalProgressBar.find("a.pause");
						if(resume)
						{
							elem.find("a.pause").removeClass("resume").text("Pause");
							elem.find(".status").html("Cancelling..");
							elem.removeClass("paused");
							globalPBPauseBtn.removeClass("resume").text("Pause");
							globalProgressBar.find(".speed,.time").show();
							globalProgressBar.find(".statusPB").remove();
						}
						runAppletCommand(true, "COMMAND=ACTION:::TYPE=UPLOAD:::ACTION=CANCEL");
						elem.attr("status", "skipped");
					}
					else
						$.CrushFTP.abortUploadRequest(elem);

					$.CrushFTP.DNDUploadCallback("skipped", false, elem.find("a.startUpload"), elem);
				}
			}
			else
			{
				elem.remove();
				$.CrushFTP.buildQueueInfo();
			}
			return false;
		});

		allItems.find("a.startUpload").unbind().click(function(e, data){
			if(data && data.allInQueue)
				$.CrushFTP.uploadAllQueued = true;
			var listElem = $(this).closest("li.formProcessed");
			if($.CrushFTP.UploadProgressing)
			{
				$(this).text(window.locale.fileupload.waiting);
				if(!dragEventsNotSupported)
				{
					if(listElem.hasClass("uploaded") || listElem.hasClass("skipped"))
					{
						var curSize = parseFloat(listElem.attr("size"));
						if(IsNumeric(curSize))
						{
							var guploadInfo = globalProgressBar.data("uploadInfo");
							if(guploadInfo)
							{
								guploadInfo.totalUploaded -= curSize;
								guploadInfo.curfile -= 1;
							}
							globalProgressBar.data("uploadInfo", guploadInfo);
						}
					}
				}
				if(!$.CrushFTP.uploadAllQueued)
				{
					listElem.addClass("queued curQueue").removeClass("uploaded error hasError skipped");
				}
				else
				{
					listElem.removeClass("uploaded error hasError skipped");
				}
				return false;
			}
			else
				$.CrushFTP.uploadAllQueued = data && data.allInQueue;
			if(listElem && listElem.length>0)
			{
				if(listElem.hasClass("skipped"))
					listElem.removeClass("skipped");

				listElem.addClass("curQueue").removeClass("hasError");
				if(listElem.hasClass("appletItem"))
				{
					listElem.find("a.start").trigger("click");
				}
				else
				{
					$.ajax({
						type: "POST",
						url: $.CrushFTP.Options.ajaxCallURL,
						data: "command=unblockUploads&random=" + Math.random(),
						success: function (response) {
							listElem.find("a.start").trigger("click");
							listElem.find(".uploadNote").remove();
							listElem.find(".progressbar").progressbar({"value" : 0});
							var guploadInfo = globalProgressBar.data("uploadInfo");
							if(!dragEventsNotSupported && guploadInfo)
							{
								globalProgressBar.show();
							}
							else
								globalProgressBar.find(".progressbarMain").progressbar({"value" : 0});
						}
					});
				}
			}
			return false;
		});

		//Applet items
		var appletItems = fileRepo.find(".appletItem");
		appletItems.find("a.start").unbind().click(function(){
			if(!$.CrushFTP.UploadProgressing)
			{
				var listElem = $(this).closest("li");
				$.ajax({
					type: "POST",
					url: $.CrushFTP.Options.ajaxCallURL,
					data: "command=unblockUploads&random=" + Math.random(),
					success: function (response) {
						$.CrushFTP.startAppletItemUpload(listElem);
						listElem.find(".progressbar").progressbar({"value" : 0});
						globalProgressBar.find(".progressbarMain").progressbar({"value" : 0});
					}
				});
			}
			return false;
		});

		appletItems.find("a.pause").unbind().click(function(){
			var resume = $(this).hasClass("resume");
			var parentElem = $(this).closest("li");
			var globalPBPauseBtn = globalProgressBar.find("a.pause");
			if(resume)
			{
				$(this).removeClass("resume").text("Pause");
				parentElem.find(".status").html("Resuming..");
				parentElem.removeClass("paused");
				globalPBPauseBtn.removeClass("resume").text("Pause");
				globalProgressBar.find(".speed,.time").show();
				globalProgressBar.find(".statusPB").remove();
			}
			else
			{
				if(!parentElem.hasClass("uploadProgress"))return false;
				$(this).addClass("resume").text("Resume");
				parentElem.addClass("paused");
				globalPBPauseBtn.removeClass("resume").text("Resume");
				globalProgressBar.find(".speed,.time").hide();
				globalProgressBar.find(".progressInfoText").append('<span class="statusPB" style="float:left;font-weight:bolder;margin-top:3px;">Paused</span>');
			}
			$.CrushFTP.pauseResumeAppletItemUpload(parentElem, !resume);
			return false;
		});

		appletItems.each(function(){
			var item = $(this);
			var fileInfo = item.data("fileInfo");
			if(!fileInfo)return;
			var ext = getFileExtension(fileInfo.name);
			var imgSrc = "";
			if ($.CrushFTP.Options.availableFileExtensionImages.has(ext)) {
				imgSrc = $.CrushFTP.Options.FileExtensionImageFilePath + ext + "_32.png";
			} else {
				imgSrc = $.CrushFTP.Options.fileLarge + "_32.png";
			}
			if(imgSrc.length>0)
				item.find("div.previewIconUpload").find("span.fade").empty().append("<img style='margin-top:5px;' src='"+imgSrc+"'/>");
		});
	}

	$.CrushFTP.startAppletItemUpload = function(item)
	{
		if(!item || item.hasClass("uploadProgress"))return;
		var fileInfo = item.data("fileInfo");
		if(!fileInfo)return;
		item.find("a.pause").removeClass("resume").text("Pause");
		item.find(".status").html("Starting Upload..");
		item.removeClass("paused");
		var globalPBPauseBtn = globalProgressBar.find("a.pause");
		globalPBPauseBtn.removeClass("resume").text("Pause");
		globalProgressBar.find(".speed,.time").show();
		globalProgressBar.find(".statusPB").remove();
		var url = location.protocol + "//" + location.host + "" + $.CrushFTP.Options.proxy + "/";
		var formData = item.data("formData") || "";
		if(formData)
		{
			formData = formData.replace(/&/g, ':::').replace(/&/g, ':::');
		}
		var resumeUpload = ":::RESUME=" + AdvancedBrowseResumeOption.find("input").is(":checked");
		var compressionUpload = ":::NOCOMPRESSION=" + ($.cookie("__WEBINTERFACE_NOCOMPRESSION") == "true");
		if(typeof window.compressionInApplet != "undefined")
            compressionUpload = ":::NOCOMPRESSION=" + (window.compressionInApplet != "true");
		var cmd = "COMMAND=UPLOAD:::URL="+url+":::UPLOADPATH=" + fileInfo.path + ":::P1=" + fileInfo.sourcePath + ":::" + formData + resumeUpload + compressionUpload;
		if(item.find("span.groupCount").length>0)
			cmd = "COMMAND=UPLOAD:::URL="+url+":::UPLOADPATH=" + fileInfo.path + fileInfo.sourcePath + ":::" + formData + resumeUpload + compressionUpload;
		if(window.UPLOAD_THREADS)
			cmd += ":::UPLOAD_THREADS=" + window.UPLOAD_THREADS;
		runAppletCommand(true, "COMMAND=AUTH:::CRUSHAUTH=" + $.cookie("CrushAuth"));
		runAppletCommand(true, cmd);
		$.CrushFTP.DNDUploadCallback("uploading", false, item.find("a.startUpload"), item);
	}

	$.CrushFTP.pauseResumeAppletItemUpload = function(item, pause)
	{
		if(!item)return;
		var fileInfo = item.data("fileInfo");
		if(!fileInfo)return;

		var cmd = "COMMAND=ACTION:::TYPE=UPLOAD:::ACTION=RESUME";
		if(pause)
			cmd = "COMMAND=ACTION:::TYPE=UPLOAD:::ACTION=PAUSE";

		runAppletCommand(true, "COMMAND=AUTH:::CRUSHAUTH=" + $.cookie("CrushAuth"));
		runAppletCommand(true, cmd);
		if(pause)
		{
			item.attr("status", "paused");
			$.CrushFTP.DNDUploadCallback("paused", false, item.find("a.startUpload"), item);
		}
		else
		{
			item.removeAttr("status");
			$.CrushFTP.DNDUploadCallback("uploading", false, item.find("a.startUpload"), item);
		}
	}


	$.CrushFTP.showUploadForm = function(elem)
	{
		if($.CrushFTP.fetchingUploadForm)return;
		if ($("#customUploadForm").length > 0) {
			$.CrushFTP.fetchingUploadForm = true;
			getUploadForm(function (data) {
				$.CrushFTP.fetchingUploadForm = false;
				if(data && data.length>0)
				{
					data = $(data);
					var checked = window.uploadFormAskAgainChecked;
					var hideAndChecked = window.uploadFormAskAgainHideAndChecked;
					var hideAndUnchecked = window.uploadFormAskAgainHideAndUnchecked;
					var check = $("<tr id='uploadFormDataCheckbox'><td colspan='2' style='border:none;'><p class='formOption ui-state-highlight'><input type='checkbox' id='useUploadFormForAll' /><label for='useUploadFormForAll'>Don't show form for additional files.</label></p></td></tr>");
					data.append(check);
					if(checked)
						check.find("input").attr("checked", "checked");
					if(hideAndChecked)
					{
						check.find("input").attr("checked", "checked");
						check.find("td").hide();
					}
					if(hideAndUnchecked)
					{
						check.find("input").removeAttr("checked");
						check.find("td").hide();
					}
					var uploadInfoForm = $("#uploadInfoForm");
					var formContent = uploadInfoForm.find(".formContent").replaceWith(data);
					setCustomFormFieldAttributes(uploadInfoForm);
					attachCalendarPopup(uploadInfoForm);
					$.CrushFTP.uploadInfoFormDialog.data("elem", elem);
					$.CrushFTP.uploadInfoFormDialog.find("#uploadFormDataCheckbox").show();
					if(fileRepo.is(":visible"))
					{
						$.unblockUI();
						$.CrushFTP.uploadInfoFormDialog.dialog("open").dialog("moveToTop");
						$.CrushFTP.showFileRepo = true;
					}
					else
					{
						$.CrushFTP.uploadInfoFormDialog.dialog("open").dialog("moveToTop");
						$.CrushFTP.showFileRepo = false;
					}
				}
				else
					$.CrushFTP.storeUploadFormDataToItems();
			}, function(){
			});
		}
		else
		{
			$.CrushFTP.storeUploadFormDataToItems();
			$.CrushFTP.fetchingUploadForm = false;
		}
	};

	$.CrushFTP.storeUploadFormDataToItems = function(formData, elem){
		var items = elem;
		if(!items || items.length==0)
		{
			items = fileRepo.find("li:not(.formProcessed)").addClass("formProcessed");
		}
		if(formData)
		{
			items.data("formData", formData);
			items.find(".editForm").parent().show().end().unbind("click").click(function(){
				var listElem = $(this).closest("li.formProcessed");
				if(listElem && listElem.length>0)
					$.CrushFTP.showUploadForm(listElem);
				return false;
			});
		}
		else
		{
			items.find(".editForm").parent().hide();
		}

		if($.cookie($.CrushFTP.Options.CookieAutoUploadFlag) + "" == "true")
		{
			setTimeout(function() {
				fileRepo.find("a.startUploading").trigger("click");
			}, 100);
		}
	};

	$.CrushFTP.checkFileExistOnServer = function(name, _path) {
		name = name.toLowerCase();
		_path = _path || "/";
		var destinationPath = encodeURIComponent(hashListener.getHash().toString().replace("#", ""));
		destinationPath = destinationPath || "/";
		destinationPath = unescape(destinationPath);
		if(_path != destinationPath) return false;
		var fileAvl = false;
		if (window.curTreeItems) {
			$.each(window.curTreeItems, function () {
				if ($.trim($(this)[0].name).toLowerCase() === $.trim(name)) {
					fileAvl = true;
					return;
				}
			});
		}
		return fileAvl;
	};

	var getFileExtension = function(filename) {
		var ext = /^.+\.([^.]+)$/.exec(filename);
		return ext == null ? "" : ext[1].toLowerCase();
	}

	$.CrushFTP.isFileTypeAllowed = function(name){
		if(typeof window.onlyAllowedExtensionsToUpload != "undefined")
		{
			var ext = getFileExtension(name);
			return window.onlyAllowedExtensionsToUpload.has("."+ext);
		}
		if(typeof window.notAllowedExtensionsToUpload != "undefined")
		{
			var ext = getFileExtension(name);
			return !window.notAllowedExtensionsToUpload.has("."+ext);
		}
		return true;
	};


	$.CrushFTP.handleWarnings = function() {
		fileRepo.find(".fileExistOnServer").each(function(){
			var item = $(this).removeClass("fileExistOnServer").closest("li");
			item.addClass("ui-state-highlight");
			$(this).hide().after('<div class="overwrite" style="float:right;margin-top:17px;"><a href="javascript:void(0);" class="overwriteLink">'+window.locale.fileupload.overwrite+'</a></div>').parent().find("div.overwrite").click(function(){
				$(this).remove();
				item.removeClass("ui-state-highlight").find("div.startUpload").show().end().find(".error").remove();
				if($.cookie($.CrushFTP.Options.CookieAutoUploadFlag) + "" == "true")
				{
					setTimeout(function() {
						fileRepo.find("a.startUploading").trigger("click");
					}, 100);
				}
				if(fileRepo.find("ul").find("a.overwriteLink:visible").length>0)
					overwriteAllLinkBtn.show();
				else
					overwriteAllLinkBtn.hide();
				return false;
			}).parent().append("<span class='error'>"+window.locale.fileupload.error + ":" + window.locale.fileupload.errors.fileExistOnServer+"</span>");
		});

		var bigFiles = [];
		fileRepo.find(".fileBiggerThanAllowed").each(function(){
			var item = $(this).removeClass("fileExistOnServer").closest("li");
			bigFiles.push(item.find("div.name").text());
		});
		if(bigFiles.length>0)
		{
			var _title = getLocalizationKeyExternal("uploadBiggerFileNoticeTitleText");
			var _desc = getLocalizationKeyExternal("uploadBiggerFileNoticeDescText");
			$.growlUI(_title, _desc, $.CrushFTP.Options.GrowlTimeout + 10000, "growlWarning", true);
		}
		fileRepo.find("span.acceptFileTypes").each(function(){
			$(this).css("float","none");
		});
	};

	$.CrushFTP.fileCount = 0;

	var dragEventsNotSupported = !$.CrushFTP.browserSupportsDND();
	//Get val type
	$.CrushFTP.getType = function(val) {
		if (val === null) return "[object Null]";
		return Object.prototype.toString.call(val);
	}

	$.CrushFTP.getActionResponseText = function(msg) {
		var responseText = '';
		try {
			var msgs = msg.getElementsByTagName("commandResult");
			for (var x = 0; x < msgs.length; x++) {
				responseText += IE(msgs[x].getElementsByTagName("response")[0]).textContent;
			}
		} catch (ex) {}
		return responseText;
	}

	$.CrushFTP.attachDND = function(o)
	{
		$.CrushFTP.Options = o;
		css_browser_selector(navigator.userAgent);
		if(is_MacOs)
		{
			browseFileButtonPanel.find("#browseFileButton").unbind().click(function(){
				if (!$(document).data("appletLoaded")) return false;
				var curElem = $("<a>");
	            curElem.crushFtpLocalFileBrowserPopup({
	                type : 'both',
	                singleSelection : false,
	                useApplet : window["currentApplet"],
	                callback : function(arr){
	                    window.handleAppletDNDCustom(arr);
	                }
	            });
	            return false;
	        });
		}
		else
		{
			browseFileButtonPanel.find("#browseFileButton").unbind().click(function(){
				window.command_id = runAppletCommand(true, "COMMAND=BROWSE:::TITLE=" + getLocalizationKeyExternal("advancedUploadItemsSelectionWindowTitle"), true);
				function getBrowseSelection() {
					var result = {};
					if (typeof window.currentApplet != "undefined") result = window.currentApplet.getASyncResult(window.command_id);
					else {
						alert(getLocalizationKeyExternal("AppletLoadingFailedMsgText"));
						return false;
					}
					if (result) {
						window.handleAppletDND(result);
					} else {
						if ($.CrushFTP.getType(result).toLowerCase().indexOf("string") < 0) {
							setTimeout(function () {
								getBrowseSelection();
							}, 200);
						}
					}
				}
				getBrowseSelection();
			});
		}

		var browseTypeSelector = $("#browseTypeSelector").unbind().click(function(){
			var cluetipTitle = $("#cluetip-title");
			$("#cluetip").hide();
			if($(this).hasClass("normal"))
			{
				switchUploadType("advanced", $(this));
				var tipInfo = $(this).data('thisInfo');
				if(tipInfo)
				{
					var _title = locale.fileupload.SwitchToNormalUpload;
					$(this).data('thisInfo', {title: _title, zIndex: tipInfo.zIndex});
					cluetipTitle.html(_title);
				}
			}
			else
			{
				switchUploadType("normal", $(this));
				var tipInfo = $(this).data('thisInfo');
				if(tipInfo)
				{
					var _title = locale.fileupload.SwitchToAdvancedUpload;
					$(this).data('thisInfo', {title: _title, zIndex: tipInfo.zIndex});
					cluetipTitle.html(_title);
				}
			}
			$(this).blur();
			return false;
		});

		bindAppletDND();
		switchUploadType(browseTypeSelector.hasClass("normal") ? "normal" : "", browseTypeSelector);
		fileRepo.draggable({
			handle : ".fileListHeader"
		});

		$.CrushFTP.removeInvalidFiles = function()
		{
			setTimeout(function(){
				fileRepo.find("li:not(.formProcessed)").remove();
			}, 300);
		}

		$.CrushFTP.uploadInfoFormDialog = $("#uploadInfoForm").dialog({
			autoOpen: false,
			width: 650,
			modal: true,
			resizable: false,
			closeOnEscape: false,
			buttons: {
				"Cancel" : function(){
					var notProcessed = fileRepo.find("li:not(.formProcessed)");
					var elem = $.CrushFTP.uploadInfoFormDialog.data("elem");
					if(!elem)
					{
						var _confirm = getLocalizationKeyExternal("uploadConfirmCancelUploadAfterFormText") || "Are you sure you wish to cancel upload for last selected {count} item(s)?";
						_confirm = _confirm.replace("{count}", notProcessed.length);
						if(confirm(_confirm))
						{
							notProcessed.each(function(){
								$(this).find(".cancelUpload").trigger("click");
							});
							$(this).dialog("close");
						}
					}
					else
						$(this).dialog("close");
					return false;
				},
				"OK": function() {
					var that = $(this);
					if (validateForm(false, $.CrushFTP.uploadInfoFormDialog.find(".customForm")))
					{
						var formData = serializeForm($.CrushFTP.uploadInfoFormDialog.find("form")[0], true);
						if($("#useUploadFormForAll", $.CrushFTP.uploadInfoFormDialog).is(":checked") && !$.CrushFTP.uploadFormInfo)
						{
							$.CrushFTP.uploadFormInfo = formData;
						}
						var elem = $.CrushFTP.uploadInfoFormDialog.data("elem");
						$.CrushFTP.storeUploadFormDataToItems(formData, elem);
						$.CrushFTP.uploadInfoFormDialog.removeData("elem");
						$.CrushFTP.uploadInfoFormDialog.find("form").submit();
						$(this).dialog("close");
					}
				}
			},
			open: function(){
				$(".ui-dialog-titlebar-close").hide();
				var elem = $.CrushFTP.uploadInfoFormDialog.data("elem");
				if(elem)
				{
					var formData = elem.data("formData");
					if(formData)
					{
						window.bindDataToForm($.CrushFTP.uploadInfoFormDialog, formData);
					}
					$.CrushFTP.uploadInfoFormDialog.find("#uploadFormDataCheckbox").hide();
				}
				setTimeout(function(){
					$.CrushFTP.uploadInfoFormDialog.find("input, select, textarea").unbind("change").change(function(){
						$.CrushFTP.uploadInfoFormDialog.find("#meta_unique_upload_id").val(generateRandomPassword(4));
					});
				}, 100);
				$.CrushFTP.uploadInfoFormDialog.parent().addClass("uploadDialog").find(".ui-widget-header").addClass("uploadFormHeader");
			},
			close : function(){
				if($.CrushFTP.showFileRepo)
				{
					$.CrushFTP.showFileRepo = false;
					$("#fileRepo").show().trigger("visibilityChange");
				}
			}
		});

		function switchUploadType(type, elm)
		{
			if(type == "normal")
			{
				bindNativeDND();
				elm.removeClass("advanced").addClass("normal").find("span.type").text("Normal");
				browseFileButtonPanel.find("input").show();
				$.CrushFTP.browseAdvanced = false;
				if(dragEventsNotSupported)
				{
					 $(document).unbind('dragover');
				}
				window.cancelDropAction(true);
				javaAppletDiv.css({
					"position": "absolute",
					"left" : "-5000px"
				});
				AdvancedBrowseResumeOption.hide();
			}
			else
			{
				$(".appletNote").show();
				bindNativeDND(!is_MacOs);
				AdvancedBrowseResumeOption.show("fast");
				$.CrushFTP.browseAdvanced = true;
				elm.removeClass("normal").addClass("advanced").find("span.type").text("Advanced");
				browseFileButtonPanel.find("input").hide();
				if (!$.CrushFTP.appletDNDAdded)
				{
					$.CrushFTP.appletDNDAdded = true;
					elm.parent().append("<span class='spinner' style='display: inline-block;padding-left: 20px;float: left;top: 5px;position: relative;margin: 0px 6px;'>Loading...</span>");
					$("#javaAppletDiv").css({
							"right" : "0px",
							"left" : "auto"
						});
					loadApplet(true, function (pnl) {
						if(pnl)
						{
							elm.parent().find("span.spinner").remove();
							if (dragEventsNotSupported) {
								window.showDropArea();
								$(window).bind("resize", function () {
									window.showDropArea();
								});
								setTimeout(listenAppletDrop, 500);
							}
							else
								$("#javaAppletDiv").css("left", "-5000px");
						}
						else
						{
							elm.parent().find("span.spinner").remove();
							$.CrushFTP.appletDNDAdded = false;
							var linkSwitch = $("#browseTypeSelector");
							var tipInfo = $(this).data('thisInfo');
							var zIndex = 9999;
							if(tipInfo)
							{
								zIndex = tipInfo.zIndex;
							}
							linkSwitch.cluetip("destroy");
							var cluetipTitle = $("#cluetip-title");
							var _title = locale.fileupload.SwitchToAdvancedUpload;
							linkSwitch.attr("title", _title).data('thisInfo', {title: _title, zIndex: zIndex});
							cluetipTitle.html(_title);
							switchUploadType("normal", elm);
							setTimeout(function() {
								linkSwitch.cluetip({
									splitTitle: '^',
									showTitle: false,
									width: 'auto',
									cluetipClass: 'default',
			                        clickThrough : true,
									arrows: true,
									tracking: true,
									positionBy: 'mouse',
									mouseOutClose: true,
									dropShadowSteps: 0,
									dynamicLeftOffset: true
								});
							}, 100);
						}
					}, false, elm.parent());
				}
				else
				{
					if(dragEventsNotSupported && !is_MacOs)
					{
						window.showDropArea();
						javaAppletDiv.css({
							"position": "fixed",
							"margin": "0px",
							"padding": "0px",
							"right" : "0px",
							"left" : "auto"
						});
					}
				}
			}
		}

		function bindNativeDND(disableDragOver){
			if(disableDragOver)
			{
				$.CrushFTP.uploadElem = $("#fileupload").crushftp_DNDUpload({disableDragOver : true});
			}
			else
			{
				var dropItemsPanel = $("#dropItemsPanel");
				var fileQueueInfo = $("#fileQueueInfo");
				$.CrushFTP.uploadElem = $("#fileupload").crushftp_DNDUpload({
					fileuploaddropEvent : function(e, data)
					{
						var target = $(e.target);
						processAddedFiles(target, data, false, true);
						e.stopPropagation();
					},
					documentDragEvent : function(e)
					{
						if(!window.draggingOut)
						{
							dropItemsPanel.show();
							if(dropItemsPanel.hasClass("stick"))
								fileQueueInfo.css("z-index", 0);
						}
					},
					documentDropEvent : function(e)
					{
						dropItemsPanel.hide();
						if(dropItemsPanel.hasClass("stick"))
							fileQueueInfo.css("z-index", 98);
					},
					fileuploadadded : function(e, data)
					{
						$.CrushFTP.buildQueueInfo();
						fileRepo.find(".dirNoWritable").each(function(){
							$(this).closest("li").find("a.cancelUpload").trigger("click");
						});
						var dirsAddedButNotAllowed = false;
						fileRepo.find(".blockUploadingDirs").each(function(){
							dirsAddedButNotAllowed = true;
							$(this).closest("li").find("a.cancelUpload").trigger("click");
						});
						if(dirsAddedButNotAllowed)
						{
							$.growlUI(getLocalizationKeyExternal("AdvancedUploadDirNotAllowedText"), getLocalizationKeyExternal("AdvancedUploadDirNotAllowedDescText"), true, "growlError");
						}
						if(!data.files[0].error && !$.CrushFTP.uploadFormInfo)
							$.CrushFTP.showUploadForm();

						if($.CrushFTP.uploadFormInfo)
						{
							var elem = fileRepo.find("li:not(.formProcessed)").addClass("formProcessed");
							$.CrushFTP.storeUploadFormDataToItems($.CrushFTP.uploadFormInfo, elem);
						}
						$.CrushFTP.showIconsForFiles();
						$.CrushFTP.handleWarnings();
					},
					fileuploadchange : function(e, data)
					{
						if(!data || !data.files)return;
						processAddedFiles(false, data);
						$.CrushFTP.buildQueueInfo();
						e.stopPropagation();
					},
					fileuploaddestroyed : function(e, data)
					{
						$.CrushFTP.buildQueueInfo();
					}
				});
			}
		}

		function bindAppletDND()
		{
			//Show drop area on upload window
			window.showDropArea = function () {
				if (!$(document).data("appletLoaded")) return false;
				if(dragEventsNotSupported || is_MacOs)return;
				javaAppletDiv.css({
					"position": "fixed",
					"margin": "0px",
					"padding": "0px",
					"right" : "0px",
					"left" : "auto"
				});
				javaAppletDiv.addClass('dragOver');
			}

			//Cancel drop action
			window.cancelDropAction = function (ignoreBrowser) {
				if (dragEventsNotSupported && !ignoreBrowser) return false; //IE issue fix
				javaAppletDiv.css({
					"position": "absolute",
					"left" : "-5000px"
				});
			}

			window.listenAppletDrop = function(){
				if($.CrushFTP.browseAdvanced)
				{
					var s = runAppletCommand(true, "COMMAND=DND:::");
					if (s && s != "") {
						handleAppletDND(s);
						while (s != "") {
							s = runAppletCommand(true, "COMMAND=DND:::");
							if (s && s != "") {
								handleAppletDND(s);
							}
						}
						window.cancelDropAction();
					}
				}
				if(!dragEventsNotSupported)
				{
					if (new Date() - $(document).data("dndActiveAt") > 1000)
						window.cancelDropAction();
					else
						setTimeout(listenAppletDrop, 500);
				}
				else
					setTimeout(listenAppletDrop, 500);
			}

			//Parse java properties
			window.parseJavaProps = function(s) {
				var o = {};
				if (s) {
					var item_props = s.split(":::");
					for (var xx = 0; xx < item_props.length; xx++) {
						o[item_props[xx].substring(0, item_props[xx].indexOf("="))] = item_props[xx].substring(item_props[xx].indexOf("=") + 1); //set the key, and value on the o object
					}
				}
				return o;
			}

			window.handleAppletDND = function(result)
			{
				result = result + ""; //need to conver this JavaRuntimeObject to a String
				var destinationPath = hashListener.getHash().toString().replace("#", "") || "/";
				var itemList = new Array();
				var items = result.split(";;;");
				for (var x = 0; x < items.length; x++) {
					var o = parseJavaProps(items[x]);
					if(o && o.name)
					{
						o.destinationPath = destinationPath;
						o.fromApplet = true;
						o.sourcePath = o.path;
						o.size = parseFloat(o.size);
						if(o.type && o.type.toLowerCase() == "dir" && window.blockUploadingDirs)
						{
							$.growlUI(getLocalizationKeyExternal("AdvancedUploadDirNotAllowedText"), getLocalizationKeyExternal("AdvancedUploadDirNotAllowedDescText"), true, "growlError");
						}
						else
						{
							itemList[itemList.length] = o;
						}
					}
				}
				if (itemList.length > 0) {
					processAddedFiles(fileRepo, {files : itemList}, true);
				}
			}

			window.handleAppletDNDCustom = function(items)
			{
				var destinationPath = hashListener.getHash().toString().replace("#", "") || "/";
				var itemList = new Array();
				for (var x = 0; x < items.length; x++) {
					var o = items[x];
					if(o && o.name)
					{
						o.destinationPath = destinationPath;
						o.fromApplet = true;
						o.sourcePath = o.path;
						o.size = parseFloat(o.size);
						if(o.type && o.type.toLowerCase() == "dir" && window.blockUploadingDirs)
						{
							$.growlUI(getLocalizationKeyExternal("AdvancedUploadDirNotAllowedText"), getLocalizationKeyExternal("AdvancedUploadDirNotAllowedDescText"), true, "growlError");
						}
						else
						{
							itemList[itemList.length] = o;
						}
					}
				}
				if (itemList.length > 0) {
					processAddedFiles(fileRepo, {files : itemList}, true);
				}
			}

			if(!dragEventsNotSupported && !is_MacOs)
			{
				addEvent($(document), "dragenter", function (e) {
					if($.CrushFTP.browseAdvanced)
					{
						$(document).data("dndActiveAt", new Date() * 1);
						if (e.preventDefault) e.preventDefault();
						if (!$(document).data("appletLoaded")) {
							$.growlUI(getLocalizationKeyExternal("JavaAppletNotLoadedGrowlText"), getLocalizationKeyExternal("JavaAppletNotLoadedDescGrowlText"), o.GrowlTimeout, "growlError", o.GrowlWithCloseButton);
							return false;
						}
						window.showDropArea();
						setTimeout(listenAppletDrop, 500);
					}
					return false;
				});

				addEvent($(document), "dragover", function cancel(e) {
					if($.CrushFTP.browseAdvanced)
					{
						$(document).data("dndActiveAt", new Date() * 1);
						if (e.preventDefault) e.preventDefault();
					}
					return false;
				});

				addEvent($(document), "drop", function (e) {
					if($.CrushFTP.browseAdvanced)
					{
						if (e.preventDefault) e.preventDefault();
						window.cancelDropAction(true);
					}
					return false;
				});
			}
		}

		function isFileBigger(size) {
			if(!size) return false;
			var sizeInMB = size / 1024 / 1024;
			if(!$.CrushFTP.maxFileSizeAllowedInNormalUploadInMB) return false;

			if(sizeInMB<=$.CrushFTP.maxFileSizeAllowedInNormalUploadInMB)
				return false;
			else
				return true;
		}

		function renderTemplate(func, files) {
            if (!func) {
                return $();
            }
            var result = func({
                files: files,
                formatFileSize: $.CrushFTP.formatBytes
            });
            if (result instanceof $) {
                return result;
            }
            return result;
        }

        function getAltNameForIOS(name, file)
        {
        	var postFix = 0;
        	if($.CrushFTP.checkFileExistOnServer(name, escape(file.path)))
        	{
        		if($.CrushFTP.lastDirCheckedForiOSIncrement != file.path)
        		{
        			$.CrushFTP.lastDirCheckedForiOSIncrement = file.path;
        			var items = [];
        			for (var i = l.length - 1; i >= 0; i--) {
        				if(l[i].name.indexOf("image")>=0)
        				{
        					var numb = l[i].name.match(/\d/g);
        					if(numb)
        					{
								numb = numb.join("");
	        					items.push(numb);
        					}
        				}
        			};
        			if(items.length>0)
        			{
        				items = items.sort(function(a,b){return b-a});
        				postFix = parseInt(items[0]) + 1;
        			}
        			else
        			{
        				if(typeof $.CrushFTP.lastiOSIncrement != "undefined")
        					postFix = $.CrushFTP.lastiOSIncrement + 1;
        			}
        		}
        		else
        		{
        			if(typeof $.CrushFTP.lastiOSIncrement != "undefined")
        				postFix = $.CrushFTP.lastiOSIncrement + 1;
        		}
        	}
        	else if(fileRepo.find("li[filename=*'image']:first").length>0)
        	{
        		var items = [];
        		fileRepo.find("input[value='"+file.path+"']").closest("li[filename=*'image']").each(function(){
					var numb = unescape($(this).attr("filename")).match(/\d/g);
					if(numb)
					{
						numb = numb.join("");
						items.push(numb);
					}
        		});
        		if(items.length>0)
    			{
    				items = items.sort(function(a,b){return b-a});
    				postFix = parseInt(items[0]) + 1;
    			}
    			else
    			{
    				if(typeof $.CrushFTP.lastiOSIncrement != "undefined")
    					postFix = $.CrushFTP.lastiOSIncrement + 1;
    			}
        	}
        	else if(typeof $.CrushFTP.lastiOSIncrement != "undefined")
    			postFix = $.CrushFTP.lastiOSIncrement + 1;
        	$.CrushFTP.lastiOSIncrement = postFix;
        	return postFix;
        }

		var tmplFn = tmpl("template-upload");
		function processAddedFiles(target, data, applet, isDropped)
		{
			var path = "";
			var privs = $(document).data("folderPrivs");
			if(!target) target = $();
			if(!target.hasClass("dropzone"))
			{
				target = target.closest(".dropzone");
			}
			if(target.hasClass("directoryThumb"))
			{
				path = target.find("a.imgLink").attr('rel').match(/.*\//);
				if(target.data("dataRow")){
					privs = target.data("dataRow").privs.toString();
				}
			}
			else if(target.hasClass("directoryTree"))
			{
				path = target.find("a:first").attr('rel').match(/.*\//);
				privs = target.attr("privs");
			}
			else{
				var destinationPath = encodeURIComponent(hashListener.getHash().toString().replace("#", ""));
				destinationPath = destinationPath || "/";
				path = destinationPath;
			}
			var _write = privs.indexOf("(write)")>=0;
			var hasError = false;
			$.each(data.files, function (index, file) {
				file.privs = privs;
				var _fileName = file.name;
				if(!applet)
				{
					file.path = unescape(unescape(path));
					var noDir = false;
					if(file.relativePath && file.relativePath != "")
					{
						if(window.blockUploadingDirs)
						{
							noDir = true;
							file.error = "blockUploadingDirs";
							hasError = true;
						}
						else
							file.path = file.path + file.relativePath;
					}
					if(!noDir)
						file.FullPath = escape(file.path + _fileName);
				}
				else
				{
					file.path = unescape(file.destinationPath);
					file.FullPath = escape(file.destinationPath + _fileName);
				}
				file.isDropped = isDropped;
				if($.CrushFTP.iOS)
				{
					if(_fileName.toLowerCase().indexOf("image")>=0)
					{
						var altName = getAltNameForIOS(_fileName, file);
						var name = _fileName;
						var arr = name.split(".");
						if(arr.length>1)
							arr[arr.length-2] = arr[arr.length-2] + "_" + altName;
						else
							arr[0] = arr[0] + "_" + altName;
						_fileName = file.altName = arr.join(".");
						file.FullPath = escape(file.path + file.altName);
					}
				}
				if(typeof file.curCount == "undefined")
				{
					file.curCount = $.CrushFTP.fileCount;
					$.CrushFTP.fileCount+=1;
				}
				if(!$.CrushFTP.iOS && fileRepo.find("li[fullPath='"+file.FullPath+"']").length>0)
				{
					file.error = "fileAvailableInSelectedFolder";
					hasError = true;
				}
				else if(!$.CrushFTP.isFileTypeAllowed(_fileName))
				{
					file.error = "acceptFileTypes";
					hasError = true;
				}
				else if($.CrushFTP.checkFileExistOnServer(_fileName, escape(file.path)))
				{
					if($.CrushFTP.browseAdvanced && $('#resumeUpload_AppletConfig').is(":checked"))
					{
						file.warning = false;
					}
					else
						file.warning = "fileExistOnServer";
				}
				if(!applet && file.size)
				{
					if(isFileBigger(file.size))
					{
						file.alert = "fileBiggerThanAllowed";
					}
				}
				if(!_write)
				{
					file.error = "dirNoWritable";
					hasError = true;
				}
			});
			if(!_write)
			{
				$.growlUI(getLocalizationKeyExternal("NoUploadInDirGrowlText"), getLocalizationKeyExternal("NoUploadInDirGrowlDesc") + "<br/>" + unescape(path), o.GrowlTimeout, "growlError");
			}
			else if(applet)
			{
				if(hasError)
					data.files.valid = false;
				else
					data.files.valid = true;
				var tempVar = [$.extend({}, data.files[0])];
				var names = [];
				var size = 0;
				var filePaths = "";
				for(var i=0;i<data.files.length;i++)
				{
					if(data.files[i])
					{
						if(data.files[i].name)
						{
							names.push(data.files[i].name);
						}
						if(data.files[i].size)
						{
							size += data.files[i].size;
						}
						if(data.files[i].sourcePath)
						{
							var j = i+1;
							filePaths += ":::P" + j + "=" + data.files[i].sourcePath;
						}
					}

				}
				names = names.join(", ");
				if(names.length>50)
					names = names.substr(0, 30) + "..." + names.substr(names.length-15, names.length);
				tempVar[0].name = names;
				tempVar[0].size = size;
				tempVar[0].isGroup = data.files.length>1;
				tempVar[0].totalCount = data.files.length;
				tempVar[0].sourcePath = filePaths;
				var html = $(renderTemplate(tmplFn, tempVar));
				var newItems = $(html);
				fileRepo.find("ul").append(newItems);
				var curIndex = 0;
				newItems.each(function(){
					if($(this).is("li"))
					{
						if(data.files.length == 1)
							$(this).data("fileInfo", data.files[curIndex]).attr("uid", generateRandomPassword(8));
						else
							$(this).data("fileInfo", tempVar[0]).attr("uid", generateRandomPassword(8));
						curIndex+=1;
					}
				});
				fileRepo.find(".dirNoWritable").each(function(){
					$(this).closest("li").find("a.cancelUpload").trigger("click");
				});
				if(!data.files[0].error && !$.CrushFTP.uploadFormInfo)
					$.CrushFTP.showUploadForm();

				if($.CrushFTP.uploadFormInfo)
				{
					var elem = fileRepo.find("li:not(.formProcessed)").addClass("formProcessed");
					$.CrushFTP.storeUploadFormDataToItems($.CrushFTP.uploadFormInfo, elem);
				}
				$.CrushFTP.handleWarnings();
				$.CrushFTP.buildQueueInfo();
			}
		}
		/*Init code*/
		$.CrushFTP.bindUploadEvents();
		viewFileQueue.hover(function() {
			if($(this).hasClass("close"))
	        	$(this).stop().animate({ top: "0px" }, 200);
	       	else
	       		$(this).stop().animate({ top: "10px" }, 200);
	    },function(){
	        $(this).stop().animate({ top: "4px" }, 300);
	    });

	    fileRepo.bind("visibilityChange", function(){
			if(fileRepo.is(":visible"))
			{
				viewFileQueue.addClass("close");
				fileQueueInfo.removeClass("ui-widget-content ui-corner-all");
				if(fileRepo.find("#fileUploadBar").length==0)
				{
					fileRepo.find("div.fileListHeader").after("<div class='fileuploadBarHolder ui-widget-content ui-corner-all'></div>");
					fileRepo.find("div.fileuploadBarHolder").append(fileUploadBar);
					fileRepo.find("div.fileuploadBarHolder").append("<div class='clear'></div>");
				}
				if(window.fileWindowAsDialog)
				{
					fileRepo.hide();
					$.blockUI({
						message: fileRepo,
						css: {
							width: '0px',
							height : '0px',
							padding : '0px',
							border : 'none',
							position: 'absolute',
							top: '25%',
							left : '50%',
							'margin-left' : '-420px',
							opacity: 1,
							'background-color': getPopupColorExternal(true)
						}
					});
				}
			}
			else
			{
				viewFileQueue.removeClass("close");
				if(fileUploadBarHolder.find("#fileUploadBar").length==0)
				{
					fileUploadBarHolder.append(fileUploadBar);
					fileQueueInfo.addClass("ui-widget-content ui-corner-all");
					fileRepo.find("div.fileuploadBarHolder").remove();
				}
			}
	    });
	}

	$.CrushFTP.refreshProgressInfo = function(elem){
		if(elem.hasClass("skipped"))
		{
			$.CrushFTP.processStatusOfUpload(elem, "error");
			return;
		}
		var isApplet = elem.hasClass("appletItem");
		$.CrushFTP.getUploadProgress(function(result){
			$.CrushFTP.updateProgressBar(elem, isApplet, result);
			var status = elem.data("uploadInfo").status;
			if(isApplet) status = elem.data("uploadInfo").statusApplet;
			$.CrushFTP.processStatusOfUpload(elem, status, result);
		}, elem, isApplet);
	}

	$.CrushFTP.ShowShareOptionForUploadedItem = function(elem)
	{
		if(fileRepo.find("a.shareUploadedItem").length>0)
			shareAllUploaded.show();
		else
			shareAllUploaded.hide();

		var privs = elem.attr("privs");
		if(!privs || typeof window.shareFile == "undefined")return;
		privs = unescape(privs);
		if(privs.toLowerCase().indexOf("(share)")>=0 && elem.find("a.shareUploadedItem").length==0)
		{
			var disableShareForUploadedItem = $(document).data("disableShareForUploadedItem");
			var reuploadLink = elem.find("a.startUpload:first");
			if(!disableShareForUploadedItem)
			{
				reuploadLink.parent().before("<div class='share block'><a href='javascript:void(0)' class='shareUploadedItem'>"+ locale.fileupload.share +"</a></div>");
				$.CrushFTP.ShowShareOptionForUploadedItem(elem);
				elem.find("a.shareUploadedItem").unbind().click(function(){
					var fileName = unescape(elem.attr("fileName"));
					var shareMethodUploadedItem = $(document).data("shareMethodUploadedItem");
					if(shareMethodUploadedItem && shareMethodUploadedItem.toLowerCase() == "quick")
					{
						window.quickShareFile(false, unescape(unescape(elem.attr("path"))) + fileName);
					}
					else
						window.shareFile(false, unescape(unescape(elem.attr("path"))) + fileName, fileName);
					$(this).blur();
					return false;
				});
			}
			if(fileRepo.find("li.uploaded").length>0)
				clearUploadedAll.show();
			else
				clearUploadedAll.hide();
		}
	}

	$.CrushFTP.processStatusOfUpload = function(elem, status, result)
	{
		var progressInfo = elem.find("div.progressInfo");
		if(status == "completed")
		{
			if(elem.hasClass("appletItem"))
			{
				elem.removeClass("uploadProgress").addClass("uploaded").find("a.startUpload").text(locale.fileupload.reupload).show();
				setTimeout(function(){
					elem.removeClass("uploadProgress").addClass("uploaded").find("a.startUpload").text(locale.fileupload.reupload).show();
					if(elem.data("formData"))
						elem.find("a.editForm").parent().show();
					$.CrushFTP.ShowShareOptionForUploadedItem(elem);
					elem.find("a.pause").parent().hide();
					progressInfo.hide();
				}, 200);
			}
			else
			{
				elem.removeClass("uploadProgress").addClass("uploaded").find("a.startUpload").text(locale.fileupload.reupload).show();
				$.CrushFTP.ShowShareOptionForUploadedItem(elem);
				if(elem.data("formData"))
					elem.find("a.editForm").parent().show();
				progressInfo.hide();
			}

			var btn = $.CrushFTP.getNextQueuedItem(!$.CrushFTP.uploadAllQueued);
			progressInfo.find(".time,.speed,.status,.uploadStatusLabel").remove();
			var progressInfoHistory = $(elem).data("uploadInfo");
			if(progressInfoHistory && progressInfoHistory.avgSpeed && progressInfoHistory.timeElapsed)
			{
				elem.find("div.name").find(".uploadNote").remove();
				if(progressInfoHistory.avgSpeed == getLocalizationKeyExternal("BrowserUploaderSpeedTimeCalculatingText"))
					progressInfoHistory.avgSpeed = progressInfoHistory.currentSpeed;
				if(progressInfoHistory.avgSpeed == getLocalizationKeyExternal("BrowserUploaderSpeedTimeCalculatingText"))
				{
					elem.find("div.name").append("<div class='uploadNote'>(" + locale.fileupload.uploadedInLabelText + "" +progressInfoHistory.timeElapsed+")</div>");
				}
				else
				{
					elem.find("div.name").append("<div class='uploadNote'>(" + locale.fileupload.uploadedInLabelText + "" +progressInfoHistory.timeElapsed+", "+locale.fileupload.atAvgSpeedOfLabelText +""+progressInfoHistory.avgSpeed+")</div>");
				}
			}
			$(elem).data("uploadInfo", {part1 : 0, part2 : 0, status : "", history : new Array()});
			if($.CrushFTP.uploadAllQueued)
			{
				if(btn)
				{
					$.CrushFTP.UploadProgressing = false;
					btn.trigger("click", [{allInQueue:true}]);
				}
				else
				{
					$.CrushFTP.removeGlobalProgressInfo();
				}
			}
			else
			{
				$.CrushFTP.UploadProgressing = false;
				if(btn && btn.length>0)
				{
					btn.trigger("click");
				}
				else
				{
					var isVisibleRepo = fileRepo.is(":visible");
					if(window.noTimeoutUploadedNote)
						$.growlUI(locale.fileupload.uploadCompletedText, locale.fileupload.uploadedFileText, false, false, true);
					else
						$.growlUI(locale.fileupload.uploadCompletedText, locale.fileupload.uploadedFileText, $.CrushFTP.Options.GrowlTimeout);
					if(window.hideUploadBarAfterUpload)
					{
						viewFileQueue.addClass("close").trigger("click");
					}
					if(window.fileWindowAsDialog)
					{
						if(isVisibleRepo)
							viewFileQueue.removeClass("close").trigger("click");
						else
							viewFileQueue.addClass("close").trigger("click");
					}
					fileRepo.find(".curQueue").removeClass("curQueue");
					$.CrushFTP.removeGlobalProgressInfo();
					var autoShareUploadedItem = $(document).data("autoShareUploadedItem");
					if(autoShareUploadedItem && autoShareUploadedItem.toLowerCase()=="true")
					{
						shareAllUploaded.trigger("click");
					}
					if(window.autoRemoveUploadedItemFromList)
					{
						fileRepo.find("a.clearCompleted:first").trigger('click');
					}
				}
			}

			if(fileRepo.find("li.uploaded").length>0)
				clearUploadedAll.show();
			else
				clearUploadedAll.hide();
		}
		else if(status == "error")
		{
			elem.removeClass("uploadProgress").addClass("hasError").find("a.startUpload").text(locale.fileupload.reupload).show();
			if(!elem.hasClass("appletItem") && result && result.message)
			{
				elem.append("<span class='error' style='color:red;'>"+result.message+"</span>");
			}
			if(elem.data("formData"))
				elem.find("a.editForm").parent().show();
			if($.CrushFTP.uploadAllQueued)
			{
				var btn = $.CrushFTP.getNextQueuedItem();
				if(btn)
				{
					$.CrushFTP.UploadProgressing = false;
					btn.trigger("click", [{allInQueue:true}]);
				}
				else
				{
					$.CrushFTP.removeGlobalProgressInfo();
				}
			}
			else
			{
				$.CrushFTP.UploadProgressing = false;
				var btn = $.CrushFTP.getNextQueuedItem(true);
				if(btn && btn.length>0)
				{
					btn.trigger("click");
				}
				else
				{
					$.CrushFTP.removeGlobalProgressInfo();
				}
			}
			progressInfo.hide();
			$(elem).data("uploadInfo", {part1 : 0, part2 : 0, status : "", history : new Array()});
			progressInfo.find(".time,.speed,.status,.uploadStatusLabel").remove();
		}
		else
		{
			if(!elem.hasClass("skipped"))
			{
				setTimeout(function(){
					$.CrushFTP.refreshProgressInfo(elem);
				}, 1000);
			}
		}
	}

	$.CrushFTP.abortUploadRequest = function(elem){
		$.ajax({
			type: "POST",
			url: $.CrushFTP.Options.ajaxCallURL,
			data: "command=blockUploads&random=" + Math.random(),
			success: function (response) {
			}
		});
	};

	$.CrushFTP.getBatchInfo = function(isBatch)
	{
		var totalSize = 0;
		var totalFiles = 0;
		if(isBatch)
		{
			var itms = fileRepo.find("li:not(.error, .ui-state-highlight, .hasError, .warning)").each(function(){
				var curSize = parseFloat($(this).attr("size"));
				if(IsNumeric(curSize))
				{
					totalSize += curSize;
				}
			});
			totalFiles = itms.length;
		}
		else
		{
			var itms = fileRepo.find("li.curQueue:not(.error, .ui-state-highlight, .hasError, .warning)").each(function(){
				var curSize = parseFloat($(this).attr("size"));
				if(IsNumeric(curSize))
				{
					totalSize += curSize;
				}
			});
			totalFiles = itms.length;
		}
		return {
			size : totalSize,
			files : totalFiles
		};
	}

	$.CrushFTP.updateProgressBar = function(elem, isApplet, appletResult){
		var uploadInfo = elem.data("uploadInfo");
		var progressInfo = elem.find("div.progressInfo");
		if(!uploadInfo) return;
		var now = new Date().getTime();
		if (!uploadInfo.history) uploadInfo.history = new Array();
		//calculate speeds using a rolling 10 interval window.  This provides a smoother speed calculation that doesn't bounce around so much to make the user concerned
		var history = uploadInfo.history;//Progressbar data history
		var currentSpeed = uploadInfo.currentSpeed;//Current upload/download speed
		var speedHistory = uploadInfo.speedHistory || [];
		history.push({
			now: now,
			bytes: uploadInfo.part1
		});
		if (history.length > 1 && elem.hasClass("paused") == false) {//Calculation and updating progressbar. Calculation of speed, percentages etc.
			var pivot = 0; //If history is for less than 5 seconds, use data of first second
			if (history.length > 5) {
				pivot = history.length - 5; // Set pivot to be of previous five second
			}
			var elapsed = now - history[0].now; // Time elapsed
			var bytes = uploadInfo.part1 - history[pivot].bytes; // Bytes transferred in timeframe
			var lastElapsed = now - history[pivot].now;// Elapsed time for last transfer timeframe
			var originalBytes = uploadInfo.part1 - history[0].bytes; // total bytes transferred
			var secs = ((((uploadInfo.part2 - uploadInfo.part1) / (originalBytes / elapsed)) / 1000) + 1) + ""; // total time remaining
			var remaining = $.CrushFTP.formatTime(secs);//formatted time
			var percentDone = (uploadInfo.part1 / uploadInfo.part2) * 100.0;// percentages completed
			var rElapsed = $.CrushFTP.formatTime((elapsed / 1000) + 1 + "");// elapsed time formatted
			var speed = "";
			var currentActualSpeed = 0;
			if ((originalBytes / elapsed) == 0) {// Still Calculating
				speed = getLocalizationKeyExternal("BrowserUploaderSpeedTimeCalculatingText");
				remaining = getLocalizationKeyExternal("BrowserUploaderSpeedTimeCalculatingText");
				uploadInfo.currentSpeed = speed;
			} else {
				currentActualSpeed = (bytes / lastElapsed) * 1024.0;
				speed = $.CrushFTP.formatBytes(currentActualSpeed) + "/s";// Based on data transferred in last timeframe (5 secs)
				uploadInfo.currentSpeed = speed;
			}
			var uploadedSize = $.CrushFTP.formatBytes(uploadInfo.part1);
			var originalSize = $.CrushFTP.formatBytes(uploadInfo.part2);
			if(isApplet)
			{
				var estimatedSize = parseFloat(elem.attr("size"));
				if(!IsNumeric(estimatedSize))
					estimatedSize = 0;
				if(IsNumeric(uploadInfo.part2) && uploadInfo.part2 > estimatedSize)
				{
					elem.attr("size", uploadInfo.part2);
					elem.find("div.size").text(originalSize);
					$.CrushFTP.buildQueueInfo();
				}
			}
			progressInfo.find(".time,.speed,.status,.uploadStatusLabel").remove();
			progressInfo.append('<span class="uploadStatusLabel">' + uploadedSize + ' of ' + originalSize + '</span>');
			var timeStampLabel = getLocalizationKeyExternal("BrowserUploaderAdvancedUploadingTimeText");
			timeStampLabel = timeStampLabel.replace("{0}", rElapsed);
			uploadInfo.timeElapsed = rElapsed;
			timeStampLabel = timeStampLabel.replace("{1}", remaining);
			progressInfo.append(timeStampLabel);
			uploadInfo.avgSpeed = speed;
			if(elapsed/1000 >= 20)
			{
				speedHistory.push(currentActualSpeed);
				uploadInfo.speedHistory = speedHistory;
				var getAverageSpeed = function()
				{
					if(speedHistory.length>30)
					{
						while (speedHistory.length > 30) speedHistory.shift();
					}
					var avgSpeed = speedHistory.average();
					if(avgSpeed>0)
					{
						uploadInfo.avgSpeed = $.CrushFTP.formatBytes(avgSpeed) + "/s";
						return getLocalizationKeyExternal("BrowserUploaderAdvancedUploadingAverageSpeedText") + uploadInfo.avgSpeed +", ";
					}
					else
						return "";
				}
				progressInfo.append("<div class='speed'>" + getAverageSpeed() + getLocalizationKeyExternal("BrowserUploaderAdvancedUploadingSpeedText") + speed + "</div>");
			}
			else
			{
				progressInfo.append("<div class='speed'>" + getLocalizationKeyExternal("BrowserUploaderAdvancedUploadingSpeedText") + speed + "</div>");
			}
			if(isApplet && appletResult && appletResult.status)
			{
				if(appletResult.status && (appletResult.status.indexOf("ERROR:") >= 0 || appletResult.status.indexOf("WARN:") >= 0))
				{
					progressInfo.find("div.speed").prepend("<span style='color:red'>" + appletResult.status + "</span><br>");
				}
				else
					progressInfo.find("div.speed").prepend(appletResult.status + "<br>");
			}
			if(uploadInfo.part1>0)
				progressInfo.find(".progressbar").progressbar({"value" : percentDone});

			//Global Progressbar
			if(!dragEventsNotSupported)
			{
				var batchInfo = $.CrushFTP.getBatchInfo($.CrushFTP.uploadAllQueued);
				var totalSize = batchInfo.size;
				var guploadInfo = globalProgressBar.data("uploadInfo");
				var prevFileSize = 0;
				var lastFile = globalProgressBar.data("curFile");
				globalProgressBar.data("curFile", elem.attr("uid"));
				if(!guploadInfo)
				{
					guploadInfo = {part1 : 0, part2 : 0, totalUploaded : 0, curfile:1, status : "", history : new Array()};
				}
				if(lastFile && lastFile != elem.attr("uid"))
				{
					prevFileSize = globalProgressBar.data("curFileSize");
					guploadInfo.totalUploaded += prevFileSize;
					guploadInfo.curfile += 1;
				}
				else
				{
					globalProgressBar.data("curFileSize", uploadInfo.part2);
				}
				guploadInfo.part2 = totalSize;
				guploadInfo.part1 = guploadInfo.totalUploaded + uploadInfo.part1;
				guploadInfo.status = uploadInfo.status;
				globalProgressBar.data("uploadInfo", guploadInfo);
				$.CrushFTP.updateGlobalProgressBar(elem, batchInfo.files, guploadInfo.curfile, isApplet, appletResult);
			}
			else
			{
				var batchInfo = $.CrushFTP.getBatchInfo($.CrushFTP.uploadAllQueued);
				var totalSize = batchInfo.size;
				var lastFile = globalProgressBar.data("curFile");
				globalProgressBar.data("curFile", elem.attr("uid"));
				var curFileCount = globalProgressBar.data("curFileCount");
				if(!curFileCount)
					curFileCount = 1;
				if(lastFile && lastFile != elem.attr("uid"))
				{
					curFileCount += 1;
					globalProgressBar.data("curFileCount", curFileCount);
				}
				globalProgressBar.data("uploadInfo", uploadInfo);
				$.CrushFTP.updateGlobalProgressBar(elem, batchInfo.files, curFileCount, isApplet, appletResult);
			}
		}
	}

	$.CrushFTP.updateGlobalProgressBar = function(elem, totalFiles, curFile, isApplet, appletResult)
	{
		var uploadInfo = globalProgressBar.data("uploadInfo");
		if(!uploadInfo) return;
		var now = new Date().getTime();
		if (!uploadInfo.history) uploadInfo.history = new Array();
		//calculate speeds using a rolling 10 interval window.  This provides a smoother speed calculation that doesn't bounce around so much to make the user concerned
		var history = uploadInfo.history;//Progressbar data history
		var currentSpeed = uploadInfo.currentSpeed;//Current upload/download speed
		var speedHistory = uploadInfo.speedHistory || [];
		history.push({
			now: now,
			bytes: uploadInfo.part1
		});
		if (history.length > 1 && elem.hasClass("paused") == false) {//Calculation and updating progressbar. Calculation of speed, percentages etc.
			var pivot = 0; //If history is for less than 5 seconds, use data of first second
			if (history.length > 5) {
				pivot = history.length - 5; // Set pivot to be of previous five second
			}
			var elapsed = now - history[0].now; // Time elapsed
			var bytes = uploadInfo.part1 - history[pivot].bytes; // Bytes transferred in timeframe
			var lastElapsed = now - history[pivot].now;// Elapsed time for last transfer timeframe
			var originalBytes = uploadInfo.part1 - history[0].bytes; // total bytes transferred
			var secs = ((((uploadInfo.part2 - uploadInfo.part1) / (originalBytes / elapsed)) / 1000) + 1) + ""; // total time remaining
			var remaining = $.CrushFTP.formatTime(secs);//formatted time
			var percentDone = (uploadInfo.part1 / uploadInfo.part2) * 100.0;// percentages completed
			var rElapsed = $.CrushFTP.formatTime((elapsed / 1000) + 1 + "");// elapsed time formatted
			var speed = "";
			var currentActualSpeed = 0;
			if ((originalBytes / elapsed) == 0) {// Still Calculating
				speed = getLocalizationKeyExternal("BrowserUploaderSpeedTimeCalculatingText");
				remaining = getLocalizationKeyExternal("BrowserUploaderSpeedTimeCalculatingText");
				uploadInfo.currentSpeed = speed;
			} else {
				currentActualSpeed = (bytes / lastElapsed) * 1024.0;
				speed = $.CrushFTP.formatBytes(currentActualSpeed) + "/s";// Based on data transferred in last timeframe (5 secs)
				uploadInfo.currentSpeed = speed;
			}
			var uploadedSize = $.CrushFTP.formatBytes(uploadInfo.part1);
			var originalSize = $.CrushFTP.formatBytes(uploadInfo.part2);
			if(uploadInfo.part2<uploadInfo.part1)
				originalSize = $.CrushFTP.formatBytes(uploadInfo.part1);
			uploadInfo.originalSize = originalSize;
			var uploadStatusLabel = uploadedSize + ' of ' + originalSize;
			var timeStampLabel = getLocalizationKeyExternal("BrowserUploaderAdvancedUploadingTimeText");
			timeStampLabel = timeStampLabel.replace("{0}", rElapsed);
			timeStampLabel = timeStampLabel.replace("{1}", remaining);
			var speedInfo = "";
			if(elapsed/1000 >= 20)
			{
				speedHistory.push(currentActualSpeed);
				uploadInfo.speedHistory = speedHistory;
				var getAverageSpeed = function()
				{
					if(speedHistory.length>30)
					{
						while (speedHistory.length > 30) speedHistory.shift();
					}
					var avgSpeed = speedHistory.average();
					if(avgSpeed>0)
					{
						return getLocalizationKeyExternal("BrowserUploaderAdvancedUploadingAverageSpeedText") + $.CrushFTP.formatBytes(avgSpeed) + "/s , ";
					}
					else
						return "";
				}
				speedInfo = $("<div class='speed'>" + getAverageSpeed() + getLocalizationKeyExternal("BrowserUploaderAdvancedUploadingSpeedText") + speed + "</div>");
			}
			else
			{
				speedInfo = $("<div class='speed'>" + getLocalizationKeyExternal("BrowserUploaderAdvancedUploadingSpeedText") + speed + "</div>");
			}

			//Global Progressbar
			globalProgressBar.show();
			var curFileIndex = curFile || elem.index() + 1;
			totalFiles = totalFiles || fileRepo.find("li.formProcessed").length;
			var fileName = unescape(elem.attr("fileName"));
			if(fileName.length>50)
				fileName = fileName.substr(0, 30) + "..." + fileName.substr(fileName.length-15, fileName.length);
			globalProgressBar.find(".time,.speed").remove();
			globalProgressBar.find(".progressbarMain").progressbar({"value" : percentDone}).end()
			.find(".progressBarText").text(uploadStatusLabel).end()
			.find(".uploadInfo").html(window.locale.fileupload.uploading + "<strong>" + fileName + "</strong>, " + curFileIndex + " of " + " total " + totalFiles + " file(s)")
			.after(speedInfo).after(timeStampLabel);

			if(isApplet && appletResult && appletResult.status)
			{
				if(appletResult.status.indexOf("ERROR:") >= 0 || appletResult.status.indexOf("WARN:") >= 0)
				{
					globalProgressBar.find(".uploadInfo").append("<br>" + "<span style='color:red'>" + appletResult.status + "</span>");
				}
				else
					globalProgressBar.find(".uploadInfo").append("<br>" + appletResult.status);
			}

			if(elem.hasClass("appletItem"))
				globalProgressBar.find("a.pause").show();
			else
				globalProgressBar.find("a.pause").hide();

			globalProgressBar.find("a.pause").unbind().click(function(){
				elem.find("a.pause").trigger("click");
				return false;
			});

			globalProgressBar.find("a.skip").unbind().click(function(){
				elem.find("a.cancelUpload").trigger("click");
				return false;
			});

			globalProgressBar.find("a.stop").unbind().click(function(){
				fileRepo.find("a.cancelUploading").trigger("click");
				return false;
			});
		}
	}

	$.CrushFTP.removeGlobalProgressInfo = function(dontHide)
	{
		$.CrushFTP.UploadProgressing = false;
		$.CrushFTP.uploadAllQueued = false;
		if(!dontHide)
			globalProgressBar.fadeOut();
		globalProgressBar.removeData("uploadInfo");
		globalProgressBar.removeData("curFile");
		globalProgressBar.removeData("curFileSize");
		globalProgressBar.removeData("curFileCount");
		$("#mainContent").find("span.refreshButton").trigger("click");
	}

	$.CrushFTP.DNDUploadCallback = function(status, data, button, template){
		if(status == "completed")
		{
			var result = data.result
			button = template.find("a.startUpload");
			if(result && result.responseText)
			{
				var response = result.responseText;
				response = $(response).find("response").text();
				if (response.toLowerCase() != "success")
	            {
	                template.addClass("ui-state-error").removeClass("uploadProgress");
	                template.append("<span class='error'>"+response+"</span>");
	            }
				else
					template.removeClass("ui-state-error uploadProgress").effect("highlight", {}, 2000);
				button.addClass("uploaded");
			}
			else {
				template.removeClass("uploadProgress").addClass("ui-state-error").append("<span class='error'>File upload failed, please try again.</span>");
				button.addClass("uploaded");
			}
		}
		else if(status == "uploading")
		{
			$.CrushFTP.UploadProgressing = true;
			template.addClass("uploadProgress").find(".error, .uploadStatus").remove();
			$.CrushFTP.refreshProgressInfo(template);
			var startBtn = template.find("a.startUpload").hide();
			template.find("a.editForm").parent().hide();
			if(template.hasClass("appletItem"))
			{
				template.find("a.pause").parent().show();
			}
			template.find("div.progressInfo").show();
		}
		else if(status == "skipped")
		{
			template.removeClass("uploadProgress curQueue").addClass("skipped").find("a.startUpload").text(locale.fileupload.reupload).show();
			if(template.data("formData"))
				template.find("a.editForm").parent().show();
			template.find("a.pause").parent().hide();
			template.find("div.progressInfo").hide();
			if($.CrushFTP.uploadAllQueued)
			{
				var btn = $.CrushFTP.getNextQueuedItem();
				if(btn)
				{
					$.CrushFTP.UploadProgressing = false;
					btn.trigger("click", [{allInQueue:true}]);
				}
				else
				{
					$.CrushFTP.removeGlobalProgressInfo(true);
				}
			}
			else
			{
				$.CrushFTP.removeGlobalProgressInfo(true);
			}

			if(fileRepo.find("li.uploaded").length>0)
				clearUploadedAll.show();
			else
				clearUploadedAll.hide();
		}
		else if(status == "paused")
		{
			$.CrushFTP.UploadProgressing = true;
			//template.removeClass("uploadProgress");
			template.find("div.progressInfo").find("div.time, div.speed").remove().end().append("<div class='status'>"+getLocalizationKeyExternal("BrowserUploaderSelectedFilePausedStatusText")+"</div>");
		}
	}

	$.CrushFTP.getUploadProgress = function(callBack, elem, applet){
		var curData = $(elem).data("uploadInfo");
		if(!curData)
			curData = {part1 : 0, part2 : 0, status : "", history : new Array()};
		if(applet)
		{
			if(elem.attr("status") == "paused")
			{
				return "paused";
			}
			var result = runAppletCommand(true, "COMMAND=ACTION:::TYPE=UPLOAD:::ACTION=STATUS");
			var o = parseJavaProps(result);
			o.isApplet = true;
			if(typeof o.status == "string" && o.status.length == 0)
			{
				o.status = " ";
			}
			if (!o || !o.status || o.status.toUpperCase().indexOf("CANCELLED:") == 0)
			{
				//If file upload/download is cancelled
				o.status= "cancelled";
			}
			else
			{
				o.part1 = o.transferedBytes * 1;
				o.part2 = o.totalBytes * 1;
			}
			if (o.part1 < o.part2)
			{
				o.statusApplet = "uploading";
			}
			else {
				if (status && status.indexOf("ERROR") >= 0) {
					//If error while upload/download
					o.statusApplet = "error";
				} else {
					//If file upload/download completed
					o.statusApplet = "completed";
				}
			}
			curData = $.extend(curData, o);
			$(elem).data("uploadInfo", curData);
			callBack(curData);
		}
		else
		{
			var fileName = $(elem).attr("uid");
			$.ajax({
				type: "POST",
				url: $.CrushFTP.Options.ajaxCallURL,
				data: "command=getUploadStatus&itemName=" + encodeURIComponent(fileName),
				success: function (response) {
					var responseData = response;
					if (responseData == null) responseData = "";
					responseData = $.CrushFTP.getActionResponseText(responseData);
					responseData = jQuery.trim(responseData.toString());
					var o = {};
					o.status = "uploading";
					if (responseData.indexOf("PROGRESS:") >= 0) {
						var part1 = curData.part1 = responseData.substring("PROGRESS:".length, responseData.indexOf("/"));
						var part2 = curData.part2 = responseData.substring(responseData.indexOf("/") + 1, responseData.indexOf(";"));
						part1 = part1 * 1;
						part2 = part2 * 1;
						o.part1 = part1;
						o.part2 = part2;
					} else if (responseData.indexOf("DONE:") >= 0) {
						o.status = "completed";
					} else if (responseData == "null" || responseData == "") { //too quick, upload hasn't started up yet.
						o.status = "starting";
					} else if (responseData.indexOf("ERROR:") >= 0) {
						o.status = "error";
						o.message = responseData;
					} else {
						o.status = "error";
						o.message = responseData;
					}
					curData = $.extend(curData, o);
					$(elem).data("uploadInfo", curData);
					callBack(curData);
				},
				error: function (XMLHttpRequest, textStatus, errorThrown) {
					var o = {};
					o.status = "error";
					o.message = getLocalizationKeyExternal("BrowserUploaderProblemWhileTransferMsgText");
					curData = $.extend(curData, o);
					$(elem).data("uploadInfo", curData);
					callBack(curData);
					callBack(o);
				}
			});
		}
	}

	$("#hideFileQueue").click(function(){
		$("#droppedFiles").hide();
		return false;
	});
});