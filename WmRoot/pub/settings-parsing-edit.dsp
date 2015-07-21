<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" CONTENT="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  <script src="client.js.txt"></script>
  <script src="acls.js.txt"></script>
  <SCRIPT type="text/javascript" SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
  <SCRIPT LANGUAGE="JavaScript">  
  
    //--------------------------------------
    // Confirm disable of a feature
    //--------------------------------------
    //function confirmDisable (feature)
    //{
    //  var s1 = "OK to disable the `"+feature+"' feature?";
    //  return confirm (s1+s2+s3);
    //}

    //--------------------------------------
    // Confirm enable of a feature
    //--------------------------------------    
    //function confirmEnable (feature)
    //{
    //  var s1 = "OK to enable the `"+feature+"' feature?";
    //  return confirm (s1+s2+s3);
    //}
    
    //-----------------------------------------------------------
    // Validate the memory values
    // - Default buffer can be optionally suffxied with k or m
    // - Max heap can be optionally suffixed with k m g or %
    // - Max doc can be optionally suffixed with k  m g or %
    // - MaxBigMemory can be optionally suffixed with k m or g
    //-----------------------------------------------------------
    function validateSetting(form) {

        var defBytes = form.defaultPartitionBytes.value;
        var result = checkMem(defBytes, "kKmM");
        if (!result) {
            alert("Default partition size must be a number optionally followed by 'k', 'K', 'm', or 'M'");
            return false;
        }
        
        var maxHeap = form.maximumHeapBytes.value;
        var temp = "";
        result = checkMem(maxHeap, "kKmMgG%");
        if (!result) {
            alert("Maximum heap allocation must be a number optionally followed by 'k', 'K', 'm', 'M', 'g', 'G', or '%'");
            return false;
        }
        if (endsWith(maxHeap, "%")) {
            temp = maxHeap.substring(0, maxHeap.length - 1);
            if (temp > 100) {
                alert("Maximum total allocation percentage may not exceed 100.");
                return false;
            }
        }
        
        var maxDoc = form.maximumDocBytes.value;
        result = checkMem(maxDoc, "kKmMgG%");
        if (!result) {
            alert("Maximum document allocation must be a number optionally followed by 'k', 'K', 'm', 'M', 'g', 'G', or '%'");
            return false;
        }
        if (endsWith(maxDoc, "%")) {
            temp = maxDoc.substring(0, maxDoc.length - 1);
            if (temp > 100) {
                alert("Maximum document allocation percentage may not exceed 100.");
                return false;
            }
        }
        
        var maxBig = form.maximumBigMemoryBytes.value;
        result = checkMem(maxBig, "kKmMgG");
        if (!result) {
            alert("Maximum BigMemory size must be a number optionally followed by 'k', 'K', 'm', 'M', 'g', or 'G'");
            return false;
        }
        return true;
    }

    //---------------------------------------------------------    
    // Determine if a string ends with the specified character
    //---------------------------------------------------------
    function endsWith(value, tail) {
        if (typeof(value) != "string")
            return false;
        if (value.length < 1)
            return false;
        return tail == value.substring(value.length - 1);
    }

    //----------------------------------------------------------------    
    // Used to validate the memory value suffix (typically k m g or %)
    //----------------------------------------------------------------
    function checkMem(value, suffixes) {
        //alert("entering checkmem with: " + value + " : " + suffixes);
        if (value == "" || value == undefined)
            return false;
        var tails = suffixes.split("");
        var baseNumber = value;
        for (i = 0; i < tails.length; i++) {
            if (endsWith(value, tails[i])) {
                baseNumber = value.substring(0, value.length - 1);
                break;
            }
        }
        if (isNum(baseNumber))
            return true;
        return false; 
    }
    
  </SCRIPT>
</head>

<body onLoad="setNavigation('settings-parsing-edit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EnhancedXMLParsing_Edit');">
     
  %ifvar action equals('enable')%
    %invoke wm.server.parsing:toggleFeature%
    %onerror% IT DIDN'T WORK
    %endinvoke%
  %endif%
  
  %ifvar action equals('disable')%
    %invoke wm.server.parsing:toggleFeature%
    %onerror% IT DIDN'T WORK
    %endinvoke%
  %endif%

  <table name="pagetable" align='left' width="100%">
      
    <tr>
      <td class="menusection-Settings" colspan="2">Settings &gt; Enhanced XML Parsing &gt; Edit</td>
    </tr>

    <tr>
      <td colspan="2">
        <ul>
          <li><a href="settings-parsing.dsp">Return to Enhanced XML Parsing Settings</a></li>
        </ul>
      </td>
    </tr>
    
    <!--tr>
      <td><img src="/WmRoot/images/blank.gif" height=10 width=0 border=0></td>
    </tr-->  
    
    <form name="settings" action="settings-parsing.dsp" onsubmit="return validateSetting(this)" >

      <tr>
        <td><img src="/WmRoot/images/blank.gif" height=10 width=0 border=0></td>
        <td>
          <table class="tableView" width="60%">
            %invoke wm.server.parsing:getProperties%
            
              <tr>
                <td class="heading" colspan=2>Enhanced Parser Settings</td>
              </tr>
            
              <tr>
                <script>writeTDWidth("row-l", "40%")</script>Default partition size</td>
                <script>writeTD("row-l")</script>
                 <input type="text" name="defaultPartitionBytes" value="%value parserSettings/defaultPartitionBytes%" size=40>
                 <br>Format: &lt;integer> [ k | m ]
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
          <table class="tableView" width="60%">
            %invoke wm.server.parsing:getProperties%
              <tr>
                <td class="heading" colspan=2>Caching</td>
              </tr>

              <tr>
                <script>writeTDWidth("row-l", "40%")</script>Maximum heap allocation for all documents combined</td>
                <script>writeTD("row-l")</script>
                <input type="text" name="maximumHeapBytes" value="%value parserSettings/maximumHeapBytes%" size=40>
                <br>Format: &lt;integer> [ k | m | g | &#0037; ]
                </td>
                <script>swapRows();</script>
                </td>
              </tr>
    
              <tr>
                <script>writeTDWidth("row-l", "40%")</script>Maximum heap allocation for any single document</td>
                <script>writeTD("row-l")</script>
                <input type="text" name="maximumDocBytes" value="%value parserSettings/maximumDocBytes%" size=40>
                <br>Format: &lt;integer> [ k | m | g | &#0037; ]
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
          <table class="tableView" width="60%">
            %invoke wm.server.parsing:getProperties%

              <tr>
                <td class="heading" colspan=2>BigMemory Caching</td>
              </tr>
    
              <tr>
                <script>writeTDWidth("row-l", "40%")</script>Maximum BigMemory allocation</td>
                <script>writeTD("row-l")</script>
                <input type="text" name="maximumBigMemoryBytes" value="%value parserSettings/maximumBigMemoryBytes%" size=40>
                <br>Format: &lt;integer> [ k | m | g ]
                <script>swapRows();</script>
                </td>
              </tr>
     
            %onerror%
              <tr><td colspan="2" class="message">error: %value errorMessage%</td></tr>
            %endinvoke%

      
            <tr>
              <td><img src="/WmRoot/images/blank.gif" height=10 width=0 border=0></td>  
            </tr>
    
            <tr>
              <!--td><img src="/WmRoot/images/blank.gif" height=10 width=0 border=0></td-->   
              <td colspan="2" class="action">
                <input type="submit" name="submit" value="Save Changes" />
                <input type="hidden" name="action" value="change" />
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </form>
  </table>
</body>
</html>