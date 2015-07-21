/****************************
CrushFTP GUI Panel custom js
*****************************/
/* Do not change these lines */
var panelAccounts = {};
panelAccounts.localization = {};
/****************************/

// Panel details
panelAccounts.panelName = "Accounts";
panelAccounts._panel = $("#pnl" + panelAccounts.panelName);

// Localizations
panelAccounts.localization = {
};

// Assign localizations
localizations.panels[panelAccounts.panelName] = $.extend(panelAccounts.localization, localizations.panels[panelAccounts.panelName]);

var tempAccountsList = $("#lst_tempAccounts", panelAccounts._panel);
var generalSettingsPanel = $("#generalSettingsPanel", panelAccounts._panel);

// Interface methods
panelAccounts.init = function(){
	applyLocalizations(panelAccounts.panelName, localizations.panels);
	panelAccounts.bindEvents();
	panelAccounts.resizeInfoContent();
	panelAccounts.showHidePanels();
	panelAccounts.bindData();
}

panelAccounts.showHidePanels = function(flag)
{
	if(flag)
	{
		$("#accountDetailsPanel", panelAccounts._panel).show();
		$("#accountsContentTip", panelAccounts._panel).hide();
	}
	else
	{
		$("#accountDetailsPanel", panelAccounts._panel).hide();
		$("#accountsContentTip", panelAccounts._panel).show();
	}
}

panelAccounts.resizeInfoContent = function()
{
	var userInfoContent = $("#AccountsContent", panelAccounts._panel);
	var sideBar = $(".sideBarTempAccounts", panelAccounts._panel);
	var windowWidth = $(window).width();
	windowWidth = windowWidth - sideBar.width() - 115;
	windowWidth = windowWidth < 300 ? 300 : windowWidth;
	userInfoContent.width(windowWidth);
}

