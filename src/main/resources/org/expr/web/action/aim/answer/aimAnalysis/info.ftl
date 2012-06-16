 <#include "/template/head.ftl"/>
<body>
  <table class="formTable" align="center" width="80%">
	<tr><td>理财目标分析说明:<br>
	${(analysisAnswer.remark)!}
 	</td></tr>
 </table>
<@table.table id="memberTable" width="80%" align="center">
 <@table.thead>
   <@table.td text="目标类型"/>
   <@table.td text="目标内容"/>
 </@>
 <#list answers as answer>
 <tr>
   <td>${(answer.aimtype.name)!}</td>
   <td>${(answer.content)!}</td>
 </tr>
 </#list>
 </@>

</body>
 <#include "/template/foot.ftl"/>