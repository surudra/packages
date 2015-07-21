            <table width="100%" id="search_table">
                  <tbody>
                        <tr>
  									         <td class="heading" colspan="2">Search Configuration (Optional)</td>
  								      </tr>
                        <tr>
                             <td class="oddrow" width="50%">
                                  Searchable 
                             </td>
                             <td class="oddrow-l">
                                  <input type="checkbox" name="searchable" id="searchableCheck" %ifvar searchable equals('true')%checked%endif% onclick="toggleSearchable(this);"/>
                             </td>
                        </tr>
                        <tr>
                             <td class="evenrow" width="50%">
                                  Allow Automatic Indexing 
                             </td>
                             <td class="evenrow-l" style="padding-left:0px;align:left;">
                                  <table>
                                      <tbody>
                                         <tr>
                                              <td style="padding-left:0px;align:left;">
                                                   <input type="checkbox" name="searchableKey" %ifvar searchableKey equals('true')%checked%endif% id="searchableKeyCheck" %ifvar searchable equals('false')%disabled%endif% %ifvar operation equals('add')%disabled%endif% />
                                              </td>
                                              <td>
                                                    Key
                                              </td>
                                              <td>
                                                   <input type="checkbox" name="searchableValue" id="searchableValueCheck"  %ifvar searchableValue equals('true')%checked%endif% %ifvar searchable equals('false')%disabled%endif% %ifvar operation equals('add')%disabled%endif%/>
                                              </td>
                                              <td>
                                                    Value
                                              </td>
                                         </tr>
                                     </tbody>
                                  </table>
                             </td>
                        </tr>
                        <!--tr>
                             <td class="oddrow" width="50%">
                                  Allow dynamic indexing 
                             </td>
                             <td class="oddrow-l">
                                  <input type="checkbox" name="dynamicIndexing" id="dynamicIndexingCheck"  %ifvar searchable equals('false')%disabled%endif% %ifvar operation equals('add')%disabled%endif%  %ifvar dynamicIndexing equals('true')%checked%endif%  onclick="enableDisableDynamicFieldExtractor(this);"/>
                             </td>
                        </tr>
                        <tr>
                             <td class="evenrow" width="50%">
                                  Dynamic field extractor 
                             </td>
                             <td class="evenrow-l">
                                  <input type="text" name="dynamicFieldExtractor" id="dynamicFieldExtractor"  %ifvar dynamicIndexing equals('false')%disabled%endif%  %ifvar operation equals('add')%disabled%endif% value="%value dynamicFieldExtractor%"/>
                             </td-->
                        </tr>
                  </tbody>
                </table>
                <style>
                      .searchTable_odd{
                         background-color: #F0F0E0;
                         padding-right:0px;
                         padding-left:0px;
                      
                      }
                      .searchTable_even{
                         background-color: #E0E0C0;
                         padding-left:0px;
                         padding-right:0px; 
                         text-align:center;                       
                      }
                      .zeroPadding{
                        padding-left:0px;
                        padding-right:0px;
                        padding-bottom:0px;
                        padding-top:0px;
                      }
                      .deleteDisableButton {
                          background: url("icons/IS_Delete_disabled.png") no-repeat scroll 0% 0% transparent;
                          width: 16px;
                          height: 16px;
                          border: medium none;
                      }
                      .addButton {
                          background: url("icons/IS_Add.png") no-repeat scroll 0% 0% transparent;
                          width: 16px;
                          height: 16px;
                          cursor: pointer;
                          border: medium none;
                      }
                      .deleteButton {
                    			background:url('icons/IS_Delete.png') no-repeat;
                    			width: 16px;
                    			height: 16px;
                    			cursor:hand;
                    			cursor:pointer;
                    			border: none;
                    		}
                        .heading_attributes
                      	{
                        	background-color: #000000;
                        	color: #FFFFFF;
                        	font-weight: bold;
                        	letter-spacing: 2px;
                        	padding-left: 5px;
                        	text-align: left;                          
                          border-left:2px solid white;
                          border-right:2px solid white;
                      	}
                        .expressionTable{
                          width:100%;
                          border-spacing:0;
                        }
                        .expressionCell{
                          border-right:solid white 2px;
                          border-spacing:0;
                        }
                </style>
                <script>
                         var rowIndex=1;
                         function  addParamRow(values,index,disabledRow){
                           
                          if(index || index == 0){
                              rowIndex=index;
                          }
                         
                          var table = document.getElementById('attribute_table');
                          var row = table.insertRow(-1);
                          row.id=++rowIndex;
                          
                          if(!values && index != 0){
                            enableFirstRow(table);
                          }                          
                          var cell = row.insertCell(0);
                          cell.className='evenrow';
                          var attributeName = document.createElement("input");
                          attributeName.type='text';
                          attributeName.name='attribute_text';
                          if(values && values['name']){
                             attributeName.value = values['name'];
                          } 
                          cell.style.textAlign='center'; 
                          cell.appendChild(attributeName);
                          
                          var cell = row.insertCell(1);
                          cell.className='evenrow';
                          var classExpRadio = document.createElement("input");
                          classExpRadio.type='radio';
                          classExpRadio.name='class'+row.id; 
                          classExpRadio.id='expression_radio_'+row.id;
                          classExpRadio.value="expression";
                          
                          if(values && values['extractMenthod']){
                             if("expression" == values['extractMenthod']){
                               classExpRadio.checked=true; 
                             }
                          }else{
                              classExpRadio.checked=true;
                          } 
                          
                          
                          classExpRadio.onclick=function(){
                              disableProperties('expression_radio_'+row.id,'properties_'+row.id);
                          }    
                          cell.appendChild(classExpRadio);  
                          var itemLabel = document.createElement("Label");
                          itemLabel.setAttribute("for", classExpRadio);
                          itemLabel.innerHTML = "Expression";
                          cell.appendChild(itemLabel); 
                          classExpRadio = document.createElement("input");
                          classExpRadio.type='radio';
                          classExpRadio.name='class'+row.id;
                          classExpRadio.id='class_radio_'+row.id; 
                          classExpRadio.value="class";
                          
                          if(values && values['extractMenthod']){
                             if("class" == values['extractMenthod']){
                               classExpRadio.checked=true; 
                             }
                          }
                          
                          classExpRadio.onclick=function(){
                              enableProperties('class_radio_'+row.id,'properties_'+row.id);
                          }                            
                          cell.appendChild(classExpRadio); 
                          itemLabel = document.createElement("Label");
                          itemLabel.setAttribute("for", classExpRadio);
                          itemLabel.innerHTML = "Class";
                          cell.appendChild(itemLabel); 
                          
                          var cell = row.insertCell(2);
                          cell.className='evenrow';
                          
                          var tableExp = document.createElement("TABLE");
                          var rowExp = tableExp.insertRow(-1);
                          var cellExp = rowExp.insertCell(0);
                          var attributeName = document.createElement("input");
                          attributeName.type='text';
                          attributeName.name='class_expression'; 
                          cellExp.className='expressionCell'; 
                          cellExp.width = "50%";
                          
                          if(values && values['classOrExpression']){
                             attributeName.value = values['classOrExpression'];
                          }
                           
                          cellExp.appendChild(attributeName); 
                          cellExp = rowExp.insertCell(1);
                          attributeName = document.createElement("input");
                          attributeName.type='text';
                          attributeName.name='properties';
                          attributeName.id='properties_'+row.id;
                          attributeName.disabled=true;
                          cellExp.align='right';
                          
                          if(values && values['properties']){
                             attributeName.value = values['properties'];
                             attributeName.disabled=false; 
                          }
                          else if(classExpRadio.checked){
                            attributeName.disabled=false;
                          }
                          
                          cellExp.appendChild(attributeName);
                          tableExp.className='expressionTable';
                          
                          cell.style.paddingLeft = '2px' 
                          cell.appendChild(tableExp); 
                          
                          cell = row.insertCell(3);
                          cell.className='evenrow';
                          var attributeName = document.createElement("input");
                          attributeName.type='button';
                          attributeName.className='addButton';
                          attributeName.onclick=function(){
                              addParamRow();
                          }
                          cell.style.textAlign='center';
                          cell.appendChild(attributeName);   
                          attributeName = document.createElement("input");
                          attributeName.type='button';
                          attributeName.className='deleteButton';
                          if(disabledRow){
                              attributeName.className='deleteDisableButton';
                              attributeName.disabled=true;
                          }
                          attributeName.onclick= function(){
                              deleteRow(table,row);
                          }
                          cell.appendChild(attributeName); 
                             
                          reshuffleRows(table);             
                        } 
                        
                        function deleteRow(table,row){
                             var rows = table.rows;
                             for(var rowIndex in rows){
                                  if(rows[rowIndex].id == row.id){
                                      table.deleteRow(rowIndex);
                                      break;
                                  }
                             }  
                             
                             if(table.rows.length<3){
                                  disableFirstRowDelete(table);
                             } 
                             reshuffleRows(table);                  
                        } 
                        
                        function enableFirstRow(table){
                               var deleButton = getDeleteButton(table);
                               deleButton.disabled=false;
                               if(deleButton && deleButton.className!='deleteButton'){
                                    deleButton.className='deleteButton';
                                    deleButton.onclick= function(){
                                      deleteRow(table,table.rows[1]);
                                    }
                               }
                        } 
                        
                        function disableFirstRowDelete(table){
                              var button = getDeleteButton(table);
                              button.onclick='';
                              button.className = 'deleteDisableButton';
                         } 
                            
                         function getDeleteButton(table){
                              var buttonCell = table.rows[1].cells[3];
                              var button = buttonCell.getElementsByTagName('INPUT')[1];
                              return  button;
                         }
                         
                         function reshuffleRows(table){
                               var rows = table.rows;
                               var style= new Array();
                               style[0]='oddRow';
                               style[1]='evenrow';
                               if(rows.length>=2){
                                 var cells;
                                 for (var i=1;i<rows.length;i++){
                                      cells  = rows[i].cells;
                                      for(var j=0;j<cells.length;j++){
                                         cells[j].className=style[i%2];
                                      }
                                 }
                               }  
                         }  
                         
                         function disableProperties(radioInputId,textId){                            
                            var  radioInput = document.getElementById(radioInputId);
                            if(radioInput.checked == true){
                              var textInput =  document.getElementById(textId);
                              textInput.value="";
                              textInput.disabled=true;
                             }
                         } 
                         
                         function enableProperties(radioInputId,textId){                          
                            var  radioInput = document.getElementById(radioInputId);
                            if(radioInput.checked == true){
                               var textInput = document.getElementById(textId);
                               textInput.disabled=false;
                             }
                         }
                         
                         function toggleSearchable(element){
                              if(element.checked){
                                enableSearchable();
                              }
                              else{
                                 disableSearchable();
                              }
                         }
                         
                         function disableSearchable(){
                            var searchableKeyCheck = document.getElementById('searchableKeyCheck');
                            searchableKeyCheck.disabled=true;
                            searchableKeyCheck.checked=false;
                            var searchableValueCheck = document.getElementById('searchableValueCheck');
                            searchableValueCheck.disabled=true;
                            searchableValueCheck.checked=false;
                            //var dynamicIndexingCheck = document.getElementById('dynamicIndexingCheck');
                            //dynamicIndexingCheck.disabled=true;
                            //dynamicIndexingCheck.checked=false;
                            //var dynamicFieldExtractor = document.getElementById('dynamicFieldExtractor');
                            //dynamicFieldExtractor.disabled=true;
                            //dynamicFieldExtractor.value="";
                            clearAttributeTable();
                        }
                        
                        function clearAttributeTable(){
                            var table = document.getElementById('attribute_table');
                            for (var i=table.rows.length-1;i>0;i--){
                                 table.deleteRow(1);                           
                            }
                            addParamRow(null,0,true);
                            disableFirstRow(true);
                        }
                        
                        function disableFirstRow (disable) {
                             var table = document.getElementById('attribute_table'); 
                             var inputs = table.rows[1].getElementsByTagName('INPUT');
                             for (var index in inputs){
                                   if(!disable && !(inputs[index].id && inputs[index].id.indexOf('properties_') == 0)) {
                                       inputs[index].disabled=disable;
                                   }
                                   else if (disable){
                                      inputs[index].disabled=disable;
                                   }
                             }
                             disableFirstRowDelete(table);
                         }
                         
                         
                         function enableSearchable(){
                            document.getElementById('searchableKeyCheck').disabled=false;
                            document.getElementById('searchableValueCheck').disabled=false;
                            //document.getElementById('dynamicIndexingCheck').disabled=false;
                            disableFirstRow(false);
                         } 
                        
                         function enableDisableDynamicFieldExtractor(element){
                            if(element.checked){
                                document.getElementById('dynamicFieldExtractor').disabled=false; 
                            }
                            else{
                                var dynamicFieldExtractor = document.getElementById('dynamicFieldExtractor');
                                dynamicFieldExtractor.disabled=true;
                                dynamicFieldExtractor.value="";
                            }                          
                         }
                         
                         function enableDynamicIndexing(element){
                            var dynamicFieldExtractor = document.getElementById('dynamicFieldExtractor');
                            if(element.checked){
                                dynamicFieldExtractor.disabled=true;
                                dynamicFieldExtractor.value="";
                            }
                            else{
                                dynamicFieldExtractor.disabled=false;
                                dynamicFieldExtractor.focus();
                            }
                         }
                                    
                </script>
                
                
                
                
                <table width="100%" cellspacing="0">
                       <tbody>
                               <tr>
                                  
        									         <td class="heading_attributes" style="padding-left:2px;">Search Attributes (Optional)</td>
                                  
        								      </tr>
                              
                              <tr>
                                   <td class="zeroPadding">
                                       <table width="100%"  id="attribute_table">
                                        <tbody width="100%">
                                            <tr>
                                              <td  class="searchTable_even"> 
                                                   Attribute
                                              </td>
                                              <td class="searchTable_even">
                                                   Extract Method
                                              </td>
                                              <td class="zeroPadding" style="background-color:#F0F0E0;">
                                                    <table width="100%" style="border-spacing:0;">
                                                    
                                                        <tr>
                                                            <td colspan="2" align="center" class="searchTable_even" style="border-bottom:solid white 2px;">
                                                              Extract By
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                          <td width="50%" class="searchTable_even" style="border-right:solid white 2px;padding-left:4px;">
                                                               Class/Expression
                                                          </td>
                                                          <td class="searchTable_even" style="padding-left:4px;">
                                                               Properties
                                                          </td>
                                                        </tr>
                                                  
                                                    </table>  
                                              </td>
                                              <td class="searchTable_even">
                                                    Add/Remove
                                              </td>
                            </tr>
                          %ifvar operation equals('add')%   
                              <tr id="0">
                                <td class="evenrow" style="text-align:center;"> 
                                    <input type="text" name="attribute_text" disabled/>
                                </td>
                                <td class="evenrow"> 
                                  <input type="radio" id="expression_radio_1"  name="class1" value="expression" onclick="disableProperties('expression_radio_1','properties_1')" checked disabled/>Expression<input type="radio" name="class1" value="class" id="class_radio_1" onclick="enableProperties('class_radio_1','properties_1')" disabled/>Class
                                </td>
                                <td class="evenrow" style="padding-left:2px;">
                                   <table class="expressionTable">
                                     <tr>
                                       <td width="50%" class="expressionCell"> 
                                           <input type="text" name="class_expression" disabled/>
                                       </td>
                                       <td align="right">    
                                           <input type="text" name="properties" id="properties_1" disabled/>
                                       </td>
                                    </tr>
                                  </table>                                                    
                                </td>
                                <td class="evenrow" style="text-align:center;"> 
                                  <input class="addButton" type="button" onclick="addParamRow()" disabled></input>
                                  <input id="deleteElementtoReferenceParamsrow0" class="deleteDisableButton" type="button" name="deleteElementtoReferenceParamsrow0" onclick="" ></input>
                                </td>
                              </tr>
                             %else%
                             %ifvar attribute_textList -notempty%
                               %loop attribute_textList%  
                                <script>
                                         addParamRow({'name':'%value name%','extractMenthod':'%value extractMenthod%','classOrExpression':'%value classOrExpression%','properties':'%value properties%'},%value $index%);
                                </script>                                
                                %endloop% 
                             %else%
                              <!-- [start] adding an empty row if no search attributes added.  -->
                                <tr id="0">
                                <td class="evenrow" style="text-align:center;"> 
                                    <input type="text" name="attribute_text"/>
                                </td>
                                <td class="evenrow"> 
                                  <input type="radio" id="expression_radio_1"  name="class1" value="expression" onclick="disableProperties('expression_radio_1','properties_1')" checked/>Expression<input type="radio" name="class1" value="class" id="class_radio_1" onclick="enableProperties('class_radio_1','properties_1')" disabled/>Class
                                </td>
                                <td class="evenrow" style="padding-left:2px;">
                                   <table class="expressionTable">
                                     <tr>
                                       <td width="50%" class="expressionCell"> 
                                           <input type="text" name="class_expression"/>
                                       </td>
                                       <td align="right">    
                                           <input type="text" name="properties" id="properties_1" />
                                       </td>
                                    </tr>
                                  </table>                                                    
                                </td>
                                <td class="evenrow" style="text-align:center;"> 
                                  <input class="addButton" type="button" onclick="addParamRow()"></input>
                                  <input id="deleteElementtoReferenceParamsrow0" class="deleteDisableButton" type="button" name="deleteElementtoReferenceParamsrow0" onclick="" disabled></input>
                                </td>
                              </tr> 
                              <!-- [end] adding an empty row if no search attributes added.  -->                               
                             %endifvar%
                             %endifvar%
                            </tbody>
                            </table>  
                            </td> 
                          </tr>   
                       </tbody>   
                </table>