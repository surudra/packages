%comment%------ Edit connection node ------%endcomment%
%ifvar connectionManagerProperties%
<script>resetRows();</script>

<TR>
   <TD colspan="2" class="heading">Connection Management Properties</TD>
</TR>   
    %ifvar readOnly equals('true')%
        %loop connectionManagerProperties%        
        <tr>
        <script>writeTDspan('row');</script>
        %value displayName%</td>
        <script>writeTDspan('rowdata-l');swapRows();</script>      
        %value value%</td></tr>        
        %endloop%  
    %else%
    %comment%-- edit mode --%endcomment%
      %loop connectionManagerProperties%   
        <tr>
        <script>writeTDspan('row');</script>
        %value displayName%</td>
        %ifvar parameterType equals('Boolean')%
          <script>writeTDspan('rowdata-l');swapRows();</script>      
          <select name=".CMGRPROP.%value -urlencode systemName%" %ifvar systemName equals('poolable')%onChange="handlePoolableChange(this.form);"%endif%>
          <option value="true"  %ifvar value equals('true')%selected="true"%endif%>true</option>
          <option value="false" %ifvar value equals('false')%selected="true"%endif%>false</option>
          </select></td></tr>
        %else%
            <script>writeTDspan('rowdata-l');swapRows();</script>
            <input size=60 name=".CMGRPROP.%value -urlencode systemName%" value="%value value%"></input></td></tr>  
        %endif%      
      %endloop%
    %endif%  

%else%
  <TR><TD class="message">Connection Management properties not found.</TD></TR>
%endif%

