 <#include "/template/head.ftl"/>
<body>
  <table class="formTable" align="center" width="80%">
	<tr><td>单个产品收益率分析说明:<br>
	${(benefitAnswer.remark)!}
 	</td></tr>
 </table>
<@table.table id="memberTable" width="80%" align="center">
 <@table.thead>
   <@table.td text="产品类型"/>
   <@table.td text="收益率分析"/>
 </@>
 <#list items as item>
 <tr>
   <td>${(item.financetype.name)!}</td>
   <td>${(item.content)!}</td>
 </tr>
 </#list>
 </@>
</body>
 <#include "/template/foot.ftl"/>