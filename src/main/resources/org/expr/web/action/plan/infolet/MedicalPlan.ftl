<#if result??>
<table width="100%" align="center">
<#include "../../experiment/metadata.ftl"/>
<#import "/template/table.ftl" as table>
<#assign type>${Parameters['type']}</#assign>
<tr><td><B>${nameMap[type]}的说明：</B></td></tr>
<tr><td>${result.remark?if_exists}</td></tr>
</table>
<#assign expenses={}>
<#list result.members?if_exists as m>
<#assign expenses=expenses+{m.name:m.expenses}/>
</#list>
<@table.table width="100%" align="center">
 <@table.thead>
   <@table.td text="年份"/>
   <#list result.members?if_exists as member>
   <td>姓名(医疗支出) </td>
   </#list>
   <td>总支出</td>
 </@>
   <tr align="center">
   <@table.td text=""/>
   <#list result.members?if_exists as member>
   <td>${member.name}</td>
   </#list>
   <td>&nbsp;</td>
   </tr>
   <#list 1..planYears as i>
   <tr align="center">
   <td>第${i}年</td>
   <#assign total=0>
   <#list result.members?if_exists as member>
   <td>${(expenses[member.name].get(i))!(0)}</td>
   <#assign total=total+(expenses[member.name].get(i))!(0)>
   </#list>
   <td><#if (total>0)>${total}</#if></td>
   </tr>
   </#list>
 </@>
<#else>
未做该部分
</#if>