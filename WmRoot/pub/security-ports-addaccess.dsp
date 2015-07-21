<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <script src="client.js.txt"></script>
    <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
    <TITLE>Integration Server -- Port Access Management -- Add Folders and Services</TITLE>
  </HEAD>

  <body onLoad="setNavigation('security-ports.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_AddFldrsSvcsScrn');">

    <TABLE width="100%">
      <TR>
        <TD class="menusection-Security" colspan=2>
          Security &gt;
          Ports &gt;
          Add Folders and Services &gt;
          %value port% </TD>
      </TR>

      <TR>
        <TD colspan=2>
          <UL>
            <LI><a href="security-ports-editaccess.dsp?port=%value port encode(url)%">Return to Edit Access Mode</a></LI>
          </UL>
      </TR>
      <tr><td><img src="images/blank.gif" height=10 width=10></td>
      <td>
    %invoke wm.server.portAccess:getPort%
    <FORM action="security-ports-editaccess.dsp" method="POST" name="form" id="form">
    <INPUT TYPE="HIDDEN" NAME="Action" VALUE="addNode">
    <INPUT TYPE="HIDDEN" NAME="port" VALUE="%value port%">

      <TABLE class="tableForm" width="100%">
        <TR>
          <TD class="heading" colspan=3>
          %switch type%
            %case 'include'%
                Add Folders and Services to Deny List
            %case 'exclude'%
                Add Folders and Services to Allow List
          %endswitch%
          </TD>

        </TR>
        <TR>
          <TD class="oddcol-l">Enter one folder or service per line</TD>
          <TD class="oddcol-l">Select a set of folders and services</TD>
        </TR>
        <TR>
          <TD class="evencol-l">
            <textarea style="width=100%" wrap=off rows=15 name="services" id="services"></textarea>
          </TD>
          <TD class="evencol-l">
            <select name="show" id="show" onchange="changeShow(showList.options[showList.selectedIndex].value); ">
                  <option value="0">-- Select an ACL --</option>
              %invoke wm.server.admin:getNodeInfo%
                %loop ACLs%
                  %switch name%
                    %case 'none'%
<!--                      <option value="%value name%">&lt;Default ACL&gt;</option> -->
                    %case%
                      <option value="%value name%">%value name%</option>
                  %endswitch%
                %endloop%
              %endinvoke%
            </select>
            <BR>
            <select style="width=100%" multiple size=10 name="staging" id="staging">
              <option value="0">------------------none------------------</option>
            </select>
            <BR><div class="action" style="text-align: center;">
            <input class="button2" type="button" name="populate" value="&lt;-- Append Selected" onclick="copySelected();"></div>
          </td>
        </TR>
        <TR>
          <TD class="action" colspan=3>
            <INPUT type="submit" name="submit" value="Save Additions">
            <input type="button" value="Clear Entries" name="clear" onclick="clearBox();">
          </TD>
        </TR>
      </TABLE>
    </FORM>
          </TD>
        </TR>
      </TABLE>


<script>

  var ACLNodes = new Array();

  var stagingList  = document.form.staging;
  var showList     = document.form.show;
  var servicesData = document.form.services;
  servicesData.value = "";

  function selectAll()
  {
    for(var i = 0; i < stagingList.length; i++)
    {
      stagingList.options[i].selected = true;
    }
  }

  function selectNone()
  {
    for(var i = 0; i < stagingList.length; i++)
    {
      stagingList.options[i].selected = false;
    }
  }

  function clearBox()
  {
    if( confirm("All enteries will be cleared.  Are you sure?"))
    {
      servicesData.value="";
    }
  }

  function copySelected()
  {
    var temp = "";

    for(var i = 0; i < stagingList.length; i++)
    {
      if(stagingList.options[i].selected == true)
      {
         temp = temp + stagingList.options[i].text + "\n";
      }
    }

    servicesData.value = servicesData.value + temp;

    selectNone();
  }

  function addACL(ACL, nodes)
  {
    ACLNodes[ACL] = ["placeholder"];
    ACLNodes[ACL].length = 0;

    for(node in nodes)
    {
      ACLNodes[ACL][nodes[node]] = nodes[node];
    }
  }

  function changeShow(newShow)
  {
    clearList(stagingList);
    var nodeList = ACLNodes[newShow];

    for(i in nodeList)
    {
      insertOption(nodeList[i],nodeList[i],stagingList,true);
    }

    selectAll();
  }

  %invoke wm.server.admin:getNodeInfo%
    %loop ACLs%
      addACL('%value name%', [%loop nodes%'%value%'%loopsep ', '%%endloop%]);
    %endloop%
  %endinvoke%

</script>



  </BODY>
</HTML>
