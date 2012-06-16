<@table.table id="memberTable" width="80%" align="center">
 <@table.thead>
   <@table.td text="年份"/>
   <td>日常消费支出<button onclick="edit()">修改</button></td>
 </@>
   <#list 1..planYears as i>
   <tr align="center">
   <td>第${i}年</td>
   <td>${(amount.get(i))!(0)}</td>
   </tr>
   </#list>
 </@>
 
  <form name="actionForm" method="post" action="${base}/answer/consumePlan!edit.action?caze.id=${Parameters['caze.id']}">
 </form>
 <script>
 	function edit(){
 		document.actionForm.submit();
 	}
 </script>