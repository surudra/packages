
<HTML>
  <HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">

    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt"></SCRIPT>

    <SCRIPT LANGUAGE="JavaScript">
    var agent = navigator.userAgent.toLowerCase();   
    var ie = (agent.indexOf("msie") != -1);

    var margin = 2;
    var modified = false;
    

    window.onbeforeunload = checkModified;
    function checkModified()
    {

		if (modified)
		{
			//event.returnValue = '--- Logging changes have not been saved. ---';
			return '--- Logging changes have not been saved. ---';
		}
    }

      
    function getThreshold (index)
    {

	switch(index){
	case 0:
	    return 'Off';
	    break;
	case 1:
	    return 'Fatal';
	    break;
	case 2:
	    return 'Error';
	    break;
	case 3:
	    return 'Warn';
	    break;
	case 4:
	    return 'Info';
	    break;
	case 5:
	    return 'Debug';
	    break;
	case 6:
	    return 'Trace';
	    break;
	default:
	    return 'Undefined';
	}
    }

    function getThresholdDisplayFromValue (value)
    {
	if ( value == "Off" ) {
		return "Off";
	}
	
	if ( value == "Fatal" ) {
		return "Fatal";
	}

	if ( value == "Error" ) {
		return "Error";
	}

	if ( value == "Warn" ) {
		return "Warn";
	}

	if ( value == "Info" ) {
		return "Info";
	}

	if ( value == "Debug" ) {
		return "Debug";
	}

	if ( value == "Trace" ) {
		return "Trace";
	}
	
	return "Undefined";
    }
    
    function onEdit ()
    {
      var loc = "settings-logging.dsp?doc=edit";
	  if(is_csrf_guard_enabled && needToInsertToken) {
		document.location.replace(loc+"&"+_csrfTokenNm_+"="+_csrfTokenVal_);
	  } else {
		document.location.replace(loc);
	  }
    }


    function toggleNode(node){
	var body=document.getElementById("Default");
 	rows = body.rows;
	
	if (node.childNodes.item(0).src.indexOf('plus') !=-1){
	    node.childNodes.item(0).src = "images/minus.gif";
	    for(var i = 3; i < rows.length; i++){
	    	var title=rows[i].title;
		if(title!=null && title.length>0){
		var image=document.getElementById('img'+rows[i].title);
		image.src = "images/plus.gif";		
		
		    if (ie) {
	   		rows[i].style.display="block";
	   	    }else{
	   	  	rows[i].style.display="block";
			rows[i].style.display="table-row";
		    }
		}
	    }
	}else{
	    node.childNodes.item(0).src = "images/plus.gif";
	    for(var i = 3; i < rows.length; i++)
                rows[i].style.display="none";  
		
	}
	restripe();

    }



    function toggle(node, bodyName)
    {

	var body=document.getElementById(bodyName);
	var image=document.getElementById('img'+bodyName);

	rows = body.rows;
	
	if (image.src.indexOf('plus') !=-1){
		image.src = "images/minus.gif";

		for(i = 0; i < rows.length; i++){
		   if (ie) {
   		     rows[i].style.display="block";
   		   }else{
   		     rows[i].style.display="block";
		     rows[i].style.display="table-row";
		   }
		}
	}else{
		image.src = "images/plus.gif";
	
		for(i = 0; i < rows.length; i++)
		    rows[i].style.display = 'none';

	}
	restripe();
    }



    var inheritedVar;
    function beforeChange(value)
    {
	inheritedVar = value;
    }
    
    function spreadNodeChange(box, oldVar){
      	var newVar = box.selectedIndex;

       	var body=document.getElementById("Default");

       	var rows = body.rows;

	var length = rows.length;
    	for(var i = 3; i < length; i++){

    	    title=rows[i].title;

	    if(title!=null && title.length>0){

       	        cells = rows[i].cells;
    	        nodes = cells[1].childNodes;//2nd td
    		for(var j = 0; j < nodes.length; j++){
    		    
    		    if(nodes[j].nodeName=='SELECT'){
    		    	var int = nodes[j].selectedIndex;
    			//changing text
    			options = nodes[j].options;
    			options[oldVar].text = getThreshold(oldVar); 
			options[oldVar].style.color="#000000";
			options[oldVar].style.fontWeight="bold";
    			options[newVar].text = options[newVar].text; 
			options[newVar].style.color="#657383";
			options[newVar].style.fontWeight="normal";
    			if(int==oldVar){
    			    nodes[j].selectedIndex = newVar;
			    //spread over children
    			    spreadChange(nodes[j], oldVar);
    
    			}else{//if inherited var
    			   // alert('int: '+int+'oldVar: '+oldVar);////////
    			
    			}
			nodes[j].style.color=options[nodes[j].selectedIndex].style.color;
			if(nodes[j].selectedIndex==newVar)
			    nodes[j].style.fontWeight="normal";
			else
			    nodes[j].style.fontWeight="bold";
			break; //we are done with this loop
    		    }//if SELECT
		
       	    	}//for j
       	    }//if

       	}//for i
	inheritedVar = newVar; //reset just in case focus in not refreshed for nexttime
    }

    function spreadChange(box, oldVar){
      	var newVar = box.selectedIndex;
    	var title = box.title;

    	if (title.length > 0){
       	    var body=document.getElementById(title);
       	    var rows = body.rows;

    	    for(var i = 0; i < rows.length; i++){
    	    	var cells = rows[i].cells;
    		var nodes = cells[1].childNodes;//2nd td
    		for(var j = 0; j < nodes.length; j++){
    		    if(nodes[j].nodeName=='SELECT'){
    		    	var int = nodes[j].selectedIndex;
    			//changing text
    			options = nodes[j].options;
    			options[oldVar].text = getThreshold(oldVar); 
			options[oldVar].style.color="#000000"
			options[oldVar].style.fontWeight="bold"
    			options[newVar].text = options[newVar].text; 
			options[newVar].style.color="#657383"
			options[newVar].style.fontWeight="normal"
    			if(int==oldVar){
    			    nodes[j].selectedIndex = newVar;
    			}else{//if inherited var
    			   // alert('int: '+int+'oldVar: '+oldVar);
    			
    			}

			nodes[j].style.color=options[nodes[j].selectedIndex].style.color;
			if(nodes[j].selectedIndex==newVar)
			    nodes[j].style.fontWeight="normal";
			else
			    nodes[j].style.fontWeight="bold";
			break;
    		    }//if SELECT
       	    	}//for j
       	    }//for i
       	}//if
	inheritedVar = newVar; //reset just in case focus in not refreshed for nexttime
    }
    
    function afterChange(box)
    {
    	if(box.title!=null&&box.title=="Default"){
    	    var textbox=document.getElementById("debugLevel");
    	    textbox.value = box.value;
   	    spreadNodeChange(box, inheritedVar);
    	}else{
  	    spreadChange(box, inheritedVar);
  	}
    }

    function commonChange(box)
    {
	modified=true;
	var newVar = box.selectedIndex;
	box.style.color=box.options[newVar].style.color;
	if(box.options[newVar].style.color =="rgb(101, 115, 131)" || box.options[newVar].style.color=="#657383")
	    box.style.fontWeight="normal";
	else
	    box.style.fontWeight="bold";
    }

    function changeStatus(id, status)
    {
      	var tag=document.getElementById(id);
    	tag.childNodes[0].nodeValue = status;
    }



    function writeOptions(value, parentValue){
       for(var i = 0;i < 7;i++){
       	   var threshold = getThreshold(i);
           w(IWebOption(threshold, parentValue, threshold==value));
       }
     }

    function IWebOption(value, parentValue, selected){
      option = "<OPTION value=\""+value+"\" style=\"color:";
      if(value==parentValue)
          option = option + "#657383; font-weight:normal\"";
      else
          option = option + "#000000; font-weight:normal\"";

      option = option + " value='value'";
      
      if(selected)
          option = option + " selected";
      
      displayText = getThresholdDisplayFromValue(value);
      
      return option+">"+displayText+"</OPTION>";
    }   


    function writePreview(value, parentValue){
       w(IWeb(value, parentValue));
    }
        
   

    function IWeb(value, parentValue){
    
      	displayText = getThresholdDisplayFromValue(value);
    
	if(value==parentValue)
	    return  "<SPAN style='color:#657383; font-weight:normal'>" + displayText + "</SPAN>";
	else
	    return  "<SPAN style='color:#000000; font-weight:bold'>" + displayText + "</SPAN>";
    }   

   

    function end(bodyName){

	var body=document.getElementById(bodyName);
	
	rows = body.rows;	
	lastrow = rows[rows.length-1];
    	cell = lastrow.cells[0]//1st cell;
    	nodes = cell.childNodes;
    	for(var j = 0; j < nodes.length; j++){
    	    if(nodes[j].nodeName == "IMG" && nodes[j].src.indexOf('link') !=-1)
    	    	nodes[j].src = "images/lastlink.gif"
	}
		
    }

    function restripe(){
	var body=document.getElementById("Default");

	var rows = body.rows;

	resetRows();
	//loop through each child
    	for(var i = 2; i < rows.length; i++){
	    if(rows[i].style.display != 'none'){
	        rows[i].cells[0].className=row+"rowdata-l";
	        rows[i].cells[1].className=row+"rowdata"
		swapRows();	    
	    }
       	}//for i
    }



    function getData(listboxName){
	var body=document.getElementById("Default");
	var listbox=document.getElementById(listboxName);

	var rows = body.rows;
	
	//loop through each child
    	for(var i = 3; i < rows.length; i++){
    	    cells = rows[i].cells;
    	    nodes = cells[1].childNodes;//2nd td
    	    for(var j = 0; j < nodes.length; j++){

              if(nodes[j].nodeName=='SELECT'){
            	var select = nodes[j];
          	
   		//this part only includes non-inherited props
		if(!(select.style.color =="rgb(101, 115, 131)" || select.style.color=="#657383")){
  		    var option = document.createElement("OPTION");
  		    var text=select.name;
  		    if (text==null || text.length==0)
  		        text=select.title;
 		    option.value = text+'='+getThreshold(select.selectedIndex);
 		    option.selected=true;
 		    listbox.appendChild(option);
       	      	}//end if
        	///////////////////////////////////////////////    
       	      }
       	    }//for j
       	}//for i
    }

    function submit(){
  	getData('facilityList');
	document.logform.submit();
    }


    </SCRIPT>


  </HEAD>

  %ifvar doc equals('edit')%
  <BODY onLoad="setNavigation('settings-logging.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditServerLoggerScrn');">
  %else%
  <BODY onLoad="setNavigation('settings-logging.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_ServerLoggerScrn');">
  %endif%
    <TABLE width="100%">
        <TR>
           <TD class="menusection-Settings" colspan=2>
                Settings &gt;
                Logging

                %ifvar doc equals('edit')%
                    &gt; Edit Server Logger Details
                %else%
                    &gt; View Server Logger Details
                %endif%
           </TD>
        </TR>
 %ifvar action equals('change')%
    %invoke wm.server.admin:setSettings%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
            <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message%</TD></TR>
        %endif%
    %endinvoke%
