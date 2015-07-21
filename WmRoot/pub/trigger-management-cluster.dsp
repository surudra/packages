<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="no-cache" http-equiv="Pragma">
  <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  <meta content="-1" http-equiv="Expires">
  <title>Server &gt; Statistics</title>
  <link href="webMethods.css" type="text/css" rel="stylesheet">
  <script src="webMethods.js.txt"></script>
</head>

<body onLoad="setNavigation('trigger-management-cluster.dsp',  '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_ClusterViewScrn');">

<table width="100%">
  <tbody>
    <tr>
      <td class="menusection-Settings" colspan="3">Settings &gt; Messaging &gt; webMethods Messaging Trigger Management &gt; Cluster View</td>
    </tr>
  </tbody>
</table>   
<table width="100%">
  <tbody>
    <tr>
      <td colspan="2">
      <ul>
        <li><a href="trigger-management.dsp">Return to webMethods Messaging Trigger Management</a></li>
        <!-- <li><a href="trigger_conditions.dsp">Document Routing View</a></li> -->
      </ul>
      </td>
    </tr>
    <tr>
    </tr>
    <tr>
      <td><img style="width: 10px; height: 10px;" alt="" src="images/blank.gif"><br>
      </td>
      <td>
      <table width="100%">
        <tbody>
          <tr>
            <td class="heading">Cluster Server List<br>
            </td>
          </tr>
        </tbody>
      </table>
      <table width="100%">
        <tbody>
          <tr>
            <td class="oddcol-l">Remote&nbsp;Server Alias</td>
            <td class="oddcol-l">Remote&nbsp;Server In&nbsp;Sync?&nbsp;&nbsp;</td>
            <td class="oddcol-l">Trigger Name</td>
            <td class="oddcol-l">Trigger In&nbsp;Sync?</td>
            <td class="oddcol-l">Error Message</td>
          </tr>

          %rename triggerName empty%
          %invoke wm.server.triggers:getClusterReport%
          
            %loop aliasList%
            
              <tr>
              
                %ifvar aliasURL -notempty%
                    <script>writeTD("row-l");</script><a href="%value aliasURL%/WmRoot/trigger-management.dsp" target="_blank">%value aliasName%</a></td> 
                %else%
                    <script>writeTD("row-l");</script>%value aliasName%</td> 
                %endif%
               
                %ifvar exception -notempty%
                  <script>writeTD("rowdata");</script>No</td> 
                  <script>writeTD("row-l");</script>&nbsp</td> 
                  <script>writeTD("row-l");</script>&nbsp</td> 
                  <script>writeTD("row-l");</script>Unable to retrieve cluster report: %value exception%</td> 
                %else%
                  %ifvar inSync equals('true')%                    
                    <script>writeTD("rowdata");</script><img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.gif">Yes</td>
                  %else%
                    <script>writeTD("rowdata");</script>No</td>
                  %endif%
                  <script>writeTDspan("row-l", 3);</script>&nbsp</td> 
                %endif%
              </tr>
              
              %ifvar exception -notempty%
              %else%
                %loop triggerDetail%
                  <tr>
                    <script>writeTD("row-l");</script>&nbsp</td> 
                    <script>writeTD("row-l");</script>&nbsp</td> 
                    <script>writeTD("row-l");</script>%value ../aliasName%::%value triggerName%</td> 
                    %ifvar inSync equals('true')%                    
                      <script>writeTD("rowdata");</script><img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.gif">Yes</td>
                      <script>writeTD("row-l");</script>&nbsp;</td>
                    %else%
                      <script>writeTD("rowdata");</script>No</td>
                      <script>writeTDnowrap("row-l");</script>
                      %loop msg%
                        %value%<br>
                      %endloop%
                      </td>
                    %endif%
  
                  </tr>
                %endloop%
              %endif%
            
              <script>swapRows();</script>
            %endloop%
          
          
          
          %onerror%
            %value errorMessage%
          %endinvoke%
 
        </tbody>
      </table>
      </td>
    </tr>
  </tbody>
</table>
</body>
</html>
