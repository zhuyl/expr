<@table.table id="memberTable" width="80%" align="center">
  <tr  align="center" class="darkColumn"> 
    <td rowspan="2">年份</td>
    <td rowspan="2">车辆价值${(result.carCapital)!}<button onclick="carForm()">修改</button></td>
    <td colspan="3">贷款${(result.businessCapital)!}
      <button onclick="edit('business')">修改</button></td>
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
   <#if result.loans.get(i)??>
   <#assign loan=result.loans.get(i)>
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
 
  <form name="actionForm" method="post" action="${base}/result/carPlan!edit.action?experiment.id=${Parameters['experiment.id']}">
 	<input name="loanType" type="hidden" value=""/>
 </form>
 <script>
 	function edit(name){
 		document.actionForm['loanType'].value=name;
 		document.actionForm.submit();
 	}
 	
 	function carForm(){
 		document.actionForm.action="${base}/result/carPlan!carForm.action?experiment.id=${Parameters['experiment.id']}";
 		document.actionForm.submit();
 	}
 </script>