%endif%
%invoke wm.server.query:getSettings%
       %ifvar ../doc equals('edit')%


                      <TR>
                    <TD colspan=2>
                      <UL>
                        <li><a href="settings-auditing.dsp">Return to Logger List</a></li>
                        <LI><a href="settings-logging.dsp">Return to View Server Logger Details</a></li>
                      </UL>
                    </TD>
                   </TR>

        %else%
            <FORM name="logform" action="stats-getlog.dsp" method="POST">
              <INPUT type="hidden" name="log" value="xxx">
              <TR>
                <TD colspan=2>
                  <UL>
                    <li><a href="settings-auditing.dsp">Return to Logger List</a></li>
                    <LI><a href="javascript:onEdit();" >Edit Server Logger</a></li>
                  </UL>
                </TD>
               </TR>
            </FORM>
        %endif%
        <TR>
        <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
        <TD>

          <TABLE class="%ifvar ../doc equals('edit')%tableForm%else%tableView%endif%">
            %ifvar ../doc equals('edit')%

              <FORM name="logtreeform" method="POST">

            %else%
 	      <FORM name="chooseform" action="settings-logging.dsp" method="POST">
            %endif%
<!--- start here -->
<TR>
 <TD colspan="3">
  <TABLE id="Default">	
            <TR>
               <TD CLASS="heading" colspan="2" width="360">Server Logger Configuration<SPAN id="loggerstatus" style='font-family:monospace;font-size:14;font-style:italic'>&nbsp;</SPAN></TD>

            <script>resetRows();</script>

            <TR>
               <TD CLASS="oddcol-l">Facility</TD>
               <TD CLASS="oddcol">Logging Level</TD>

            </TR>
	    <TR>
                <TD CLASS="evenrowdata-l">
                    <A onClick="toggleNode(this)"><img id="imgDefault" src="images/minus.gif">Default</A>
                </TD>
		<TD CLASS="evenrowdata">
		%ifvar ../doc equals('edit')%
		    <SELECT title="Default" onfocus="beforeChange(this.selectedIndex)" onchange="commonChange(this);afterChange(this)" style="font-weight:bold;width:80px">
			<SCRIPT>writeOptions('%value DebugLevel%','FOO');</SCRIPT>
		    </SELECT>
		%else%
		    <script>writePreview('%value DebugLevel%', 'FOO');</script>
		%endif%
                </TD>    
             </TR>
             <SCRIPT>resetRows();swapRows();</SCRIPT>
