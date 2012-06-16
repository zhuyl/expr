<@table.table id="memberTable" width="80%" align="center">
<tr  align="center" class="darkColumn">
   <td rowspan="2">年份</td>
   <td rowspan="2">房产价值${(result.houseCapital)!}<button onclick="houseForm()">修改</button></td>
   <td colspan="4">商业贷款${(result.businessCapital)!}<button onclick="edit('business')">修改</button></td>
   <td colspan="4">公积金贷款${(result.accumulationCapital)!}<button onclick="edit('accumulation')">修改</button></td>
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
   <#if result.loans.get(i)??>
   <#assign loan=result.loans.get(i)>
   <td>${(loan.business.capital)!0}</td>
   <td>${(loan.business.interest)!0}</td>
   <td>${(loan.business.total)!0}</td>
   <td>${(loan.businessCapital)!0}</td>
   <td>${(loan.accumulation.capital)!0}</td>
   <td>${(loan.accumulation.interest)!0}</td>
   <td>${(loan.accumulation.total)!0}</td>
   <td>${(loan.accumulationCapital)!0}</td>
   <td>${((loan.accumulation.total)!0)+((loan.business.total)!0)}</td>
   <td>${((loan.businessCapital)!0)+((loan.accumulationCapital)!0)}</td>
   <td>${((amount.get(i))!0)-(((loan.businessCapital)!0)+((loan.accumulationCapital)!0))}</td>
   <#else>
   <#list 1..11 as i><td></td></#list>
   </#if>
   </tr>
   </#list>
 </@>
 
  <form name="actionForm" method="post" action="${base}/result/estateLoanPlan!edit.action?experiment.id=${Parameters['experiment.id']}">
 	<input name="loanType" type="hidden" value=""/>
 </form>
 <script>
 	function edit(name){
 		document.actionForm['loanType'].value=name;
 		document.actionForm.submit();
 	}
 	function houseForm(){
 		document.actionForm.action="${base}/result/estateLoanPlan!houseForm.action?experiment.id=${Parameters['experiment.id']}";
 		document.actionForm.submit();
 	}
 </script>