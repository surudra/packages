/*!
* CrushFTP Web GUI localizations
*
* Copyright @ SoftwareAG
*
*/

var localizations = {};

// Navigation items
localizations.navigationItem = {};
localizations.panels = {};
localizations.navigationItem.IPServers = "IP / Servers";
localizations.navigationItem.GeneralSettings = "General Settings";
localizations.navigationItem.WebInterface = "Web Interface";
localizations.navigationItem.Restrictions = "Restrictions";
localizations.navigationItem.Banning = "Banning";
localizations.navigationItem.Logging = "Logging";
localizations.navigationItem.Encryption = "Encryption";
localizations.navigationItem.Alerts = "Alerts";
localizations.navigationItem.FolderMonitor = "Folder Monitor";
localizations.navigationItem.Tunnels = "Tunnels";
localizations.navigationItem.UserConfig = "User Config";
localizations.navigationItem.Preview = "Preview";
localizations.navigationItem.Misc = "Misc";
localizations.navigationItem.Plugins = "Plugins";

function applyLocalizations(section, custLocalization)
{
	custLocalization = custLocalization || localizations;
	if(section)
	{
		var toApply = custLocalization[section];
		if(toApply)
		{
			for(var i in toApply)
			{
				if(i)
				{
					var key = i.toString();
					var val = toApply[i].toString();
					if(key && (val || val == ""))
					{
						if(key.toLowerCase().indexOf("button")>=0 || key.toLowerCase().indexOf("input")>=0)
						{
							$("."+key).val(val);
						}
						else if(key.toLowerCase().indexOf("byclass")>=0|| key.toLowerCase().indexOf("multiple")>=0)
						{
							$("."+key).html(val);
						}
						else
						{
							$("." + key + "." + section).html(val);
						}
					}
				}
			}
		}
		else 
		{
			return;
		}
	}
	else
	{
		var toApply = custLocalization;
		for(var i in toApply)
		{
			if(i)
			{
				var key = i.toString();
				applyLocalizations(key);
			}
		}
	}
}

$(document).ready(function(){
	applyLocalizations();
});