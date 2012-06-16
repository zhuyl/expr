<#if result??>
<table width="100%" align="center">
<#include "../../experiment/metadata.ftl"/>
<#import "/template/table.ftl" as table>
<#assign type>${Parameters['type']}</#assign>
<tr><td><B>${nameMap[type]}的说明：</B></td></tr>
<tr><td>${result.remark?if_exists}</td></tr>
</table>
<@table.table id="aimItemTable" width="100%" align="center">
 <@table.thead>
   <@table.td text="目标类型"/>
   <@table.td text="目标内容"/> 
 </@>
  <@table.tbody datas=result.items?if_exists;answer>
   <td>${(answer.aimtype.name)!}</td>
   <td>${(answer.content)!}</td>
 </@>
 </@>
<#else>
未做该部分</#if>