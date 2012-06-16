<#include "/template/head.ftl"/>
<body>
<table class="formTable" align="center" width="85%">
	<tr><td>保险支出说明:<br>
	${(answer.remark)!}
 	</td></tr>
</table>
<@table.table width="85%" id="listTable" align="center">
  <@table.thead>
    <td><div align="center">产品名称</div></td>
    <td><div align="center">保险公司名称</div></td>
    <td><div align="center">被保险人</div></td>
    <td><div align="center">投保人</div></td>    
    <td><div align="center">受益人</div></td>
    <td><div align="center">投保年份</div></td>    
    <td><div align="center">保险类型</div></td>
    <td><div align="center">缴费期限</div></td>
    <td><div align="center">缴费方式</div></td>
    <td><div align="center">保险期限</div></td>
    <td><div align="center">保额（元）</div></td>
    <td><div align="center">保费（元）</div></td>
    <td><div align="center">主险名称</div></td>       
  </@>

  <@table.tbody datas=answer.policies;policyAnswer>
    <td>${(policyAnswer.product.name)!}</td>
    <td>${(policyAnswer.product.corporation)!}</td>
    <td>${(policyAnswer.insurant)!}</td>
    <td>${(policyAnswer.proposer)!}</td>
    <td>${(policyAnswer.benefit)!}</td>
    <td>${(policyAnswer.applyOn)!}</td>
    <td>${(policyAnswer.product.type.parent.name)!}|${(policyAnswer.product.type.name)!}</td>
    <td>${(policyAnswer.payTime.name)!}</td>
    <td>${(policyAnswer.payType.name)!}</td>
    <td>${policyAnswer.time.name}</td> 
    <td>${(policyAnswer.coverage)!}</td>
    <td>${(policyAnswer.expense)!}</td> 
   <td>${(policyAnswer.master.name)!}</td>    
  </@>

</@>
<br>

<@table.table id="memberTable" width="85%" align="center">   
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
</body>
<#include "/template/foot.ftl"/>