panelAccounts.bindEvents = function()
{
	$(window).resize(function () {
		panelAccounts.resizeInfoContent();
	});

	tempAccountsList.unbind("change").bind("change"
	, function(){
		if($(this).find(":selected").length==1)
		{
			panelAccounts.accountSelected($(this), $(this).find(":selected:first"));
		}
		else
		{
			panelAccounts.showHidePanels();
		}
	});

	var filterAccountField = $("#filterAvailableAccounts", panelAccounts._panel).unbind("keyup").keyup(function (evt) {
		var evt = (evt) ? evt : ((event) ? event : null);
		if (evt.keyCode === 27) {
			evt.preventDefault();
			filterAccountField.val("").trigger("keyup");
			return;
		}
		var phrase = this.value;
		if (window.last_searched_c === phrase) {
			return false;
		}
		panelAccounts.bindAccounts(phrase);
		if(tempAccountsList.find(":selected").length==0)
			panelAccounts.showHidePanels();
		window.last_searched_c = phrase;
	});

	$("#clearFilter", panelAccounts._panel).click(function(){
		filterAccountField.val("").trigger("keyup");
		return false;
	});

	$("#reloadAccountsLink", panelAccounts._panel).click(function(){
		panelAccounts.bindData();
		return false;
	});

	$("a.serverFilePickButton", panelAccounts._panel).each(function(){
		$(this).click(function(){
			var curElem = $(this);
			var rel = $("#" + curElem.attr("rel"), panelAccounts._panel);
			curElem.crushFtpVFSBrowserPopup({
				type : curElem.attr("PickType") || 'any',
				allowMultiple : true,
				callback : function(selectedPath){
					if(selectedPath)
					{
						var items = selectedPath.split("\n");
						var files = [];
						for(var i=0;i<items.length;i++)
						{
							var curPath = $.trim(items[i]);
							if(curPath.length>0 && rel.find("option[val='"+curPath+"']").length==0)
							{
								files.push(curPath);
							}
						}
						if(files && files.length>0)
						{
							panelAccounts.filesListingLoadingIndicator(true);
							panelAccounts.addSelectedFilesFromAccount(files, function(){
								panelAccounts.filesListingLoadingIndicator();
								panelAccounts.accountSelected(tempAccountsList, tempAccountsList.find(":selected:first"));
							});
						}
					}
				}
			});
			return false;
		});
	});

	$("#allowUploads", panelAccounts._panel).unbind().change(function(){
		if(panelAccounts.curAccountData && panelAccounts.curAccountData.info)
		{
			panelAccounts.curAccountData.info.allowUploads = $(this).is(":checked");
		}
	});

	$("#expire", panelAccounts._panel).unbind().change(function(){
		if(panelAccounts.curAccountData && panelAccounts.curAccountData.info)
		{
			panelAccounts.curAccountData.info.expire = $(this).datetimepicker("getDate").format("MM/DD/YYYY hh:mm a/p");
		}
	});

	$("#removeFiles", panelAccounts._panel).click(function(){
		panelAccounts.filesListingLoadingIndicator(true);
		panelAccounts.removeSelectedFilesFromAccount(function(){
			panelAccounts.filesListingLoadingIndicator();
		});
		return false;
	});

	$("#linkGeneralSettings", panelAccounts._panel).click(function(){
		generalSettingsPanel.show()
		generalSettingsPanel.find("input:first").focus();
		panelAccounts.resizeInfoContent();
		return false;
	});

	$("#cancelGeneralSettings", panelAccounts._panel).click(function(){
		generalSettingsPanel.slideUp("fast", function(){
			panelAccounts.resizeInfoContent();
		});
		return false;
	});

	$("#saveGeneralSettings", panelAccounts._panel).click(function(){
		panelAccounts.savePrefs();
		return false;
	});

	var createUserDialog = $("#createUserDialog", panelAccounts._panel).form().dialog({
		autoOpen: false,
		width: 500,
		modal: true,
		resizable: false,
		closeOnEscape: false,
		title : "Create new account :",
		buttons: {
			"Cancel" : function(){
				$(this).dialog("close");
			},
			"OK": function() {
				var hasError = false;
				$(".validate", createUserDialog).each(function(){
					if($(this).validateNow())
					{
						hasError = true;
					}
				})
				if(!hasError)
				{
					var uName = $.trim(createUserDialog.find("#username_prompt").val());
					var uPass = $.trim(createUserDialog.find("#userpassword_prompt").val());
					if(tempAccountsList.find("[username='"+uName.toLowerCase()+"']").length>0)
					{
						alert("User already exist, please choose another name");
						createUserDialog.find("#username_prompt").focus();
						return false;
					}
					else
					{
						var dateNow = new Date();
						dateNow = crushFTP.methods.htmlEncode(dateNow.format("MM/DD/YYYY hf:mm"));
						var url = crushFTP.methods.htmlEncode(window.location.protocol + "//" + window.location.host + "/");
						var publishType = createUserDialog.find("input[name='publishType']:checked").val();
						var expDate = $("#expires_prompt", createUserDialog).datetimepicker("getDate");
						var folderName = 'u='+uName+',,p='+uPass+',,m='+$(document).data("username")+',,t=TempAccount,,ex=' + expDate.format("mmddyyyyHHmm");
						var permissions = '(read)(view)(resume)(slideshow)';
						if(createUserDialog.find("#allowUploads_prompt").is(":checked"))
							permissions = '(read)(write)(view)(resume)(slideshow)';
						var saveData = {
							tempaccount_user : uName,
							tempaccount_pass : uPass,
							permissions : '<?xml version="1.0" encoding="UTF-8"?><VFS type="properties"><item name="/">' + permissions + '</item></VFS>',
							info : '<?xml version="1.0" encoding="UTF-8"?><INFO type="properties"><password>'+uPass+'</password><baseUrl>'+url+'</baseUrl><type>text</type><command>publish</command><username>'+uName+'</username><emailBcc></emailBcc><shareUsernamePermissions>'+permissions+'</shareUsernamePermissions><sendEmail>false</sendEmail><emailSubject></emailSubject><created>'+dateNow+'</created><emailTo></emailTo><web_link>'+url+'?u='+uName+'&amp;p='+uPass+'</web_link><publishType>'+publishType+'</publishType><master>'+$(document).data("username")+'</master><emailBody></emailBody><allowUploads>'+createUserDialog.find("#allowUploads_prompt").is(":checked")+'</allowUploads><paths></paths><emailFrom></emailFrom><emailCc></emailCc><expire>'+expDate.format("MM/DD/YYYY hh:mm a/p")+'</expire><attach>false</attach><shareUsernames></shareUsernames><instance></instance><shareUsername>false</shareUsername></INFO>',
							tempaccount_folder : folderName
						};
						createUserDialog.block({
							message:  'Please Wait..',
							css: {
								border: 'none',
								padding: '10px',
								width : '110px',
								backgroundColor: '#000',
								'-webkit-border-radius': '10px',
								'-moz-border-radius': '10px',
								opacity: .5,
								color: '#fff',
								'text-align':'center'
							}
						});
						panelAccounts.addEditTempAccount(saveData, function(flag){
							createUserDialog.unblock();
							if(flag)
							{
								panelAccounts.bindData(function(){
									createUserDialog.dialog("close");
									tempAccountsList.val(uName).trigger("change");
								});
							}
							else
							{
								jAlert("Adding account failed, please try again.", "Failed");
							}
						});
					}
				}
			}
		},
		open : function(){
			var randomNameLength = parseInt($(document).data("GUIXMLPrefs").temp_accounts_length);
			if(!randomNameLength) randomNameLength = 4;
			var uName = crushFTP.methods.generateRandomPassword(randomNameLength);
			var uPass = crushFTP.methods.generateRandomPassword(randomNameLength);
			createUserDialog.find("#username_prompt").val(uName);
			createUserDialog.find("#userpassword_prompt").val(uPass);
			var dateNow = new Date();
			dateNow.setDate(dateNow.getDate()+30);
			var expDate = $("#expires_prompt", createUserDialog).datetimepicker("setDate", dateNow);
		}
	});

	$("#user_generateUser").click(function(){
		var randomNameLength = parseInt($(document).data("GUIXMLPrefs").temp_accounts_length);
		if(!randomNameLength) randomNameLength = 4;
		var uName = crushFTP.methods.generateRandomPassword(randomNameLength);
		createUserDialog.find("#username_prompt").val(uName);
		return false;
	});

	$("#user_generateRandomPass").click(function(){
		var randomNameLength = parseInt($(document).data("GUIXMLPrefs").temp_accounts_length);
		if(!randomNameLength) randomNameLength = 4;
		var uPass = crushFTP.methods.generateRandomPassword(randomNameLength);
		createUserDialog.find("#userpassword_prompt").val(uPass);
		return false;
	});

	$("#addEvent", panelAccounts._panel).click(function(){
		createUserDialog.dialog("open");
		return false;
	});

	$("#saveAccountSettings", panelAccounts._panel).click(function(){
		panelAccounts.saveAccountInfo();
		return false;
	});

	$("#removeEvent", panelAccounts._panel).click(function(){
		var toRemove = [];
		tempAccountsList.find(":selected").each(function(){
			var data = $(this).data("controlData");
			if(data)
			{
				toRemove.push(data);
			}
		});
		if(toRemove.length>0)
		{
			jConfirm("Are you sure you wish to remove selected " + toRemove.length + " account(s)?", "Confirm", function(flag){
				if(flag)
				{
					panelAccounts.accountsToRemove = toRemove;
					panelAccounts.removeAccounts(function(){
						panelAccounts.accountsToRemove = false;
						panelAccounts.bindData();
					});
				}
			})
		}
		else
			crushFTP.UI.growl("Nothing selected to remove", "Select account you want to remove", true, 5000);
		return false;
	});
}

