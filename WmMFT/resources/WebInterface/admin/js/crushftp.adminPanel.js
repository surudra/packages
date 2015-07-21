/*!
* CrushFTP Web GUI interface methods for User Manager
*
* Copyright @ SoftwareAG
*
*/

window.dataBindEvents = [];

var adminPanel = {
	ajaxCallURL : "/WebInterface/function/",
	ajaxCallURLBase : "/WebInterface/function/",
	refreshInfoInterval : 5000,
	buggyBrowser : $.browser.msie && $.browser.version < 8	,
	UI :
	{
		initEvents : function()
		{
			$(".backToTop", "#GUIAdmin").unbind().click(function () {
				$('html,body').animate({
					scrollTop: 0
				}, 500, false);
				return false;
			});

			//Keep this line at the end of this method, it will bind click at the end of all bindings
			$("#topNavigation, ul#context-menu").find("a").click(function(){
				contextMenu.hide();
				$(document).trigger("click");
			});

			$("#mainServerInstance").unbind().change(function(){
				var options = {
					path: '/'
				};
				$.cookie("mainServerInstance", null);
				$.cookie("mainServerInstance", $(this).val(), options);
				window.location = window.location;
			});
		},
		multiOptionControlDataBind : function(dataSet, dataColumn, control, bindItemMethod, directData, noSubitem, reverse, noEmpty){
			var dataItem = directData ? dataSet : dataSet[dataColumn];
			if(!noEmpty)
				control.empty();
			if(dataItem)
			{
				if(!noSubitem && dataColumn)
				{
					dataItem = dataItem[dataColumn + "_subitem"];
				}
				if(dataItem)
				{
					function addNewOption(curItem, index)
					{
						var newControl = bindItemMethod(curItem, index);
						if(!newControl)return;
						if(reverse)
							control.prepend(newControl);
						else
							control.append(newControl);
						newControl.data("controlData", curItem);
					}
					if(dataItem.length && dataItem.length>0 && !noSubitem)
					{
						for(var i=0; i < dataItem.length; i++)
						{
							addNewOption(dataItem[i], i);
						}
					}
					else
					{
						addNewOption(dataItem, 0);
					}
				}
			}
		}
	},
	data:
	{
		refreshInfoThread : function () {
			adminPanel.data.dataRefreshCall();
			if (!adminPanel.refreshInfoThreadInterval) {
				adminPanel.refreshInfoThreadInterval = setInterval(
					function(){
						adminPanel.data.dataRefreshCall();
						if(window.jobsOnly && window.panelJobsMonitor && panelJobsMonitor._panel && panelJobsMonitor._panel.is(":visible"))
						{
							panelJobsMonitor.dataPollingMethod();
						}
					}
				, adminPanel.refreshInfoInterval);
			}
		},
		dataRefreshCall : function (onlySessionInfo) {
			crushFTP.UI.showIndicator(true, $("#statusPanelTabs"));
			if((panelServerInfo && panelServerInfo._panel.is(":visible")) || (window.panelDashboard && window.panelDashboard._panel.is(":visible")))
			{
				adminPanel.dataRepo.refreshServerInfo(function(items, xml){
					if(panelServerInfo.bindData)
					{
						if(panelServerInfo.bindData.serverList)
							panelServerInfo.bindData.serverList(items);
						if(panelServerInfo.bindData.serverInfo)
							panelServerInfo.bindData.serverInfo(items);
					}
					if(window.panelDashboard && window.panelDashboard.bindData)
					{
						panelDashboard.bindData(items, xml);
					}
					crushFTP.UI.hideIndicator(true, $("#statusPanelTabs"));
				});
			}
			if(panelUserInfo._panel.is(":visible"))
			{
				var sessionSelectionStatus = {type : false, index : -1};
				if(panelUserInfo && panelUserInfo.status && panelUserInfo.status.selectedSession)
				{
					sessionSelectionStatus = panelUserInfo.status.selectedSession();
				}
				if(onlySessionInfo)
				{
					adminPanel.dataRepo.getUserSessionInfo(sessionSelectionStatus.type, sessionSelectionStatus.index, function(data){
						panelUserInfo.bindData.sessionInfo(data, sessionSelectionStatus);
						crushFTP.UI.hideIndicator(true, $("#statusPanelTabs"));
					});
				}
				else
				{
					adminPanel.dataRepo.refreshUserSessonList(false, function(items){
						if(panelUserInfo)
						{
							if(panelUserInfo.bindData)
							{
								if(panelUserInfo.bindData.sessionList)
									panelUserInfo.bindData.sessionList(items, "", false, sessionSelectionStatus);
							}
							adminPanel.dataRepo.refreshUserSessonList("recent_", function(recentItems){
								if(panelUserInfo.bindData)
								{
									if(panelUserInfo.bindData.sessionList)
										panelUserInfo.bindData.sessionList(recentItems, "recent_", false, sessionSelectionStatus);
								}
								if(panelUserInfo.bindData && panelUserInfo.bindData.sessionInfo)
								{
									if(sessionSelectionStatus.index>=0)
									{
										adminPanel.dataRepo.getUserSessionInfo(sessionSelectionStatus.type, sessionSelectionStatus.index, function(data){
											panelUserInfo.bindData.sessionInfo(data, sessionSelectionStatus);
											crushFTP.UI.hideIndicator(true, $("#statusPanelTabs"));
										});
									}
									else
									{
										crushFTP.UI.hideIndicator(true, $("#statusPanelTabs"));
									}
								}
								else
								{
									crushFTP.UI.hideIndicator(true, $("#statusPanelTabs"));
								}
							});
						}
					});
				}
			}
		},
		getXMLPrefsDataFromServer : function(dataKey, callback)
		{
			var items = [];
			crushFTP.data.loadAllPrefs(function(data){
				if(data && typeof data.getElementsByTagName !="undefined" && data.getElementsByTagName("result_value") && data.getElementsByTagName("result_value").length > 0)
				{
					data = data.getElementsByTagName("result_value")[0];
					$(data).find("reportSchedules").find("usernames").each(function(){
						var users = [];
						$(this).find("usernames_subitem").each(function(){
							users.push($(this).text());
						});
						$(this).text(users.join(","));
					});
					items = $.xml2json(data);
					crushFTP.storage(dataKey, items);
					crushFTP.storage(dataKey + "_RAW", data);
					if(callback){
						callback(data);
					}
				}
			});
		},
		bindValuesFromJson : function(_panel, curItem, attrToUse, ignoreUnderscore)
		{
			function elemNameWithoutUnderScore(name)
			{
				if(ignoreUnderscore && name.indexOf("_")>=0)
				{
					name = name.substr(0, name.indexOf("_"));
				}
				return name;
			}

			attrToUse = attrToUse || "id";
			_panel.find("input[type='text']:not(.ignoreBind),input[type='password']:not(.ignoreBind), textarea:not(.ignoreBind), select:not(.ignoreBind)").each(function(){
				if($(this).attr(attrToUse))
				{
					if(curItem)
					{
						var curData = crushFTP.data.getValueFromJson(curItem, elemNameWithoutUnderScore($(this).attr(attrToUse)));
						var curVal = curData.value || curData;
						$(this).val(curVal).trigger("change");
					}
					else
					{
						$(this).val("").trigger("change");
					}
				}
			});
			_panel.find("input[type='checkbox']:not(.ignoreBind), input[type='radio']:not(.ignoreBind) ").each(function(){
				if($(this).attr(attrToUse))
				{
					if(curItem)
					{
						var curData = crushFTP.data.getValueFromJson(curItem, elemNameWithoutUnderScore($(this).attr(attrToUse)));
						var curVal = curData.value || curData;
						if($(this).is(".reverse"))
						{
							crushFTP.UI.checkUnchekInput($(this), curVal != "true");
						}
						else
						{
							crushFTP.UI.checkUnchekInput($(this), curVal == "true");
						}
						$(this).trigger("change");
					}
					else
					{
						if($(this).is(".reverse"))
						{
							crushFTP.UI.checkUnchekInput($(this), true);
						}
						else
						{
							crushFTP.UI.checkUnchekInput($(this), false);
						}
						$(this).trigger("change");
					}
				}
			});
			_panel.find(".liveData").each(function(){
				if($(this).attr(attrToUse))
				{
					if(curItem)
					{
						var curVal = crushFTP.data.getValueFromJson(curItem, elemNameWithoutUnderScore($(this).attr(attrToUse)));
						$(this).text(curVal);
					}
					else
					{
						$(this).text("");
					}
				}
			});
		},
		buildXMLToSubmitForm : function(_panel, includeRadio, attrToUse, ignoreNullValue)
		{
			attrToUse = attrToUse || "id";
			var xmlString = [];
			_panel.find("input[type='text']:not(.ignoreBind, .excludeXML),input[type='password']:not(.ignoreBind, .excludeXML), textarea:not(.ignoreBind, .excludeXML), select:not(.ignoreBind, .excludeXML)").each(function(){
				if($(this).attr(attrToUse))
				{
					var curVal = $(this).val();
					if(!ignoreNullValue)
						xmlString.push("<"+$(this).attr(attrToUse)+">"+crushFTP.methods.htmlEncode(curVal)+"</"+$(this).attr(attrToUse)+">");
					else if(curVal.length>0)
						xmlString.push("<"+$(this).attr(attrToUse)+">"+crushFTP.methods.htmlEncode(curVal)+"</"+$(this).attr(attrToUse)+">");
				}
			});
			_panel.find("input[type='checkbox']:not(.ignoreBind, .excludeXML)").each(function(){
				if($(this).attr(attrToUse))
				{
					if($(this).is(".reverse"))
					{
						xmlString.push("<"+$(this).attr(attrToUse)+">"+!$(this).is(":checked")+"</"+$(this).attr(attrToUse)+">");
					}
					else
					{
						xmlString.push("<"+$(this).attr(attrToUse)+">"+$(this).is(":checked")+"</"+$(this).attr(attrToUse)+">");
					}
				}
			});
			if(includeRadio)
			{
				_panel.find("input[type='radio']:not(.ignoreBind, .excludeXML)").each(function(){
					if($(this).attr(attrToUse))
					{
						xmlString.push("<"+$(this).attr(attrToUse)+">"+$(this).is(":checked")+"</"+$(this).attr(attrToUse)+">");
					}
				});
			}
			return xmlString.join("\r\n");
		}
	},
	dataRepo :
	{
		refreshServerInfo : function(callback)
		{
			crushFTP.data.serverRequest({
				command: "getServerItem",
				key : "server_info"
			},
			function(data){
				var server_info = false;
				if(data && typeof data.getElementsByTagName != "undefined")
				{
					if(data.getElementsByTagName("result_value") && data.getElementsByTagName("result_value").length > 0)
					{
						data = data.getElementsByTagName("result_value")[0];
						server_info = $.xml2json(data);
						crushFTP.methods.rebuildSubItems(server_info, "result_value");
						crushFTP.storage("serverInfo", server_info);
						if(!adminPanel.expiredNoteShown)
						{
							var registration_name = server_info.registration_name;
							var rid = server_info.rid;
							if(registration_name && rid)
							{
								if(registration_name.toLowerCase() == "crush")
								{
									var seconds = parseInt(rid);
									var days = Math.floor((seconds % 31536000) / 86400);
									if(days>30)
									{
										var date = new Date(seconds);
										$("#installationDate").text(date.format("mm/dd/yyyy"));
										adminPanel.expiredNoteShown = true;
										$("#expiredNote").dialog("open");
									}
								}
							}
						}
						if(server_info)
						{
							var versionInfo = "";
							if(server_info.version_info_str)
								versionInfo = server_info.version_info_str;
							if(server_info.sub_version_info_str)
							{
								var subversion = server_info.sub_version_info_str;
								if(subversion.indexOf("_")==0)
									subversion = subversion.substr(1, subversion.length);
								versionInfo += " Build : " + subversion;
								$("#crushVersionInfo").text(versionInfo);
							}
							if(server_info.machine_is_linux == "true")
							{
								$.CrushFTPOS = "linux";
							}
							else if(server_info.machine_is_solaris == "true")
							{
								$.CrushFTPOS = "solaris";
							}
							else if(server_info.machine_is_unix == "true")
							{
								$.CrushFTPOS = "unix";
							}
							else if(server_info.machine_is_windows == "true")
							{
								$.CrushFTPOS = "windows";
							}
							else if(server_info.machine_is_x == "true")
							{
								$.CrushFTPOS = "mac";
							}
						}
						if(callback){
							callback(server_info, data);
							return;
						}
					}
				}
				if(callback){
					callback(server_info, data);
				}
				return;
			});
		},
		getSeverLog : function(callback)
		{
			crushFTP.data.serverRequest({
				command: "getServerItem",
				key : "server_info/server_log"
			},
			function(data){
				var items = false;
				if(data && typeof data.getElementsByTagName != "undefined")
				{
					if(data.getElementsByTagName("result_value") && data.getElementsByTagName("result_value").length > 0)
					{
						data = data.getElementsByTagName("result_value")[0];
						var log = [];
						$(data).find("result_value_subitem").each(function(){
							log.push($(this).text());
						});
						if(callback){
							if(adminPanel.buggyBrowser)
								callback(log.join("\r\n"));
							else
								callback(log.join("\n"));
							return;
						}
					}
				}
				if(callback){
					callback(items);
				}
				return;
			});
		},
		getSeverLogSegment : function(start, length, callback, logFile)
		{
			start = start || 0;
			length = length || 1;
			var obj = {
				command: "getLog",
				segment_start : start,
				segment_len : length
			};
			if(logFile && logFile.length>0)
			{
				obj.log_file = logFile;
			}
			crushFTP.data.serverRequest(obj,
			function(data){
				var error = false;
				if(data && typeof data.getElementsByTagName != "undefined")
				{
					if(data.getElementsByTagName("log_data") && data.getElementsByTagName("log_data").length > 0)
					{
						data = data.getElementsByTagName("log_data")[0];
						if(callback){
							callback(data);
							return;
						}
					}
					else
					{
						if(callback){
							callback(false, data);
						}
					}
				}
				else
				{
					error = true;
					crushFTP.UI.growl("Error", "Error while fetching log info from server Start : " + start + " , Len : " + length, true, 2000);
					if(callback){
						callback(false, error);
					}
				}
				return;
			}, false, "GET", "xml");
		},
		refreshUserSessonList : function(prefix, callback)
		{
			prefix = prefix || "";
			crushFTP.data.serverRequest({
				command: "getSessionList",
				session_list : prefix + "user_list"
			},
			function(data){
				var items = false;
				if(data && typeof data.getElementsByTagName != "undefined")
				{
					if(data.getElementsByTagName("session_list") && data.getElementsByTagName("session_list").length > 0)
					{
						data = data.getElementsByTagName("session_list")[0];
						items = $.xml2json(data);
						crushFTP.methods.rebuildSubItems(items, "session_list");
						if(callback){
							callback(items);
							return;
						}
					}
				}
				if(callback){
					callback(items);
				}
				return;
			});
		},
		getUserSessionInfo : function(prefix, index, callback)
		{
			prefix = prefix || "";
			if(index<0)return;
			crushFTP.data.serverRequest({
				command : "adminAction",
				action : "getUserInfo",
				index : index
			},
			function(data){
				var items = false;
				if(data)
				{
					if(data.getElementsByTagName("result_item") && data.getElementsByTagName("result_item").length > 0)
					{
						data = data.getElementsByTagName("result_item")[0];
						if(callback){
							callback(data);
							return;
						}
					}
				}
				if(callback){
					callback(items);
				}
				return;
			});
		},
		getCurrentUserInformation : function(callback)
		{
			crushFTP.data.serverRequest({
					command: 'getUserInfo',
					path : "/",
					random: Math.random()
				},
				function(data){
					if(data)
					{
						callback(data);
					}
				}
			);
		}
	},
	methods :
	{
		initGUI : function(){
			//window.onbeforeunload = adminPanel.methods.confirmExit;
			$("#statusPanelTabs").tabs({
				show : function(){
					adminPanel.data.dataRefreshCall();
				}
			});

			$("#configOptionTabs").tabs({
				select: function(event, ui) {
					if(ui.index == 0)
					{
						setTimeout(function(){
							try{
								adminPanel.data.dataRefreshCall();
							}catch(ex){}
						}, 100);
					}
					else if(ui.index == 3)
					{
						if(window.panelAbout)
						{
							panelAbout.tabShown();
						}
					}
				}
			});
			if(window.jobsOnly)
			{
				$("#jobsPanelTabs").tabs({
					select: function(event, ui) {
						if(ui.index == 1)
						{
							try{
								panelJobsMonitor.bindData();
							}catch(ex){}
						}
					}
				});
			}
			adminPanel.placeHolder = $("#placeHolder");
			adminPanel.GUIAdmin = $("#GUIAdmin");
			$(document).data("pageTitle", document.title);
			adminPanel.GUIAdmin.find("#adminPanel").block({
				message:  'Loading server prefs..',
				css: {
					border: 'none',
					padding: '10px',
					width : '200px',
					backgroundColor: '#000',
					'-webkit-border-radius': '10px',
					'-moz-border-radius': '10px',
					opacity: .5,
					color: '#fff',
					'text-align':'left'
				}
			});
			var blockMsg = $(".blockMsg");
			var logoElem = $("#logo", "#header").hide();
			var mainServerInstance = $.cookie("mainServerInstance");
			crushFTP.data.serverRequest({
				command: 'getServerItem',
					key: "server_settings/server_list",
					random: Math.random()
				},
				function(data){
					var _mainServerInstance = $("#mainServerInstance").empty();
					if(data)
					{
						$(data).find("result_value_subitem").each(function(){
							var type = $(this).find("serverType").text();
							if(type.toLowerCase().indexOf("dmz") >= 0)
							{
								var instance = $(this).find("server_item_name").text();
								if(!instance) instance = $(this).find("ip").text() + ":" + $(this).find("port").text();
								if(instance && instance.length>0)
								{
									if(instance.toLowerCase() == "main")
										_mainServerInstance.append("<option value=''>"+instance+"</option>");
									else
										_mainServerInstance.append("<option value='"+instance+"'>"+instance+"</option>");
								}
							}
						});
						if(_mainServerInstance.find("option").length>0)
						{
							_mainServerInstance.prepend("<option value=''>Main</option>");
							if(mainServerInstance != null)
							{
								if(_mainServerInstance.find("option[value='"+mainServerInstance+"']").length>0)
								{
									if(mainServerInstance.length>0 && mainServerInstance.toLowerCase()!= "main")
									{
										crushFTP.ajaxCallURL = adminPanel.ajaxCallURL = adminPanel.ajaxCallURL + mainServerInstance + "/";
									}
									_mainServerInstance.val(mainServerInstance);
								}
								else
								{
									crushFTP.ajaxCallURL = adminPanel.ajaxCallURL = adminPanel.ajaxCallURLBase;
									_mainServerInstance.val("");
									var options = {
										path: '/'
									};
									$.cookie("mainServerInstance", null);
									$.cookie("mainServerInstance", "", options);
								}
							}
						}
						else
						{
							_mainServerInstance.parent().remove();
						}
					}
					adminPanel.data.getXMLPrefsDataFromServer("GUIXMLPrefs", function(allPrefs){
						blockMsg.text("Loading Current User Information..");
						adminPanel.dataRepo.getCurrentUserInformation(function(data){
							var customizations = [];
							var logo = "";
							$(data).find("customizations_subitem").each(function(){
								var curObj = {
									key : $(this).find("key").text(),
									value : $(this).find("value").text()
								};
								customizations.push(curObj);
								if(curObj.key && curObj.key.toLowerCase() == "logo")
								{
									logo = curObj.value;
								}
							});
							if(logo)
							{
								logoElem.hide();
								if(logo.toLowerCase().indexOf("http://")<0 && logo.toLowerCase().indexOf("https://")<0)
								{
									logo = "/WebInterface/images/" + logo;
								}
								if(logoElem.find("img").length>0)
									logoElem.find("img").replaceWith("<img src='" + logo+ "' />");
								else
									logoElem.append("<img src='" + logo + "' />");

								/*logoElem.find('img').bind("load", function(){
									var width = $(this).width();
									if(width>300)
									{
										logoElem.find('img').css("max-height", "inherit");
										var height = $(this).height();
										$(this).replaceWith("<div style='background-image:url("+logo+");width:300px;height:"+height+"px;background-repeat:no-repeat;display:inline-block;'></div>");
									}
									logoElem.show();
								});*/
							}
							logoElem.show();
							if(!window.jobsOnly)
							{
								var versionNo = ($(document).data("crushftp_version")+"").replace( /^\D+/g, '');
								var crushVersion = parseInt(versionNo);
								var isCrush7 = crushVersion >= 7;
								var isEnterprise = $(document).data("crushftp_enterprise");
								blockMsg.text("Loading Server Information..");
								if(!isCrush7)
								{
									$("#dashboardPanelTabLink, #serverGraphsTabDashboard").remove();
									$("#configOptionTabs").tabs("select", 1);
								}
								adminPanel.methods.loadPanel($("#serverInfoPlaceHolder"), "ServerInfo", false, function(flag){
									try{
										if(!isCrush7)
										{
											adminPanel.methods.loadPanel($("#serverGraphsTab"), "Graphs", false, function(flag){
												try{
													$("#statusPanelTabs").tabs("select", 0);
													adminPanel.data.refreshInfoThread();
												}catch(ex){}
											});
										}
										else
											adminPanel.data.refreshInfoThread();
									}catch(ex){}
								});

								adminPanel.methods.loadPanel($("#userInfoPlaceHolder"), "UserInfo", false, function(flag){
									try{
										adminPanel.data.refreshInfoThread();
									}catch(ex){}
								});
								adminPanel.GUIAdmin.find("#adminPanel").unblock();
								/*adminPanel.methods.loadPanel($("#aboutPanel"), "About", false, function(flag){
								});
								adminPanel.methods.loadPanel($("#reportsSetupPlaceHolder"), "ReportsSetup", false, function(flag){
								});
								adminPanel.methods.loadPanel($("#reportsSchedulePlaceHolder"), "ReportSchedule", false, function(flag){
									adminPanel.GUIAdmin.find("#adminPanel").unblock();
								});
								*/
								if(isCrush7)
								{
									adminPanel.methods.loadPanel($("#dashboardPanel"), "Dashboard", false, function(flag){
										try{
											adminPanel.data.refreshInfoThread();
											$("#graphsPanelTabLink, #serverGraphsTab").remove();
										}catch(ex){}
										adminPanel.methods.loadPanel($("#serverGraphsTabDashboard"), "Graphs", false, function(flag){
										});
									});
								}
							}
							else
							{
								blockMsg.text("Loading Jobs..");
								adminPanel.methods.loadPanel($("#jobsSchedulePlaceHolder"), "JobsSchedule", false, function(flag){
								});
								if(!$(document).data("crushftp_enterprise"))
								{
									adminPanel.GUIAdmin.find("#adminPanel").unblock();
									adminPanel.dataRepo.refreshServerInfo(function(items){});
									try{
										if (!adminPanel.refreshInfoThreadInterval) {
											adminPanel.refreshInfoThreadInterval = setInterval(
												function(){
													if(window.jobsOnly && window.panelJobsMonitor && panelJobsMonitor._panel && panelJobsMonitor._panel.is(":visible"))
													{
														panelJobsMonitor.dataPollingMethod();
													}
												}
											, adminPanel.refreshInfoInterval);
										}
									}catch(ex){}
								}
								else
								{
									adminPanel.methods.loadPanel($("#jobsMonitorPlaceHolder").empty(), "JobsMonitor", false, function(flag){
										adminPanel.GUIAdmin.find("#adminPanel").unblock();
										adminPanel.dataRepo.refreshServerInfo(function(items){});
										try{
											if (!adminPanel.refreshInfoThreadInterval) {
												adminPanel.refreshInfoThreadInterval = setInterval(
													function(){
														if(window.jobsOnly && window.panelJobsMonitor && panelJobsMonitor._panel && panelJobsMonitor._panel.is(":visible"))
														{
															panelJobsMonitor.dataPollingMethod();
														}
													}
												, adminPanel.refreshInfoInterval);
											}
										}catch(ex){}
									});
								}
							}
						});
					});
				}
			,false , "POST");
			crushFTP.UI.hideLoadingIndicator();
			adminPanel.UI.initEvents();

			/*Session checker will get version information, based on it new features will be show/hide/initiated*/
			$(".enterpriseFeature, .crush7Feature").hide();
			$("#SessionSeconds").sessionChecker({
				callBack:function(){
					var context = $(document);
					var versionNo = ($(document).data("crushftp_version")+"").replace( /^\D+/g, '');
					var crushVersion = parseInt(versionNo);
					var isEnterprise = $(document).data("crushftp_enterprise");
					context.find(".enterpriseFeature, .crush6Feature, .crush7Feature").hide();
					context.find(".enterpriseFeature").each(function(){
						if($(this).hasClass("crush6Feature") && crushVersion>=6)
							$(this).show();
						else if($(this).hasClass("crush7Feature") && crushVersion>=7)
							$(this).show();
						else if(!$(this).hasClass("crush6Feature") && !$(this).hasClass("crush7Feature"))
							$(this).show();
					});

					context.find(".crush6Feature, .crush7Feature").not(".enterpriseFeature").each(function(){
						if($(this).hasClass("crush6Feature") && crushVersion>=6)
							$(this).show();
						else if($(this).hasClass("crush7Feature") && crushVersion>=7)
							$(this).show();
					});

					if(crushVersion<6)
					{
						crushFTP.userLogin.userLoginStatusCheckThread();
					}
				}
			});

			var ignorePurchaseBtn = $("#ignorePurchase").click(function(){
				if($(this).attr("disabled"))return false;
				$("#expiredNote").dialog("close");
				return false;
			}).attr("disabled", "disabled");

			$("#expiredNote").dialog({
				autoOpen: false,
				width: 400,
				title : "Trial Expired : ",
				modal: true,
				resizable: false,
				closeOnEscape: false,
				beforeClose : function(){
					return true;
				},
				open: function(){
					$(".ui-dialog-titlebar-close").hide();
					ignorePurchaseBtn.block({
						message:  '10',
						css: {
							border: 'none',
							padding: '0px',
							backgroundColor: 'transparent',
							opacity: .9,
							color: '#fff',
							'text-align':'center'
						}
					});
					var msgText = $(".blockMsg");
					var counter = 0;
					var myInterval = setInterval(function () {
					  ++counter;
					  if(counter==10)
					  	clearInterval(myInterval);
					  msgText.text(10-counter);
					}, 1000);

					setTimeout(function(){
						ignorePurchaseBtn.unblock();
						ignorePurchaseBtn.removeAttr("disabled");
					}, 10000);
				}
			});
		},
		loadPanel : function(panelPlaceHolder, panel, initParam, callback){
			crushFTP.UI.notification(false);
			if(panel && panel.length>0)
			{
				$.ajax({
					url : "panels/"+panel+"/index.html?random="+Math.random(),
					success : function(response) {
						var curPanel = $(response);
						panelPlaceHolder.append(curPanel);
						buildButtons(curPanel);
						$(".tabs", curPanel).tabs();
						$("#configOptionTabs").tabs();
						$.getScript("panels/"+panel+"/interface.js?random="+Math.random(), function() {
							initParam = initParam || false;
							var initScript = "panel" + panel + ".init();";
							if(initParam)
							{
								initScript = "panel" + panel + ".init('"+initParam+"');";
							}
							try{
								eval(initScript);
								adminPanel.methods.initLayoutEvents(curPanel, panel);
								if(callback)
									callback(true);
							}
							catch(ex){
								if(ex && ex.toString() != "")
								{
									crushFTP.UI.growl("Error", "panel" +panel + ".init(); " + ex, true);
								}
								if(callback)
									callback(false);
							}
						});
					},
					error : function(xhr)
					{
						var msg = "Sorry but there was an error: " + xhr.status + " " + xhr.statusText + " while loading panel : " + panel;
						crushFTP.UI.notification(msg, true);
						if(callback)
							callback(false);
					}
				});
			}
			else
			{
				if(callback)
				{
					callback(false);
				}
			}
			return false;
		},
		initLayoutEvents : function(context, panel){
			context = context || adminPanel.placeHolder;
			adminPanel.methods.itemsChanged(false);
			context.form();
			$("#ui-datepicker-div").hide();
			if(context.find(".panelFormFields").length>0)
			{
				adminPanel.methods.listenChanges(context.find(".panelFormFields"));
			}
			else
			{
				adminPanel.methods.listenChanges(context);
			}
			context.unbind("changed").bind("changed", function(){
				adminPanel.methods.itemsChanged(true);
			});
			vtip(context);
			$("ol.selectable", context).selectable({
				selected: function(event, ui) {
					var selected = $(ui.selected);
					selected.parent().find(".ui-widget-header").removeClass("ui-widget-header");
					selected.addClass("ui-widget-header");
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
				}
			});
		},
		listenChanges : function(context){
			context = context || adminPanel.placeHolder;
			context.find("input:not(.ignoreChange), select:not(.ignoreChange), textarea:not(.ignoreChange)").change(function(){
				adminPanel.methods.itemsChanged(true);
			});
			context.find("input[type='text']:not(.ignoreChange), textarea:not(.ignoreChange)").bind("textchange", function(){
				adminPanel.methods.itemsChanged(true);
			});
		},
		itemsChanged : function(flag){
			var context = adminPanel.placeHolder;
			if(context)
			{
				context.data("hasChanged", flag);
			}
		},
		confirmExit : function(){
			if(adminPanel.placeHolder.data("hasChanged"))
			{
				return "If you navigate away, you will lose your unsaved changes. Do you want to continue?";
			}
		},
		hideZero : function(val) {
			if(!val || val+"" == "0" || val == "undefined" || val.length == 0)
				return "N/A";
			else
				return val;
		}
	}
};