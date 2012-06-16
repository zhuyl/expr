 <#include "/template/head.ftl"/>
<body>
<table class="formTable" align="center" width="80%">
	<tr><td>其他支出说明:<br>
	${(answer.remark)!}
 	</td></tr>
</table>
<@table.table id="memberTable" width="80%" align="center">
 <@table.thead>
   <@table.td text="年份"/>
   <td>其他支出</td>
 </@>
   <#list 1..planYears as i>
   <tr align="center">
   <td>第${i}年</td>
   <td>${(amount.get(i))!(0)}</td>
   </tr>
   </#list>
 </@>
</body>
 <#include "/template/foot.ftl"/>