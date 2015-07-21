/****************************
CrushFTP GUI Panel custom js
*****************************/
/* Do not change these lines */
var panelServerInfo = {};
panelServerInfo.localization = {};
/****************************/

// Panel details
panelServerInfo.panelName = "ServerInfo";
panelServerInfo._panel = $("#pnl" + panelServerInfo.panelName);
panelServerInfo.serverItemContextMenu = $("#serverItemContextMenu", panelServerInfo._panel);

// Localizations
panelServerInfo.localization = {
};

// Assign localizations
localizations.panels[panelServerInfo.panelName] = $.extend(panelServerInfo.localization, localizations.panels[panelServerInfo.panelName]);

// Interface methods
panelServerInfo.init = function(){
	applyLocalizations(panelServerInfo.panelName, localizations.panels);
	panelServerInfo.bindEvents();
	$("#lstServers", panelServerInfo._panel).parent().resizable({minHeight:40, handles: 's', resize : function(){
		panelServerInfo.resizeLogFrame();
	} });
}

// Bind data from provided JSON to panel's fields
panelServerInfo.bindData  = {
	serverList : function(data, elem){
		data = data || crushFTP.storage("serverInfo");
		if(!data)
		{
			return;
		}
		elem = elem || $("#lstServers", panelServerInfo._panel);
		var selectedIndex = elem.find("li.ui-widget-header").index();
		if(elem && elem.length>0)
		{
			var serverStatus = {
				total : 0,
				running : 0,
				down : 0
			};
			adminPanel.UI.multiOptionControlDataBind(data
				, "server_list"
				, elem
				, function(curItem){
					var display = unescape(curItem.display);
					if(display && display != "undefined")
					{
						display = _escapeHTML(display);
						if(elem.find("li[display='"+display+"']").length==0)
						{
							serverStatus.total+=1;
							if(curItem.running)
								serverStatus.running+=1;
							else
								serverStatus.down+=1;
							return $("<li class='ui-widget-content' running='"+curItem.running+"' display='"+display+"'>"+ display +"</li>");
						}
						else
							return false;
					}
					else
					{
						return false;
					}
				}
			);
			if(selectedIndex>=0)
			{
				selectedIndex += 1;
				elem.find("li.ui-widget-header").removeClass("ui-widget-header");
				elem.find("li:nth-child("+selectedIndex+")").addClass("ui-widget-header");
			}

			panelServerInfo.resizeLogFrame();

			elem.find("li").contextMenu({
				topPadding : 110,
				leftPadding : 20,
				addClassSP : true,
				menu: 'serverItemContextMenu'
			}, function (action, el, pos, command) {
				panelServerInfo.adminAction(action);
				return false;
			}).click(function (evt) {
				evt.stopPropagation();
				evt.preventDefault();
				$(this).trigger("mousedown").trigger("mouseup");
				return false;
			}).bind("onBeforeContextMenu", function(){
				var running = $(this).attr("running");
				panelServerInfo.serverItemContextMenu.find(".ui-state-disabled").removeClass("ui-state-disabled");
				if(running == "true")
				{
					panelServerInfo.serverItemContextMenu.find(".start").addClass("ui-state-disabled");
				}
				else
				{
					panelServerInfo.serverItemContextMenu.find(".stop, .restart").addClass("ui-state-disabled");
				}
			});

			elem.find("li").each(function(){
				var item = $("<span class='serverItemButtonPnl' style='display:none;'></span>")
				 $(this).prepend(item);
				item.append('<a href="#" class="serverItemButton start"><span style="display: inline-block;margin: 0px 3px 0px -17px; float: left;" class="pointer ui-icon ui-icon-play"></span><span class="">Start</span></a>');
				item.append('<a href="#" class="serverItemButton stop"><span style="display: inline-block;margin: 0px 3px 0px -17px; float: left;" class="pointer ui-icon ui-icon-power"></span><span class="">Stop</span></a>');
				item.append('<a href="#" class="serverItemButton restart"><span style="display: inline-block;margin: 0px 3px 0px -17px; float: left;" class="pointer ui-icon ui-icon-refresh"></span><span class="">Restart</span></a>');
				$(this).hover(function(){
					var serverItemButtonPnl = $(this).find(".serverItemButtonPnl").show();
					var running = $(this).attr("running");
					serverItemButtonPnl.find(".ui-state-disabled").removeClass("ui-state-disabled");
					if(running == "true")
					{
						serverItemButtonPnl.find(".start").addClass("ui-state-disabled");
					}
					else
					{
						serverItemButtonPnl.find(".stop, .restart").addClass("ui-state-disabled");
					}
				},function(){
					$(this).find(".serverItemButtonPnl").hide();
				});

				item.bind("mousedown", function(evt)
				{
					evt.stopPropagation();
					evt.preventDefault();
				});

				item.find(".serverItemButton").click(function(evt){
					if(!$(this).hasClass("ui-state-disabled"))
					{
						var action = "startServer";
						if ($(this).hasClass("stop")) {
							action = "stopServer";
						}
						else if ($(this).hasClass("restart")) {
							action = "restartServer";
						}
						panelServerInfo.adminAction(action, $(this).closest("li").index());
					}
					evt.stopPropagation();
					evt.preventDefault();
					return false;
				})
			});
		}
	},
	serverInfo : function(data, elem){
		data = data || crushFTP.storage("serverInfo");
		if(!data)
		{
			return;
		}
		elem = elem || $("#serverInfoTab", panelServerInfo._panel);
		if(elem && elem.length>0)
		{
			adminPanel.data.bindValuesFromJson(elem, data);
		}
		elem.find(".formatData, .hideZero").each(function(){
			var val = $(this).text();
			if($(this).hasClass("hideZero"))
			{
				val = adminPanel.methods.hideZero(val);
				$(this).text(val);
			}
			if($(this).hasClass("formatData"))
			{
				if(val && crushFTP.methods.isNumeric(val))
				{
					if($(this).hasClass("inKBs"))
					{
						val = parseFloat(val) * 1024;
					}
					$(this).text(crushFTP.methods.formatBytes(val));
					if($(this).hasClass("speedInSecond"))
					{
						$(this).text($(this).text() + " /sec");
					}
				}
			}
		});
	}
};

