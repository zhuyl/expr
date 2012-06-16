<#include "/template/head.ftl"/>
<#assign labInfo><@text name="实验答案"/></#assign>
<#include "/template/back.ftl"/>
<table width="90%" border="0" align="center" cellpadding="0" cellspacing="0" class="listTable">
  <tr  class="darkColumn"> 
    <td width="96%"><B>客户分析</B></td>
  </tr>
  <tr class="grayStyle"> 
    <td>家庭基本信息分析</td>
  </tr>
  <tr> 
    <td width="100%" valign="top">
	 <iframe src="answer/familyAnalysis.action?method=info&caze.id=${caze.id}" id="familyAnalysisFrame" name="familyAnalysisFrame" marginwidth="0" marginheight="0" scrolling="no" frameborder="0"  height="100%" width="100%"></iframe>
    </td>
  </tr>
  <tr  class="grayStyle"> 
    <td>家庭资产负债信息分析</td>
  </tr>
  <tr> 
    <td width="100%" valign="top">
	 <iframe src="answer/balanceSheet.action?method=info&caze.id=${caze.id}" id="balanceSheetFrame" name="balanceSheetFrame" marginwidth="0" marginheight="0" scrolling="no" frameborder="0"  height="100%" width="100%"></iframe>
    </td>
  </tr>
  </tr>
  <tr  class="grayStyle"> 
    <td>家庭月度收支分析</td>
  </tr>
  <tr> 
    <td width="100%" valign="top">
	 <iframe src="answer/incomeExpense.action?method=info&caze.id=${caze.id}" id="incomeExpenseFrame" name="incomeExpenseFrame" marginwidth="0" marginheight="0" scrolling="no" frameborder="0"  height="100%" width="100%"></iframe>
    </td>
  </tr>
  <tr  class="grayStyle"> 
    <td>保险资产明细分析</td>
  </tr>
  <tr> 
  	<td width="100%" valign="top">
	 <iframe src="answer/insuranceAnalysis.action?method=info&caze.id=${caze.id}" id="insuranceAnalysisFrame" name="insuranceAnalysisFrame" marginwidth="0" marginheight="0" scrolling="no" frameborder="0"  height="100%" width="100%"></iframe>
    </td>
  </tr>
  <tr  class="grayStyle"> 
    <td>金融资产明细分析</td>
  </tr>
  <tr> 
  	<td width="100%" valign="top">
	 <iframe src="answer/financeAssetAnalysis.action?method=info&caze.id=${caze.id}" id="financeAssetAnalysisFrame" name="financeAssetAnalysisFrame" marginwidth="0" marginheight="0" scrolling="no" frameborder="0"  height="100%" width="100%"></iframe>
    </td>
  </tr>
  <tr  class="grayStyle"> 
    <td>客户风险承受能力分析</td>
  </tr>
  <tr> 
    <td width="100%" valign="top">
	 <iframe src="answer/riskToleranceAnalysis.action?method=info&caze.id=${caze.id}" id="riskToleranceAnalysisFrame" name="riskToleranceAnalysisFrame" marginwidth="0" marginheight="0" scrolling="no" frameborder="0"  height="100%" width="100%"></iframe>
	</td>
  </tr>
  <tr  class="grayStyle"> 
    <td>客户分析综述</td>
  </tr>
  <tr> 
    <td width="100%" valign="top">
	 <iframe src="answer/analysisSummary.action?method=info&caze.id=${caze.id}" id="analysisSummaryFrame" name="analysisSummaryFrame" marginwidth="0" marginheight="0" scrolling="no" frameborder="0"  height="100%" width="100%"></iframe>
	</td>
  </tr>
  <tr  class="darkColumn"> 
    <td><B>理财目标分析</B></td>
  </tr>
  <tr  class="grayStyle"> 
    <td>客户理财目标分析</td>
  </tr>
  <tr  class="grayStyle"> 
    <td width="100%" valign="top">
	 <iframe src="answer/aimAnalysis.action?method=info&caze.id=${caze.id}" id="aimAnalysisFrame" name="aimAnalysisFrame" marginwidth="0" marginheight="0" scrolling="no" frameborder="0"  height="100%" width="100%"></iframe>
	</td>
  </tr>
  <tr  class="darkColumn"> 
    <td><B>理财规划制定</B></td>
  </tr>
  <tr  class="grayStyle"> 
    <td>工作收入规划制定</td>
  </tr>
  <tr> 
    <td width="100%" valign="top">
	 <iframe src="answer/cashPlan.action?method=info&caze.id=${caze.id}" id="cashPlanFrame" name="cashPlanFrame" marginwidth="0" marginheight="0" scrolling="no" frameborder="0"  height="100%" width="100%"></iframe>
	</td>
  </tr>
  <tr  class="grayStyle"> 
    <td>奖金收入规划制定</td>
  </tr>
  <tr> 
    <td width="100%" valign="top">
	 <iframe src="answer/bonusPlan.action?method=info&caze.id=${caze.id}" id="bonusPlanFrame" name="bonusPlanFrame" marginwidth="0" marginheight="0" scrolling="no" frameborder="0"  height="100%" width="100%"></iframe>
	</td>
  </tr>
  <tr  class="grayStyle"> 
    <td>其他收入规划制定</td>
  </tr>
  <tr> 
    <td width="100%" valign="top">
	 <iframe src="answer/otherIncomePlan.action?method=info&caze.id=${caze.id}" id="otherIncomePlanFrame" name="otherIncomePlanFrame" marginwidth="0" marginheight="0" scrolling="no" frameborder="0"  height="100%" width="100%"></iframe>
	</td>
  </tr>
  <tr  class="grayStyle"> 
    <td>消费规划制定</td>
  </tr>
  <tr> 
    <td width="100%" valign="top">
	 <iframe src="answer/consumePlan.action?method=info&caze.id=${caze.id}" id="consumePlanFrame" name="consumePlanFrame" marginwidth="0" marginheight="0" scrolling="no" frameborder="0"  height="100%" width="100%"></iframe>
	</td>
  </tr>
  <tr  class="grayStyle"> 
    <td>教育规划制定</td>
  </tr>
  <tr> 
    <td width="100%" valign="top">
	 <iframe src="answer/educationPlan.action?method=info&caze.id=${caze.id}" id="educationPlanFrame" name="educationPlanFrame" marginwidth="0" marginheight="0" scrolling="no" frameborder="0"  height="100%" width="100%"></iframe>
	</td>
  </tr>
  <tr  class="grayStyle"> 
    <td>保险规划制定</td>
  </tr>
  <tr> 
    <td width="100%" valign="top">
	 <iframe src="answer/insurancePlan.action?method=info&caze.id=${caze.id}" id="insurancePlanFrame" name="insurancePlanFrame" marginwidth="0" marginheight="0" scrolling="no" frameborder="0"  height="100%" width="100%"></iframe>
	</td>
  </tr>
  <tr  class="grayStyle"> 
    <td>医疗规划制定</td>
  </tr>
  <tr> 
    <td width="100%" valign="top">
	 <iframe src="answer/medicalPlan.action?method=info&caze.id=${caze.id}" id="medicalPlanFrame" name="medicalPlanFrame" marginwidth="0" marginheight="0" scrolling="no" frameborder="0"  height="100%" width="100%"></iframe>
	</td>
  </tr>
  <tr  class="grayStyle"> 
    <td>旅游规划制定</td>
  </tr>
  <tr> 
    <td width="100%" valign="top">
	 <iframe src="answer/tripPlan.action?method=info&caze.id=${caze.id}" id="tripPlanFrame" name="tripPlanFrame" marginwidth="0" marginheight="0" scrolling="no" frameborder="0"  height="100%" width="100%"></iframe>
	</td>
  </tr>
  <tr  class="grayStyle"> 
    <td>金融投资规划制定</td>
  </tr>
  <tr> 
    <td width="100%" valign="top">
	 <iframe src="answer/financeAssetPlan.action?method=info&caze.id=${caze.id}" id="financeAssetPlanFrame" name="financeAssetPlanFrame" marginwidth="0" marginheight="0" scrolling="no" frameborder="0"  height="100%" width="100%"></iframe>
	</td>
  </tr>
  <tr  class="grayStyle"> 
    <td>购车规划制定</td>
  </tr>
  <tr> 
    <td width="100%" valign="top">
	 <iframe src="answer/carPlan.action?method=info&caze.id=${caze.id}" id="carPlanFrame" name="carPlanFrame" marginwidth="0" marginheight="0" scrolling="no" frameborder="0"  height="100%" width="100%"></iframe>
	</td>
  </tr>
  <tr  class="grayStyle"> 
    <td>房产规划制定</td>
  </tr>
  <tr> 
    <td width="100%" valign="top">
	 <iframe src="answer/estateLoanPlan.action?method=info&caze.id=${caze.id}" id="estateLoanPlanFrame" name="estateLoanPlanFrame" marginwidth="0" marginheight="0" scrolling="no" frameborder="0"  height="100%" width="100%"></iframe>
	</td>
  </tr>
  <tr  class="grayStyle"> 
    <td>其他支出规划制定</td>
  </tr>
  <tr> 
    <td width="100%" valign="top">
	 <iframe src="answer/otherExpensePlan.action?method=info&caze.id=${caze.id}" id="otherExpensePlanFrame" name="otherExpensePlanFrame" marginwidth="0" marginheight="0" scrolling="no" frameborder="0"  height="100%" width="100%"></iframe>
	</td>
  </tr>
  <tr  class="grayStyle"> 
    <td>综合理财规划制定</td>
  </tr>
  <tr> 
    <td width="100%" valign="top">
	 <iframe src="answer/planSummary.action?method=info&caze.id=${caze.id}" id="planSummaryFrame" name="planSummaryFrame" marginwidth="0" marginheight="0" scrolling="no" frameborder="0"  height="100%" width="100%"></iframe>
	</td>
  </tr>
  <tr  class="darkColumn"> 
    <td><B>动态平衡</B></td>
  </tr>
  <tr  class="grayStyle"> 
    <td>动态平衡调整</td>
  </tr>
  <tr> 
    <td width="100%" valign="top">
	 <iframe src="answer/changeAnalysis.action?method=info&caze.id=${caze.id}" id="changeAnalysisFrame" name="changeAnalysisFrame" marginwidth="0" marginheight="0" scrolling="no" frameborder="0"  height="100%" width="100%"></iframe>
	</td>
  </tr>
  <tr  class="darkColumn"> 
    <td><B>理财方案评估</B></td>
  </tr>
  <tr  class="grayStyle"> 
    <td>单个产品收益率分析</td>
  </tr>
  <tr> 
    <td width="100%" valign="top">
	 <iframe src="answer/benefitAnalysis.action?method=info&caze.id=${caze.id}" id="benefitAnalysisFrame" name="benefitAnalysisFrame" marginwidth="0" marginheight="0" scrolling="no" frameborder="0"  height="100%" width="100%"></iframe>
	</td>
  </tr>
  <tr  class="grayStyle"> 
    <td>单个产品风险分析</td>
  </tr>
  <tr> 
    <td width="100%" valign="top">
	 <iframe src="answer/riskAnalysis.action?method=info&caze.id=${caze.id}" id="riskAnalysisFrame" name="riskAnalysisFrame" marginwidth="0" marginheight="0" scrolling="no" frameborder="0"  height="100%" width="100%"></iframe>
	</td>
  </tr>
  <tr  class="grayStyle"> 
    <td>收支结构对比分析</td>
  </tr>
  <tr> 
    <td width="100%" valign="top">
	 <iframe src="answer/balanceCompare.action?method=info&caze.id=${caze.id}" id="balanceCompareFrame" name="balanceCompareFrame" marginwidth="0" marginheight="0" scrolling="no" frameborder="0"  height="100%" width="100%"></iframe>
	</td>
  </tr>
  <tr  class="grayStyle"> 
    <td>金融资产结构对比分析</td>
  </tr>
  <tr> 
    <td width="100%" valign="top">
	 <iframe src="answer/financeCompare.action?method=info&caze.id=${caze.id}" id="financeCompareFrame" name="financeCompareFrame" marginwidth="0" marginheight="0" scrolling="no" frameborder="0"  height="100%" width="100%"></iframe>
	</td>
  </tr>
  <tr  class="grayStyle"> 
    <td>保险资产结构对比分析</td>
  </tr>
  <tr> 
    <td width="100%" valign="top">
	 <iframe src="answer/insuranceCompare.action?method=info&caze.id=${caze.id}" id="insuranceCompareFrame" name="insuranceCompareFrame" marginwidth="0" marginheight="0" scrolling="no" frameborder="0"  height="100%" width="100%"></iframe>
	</td>
  </tr>
</table>
<#include "/template/foot.ftl"/>