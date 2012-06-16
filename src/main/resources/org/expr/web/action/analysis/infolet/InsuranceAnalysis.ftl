<#if result??>
<table width="100%" align="center">
<#include "../../experiment/metadata.ftl"/>
<#import "/template/table.ftl" as table>
<#assign type>${Parameters['type']}</#assign>
<tr><td><B>${nameMap[type]}的说明：</B></td></tr>
<tr><td>${result.remark?if_exists}</td></tr>
</table>
<@table.table id="policyTable" width="100%" align="center">
 <@table.thead>
   <@table.td text="保险名称"/>
   <@table.td text="保险公司"/>
   <@table.td text="被保险人"/>
   <@table.td text="投保人"/>
   <@table.td text="受益人"/>
   <@table.td text="投保日期"/>  
   <@table.td text="保险类型"/>
   <@table.td text="保额（元）"/>
   <@table.td text="年保费（元）"/>  
   <@table.td text="缴费期限"/>
   <@table.td text="缴费方式"/>
   <@table.td text="保险期限"/>          
   <@table.td text="是否附加险"/>  
   <@table.td text="主险名称" />   
 </@>
  <@table.tbody datas=result.form.policies?if_exists;answer>
   <td>${(answer.policy.name)!}</td>
   <td>${(answer.policy.company)!}</td>
   <td>${answer.policy.insurant!}</td>
   <td>${answer.policy.proposer!}</td>
   <td>${answer.policy.benefit!}</td>   
   <td>${(answer.policy.applyOn?string("yyyy-MM-dd"))?if_exists}</td>   
   <td>${(answer.policy.type.parent.name)!}|${(answer.policy.type.name)!}</td>
   <td>${answer.policy.coverage!}</td>
   <td>${answer.policy.expense!}</td>  
   <td>${answer.policy.payTime.name!}</td> 
   <td>${answer.policy.payType.name!}</td>    
   <td>${answer.policy.time.name!}</td> 
   <td>${(answer.policy.additional!false)?string("是","否")}</td>
   <td>${(answer.master.name)!}</td> 
 </@>
 </@>
<#else>
未做该部分
</#if>