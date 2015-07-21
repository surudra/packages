/*!
* CrushFTP Web GUI interface methods for Manage Shares
*
* Copyright @ SoftwareAG
*
*/

$(document).ready(function(){
	crushFTP.UI.initLoadingIndicator();
	crushFTP.userLogin.bindUserName(function (response, username) {
		crushFTP.UI.showLoadingIndicator({});
		$("#tempAccounts").form();
		css_browser_selector(navigator.userAgent);
		$(".button").button();
		if (response == "failure") {
			window.location = "/WebInterface/login.html?link=/WebInterface/ManageShares/index.html";
		} else {
			manageShares.init();
		}
	});
});

var manageShares = {
	ajaxCallURL : "/WebInterface/function/",
	ajaxCallURLBase : "/WebInterface/function/",
	columnNames : {

	},
	init : function()
	{
		manageShares.externalShareItemDetails = $("#externalShareItemDetails").dialog({
		    title : "Share details : ",
		    width : "70%",
		    buttons: { "OK": function() { $(this).dialog("close"); } },
			modal : true,
			autoOpen : false,
			resizable : false,
			open : function() {
				manageShares.externalShareItemDetails.dialog({closeOnEscape : true});
				var emailpnlHeight = $(this).find("#emailInfoPanel").height();
				if(emailpnlHeight>400)
					$("#pathList").find("ul").css("max-height", emailpnlHeight-200 + "px");
				else
					$("#pathList").find("ul").css("max-height", "250px");
				showNextPrevOnPopup();
			}
		});

		var selectSimilarTitle = "Select Matching Accounts : ";
		var comfirmOk = "OK";
		var confirmCancel = "Cancel";
		if(window.localizations)
		{
			if(localizations.ManageShareWindowSelectSimilarTitleText)
				selectSimilarTitle = localizations.ManageShareWindowSelectSimilarTitleText;
			if(localizations.ManageShareWindowRemoveConfirmOkText)
				comfirmOk = localizations.ManageShareWindowRemoveConfirmOkText;
			if(localizations.ManageShareWindowRemoveConfirmCancelText)
				confirmCancel = localizations.ManageShareWindowRemoveConfirmCancelText;
			if(localizations.ManageShareWindowPageTitle)
				document.title = localizations.ManageShareWindowPageTitle;
		}
		manageShares.selectSimilarPopup = $("#selectSimilar").dialog({
		    title : selectSimilarTitle,
		    width : "400px",
		    buttons: [{ text : comfirmOk,
		    			click:  function() {
					    	var column = manageShares.selectSimilarPopup.find("#columnToSelect").attr("_column");
					    	var text = manageShares.selectSimilarPopup.find("#matchColumnData").val();
					    	if(column == "emailTo")
					    		text = text.split("\n").join(",");
					    	else if(column == "paths")
					    		text = text.split("\n").join(",");
					    	manageShares.findSimilar(column, text.toLowerCase(), manageShares.selectSimilarPopup.find("#exactMatch").is(":checked"));
					    }
					  },{
					  	text : confirmCancel,
					  	click : function(){ $(this).dialog("close"); }
					  }],
			modal : true,
			autoOpen : false,
			resizable : false,
			open : function() {

			},
			close : function(){
				setTimeout(function(){
					if(manageShares.internalShareItemDetails.dialog("isOpen"))
					{
						manageShares.internalShareItemDetails.dialog({closeOnEscape : true});
					}
					else if(manageShares.externalShareItemDetails.dialog("isOpen"))
					{
						manageShares.externalShareItemDetails.dialog({closeOnEscape : true});
					}
				}, 300);
			}
		});

		manageShares.externalShareItemDetails.find("div.shareItem").hover(function () {
			$(this).addClass("highlight");
		}, function () {
			$(this).removeClass("highlight");
		});

		manageShares.externalShareItemDetails.find("a.nextShare, a.prevShare").click(function(){
			if($(this).hasClass("disabled"))
				return false;
			if($(this).is(".nextShare"))
			{
				if(manageShares.curShownItem.next().is(":visible"))
					manageShares.showDetails(manageShares.curShownItem.next());
				else
					manageShares.showDetails(manageShares.curShownItem.nextAll(":visible:first"));
			}
			else
			{
				if(manageShares.curShownItem.prev().is(":visible"))
					manageShares.showDetails(manageShares.curShownItem.prev());
				else
					manageShares.showDetails(manageShares.curShownItem.prevAll(":visible:first"));
			}
			return false;
		});

		manageShares.externalShareItemDetails.find(".findSimilar").remove();
		manageShares.externalShareItemDetails.find(".shareItem").each(function(){
			$(this).prepend('<a tabindex="-1" class="findSimilar" title="Find Similar" href="#"></a>');
		});

		manageShares.externalShareItemDetails.find(".findSimilar").click(function(){
			manageShares.selectSimilarFromTable($(this));
			return false;
		});

		function showNextPrevOnPopup(isInternal)
		{
			var parentElem;
			if(isInternal)
				parentElem = manageShares.internalShareItemDetails;
			else
				parentElem = manageShares.externalShareItemDetails;

			var curElem = manageShares.curShownItem;
			if(curElem && curElem.length>0)
			{
				if(curElem.prevAll(":visible:first").length>0)
					parentElem.find("a.prevShare").removeClass("disabled");
				else
					parentElem.find("a.prevShare").addClass("disabled");

				if(curElem.nextAll(":visible:first").length>0)
					parentElem.find("a.nextShare").removeClass("disabled");
				else
					parentElem.find("a.nextShare").addClass("disabled");
			}
		}

		manageShares.internalShareItemDetails = $("#internalShareItemDetails").dialog({
		    title : "Share details : ",
		    width : "40%",
		    buttons: { "OK": function() { $(this).dialog("close"); } },
			modal : true,
			autoOpen : false,
			resizable : false,
			open : function() {
				showNextPrevOnPopup(true);
				manageShares.internalShareItemDetails.dialog({closeOnEscape : true});
			}
		});

		manageShares.internalShareItemDetails.find("div.shareItem").hover(function () {
			$(this).addClass("highlight");
		}, function () {
			$(this).removeClass("highlight");
		});

		manageShares.internalShareItemDetails.find("a.nextShare, a.prevShare").click(function(){
			if($(this).hasClass("disabled"))
				return false;
			if($(this).is(".nextShare"))
			{
				manageShares.showDetails(manageShares.curShownItem.next());
			}
			else
				manageShares.showDetails(manageShares.curShownItem.prev());
			return false;
		});
		manageShares.internalShareItemDetails.find(".findSimilar").remove();
		manageShares.internalShareItemDetails.find(".shareItem").each(function(){
			$(this).prepend('<a tabindex="-1" class="findSimilar" title="Find Similar" href="#"></a>');
		});

		manageShares.internalShareItemDetails.find(".findSimilar").click(function(){
			manageShares.selectSimilarFromTable($(this));
			return false;
		});

		manageShares.applyCustomizations(function(){
			manageShares.fetchShareRecords();
		})

		var chkBoxAllManageShares = $("#chkBoxAllManageShares").change(function(){
			if($(this).is(":checked"))
			{
				$("#sharesTable").find("tbody").find("input.chkBox").attr("checked", "checked");
			}
			else
			{
				$("#sharesTable").find("tbody").find("input.chkBox").removeAttr("checked");
			}
		});

		$(document).bind('keydown', 'left', function (evt){
            if(manageShares.internalShareItemDetails.dialog("isOpen"))
            {
            	manageShares.internalShareItemDetails.find("a.prevShare:first").trigger("click");
            }
            else if(manageShares.externalShareItemDetails.dialog("isOpen"))
            {
            	manageShares.externalShareItemDetails.find("a.prevShare:first").trigger("click");
            }
        });

		$(document).bind('keydown', 'right', function (evt){
            if(manageShares.internalShareItemDetails.dialog("isOpen"))
            {
            	manageShares.internalShareItemDetails.find("a.nextShare:first").trigger("click");
            }
            else if(manageShares.externalShareItemDetails.dialog("isOpen"))
            {
            	manageShares.externalShareItemDetails.find("a.nextShare:first").trigger("click");
            }
        });

		//Delayed call of repeatative method, it will ignore all events untill specified event has completed
        var delay = (function () {
            var timer = 0;
            return function (callback, ms) {
                clearTimeout(timer);
                timer = setTimeout(callback, ms);
            };
        })();

        var filterAvailableShares = $("#filterShares").unbind("keyup").keyup(function (evt) {
			var evt = (evt) ? evt : ((event) ? event : null);
			var keyCode = evt.keyCode || evt.which;
			if(keyCode == 27)
				$(this).val("");
			var phrase = $.trim(this.value);
			if (manageShares.last_searched && manageShares.last_searched === phrase) {
				return false;
			}
			delay(function(){
				manageShares.last_searched = phrase;
				manageShares.filterShares(phrase);
			}, 500);
		});

		$("#clearFilter").click(function(){
			filterAvailableShares.val("").trigger("keyup");
			return false;
		});

		$("#refreshBtn").click(function(){
			manageShares.fetchShareRecords();
		});

		var deleteSelectedShares = $("#deleteSelectedShares").click(function(evt, data){
			var deleteIds = "";
			var totalItems = 0;
			if(!data)
			{
				$("#sharesTable").find("tbody").find("input.chkBox:checked:visible").each(function(){
					var dataItem = $(manageShares.shareData[$(this).closest("tr").attr("_index")]);
					if(dataItem && dataItem.length>0)
					{
						if (dataItem.find("usernameShare").text() == "true") deleteIds += dataItem.find("username").text()+":"+dataItem.find("paths").text()+";";
						else deleteIds += dataItem.find("username").text() + ";";
						totalItems += 1;
					}
				});
			}
			else
			{
				totalItems = 1;
				deleteIds = data;
			}
			if(totalItems>0)
			{

				var confirmMsg = "Are you sure you wish to delete selected " + totalItems + " share account(s)?";
				if(data)
					confirmMsg = "Are you sure you wish to delete this share account?";
				var confirmTitle = "Confirm";
				var comfirmOk = "OK";
				var confirmCancel = "Cancel";
				if(window.localizations)
				{
					confirmMsg = localizations.ManageShareWindowDeleteAccountConfirmationText.replace("{count}", totalItems);
					if(localizations.ManageShareWindowRemoveConfirmTitleText)
						confirmTitle = localizations.ManageShareWindowRemoveConfirmTitleText;
					if(localizations.ManageShareWindowRemoveConfirmOkText)
						comfirmOk = localizations.ManageShareWindowRemoveConfirmOkText;
					if(localizations.ManageShareWindowRemoveConfirmCancelText)
						confirmCancel = localizations.ManageShareWindowRemoveConfirmCancelText;
				}
				jConfirm(confirmMsg, confirmTitle, function(flag){
					if(flag)
					{
						var obj = {
							command: "deleteTempAccount",
							tempUsername: deleteIds,
							random: Math.random()
						};
						$.ajax({
							type: "POST",
							url: "/WebInterface/function/",
							data: obj,
							error: function (XMLHttpRequest, textStatus, errorThrown) {
								errorThrown = errorThrown || "deleteTempAccount failed";
								//manageShareAlert("(Error : " + errorThrown + ")", "red");
							},
							success: function (msg) {
								var items = $.xml2json(msg, true);
								if (items["tempUsername"] && items["tempUsername"].length > 0) {
									var curItem = items["tempUsername"][0];
									var curItemsStr = "";
									for (var x=0; x<curItem.text.split(";").length; x++)
									{
										curItemsStr += curItem.text.split(";")[x] + " ";
									}
									//manageShareAlert(getLocalizationKey("ManageShareWindowUserDeletedMessageText").replace("{name}", curItemsStr), "green", 3000);
								}
								if(manageShares.internalShareItemDetails.dialog("isOpen"))
					            {
					            	manageShares.internalShareItemDetails.dialog("close")
					            }
					            else if(manageShares.externalShareItemDetails.dialog("isOpen"))
					            {
					            	manageShares.externalShareItemDetails.dialog("close")
					            }
					            if(data)
					            {
					            	crushFTP.UI.growl("Message : ", "Total " + totalItems + " account(s) deleted!", false, 3000);
					            }
								manageShares.fetchShareRecords();
							}
						});
					}
				},{
					okButtonText : comfirmOk,
					cancelButtonText : confirmCancel
				});
			}
			return false;
		});

		$(".deleteShareItem").click(function(){
			deleteSelectedShares.trigger("click", [manageShares.curShownItem.attr("_deleteIds")]);
			return false;
		});

		$("#sharesTable").tablesorter({
			headers: {
            	0: {
                	sorter: false
            	}
            }
		});
		manageShares.applyLocalizations();
	},
	applyLocalizations : function(){
		if(window.localizations)
		{
			$("[_loc]").each(function(){
				if(window.localizations[$(this).attr("_loc")])
				{
					$(this).text(window.localizations[$(this).attr("_loc")]);
				}
			});
		}
		$(".shareItem").find("[rel]").each(function(){
			manageShares.columnNames[$(this).attr("rel")] = $(this).closest(".shareItem").find("label").text();
		});
		var title;
		if(window.localizations)
		{
			title = localizations.ManageShareWindowShareDetailsLabelText;
			if(title)
				manageShares.externalShareItemDetails.dialog({title:title});
		}

	},
	highlightSelected : function()
	{
		var allChecked=true;
		$("#sharesTable").find("tbody").find("input.chkBox").each(function(){
			if($(this).is(":checked"))
			{
				$(this).closest("tr").find("td").addClass("ui-state-focus");
			}
			else
			{
				allChecked = false;
				$(this).closest("tr").find("td").removeClass("ui-state-focus");
			}
		});
		if(allChecked)
			$("#chkBoxAllManageShares").attr("checked", "checked");
		else
			$("#chkBoxAllManageShares").removeAttr("checked");
	},
	selectSimilarFromTable  : function(el)
	{
		var dataItem = $(manageShares.shareData[manageShares.curShownItem.attr("_index")]);
		manageShares.selectSimilarPopup.find("#matchColumnData").val("");
		if(dataItem && dataItem.length>0)
		{
			var column = el.parent().find("[rel]").attr("rel");
			var columnName = column;
			if(manageShares.columnNames[column])
				columnName = manageShares.columnNames[column];
			var text = dataItem.find(column).text();
			if(column == "emailTo")
				text = text.split(",").join("\n");
			else if(column == "paths")
				text = text.split("\r\n").join("\n");
			manageShares.selectSimilarPopup.find("#columnToSelect").text(columnName).attr("_column", column);
			manageShares.selectSimilarPopup.find("#matchColumnData").val(text);
			manageShares.selectSimilarPopup.dialog("open");

			if(manageShares.internalShareItemDetails.dialog("isOpen"))
			{
				manageShares.internalShareItemDetails.dialog({closeOnEscape : false});
			}
			else if(manageShares.externalShareItemDetails.dialog("isOpen"))
			{
				manageShares.externalShareItemDetails.dialog({closeOnEscape : false});
			}
		}
	},
	findSimilar : function(column, text, exact)
	{
		var sharesTable = $("#sharesTable");
		var matchingElems = [];
		var data = manageShares.shareData;
		for(var i=0;i<data.length;i++)
		{
			if(column=="paths")
			{
				if(exact)
				{
					if($(data[i]).find(column).text().toLowerCase().split("\r\n").join(",") == text)
						matchingElems.push(i);
				}
				else
				{
					if($(data[i]).find(column).text().toLowerCase().split("\r\n").join(",").indexOf(text)>=0)
						matchingElems.push(i);
				}
			}
			else
			{
				if(exact)
				{
					if($(data[i]).find(column).text().toLowerCase() == text)
						matchingElems.push(i);
				}
				else
				{
					if($(data[i]).find(column).text().toLowerCase().indexOf(text)>=0)
						matchingElems.push(i);
				}
			}
		}
		sharesTable.find("tbody").find("tr").show().find("input.chkBox").removeAttr("checked").trigger("change");
		$("#filterMatch").text("");
		if(matchingElems.length>0)
		{
			for(var i=0;i<matchingElems.length;i++)
			{
				sharesTable.find("tr[_index='"+matchingElems[i]+"']").find("input.chkBox").attr("checked", "checked").trigger("change");
			}
			crushFTP.UI.growl("Message : ", "Total " + matchingElems.length + " matching accounts found and selected", false, 3000);
			manageShares.selectSimilarPopup.dialog("close");
			manageShares.internalShareItemDetails.dialog("close");
			manageShares.externalShareItemDetails.dialog("close");
		}
		else
		{
			crushFTP.UI.growl("Message : ", "No matching accounts found", true, 3000);
		}
	},
	filterShares : function(phrase){
		var sharesTable = $("#sharesTable");
		if(phrase && phrase.length>0)
		{
			phrase = phrase.toLowerCase();
			var matchingElems = [];
			var data = manageShares.shareData;
			for(var i=0;i<data.length;i++)
			{
				if($(data[i]).text().toLowerCase().indexOf(phrase)>=0)
					matchingElems.push(i);
			}
			sharesTable.find("tbody").find("tr").hide();
			$("#filterMatch").text("");
			if(matchingElems.length>0)
			{
				for(var i=0;i<matchingElems.length;i++)
				{
					sharesTable.find("tr[_index='"+matchingElems[i]+"']").show()
				}
				$("#filterMatch").text("Matches " + matchingElems.length + " items from ");
			}
			else
			{
				$("#filterMatch").html("No matches found for : " + phrase + " &nbsp;&nbsp;&nbsp;");
			}
		}
		else
		{
			sharesTable.find("tbody").find("tr").show();
			$("#filterMatch").text("");
		}
	},
	showDetails : function(elem)
	{
		var _index = elem.attr("_index");
		if(manageShares.shareData && manageShares.shareData.length>_index)
		{
			var dataElem = $(manageShares.shareData[_index]);
			var isInternalShare = manageShares.getColumnText(dataElem, "usernameShare") == "true";
			if(isInternalShare)
			{
				manageShares.internalShareItemDetails.find("[rel]").each(function(){
					var key = $(this).attr("rel");
					if(key=="paths")
					{
						var paths = manageShares.getColumnText(dataElem, key).split("\r\n");
						var items = [];
						for(var i=0;i<paths.length;i++)
						{
							var curFile = $.trim(paths[i]);
							if(curFile.length>0)
								items.push("<li>"+unescape(curFile)+"</li>");
						}
						if(items.length>0)
						{
							$(this).empty().append("<ul class='pathlist'>"+items.join("")+"</ul>");
						}
						else
							$(this).empty().append("-");
					}
					else
						$(this).empty().html(manageShares.getColumnText(dataElem, key, true));
				});
				manageShares.curShownItem = elem;
				manageShares.externalShareItemDetails.dialog("close");
				manageShares.internalShareItemDetails.dialog("close");
				manageShares.internalShareItemDetails.dialog("open");
			}
			else
			{
				manageShares.externalShareItemDetails.find("[rel]").each(function(){
					var key = $(this).attr("rel");
					if(key=="paths")
					{
						var paths = manageShares.getColumnText(dataElem, key).split("\r\n");
						var items = [];
						for(var i=0;i<paths.length;i++)
						{
							var curFile = $.trim(paths[i]);
							if(curFile.length>0)
								items.push("<li>"+unescape(curFile)+"</li>");
						}
						if(items.length>0)
						{
							$(this).empty().append("<ul class='pathlist'>"+items.join("")+"</ul>");
						}
						else
							$(this).empty().append("-");
					}
					else if(key == "emailTo" || key == "emailCc" || key == "emailBcc" || key == "emailFrom")
					{
						var emails = manageShares.getColumnText(dataElem, key).split(",");
						var items = [];
						for(var i=0;i<emails.length;i++)
						{
							var curItem = $.trim(emails[i]);
							if(curItem.length>0)
								items.push("<li>"+unescape(curItem)+"</li>");
						}
						if(items.length>0)
						{
							$(this).empty().append("<ul class='emailList'>"+items.join("")+"</ul>");
						}
						else
							$(this).empty().append("-");
					}
					else
						$(this).empty().html(manageShares.getColumnText(dataElem, key, true));
				});
				manageShares.curShownItem = elem;
				manageShares.internalShareItemDetails.dialog("close");
				manageShares.externalShareItemDetails.dialog("close");
				manageShares.externalShareItemDetails.dialog("open");
			}
		}
	},
	applyCustomizations : function(callback){
		crushFTP.UI.showLoadingIndicator({});
		crushFTP.data.serverRequest({
			command: "getUserInfo",
			random: Math.random()
		}, function(data){
			var items = [];
			if(data && $(data).find("customizations_subitem"))
			{
				var toConsider = ["manageShare_HeaderBGColor","manageShare_HeaderTextColor","manageShare_HeaderBorderColor", "manageShare_BGColor","manageShare_Color","manageShare_TableHeaderBgColor","manageShare_TableHeaderColor","manageShare_TableHeaderBorderColor","manageShare_TableRowBGColor","manageShare_TableRowColor","manageShare_TableRowHoverBGColor","manageShare_TableRowHoverColor","manageShare_TableRowHoverBorderColor"];
				crushFTP.UI.hideLoadingIndicator({});
				$(data).find("customizations_subitem").each(function(index){
					var curRow = $(this);
					var key = manageShares.getColumnText(curRow, "key");
					var val = manageShares.getColumnText(curRow, "value");
					if(toConsider.has(key))
					{
						switch (key)
						{
							case "manageShare_HeaderBGColor":
								$.cssRule({
									"div.ui-widget-header": [
										["background", val +" !important"]
										]
								});
								break;
							case "manageShare_HeaderTextColor":
								$.cssRule({
									"#GUIAdmin .ui-widget-header": [
										["color", val +" !important"]
										]
								});
								break;
							case "manageShare_HeaderBorderColor":
								$.cssRule({
									"#GUIAdmin div.ui-widget-header": [
										["border-color", val +" !important"]
										]
								});
								break;
							case "manageShare_BGColor":
								$.cssRule({
									"#GUIAdmin, #externalShareItemDetails, .ui-dialog, div.ui-widget-content, button.ui-state-default": [
										["background", val +" !important"]
										]
								});
								break;
							case "manageShare_Color":
								$.cssRule({
									"#GUIAdmin, #GUIAdmin a, #GUIAdmin label, #GUIAdmin span, #GUIAdmin p, #externalShareItemDetails, .ui-dialog, button.ui-state-hover": [
										["color", val + " !important"]
										]
								});
								break;
							case "manageShare_TableHeaderBgColor":
								$.cssRule({
									"#sharesTable th": [
										["background", val]
										]
								});
								break;
							case "manageShare_TableHeaderColor":
								$.cssRule({
									"#sharesTable th": [
										["color", val]
										]
								});
								break;
							case "manageShare_TableHeaderBorderColor":
								$.cssRule({
									"#sharesTable th": [
										["border-color", val]
										]
								});
								break;
							case "manageShare_TableRowBGColor":
								$.cssRule({
									"#sharesTable tbody tr td": [
										["background", val + ""]
										]
								});
								break;
							case "manageShare_TableRowColor":
								$.cssRule({
									"#sharesTable tbody td": [
										["color", val + ""]
										]
								});
								break;
							case "manageShare_TableRowHoverBGColor":
								$.cssRule({
									"#sharesTable .hovered, .ui-state-highlight, .shareItemDetailsPanel .highlight": [
										["background", val + " !important"]
										]
								});
								break;
							case "manageShare_TableRowHoverColor":
								$.cssRule({
									"#sharesTable .hovered.clickable, #sharesTable .hovered, .ui-state-highlight, .shareItemDetailsPanel .highlight": [
										["color", val + " !important"]
										]
								});
								break;
							case "manageShare_TableRowHoverBorderColor":
								$.cssRule({
									"#sharesTable .hovered.clickable, #sharesTable .hovered, .ui-state-highlight, .shareItemDetailsPanel  .highlight": [
										["border-color", val + " !important"]
										]
								});
								break;
							default:
								break;
						}
					}
				});
				if(callback)
					callback();
			}
		});
	},
	fetchShareRecords : function(){
		crushFTP.UI.showLoadingIndicator({});
		crushFTP.data.serverRequest({
			command: "manageShares",
			random: Math.random()
		}, function(data){
			var items = [];
			if(data && $(data).find("listingInfo_subitem"))
			{
				manageShares.shareData = $(data).find("listingInfo_subitem");
				$(data).find("listingInfo_subitem").each(function(index){
					var curRow = $(this);
					var isInternalShare = manageShares.getColumnText(curRow, "usernameShare") == "true";
					var deleteIds = "";
					if (curRow.find("usernameShare").text() == "true")
						deleteIds += curRow.find("username").text()+":"+curRow.find("paths").text()+";";
					else
						deleteIds += curRow.find("username").text() + ";";
					items.push("<tr _index='"+index+"' _deleteIds='"+crushFTP.methods.htmlEncode(deleteIds)+"'>");
					items.push('<td class="ui-state-default center"><input type="checkBox" class="chkBox" /></td>');
					if(window.localizations && window.localizations.ManageShareDateFormatDDMMYYYY)
					{
						var createdDate = manageShares.getColumnText(curRow, "created");
						if(createdDate.indexOf("/")>=0)
						{
							var splitDate = createdDate.split("/");
							if(splitDate.length==3)
								createdDate = splitDate[1] + '/' + splitDate[0] + '/' + splitDate[2];
						}
						var expireDate = manageShares.getColumnText(curRow, "expire");
						if(expireDate.indexOf("/")>=0)
						{
							var splitDate = expireDate.split("/");
							if(splitDate.length==3)
								expireDate = splitDate[1] + '/' + splitDate[0] + '/' + splitDate[2];
						}
						items.push('<td class="ui-state-default clickable" _column="created"><div class="nowrap">'+createdDate+'</div></td>');
						items.push('<td class="ui-state-default clickable" _column="expire"><div class="nowrap">'+expireDate+'</div></td>');
					}
					else
					{
						items.push('<td class="ui-state-default clickable" _column="created"><div class="nowrap">'+manageShares.getColumnText(curRow, "created")+'</div></td>');
						items.push('<td class="ui-state-default clickable" _column="expire"><div class="nowrap">'+manageShares.getColumnText(curRow, "expire")+'</div></td>');
					}

					var emailTo = "";
					var emails = manageShares.getColumnText(curRow, "emailTo").split(",");
					if(emails.length>3)
					{
						var remained = emails.length-3;
						emailTo = unescape(emails[0]) + "<br>" + unescape(emails[1]) + "<br>" + unescape(emails[2]) + " <span class='fewMore'> ... and <strong>" + remained + "</strong> more...</span>";
					}
					else
						emailTo = unescape(emails.join("<br>"));

					items.push('<td class="ui-state-default clickable" _column="emailTo">'+emailTo+'</td>');
					var pathsText = "";
					var paths = manageShares.getColumnText(curRow, "paths").split("\r\n");
					if(paths.length>3)
					{
						var remained = paths.length-3;
						pathsText = unescape(paths[0]) + "<br>" + unescape(paths[1]) + "<br>" + unescape(paths[2]) + " <span class='fewMore'> ... and <strong>" + remained + "</strong> more...</span>";
					}
					else
						pathsText = unescape(paths.join("<br>"));
					items.push('<td class="ui-state-default clickable" _column="paths">'+pathsText+'</td>');
					items.push('<td class="ui-state-default center clickable" _column="downloads">'+manageShares.getColumnText(curRow, "downloads")+'</td>');
					items.push("</tr>");
				});
			}
			else
				manageShares.shareData = false;
			var sharesTable = $("#sharesTable");
			if(manageShares.shareData)
			{
				$("#totalCount").text(manageShares.shareData.length);
			}
			sharesTable.find("tbody").empty().append(items.join("\r\n"));
			sharesTable.trigger("update");

			sharesTable.find("tbody tr").hover(function(){
				$(this).find("td").addClass("ui-state-highlight");
			}, function(){
				$(this).find("td").removeClass("ui-state-highlight hovered");
			});

			sharesTable.find("tbody td.clickable").hover(function(){
				$(this).addClass("hovered");
			}, function(){
				$(this).removeClass("hovered");
			});

			//$("#sharesTable").fixedHeaderTable();
			crushFTP.UI.hideLoadingIndicator({});
			sharesTable.find("td").click(function(evt){
				if($(this).is(".clickable"))
				{
					if(evt.button != 2 && !evt.ctrlKey && !$("#rowContextMenu").is(":visible"))
						manageShares.showDetails($(this).parent());
				}
				else
				{
					if($(this).find("input").is(":checked"))
						$(this).find("input").removeAttr("checked").trigger("change");
					else
						$(this).find("input").attr("checked", "checked").trigger("change");
				}
			});
			$("#chkBoxAllManageShares").trigger("change");
			sharesTable.find("input").click(function(evt){
				evt.stopPropagation();
			}).change(function(){
				manageShares.highlightSelected();
			});
			var contextMenu = sharesTable.find("td.clickable").contextMenu({
					menu: "rowContextMenu",
					inSpeed : 0,
					outSpeed : 0
				},
				function(action, el, pos) {
					if(action == "similar")
					{
						var dataItem = $(manageShares.shareData[$(el).closest("tr").attr("_index")]);
						manageShares.selectSimilarPopup.find("#matchColumnData").val("");
						if(dataItem && dataItem.length>0)
						{
							var column = el.attr("_column");
							var columnName = manageShares.columnNames[column];
							var text = dataItem.find(column).text();
							if(column == "emailTo")
								text = text.split(",").join("\n");
							else if(column == "paths")
								text = text.split("\r\n").join("\n");
							manageShares.selectSimilarPopup.find("#columnToSelect").text(columnName).attr("_column", column);
							manageShares.selectSimilarPopup.find("#matchColumnData").val(text);
							manageShares.selectSimilarPopup.dialog("open");
						}
					}
					else if(action == "delete")
					{
						$("#deleteSelectedShares").trigger("click", [el.closest("tr").attr("_deleteIds")]);
					}
				}
			);
		});
	},
	getColumnText : function(row, column, flag)
	{
		var text = row.find("" + column).text();
		if(flag)
		{
			if(text == "true") text = "Yes";
			if(text == "false") text = "No";
		}
		return text;
	}
};

window.applyLocalizations = function(){}