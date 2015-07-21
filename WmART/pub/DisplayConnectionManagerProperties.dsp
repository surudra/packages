%comment%------ Display connection parameters ------%endcomment%

%ifvar connectionManagerProperties%
    <script>resetRows();</script>
    <tr><td class="heading" colspan=2>Connection Management Properties</td></tr>
    %loop connectionManagerProperties%
        <tr>
            <script>writeTD('row');</script>%value displayName%</td>
            %ifvar parameterType equals('Boolean')%
                <script>writeTD('rowdata-l');swapRows();</script>
                <select name=".CMGRPROP.%value -urlencode systemName%" %ifvar systemName equals('poolable')%onChange="handlePoolableChange(this.form);"%endif%>
                <option value="true"  %ifvar value equals('true')%selected="true"%endif%>true</item>
                <option value="false" %ifvar value equals('false')%selected="true"%endif%>false</item>
                </select>
            %else%
                <script>writeTD('rowdata-l');swapRows();</script>
                <input size=60 name=".CMGRPROP.%value -urlencode systemName%" value="%value defaultValue%"></input></td>  
            %endif%
        </tr>
    %endloop%
%else%
    <tr><td class="message">Connection Management properties not found.</td></tr>
%endif%