panelAccounts.saveAccountInfo = function()
{
	if(panelAccounts.curAccountData && panelAccounts.curAccountData.info)
	{
		var infoXML = [];
		var notToAdd = ["C","EX","M","P","T"];
		for(var item in panelAccounts.curAccountData.info)
		{
			if(!notToAdd.has(item))
			{
				infoXML.push("<"+item+">"+crushFTP.methods.htmlEncode(panelAccounts.curAccountData.info[item])+"</"+item+">");
			}
		}
		var permissions = '<?xml version="1.0" encoding="UTF-8"?><VFS type="properties"><item name="/">(read)(view)(resume)(slideshow)</item></VFS>';
		if(panelAccounts.curAccountData.info.allowUploads)
			permissions = '<?xml version="1.0" encoding="UTF-8"?><VFS type="properties"><item name="/">(read)(write)(view)(resume)(slideshow)</item></VFS>';
		var saveData = {
			tempaccount_user : panelAccounts.curAccountData.tempaccount_user,
			tempaccount_pass : panelAccounts.curAccountData.tempaccount_pass,
			permissions : permissions,
			info : '<?xml version="1.0" encoding="UTF-8"?><INFO type="properties">'+infoXML.join("\n")+'</INFO>',
			tempaccount_folder : panelAccounts.curAccountData.tempaccount_folder
		};
		var accountDetailsPanel = $("#accountDetailsPanel").block({
			message:  'Please Wait..',
			css: {
				border: 'none',
				padding: '10px',
				width : '110px',
				backgroundColor: '#000',
				'-webkit-border-radius': '10px',
				'-moz-border-radius': '10px',
				opacity: .5,
				color: '#fff',
				'text-align':'center'
			}
		});
		panelAccounts.addEditTempAccount(saveData, function(flag){
			accountDetailsPanel.unblock();
			if(flag)
			{
				panelAccounts.bindData(function(){
					tempAccountsList.val(saveData.tempaccount_user).trigger("change");
				});
			}
			else
			{
				jAlert("Saving account failed, please try again.", "Failed");
			}
		});
}
}

