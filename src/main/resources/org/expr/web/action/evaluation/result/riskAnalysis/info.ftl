 <#include "/template/head.ftl"/>
<body>
  <table class="formTable" align="center" width="80%">
	<tr><td>单个产品风险分析说明:<br>
	${(analysisResult.remark)!}
 	</td></tr>
 </table>
<@table.table id="memberTable" width="80%" align="center">
 <@table.thead>
   <@table.td text="产品类型"/>
   <@table.td text="风险分析"/>
 </@>
 <#list results as result>
 <tr>
   <td>${(result.financetype.name)!}</td>
   <td>${(result.content)!}</td>
 </tr>
 </#list>
 </@>
</body>
 <#include "/template/foot.ftl"/>