<!--	     <TBODY id="Default">-->
	     %loop Components% 
	        <TR title="%value CompCode%">
                    <SCRIPT>writeTD('rowdata-l');</SCRIPT>
                        <A onClick="toggle(this,'%value CompCode%');">&nbsp;&nbsp;&nbsp;<img id="img%value CompCode%" src="images/plus.gif">%value CompDesc%</A>
                    </TD>
                    <SCRIPT>writeTD('rowdata');swapRows();</SCRIPT>
		    %ifvar ../../doc equals('edit')%
		       %ifvar Threshold vequals(../DebugLevel)%
   		        <SELECT title="%value CompCode%" onfocus="beforeChange(this.selectedIndex)" onchange="commonChange(this);afterChange(this)" style="color:#657383;width:80px" >
		       %else%
   		        <SELECT title="%value CompCode%" onfocus="beforeChange(this.selectedIndex)" onchange="commonChange(this);afterChange(this)" style="font-weight:bold;width:80px">		        
		       %endif%
			    <SCRIPT>writeOptions('%value Threshold%','%value ../DebugLevel%');</SCRIPT>
			</SELECT>
		    %else%
		    	<script>writePreview('%value Threshold%', '%value ../DebugLevel%');</script>
		    %endif%
                    </TD>    
                </TR>                  
 		<TBODY id="%value CompCode%">
                  %loop Facs%
                  <TR style='display:none'> 
                    <TD CLASS="evenrow-l">
			&nbsp;&nbsp;&nbsp;&nbsp;<img src="images/link.gif">&nbsp;%value FacCode% &nbsp; %value FacDesc%
		    </TD>
		    <TD>
		    %ifvar ../../../doc equals('edit')%
		       %ifvar Threshold vequals(../Threshold)%
		        <SELECT name="%value ../CompCode%.%value FacCode%" onchange="commonChange(this);" style="color:#657383;width:80px">
		       %else%
		        <SELECT name="%value ../CompCode%.%value FacCode%" onchange="commonChange(this);" style="font-weight:bold;width:80px">
		       %endif%
			    <SCRIPT>writeOptions('%value Threshold%','%value ../Threshold%');</SCRIPT>
			</SELECT>
		    %else%
		    	<script>writePreview('%value Threshold%', '%value ../Threshold%');</script>
		    %endif%
                    </TD>    
		  </TR>
                  %endloop%
  	    	</TBODY>
	    %endloop% <!-- components -->
	  <!--</TBODY>-->
  </TABLE>
  </TD>
 </TR>
 <TR>
 <script>writeTDspan("row-l","9");</script>
 	NOTE: <SPAN style='color:#657383'><b>GRAY</b></SPAN> text signifies inherited from parent.
 </TD>
 </TR>

