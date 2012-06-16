<#include "/template/head.ftl"/>
<body>
<table class="formTable" align="center" width="80%">
	<tr><td>家庭基本信息分析说明:<br>
	${(analysisAnswer.remark)!}
 	</td></tr>
 	<tr>
	<@table.table id="memberTable" width="80%" align="center">
	 <@table.thead>
	   <@table.td text="姓名"/>
	   <@table.td text="性别"/>
	   <@table.td text="年龄"/>
	   <@table.td text="出生日期"/>
	   <@table.td text="职业"/>
	   <@table.td text="家庭关系"/>
	   <@table.td text="收入（元）"/>
	   <@table.td text="工作单位"/>
	 </@>
	 <#list answers as answer>
	 <tr>
	   <td>${answer.member.name}</td>
	   <td>${answer.member.gender.name}</td>
	   <td>${answer.member.age!}</td>
	   <td>${(answer.member.birthday?string('yyyy-MM-dd'))?if_exists}</td>  
	   <td>${(answer.member.career.parent.parent.name)}|${(answer.member.career.parent.name)}|${(answer.member.career.name)!}</td>
	   <td>${(answer.member.relation.name)!}</td>
	   <td>${answer.member.salary!}</td>
	   <td>${answer.member.department!}</td>
	 </tr>  
	 </#list>
	 </@>
	 </tr>
</body>
 <#include "/template/foot.ftl"/>