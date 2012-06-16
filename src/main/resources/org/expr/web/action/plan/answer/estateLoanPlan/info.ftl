 <#include "/template/head.ftl"/>
<body>
<table class="formTable" align="center" width="80%">
	<tr><td>房产规划说明:<br>
	${(answer.remark)!}
 	</td></tr>
</table>
<@table.table id="memberTable" width="80%" align="center">
<tr  align="center" class="darkColumn">
   <td rowspan="2">年份</td>
   <td rowspan="2">房产价值${(answer.houseCapital)!}</td>
   <td colspan="4">商业贷款${(answer.businessCapital)!}</td>
   <td colspan="4">公积金贷款${(answer.accumulationCapital)!}</td>
   <td rowspan="2">总还款</td>
   <td rowspan="2">总负债</td>
   <td rowspan="2">总资产</td>
</tr>
<tr  align="center"  class="darkColumn">
   <td>本金</td>
   <td>利息</td>
   <td>还款总额</td>
   <td>商业负债</td>
   <td>本金</td>
   <td>利息</td>
   <td>还款总额</td>
   <td>公积金负债</td>
</tr>

   <#list 1..planYears as i>
   <tr align="center">
   <td>第${i}年</td>
   <td>${(amount.get(i))!(0)}</td>
   <#if answer.loans.get(i)??>
   <#assign loan=answer.loans.get(i)>
   <td>${(loan.business.capital)!}</td>
   <td>${(loan.business.interest)!}</td>
   <td>${(loan.business.total)!}</td>
   <td>${(loan.businessCapital)!}</td>
   <td>${(loan.accumulation.capital)!}</td>
   <td>${(loan.accumulation.interest)!}</td>
   <td>${(loan.accumulation.total)!}</td>
   <td>${(loan.accumulationCapital)!}</td>
   <td>${((loan.accumulation.total)!0)+((loan.business.total)!0)}</td>
   <td>${((loan.businessCapital)!0)+((loan.accumulationCapital)!0)}</td>
   <td>${((amount.get(i))!0)-(((loan.businessCapital)!0)+((loan.accumulationCapital)!0))}</td>
   <#else>
   <#list 1..11 as i><td></td></#list>
   </#if>
   </tr>
   </#list>
 </@>
</body>
 <#include "/template/foot.ftl"/>