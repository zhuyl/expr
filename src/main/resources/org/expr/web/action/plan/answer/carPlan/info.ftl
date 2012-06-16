 <#include "/template/head.ftl"/>
<body>
<table class="formTable" align="center" width="80%">
	<tr><td>购车规划说明:<br>
	${(answer.remark)!}
 	</td></tr>
</table>
<@table.table id="memberTable" width="80%" align="center">
  <tr  align="center" class="darkColumn"> 
    <td rowspan="2">年份</td>
    <td rowspan="2">车辆价值${(answer.carCapital)!}</td>
    <td colspan="3">贷款${(answer.businessCapital)!}
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
   <td>${(amount.get(i))!(0)}</td>
   <#if answer.loans.get(i)??>
   <#assign loan=answer.loans.get(i)>
   <td>${(loan.business.capital)!(0)}</td>
   <td>${(loan.business.interest)!(0)}</td>
   <td>${(loan.business.total)!(0)}</td>
   <td>${(loan.capital)!(0)}</td>
   <td>${(amount.get(i))?if_exists-(loan.capital)?if_exists!0}</td>
   <#else>
   <#list 1..4 as i><td>0</td></#list>
   <td>${(amount.get(i))!(0)}</td>  
   </#if>
   </tr>
   </#list>
 </@>
</body>
 <#include "/template/foot.ftl"/>