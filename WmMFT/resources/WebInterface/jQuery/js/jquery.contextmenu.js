// jQuery Context Menu Plugin
// Customized for ActiveTransfer
//
// Version 1.01
//
// Cory S.N. LaViska
// A Beautiful Site (http://abeautifulsite.net/)
//
// More info: http://abeautifulsite.net/2008/09/jquery-context-menu-plugin/
//
// Terms of Use
//
// This plugin is dual-licensed under the GNU General Public License
//   and the MIT License and is copyright A Beautiful Site, LLC.
//
if (jQuery) (function() {
	$.extend($.fn, {

		contextMenu: function(o, callback) {
			// Defaults
			if (o.menu == undefined) return false;
			if (o.inSpeed == undefined) o.inSpeed = 150;
			if (o.outSpeed == undefined) o.outSpeed = 75;
			// 0 needs to be -1 for expected results (no fade)
			if (o.inSpeed == 0) o.inSpeed = -1;
			if (o.outSpeed == 0) o.outSpeed = -1;
			if (o.addHoverClass == undefined) o.addHoverClass = false;
			// Loop each context menu
			$(this).each(function() {
				var el = $(this);
				var offset = $(el).offset();
				// Add contextMenu class
				$('#' + o.menu).addClass('contextMenu');
				// Simulate a true right click
				$(this).mousedown(function(e) {
					var evt = e;
					//evt.stopPropagation();
					//evt.preventDefault();
					$(this).mouseup(function(e) {
						e.stopPropagation();
						e.preventDefault();
						var srcElement = $(this);
						$(this).unbind('mouseup');
						if (evt.button == 2 || evt.ctrlKey || $(this).hasClass("selectionLink") || $(this).hasClass("pageSizeSelectionLink")) {
							srcElement.blur();
							$("#cluetip").hide();
							// Hide context menus that may be showing
							if(o.addHoverClass)
							{
								srcElement.parent().removeClass("rowHoverFixed");
							}
							$(".contextMenu").hide();
							// Get this context menu
							var menu = $('#' + o.menu);

							if ($(el).hasClass('disabledMenu')) {
							return false;}

							// Detect mouse position
							var d = {}, x, y;
							if (self.innerHeight) {
								d.pageYOffset = self.pageYOffset;
								d.pageXOffset = self.pageXOffset;
								d.innerHeight = self.innerHeight;
								d.innerWidth = self.innerWidth;
							} else if (document.documentElement &&
								document.documentElement.clientHeight) {
								d.pageYOffset = document.documentElement.scrollTop;
								d.pageXOffset = document.documentElement.scrollLeft;
								d.innerHeight = document.documentElement.clientHeight;
								d.innerWidth = document.documentElement.clientWidth;
							} else if (document.body) {
								d.pageYOffset = document.body.scrollTop;
								d.pageXOffset = document.body.scrollLeft;
								d.innerHeight = document.body.clientHeight;
								d.innerWidth = document.body.clientWidth;
							}
							(e.pageX) ? x = e.pageX : x = e.clientX + d.scrollLeft;
							(e.pageY) ? y = e.pageY : y = e.clientY + d.scrollTop;

							// Show the menu
							$(document).unbind('click');

							$(menu).css({ top: y - 5, left: x - 5}).show();

							applyPrivsOnMenu(el);
							$("div.tipsy").remove();
							var pos = $.extend({}, $(menu).offset(), { width: menu.offsetWidth, height: $(menu).height()});
							var winHeight = $(window).height();
							var posTop = pos.top + pos.height;
							if(posTop > winHeight)
							{
								var _top = y - pos.height - 5;
								if(_top-y<0)
								{
									var st = $(document).scrollTop();
									var ph = st + 5;
									if(ph + pos.height < y)
								 		_top = y - pos.height + 5;
								 	else
								 		_top = ph;
								}
								menu.css({ top: _top});
							}
							var myMenu = $("#myMenu");
							if (($(document).data("__WEBINTERFACE_FILES_COPIED") && $(document).data("__WEBINTERFACE_FILES_COPIED").length > 0)) {
								myMenu.find(".paste").removeAttr("disable").removeClass("disabledMenu");
							}
							else {
								myMenu.find(".paste").attr("disable", "disable").addClass("disabledMenu");
							}
							myMenu.find(".download").removeAttr("disable").removeClass("disabledMenu");
							if(window.isSearchResult)
							{
								if(myMenu.find("li.parentLocation").length==0)
									myMenu.prepend('<li class="parentLocation"><a href="javascript:void(0);" command="javascript:performAction(\'parentLocation\',true);">'+getLocalizationKeyExternal("SearchItemsContextGoToParentText")+'</a></li>');
							}
							else
							{
								myMenu.find("li.parentLocation").remove();
							}
							// Hover events
							$(menu).find('A').mouseover(function() {
								$(menu).find('LI.hover').removeClass('hover');
								$(this).parent().addClass('hover');
							}).mouseout(function() {
								$(menu).find('LI.hover').removeClass('hover');
							});

							// Keyboard
							$(document).keyup(function(e) {
								switch (e.keyCode) {
									case 38: // up
										if ($(menu).find('LI.hover').size() == 0) {
											$(menu).find('LI:last').addClass('hover');
										} else {
											$(menu).find('LI.hover').removeClass('hover').prevAll('LI:not(.disabledMenu)').eq(0).addClass('hover');
											if ($(menu).find('LI.hover').size() == 0) $(menu).find('LI:last').addClass('hover');
										}
										break;
									case 40: // down
										if ($(menu).find('LI.hover').size() == 0) {
											$(menu).find('LI:first').addClass('hover');
										} else {
											$(menu).find('LI.hover').removeClass('hover').nextAll('LI:not(.disabledMenu)').eq(0).addClass('hover');
											if ($(menu).find('LI.hover').size() == 0) $(menu).find('LI:first').addClass('hover');
										}
										break;
									case 13: // enter
										$(menu).find('LI.hover A').trigger('click');
										break;
									case 27: // esc
										$(document).trigger('click');
										break
								}
							});

							// When items are selected
							$('#' + o.menu).find('A').unbind('click');
							$('#' + o.menu).find('LI:not(.disabledMenu) A').click(function(evt) {
								evt.stopPropagation();
								evt.preventDefault();
								$(document).unbind('click').unbind('keyup');
								if(o.addHoverClass)
								{
									srcElement.parent().removeClass("rowHoverFixed");
								}
								$(".contextMenu").hide();
								// Callback
								var action = $(this).attr('href').substr(1);
								if(action.indexOf("#")>=0)
								{
									action = action.substr(action.indexOf("#") + 1 , action.length - 1);
								}
								if (callback) callback(action, $(srcElement), { x: x - offset.left, y: y - offset.top, docX: x, docY: y }, $(this).attr('command'));
								return false;
							});

							// Hide bindings
							setTimeout(function() { // Delay for Mozilla
								$(document).click(function() {
									$(document).unbind('click').unbind('keypress');
									if(o.addHoverClass)
									{
										srcElement.parent().removeClass("rowHoverFixed");
									}
									$(menu).hide();
									return false;
								});
							}, 0);

							srcElement.mouseout(function() {
								if(o.addHoverClass)
								{
									srcElement.parent().removeClass("rowHoverFixed");
								}
								srcElement.data("menuOn", false);
								handleMouseOut();
							});

							function handleMouseOut() {
								setTimeout(function() {
									if (!srcElement.data("menuOn")) {
										srcElement.unbind('mouseout');
										$(".contextMenu").unbind('mouseenter mouseleave');
										$(menu).hide();
										if(o.addHoverClass)
										{
											srcElement.parent().removeClass("rowHoverFixed");
										}
									}
								}, 200);
							}

							$(".contextMenu").hover(function() {
								if(o.addHoverClass)
								{
									srcElement.parent().addClass("rowHoverFixed");
								}
								srcElement.data("menuOn", true);
							},
								function() {
									if(o.addHoverClass)
									{
										srcElement.parent().removeClass("rowHoverFixed");
									}
									srcElement.data("menuOn", false);
									handleMouseOut();
								});
							return false;
						}
						return false;
					});
				});

				if(!$(document).data("menuActionAdded"))
				{
					// Disable text selection
					if ($.browser.mozilla) {
						$('#' + o.menu).each(function() { $(this).css({ 'MozUserSelect': 'none' }); });
					} else if ($.browser.msie) {
						$('#' + o.menu).each(function() { $(this).bind('selectstart.disableTextSelect', function() { return false; }); });
					} else {
						$('#' + o.menu).each(function() { $(this).bind('mousedown.disableTextSelect', function() { return false; }); });
					}
					$(document).data("menuActionAdded",true);
				}
				// Disable browser context menu (requires both selectors to work in IE/Safari + FF/Chrome)
				$(el).add($('UL.contextMenu')).bind('contextmenu', function() { return false; });

			});
			return $(this);
		},

		// Disable context menu items on the fly
		disableContextMenuItems: function(o) {
			if (o == undefined) {
				// Disable all
				$(this).find('LI').addClass('disabledMenu');
				return ($(this));
			}
			$(this).each(function() {
				if (o != undefined) {
					var d = o.split(',');
					for (var i = 0; i < d.length; i++) {
						$(this).find('A[href="' + d[i] + '"]').parent().addClass('disabledMenu');

					}
				}
			});
			return ($(this));
		},

		// Enable context menu items on the fly
		enableContextMenuItems: function(o) {
			if (o == undefined) {
				// Enable all
				$(this).find('LI.disabledMenu').removeClass('disabledMenu');
				return ($(this));
			}
			$(this).each(function() {
				if (o != undefined) {
					var d = o.split(',');
					for (var i = 0; i < d.length; i++) {
						$(this).find('A[href="' + d[i] + '"]').parent().removeClass('disabledMenu');

					}
				}
			});
			return ($(this));
		},

		// Disable context menu(s)
		disableContextMenu: function() {
			$(this).each(function() {
				$(this).addClass('disabledMenu');
			});
			return ($(this));
		},

		// Enable context menu(s)
		enableContextMenu: function() {
			$(this).each(function() {
				$(this).removeClass('disabledMenu');
			});
			return ($(this));
		},

		// Destroy context menu(s)
		destroyContextMenu: function() {
			// Destroy specified context menus
			$(this).each(function() {
				// Disable action
				$(this).unbind('mousedown').unbind('mouseup');
			});
			return ($(this));
		}

	});
})(jQuery);