panelAccounts.removeAccounts = function(callback)
{
	var selectedAccounts = panelAccounts.accountsToRemove;
	if(!selectedAccounts || selectedAccounts.length == 0)
	{
		if(callback)
			callback();
		return;
	}
	var curAccount = selectedAccounts[0];
	if(!curAccount)return;
	var obj = {
		command : "removeTempAccount",
		tempaccount_user : curAccount.tempaccount_user,
		tempaccount_pass : curAccount.tempaccount_pass,
		tempaccount_folder : curAccount.tempaccount_folder
	}
	crushFTP.data.serverRequest(obj,
	function(data){
		if(data && typeof $(data).find != "undefined" && $(data).find("response").text().toLowerCase().indexOf("success")>=0)
		{
			selectedAccounts.remove(0);
			panelAccounts.removeAccounts(callback);
		}
	});
}

panelAccounts.savePrefs = function()
{
	crushFTP.UI.showIndicator(false, generalSettingsPanel, "Please wait..");
	var loc = $("#temp_accounts_path").val();
	if(loc.lastIndexOf("/")!=loc.length-1 && loc.lastIndexOf("\\")!=loc.length-1)
	{
		loc = loc + "/";
		$("#temp_accounts_path").val(loc);
	}
	var dataXML = '<server_prefs type="properties">'+tempAccounts.data.buildXMLToSubmitForm(generalSettingsPanel)+'</server_prefs>';
	crushFTP.data.setXMLPrefs("server_settings/server_prefs/"
		, "properties"
		, "update"
		, dataXML
		, function(data){
			data = $.xml2json(data, true);
			if(data.response_status && crushFTP.data.getTextValueFromXMLNode(data.response_status) && crushFTP.data.getTextValueFromXMLNode(data.response_status) == "OK")
			{
				tempAccounts.data.updateLocalPrefs(function(){
					crushFTP.UI.hideIndicator(false, generalSettingsPanel);
					crushFTP.UI.growl("Data saved", "Your changes are saved", false, 5000);
					var prefs = $(document).data("GUIXMLPrefs");
					tempAccounts.data.bindValuesFromJson(generalSettingsPanel, prefs);
					$("#cancelGeneralSettings", panelAccounts._panel).trigger("click");
				});
			}
			else
			{
				crushFTP.UI.growl("Error while saving", "Your changes are not saved", true);
			}
	});
}

