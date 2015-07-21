<html>

<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" type="text/css" href="webMethods.css">
  <script src="webMethods.js.txt"></script>
  
  <style>
  .disabledLink
  {
    color:#0D109B;
  }
  </style>

  <script language ="javascript">
  
  </script>
  
</head>

<body onLoad="setNavigation('settings-broker.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Msging_JMSsetScrn');">
  <table width="100%">
  
    <tr>
      <td class="menusection-Settings" colspan="2">Settings &gt; Messaging &gt; Publishable Document Type Sync Report</td>
    </tr>
    
    <!--                 -->
    <!-- Handle 'action' -->
    <!--                 -->
    
    %switch action%
    %case 'push'%
      %invoke wm.server.ed:submit%
        <TR>
          <TD colspan="2">&nbsp;</td>
          </TR>
        <TR>
          <TD class="message" colspan=2>Errors: %value errors%</TD>
        </TR>
        <TR>    
          <TD class="message" colspan=2>Warnings: %value warnings%</TD>
        </TR>
        <TR>
          <TD class="message" colspan=2>Success: %value successfulPDTs%</TD>
        </TR>
      %endinvoke%
    %end%
    
    <!--                                                  -->
    <!--  -->
    <!--                                                  -->
    
    %invoke wm.server.messaging:getPDTReport%
    
    <!-- Navigation Menu -->
    
    <tr>
      <td colspan="2">
        <ul>
          <li><a href="settings-messaging.dsp">Return to Messaging</a></li>
          <li><a href="settings-wm-pdt.dsp">Refresh Page</a></li>
        </ul>
      </td>                                                                                                                       
    </tr>
    
    <tr>
      <td><img src="images/blank.gif" height=10 width=9></td>
      <td>

        <!--  -->

        <table class="tableView" width="100%">

          <!-- Headers -->

          <tr>
            <td class="heading" colspan=8>Publishable Document Type List</td>
          </tr>

          <tr>
            <td class="oddcol-l">Action</td>
            <td class="oddcol-l">Document Name</td>
            <td class="oddcol-l">Alias Name</td>
            <td class="oddcol-l">Status</td>
            <td class="oddcol-l">Channel Name</td>
            
          </tr> 
          
          %loop pdts%
            <tr>      
            
              <!-- action -->
              %ifvar isConnected equals('false')%              
                  <script>writeTD("row-l");</script>Push</td> 
              %else%
                  <script>writeTD("row-l");</script><a href="settings-wm-pdt.dsp?action=push&nsName=%value nsName%">Push</a></td> 
              %endif%  
                
              <!-- nsName -->   
              <script>writeTD("row-l");</script>%value nsName%</td>
              
              <!-- aliasName -->              
              <script>writeTD("row-l");</script>%value aliasNameDisplay%</td>      
              
              <!-- status -->
              
              <script>writeTD("row-l");</script>
                %switch syncState/status%
                  %case '2'%
                    IN_SYNC
                  %case '3'%
                    OUT_OF_SYNC
                  %case '4'%
                    DELETED_ON_PROVIDER
                  %case '5'%
                    CREATED_ON_IS
                  %end%
              </td>    
              
              <!-- eventDisplayName -->              
              <script>writeTD("row-l");</script>%value eventDisplayName%</td>   
              

              
              <script>swapRows();</script>
            </tr>
          %endloop%
          
          <tr>
            <td>&nbsp;</td>
          </tr>
        </table>
        

      </td>
    </tr>
                
   %onerror%
   
   <tr>
     <td class="message" colspan=2>G%value errorService%<br>%value error%<br>%value errorMessage%<br></td>
   </tr>
                  
   %endinvoke%

  </table>
</body>
</html>