<HTML>
<HEAD>
<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
<script src="menu.js.txt"></script>
<style>
body {     border-top: 1px solid #97A6CB; }
</style>
<script type="text/javascript">
function toggle(parent, id, imgId) {
	var set = 'none';
	var image = document.getElementById(imgId);
	if(parent.getAttribute('manualhide') == 'true') {
		set = 'table-row';
		parent.setAttribute('manualhide', 'false');
		image.src = 'images/expanded.gif';
	} else {
		parent.setAttribute('manualhide', 'true');
		image.src = 'images/collapsed.gif';
	}
	var elements = getElements("TR", id);

	for ( var i = 0; i < elements.length; i++) {
		var element = elements[i];
		//alert(element.getAttribute("name"));
		element.style.cssText = "display:"+set;
	}
}

function getElements(tag, name) {
	var elem = document.getElementsByTagName(tag);
	var arr = new Array();
	for(i=0, idx=0; i<elem.length; i++) {
		att = elem[i].getAttribute("name");
		if(att == name) {
			arr[idx++] = elem[i];
		}
	}
	return arr;
}
</script>
</HEAD>
%invoke wm.server.ui:mainMenu%
<BODY CLASS="menu" onload="initMenu('%value buttonUrls/sections[0]/submenu[2]/url%');">



<TABLE WIDTH="100%" cellspacing=0 cellpadding=1 border=0>

%scope buttonUrls%
%loop sections%

		%ifvar name equals('hide')%
		%else%
			%ifvar value text equals('Server')%
				<TR manualhide="false" onClick="toggle(this, '%value text%_subMenu', '%value text%_twistie');" OnMouseOver="this.className='cursor';">
				<TD CLASS="menusection-%value name%">
					   <img id='%value text%_twistie' src="images/expanded.gif">&nbsp;%value text%
					</TD>
				</TR>
			%else%
				<TR manualhide="true" onClick="toggle(this, '%value text%_subMenu', '%value text%_twistie');" OnMouseOver="this.className='cursor';">
					<TD CLASS="menusection-%value name%">
						<img id='%value text%_twistie' src="images/collapsed.gif">&nbsp;%value text%
					</TD>
				</TR>
			%endif%
%loop submenu%
        
	%ifvar url -notempty%
	<!--<TR>-->
	
		%ifvar value value ../text equals('Server')%
			<TR name="%value ../text%_subMenu" style="display: table-row">
		%else%
			
			<TR name="%value ../text%_subMenu" style="display: none">
		%endif%
    <TD id="i%value encode(htmlattr) url%"
        %ifvar url equals('nonedsp')%
          class="menuitem-unclickable"
        %else%
          class="menuitem"
          onmouseover="menuMouseOver(this, '%value encode(htmlattr) url%');"
          onmouseout="menuMouseOut(this);"
          onclick="document.all['a%value encode(htmlattr) url%'].click();"
        %endif%>
    <nobr>
	%ifvar url equals('dummy-horizontal-linedsp')%
	   <hr/>
	%else%
		%ifvar url equals('nonedsp')%
			%value none text%
		%else%
		<img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><img valign="middle"
				%ifvar url%id="%value encode(htmlattr) url%" name="%value encode(htmlattr) url%"%endif%
				src="images/blank.gif"
				height="8" width="8" border="0">
		   
			
					<A id="a%value encode(htmlattr) url%" TARGET="%ifvar target%%value $host%%value target%%else%body%endif%" HREF="%value encode(htmlattr) url%"	%ifvar noarrow%%else%onclick="menuMove('%value encode(htmlattr) url%', %ifvar target%'%value target%'%else%'body'%endif%); return true;"%endif%>

					<script type="text/javascript">
					if( IE() )
						{
							document.write("</a>");
						}
					</script>

					<span class="menuitemspanie">%value text%%ifvar target%...%endif%</span></a>



		%endif%
	%endif%	
    </nobr></TD></TR>
    %else%
    %endif%
%endloop%
<tr>
<td class="menuseparator"><img src="images/blank.gif" width="3" height="3" border="0"></td>
</tr>
%endif%

    %endloop%
%endscope%
</TABLE>

<div style="height=0; width=0">
<form name="urlsaver">
<input type="hidden" name="helpURL" value="/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Server_SrvrStatsScrn">
</form>
</div>

</BODY>
</HTML>
