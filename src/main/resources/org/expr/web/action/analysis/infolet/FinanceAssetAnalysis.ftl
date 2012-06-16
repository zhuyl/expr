<#if result??>
<table width="100%" align="center">
<#include "../../experiment/metadata.ftl"/>
<#import "/template/table.ftl" as table>
<#assign type>${Parameters['type']}</#assign>
<tr><td><B>${nameMap[type]}的说明：</B></td></tr>
<tr><td>${result.remark?if_exists}</td></tr>
</table>
  <@table.table width="100%"  align="center">
    <@table.thead>
       <@table.td name="资产名称" id="asset.asset.name"/>
       <@table.td name="资产类型" id="asset.asset.financetype"/>
       <@table.td name="风险等级" id="asset.asset.riskgrade"/>   
       <@table.td name="流动性" id="asset.asset.mobility"/>
       <@table.td name="计息周期" id="asset.asset.ratepayperiod"/>  
       <@table.td name="年收益率(%)" id="asset.asset.rate"/>
       <@table.td name="投资金额(元)" id="asset.asset.amount"/>                           
    </@>
  	<@table.tbody datas=result.form.assets?if_exists;answer>
       <td>${answer.asset.name?if_exists}</td>
       <td>${(answer.asset.financetype.parent?if_exists).name?if_exists}|${(answer.asset.financetype?if_exists).name?if_exists}</td> 
       <td>${(answer.asset.riskgrade?if_exists).name?if_exists}</td>
       <td>${(answer.asset.mobility.name?if_exists)?if_exists}</td>
       <td>${(answer.asset.ratepayperiod?if_exists).name?if_exists}</td>
       <td>${answer.asset.rate?if_exists}%</td> 
       <td>${answer.asset.amount?if_exists}</td>                             
    </@>
   </@>
<#else>
未做该部分
</#if>