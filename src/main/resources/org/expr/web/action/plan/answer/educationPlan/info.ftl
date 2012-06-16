 <#include "/template/head.ftl"/>
<body>
<table class="formTable" align="center" width="80%">
	<tr><td>教育支出说明:<br>
	${(answer.remark)!}
 	</td></tr>
</table>
<@table.table id="memberTable" width="80%" align="center">
 <@table.thead>
   <@table.td text="年份"/>
   <#list members as member>
   <td>姓名(教育支出) </td>
   </#list>
   <td>总支出</td>
 </@>
   <tr align="center">
   <@table.td text=""/>
   <#list members as member>
   <td>${member.name} 
   </td>
   </#list>
   <td>&nbsp;</td>
   </tr>
   <#list 1..planYears as i>
   <tr align="center">
   <td>第${i}年</td>
   <#assign total=0>
   <#list members as member>
   <td>${(expenses[member.name].get(i))!(0)}</td>
   <#assign total=total+(expenses[member.name].get(i))!(0)>
   </#list>
   <td><#if (total>0)>${total}</#if></td>
   </tr>
   </#list>
 </@>

</body>
 <#include "/template/foot.ftl"/>