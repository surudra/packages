<SCRIPT LANGUAGE="JavaScript">
	//
    // Set all checkbox fields to select or deselect. The select field must be an
    // array of checkBox fields. Pass "true" to select and "false" to deselect
    //  Example: to select call setAll(document.exportform.useTran,true);
    //
    function setAll(selectField, selected)
    {
    
        if(isArray(selectField))
        {
    	    var numItems = selectField.length;
            for (Count = 0;Count < numItems; Count++)
            {
                selectField[Count].checked = selected;
            }
        }
        else if(isObject(selectField))
        {
    	    selectField.checked = selected;
        
        }
        
        return true;
    }

    function isArray(testObj)
    {
    	if(typeof testObj == "undefined")
    	{
    		return false;
    	}
        else if(typeof testObj.length != "undefined")
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    
    function isObject(testObj)
    {
    	if(typeof testObj == "undefined")
    	{
    		return false;
    	}
        else if(typeof testObj == "object")
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    
    function isDefined(testObj)
    {
    	if(typeof testObj == "undefined")
    	{
    		return false;
    	}
        
        return true;
    }

    //
    // Search the array for the specified value. Return -1 if not found. Otherwise
    // it will return the index.
    //    
    function inArray(srcArray, searchFor)
    {
        var len =  srcArray.length;
        
        for(index = 0; index < len; index++)
        {
            if (srcArray[index] == searchFor)
            {
                return index;
            }
        }
        
        return -1;
    }
    
    //
    // Checks InString to see if it contains any characters in RefString. If either string is
    // null or empty, false is returned.
    // 
    // Return - true if Instring has any characters in RefString
    //          false otherwise
    //
    function invalidInString(InString, RefString)  
    {
        if((InString == null) || (InString.length==0)) return (false);
        if((RefString == null) || (RefString.length==0)) return (false);

        for (Count=0; Count < InString.length; Count++)  
        {
            TempChar= InString.substring (Count, Count+1);
            if (RefString.indexOf(TempChar, 0)!=-1)  
                return(true);
        }
        return(false);
    }

    function leftTrim(InString)  
    {
        OutString=InString;
        for (Count=0; Count < InString.length; Count++)  
        {
            TempChar=InString.substring (Count, Count+1);
            if (TempChar!=" ") 
            {
                OutString=InString.substring (Count, InString.length)
                break;
            }
        }
        return(OutString);
    }

    function rightTrim(InString)  
    {
        OutString=InString;
        for (Count=InString.length; Count > 0; Count--)  
        {
            TempChar=InString.substring (Count-1, Count);
            if (TempChar!=" ") 
            {
                OutString=InString.substring (0, Count)
                break;
            }
        }
        return(OutString);
    }

    //
    // Checks the incoming field for ilegal characters as defined by the B2B server.
    //   checkField -  Field to examine (document.exportform.exportFile)
    //   displayName - the name of the field to display in an alert.
    //
    // Sample Usage:
    //    <TD class="rowdata"><INPUT TYPE="TEXT" name="exportFile" 
    //        onChange="containsIllegalChars(this,'Export File');"></TD>
    //
    // NOTE: CALL setIllegalChars before invoking this function to get the
    //  server list of illegal characters.
    //
    function containsIllegalChars(checkField, displayName)
    {

        fileName = checkField.value;

        if(invalidInString(fileName, illegalChars))
        {
            alert(displayName + " contains one of the following illegal characters:\n"
                +illegalChars);
            return true;
        }
        else
        {
            return false;
        }
    }

    var illegalChars = null;
    
    function setIllegalChars()
    {
        %invoke wm.OracleApps.OAExcAdmin:getIllegalFileChars%
            illegalChars = '%value illegalFileChars%';
        %onerror%
            illegalChars = null;
        %endinvoke%
    }
       
</SCRIPT>
