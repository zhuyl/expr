<#if result??>
<table width="100%" align="center">
<#include "../../experiment/metadata.ftl"/>
<#import "/template/table.ftl" as table>
<#assign type>${Parameters['type']}</#assign>
<tr><td><B>${nameMap[type]}的说明：</B></td></tr>
<tr><td>${result.remark?if_exists}</td></tr>
</table>
<table class="listTable" width="100%" align="center">
 <tr class="darkColumn" align="center">
   <td>年份</td>
   <td>其他支出</td>
 </tr>
   <#list 1..planYears as i>
   <tr align="center">
   <td>第${i}年</td>
   <td>${(result.amounts.get(i))!(0)}</td>
   </tr>
   </#list>
 </table>
<#else>
未做该部分
</#if>