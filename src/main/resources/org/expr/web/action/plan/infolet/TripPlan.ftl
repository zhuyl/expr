<#if result??>
<table width="100%" align="center">
<#include "../../experiment/metadata.ftl"/>
<#import "/template/table.ftl" as table>
<#assign type>${Parameters['type']}</#assign>
<tr><td><B>${nameMap[type]}的说明：</B></td></tr>
<tr><td>${result.remark?if_exists}</td></tr>
</table>
<@table.table  width="100%" align="center">
 <@table.thead>
   <@table.td text="年份"/>
   <td>旅游支出</td>
 </@>
   <#list 1..planYears as i>
   <tr align="center">
   <td>第${i}年</td>
   <td>${(result.expenses.get(i))!(0)}</td>
   </tr>
   </#list>
 </@>
<#else>
未做该部分
</#if>