panelServerInfo.adminAction = function(action, _index)
{
	var selectedIndex = $("#lstServers", panelServerInfo._panel).find("li.ui-widget-header").index();
	if(typeof _index != "undefined")
		selectedIndex = _index;
	if(!action || selectedIndex < 0) return;
	var cmdObj = {
		command: "adminAction",
		action : action,
		index : selectedIndex
	};
	crushFTP.data.serverRequest(
	cmdObj,
	function(data){
		var success = false;
		if(data)
		{
			var usersData = $.xml2json(data);
			if(usersData && usersData["response_status"] && usersData["response_status"]== "OK")
			{
				success = true;
			}
		}
		if(!success)
		{
			crushFTP.UI.growl("Failure", "Admin action " + action + " failed for index " + selectedIndex, true, true);
		}
		else
		{
			var msg = "Server Started";
			if(action == "stopServer")
				msg = "Server Stopped";
			else if(action == "restartServer")
				msg = "Server Restarted";
			crushFTP.UI.growl("Sucess", msg, false, 2000);
		}
	});
};

panelServerInfo.serverStatResetAction = function(action)
{
	var cmdObj = {
		command: "adminAction",
		action : action
	};
	crushFTP.data.serverRequest(
	cmdObj,
	function(data){
		var success = false;
		if(data)
		{
			var usersData = $.xml2json(data);
			if(usersData && usersData["response_status"] && usersData["response_status"]== "OK")
			{
				success = true;
			}
		}
		if(!success)
		{
			crushFTP.UI.growl("Failure", "Admin action " + action, true, true);
		}
		else
		{
			var msg = " Stats reset completed..";
			if(action == "allStats")
				msg = "All" + msg;
			else if(action == "loginStats")
				msg = "Login" + msg;
			else if(action == "transferStats")
				msg = "Transfer : Server Bytes (in, out)"  + msg;
			else if(action == "uploadDownloadStats")
				msg = "Upload/Download"  + msg;
			crushFTP.UI.growl("Sucess", msg, false, 2000);
		}
	});
};

panelServerInfo.resizeLogFrame = function()
{
	var winHeight = $(window).height();
	var serverListHeight = $("#lstServers").parent().height();
	var arbHeight = serverListHeight + 250;
	var frameHeight = winHeight - arbHeight;
	if(frameHeight<500)
		frameHeight = 500;
	$("#serverLoggingFrame").height(frameHeight);
}

panelServerInfo.bindEvents = function()
{
	$(window).resize(function () {
		panelServerInfo.resizeLogFrame();
    });
    panelServerInfo.resizeLogFrame();

	$("#serverInfoTab", panelServerInfo._panel).contextMenu({
		topPadding : 110,
		leftPadding : 20,
		menu: 'serverResetStatsContextMenu'
	}, function (action, el, pos, command) {
		jConfirm("Are you sure you want to : " + command + "?","Confirm", function(flag){
			if(flag)
			{
				panelServerInfo.serverStatResetAction(action);
			}
		});
		return false;
	}).click(function (evt) {
		evt.stopPropagation();
		evt.preventDefault();
		return false;
	});

	var val = [0];
	function drawGraph()
	{
		$('.sparklines', panelServerInfo._panel).sparkline(val, {
			width:"99%",
			height: "25%",
			type : "line",
			barColor : "#FED22F"
		});
		setTimeout(function(){
			val.push(Math.floor((Math.random()*100)+1));
			drawGraph();
		}, 500);
	}
	drawGraph();
};

var HTML_ESCAPES = {
  '&': '&amp;',
  '<': '&lt;',
  '>': '&gt;',
  '"': '&quot;',
  "'": '&#x27;',
  '/': '&#x2F;'
};

var HTML_ESCAPE_CHARS = /[&<>"'\/]/g;

function coerceToString(val) {
  return String((val === null || val === undefined) ? '' : val);
}

function _escapeHTML(text) {
  return coerceToString(text).replace(HTML_ESCAPE_CHARS, function(match) {
    return HTML_ESCAPES[match];
  });
} 