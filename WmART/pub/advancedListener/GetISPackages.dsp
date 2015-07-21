%comment%------ Display available IS packages ------%endcomment%

<tr>
    <script>writeTD('row');</script>Package</th>

    %invoke wm.art.admin:getPackageNames%  
        %ifvar availablePackages%
            <script>writeTD('rowdata-l');</script>
            <select name="packageName">
            %loop availablePackages%
                <option name="%value name%" %ifvar ../packageName vequals(name)% selected="true" %endif% >%value name%</option>
            %endloop%
            </select></td>
        %else%
            <script>writeTD('rowdata-l');</script>    
            <input name="packageName" value="%value packageName%"></input></td>
        %endif%        
        
        %onerror%
          %ifvar localizedMessage%
            %comment%-- Localized error message supplied --%endcomment%
            <tr><td class="message">Error encountered <PRE>%value localizedMessage%</PRE></td></tr>
          %else%
            %ifvar error%
              <tr><td class="message">Error encountered <PRE>%value errorMessage%</PRE></td></tr>
            %endif%
          %endif%
    %endinvoke%        
</tr>