<TR><TD>
</FORM>
            <FORM name="logform" action="settings-logging.dsp" method="POST">
              <INPUT type="hidden" name="logSettings" value="true">
              <INPUT type="hidden" name="action" value="change">
              <INPUT type="hidden" id="debugLevel" name="watt.debug.level" value="%value DebugLevel%">
	      <SELECT style="display:none" id="facilityList" name="facility" multiple=true>
	       </SELECT>
</TD>


</TR>
<!-- end here --> 
 
 <!-- Hiding E-mail Notification, will be moved to Settings--Resources 
 
 	    <TR>
                <TD class="space" colspan="3">&nbsp;</TD>
            </TR>

            <TR>
                <TD class="heading" colspan=3>Email Notification</TD>
            </TR>
            <TR>
                <TD class="oddrow">SMTP Server</TD>
                <TD class="%ifvar ../doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%" colspan=2><script>
                    writeEdit("%value ../doc%", "watt.server.smtpServer", "%value watt.server.smtpServer%"); </script>
                </TD>
            </TR>
            <TR>
                <TD class="evenrow">Internal Email</TD>
                <TD class="%ifvar ../doc equals('edit')%evenrow-l%else%evenrowdata-l%endif%" colspan=2><script>
                    writeEdit("%value ../doc%", "watt.server.errorMail", "%value watt.server.errorMail%"); </script>
                </TD>
            </TR>
            <TR>
                <TD class="oddrow">Service Email</TD>
                <TD class="%ifvar ../doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%" colspan=2><script>
                    writeEdit("%value ../doc%", "watt.server.serviceMail", "%value watt.server.serviceMail%"); </script>
                </TD>
            </TR>
            <TR>
                <TD class="evenrow">Default Email Charset</TD>
                <TD class="%ifvar ../doc equals('edit')%evenrow-l%else%evenrowdata-l%endif%" colspan=2><script>
                    writeEdit("%value ../doc%", "watt.server.email.charset", "%value watt.server.email.charset%"); </script>
                </TD>
            </TR>

--> 
            <TR>
                <TD class="space" colspan="3">&nbsp;</TD>
            </TR>

            <TR>
                <TD class="heading" colspan=3>Log Timestamp Format</TD>
            </TR>
            <TR>
                <TD class="oddrow">Format</TD>
                <TD class="%ifvar ../doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%" colspan=2><script>
                    writeEdit("%value ../doc%", "watt.server.dateStampFmt", "%value -code watt.server.dateStampFmt%"); </script>
                </TD>
            </TR>
            %ifvar ../doc equals('edit')%
		<tr>
			<td class="evenrow">Example Format</td>
			<td class="%ifvar ../doc equals('edit')%evenrow-l%else%evenrowdata-l%endif%">yyyy-MM-dd HH:mm:ss</td>
		</tr>
	    %endif%
            </FORM>
          %ifvar ../doc equals('edit')%
            <TR>
                <TD colspan=3 class="action">
                    <INPUT onclick="modified = false;submit();" type="submit" value="Save Changes" name="submit">
                </TD>
            </TR>
           %endif%



 %endinvoke%
          </TABLE> </TD>
      </TR>
    </TABLE>
  </DIV>
</HTML>
