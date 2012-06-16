<#include "../../experiment/metadata.ftl"/>
<#import "/template/table.ftl" as table>
<#if planResult??><#assign result=planResult/></#if>
<#if planAnswer??><#assign result=planAnswer/></#if>
<#assign type>${Parameters['type']}</#assign>

<#if result??&&(result.remark??||result.assets?size!=0)>
<table width="100%" align="center">
<tr><td><B>${nameMap[type]}的说明：</B></td></tr>
<tr><td>${(result.remark)?if_exists}</td></tr>
</table>
<@table.table width="100%"  align="center">
    <@table.thead>
       <@table.td name="资产类型" id="asset.finance.financetype"/>
       <@table.td name="风险等级" id="asset.finance.riskgrade"/>   
       <@table.td name="流动性" id="asset.finance.mobility"/>
       <@table.td name="计息周期" id="asset.finance.ratepayperiod"/>  
       <@table.td name="预计年收益率(%)" id="asset.finance.rate"/>
       <@table.td name="投资金额(元)" id="asset.amount"/>     
       <@table.td name="追加投资占比(%)" id="asset.amount"/>   
       <@table.td name="开始年份" id="asset.startYear"/> 
       <@table.td name="结束年份" id="asset.endYear"/>  
       <@table.td name="建议产品" id="asset.endYear"/>
    </@>
    <#list result.assets?if_exists as answer>
    <tr>
       <td>${(answer.financetype.parent)?if_exists.name?if_exists}|${(answer.financetype)?if_exists.name?if_exists}</td> 
       <td>${(answer.riskgrade)?if_exists.name?if_exists}</td>
       <td>${(answer.mobility.name)?if_exists}</td>
       <td>${(answer.ratepayperiod)?if_exists.name?if_exists}</td>
       <td>${(answer.rate)?if_exists}%</td> 
       <td>${answer.amount?if_exists}</td>  
       <td>${answer.append?if_exists}</td>                           
       <td>${answer.startYear?if_exists}</td>
       <td>${answer.endYear?if_exists}</td>
       <td>${answer.finances?if_exists}</td>
    </tr>
    </#list>
   </@>

<@table.table width="100%" align="center">
 <@table.thead>
   <@table.td text="年份"/>
   <#list result.assets?if_exists as answer>
   <td colspan="4">金融资产名称 <br>${answer.financetype.name}</td>
   </#list>
   <@table.td text="期初总资产"/>
   <@table.td text="总投入"/>
   <@table.td text="总收益"/>
   <@table.td text="期末总资产"/>   
 </@>
   <tr align="center">
   <@table.td text=""/>
   <#list result.assets?if_exists as answer>
 <td>期初资产</td>
 <td>追加投资</td>
 <td>收益</td>
 <td>期末资产</td>
   </#list>
   <td>&nbsp;</td>
   <td>&nbsp;</td>
   <td>&nbsp;</td>
   <td>&nbsp;</td>
   </tr>
   
   <#list 1..planYears as i>
   <tr align="center">
   <td>第${i}年</td>
   <#assign totalincome=0>
   <#assign totalexpense=0>
   <#assign totalcapital=0>
   <#list result.assets?if_exists as answer>
  <td>${capitals[answer.financetype.name].get(i)!0}</td>
  <td>${expenses[answer.financetype.name].get(i)!0}</td>
  <td>${incomes[answer.financetype.name].get(i)!0}</td>
  <td>${(incomes[answer.financetype.name].get(i)!0)+(capitals[answer.financetype.name].get(i)!0)+(expenses[answer.financetype.name].get(i)!0)}</td>  
  <#assign totalincome=totalincome+(incomes[answer.financetype.name].get(i)!0)>
 <#assign totalexpense=totalexpense+(expenses[answer.financetype.name].get(i)!0)>
  <#assign totalcapital=totalcapital+(capitals[answer.financetype.name].get(i)!0)>
   </#list>
   <td>${totalcapital!0}</td>
   <td>${totalexpense!0}</td>
    <td>${totalincome!0}</td>
    <td>${(totalexpense!0)+(totalcapital!0)+(totalincome!0)}</td>
   </tr>
   </#list>
 </@>
 <#else>
未做该部分
</#if>