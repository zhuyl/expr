<#if result??>
<#include "../../experiment/metadata.ftl"/>
<#import "/template/table.ftl" as table>
<#assign type>${Parameters['type']}</#assign>
<table width="100%" align="center">
<tr><td><B>${nameMap[type]}的说明：</B></td></tr>
<tr><td>${(result.remark)?if_exists}</td></tr>
</table>
<@table.table id="memberTable" width="100%" align="center">
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
 <@table.tbody datas=result.form.members?if_exists;result>
   <td>${result.member.name!}</td>
   <td>${result.member.gender.name!}</td>
   <td>${result.member.age!}</td>
   <td>${(result.member.birthday?string('yyyy-MM-dd'))?if_exists}</td>  
   <td>${(result.member.career.parent.parent.name)}|${(result.member.career.parent.name)}|${(result.member.career.name)!}</td>
   <td>${(result.member.relation.name)!}</td>
   <td>${result.member.salary!}</td>
   <td>${result.member.department!}</td>
   </@>
 </@>
<#else>
未做该部分
</#if>