/*!
* CrushFTP Web GUI Initial events
*
* Copyright @ SoftwareAG
*
*/
crushFTP.defaultRequestType = "GET";
$(document).ready(function(){
	$(".tabs").tabs();
	crushFTP.UI.initLoadingIndicator();
	crushFTP.userLogin.bindUserName(function (response, username) {
		crushFTP.UI.showLoadingIndicator({});
		$("#adminPanel").form();
		css_browser_selector(navigator.userAgent);
		$(".button").button();
		if (response == "failure") {
			window.location = "/WebInterface/login.html?link=/WebInterface/admin/index.html";
		} else {
			adminPanel.methods.initGUI();
		}
	});
});

function doLogout()
{
	$.ajax({type: "POST",url: "/WebInterface/function/",data: {command: "logout",random: Math.random()},
		error: function (XMLHttpRequest, textStatus, errorThrown)
		{
			$.cookie("CrushAuth", "", {path: '/',expires: -1});
			document.location = "/WebInterface/login.html";
		},
		success: function (msg)
		{
			$.cookie("CrushAuth", "", {path: '/',expires: -1});
			document.location = "/WebInterface/login.html";
		}
	});
	return false;
}