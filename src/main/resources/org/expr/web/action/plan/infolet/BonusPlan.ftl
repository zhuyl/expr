<#if result??>
<table width="100%" align="center">
<#include "../../experiment/metadata.ftl"/>
<#assign type>${Parameters['type']}</#assign>
<tr><td><B>${nameMap[type]}的说明：</B></td></tr>
<tr><td>${result.remark?if_exists}</td></tr>
</table>
<#assign members=result.members?sort_by('name')>
<#assign bonuses={}/>
<#list result.members as m>
<#assign bonuses=bonuses+{m.name:m.bonuses}/>
</#list>
<table width="100%" align="center" class="listTable">
 <tr class="darkColumn" align="center">
   <td>年份</td>
   <#list members as member>
   <td>姓名</td>
   </#list>
   <td>总收入</td>
 </tr>
   <tr align="center">
   <td></td>
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
   <td><#assign total=total+(bonuses[member.name].get(i))!0>${(bonuses[member.name].get(i))!0}</td>
   </#list>
   <td>${total}</td>
   </tr>
   </#list>
 </table>
<#else>
未做该部分
</#if>