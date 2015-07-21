window.onload = rebrand;

function rebrand() {
	/* switch Header Text and Header Image */
	$('#headerText').append('ActiveTransfer Web Client');
	$('#headerText').before($('#headerImages'));

	removeAdminLink();
	$('#mainNavigation').bind('DOMSubtreeModified', removeAdminLink);
}

function removeAdminLink() {
	/* Remove Admin link */
	$("ul.topnav li:contains('Admin')").remove();
}