panelAccounts.filesListingLoadingIndicator = function(block)
{
	var containedFiles = $("#containedFiles", panelAccounts._panel);
	if(block)
	{
		containedFiles.closest("div").block({
			message:  'Loading..',
			css: {
				border: 'none',
				padding: '10px',
				width : '70px',
				backgroundColor: '#000',
				'-webkit-border-radius': '10px',
				'-moz-border-radius': '10px',
				opacity: .5,
				color: '#fff',
				'text-align':'center'
			}
		});
	}
	else
		containedFiles.closest("div").unblock();
}

panelAccounts.accountsLoadingIndicator = function(block)
{
	var lst_tempAccounts = $("#lst_tempAccounts", panelAccounts._panel);
	if(block)
	{
		lst_tempAccounts.closest("div").block({
			message:  'Loading..',
			css: {
				border: 'none',
				padding: '10px',
				width : '70px',
				backgroundColor: '#000',
				'-webkit-border-radius': '10px',
				'-moz-border-radius': '10px',
				opacity: .5,
				color: '#fff',
				'text-align':'center'
			}
		});
	}
	else
		lst_tempAccounts.closest("div").unblock();
}

panelAccounts.accountSelected = function(list, selectedItem)
{
	var data = selectedItem.data("controlData");
	if(data && data.info){
		panelAccounts.showPrefsData(data.info);
	};
	panelAccounts.curAccountData = data;
	var containedFiles = $("#containedFiles", panelAccounts._panel).empty();
	panelAccounts.filesListingLoadingIndicator(true);
	panelAccounts.getAccountFiles(data, function(filesInfo){
		panelAccounts.filesListingLoadingIndicator();
		var files;
		if(data.info.publishType == "reference")
			files = $(filesInfo).find("refFiles_subitem");
		else
			files = $(filesInfo).find("containedFiles_subitem");
		if(files)
		{
			files.each(function(){
				containedFiles.append("<option val=\""+$(this).text()+"\">"+$(this).text()+"</option>");
			});
		}
	});
}

panelAccounts.getAccountFiles = function(data, callback)
{
	var obj = {
		command : "getTempAccountFiles",
		tempaccount_user : data.tempaccount_user,
		tempaccount_pass : data.tempaccount_pass,
		tempaccount_folder : data.tempaccount_folder
	}
	crushFTP.data.serverRequest(obj,
	function(data){
		if(callback)
			callback(data);
	});
}

panelAccounts.removeSelectedFilesFromAccount = function(callback)
{
	var selectedFile = $("#containedFiles", panelAccounts._panel).find("option:selected:first");
	if(!selectedFile || selectedFile.length == 0)
	{
		if(callback)
			callback();
		return;
	}
	var file = selectedFile.val();
	var data = panelAccounts.curAccountData;
	if(!data || !file)return;
	var obj = {
		command : "removeTempAccountFile",
		tempaccount_user : data.tempaccount_user,
		tempaccount_pass : data.tempaccount_pass,
		tempaccount_folder : data.tempaccount_folder,
		tempaccount_file : file
	}
	crushFTP.data.serverRequest(obj,
	function(data){
		if(data && typeof $(data).find != "undefined" && $(data).find("response").text().toLowerCase().indexOf("success")>=0)
		{
			selectedFile.remove();
			panelAccounts.removeSelectedFilesFromAccount(callback);
		}
	});
}

panelAccounts.addSelectedFilesFromAccount = function(files, callback)
{
	if(!files || files.length == 0)
	{
		if(callback)
			callback();
		return;
	}
	var file = files[files.length - 1];
	var data = panelAccounts.curAccountData;
	var containedFiles = $("#containedFiles", panelAccounts._panel);
	if(!data || !file)return;
	var obj = {
		command : "addTempAccountFile",
		tempaccount_user : data.tempaccount_user,
		tempaccount_pass : data.tempaccount_pass,
		tempaccount_folder : data.tempaccount_folder,
		tempaccount_file : file,
		tempaccount_reference : $("#shareOptions", panelAccounts._panel).find("#publishType").text() == "reference"
	}
	crushFTP.data.serverRequest(obj,
	function(data){
		if(data && typeof $(data).find != "undefined" && $(data).find("response").text().toLowerCase().indexOf("success")>=0)
		{
			containedFiles.append("<option val=\""+file+"\">"+file+"</option>");
			files.remove(files.length - 1);
			panelAccounts.addSelectedFilesFromAccount(files, callback);
		}
	});
}

