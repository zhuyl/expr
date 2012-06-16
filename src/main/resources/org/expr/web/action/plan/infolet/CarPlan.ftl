<#if result??>
<table width="100%" align="center">
<#include "../../experiment/metadata.ftl"/>
<#import "/template/table.ftl" as table>
<#assign type>${Parameters['type']}</#assign>
<tr><td><B>${nameMap[type]}的说明：</B></td></tr>
<tr><td>${result.remark?if_exists}</td></tr>
</table>
<@table.table width="100%" align="center">
  <tr  align="center" class="darkColumn"> 
    <td rowspan="2">年份</td>
    <td rowspan="2">车辆价值${(result.carCapital)!}</td>
    <td colspan="3">贷款${(result.businessCapital)!}
    </td>
    <td rowspan="2">负债</td>
    <td rowspan="2">总资产</td>
  </tr>
  <tr  align="center"  class="darkColumn"> 
    <td>本金</td>
    <td>利息</td>
    <td>还款总额</td>
  </tr>

   <#list 1..planYears as i>
   <tr align="center">
   <td>第${i}年</td>
   <td>${(result.expenses.get(i))!(0)}</td>
   <#if result.loans.get(i)??>
   <#assign loan=result.loans.get(i)>
   <td>${(loan.business.capital)!(0)}</td>
   <td>${(loan.business.interest)!(0)}</td>
   <td>${(loan.business.total)!(0)}</td>
   <td>${(loan.capital)!(0)}</td>
   <td>${(result.expenses.get(i))?if_exists-(loan.capital)?if_exists!0}</td>
   <#else>
   <#list 1..4 as i><td>0</td></#list>
   <td>${(result.expenses.get(i))!(0)}</td>  
   </#if>
   </tr>
   </#list>
 </@>
<#else>
未做该部分
</#if>