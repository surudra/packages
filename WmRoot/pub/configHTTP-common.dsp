            <input type="hidden" name="factoryKey" value="webMethods/HTTP">
	    %ifvar listenerKey -notempty%
              <input type="hidden" name="operation" value="update">
              <input type="hidden" name="oldPkg" value="%value pkg%">
            %else%
              <input type="hidden" name="operation" value="add">
              <input type="hidden" name="oldPkg">
            %endif%
            <input type="hidden" name="listenerKey" value="%value listenerKey%">
            <input type="hidden" name="serverType">
            <input type="hidden" name="listening" value="%value listening%">
            <input type="hidden" name="listenerType" value="%value listenerType%">
            <input type="hidden" name="mode" value="%value ../mode%">

      <tr>
	      <td class="oddrow">Port</td>
	       <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
	         %ifvar ../mode equals('view')%
		         %value port%
	         %else%
		         <input name="port" value="%value port%">
	         %endif%
	       </td>
      </tr>
      <tr>
         <td class="evenrow">Alias</td>
         <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
           %ifvar listenerKey -notempty%
			 %ifvar ../mode equals('view')%
				%value portAlias%
			 %else%
				<input name="portAlias" value="%value portAlias%" size="60" disabled>
			 %endif%
           %else%
             <input name="portAlias" value="%value portAlias%" size="60">
           %endif%
         </td>
      </tr>
      <tr>
         <td class="oddrow">Description (optional)</td>
         <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
           %ifvar ../mode equals('view')%
             %value portDescription%
           %else%
             <input name="portDescription" value="%value portDescription%" size="60">
           %endif%
         </td>
      </tr>
    <tr>
	<td class="evenrow">Package Name</td>
	<td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
	  %invoke wm.server.packages:packageList%
	    %ifvar ../mode equals('view')%
		%value pkg%
	    %else%
		<select name="pkg">
		  %loop packages%
		      %ifvar enabled equals('true')%
			    %ifvar ../pkg -notempty%
				<option %ifvar ../pkg vequals(name)%selected %endif%value="%value name%">%value name%</option>
			    %else%
				<option %ifvar name equals('WmRoot')%selected %endif%value="%value name%">%value name%</option>
			    %endif%
		      %endif%
		  %endloop%
		</select>
	    %endif%
	  %endinvoke%
	</td>
    </tr>
<!-- only needed sometimes -->
    <tr>
	<td class="oddrow">Bind Address (optional)</td>
	<td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
	  %ifvar ../mode equals('view')%
	    %value bindAddress%
	  %else%
	    <input name="bindAddress" value="%value bindAddress%">
	  %endif%
	</td>
    </tr>
<!-- hmmm . . . only needed sometimes -->

%ifvar listenerType equals('revinvokeinternal')%
%else%
    <tr>
	<td class="evenrow">Backlog</td>
	<td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
	 %ifvar ../mode equals('view')%
	   %value maxQueue%
	 %else%
	   %ifvar maxQueue%
	     <input name="maxQueue" value="%value maxQueue%">
	   %else%
	     <input name="maxQueue" value="200">
	   %endif%
	 %endif%
	</td>
   </tr>
%endifvar%