panelAccounts.addEditTempAccount = function(saveData, callback)
{
	if(!saveData)
	{
		if(callback)
			callback();
		return;
	}
	var obj = {
		command : "addTempAccount",
		tempaccount_user : saveData.tempaccount_user,
		tempaccount_pass : saveData.tempaccount_pass,
		permissions : saveData.permissions,
		info : saveData.info,
		tempaccount_folder : saveData.tempaccount_folder
	}
	crushFTP.data.serverRequest(obj,
	function(data){
		if(data && typeof $(data).find != "undefined" && $(data).find("response").text().toLowerCase().indexOf("success")>=0)
		{
			callback(true);
		}
		else
			callback(false);
	});
}

panelAccounts.showPrefsData = function(data)
{
	if(!data)
	{
		panelAccounts.showHidePanels();
		return;
	}
	else
	{
		panelAccounts.showHidePanels(true);
		data.expire = data.expire.replace("+", " ");
		var dateExpire = new Date(data.expire);
		data.expire = dateExpire.format("MM/DD/YYYY hh:mm a/p");
		tempAccounts.data.bindValuesFromJson($("#accountDetailsPanel", panelAccounts._panel), data);
		/*var shareMethod = data.publishType || "copy";
		if (shareMethod) {
			shareMethod = shareMethod.toLowerCase();
			if (shareMethod == "copy") {
				crushFTP.UI.checkUnchekInput($("#shareOptions", panelAccounts._panel).find("input#chkCopy"), true);
			} else if (shareMethod == "reference") {
				crushFTP.UI.checkUnchekInput($("#shareOptions", panelAccounts._panel).find("input#chkReference"), true);
			} else if (shareMethod == "move") {
				crushFTP.UI.checkUnchekInput($("#shareOptions", panelAccounts._panel).find("input#chkMove"), true);
			}
		}*/
	}
}

panelAccounts.bindData = function(callback)
{
	panelAccounts.accountsLoadingIndicator(true);
	crushFTP.data.serverRequest({
		command: "getTempAccounts",
		random : Math.random()
	},
	function(data){
		panelAccounts.accountsLoadingIndicator();
		var dataJson = $.xml2json(data);
		crushFTP.methods.rebuildSubItems(dataJson, "temp_accounts");
		if(dataJson)
		{
			if(dataJson.temp_accounts_subitem)
				dataJson = dataJson.temp_accounts_subitem;
			panelAccounts.tempAccountsData = dataJson;
			panelAccounts.bindAccounts();
		}
		if(callback)
			callback();
	});
	var prefs = $(document).data("GUIXMLPrefs");
	tempAccounts.data.bindValuesFromJson(generalSettingsPanel, prefs);
}

panelAccounts.bindAccounts = function(filter)
{
	var selectedVal = tempAccountsList.val();
	tempAccountsList.empty();
	if(filter) filter = filter.toLowerCase();
	var dataJson = panelAccounts.tempAccountsData;
	for(var i=0;i<dataJson.length;i++)
	{
		var curItem = dataJson[i];
		if(curItem && curItem.info)
		{
			var info = curItem.info;
			var txtToShow = info.master + " - " + info.created + " - " + info.U + " - " + info.emailTo;
			var newItem = $("<option username='"+info.U.toLowerCase()+"' value='"+info.U+"'>"+ txtToShow +"</option>");
			newItem.data("controlData", curItem);
			if(filter)
			{
				if(txtToShow.toLowerCase().indexOf(filter)>=0)
				{
					tempAccountsList.append(newItem);
				}
			}
			else
			{
				tempAccountsList.append(newItem);
			}
		}
	}
	if(filter)
		$("#accountCountLabel", panelAccounts._panel).text(tempAccountsList.find("option").length + " (filtered) ");
	else
		$("#accountCountLabel", panelAccounts._panel).text(tempAccountsList.find("option").length);
	tempAccountsList.val(selectedVal);
	if(tempAccountsList.find(":selected").length == 0)
	{
		panelAccounts.showHidePanels();
	}
}