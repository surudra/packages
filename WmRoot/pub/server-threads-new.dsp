
<HTML>
   <HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


      <TITLE>Integration Server Threads
      </TITLE>
      <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
      <SCRIPT src="webMethods.js.txt"></SCRIPT>
      
      
    <SCRIPT LANGUAGE="JavaScript">

      function confirmAction(action, name)
      {
         var s1 = "OK to " + action + " the thread: '" + name + "' ?";
         if ( confirm (s1) ) {
		return true;         
         }
         else {
         	return false;
         }
      }
      
      </SCRIPT>
      
   </HEAD>
   <BODY onLoad="setNavigation('stats-general.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Server_SysThreadsScrn');">
      <DIV class="position">
         <TABLE width="100%">

	     %ifvar action equals('kill')%  %invoke wm.server.query:killThread%
	     %endinvoke%  %endif%

	     %ifvar action equals('interrupt')%  %invoke wm.server.query:interruptThread%
	     %endinvoke%  %endif%

	     %invoke wm.server.query:getThreadList%

            <TR>
               <TD class="menusection-Server" colspan=5>Server &gt; Statistics &gt; System Threads</TD>
            </TR>
            <TR>
              <TD colspan=2>
			  <UL>
				  <LI><A HREF="stats-general.dsp">Return to Server Statistics</A></LI>
				  <LI><A HREF="server-thread-dump.dsp">Generate JVM Thread Dump</A></LI>
				  <LI><input type="checkbox" id="ssot" align="right" onclick="executeAction(this)" %ifvar checked equals('true')% checked %endif%>Show threads that can be canceled or killed at the top of the list.</LI>
			  </UL>


            <TR>
               <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
               <TD>
                  <!-- Thread table -->
                  <IMG SRC="images/blank.gif" height=10 width=10>
                  <TABLE class="tableView" id="servicecon" CELLPADDING=2>
                  
                     <TR>
                        <TD class="heading" colspan=9>System Threads</TD>
                     </TR>
                     <TR>
                        <TD class="oddcol">Priority</TD>
                        <TD class="oddcol-l">Name</TD>
                        <TD class="oddcol">Alive</TD>
                        <TD class="oddcol">Daemon</TD>
                        <TD class="oddcol">Interrupted</TD>
                        <TD class="oddcol">Cancel</TD>
                        <TD class="oddcol">Kill</TD>
                        <TD class="oddcol">Start Time</TD>
                        <TD class="oddcol">Protocol</TD>
                        <script>resetRows();</script>
                     </TR> %loop threads%
                     <TR id="%ifvar cancancel equals('true')%%value $index%run%else%%ifvar cankill equals('true')% %value $index%run%value $index%run%else%%value $index%%endif%%endif%">
                        <script>writeTD('rowdata');</script>%value priority%</TD>
                        <script>writeTD('rowdata-l');</script>
                        <A class="imagelink" href="single-server-thread-dump.dsp?threadID=%value threadid -urlencode%">%value name%</A></TD>
                        <script>writeTD('rowdata');</script>
                            %ifvar alive equals('true')%<IMG SRC="images/green_check.gif" height=13 width=13>%else%-%endif%</TD>
                        <script>writeTD('rowdata');</script>
                            %ifvar daemon equals('true')%<IMG SRC="images/green_check.gif" height=13 width=13>%else%-%endif%</TD>
                        <script>writeTD('rowdata');</script>
                            %ifvar interrupted equals('true')%<IMG SRC="images/green_check.gif" height=13 width=13>%else%-%endif%</TD>
                        <script>writeTD('rowdata');</script>
                            %ifvar cancancel equals('false')%
                            	  <IMG SRC="images/green_check.gif" height=13 width=13>
                            %else%
                            	  %ifvar cancancel equals('true')%
                            	  	<A class="imagelink" href="server-threads-new.dsp?action=interrupt&threadID=%value threadid -urlencode%" onClick="return confirmAction('cancel', '%value name%');"><IMG src="images/yellow_check.gif" border=0></A>
                            	  %else%
                            	  	-
                            	  %endif%	
                            %endif%</TD>
			<script>writeTD('rowdata');</script>
			    %ifvar cankill equals('true')%
			      <A class="imagelink" href="server-threads-new.dsp?action=kill&threadID=%value threadid -urlencode%" onClick="return confirmAction('kill', '%value name%');"><IMG src="icons/delete.gif" border=0></A>
			    %else%
			    	%ifvar cankill equals('false')%
			    		<IMG src="icons/delete_disabled.gif" border=0>
			    	%else%	
			    		-
			    	%endif%			    
			    %endif%</TD>    
			<script>writeTD('rowdata');</script>%value startedat%</TD>	
			<script>writeTD('rowdata');</script>%value protocol%</TD>		
                        <script>swapRows();</script>
                     </TR> %endloop%
                  </TABLE>
                  <!-- Threads table --> %endinvoke%  </TD>
            </TR>
         </TABLE>
      </DIV>
   </BODY>
</HTML>

<script>

var firefox = false;
if(navigator.userAgent.indexOf("Firefox")!=-1){
	firefox = true;
}

var stateChanged = false;
var originalURL;
var tempURL = window.location+"";
var index=tempURL.indexOf("?");
if(index!=-1){
	originalURL = tempURL.substring(0,index);
} else {
	originalURL = tempURL ;
}

function showRunningServicesOnTop(){

stateChanged=false;
var replaceCount = 2;
var table = document.getElementById('servicecon');
var rows = table.rows;

for(var i=2;i<rows.length;i++){
	if(rows[i].id.indexOf("run") != -1){
	if(firefox){
		var a = rows[replaceCount].innerHTML;
		rows[replaceCount].innerHTML= rows[i].innerHTML;
		rows[i].innerHTML=a;
	} else {
		rows[replaceCount].swapNode(rows[i]);	
	}
	replaceCount++;
	}
}
if(replaceCount==2){
	return;
}
stateChanged = true;
resetRows();
for(var i=2;i<rows.length;i++){
	var cells = rows[i].cells;
	cells[0].className=row+"rowdata";
	cells[1].className=row+"rowdata-l";
	for(var j = 2;j<cells.length;j++){
		cells[j].className=row+"rowdata";
	}
	swapRows();
}
}

function executeAction(checkbox){
	if(checkbox.checked){
		//showRunningServicesOnTop();
		refreshPage();
	} else {
		refreshPage();
		//window.location.href=originalURL;
	}
}

function refreshPage(){
	var checkBox = document.getElementById("ssot");
	var url = originalURL;
	if(checkBox.checked){
		url=url+"?checked=true";
	}
	else {
		url=url+"?checked=false";
	}
	if(is_csrf_guard_enabled && needToInsertToken) {
		window.location.href=url+"&"+ _csrfTokenNm_ + "=" + _csrfTokenVal_;
	} else {
		window.location.href=url;
	}
}

%ifvar checked equals('true')% showRunningServicesOnTop(); %endif%

</script>
