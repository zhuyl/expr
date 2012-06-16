<table width="100%" align="center">
<#include "../../experiment/metadata.ftl"/>
<#import "/template/table.ftl" as table>
<#if answer??><#assign result=answer></#if>
<#assign type>${Parameters['type']}</#assign>
<#if result??&&(result.remark??||(result.policies?size>0))>
<tr><td><B>${nameMap[type]}的说明：</B></td></tr>
<tr><td>${result.remark?if_exists}</td></tr>
</table>

<@table.table width="100%" align="center">
  <@table.thead>
    <td>产品名称</td>
    <td>保险公司名称</td>
    <td>被保险人</td>
    <td>投保人</td>    
    <td>受益人</td>
    <td>投保年份</td>    
    <td>保险类型</td>
    <td>缴费期限</td>
    <td>缴费方式</td>
    <td>保险期限</td>
    <td>保额（元）</td>
    <td>保费（元）</td>
    <td>主险名称</td>
  </@>

  <@table.tbody datas=result.policies?if_exists;policyAnswer>
    <td>${(policyAnswer.product.name)!}</td>
    <td>${(policyAnswer.product.corporation)!}</td>
    <td>${(policyAnswer.insurant)!}</td>
    <td>${(policyAnswer.proposer)!}</td>
    <td>${(policyAnswer.benefit)!}</td>
    <td>${(policyAnswer.applyOn)!}</td>
    <td>${(policyAnswer.product.type.parent.name)!}|${(policyAnswer.product.type.name)!}</td>
    <td>${(policyAnswer.payTime.name)!}</td>
    <td>${(policyAnswer.payType.name)!}</td>
    <td>${policyAnswer.time.name!}</td> 
    <td>${(policyAnswer.coverage)!}</td>
    <td>${(policyAnswer.expense)!}</td> 
   <td>${(policyAnswer.master.name)!}</td>    
  </@>
</@>
<@table.table id="memberTable" width="100%" align="center">   
 <@table.thead>
   <@table.td text="年份"/>
   <#list members as member>
   <td colspan=${memberpolicies[member.name]?size*2+2}>姓名(${member.name})</td>
   </#list>
   <@table.td text="总保额(元)"/>
   <@table.td text="总保费(元)"/>
 </@>
   <tr align="center">
   <@table.td text=""/>
   <#list members as member>
   	<#list memberpolicies[member.name] as policy>
   <td colspan='2'>${policy.product.name}|保额(元),保费(元)</td>
   	</#list>
   	<td>个人总保额(元)</td>
   	<td>个人总保费(元)</td>
   </#list>
   <td>&nbsp;</td>
   <td>&nbsp;</td>
   </tr>
   
   
<#list 1..planYears as i>
   <tr align="center">
   <td>第${i}年</td>
    <#assign totalcoverage=0>
   <#assign totalexpense=0>  
   <#list members as member>
    <#assign membercoverages=0>
   <#assign memberexpenses=0>  
   	<#list memberpolicies[member.name] as policy>   	
  <td>${(coverages[member.name][policy.product.name].get(i))!0}</td>
  <td>${(expenses[member.name][policy.product.name].get(i))!0}</td>
  <#assign membercoverages=membercoverages+(coverages[member.name][policy.product.name].get(i))!0>
 <#assign memberexpenses=memberexpenses+(expenses[member.name][policy.product.name].get(i))!0>
    </#list>
   <td>${membercoverages}</td>
   <td>${memberexpenses}</td>
  <#assign totalcoverage=totalcoverage+membercoverages>
 <#assign totalexpense=totalexpense+memberexpenses>    
   </#list>
    <td>${totalcoverage}</td>
   <td>${totalexpense}</td>  
   </tr>
</#list>
 </@>
<#else>
未做该部分
</#if>