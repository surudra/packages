/****************************
CrushFTP GUI Panel custom js
*****************************/
/* Do not change these lines */
var panelGraphs = {};
panelGraphs.localization = {};
/****************************/

// Panel details
panelGraphs.panelName = "Graphs";
panelGraphs._panel = $("#pnl" + panelGraphs.panelName);

//Local variables
panelGraphs.initGraphInterval = 300;
panelGraphs.intervalsInPoll = 1;
panelGraphs.pollIntervalInMS = 1000;
panelGraphs.maxRecordsToShow = 300;
panelGraphs.hasReopened = false;

panelGraphs.Connections = [0];
panelGraphs.OutSpeed = [0];
panelGraphs.InSpeed = [0];

panelGraphs.connectionsGraph = $("#connectionsGraph", panelGraphs._panel);
panelGraphs.connectionCurrent = $("#connectionCurrent", panelGraphs._panel);
panelGraphs.connectionMax = $("#connectionMax", panelGraphs._panel);

panelGraphs.outSpeedGraph = $("#outSpeedGraph", panelGraphs._panel);
panelGraphs.outSpeedCurrent = $("#outSpeedCurrent", panelGraphs._panel);
panelGraphs.outSpeedMax = $("#outSpeedMax", panelGraphs._panel);

panelGraphs.inSpeedGraph = $("#inSpeedGraph", panelGraphs._panel);
panelGraphs.inSpeedCurrent = $("#inSpeedCurrent", panelGraphs._panel);
panelGraphs.inSpeedMax = $("#inSpeedMax", panelGraphs._panel);

$.fn.sparkline.defaults.common.width = "99%";
$.fn.sparkline.defaults.common.height = "100px";

panelGraphs.maxConnection = 0;
panelGraphs.maxOutSpeed = 0;
panelGraphs.maxInSpeed = 0;

// Localizations
panelGraphs.localization = {
};

// Assign localizations
localizations.panels[panelGraphs.panelName] = $.extend(panelGraphs.localization, localizations.panels[panelGraphs.panelName]);

// Interface methods
panelGraphs.init = function(){
	applyLocalizations(panelGraphs.panelName, localizations.panels);
	var isInit = true;
	function threadMethod()
	{
		if(!panelGraphs._panel.is(":visible"))
		{
			panelGraphs.hasReopened = true;
		}
		else
		{
			if(!panelGraphs.graphThreadRunning)
			{
				panelGraphs.refreshDataFromServer(isInit || panelGraphs.hasReopened);
				panelGraphs.hasReopened = isInit = false;
			}
		}
	}
	if (!panelGraphs.graphsThread) {
		panelGraphs.graphsThread = setInterval(
			threadMethod
		, panelGraphs.pollIntervalInMS);
	}
	threadMethod();
}

panelGraphs.refreshDataFromServer = function(isInit)
{
	panelGraphs.graphThreadRunning = true;
	var priorIntervals = panelGraphs.intervalsInPoll;
	if(isInit)
	{
		priorIntervals = panelGraphs.initGraphInterval;
		panelGraphs.Connections = [];
		panelGraphs.OutSpeed = [];
		panelGraphs.InSpeed = [];
	}
	function getDataFromResponse(items, key)
	{
		if(items && items[key])
		{
			var val = items[key];
			if(val.lastIndexOf(",") == val.length - 1)
				val = val.substr(0, val.length - 1);
			return val.split(",").reverse();
		}
		else
			return "";
	}
	if(priorIntervals>panelGraphs.maxRecordsToShow)priorIntervals = panelGraphs.maxRecordsToShow;
	crushFTP.data.serverRequest({
		command : "getStatHistory",
		params : "current_download_speed,current_upload_speed,logged_in_users",
		priorIntervals : priorIntervals
	}, function(data){
		panelGraphs.graphThreadRunning = false;
		var items = $.xml2json(data)
		panelGraphs.bindData.graphs({
			logged_in_users : getDataFromResponse(items.response_data, "logged_in_users"),
			current_download_speed : getDataFromResponse(items.response_data, "current_download_speed"),
			current_upload_speed : getDataFromResponse(items.response_data, "current_upload_speed")
		});
	});
};