function applyPrivsOnMenu(elem)
{
	var privs = "";
	var elemName = "";
	var ext = "";
	var hasPreview = false;
	var basket = false;
	if(elem)
		basket = elem.hasClass("contextMenuItem");
	basket = basket ? "_basket" : "";
	if($("body").data("currentView" + basket) == "Thumbnail"){
		if(elem.data("dataRow")){
			privs = elem.data("dataRow").privs.toString();
			hasPreview = elem.data("dataRow").preview.toString() != "0";
		}
		if(!elem.hasClass("directoryThumb"))
		{
			if(basket)
				elemName = unescape(elem.find("a.imgLink").find("img").attr("alt"));
			else
				elemName = elem.find("a.imgLink").find("img").attr("alt");
		}
	}
	else {
		privs = unescape(elem.attr("privs"));
		hasPreview = elem.attr("preview") &&  elem.attr("preview") != "0";
		if(basket)
		{
			var dataRow = elem.parent().data("dataRow");
			if(dataRow){
				privs = dataRow.privs.toString();
				hasPreview = dataRow.preview.toString() != "0";
			}
		}
		if(!elem.hasClass("directory"))
		{
			if(basket)
				elemName = unescape(elem.find("a:first").attr("rel"));
			else
				elemName = elem.find("a:first").attr("href");
		}
	}
	if(elemName && elemName.length>0)
	{
		var getFileExtension = function(filename) {
			var ext = /^.+\.([^.]+)$/.exec(filename);
			return ext == null ? "" : ext[1].toLowerCase();
		}
		ext = getFileExtension(elemName);
	}
	if(privs && privs.length>0) {
		var myMenu = $("#myMenu");
		myMenu.find("li").show();
		var _delete = privs.indexOf("(delete)")>=0;
		var _write = privs.indexOf("(write)")>=0;
		var _resume = privs.indexOf("(resume)")>=0;
		var _share = privs.indexOf("(share)")>=0;
		var _slideshow = privs.indexOf("(slideshow)")>=0;
		var _rename = privs.indexOf("(rename)")>=0;
		var _makedir = privs.indexOf("(makedir)")>=0;
		var _deleteDir = privs.indexOf("(deletedir)")>=0;
		var _download = privs.indexOf("(read)")>=0;
		var _sync = privs.indexOf("syncName=")>=0;

		if(elem.hasClass("directory") || elem.hasClass("directoryThumb")) {
			if(!_deleteDir){
				myMenu.find(".delete").hide();
			}
			if(!_write){
				myMenu.find(".upload").hide();
			}
			myMenu.find("a[command*='changeIcon']").parent().hide(); // Hide changeicon for directories
		}
		if(!_write)
		{
			myMenu.find("li.cut, li.copy, li.paste").hide();
			myMenu.find("a[command*='updateKeywords']").parent().hide();
			myMenu.find("a[command*='changeIcon']").parent().hide();
		}
		if(!_delete){
				myMenu.find(".delete").hide();
		}
		if(!_download){
				myMenu.find(".dwnld").hide();
				myMenu.find("li.cut, li.copy, li.paste, li.zip").hide();
				myMenu.find("a[command*='addToBasket']").parent().hide();
				myMenu.find("a[command*='download']").parent().hide();
				myMenu.find("a[command*='Download']").parent().hide();
		}
		if(!_rename){
				myMenu.find(".rename").hide();
		}
		if(!_share){
				myMenu.find(".share").hide();
		}
		if(!_makedir){
				myMenu.find(".makedir").hide();
				myMenu.find("a[command*='createFolder']").parent().hide();
		}
		if(!_sync)
		{
			myMenu.find("a[command*='popupManageSync']").parent().hide();
		}
		var preview = false;
		if(ext.length>0)
		{
			if(window.mediaFileExtensions.has(ext))
			{
				preview = true;
			}
		}
		if(preview || _slideshow)
		{
			myMenu.find("a[command*='quickView'],a[command*='Preview']").show();
		}
		/*}*/
		if(typeof window.noCopyLinkOnContextMenu !="undefined")
		{
			myMenu.find(".copydirectlink").remove();
		}
		if(!hasPreview && !window.mediaFileExtensions.has(ext)){
			myMenu.find("a[command*='slideshow'], a[command*='quickView'], a[command*='downloadLowRes'],a[command*='Preview']").each(function(){
				$(this).parent().hide();
			});
		}
		else
		{
			if(!preview && !_slideshow){
				myMenu.find("a[command*='downloadLowRes']").each(function(){
					$(this).parent().hide();
				});
			}
			else
			{
				myMenu.find("a[command*='slideshow'], a[command*='quickView'], a[command*='downloadLowRes'],a[command*='Preview']").each(function(){
					$(this).parent().show();
				});
			}
		}
		if(basket)
		{
			myMenu.find("a[command*='addToBasket']").parent().hide();
			myMenu.find("a[command*='showBasket']").parent().hide();
		}
		myMenu.find("li.custom").show();
	}
}