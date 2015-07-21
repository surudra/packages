<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" CONTENT="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  <script src="client.js.txt"></script>
  <script src="acls.js.txt"></script>
  <script type="text/javascript" SRC="/WmRoot/webMethods.js.txt"></script>
 
  <script LANGUAGE="JavaScript">  
     function confirmDisable (feature)
      {
         var s1 = "OK to disable the `"+feature+"' feature?";
         return confirm (s1);
      }
      function confirmEnable (feature)
      {
         var s1 = "OK to enable the `"+feature+"' feature?";
         return confirm (s1);
      }
  </script>
</head>

<body onLoad="setNavigation('settings-parsing.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EnhancedXMLParsing');">

  <table name="pagetable" align='left' width="100%">

    <tr>
      <td class="menusection-Settings" colspan="4">Settings &gt; Enhanced XML Parsing </td>
    </tr>

    %ifvar action equals('change')%
      %invoke wm.server.parsing:saveSettings%
      %onerror%
        <tr><td colspan="2" class="message">error: %value errorMessage%</td></tr>
      %endinvoke%
    %endif%
     
    %ifvar action equals('enable')%
      %invoke wm.server.parsing:toggleFeature%
      %onerror%
        <tr><td colspan="2" class="message">error: %value errorMessage%</td></tr>
      %endinvoke%
    %endif%
  
    %ifvar action equals('disable')%
      %invoke wm.server.parsing:toggleFeature%
      %onerror%
        <tr><td colspan="2" class="message">error: %value errorMessage%</td></tr>
      %endinvoke%
    %endif%

    <tr>
      <td colspan="2">
        <ul>
          <li><a href="settings-parsing-edit.dsp">Edit Enhanced XML Parsing Settings</a></li>
        </ul>
      </td>
    </tr>
    
    <!--tr>
      <td><img src="/WmRoot/images/blank.gif" height=10 width=0 border=0></td>
    </tr-->  
    
    <tr>
      <td><img src="/WmRoot/images/blank.gif" height=10 width=0 border=0></td>
      <td>
        <table class="tableView" width="70%">
          %invoke wm.server.parsing:getProperties%
            
            <tr>
              <td class="heading" colspan=2>Enhanced Parser Settings</td>
            </tr>
            
            <tr>
              <script>writeTDWidth("row-l", "40%")</script>Default partition size</td>
              <script>writeTDWidth("rowdata-l", "60%")</script>%value parserSettings/defaultPartitionBytes%
              <script>swapRows();</script>
              </td>
            </tr>         
          %onerror%
            <tr><td colspan="2" class="message">error: %value errorMessage%</td></tr>
          %endinvoke%
        </table>
      </td>
      
    </tr> 
      
    <tr>
      <td><img src="/WmRoot/images/blank.gif" height=10 width=0 border=0></td>
    </tr>  

    <tr>
      <td><img src="/WmRoot/images/blank.gif" height=10 width=0 border=0></td>
      <td>
        <table class="tableView" width="70%">
          %invoke wm.server.parsing:getProperties%
            <tr>
              <td class="heading" colspan=2>Caching</td>
            </tr>
            
            <tr>
              <script>writeTDWidth("row-l", "40%")</script>Enabled</td>
              <script>writeTDWidth('rowdata-l', "60%");</script>
              
              %ifvar parserSettings/useCache equals('true')%
                <A class="imagelink" HREF="settings-parsing.dsp?action=disable&feature=usecache"
                  ONCLICK="return confirmDisable('Caching');"><IMG SRC="images/green_check.gif" border="0"
                  height=13>&nbspYes</A>
              %else%
                <A class="imagelink" HREF="settings-parsing.dsp?action=enable&feature=usecache"
                  ONCLICK="return confirmEnable('Caching');"><!--IMG border="0" SRC="images/blank.gif"
                  height=13-->No</A>
              %endif%</td>
              <script>swapRows();</script>
              </td>
            </tr>

            <tr>
              <script>writeTDWidth("row-l", "30%")</script>Maximum heap allocation for all documents combined</td>
              <script>writeTDWidth("rowdata-l", "70%")</script>%value parserSettings/maximumHeapBytes%
              <script>swapRows();</script>
              </td>
            </tr>
    
            <tr>
              <script>writeTD("row-l")</script>Maximum heap allocation for any single document</td>
              <script>writeTDWidth("rowdata-l", "30%")</script>%value parserSettings/maximumDocBytes%
              <script>swapRows();</script>
              </td>
            </tr>
            
            %ifvar parserSettings/failureMessage%
              <tr>
                <script>writeTD("row-l")</script>Warning! The cache failed to initialize properly</td>
                <script>writeTDWidth("rowdata-l", "30%")</script>%value parserSettings/failureMessage%
                <script>swapRows();</script>
                </td>
              </tr>
            %endif%
           
          %onerror%
            <tr><td colspan="2" class="message">error: %value errorMessage%</td></tr>
          %endinvoke%
        </table>
      </td>
      
    </tr> 
       
    <tr>
      <td><img src="/WmRoot/images/blank.gif" height=10 width=0 border=0></td>   
    </tr> 
    
    <tr>  
      <td><img src="/WmRoot/images/blank.gif" height=10 width=0 border=0></td> 
      <td>
        <table class="tableView" width="70%">
          %invoke wm.server.parsing:getProperties%

            <tr>
              <td class="heading" colspan=2>BigMemory Caching</td>
            </tr>

            <tr>
              <script>writeTDWidth("row-l", "40%")</script>Enabled</td>
              <script>writeTD('rowdata-l');</script>
              
              %ifvar parserSettings/useBigMemory equals('true')%
                <A class="imagelink" HREF="settings-parsing.dsp?action=disable&feature=bigmemory"
                  ONCLICK="return confirmDisable('BigMemory caching');"><IMG SRC="images/green_check.gif" border="0"
                  height=13>&nbspYes</A>
              %else%
                <A class="imagelink" HREF="settings-parsing.dsp?action=enable&feature=bigmemory"
                  ONCLICK="return confirmEnable(' BigMemory caching');"><!--IMG border="0" SRC="images/blank.gif"
                  height=13-->No</A>
              %endif%</td>
              <script>swapRows();</script>
              </td>
            </tr>
    
            <tr>
              <script>writeTDWidth("row-l", "40%")</script>Maximum BigMemory allocation</td>
              <script>writeTDWidth("rowdata-l", "50")</script>%value parserSettings/maximumBigMemoryBytes%
              <script>swapRows();</script>
              </td>
            </tr>
     
          %onerror%
            <tr><td colspan="2" class="message">error: %value errorMessage%</td></tr>
          %endinvoke%
        </table>
      </td>
    </tr>
    
        <tr>
      <td><img src="/WmRoot/images/blank.gif" height=10 width=0 border=0></td>   
    </tr> 
    
    <tr>  
      <td><img src="/WmRoot/images/blank.gif" height=10 width=0 border=0></td> 
      <td>
        <table class="tableView" width="70%">
          %invoke wm.server.parsing:getProperties%

            <tr>
              <td class="heading" colspan=2>Peak Usage Statistics</td>
            </tr>
    
            <tr>
              <script>writeTDWidth("row-l", "40%")</script>Peak heap allocation for all documents combined </td>
              <script>writeTDWidth("rowdata-l", "50")</script>%value parserSettings/peakSystemLocalMBytes%m
              <script>swapRows();</script>
              </td>
            </tr>
            
            <tr>
              <script>writeTDWidth("row-l", "40%")</script>Peak heap allocation for any single document </td>
              <script>writeTDWidth("rowdata-l", "50")</script>%value parserSettings/peakDocumentLocalMBytes%m
              <script>swapRows();</script>
              </td>
            </tr>
            
            <tr>
              <script>writeTDWidth("row-l", "40%")</script>Peak BigMemory use </td>
              <script>writeTDWidth("rowdata-l", "50")</script>%value parserSettings/peakBigMemoryUseMBytes%m
              <script>swapRows();</script>
              </td>
            </tr>
     
          %onerror%
            <tr><td colspan="2" class="message">error: %value errorMessage%</td></tr>
          %endinvoke%
        </table>
      </td>
    </tr>
    
  </table>
</body>

</html>