// Bind data from provided JSON to panel's fields
panelGraphs.bindData  = {
	graphs : function(data){
		if(!data)
		{
			return;
		}

		//Connections
		panelGraphs.Connections = panelGraphs.Connections.concat(data.logged_in_users);
		if(panelGraphs.Connections.length>panelGraphs.maxRecordsToShow)
		{
			var itemsToRemove = panelGraphs.Connections.length - panelGraphs.maxRecordsToShow;
			panelGraphs.Connections.remove(1, itemsToRemove);
			panelGraphs.Connections[0] = 0;
		}
		var currentConnections = parseInt(data.logged_in_users[data.logged_in_users.length -1]);
		var maxVal = parseInt(data.logged_in_users.max());
		if(maxVal>panelGraphs.maxConnection)
		{
			panelGraphs.maxConnection = maxVal;
		}
		panelGraphs.connectionCurrent.text(currentConnections);
		panelGraphs.connectionMax.text(panelGraphs.maxConnection);

		//Out speed
		panelGraphs.OutSpeed = panelGraphs.OutSpeed.concat(data.current_download_speed);
		if(panelGraphs.OutSpeed.length>panelGraphs.maxRecordsToShow)
		{
			var itemsToRemove = panelGraphs.OutSpeed.length - panelGraphs.maxRecordsToShow;
			panelGraphs.OutSpeed.remove(1, itemsToRemove);
			panelGraphs.OutSpeed[0] = 0;
		}
		var currentOutSpeed = parseInt(data.current_download_speed[data.current_download_speed.length -1]);
		var maxOSVal = parseInt(data.current_download_speed.max());
		if(maxOSVal>panelGraphs.maxOutSpeed)
		{
			panelGraphs.maxOutSpeed = maxOSVal;
		}
		panelGraphs.outSpeedCurrent.text(crushFTP.methods.formatBytes(currentOutSpeed * 1024) + "/sec");
		panelGraphs.outSpeedMax.text(crushFTP.methods.formatBytes(panelGraphs.maxOutSpeed * 1024) + "/sec");


		//In Speed
		panelGraphs.InSpeed = panelGraphs.InSpeed.concat(data.current_upload_speed);
		if(panelGraphs.InSpeed.length>panelGraphs.maxRecordsToShow)
		{
			var itemsToRemove = panelGraphs.InSpeed.length - panelGraphs.maxRecordsToShow;
			panelGraphs.InSpeed.remove(1, itemsToRemove);
			panelGraphs.InSpeed[0] = 0;
		}
		var currentInSpeed = parseInt(data.current_upload_speed[data.current_upload_speed.length -1]);
		var maxISVal = parseInt(data.current_upload_speed.max());
		if(maxISVal>panelGraphs.maxInSpeed)
		{
			panelGraphs.maxInSpeed = maxISVal;
		}
		panelGraphs.inSpeedCurrent.text(crushFTP.methods.formatBytes(currentInSpeed * 1024) + "/sec");
		panelGraphs.inSpeedMax.text(crushFTP.methods.formatBytes(panelGraphs.maxInSpeed * 1024) + "/sec");

		// Now render graphs
		panelGraphs.renderGraphs();
	}
};

panelGraphs.renderGraphs = function()
{
	var now = new Date();
	$("#lastGraphUpdatedTimestamp", panelGraphs._panel).text(dateFormat(now, "mediumTime"));
	panelGraphs.connectionsGraph.sparkline(panelGraphs.Connections);
	panelGraphs.outSpeedGraph.sparkline(panelGraphs.OutSpeed);
	panelGraphs.inSpeedGraph.sparkline(panelGraphs.InSpeed);
};