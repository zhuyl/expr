<@table.table id="memberTable" width="80%" align="center">
 <@table.thead>
   <@table.td text="年份"/>
   <#list members as member>
   <td>姓名(职业) </td>
   </#list>
   <@table.td text="总收入"/>
 </@>
   <tr align="center">
   <@table.td text=""/>
   <#list members as member>
   <td>${member.name} (${(member.career.name)!} ) 
   <button onclick="edit('${member.name}')">修改</button></td>
   </#list>
   <td>&nbsp;</td>
   </tr>
   
   <#list 1..planYears as i>
   <tr align="center">
   <td>第${i}年</td>
   <#assign total=0>
   <#list members as member>
   <td><#assign total=total+(bonuses[member.name].get(i))!0>${(bonuses[member.name].get(i))!0}</td>
   </#list>
   <td>${total}</td>
   </tr>
   </#list>
 </@>

  <form name="actionForm" method="post" action="${base}/result/bonusPlan!edit.action?experiment.id=${Parameters['experiment.id']}">
 	<input name="name" type="hidden" value=""/>
 </form>
 <script>
 	function edit(name){
 		document.actionForm['name'].value=name;
 		document.actionForm.submit();
 	}
 </script>