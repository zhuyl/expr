 <#include "/template/head.ftl"/>
<body>
<table class="formTable" align="center" width="80%">
	<tr><td>工作收入说明:<br>
	${(answer.remark)!}
 	</td></tr>
</table>
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
   <td>${member.name} (${(member.career.name)!}) 
   </td>
   </#list>
   <td>&nbsp;</td>
   </tr>
   
   <#list 1..planYears as i>
   <tr align="center">
   <td>第${i}年</td>
   <#assign total=0>
   <#list members as member>
   <td><#assign total=total+(salaries[member.name].get(i))!0>${(salaries[member.name].get(i))!0}</td>
   </#list>
   <td>${total}</td>
   </tr>
   </#list>
 </@>
</body>
 <#include "/template/foot.ftl"/>