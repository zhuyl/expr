package org.expr.web.action;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.lang.StringUtils;
import org.beanfuse.collection.Order;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.aim.result.AimResult;
import org.expr.model.analysis.AbstractResult;
import org.expr.model.analysis.AnalysisForm;
import org.expr.model.analysis.BalanceOfPayment;
import org.expr.model.analysis.ExpendHolder;
import org.expr.model.analysis.FamilyMember;
import org.expr.model.analysis.IncomeHolder;
import org.expr.model.analysis.result.AnalysisSummaryResult;
import org.expr.model.analysis.result.BalanceOfPaymentResult;
import org.expr.model.analysis.result.CazeResult;
import org.expr.model.analysis.result.ChangeResult;
import org.expr.model.analysis.result.ExpendResult;
import org.expr.model.analysis.result.FamilyAnalysisResult;
import org.expr.model.analysis.result.FamilyMemberResult;
import org.expr.model.analysis.result.FinanceAssetAnalysisResult;
import org.expr.model.analysis.result.FinanceAssetResult;
import org.expr.model.analysis.result.FundsAnalysisResult;
import org.expr.model.analysis.result.FundsAssetResult;
import org.expr.model.analysis.result.FundsLiabilityResult;
import org.expr.model.analysis.result.IncomeResult;
import org.expr.model.analysis.result.InsuranceAnalysisResult;
import org.expr.model.analysis.result.InsurancePolicyResult;
import org.expr.model.analysis.result.RiskToleranceResult;
import org.expr.model.assessment.AssessItem;
import org.expr.model.basecode.Analysis;
import org.expr.model.basecode.ExpendProject;
import org.expr.model.basecode.FinanceType;
import org.expr.model.basecode.IncomeProject;
import org.expr.model.basecode.InsuranceType;
import org.expr.model.basecode.Mobility;
import org.expr.model.basecode.RiskGrade;
import org.expr.model.evaluation.result.BalanceCompareResult;
import org.expr.model.evaluation.result.BenefitResult;
import org.expr.model.evaluation.result.FinanceCompareResult;
import org.expr.model.evaluation.result.InsuranceCompareResult;
import org.expr.model.evaluation.result.RiskResult;
import org.expr.model.lesson.Experiment;
import org.expr.model.lesson.ExperimentMark;
import org.expr.model.lesson.StudyLog;
import org.expr.model.plan.result.BonusPlanResult;
import org.expr.model.plan.result.CarPlanResult;
import org.expr.model.plan.result.CashPlanResult;
import org.expr.model.plan.result.ConsumePlanResult;
import org.expr.model.plan.result.EducationPlanResult;
import org.expr.model.plan.result.EstateLoanPlanResult;
import org.expr.model.plan.result.FinanceAssetPlanResult;
import org.expr.model.plan.result.FinancePlanResult;
import org.expr.model.plan.result.InsurancePlanPolicyResult;
import org.expr.model.plan.result.InsurancePlanResult;
import org.expr.model.plan.result.MedicalPlanResult;
import org.expr.model.plan.result.MemberBonusPlanResult;
import org.expr.model.plan.result.MemberCashPlanResult;
import org.expr.model.plan.result.MemberEducationPlanResult;
import org.expr.model.plan.result.MemberMedicalPlanResult;
import org.expr.model.plan.result.OtherExpensePlanResult;
import org.expr.model.plan.result.OtherIncomePlanResult;
import org.expr.model.plan.result.PlanSummaryResult;
import org.expr.model.plan.result.TripPlanResult;
import org.expr.web.action.plan.result.AbstractPlanResultAction;
import org.jfree.chart.plot.PiePlot;
import org.jfree.data.general.DefaultPieDataset;

import com.ekingstar.eams.student.Student;
import com.ekingstar.eams.util.stat.CountItem;
import com.ekingstar.eams.util.stat.GeneralDatasetProducer;
import com.ekingstar.eams.web.action.BaseAction;


/**
 * 作业查看界面
 * 
 * @author Administrator
 * 
 */
public class ExperimentCheckAction extends BaseAction {

	/**
	 * 查询结果，必要时生成初始结果
	 * @param experiment
	 * @return
	 */
	protected void addStdCondition(EntityQuery query,String prefix,Student std){
		if (null == std) {
			query.add(new Condition(prefix+".student.id=:stdId", getLong("std.id")));
		} else {
			query.add(new Condition(prefix+".student=:std", std));
		}
	}
	public int getPlanYears() {
		return 30;
	}
	public String index() {
		Long experiment_id = getLong("experiment.id");
		put("experimentId", experiment_id);
		Long student_id=getLong("std.id");
		put("studentId",student_id);		

		return forward();
	}
//	
	
	public String experimentDetail(){
		Long experiment_id = getLong("experimentId");		
		Experiment experiment = (Experiment) entityService.load(Experiment.class, experiment_id);	
		put("experiment", experiment);
		return forward();
	}
	public String analysisTree() {	
		Long experiment_id = getLong("experimentId");
		Experiment experiment = (Experiment) entityService.load(Experiment.class, experiment_id);
		Set analysisSet = new HashSet();
		Set analysisPhaseSet = new HashSet();
		for (Iterator iter = experiment.getMarks().iterator(); iter.hasNext();) {
			ExperimentMark mark = (ExperimentMark) iter.next();
			analysisSet.add(mark.getAnalysis().getCode());
			analysisPhaseSet.add(mark.getAnalysis().getPhase().getCode());
		}
		put("analysisSet", analysisSet);
		put("analysisPhaseSet", analysisPhaseSet);
		put("experiment", experiment);
		Long studentId = getLong("studentId");
		put("studentId",studentId);
		return forward();
	}
//
	public String studyLogs() {
		EntityQuery query = new EntityQuery(StudyLog.class, "log");
		query.add(new Condition("log.std.code=:stdCode", getLoginName()));
		query.add(new Condition("log.experiment.id=:experimentId", getLong("experimentId")));
		query.addOrder(Order.asc("log.startAt"));
		List rs = (List) entityService.search(query);
		put("logs", rs);
		return forward();
	}
//
//
	private <T> T getResult(Class<T> clazz, Experiment experiment,Long stdId) {
		EntityQuery query = new EntityQuery(clazz, "result");
		query.add(new Condition("result.experiment=:experiment", experiment));
		query.add(new Condition("result.student.id=:stdId", stdId));	
		List results = entityService.search(query);
		if (!results.isEmpty()) {
			return (T) results.get(0);
		} else {
			return null;
		}
	}

	/**
	 * 作业批改结果
	 * 
	 * @return
	 * @throws NoSuchMethodException 
	 * @throws InvocationTargetException 
	 * @throws IllegalAccessException 
	 */
	public String checkResult() throws IllegalAccessException, InvocationTargetException, NoSuchMethodException {
		Long stdId = getEntityId("std");
		Long expId = getLong("experiment.id");
		Experiment exp=(Experiment)entityService.get(Experiment.class, expId);
		put("experiment",exp);
		EntityQuery query = new EntityQuery(CazeResult.class, "r");
		query.add(new Condition("r.student.id=:stdId",stdId));
		query.add(new Condition("r.experiment.id=:experimentId",expId));		
		List<CazeResult> results = entityService.search(query);
		List<Analysis> analysisTalbes=entityService.loadAll(Analysis.class);
		Map<String,Float> ScoreMap=new HashMap();
		CazeResult result = null;
		if (results.size() > 0) {
			result = results.get(0);
			put("result", result);
			//取各分析表得分
			for (int i=0;i<analysisTalbes.size();i++){
				Analysis analysisTalbe=analysisTalbes.get(i);
				if (exp.getMark(analysisTalbe)!=null)
				{
					String hql="from "+analysisTalbe.getEngName()+"Result r where r.student.id=:stdId and r.experiment.id=:expId";
					Map params=new HashMap();
					params.put("stdId", stdId);
					params.put("expId", expId);
					Float score=0f;
					String remark=new String();
					List forms = entityService.searchHQLQuery(hql, params);
					if(forms.size()>0){
						 Object form=forms.get(0);	
						 score=(Float)PropertyUtils.getProperty(form,"score");
					}
					ScoreMap.put(analysisTalbe.getEngName(), score);
				}
			}
			put("ScoreMap",ScoreMap);
		}
		return forward();
	}
	public String checkIndex(){
	Long stdId = getLong("std.id");
	Long expId = getLong("experiment.id");
	String phase=get("phase");
	String type=get("type");
	
	Experiment experiment=(Experiment)entityService.load(Experiment.class, expId);
	Student std=(Student)entityService.load(Student.class, stdId);
	EntityQuery query=new EntityQuery(getResultTypeName(phase, type),"result");
	query.add(new Condition("result.student.id=:stdId and result.experiment.id=:expId", stdId, expId));
	List<AbstractResult> results=(List)entityService.search(query);	
	AbstractResult result=null;
	if (!results.isEmpty()) {
		result= results.get(0);
	}else{
		result=new AbstractResult();
		result.setStudent(std);
	}
	put("phase",phase);
    put("type",type);
	put("studentId",stdId);
	put("experimentId",expId);
	put("result",result);
	
	/**取assementItem*/	
	query=new EntityQuery(AssessItem.class,"item");
	query.add(new Condition("item.assessment=:assessment and item.phase.engName=:type", experiment.getAssessment(), type));		
	List<AssessItem> items=(List)entityService.search(query);
	AssessItem item=null;
	if(!items.isEmpty()){
		item=items.get(0);
		put("item",item);
	}		
	/**取某分析表的总分*/	
	
	query=new EntityQuery(Analysis.class,"analysis");
	query.add(new Condition("analysis.engName=:engName", type));
	List<Analysis> analysises=(List)entityService.search(query);		
	Analysis analysis=analysises.get(0);
	Float totalmark=(experiment.getMark(analysis).getMark()==null)?0f:experiment.getMark(analysis).getMark();
	put("totalmark",totalmark);

	
	return forward();
	}
//
//	public String checkIndex(){
//		Long stdId = getLong("studentId");
//		Long expId = getLong("experiment.id");
//		String phase=get("phase");
//		String type=get("type");
//		put("planYears",30);
//		
//		Experiment experiment=(Experiment)entityService.load(Experiment.class, expId);
//		Student std=(Student)entityService.load(Student.class, stdId);
//		EntityQuery query=new EntityQuery(getResultTypeName(phase, type),"result");
//		query.add(new Condition("result.student.id=:stdId and result.experiment.id=:expId", stdId, expId));
//		if (type.equals("FamilyAnalysis")){//家庭基本信息分析
//			List<FamilyAnalysisResult> results=(List)entityService.search(query);
//			FamilyAnalysisResult result=new FamilyAnalysisResult();
//			if (!results.isEmpty()) {
//				result= results.get(0);
//			}
//			put("result",result);
//		}
//		else if (type.equals("FundsAnalysis"))
//		{//家庭月度收支分析
//			List<FundsAnalysisResult> results=(List)entityService.search(query);
//			FundsAnalysisResult result=new FundsAnalysisResult();
//			if (!results.isEmpty()) {
//				result= results.get(0);
//			}
//			put("result",result);
//		}
//		else if (type.equals("BalanceOfPayment"))
//		{//家庭资产负债分析
//			List<BalanceOfPaymentResult> results=(List)entityService.search(query);
//			BalanceOfPaymentResult result=new BalanceOfPaymentResult();
//			if (!results.isEmpty()) {
//				result= results.get(0);
//			}
//			put("result",result);
//		}
//		else if (type.equals("InsuranceAnalysis"))
//		{//保险资产明细分析
//			List<InsuranceAnalysisResult> results=(List)entityService.search(query);
//			InsuranceAnalysisResult result=new InsuranceAnalysisResult();
//			if (!results.isEmpty()) {
//				result= results.get(0);
//			}
//			put("result",result);
//		}
//		else if (type.equals("FinanceAssetAnalysis"))
//		{//金融资产明细分析
//			List<FinanceAssetAnalysisResult> results=(List)entityService.search(query);
//			FinanceAssetAnalysisResult result=new FinanceAssetAnalysisResult();
//			if (!results.isEmpty()) {
//				result= results.get(0);
//			}
//			put("result",result);
//		}
//		else if (type.equals("RiskTolerance"))
//		{//客户风险承受能力分析
//			List<RiskToleranceResult> results=(List)entityService.search(query);
//			RiskToleranceResult result=new RiskToleranceResult();
//			if (!results.isEmpty()) {
//				result= results.get(0);
//			}
//			put("result",result);
//		}
//		else if (type.equals("AnalysisSummary"))
//		{//客户分析综述
//			List<AnalysisSummaryResult> results=(List)entityService.search(query);
//			AnalysisSummaryResult result=new AnalysisSummaryResult();
//			if (!results.isEmpty()) {
//				result= results.get(0);
//			}
//			put("result",result);
//			
//
//			/**
//			 * 1)资产负债比率=总负债/总资产 2)流动比率=流动性资产/流动负债 3)储蓄比率=每月的盈余/税后收入 4)流动资产比率=流动资产/总资产
//			 * 4)财务自由度=年理财收入/年支出 5)平均投资报酬率=年理财收入/生息资产 6)自由储蓄率=自由储蓄额/总资产
//			 */
//
//				// 资产负债比率=总负债/总资产
//				FundsAnalysisResult t_result = getResult(FundsAnalysisResult.class, experiment,stdId);
//				Float liabilityRatio = null;
//				if (null != t_result) {
//					if (null != t_result.getForm() && null != t_result.getForm().getTotalLiabilities()
//							&& null != t_result.getForm().getTotalAssets())
//						liabilityRatio = t_result.getForm().getTotalLiabilities()
//								/ t_result.getForm().getTotalAssets();
//				}
//				put("liabilityRatio", liabilityRatio);
//
//				// 流动比率=流动性资产/流动负债
//				// 流动资产比率=流动资产/总资产
//				Float currentRatio = null;
//				Float currentAssetRatio = null;
//				if (null != t_result && null != t_result.getForm()) {
//					Float currentAsset = null;
//					Float currentLiability = null;
//					for (Iterator iter = t_result.getForm().getAssets().iterator(); iter.hasNext();) {
//						FundsAssetResult faa = (FundsAssetResult) iter.next();
//						if (null == faa.getAsset().getAssetProject().getParent()
//								&& faa.getAsset().getAssetProject().getName().equals("流动性资产")) {
//							currentAsset = faa.getAsset().getAmount();
//						}
//					}
//					for (Iterator iter = t_result.getForm().getLiabilities().iterator(); iter.hasNext();) {
//						FundsLiabilityResult faa = (FundsLiabilityResult) iter.next();
//						if (null == faa.getLiability().getLiabilityProject().getParent()
//								&& faa.getLiability().getLiabilityProject().getName().equals("流动性负债")) {
//							currentLiability = faa.getLiability().getAmount();
//						}
//					}
//					if (null != currentAsset && null != currentLiability) {
//						currentRatio = currentAsset / currentLiability;
//					}
//					if (null != currentAsset && null != t_result.getForm().getTotalAssets()) {
//						currentAssetRatio = currentAsset / t_result.getForm().getTotalAssets();
//					}
//				}
//
//				put("currentRatio", currentRatio);
//				put("currentAssetRatio", currentAssetRatio);
//
//				// 储蓄比率=每月的盈余/税后收入
//				BalanceOfPaymentResult t_result2 = getResult(BalanceOfPaymentResult.class, experiment,stdId);
//				Float saveRatio = null;
//				if (null != t_result2 & null != t_result2.getForm()) {
//					if (null != t_result2.getForm().getTotalBalance()
//							&& null != t_result2.getForm().getTotalIncome()) {
//						saveRatio = t_result2.getForm().getTotalBalance()
//								/ t_result2.getForm().getTotalIncome();
//					}
//				}
//				put("saveRatio", saveRatio);
//
//				// 财务自由度=年理财收入/年支出
//				Float financialFreeDegree = null;
//				Float yearIncome = null;
//				if (null != t_result2 & null != t_result2.getForm()
//						&& null != t_result2.getForm().getTotalExpend()) {
//					for (Iterator<IncomeResult> iter = t_result2.getForm().getIncomes().iterator(); iter
//							.hasNext();) {
//						IncomeResult income = iter.next();
//						if (null == income.getIncome().getIncomeProject().getParent()
//								&& income.getIncome().getIncomeProject().getName().equals("理财性收入")) {
//							if (null != income.getIncome().getAmount()) {
//								yearIncome = 12 * income.getIncome().getAmount();
//								financialFreeDegree = income.getIncome().getAmount()
//										/ t_result2.getForm().getTotalExpend();
//							}
//						}
//					}
//				}
//				put("financialFreeDegree", financialFreeDegree);
//
//				// 平均投资报酬率=年理财收入/生息资产
//				Float returnRatio = null;
//				if (null != yearIncome && null != t_result.getForm()) {
//					for (Iterator iter = t_result.getForm().getAssets().iterator(); iter.hasNext();) {
//						FundsAssetResult faa = (FundsAssetResult) iter.next();
//						if (null == faa.getAsset().getAssetProject().getParent()
//								&& faa.getAsset().getAssetProject().getName().equals("投资性资产")) {
//							if (null != faa.getAsset().getAmount()) {
//								returnRatio = yearIncome / faa.getAsset().getAmount();
//							}
//						}
//					}
//				}
//				put("returnRatio", returnRatio);
//				// 自由储蓄率=自由储蓄额/总资产
//				Float saved = 0f;
//				Float savedRatio = null;
//				if (null != t_result.getForm()) {
//					for (Iterator iter = t_result.getForm().getAssets().iterator(); iter.hasNext();) {
//						FundsAssetResult faa = (FundsAssetResult) iter.next();
//						if (null != faa.getAsset().getAssetProject().getParent()
//								&& faa.getAsset().getAssetProject().getName().endsWith("存款")) {
//							if (null != faa.getAsset().getAmount()) {
//								saved += faa.getAsset().getAmount();
//							}
//						}
//					}
//				}
//				if (null != t_result.getForm().getTotalAssets()) {
//					savedRatio = saved / t_result.getForm().getTotalAssets();
//				}
//				put("savedRatio", savedRatio);
//
//			
//			
//			
//			
//			
//		}		
//		else if (type.equals("Aim"))
//		{//客户理财目标分析
//			List<AimResult> results=(List)entityService.search(query);
//			AimResult result=new AimResult();
//			if (!results.isEmpty()) {
//				result= results.get(0);
//			}
//			put("result",result);
//		}			
//		else if (type.equals("CashPlan"))
//		{//工作收入规划
//			List<CashPlanResult> results=(List)entityService.search(query);
//			CashPlanResult result=new CashPlanResult();
//			if (!results.isEmpty()) {
//				result= results.get(0);
//			}
//			put("result",result);
//		}			
//		else if (type.equals("BonusPlan"))
//		{//奖金收入规划
//			List<BonusPlanResult> results=(List)entityService.search(query);
//			BonusPlanResult result=new BonusPlanResult();
//			if (!results.isEmpty()) {
//				result= results.get(0);
//			}
//			put("result",result);
//		}	
//		else if (type.equals("OtherIncomePlan"))
//		{//其它收入规划
//			List<OtherIncomePlanResult> results=(List)entityService.search(query);
//			OtherIncomePlanResult result=new OtherIncomePlanResult();
//			if (!results.isEmpty()) {
//				result= results.get(0);
//			}
//			put("result",result);
//		}		
//		else if (type.equals("ConsumePlan"))
//		{//消费支出规划
//			List<ConsumePlanResult> results=(List)entityService.search(query);
//			ConsumePlanResult result=new ConsumePlanResult();
//			if (!results.isEmpty()) {
//				result= results.get(0);
//			}
//			put("result",result);
//		}		
//		else if (type.equals("EducationPlan"))
//		{//教育支出规划
//			List<EducationPlanResult> results=(List)entityService.search(query);
//			EducationPlanResult result=new EducationPlanResult();
//			if (!results.isEmpty()) {
//				result= results.get(0);
//			}
//			put("result",result);
//		}			
//		else if (type.equals("InsurancePlan"))
//		{//保险支出规划
//			List<InsurancePlanResult> results=(List)entityService.search(query);
//			InsurancePlanResult result=new InsurancePlanResult();
//			if (!results.isEmpty()) {
//				result= results.get(0);
//			}
//			put("result",result);
//			if(result.isSaved()){
//				 query = new EntityQuery(InsurancePlanPolicyResult.class, "pa");		
//				query.add(new Condition("pa.result=:result", result));
//				List<InsurancePlanPolicyResult> policies = entityService.search(query);
//				put("policies",policies);
//				}
//		/**取人员*/		
//				query = new EntityQuery(FamilyMemberResult.class, "memberResult");
//				query.add(new Condition("memberResult.result.experiment.id=:experimentId", expId));
//				query.add(new Condition("memberResult.result.student.id=:stdId", stdId));		
//				query.setSelect("memberResult.member");
//				List<FamilyMember> members = entityService.search(query);
//				put("members",members);
//		/**人员保单*/		
//				Map<String, List<InsurancePlanPolicyResult>> memberpolicies = new HashMap();
//				EntityQuery productquery = new EntityQuery();	
//				for ( int i=0;i<members.size();i++) {
//					FamilyMember member= members.get(i);
//					productquery=new EntityQuery(InsurancePlanPolicyResult.class, "policyresult");
//					productquery.add(new Condition("policyresult.result.experiment.id=:experimentId", expId));
//					productquery.add(new Condition("policyresult.result.student.id=:stdId",  stdId));			
//					productquery.add(new Condition("policyresult.insurant=:insurant", member.getName()));
//					List<InsurancePlanPolicyResult> memberpolicy=entityService.search(productquery);
//					memberpolicies.put(member.getName(),memberpolicy);
//				}		
//				put("memberpolicies",memberpolicies);
//		/**保单保额保费*/		
//				Map<String,Map<String, Map<Integer,Double>>>coverages = new HashMap();		
//				Map<String,Map<String, Map<Integer,Double>>> expenses = new HashMap();
//				for ( int j=0;j<members.size();j++) {
//					FamilyMember member= members.get(j);
//					Map<String, Map<Integer,Double>> membercoverages = new HashMap();		
//					Map<String, Map<Integer,Double>> memberexpenses = new HashMap();	
//					productquery=new EntityQuery(InsurancePlanPolicyResult.class, "policyresult");
//					productquery.add(new Condition("policyresult.result.experiment.id=:experimentId", expId));	
//					productquery.add(new Condition("policyresult.result.student.id=:stdId", stdId));			
//					productquery.add(new Condition("policyresult.insurant=:insurant", member.getName()));
//					List<InsurancePlanPolicyResult> memberpolicy=entityService.search(productquery);
//					
//				for (InsurancePlanPolicyResult policyResult : memberpolicy) {
//					Map<Integer, Double> coverage=new HashMap();
//					Map<Integer, Double> expense=new HashMap();	
//					for(int i=0;i<=getPlanYears();i++)
//					{
//						coverage.put(i, 0d);
//						expense.put(i,0d);
//					}
//					int paytime=calcYears(member.getAge(),policyResult.getPayTime().getDuration());
//					for(int i=policyResult.getApplyOn();i<=paytime+policyResult.getApplyOn();i++)
//					{
//						if (i>30) 
//						{
//						 break; 
//						}
//						expense.put(i,policyResult.getExpense().doubleValue());/**保费*/
//					}
//					int insurancetime=calcYears(member.getAge()+policyResult.getApplyOn(),policyResult.getTime().getDuration());
//					for(int i=policyResult.getApplyOn();i<=insurancetime+policyResult.getApplyOn();i++)
//					{
//						if (i>30) 
//						{
//						 break; 
//						}
//						coverage.put(i,policyResult.getCoverage().doubleValue());/**保额*/
//					}
//					memberexpenses.put(policyResult.getProduct().getName(), expense);
//					membercoverages.put(policyResult.getProduct().getName(), coverage);
//				}
//				expenses.put(member.getName(), memberexpenses);
//				coverages.put(member.getName(), membercoverages);
//				}
//				put("expenses",expenses);
//				put("coverages",coverages);
//				
//		}			
//		else if (type.equals("MedicalPlan"))
//		{//医疗支出规划
//			List<MedicalPlanResult> results=(List)entityService.search(query);
//			MedicalPlanResult result=new MedicalPlanResult();
//			if (!results.isEmpty()) {
//				result= results.get(0);
//			}
//			put("result",result);
//		}			
//		else if (type.equals("TripPlan"))
//		{//旅游支出规划
//			List<TripPlanResult> results=(List)entityService.search(query);
//			TripPlanResult result=new TripPlanResult();
//			if (!results.isEmpty()) {
//				result= results.get(0);
//			}
//			put("result",result);
//		}			
//		else if (type.equals("FinanceAssetPlan"))
//		{//投资支出规划
//			List<FinanceAssetPlanResult> results=(List)entityService.search(query);
//			FinanceAssetPlanResult result=new FinanceAssetPlanResult();
//			if (!results.isEmpty()) {
//				result= results.get(0);
//			}
//			put("result",result);
//			if(result.isSaved()){
//				 query = new EntityQuery(FinancePlanResult.class, "asset");
//				query.add(new Condition("asset.result.experiment.id=:experimentid", expId));
//				query.add(new Condition("asset.result.student.id=:stdId", stdId));
//				List<FinancePlanResult> financeresults = entityService.search(query);
//			double firstbalance = getstdFirstBalance(experiment,stdId);
//
//			Map<String, Map<Integer, Double>> capitals = new HashMap();
//			Map<String, Map<Integer, Double>> expenses = new HashMap();
//			/** 追加 */
//			Map<String, Map<Integer, Double>> incomes = new HashMap();
//			/** 收益 */
//
//			Map<Integer, Double>[] expensearray = new Map[financeresults.size()];
//			Map<Integer, Double>[] capitalarray = new Map[financeresults.size()];
//			Map<Integer, Double>[] incomearray = new Map[financeresults.size()];
//			for (int i = 0; i < financeresults.size(); i++) {
//				expensearray[i] = new HashMap<Integer, Double>();
//				capitalarray[i] = new HashMap<Integer, Double>();
//				incomearray[i] = new HashMap<Integer, Double>();
//			}
//			for (int i = 1; i <= getPlanYears(); i++) {
//				double expense = 0d;
//				double capital = 0d;
//				/** 期初资产 */
//				double income = 0d;
//				if (i == 1) {
//					for (int j = 0; j < financeresults.size(); j++) {
//						expense = 0d;
//						capital = 0d;
//						income = 0d;
//						FinancePlanResult planresult = financeresults.get(j);
//						if (planresult.getStartYear() == 1) {
//							expense = planresult.getAppend().doubleValue() * firstbalance / 100d;
//							capital = planresult.getAmount();
//							income = (capital + expense) * planresult.getRate() / 100d;
//						}
//						expensearray[j].put(i, expense);
//						capitalarray[j].put(i, capital);
//						incomearray[j].put(i, income);
//					}
//				} else {
//					/** 计算上一年收益和支出 */
//					double lastexpense = 0d;
//					double lastincome = 0d;
//					double lastbalance = 0d;
//					for (int p = 0; p < financeresults.size(); p++) {
//						if ((i > financeresults.get(p).getStartYear())
//								&& (i <= financeresults.get(p).getEndYear() + 1)) {
//							lastexpense = expensearray[p].get(i - 1) + lastexpense;
//							lastincome = incomearray[p].get(i - 1) + lastincome;
//						}
//					}
//					lastbalance = getYearCashes(experiment, i - 1,std) + getYearBonuses(experiment, i - 1,std)
//							+ getYearOtherIncomes(experiment, i - 1,std) + lastincome
//							- getYearConsumes(experiment, i - 1,std) - lastexpense
//							- getYearEducations(experiment, i - 1,std) - getYearTrips(experiment, i - 1,std)
//							- getYearMedicals(experiment, i - 1,std) - getYearDeposits(experiment, i - 1,std)
//							- getYearInsurances(experiment, i - 1,std)
//							- getYearOtherExpenses(experiment, i - 1,std);
//
//					for (int j = 0; j < financeresults.size(); j++) {
//						expense = 0d;
//						capital = 0d;
//						income = 0d;
//						FinancePlanResult planresult = financeresults.get(j);
//						if ((planresult.getStartYear() <= i) && (planresult.getEndYear() >= i)) {
//							if (planresult.getStartYear() == i) {
//								expense = planresult.getAppend().doubleValue() * lastbalance / 100d;
//								capital = planresult.getAmount();
//								income = (expense + capital) * planresult.getRate() / 100d;
//							} else {
//								expense = planresult.getAppend().doubleValue() * lastbalance / 100d;
//								capital = expensearray[j].get(i - 1) + incomearray[j].get(i - 1)
//										+ capitalarray[j].get(i - 1);
//								income = (expense + capital) * planresult.getRate() / 100d;
//							}
//						}
//						expensearray[j].put(i, expense);
//						capitalarray[j].put(i, capital);
//						incomearray[j].put(i, income);
//					}
//				}
//			}
//			for (int i = 0; i < financeresults.size(); i++) {
//				capitals.put(financeresults.get(i).getFinancetype().getName(), capitalarray[i]);
//				expenses.put(financeresults.get(i).getFinancetype().getName(), expensearray[i]);
//				incomes.put(financeresults.get(i).getFinancetype().getName(), incomearray[i]);
//			}
//			put("expenses", expenses);
//			put("capitals", capitals);
//			put("incomes", incomes);
//			}
//			
//		}					
//		else if (type.equals("CarPlan"))
//		{//购车支出规划
//			List<CarPlanResult> results=(List)entityService.search(query);
//			CarPlanResult result=new CarPlanResult();
//			if (!results.isEmpty()) {
//				result= results.get(0);
//			}
//			put("result",result);
//		}		
//		else if (type.equals("EstateLoanPlan"))
//		{//房产支出规划
//			List<EstateLoanPlanResult> results=(List)entityService.search(query);
//			EstateLoanPlanResult result=new EstateLoanPlanResult();
//			if (!results.isEmpty()) {
//				result= results.get(0);
//			}
//			put("result",result);
//		}			
//		else if (type.equals("OtherExpensePlan"))
//		{//其他支出规划
//			List<OtherExpensePlanResult> results=(List)entityService.search(query);
//			OtherExpensePlanResult result=new OtherExpensePlanResult();
//			if (!results.isEmpty()) {
//				result= results.get(0);
//			}
//			put("result",result);
//		}		
//		else if (type.equals("PlanSummary"))
//		{//综合理财规划
//			List<PlanSummaryResult> results=(List)entityService.search(query);
//			PlanSummaryResult result=new PlanSummaryResult();
//			if (!results.isEmpty()) {
//				result= results.get(0);
//			}
//			put("result",result);
//			
//			query = new EntityQuery(FamilyMemberResult.class, "memberResult");
//			query.add(new Condition("memberResult.result.experiment.id=:experimentId", expId));
//			addStdCondition(query, "memberResult.result", std);
//			query.setSelect("memberResult.member");
//			List<FamilyMember> members = entityService.search(query);
//
//			/** 工资收入map */
//			query = new EntityQuery(CashPlanResult.class, "cashPlan");
//			query.add(new Condition("cashPlan.experiment.id=:experimentId", expId));
//			addStdCondition(query, "cashPlan", std);
//			List<CashPlanResult> cashresults = entityService.search(query);
//			CashPlanResult cashresult = new CashPlanResult();
//			if (!cashresults.isEmpty()) {
//				cashresult = cashresults.get(0);
//			}
//
//			Map<Integer, Double> cashes = new HashMap();
//			for (int i = 1; i <= getPlanYears(); i++) {
//				double sum = 0;
//				for (MemberCashPlanResult memberResult : cashresult.getMembers()) {
//					if (memberResult.getSalaries() == null || memberResult.getSalaries().get(i) == null) {
//						sum = sum + 0;
//					} else {
//						sum = sum + memberResult.getSalaries().get(i);
//					}
//				}
//				cashes.put(i, sum);
//			}
//			put("cashes", cashes);
//
//			/*** 奖金收入map */
//			query = new EntityQuery(BonusPlanResult.class, "bonusPlan");
//			query.add(new Condition("bonusPlan.experiment.id=:experimentId", expId));
//			addStdCondition(query, "bonusPlan", std);
//			List<BonusPlanResult> bonusresults = entityService.search(query);
//			BonusPlanResult bonusresult = new BonusPlanResult();
//			if (!bonusresults.isEmpty()) {
//				bonusresult = bonusresults.get(0);
//			}
//			Map<Integer, Double> bonuses = new HashMap();
//			for (int i = 1; i <= getPlanYears(); i++) {
//				double sum = 0;
//				for (MemberBonusPlanResult memberResult : bonusresult.getMembers()) {
//					if (memberResult.getBonuses() == null || memberResult.getBonuses().get(i) == null) {
//						sum = sum + 0;
//					} else {
//						sum = sum + memberResult.getBonuses().get(i);
//					}
//				}
//				bonuses.put(i, sum);
//			}
//			put("bonuses", bonuses);
//
//			/** 其他收入 */
//			query = new EntityQuery(OtherIncomePlanResult.class, "incomePlan");
//			query.add(new Condition("incomePlan.experiment.id=:experimentId", expId));
//			addStdCondition(query, "incomePlan", std);
//			List<OtherIncomePlanResult> incomeresults = entityService.search(query);
//			OtherIncomePlanResult incomeresult = new OtherIncomePlanResult();
//			if (!incomeresults.isEmpty()) {
//				incomeresult = incomeresults.get(0);
//			}
//			Map<Integer, Double> incomes = new HashMap();
//			for (int i = 1; i <= getPlanYears(); i++) {
//				if ((incomeresult.getAmounts() == null) || (incomeresult.getAmounts().get(i) == null)) {
//					incomes.put(i, 0d);
//				} else {
//					incomes.put(i, incomeresult.getAmounts().get(i));
//				}
//			}
//			put("incomes", incomes);
//
//			/** 消费支出 */
//			query = new EntityQuery(ConsumePlanResult.class, "consumePlan");
//			query.add(new Condition("consumePlan.experiment.id=:experimentId", expId));
//			addStdCondition(query, "consumePlan", std);
//			List<ConsumePlanResult> consumeresults = entityService.search(query);
//			ConsumePlanResult consumeresult = new ConsumePlanResult();
//			if (!consumeresults.isEmpty()) {
//				consumeresult = consumeresults.get(0);
//			}
//			Map<Integer, Double> consumes = new HashMap();
//			for (int i = 1; i <= getPlanYears(); i++) {
//				if ((consumeresult.getAmounts() == null) || (consumeresult.getAmounts().get(i) == null)) {
//					consumes.put(i, 0d);
//				} else {
//					consumes.put(i, consumeresult.getAmounts().get(i));
//				}
//			}
//			put("consumes", consumes);
//
//			/** 教育支出 */
//			query = new EntityQuery(EducationPlanResult.class, "educationPlan");
//			query.add(new Condition("educationPlan.experiment.id=:experimentId", expId));
//			addStdCondition(query, "educationPlan", std);
//			List<EducationPlanResult> educationresults = entityService.search(query);
//			EducationPlanResult educationresult = new EducationPlanResult();
//			if (!educationresults.isEmpty()) {
//				educationresult = educationresults.get(0);
//			}
//			Map<Integer, Double> educations = new HashMap();
//			for (int i = 1; i <= getPlanYears(); i++) {
//				double sum = 0;
//				for (MemberEducationPlanResult memberResult : educationresult.getMembers()) {
//					if (memberResult.getExpenses() == null || memberResult.getExpenses().get(i) == null) {
//						sum = sum + 0;
//					} else {
//						sum = sum + memberResult.getExpenses().get(i);
//					}
//				}
//				educations.put(i, sum);
//			}
//			put("educations", educations);
//
//			/** 旅游支出 */
//			query = new EntityQuery(TripPlanResult.class, "tripPlan");
//			query.add(new Condition("tripPlan.experiment.id=:experimentId", expId));
//			addStdCondition(query, "tripPlan", std);
//			List<TripPlanResult> tripresults = entityService.search(query);
//			TripPlanResult tripresult = new TripPlanResult();
//			if (!tripresults.isEmpty()) {
//				tripresult = tripresults.get(0);
//				;
//			}
//			Map<Integer, Double> trips = new HashMap();
//			for (int i = 1; i <= getPlanYears(); i++) {
//				if ((tripresult.getExpenses() == null) || (tripresult.getExpenses().get(i) == null)) {
//					trips.put(i, 0d);
//				} else {
//					trips.put(i, tripresult.getExpenses().get(i));
//				}
//			}
//
//			put("trips", trips);
//
//			/** 医疗支出 */
//			query = new EntityQuery(MedicalPlanResult.class, "medicalPlan");
//			query.add(new Condition("medicalPlan.experiment.id=:experimentId", expId));
//			addStdCondition(query, "medicalPlan", std);
//			List<MedicalPlanResult> medicalresults = entityService.search(query);
//			MedicalPlanResult medicalresult = new MedicalPlanResult();
//			if (!medicalresults.isEmpty()) {
//				medicalresult = medicalresults.get(0);
//			}
//			Map<Integer, Double> medicals = new HashMap();
//			for (int i = 1; i <= getPlanYears(); i++) {
//				double sum = 0;
//				for (MemberMedicalPlanResult memberResult : medicalresult.getMembers()) {
//					if (memberResult.getExpenses() == null || memberResult.getExpenses().get(i) == null) {
//						sum = sum + 0;
//					} else {
//						sum = sum + memberResult.getExpenses().get(i);
//					}
//				}
//				medicals.put(i, sum);
//			}
//			put("medicals", medicals);
//
//			/** 还贷支出 */
//			/** 车贷 */
//			query = new EntityQuery(CarPlanResult.class, "result");
//			query.add(new Condition("result.experiment.id=:experimentId", expId));
//			addStdCondition(query, "result", std);
//			List<CarPlanResult> carresults = entityService.search(query);
//			CarPlanResult carresult = new CarPlanResult();
//			if (!carresults.isEmpty()) {
//				carresult = carresults.get(0);
//			}
//
//			/** 房贷 */
//			query = new EntityQuery(EstateLoanPlanResult.class, "result");
//			query.add(new Condition("result.experiment.id=:experimentId", expId));
//			addStdCondition(query, "result", std);
//			List<EstateLoanPlanResult> estateresults = entityService.search(query);
//			EstateLoanPlanResult estateresult = new EstateLoanPlanResult();
//			if (!estateresults.isEmpty()) {
//				estateresult = estateresults.get(0);
//			}
//
//			Map<Integer, Double> deposits = new HashMap();
//			Map<Integer, Double> cardeposits = new HashMap();
//			Map<Integer, Double> housedeposits = new HashMap();
//			for (int i = 1; i <= getPlanYears(); i++) {
//				double sum = 0d;
//				double housesum = 0d;
//				if (carresult.getLoans() == null || carresult.getLoans().get(i) == null
//						|| carresult.getLoans().get(i).getBusiness() == null
//						|| carresult.getLoans().get(i).getBusiness().getTotal() == null) {
//					sum = sum + 0;
//				} else {
//					sum = sum + carresult.getLoans().get(i).getBusiness().getTotal().doubleValue();
//				}
//				if (carresult.getLoans() == null || carresult.getLoans().get(i) == null
//						|| carresult.getLoans().get(i).getCapital() == null) {
//					cardeposits.put(i, 0d);
//				} else {
//					cardeposits.put(i, carresult.getLoans().get(i).getCapital());
//				}
//				if (estateresult.getLoans() == null || estateresult.getLoans().get(i) == null
//						|| estateresult.getLoans().get(i).getAccumulation() == null
//						|| estateresult.getLoans().get(i).getAccumulation().getTotal() == null) {
//					sum = sum + 0;
//				} else {
//					sum = sum
//							+ estateresult.getLoans().get(i).getAccumulation().getTotal().doubleValue();
//				}
//				if (estateresult.getLoans() == null || estateresult.getLoans().get(i) == null
//						|| estateresult.getLoans().get(i).getBusiness() == null
//						|| estateresult.getLoans().get(i).getBusiness().getTotal() == null) {
//					sum = sum + 0;
//				} else {
//					sum = sum + estateresult.getLoans().get(i).getBusiness().getTotal().doubleValue();
//				}
//				if (estateresult.getLoans() == null || estateresult.getLoans().get(i) == null
//						|| estateresult.getLoans().get(i).getAccumulationCapital() == null) {
//					housesum = housesum + 0;
//				} else {
//					housesum = housesum + estateresult.getLoans().get(i).getAccumulationCapital();
//				}
//				if (estateresult.getLoans() == null || estateresult.getLoans().get(i) == null
//						|| estateresult.getLoans().get(i).getBusinessCapital() == null) {
//					housesum = housesum + 0;
//				} else {
//					housesum = housesum + estateresult.getLoans().get(i).getBusinessCapital();
//				}
//				housedeposits.put(i, housesum);
//				deposits.put(i, sum);
//			}
//			put("deposits", deposits);
//			put("housedeposits", housedeposits);
//			put("cardeposits", cardeposits);
//
//			/** 保险支出 */
//			/** 保单保额保费 */
//
//			Map<Integer, Double> insurances = new HashMap();
//			Map<Integer, Double> coverages = new HashMap();
//			for (int i = 1; i <= getPlanYears(); i++) {
//				insurances.put(i, 0d);
//				coverages.put(i, 0d);
//			}
//
//			EntityQuery productquery = new EntityQuery();
//
//			for (int j = 0; j < members.size(); j++) {
//				FamilyMember member = members.get(j);
//
//				productquery = new EntityQuery(InsurancePlanPolicyResult.class, "policyresult");
//				productquery.add(new Condition("policyresult.result.experiment.id=:experimentId",
//						expId));
//				addStdCondition(query, "policyresult.result", std);
//				productquery.add(new Condition("policyresult.insurant=:insurant", member.getName()));
//				List<InsurancePlanPolicyResult> memberpolicy = entityService.search(productquery);
//
//				for (InsurancePlanPolicyResult policyResult : memberpolicy) {
//					int paytime = calcYears(member.getAge(), policyResult.getPayTime().getDuration());
//					for (int i = policyResult.getApplyOn(); i <= paytime + policyResult.getApplyOn(); i++) {
//						if (i > 30) {
//							break;
//						}
//						insurances.put(i, insurances.get(i) + policyResult.getExpense().doubleValue());
//					}
//					int insurancetime = calcYears(member.getAge() + policyResult.getApplyOn(),
//							policyResult.getTime().getDuration());
//					for (int i = policyResult.getApplyOn(); i <= insurancetime
//							+ policyResult.getApplyOn(); i++) {
//						if (i > 30) {
//							break;
//						}
//						coverages.put(i, coverages.get(i) + policyResult.getCoverage().doubleValue());
//						/** 保额 */
//					}
//				}
//			}
//			put("insurances", insurances);
//			put("coverages", coverages);
//
//			/** 其他支出 */
//			query = new EntityQuery(OtherExpensePlanResult.class, "expensePlan");
//			query.add(new Condition("expensePlan.experiment.id=:experimentId", expId));
//			addStdCondition(query, "expensePlan", std);
//			List<OtherExpensePlanResult> expenseresults = entityService.search(query);
//			OtherExpensePlanResult expenseresult = new OtherExpensePlanResult();
//			if (!expenseresults.isEmpty()) {
//				expenseresult = expenseresults.get(0);
//			}
//			Map<Integer, Double> expenses = new HashMap();
//			for (int i = 1; i <= getPlanYears(); i++) {
//				if ((expenseresult.getAmounts() == null) || (expenseresult.getAmounts().get(i) == null)) {
//					expenses.put(i, 0d);
//				} else {
//					expenses.put(i, expenseresult.getAmounts().get(i));
//				}
//			}
//
//			put("expenses", expenses);
//
//			/** 理财收入支出 */
//			FinanceAssetPlanResult planResult = getstdFinanceAssetPlanResult(expId,stdId);
//			query = new EntityQuery(FinancePlanResult.class, "asset");
//			query.add(new Condition("asset.result.experiment.id=:experimentid", expId));
//			addStdCondition(query, "asset.result", std);
//			List<FinancePlanResult> financeresults = entityService.search(query);
//			double firstbalance = getstdFirstBalance(experiment,stdId);
//
//			Map<Integer, Double> totalcapital = new HashMap();
//			Map<Integer, Double> totalexpense = new HashMap();
//			/** 追加 */
//			Map<Integer, Double> totalincome = new HashMap();
//			/** 收益 */
//			Map<Integer, Double> totalbalance = new HashMap();
//			/** 结余 */
//
//			for (int i = 1; i <= getPlanYears(); i++) {
//				totalcapital.put(i, 0d);
//			}
//			for (int i = 1; i <= getPlanYears(); i++) {
//				totalexpense.put(i, 0d);
//			}
//			for (int i = 1; i <= getPlanYears(); i++) {
//				totalincome.put(i, 0d);
//			}
//			Map<String, Double> lastcapital = new HashMap();
//			for (FinancePlanResult planresult : financeresults) {
//				lastcapital.put(planresult.getFinancetype().getName(), planresult.getAmount());
//			}
//			for (int i = 1; i <= getPlanYears(); i++) {
//				double expense = 0d;
//				double income = 0d;
//				double capital = 0d;/* 期初+追加资产 */
//				double balance = 0d;
//
//				if (i == 1) {
//					for (FinancePlanResult planresult : financeresults) {
//						if (planresult.getStartYear() == 1) {
//
//							expense = expense + planresult.getAppend().doubleValue() * firstbalance
//									/ 100d;
//							capital = capital + planresult.getAmount()
//									+ planresult.getAppend().doubleValue() * firstbalance / 100d;
//							income = income
//									+ (planresult.getAmount() + firstbalance
//											* planresult.getAppend().doubleValue() / 100d)
//									* planresult.getRate().doubleValue() / 100d;
//							lastcapital.put(planresult.getFinancetype().getName(),
//									planresult.getAmount() + planresult.getAppend().doubleValue()
//											* firstbalance / 100d);
//						}
//					}
//				} else {
//					for (FinancePlanResult planresult : financeresults) {
//						if ((i <= planresult.getEndYear()) && (i >= planresult.getStartYear())) {
//							double nowcapital = 0d;
//							expense = expense + planresult.getAppend().doubleValue()
//									* totalbalance.get(i - 1) / 100d;
//							if (i == planresult.getStartYear()) {
//								nowcapital = planresult.getAmount()
//										+ planresult.getAppend().byteValue() * totalbalance.get(i - 1)
//										/ 100d;
//							} else {
//								nowcapital = lastcapital.get(planresult.getFinancetype().getName())
//										* (1 + planresult.getRate().doubleValue() / 100d)
//										+ planresult.getAppend().byteValue() * totalbalance.get(i - 1)
//										/ 100d;
//							}
//							capital = capital + nowcapital;
//							lastcapital.put(planresult.getFinancetype().getName(), nowcapital);
//							income = income + (nowcapital) * planresult.getRate().doubleValue() / 100d;
//						}
//					}
//				}
//				balance = cashes.get(i) + bonuses.get(i) + incomes.get(i) + income - consumes.get(i)
//						- expense - educations.get(i) - trips.get(i) - medicals.get(i)
//						- deposits.get(i) - insurances.get(i) - expenses.get(i);
//				totalexpense.put(i, expense);
//				totalincome.put(i, income);
//				totalcapital.put(i, capital + income);
//				/** 期初+追加+收益 */
//				totalbalance.put(i, balance);
//			}
//			put("capitals", totalcapital);
//			put("investexpenses", totalexpense);
//			put("investincomes", totalincome);
//			put("balances", totalbalance);
//
//			/** 房屋资产 **/
//
//			query = new EntityQuery(EstateLoanPlanResult.class, "result");
//			query.add(new Condition("result.experiment.id=:experimentId", expId));
//			query.add(new Condition("result.student.code=:stdCode", getLoginName()));
//			List<EstateLoanPlanResult> estatePlanresults = entityService.search(query);
//			EstateLoanPlanResult estatePlanresult = new EstateLoanPlanResult();
//			if (!estatePlanresults.isEmpty()) {
//				estatePlanresult = (EstateLoanPlanResult) estatePlanresults.get(0);
//			}
//			Map<Integer, Double> estates = new HashMap();
//			for (int i = 1; i <= getPlanYears(); i++) {
//				if ((estatePlanresult.getExpenses() == null)
//						|| (estatePlanresult.getExpenses().get(i) == null)) {
//					estates.put(i, 0d);
//				} else {
//					estates.put(i, estatePlanresult.getExpenses().get(i));
//				}
//			}
//			put("estates", estates);
//
//			// **汽车资产**/
//			query = new EntityQuery(CarPlanResult.class, "result");
//			query.add(new Condition("result.experiment.id=:experimentId", expId));
//			addStdCondition(query, "result", std);
//			List<CarPlanResult> carPlanresults = entityService.search(query);
//			CarPlanResult carPlanresult = new CarPlanResult();
//			if (!carPlanresults.isEmpty()) {
//				carPlanresult = (CarPlanResult) carPlanresults.get(0);
//			}
//			Map<Integer, Double> cars = new HashMap();
//			for (int i = 1; i <= getPlanYears(); i++) {
//				if ((carPlanresult.getExpenses() == null)
//						|| (carPlanresult.getExpenses().get(i) == null)) {
//					cars.put(i, 0d);
//				} else {
//					cars.put(i, carPlanresult.getExpenses().get(i));
//				}
//			}
//			put("cars", cars);
//			
//			
//			
//		}		
//		else if (type.equals("Change"))
//		{//动态平衡调整
//			List<ChangeResult> results=(List)entityService.search(query);
//			ChangeResult result=new ChangeResult();
//			if (!results.isEmpty()) {
//				result= results.get(0);
//			}
//			put("result",result);
//			
//			addBaseCode("incomeProjects", IncomeProject.class);
//			addBaseCode("expendProjects", ExpendProject.class);
//			List<IncomeProject> incomeProjects=entityService.loadAll(IncomeProject.class);
//			List<IncomeProject> expendProjects=entityService.loadAll(ExpendProject.class);		
//			int changeYear=0;
//			if (experiment.getCaze().getChangeYear()!=null)
//			{
//				changeYear=experiment.getCaze().getChangeYear();
//			}
//			put ("changeYear",changeYear);
//
//			double totalincome=0d;
//			double totalexpend=0d;
//			double totalchangeincome=0d;
//			double totalchangeexpend=0d;
//			double totalbalance=0d;
//			double totalchangebalance=0d;
//			Map incomeMap = new HashMap();
//			Map expendMap = new HashMap();
//			BalanceOfPaymentResult balanceresult = getIncomeExpenseResult(experiment,stdId);
//			/**如果动态平衡年度没有填，则显示第0年，否则显示第n年的收支情况*/
//			if(changeYear==0){
//				totalincome=(balanceresult.getForm().getTotalIncome()==null?0:balanceresult.getForm().getTotalIncome());
//			    totalexpend=(balanceresult.getForm().getTotalExpend()==null?0:balanceresult.getForm().getTotalExpend());
//				totalbalance=totalincome-totalexpend;
//			if (null != balanceresult.getForm()) {
//				populateIncomeExpend(balanceresult.getForm(), incomeMap, expendMap);
//			}}
//			else{
//
//				FinanceAssetPlanResult planResult=getstdFinanceAssetPlanResult(expId,stdId);
//				query = new EntityQuery(FinancePlanResult.class, "asset");
//				query.addOrder(Order.parse(get("orderBy")));
//				query.add(new Condition("asset.result.experiment.id=:experimentid", experiment.getId()));
//				addStdCondition(query, "asset.result", std);
//				List<FinancePlanResult> financeresults=entityService.search(query);
//				
//				double firstbalance=getstdFirstBalance(experiment,stdId);
//			
//				Map<String,Map<Integer,Double>> capitals=new HashMap();
//				Map<String,Map<Integer,Double>> expenses=new HashMap();/**追加*/
//				Map<String,Map<Integer,Double>> incomes=new HashMap();/**收益*/
//				
//				 Map<Integer,Double>[] expensearray=new Map[financeresults.size()];
//				 Map<Integer,Double>[] capitalarray=new Map[financeresults.size()];
//				 Map<Integer,Double>[] incomearray=new Map[financeresults.size()];
//					for(int i=0;i<financeresults.size();i++){
//						expensearray[i]=new HashMap<Integer, Double>();
//						capitalarray[i]=new HashMap<Integer, Double>();
//						incomearray[i]=new HashMap<Integer, Double>();	
//					}
//					for(int i=1;i<=getPlanYears();i++)
//					{
//						double expense=0d;
//						double capital=0d;/**期初资产*/
//						double income=0d;
//						if(i==1){
//							for(int j=0;j<financeresults.size();j++)
//							{expense=0d;
//							capital=0d;
//							income=0d;
//								FinancePlanResult planresult=financeresults.get(j);
//								if(planresult.getStartYear()==1)
//								{
//									expense=planresult.getAppend().doubleValue()*firstbalance/100d;
//									capital=planresult.getAmount();
//									income=(capital+expense)*planresult.getRate()/100d;
//								}
//								expensearray[j].put(i, expense);
//								capitalarray[j].put(i,capital);
//								incomearray[j].put(i,income);
//							}
//						}else
//						{/**计算上一年收益和支出*/
//							double lastexpense=0d;
//							double lastincome=0d;
//							double lastbalance=0d;
//							for(int p=0;p<financeresults.size();p++){
//								if((i>financeresults.get(p).getStartYear())&&(i<=financeresults.get(p).getEndYear()+1))
//								{
//									lastexpense=expensearray[p].get(i-1)+lastexpense;
//									lastincome=incomearray[p].get(i-1)+lastincome;
//								}
//							}
//							lastbalance=getYearCashes(experiment,i-1,std)+getYearBonuses(experiment,i-1,std)+getYearOtherIncomes(experiment,i-1,std)+lastincome-getYearConsumes(experiment,i-1,std)
//							-lastexpense-getYearEducations(experiment,i-1,std)-getYearTrips(experiment,i-1,std)-getYearMedicals(experiment,i-1,std)-getYearDeposits(experiment,i-1,std)
//							-getYearInsurances(experiment,i-1,std)-getYearOtherExpenses(experiment,i-1,std);
//							
//							for(int j=0;j<financeresults.size();j++)
//							{expense=0d;
//							capital=0d;
//							income=0d;			
//								FinancePlanResult planresult=financeresults.get(j);
//								if((planresult.getStartYear()<=i)&&(planresult.getEndYear()>=i)){
//								if(planresult.getStartYear()==i)
//								{
//									expense=planresult.getAppend().doubleValue()*lastbalance/100d;
//									capital=planresult.getAmount();
//									income=(expense+capital)*planresult.getRate()/100d;
//								}else
//								{
//									expense=planresult.getAppend().doubleValue()*lastbalance/100d;
//									capital=expensearray[j].get(i-1)+incomearray[j].get(i-1)+capitalarray[j].get(i-1);
//									income=(expense+capital)*planresult.getRate()/100d;							
//								}
//								}
//								expensearray[j].put(i, expense);
//								capitalarray[j].put(i,capital);
//								incomearray[j].put(i,income);
//							}
//						}
//					}
//					for(int i=0;i<financeresults.size();i++){
//						capitals.put(financeresults.get(i).getFinancetype().getName(), capitalarray[i]);
//						expenses.put(financeresults.get(i).getFinancetype().getName(), expensearray[i]);
//						incomes.put(financeresults.get(i).getFinancetype().getName(), incomearray[i]);				
//					}		
//					
//					Map<String,Double> typeincome=new HashMap();/**不同类型金融资产收入*/
//					Map<String,Double> typeexpense=new HashMap();/**不同类型金融资产支出*/
//
//					List<FinanceType> financetypes = getTopFinanceTypes();	
//
//					for(FinanceType financetype : financetypes){
//						double perincome=0d;
//						double perexpense=0d;
//						for(FinancePlanResult planresult:financeresults)
//						{
//							if(planresult.getFinancetype().getParent().getName()==financetype.getName()){
//								perincome=perincome+incomes.get(planresult.getFinancetype().getName()).get(changeYear);
//								perexpense=perexpense+expenses.get(planresult.getFinancetype().getName()).get(changeYear);
//							}
//							typeincome.put(financetype.getName(), perincome);
//							typeexpense.put(financetype.getName(), perexpense);
//						}
//					}
//
//					double t_income=0d;
//					double t_expend=0d;
//					double financeincome=0d;
//					double financeexpend=0d;
//					/**将值放到map中*/
//					for (Iterator iterator = incomeProjects.iterator(); iterator.hasNext();) {
//						IncomeProject holder = (IncomeProject) iterator.next();
//						if(holder.getName().equals("工资收入"))
//						{
//							 t_income=getYearCashes(experiment,changeYear,std);
//							incomeMap.put(holder.getId().toString(),t_income);					
//							totalincome=totalincome+t_income;
//						}else if(holder.getName().equals("奖金收入"))
//						{
//							 t_income=getYearBonuses(experiment,changeYear,std);
//							incomeMap.put(holder.getId().toString(), t_income);					
//							
//						}else if(holder.getName().equals("工资性收入"))
//						{
//							t_income=getYearCashes(experiment,changeYear,std)+getYearBonuses(experiment,changeYear,std);
//							totalincome=totalincome+t_income;
//							incomeMap.put(holder.getId().toString(), t_income);
//						}else if(holder.getName().equals("储蓄收入"))
//						{
//							t_income=(typeincome.get("储蓄存款")==null?0:typeincome.get("储蓄存款"));
//							financeincome=financeincome+t_income;
//							incomeMap.put(holder.getId().toString(), t_income);
//						}else if(holder.getName().equals("债券收入"))
//						{
//							t_income=(typeincome.get("债券产品")==null?0:typeincome.get("债券产品"));
//							financeincome=financeincome+t_income;						
//							incomeMap.put(holder.getId().toString(), t_income);
//						}else if(holder.getName().equals("股票收入"))
//						{
//							t_income=(typeincome.get("股票产品")==null?0:typeincome.get("股票产品"));
//							financeincome=financeincome+t_income;						
//							incomeMap.put(holder.getId().toString(),t_income );
//						}else if(holder.getName().equals("基金收入"))
//						{
//							t_income=(typeincome.get("基金产品")==null?0:typeincome.get("基金产品"));
//							financeincome=financeincome+t_income;						
//							incomeMap.put(holder.getId().toString(), t_income);
//						}else if(holder.getName().equals("银行理财产品收入"))
//						{
//							t_income=(typeincome.get("银行理财产品")==null?0:typeincome.get("银行理财产品"));
//							financeincome=financeincome+t_income;
//							incomeMap.put(holder.getId().toString(),t_income );
//						}else if(holder.getName().equals("信托产品收入"))
//						{
//							t_income=(typeincome.get("信托产品")==null?0:typeincome.get("信托产品"));
//							financeincome=financeincome+t_income;
//							incomeMap.put(holder.getId().toString(), t_income);
//						}else if(holder.getName().equals("金融衍生产品收入"))
//						{
//							t_income=(typeincome.get("金融衍生产品")==null?0:typeincome.get("金融衍生产品"));
//							financeincome=financeincome+t_income;
//							incomeMap.put(holder.getId().toString(), t_income);
//						}else if(holder.getName().equals("其他理财收入"))
//						{
//							t_income=(typeincome.get("其他理财产品")==null?0:typeincome.get("其他理财产品"));
//							financeincome=financeincome+t_income;
//							incomeMap.put(holder.getId().toString(), t_income);
//						}else if(holder.getName().equals("理财性收入"))
//						{	
//							totalincome=totalincome+financeincome;
//							incomeMap.put(holder.getId().toString(), financeincome);
//						}else if(holder.getName().equals("其他收入"))
//						{
//							t_income=getYearOtherIncomes(experiment,changeYear,std);
//							totalincome=totalincome+t_income;
//							incomeMap.put(holder.getId().toString(), t_income);
//						}
//					}
//					for (Iterator iterator = expendProjects.iterator(); iterator.hasNext();) {
//						ExpendProject holder = (ExpendProject) iterator.next();
//						if(holder.getName().equals("消费支出"))
//						{
//							t_expend=getYearConsumes(experiment,changeYear,std);
//							totalexpend=totalexpend+t_expend;
//							 expendMap.put(holder.getId().toString(),t_expend );
//							
//						}
//						else if(holder.getName().equals("教育支出"))
//						{
//							t_expend=getYearEducations(experiment,changeYear,std);
//							totalexpend=totalexpend+t_expend;						
//							 expendMap.put(holder.getId().toString(),t_expend );
//						}
//						else if(holder.getName().equals("医疗支出"))
//						{
//							t_expend=getYearMedicals(experiment,changeYear,std);
//							totalexpend=totalexpend+t_expend;
//							 expendMap.put(holder.getId().toString(), t_expend);
//						}					
//						else if(holder.getName().equals("房屋贷款支出"))
//						{
//							t_expend=getYearHouseDeposits(experiment,changeYear,std);
//							 expendMap.put(holder.getId().toString(),t_expend );
//						}		
//						else if(holder.getName().equals("汽车贷款支出"))
//						{
//							t_expend=getYearCarDeposits(experiment,changeYear,std);
//							 expendMap.put(holder.getId().toString(),t_expend );
//						}
//						else if(holder.getName().equals("贷款支出"))
//						{
//							t_expend=getYearCarDeposits(experiment,changeYear,std)+getYearHouseDeposits(experiment,changeYear,std);
//							totalexpend=totalexpend+t_expend;
//							 expendMap.put(holder.getId().toString(),t_expend );
//						}					
//						else if(holder.getName().equals("保费支出"))
//						{
//							t_expend=getYearInsurances(experiment,changeYear,std);
//							totalexpend=totalexpend+t_expend;
//							 expendMap.put(holder.getId().toString(), t_expend);
//						}else if(holder.getName().equals("储蓄支出"))
//						{
//							t_expend=(typeexpense.get("储蓄存款")==null?0:typeexpense.get("储蓄存款"));
//							financeexpend=financeexpend+t_expend;
//							 expendMap.put(holder.getId().toString(), t_expend);
//						}else if(holder.getName().equals("债券支出"))
//						{
//							t_expend=(typeexpense.get("债券产品")==null?0:typeexpense.get("债券产品"));
//							financeexpend=financeexpend+t_expend;
//							 expendMap.put(holder.getId().toString(), t_expend);
//						}else if(holder.getName().equals("股票支出"))
//						{
//							t_expend=(typeexpense.get("股票产品")==null?0:typeexpense.get("股票产品"));
//							financeexpend=financeexpend+t_expend;
//							 expendMap.put(holder.getId().toString(), t_expend);
//						}else if(holder.getName().equals("基金支出"))
//						{
//							t_expend=(typeexpense.get("基金产品")==null?0:typeexpense.get("基金产品"));
//							financeexpend=financeexpend+t_expend;
//							 expendMap.put(holder.getId().toString(), t_expend);
//						}else if(holder.getName().equals("银行理财产品支出"))
//						{
//							t_expend=(typeexpense.get("银行理财产品")==null?0:typeexpense.get("银行理财产品"));
//							financeexpend=financeexpend+t_expend;
//							 expendMap.put(holder.getId().toString(), t_expend);
//						}else if(holder.getName().equals("信托产品支出"))
//						{
//							t_expend=(typeexpense.get("信托产品")==null?0:typeexpense.get("信托产品"));
//							financeexpend=financeexpend+t_expend;
//							 expendMap.put(holder.getId().toString(), t_expend);
//						}else if(holder.getName().equals("金融衍生产品支出"))
//						{
//							t_expend=(typeexpense.get("金融衍生产品")==null?0:typeexpense.get("金融衍生产品"));
//							financeexpend=financeexpend+t_expend;
//							 expendMap.put(holder.getId().toString(), t_expend);
//						}else if(holder.getName().equals("其他理财支出"))
//						{
//							t_expend=(typeexpense.get("其他理财产品")==null?0:typeexpense.get("其他理财产品"));
//							financeexpend=financeexpend+t_expend;
//							 expendMap.put(holder.getId().toString(), t_expend);
//						}else if(holder.getName().equals("投资支出"))
//						{
//							totalexpend=totalexpend+financeexpend;
//							 expendMap.put(holder.getId().toString(), financeexpend);
//						}											 
//						else if(holder.getName().equals("旅游支出"))
//						{
//							t_expend=getYearTrips(experiment,changeYear,std);
//							totalexpend=totalexpend+t_expend;	
//							 expendMap.put(holder.getId().toString(),t_expend );
//						}	
//						else if(holder.getName().equals("其他支出"))
//						{
//							t_expend=getYearOtherExpenses(experiment,changeYear,std);
//							totalexpend=totalexpend+t_expend;	
//							 expendMap.put(holder.getId().toString(), t_expend);
//						}	
//					}
//						
//				
//			}
//			put("totalincome",totalincome);
//			put("totalexpend",totalexpend);
//			put("totalbalance",totalincome-totalexpend);			
//			put("incomeMap", incomeMap);
//			put("expendMap", expendMap);

//
//			Map changeIncomeMap = new HashMap();
//			Map changeExpendMap = new HashMap();
//			put("changeIncomeMap", changeIncomeMap);
//			put("changeExpendMap", changeExpendMap);
//
//			if (null != result.getForm()) {
//				populateIncomeExpend(result.getForm(), changeIncomeMap, changeExpendMap);
//				totalchangeincome=(result.getForm().getTotalIncome()==null?0:result.getForm().getTotalIncome());
//				totalchangeexpend=(result.getForm().getTotalExpend()==null?0:result.getForm().getTotalExpend());
//				totalchangebalance=totalchangeincome-totalchangeexpend;
////				totalchangebalance=changeResult.getForm().getTotalBalance();
//			}else
//			{
//				//put("changeIncomeMap", incomeMap);
//				//put("changeExpendMap", expendMap);
//				//totalchangeincome=totalincome;
//				//totalchangeexpend=totalexpend;
//				//totalchangebalance=totalincome-totalexpend;			
//			}
//			put("totalchangeincome",totalchangeincome);
//			put("totalchangeexpend",totalchangeexpend);
//			put("totalchangebalance",totalchangebalance);

			
//			
//		}						
//		else if (type.equals("Benefit"))
//		{//单个产品收益率分析
//			List<BenefitResult> results=(List)entityService.search(query);
//			BenefitResult result=new BenefitResult();
//			if (!results.isEmpty()) {
//				result= results.get(0);
//			}
//			put("result",result);
//		}						
//		else if (type.equals("Risk"))
//		{//单个产品风险分析
//			List<RiskResult> results=(List)entityService.search(query);
//			RiskResult result=new RiskResult();
//			if (!results.isEmpty()) {
//				result= results.get(0);
//			}
//			put("result",result);
//		}						
//		else if (type.equals("BalanceCompare"))
//		{//收支结构对比分析
//			List<BalanceCompareResult> results=(List)entityService.search(query);
//			BalanceCompareResult result=new BalanceCompareResult();
//			if (!results.isEmpty()) {
//				result= results.get(0);
//			}
//			put("analysisResult",result);
//			put("result",result);			
//
//			Double nowTotalIncomeAmount = 0d;
//			Double nowTotalExpendAmount = 0d;
//			EntityQuery nowTotalQuery = new EntityQuery(BalanceOfPaymentResult.class,
//					"balanceOfPaymentResult");
//			nowTotalQuery.add(new Condition("balanceOfPaymentResult.experiment.id=" + expId));
//			addStdCondition(nowTotalQuery, "balanceOfPaymentResult", std);
//			nowTotalQuery.add(new Condition("balanceOfPaymentResult.student.code=:stdCode",
//					getLoginName()));
//			List nowTotalAmountList = entityService.search(nowTotalQuery);
//			if (!nowTotalAmountList.isEmpty()) {
//				BalanceOfPaymentResult balanceOfPaymentResult = (BalanceOfPaymentResult) nowTotalAmountList
//						.get(0);
//				if (null != balanceOfPaymentResult && null != balanceOfPaymentResult.getForm()
//						&& null != balanceOfPaymentResult.getForm().getTotalIncome()) {
//					nowTotalIncomeAmount = balanceOfPaymentResult.getForm().getTotalIncome()
//							.doubleValue();
//				}
//				if (null != balanceOfPaymentResult && null != balanceOfPaymentResult.getForm()
//						&& null != balanceOfPaymentResult.getForm().getTotalExpend()) {
//					nowTotalExpendAmount = balanceOfPaymentResult.getForm().getTotalExpend()
//							.doubleValue();
//				}
//			}
//			put("nowTotalIncomeAmount", nowTotalIncomeAmount);
//			put("nowTotalExpendAmount", nowTotalExpendAmount);
//			List notZeroItemsIncome = new ArrayList();
//			List notZeroItemsExpense = new ArrayList();
//
//			EntityQuery nowIncomeQuery = new EntityQuery(IncomeResult.class, "incomeResult");
//			nowIncomeQuery.add(new Condition("incomeResult.result.experiment.id=" + expId));
//			addStdCondition(nowIncomeQuery, "incomeResult.result", std);
//			nowIncomeQuery.groupBy("incomeResult.income.incomeProject");
//			nowIncomeQuery
//					.setSelect("select new com.ekingstar.eams.util.stat.CountItem(sum(incomeResult.income.amount), incomeResult.income.incomeProject) ");
//			nowIncomeQuery.add(new Condition("incomeResult.income.incomeProject.parent is null"));
//			List nowIncomeItems = entityService.search(nowIncomeQuery);
//			DefaultPieDataset nowIncomeDataSet = new DefaultPieDataset();
//			if (!nowIncomeItems.isEmpty()) {
//				for (Iterator iter = nowIncomeItems.iterator(); iter.hasNext();) {
//					CountItem item = (CountItem) iter.next();
//					if(item!=null&&item.getCount()!=null){
//					if (item.getCount().intValue() != 0) {
//						double tempValue = Math.rint(Double.parseDouble(item.getCount().toString())
//								/ nowTotalIncomeAmount * 10000);
//						nowIncomeDataSet.setValue(((IncomeProject) item.getWhat()).getName() + "  ("
//								+ tempValue / 100 + "%)", item.getCount().intValue());
//						notZeroItemsIncome.add(item);
//					}
//					}
//				}
//			}
//			put("nowIncome", new GeneralDatasetProducer("test", nowIncomeDataSet));
//			put("countResultIncome", notZeroItemsIncome);
//
//			EntityQuery nowExpenseQuery = new EntityQuery(ExpendResult.class, "expendResult");
//			nowExpenseQuery.add(new Condition("expendResult.result.experiment.id=" + expId));
//			addStdCondition(nowExpenseQuery, "expendResult.result", std);
//			nowExpenseQuery.groupBy("expendResult.expend.expendProject");
//			nowExpenseQuery
//					.setSelect("select new com.ekingstar.eams.util.stat.CountItem(sum(expendResult.expend.amount), expendResult.expend.expendProject) ");
//			nowExpenseQuery.add(new Condition("expendResult.expend.expendProject.parent is null"));
//			List nowExpenseItems = entityService.search(nowExpenseQuery);
//			DefaultPieDataset nowExpenseDataSet = new DefaultPieDataset();
//			if (!nowExpenseItems.isEmpty()) {
//				for (Iterator iter = nowExpenseItems.iterator(); iter.hasNext();) {
//					CountItem item = (CountItem) iter.next();
//					if(item!=null&&item.getCount()!=null){
//					if (item.getCount().intValue() != 0) {
//						double tempValue = Math.rint(Double.parseDouble(item.getCount().toString())
//								/ nowTotalExpendAmount * 10000);
//						nowExpenseDataSet.setValue(((ExpendProject) item.getWhat()).getName() + "  ("
//								+ tempValue / 100 + "%)", item.getCount().intValue());
//						notZeroItemsExpense.add(item);
//					}
//					}
//				}
//			}
//			put("nowExpense", new GeneralDatasetProducer("test", nowExpenseDataSet));
//			put("countResultExpense", notZeroItemsExpense);
//
//			/*
//			 * String year = (get("year")==null)?"1":get("year"); int
//			 * intyear=Integer.valueOf(year);
//			 */
//			int intyear = 1;
//			if (get("faceyear") == null) {
//				intyear = 1;
//				if (result.getYear() != null) {
//					intyear = Integer.valueOf(result.getYear());
//				}
//			} else {
//				intyear = Integer.valueOf(get("faceyear"));
//			}
//			put("defaultYear", String.valueOf(intyear));
//			/*
//			 * List notZeroItems = new ArrayList(); if (year != null &&
//			 * "".equals(year)) {
//			 * 
//			 * DefaultPieDataset dataset = new DefaultPieDataset(); CountItem item =
//			 * new CountItem(1,""); if (item.getCount().intValue() != 0) {
//			 * dataset.setValue(((Department) item.getWhat()).getName(),
//			 * item.getCount() .intValue()); notZeroItems.add(item); } put("year",
//			 * year); put("incomeExpense", new GeneralDatasetProducer("test",
//			 * dataset)); } put("countResult", notZeroItems);
//			 */
//
//			/** 理财后 */
//			FinanceAssetPlanResult planResult = getstdFinanceAssetPlanResult(expId,stdId);
//			query = new EntityQuery(FinancePlanResult.class, "asset");
//			query.addOrder(Order.parse(get("orderBy")));
//			query.add(new Condition("asset.result.experiment.id=:experimentid", experiment.getId()));
//			addStdCondition(query, "asset.result", std);
//			query.setLimit(getPageLimit());// 加分页，否则删除会有误
//			List<FinancePlanResult> financeresults = entityService.search(query);
//
//			double firstbalance = getstdFirstBalance(experiment,stdId);
//
//			Map<String, Map<Integer, Double>> capitals = new HashMap();
//			Map<String, Map<Integer, Double>> expenses = new HashMap();
//			/** 追加 */
//			Map<String, Map<Integer, Double>> incomes = new HashMap();
//			/** 收益 */
//
//			Map<Integer, Double>[] expensearray = new Map[financeresults.size()];
//			Map<Integer, Double>[] capitalarray = new Map[financeresults.size()];
//			Map<Integer, Double>[] incomearray = new Map[financeresults.size()];
//			for (int i = 0; i < financeresults.size(); i++) {
//				expensearray[i] = new HashMap<Integer, Double>();
//				capitalarray[i] = new HashMap<Integer, Double>();
//				incomearray[i] = new HashMap<Integer, Double>();
//			}
//			for (int i = 1; i <= getPlanYears(); i++) {
//				double expense = 0d;
//				double capital = 0d;
//				/** 期初资产 */
//				double income = 0d;
//				if (i == 1) {
//					for (int j = 0; j < financeresults.size(); j++) {
//						expense = 0d;
//						capital = 0d;
//						income = 0d;
//						FinancePlanResult planresult = financeresults.get(j);
//						if (planresult.getStartYear() == 1) {
//							expense = planresult.getAppend().doubleValue() * firstbalance / 100d;
//							capital = planresult.getAmount();
//							income = (capital + expense) * planresult.getRate() / 100d;
//						}
//						expensearray[j].put(i, expense);
//						capitalarray[j].put(i, capital);
//						incomearray[j].put(i, income);
//					}
//				} else {
//					/** 计算上一年收益和支出 */
//					double lastexpense = 0d;
//					double lastincome = 0d;
//					double lastbalance = 0d;
//					for (int p = 0; p < financeresults.size(); p++) {
//						if ((i > financeresults.get(p).getStartYear())
//								&& (i <= financeresults.get(p).getEndYear() + 1)) {
//							lastexpense = expensearray[p].get(i - 1) + lastexpense;
//							lastincome = incomearray[p].get(i - 1) + lastincome;
//						}
//					}
//					lastbalance = getYearCashes(experiment, i - 1,std) + getYearBonuses(experiment, i - 1,std)
//							+ getYearOtherIncomes(experiment, i - 1,std) + lastincome
//							- getYearConsumes(experiment, i - 1,std) - lastexpense
//							- getYearEducations(experiment, i - 1,std) - getYearTrips(experiment, i - 1,std)
//							- getYearMedicals(experiment, i - 1,std) - getYearDeposits(experiment, i - 1,std)
//							- getYearInsurances(experiment, i - 1,std)
//							- getYearOtherExpenses(experiment, i - 1,std);
//
//					for (int j = 0; j < financeresults.size(); j++) {
//						expense = 0d;
//						capital = 0d;
//						income = 0d;
//						FinancePlanResult planresult = financeresults.get(j);
//						if ((planresult.getStartYear() <= i) && (planresult.getEndYear() >= i)) {
//							if (planresult.getStartYear() == i) {
//								expense = planresult.getAppend().doubleValue() * lastbalance / 100d;
//								capital = planresult.getAmount();
//								income = (expense + capital) * planresult.getRate() / 100d;
//							} else {
//								expense = planresult.getAppend().doubleValue() * lastbalance / 100d;
//								capital = expensearray[j].get(i - 1) + incomearray[j].get(i - 1)
//										+ capitalarray[j].get(i - 1);
//								income = (expense + capital) * planresult.getRate() / 100d;
//							}
//						}
//						expensearray[j].put(i, expense);
//						capitalarray[j].put(i, capital);
//						incomearray[j].put(i, income);
//					}
//				}
//			}
//			for (int i = 0; i < financeresults.size(); i++) {
//				capitals.put(financeresults.get(i).getFinancetype().getName(), capitalarray[i]);
//				expenses.put(financeresults.get(i).getFinancetype().getName(), expensearray[i]);
//				incomes.put(financeresults.get(i).getFinancetype().getName(), incomearray[i]);
//			}
//			/** 第n年金融收入、支出、资本 */
//			Map<Integer, Double> yearincomes = new HashMap();
//			Map<Integer, Double> yearexpenses = new HashMap();
//			Map<Integer, Double> yearcapitals = new HashMap();
//			for (int i = 1; i <= getPlanYears(); i++) {
//				double tempincome = 0d;
//				double tempexpense = 0d;
//				double tempcapital = 0d;
//				for (int j = 0; j < financeresults.size(); j++) {
//					FinancePlanResult plan = financeresults.get(j);
//					tempincome = incomes.get(plan.getFinancetype().getName()).get(i) + tempincome;
//					tempexpense = expenses.get(plan.getFinancetype().getName()).get(i) + tempexpense;
//					tempcapital = capitals.get(plan.getFinancetype().getName()).get(i) + tempcapital;
//				}
//				yearincomes.put(i, tempincome);
//				yearexpenses.put(i, tempexpense);
//				yearcapitals.put(i, tempcapital);
//			}
//
//			/* 收入 */
//			double laterTotalIncomeAmount = 0d;
//			laterTotalIncomeAmount = getYearCashes(experiment, intyear,std)
//					+ getYearBonuses(experiment, intyear,std) + yearincomes.get(intyear)
//					+ getYearOtherIncomes(experiment, intyear,std);
//			DefaultPieDataset laterIncomeDataSet = new DefaultPieDataset();
//			List<IncomeProject> laterIncomeProjects = getTopIncomeProjects();
//
//			if (!laterIncomeProjects.isEmpty()) {
//				Collections.sort(laterIncomeProjects);
//				for (Iterator iter = laterIncomeProjects.iterator(); iter.hasNext();) {
//					IncomeProject project = (IncomeProject) iter.next();
//					double pertempValue = 0d;
//					double tempValue = 0d;
//					if (project.getName().equals("工资性收入")) {
//						tempValue = getYearCashes(experiment, intyear,std)
//								+ getYearBonuses(experiment, intyear,std);
//						pertempValue = Math.rint((getYearCashes(experiment, intyear,std) + getYearBonuses(
//								experiment, intyear,std)) / laterTotalIncomeAmount * 10000);
//					} else if (project.getName().equals("理财性收入")) {
//						tempValue = yearincomes.get(intyear);
//						pertempValue = Math.rint((yearincomes.get(intyear)) / laterTotalIncomeAmount
//								* 10000);
//
//					} else if (project.getName().equals("其他收入")) {
//						tempValue = getYearOtherIncomes(experiment, intyear,std);
//						pertempValue = Math.rint((getYearOtherIncomes(experiment, intyear,std))
//								/ laterTotalIncomeAmount * 10000);
//					}
//
//					laterIncomeDataSet.setValue(project.getName() + "  (" + pertempValue / 100 + "%)",
//							tempValue);
//
//				}
//			}
//			put("laterIncome", new GeneralDatasetProducer("test", laterIncomeDataSet));
//			put("laterTotalIncomeAmount", laterTotalIncomeAmount);
//
//			/** 支出 */
//			double laterTotalExpenseAmount = 0d;
//			laterTotalExpenseAmount = getYearConsumes(experiment, intyear,std)
//					+ getYearEducations(experiment, intyear,std) + getYearMedicals(experiment, intyear,std)
//					+ getYearHouseDeposits(experiment, intyear,std)
//					+ getYearCarDeposits(experiment, intyear,std) + yearexpenses.get(intyear)
//					+ getYearInsurances(experiment, intyear,std) + getYearTrips(experiment, intyear,std)
//					+ getYearOtherExpenses(experiment, intyear,std);
//			DefaultPieDataset laterExpendDataSet = new DefaultPieDataset();
//			List<ExpendProject> laterExpenseProjects = getTopExpendProjects();
//			if (!laterExpenseProjects.isEmpty()) {
//				Collections.sort(laterExpenseProjects);
//				for (Iterator iter = laterExpenseProjects.iterator(); iter.hasNext();) {
//					ExpendProject project = (ExpendProject) iter.next();
//					double pertempValue = 0d;
//					double tempValue = 0d;
//					if (project.getName().equals("日常消费支出")) {
//						tempValue = getYearConsumes(experiment, intyear,std);
//						pertempValue = Math.rint((getYearConsumes(experiment, intyear,std))
//								/ laterTotalExpenseAmount * 10000);
//
//					} else if (project.getName().equals("教育支出")) {
//						tempValue = getYearEducations(experiment, intyear,std);
//						pertempValue = Math.rint((getYearEducations(experiment, intyear,std))
//								/ laterTotalExpenseAmount * 10000);
//					} else if (project.getName().equals("医疗支出")) {
//						tempValue = getYearMedicals(experiment, intyear,std);
//						pertempValue = Math.rint((getYearMedicals(experiment, intyear,std))
//								/ laterTotalExpenseAmount * 10000);
//
//					} else if (project.getName().equals("贷款支出")) {
//						tempValue = getYearHouseDeposits(experiment, intyear,std)
//								+ getYearCarDeposits(experiment, intyear,std);
//						pertempValue = Math
//								.rint((getYearHouseDeposits(experiment, intyear,std) + getYearCarDeposits(
//										experiment, intyear,std)) / laterTotalExpenseAmount * 10000);
//
//					} else if (project.getName().equals("投资支出")) {
//						tempValue = yearexpenses.get(intyear);
//						pertempValue = Math.rint((yearexpenses.get(intyear)) / laterTotalExpenseAmount
//								* 10000);
//					} else if (project.getName().equals("保费支出")) {
//						tempValue = getYearInsurances(experiment, intyear,std);
//						pertempValue = Math.rint((getYearInsurances(experiment, intyear,std))
//								/ laterTotalExpenseAmount * 10000);
//					} else if (project.getName().equals("旅游支出")) {
//						tempValue = getYearTrips(experiment, intyear,std);
//						pertempValue = Math.rint((getYearTrips(experiment, intyear,std))
//								/ laterTotalExpenseAmount * 10000);
//					} else if (project.getName().equals("其他支出")) {
//						tempValue = getYearOtherExpenses(experiment, intyear,std);
//						pertempValue = Math.rint((getYearOtherExpenses(experiment, intyear,std))
//								/ laterTotalExpenseAmount * 10000);
//					}
//
//					laterExpendDataSet.setValue(project.getName() + "  (" + pertempValue / 100 + "%)",
//							tempValue);
//
//				}
//			}
//			put("laterExpense", new GeneralDatasetProducer("test", laterExpendDataSet));
//			put("laterTotalExpendAmount", laterTotalExpenseAmount);
//			
//			
//			
//			
//		}
//		else if (type.equals("FinanceCompare"))
//		{//金融资产结构对比分析
//			List<FinanceCompareResult> results=(List)entityService.search(query);
//			FinanceCompareResult result=new FinanceCompareResult();
//			if (!results.isEmpty()) {
//				result= results.get(0);
//			}
//			put("result",result);
//			
//			put("analysisResult",result);
//			
//			Double nowTotalAmount = 0d;
//			EntityQuery nowTotalQuery = new EntityQuery(FinanceAssetResult.class, "financeAssetResult");
//			nowTotalQuery.add(new Condition("financeAssetResult.result.experiment.id=" + expId));
//			addStdCondition(nowTotalQuery, "financeAssetResult.result", std);
//			nowTotalQuery.setSelect("select sum(financeAssetResult.asset.amount)");
//			List nowTotalAmountList = entityService.search(nowTotalQuery);
//			if (!nowTotalAmountList.isEmpty()) {
//				nowTotalAmount = (Double)nowTotalAmountList.get(0);
//			}
//			put("nowTotalAmount", nowTotalAmount);
//			// 按资产类型
//			List notZeroItemsFinanceType = new ArrayList();
//			EntityQuery nowFinanceTypeQuery = new EntityQuery(FinanceAssetResult.class, "financeAssetResult");
//			nowFinanceTypeQuery.add(new Condition("financeAssetResult.result.experiment.id=" + expId));
//			addStdCondition(nowFinanceTypeQuery, "financeAssetResult.result", std);
//			nowFinanceTypeQuery.groupBy("financeAssetResult.asset.financetype.parent");
//			nowFinanceTypeQuery.setSelect("select new com.ekingstar.eams.util.stat.CountItem(sum(financeAssetResult.asset.amount), financeAssetResult.asset.financetype.parent) ");
//			//nowFinanceTypeQuery.add(new Condition("financeAssetResult.asset.financetype.parent is null"));
//			List nowFinanceTypeItems = entityService.search(nowFinanceTypeQuery);
//			DefaultPieDataset nowFinanceTypeDataSet = new DefaultPieDataset();
//			if (!nowFinanceTypeItems.isEmpty()) {
//				Collections.sort(nowFinanceTypeItems);
//		        for (Iterator iter = nowFinanceTypeItems.iterator(); iter.hasNext();) {
//		            CountItem item = (CountItem) iter.next();
//		            if (item.getCount().intValue() != 0) {
//		            	double tempValue = Math.rint(Double.parseDouble(item.getCount().toString())/nowTotalAmount*10000);
//		            	nowFinanceTypeDataSet.setValue(((FinanceType) item.getWhat()).getName() + "  ("+ tempValue/100 +"%)", item.getCount()
//		                        .intValue());
//		            	notZeroItemsFinanceType.add(item);
//		            }
//		        }
//			}
//			put("nowFinanceType", new GeneralDatasetProducer("test", nowFinanceTypeDataSet));
//			put("countResultFinanceType", notZeroItemsFinanceType);
//			
//					
//			
//			// 按风险等级
//			List notZeroItemsRiskGrade = new ArrayList();
//			EntityQuery nowRiskGradeQuery = new EntityQuery(FinanceAssetResult.class, "financeAssetResult");
//			nowRiskGradeQuery.add(new Condition("financeAssetResult.result.experiment.id=" + expId));
//			addStdCondition(nowRiskGradeQuery, "financeAssetResult.result", std);		
//			nowRiskGradeQuery.groupBy("financeAssetResult.asset.riskgrade");
//			nowRiskGradeQuery.setSelect("select new com.ekingstar.eams.util.stat.CountItem(sum(financeAssetResult.asset.amount), financeAssetResult.asset.riskgrade) ");
//			List nowRiskGradeItems = entityService.search(nowRiskGradeQuery);
//			DefaultPieDataset nowRiskGradeDataSet = new DefaultPieDataset();
//			if (!nowRiskGradeItems.isEmpty()) {
//				Collections.sort(nowRiskGradeItems);
//		        for (Iterator iter = nowRiskGradeItems.iterator(); iter.hasNext();) {
//		            CountItem item = (CountItem) iter.next();
//		            if (item.getCount().intValue() != 0) {
//		            	double tempValue = Math.rint(Double.parseDouble(item.getCount().toString())/nowTotalAmount*10000);
//		            	nowRiskGradeDataSet.setValue(((RiskGrade) item.getWhat()).getName() + "  ("+ tempValue/100 +"%)", item.getCount()
//		                        .intValue());
//		            	notZeroItemsRiskGrade.add(item);
//		            	
//		            }
//		        }
//			}
//			PiePlot pie;
//			
//			put("nowRiskGrade", new GeneralDatasetProducer("test", nowRiskGradeDataSet));
//			put("countResultRiskGrade", notZeroItemsRiskGrade);
//			
//			// 按流动性
//			List notZeroItemsMobility = new ArrayList();
//			EntityQuery nowMobilityQuery = new EntityQuery(FinanceAssetResult.class, "financeAssetResult");
//			nowMobilityQuery.add(new Condition("financeAssetResult.result.experiment.id=" + expId));
//			addStdCondition(nowMobilityQuery, "financeAssetResult.result", std);
//			nowMobilityQuery.groupBy("financeAssetResult.asset.mobility");
//			nowMobilityQuery.setSelect("select new com.ekingstar.eams.util.stat.CountItem(sum(financeAssetResult.asset.amount), financeAssetResult.asset.mobility) ");
//			List nowMobilityItems = entityService.search(nowMobilityQuery);
//			DefaultPieDataset nowMobilityDataSet = new DefaultPieDataset();
//			if (!nowMobilityItems.isEmpty()) {
//				Collections.sort(nowMobilityItems);
//		        for (Iterator iter = nowMobilityItems.iterator(); iter.hasNext();) {
//		            CountItem item = (CountItem) iter.next();
//		            if (item.getCount().intValue() != 0) {
//		            	double tempValue = Math.rint(Double.parseDouble(item.getCount().toString())/nowTotalAmount*10000);
//		            	nowMobilityDataSet.setValue(((Mobility) item.getWhat()).getName() + "  ("+ tempValue/100 +"%)", item.getCount()
//		                        .intValue());
//		            	notZeroItemsMobility.add(item);
//		            	
//		            }
//		        }
//			}
//			put("nowMobility", new GeneralDatasetProducer("test", nowMobilityDataSet));
//			put("countResultMobility", notZeroItemsMobility);
//			
//			// 按收益性分析对比
//			EntityQuery nowRate20Query = new EntityQuery(FinanceAssetResult.class, "financeAssetResult");
//			nowRate20Query.add(new Condition("financeAssetResult.result.experiment.id=" + expId));
//			addStdCondition(nowRate20Query, "financeAssetResult.result", std);
//			nowRate20Query.add(new Condition("financeAssetResult.asset.rate>20"));
//			List nowRate20Items = entityService.search(nowRate20Query);
//			DefaultPieDataset nowRateDataSet = new DefaultPieDataset();
//			if (!nowRate20Items.isEmpty()) {
//				Double count = 0d;
//		        for (Iterator iter = nowRate20Items.iterator(); iter.hasNext();) {
//		        	FinanceAssetResult item = (FinanceAssetResult) iter.next();
//		        	count += item.getAsset().getAmount();
//		        }
//		        if (count != 0) {
//		        	double tempValue = Math.rint(count/nowTotalAmount*10000);
//		        	nowRateDataSet.setValue("大于百分之二十" + "  ("+ tempValue/100 +"%)", count
//		        			.intValue());
//		        	
//		        }
//			}
//			
//			// 按收益性分析对比
//			EntityQuery nowRate10Query = new EntityQuery(FinanceAssetResult.class, "financeAssetResult");
//			nowRate10Query.add(new Condition("financeAssetResult.result.experiment.id=" + expId));
//			addStdCondition(nowRate10Query, "financeAssetResult.result", std);
//			nowRate10Query.add(new Condition("financeAssetResult.asset.rate>10 and financeAssetResult.asset.rate<=20"));
//			List nowRate10Items = entityService.search(nowRate10Query);
//			if (!nowRate10Items.isEmpty()) {
//				Double count = 0d;
//		        for (Iterator iter = nowRate10Items.iterator(); iter.hasNext();) {
//		        	FinanceAssetResult item = (FinanceAssetResult) iter.next();
//		        	count += item.getAsset().getAmount();
//		        }
//		        if (count != 0) {
//		        	double tempValue = Math.rint(count/nowTotalAmount*10000);
//		        	nowRateDataSet.setValue("介于百分之十与百分之二十之间" + "  ("+ tempValue/100 +"%)", count
//		        			.intValue());
//		        	
//		        }
//			}
//			
//			// 按收益性分析对比
//			EntityQuery nowRate5Query = new EntityQuery(FinanceAssetResult.class, "financeAssetResult");
//			nowRate5Query.add(new Condition("financeAssetResult.result.experiment.id=" + expId));
//			addStdCondition(nowRate5Query, "financeAssetResult.result", std);
//			nowRate5Query.add(new Condition("financeAssetResult.asset.rate>5 and financeAssetResult.asset.rate<=10"));
//			List nowRate5Items = entityService.search(nowRate5Query);
//			if (!nowRate5Items.isEmpty()) {
//				Double count = 0d;
//		        for (Iterator iter = nowRate5Items.iterator(); iter.hasNext();) {
//		        	FinanceAssetResult item = (FinanceAssetResult) iter.next();
//		        	count += item.getAsset().getAmount();
//		        }
//		        if (count != 0) {
//		        	double tempValue = Math.rint(count/nowTotalAmount*10000);
//		        	nowRateDataSet.setValue("介于百分之五与百分之十之间" + "  ("+ tempValue/100 +"%)", count
//		        			.intValue());
//		        	
//		        }
//			}
//			
//			// 按收益性分析对比
//			EntityQuery nowRate0Query = new EntityQuery(FinanceAssetResult.class, "financeAssetResult");
//			nowRate0Query.add(new Condition("financeAssetResult.result.experiment.id=" + expId));
//			addStdCondition(nowRate0Query, "financeAssetResult.result", std);
//			nowRate0Query.add(new Condition("financeAssetResult.asset.rate<=5"));
//			List nowRate0Items = entityService.search(nowRate0Query);
//			if (!nowRate0Items.isEmpty()) {
//				Double count = 0d;
//		        for (Iterator iter = nowRate0Items.iterator(); iter.hasNext();) {
//		        	FinanceAssetResult item = (FinanceAssetResult) iter.next();
//		        	count += item.getAsset().getAmount();
//		        }
//		        if (count != 0) {
//		        	double tempValue = Math.rint(count/nowTotalAmount*10000);
//		        	nowRateDataSet.setValue("介于百分之零与百分之五之间" + "  ("+ tempValue/100 +"%)", count
//		        			.intValue());
//		        	
//		        }
//			}
//			
//			put("nowRate", new GeneralDatasetProducer("test", nowRateDataSet));
//			
//			/*String year = (get("year")==null)?"1":get("year");
//			int intyear=Integer.parseInt(year);
//			put("defaultYear",year);*/
//			int intyear=1;
//			if(get("faceyear")==null){
//			 intyear=1;
//			if (result.getYear()!=null)
//			{
//			 intyear=Integer.valueOf(result.getYear());
//			}}
//			else
//			{
//				 intyear=Integer.valueOf(get("faceyear"));
//			}
//			put("defaultYear",String.valueOf(intyear));
//			
//			FinanceAssetPlanResult planResult=getstdFinanceAssetPlanResult(expId,stdId);
//			 query = new EntityQuery(FinancePlanResult.class, "asset");
//			query.addOrder(Order.parse(get("orderBy")));
//			query.add(new Condition("asset.result.experiment.id=:experimentid", experiment.getId()));
//			addStdCondition(query, "asset.result", std);
//			query.setLimit(getPageLimit());// 加分页，否则删除会有误
//			List<FinancePlanResult> financeresults=entityService.search(query);
//			
//			double firstbalance=getstdFirstBalance(experiment,stdId);
//		
//			Map<String,Map<Integer,Double>> capitals=new HashMap();
//			Map<String,Map<Integer,Double>> expenses=new HashMap();/**追加*/
//			Map<String,Map<Integer,Double>> incomes=new HashMap();/**收益*/
//			
//			 Map<Integer,Double>[] expensearray=new Map[financeresults.size()];
//			 Map<Integer,Double>[] capitalarray=new Map[financeresults.size()];
//			 Map<Integer,Double>[] incomearray=new Map[financeresults.size()];
//				for(int i=0;i<financeresults.size();i++){
//					expensearray[i]=new HashMap<Integer, Double>();
//					capitalarray[i]=new HashMap<Integer, Double>();
//					incomearray[i]=new HashMap<Integer, Double>();	
//				}
//				for(int i=1;i<=getPlanYears();i++)
//				{
//					double expense=0d;
//					double capital=0d;/**期初资产*/
//					double income=0d;
//					if(i==1){
//						for(int j=0;j<financeresults.size();j++)
//						{expense=0d;
//						capital=0d;
//						income=0d;
//							FinancePlanResult planresult=financeresults.get(j);
//							if(planresult.getStartYear()==1)
//							{
//								expense=planresult.getAppend().doubleValue()*firstbalance/100d;
//								capital=planresult.getAmount();
//								income=(capital+expense)*planresult.getRate()/100d;
//							}
//							expensearray[j].put(i, expense);
//							capitalarray[j].put(i,capital);
//							incomearray[j].put(i,income);
//						}
//					}else
//					{/**计算上一年收益和支出*/
//						double lastexpense=0d;
//						double lastincome=0d;
//						double lastbalance=0d;
//						for(int p=0;p<financeresults.size();p++){
//							if((i>financeresults.get(p).getStartYear())&&(i<=financeresults.get(p).getEndYear()+1))
//							{
//								lastexpense=expensearray[p].get(i-1)+lastexpense;
//								lastincome=incomearray[p].get(i-1)+lastincome;
//							}
//						}
//						lastbalance=getYearCashes(experiment,i-1,std)+getYearBonuses(experiment,i-1,std)+getYearOtherIncomes(experiment,i-1,std)+lastincome-getYearConsumes(experiment,i-1,std)
//						-lastexpense-getYearEducations(experiment,i-1,std)-getYearTrips(experiment,i-1,std)-getYearMedicals(experiment,i-1,std)-getYearDeposits(experiment,i-1,std)
//						-getYearInsurances(experiment,i-1,std)-getYearOtherExpenses(experiment,i-1,std);
//						
//						for(int j=0;j<financeresults.size();j++)
//						{expense=0d;
//						capital=0d;
//						income=0d;			
//							FinancePlanResult planresult=financeresults.get(j);
//							if((planresult.getStartYear()<=i)&&(planresult.getEndYear()>=i)){
//							if(planresult.getStartYear()==i)
//							{
//								expense=planresult.getAppend().doubleValue()*lastbalance/100d;
//								capital=planresult.getAmount();
//								income=(expense+capital)*planresult.getRate()/100d;
//							}else
//							{
//								expense=planresult.getAppend().doubleValue()*lastbalance/100d;
//								capital=expensearray[j].get(i-1)+incomearray[j].get(i-1)+capitalarray[j].get(i-1);
//								income=(expense+capital)*planresult.getRate()/100d;							
//							}
//							}
//							expensearray[j].put(i, expense);
//							capitalarray[j].put(i,capital);
//							incomearray[j].put(i,income);
//						}
//					}
//				}
//				for(int i=0;i<financeresults.size();i++){
//					capitals.put(financeresults.get(i).getFinancetype().getName(), capitalarray[i]);
//					expenses.put(financeresults.get(i).getFinancetype().getName(), expensearray[i]);
//					incomes.put(financeresults.get(i).getFinancetype().getName(), incomearray[i]);				
//				}	
//				/**第n年金融收入、支出、资本*/
//				Map<Integer,Double> yearincomes=new HashMap();
//				Map<Integer,Double> yearexpenses=new HashMap();	
//				Map<Integer,Double> yearcapitals=new HashMap();
//				for(int i=1;i<=getPlanYears();i++){
//					double tempincome=0d;
//					double tempexpense=0d;
//					double tempcapital=0d;
//					for(int j=0;j<financeresults.size();j++)
//					{
//						FinancePlanResult plan=financeresults.get(j);
//						tempincome=incomes.get(plan.getFinancetype().getName()).get(i)+tempincome;
//						tempexpense=expenses.get(plan.getFinancetype().getName()).get(i)+tempexpense;
//						tempcapital=capitals.get(plan.getFinancetype().getName()).get(i)+tempcapital;
//					}
//					yearincomes.put(i, tempincome);
//					yearexpenses.put(i,tempexpense);
//					yearcapitals.put(i, tempcapital);
//				}		
//			
//				double totalcapitals=yearcapitals.get(intyear)+yearexpenses.get(intyear)+yearincomes.get(intyear);
//				// 按风险等级
//				List laterRiskGrades= entityService.loadAll(RiskGrade.class);
//				DefaultPieDataset laterRiskGradeDataSet = new DefaultPieDataset();
//				if (!laterRiskGrades.isEmpty()) {
//					Collections.sort(laterRiskGrades);
//					for(Iterator riskiter=laterRiskGrades.iterator();riskiter.hasNext();)
//					{
//						RiskGrade riskgrade = (RiskGrade) riskiter.next();
//						double tempValue=0d;
//						double pertempValue=0d;
//			        for (Iterator iter = financeresults.iterator(); iter.hasNext();) {
//			        	FinancePlanResult plan = (FinancePlanResult) iter.next();
//			        	if(plan.getRiskgrade()==riskgrade){
//			            	tempValue=tempValue+(capitals.get(plan.getFinancetype().getName()).get(intyear))+(expenses.get(plan.getFinancetype().getName()).get(intyear))+(incomes.get(plan.getFinancetype().getName()).get(intyear));
//			        	}		            	
//			        }
//	        		pertempValue = Math.rint(tempValue/totalcapitals*10000);
//	        		if (tempValue!=0){
//	        			laterRiskGradeDataSet.setValue(riskgrade.getName() + "  ("+ pertempValue/100 +"%)", tempValue);
//	        		}
//	        		}
//				}
//				
//				put("laterRiskGrade", new GeneralDatasetProducer("test", laterRiskGradeDataSet));	
//				put("totalcapitals",totalcapitals);
//			
//			
//
//				// 按资产类型
//				List laterFinanceTypes= getTopFinanceTypes();
//				DefaultPieDataset laterFinanceTypeDataSet = new DefaultPieDataset();
//				if (!laterFinanceTypes.isEmpty()) {
//					Collections.sort(laterFinanceTypes);
//					for(Iterator typeiter=laterFinanceTypes.iterator();typeiter.hasNext();)
//					{
//						FinanceType financeType = (FinanceType) typeiter.next();
//						double tempValue=0d;
//						double pertempValue=0d;
//			        for (Iterator iter = financeresults.iterator(); iter.hasNext();) {
//			        	FinancePlanResult plan = (FinancePlanResult) iter.next();
//			        	if(plan.getFinancetype().getParent()==financeType){
//			            	tempValue=tempValue+(capitals.get(plan.getFinancetype().getName()).get(intyear))+(expenses.get(plan.getFinancetype().getName()).get(intyear))+(incomes.get(plan.getFinancetype().getName()).get(intyear));
//			        	}		            	
//			        }
//	        		pertempValue = Math.rint(tempValue/totalcapitals*10000);
//	        		if (tempValue!=0){
//	        			laterFinanceTypeDataSet.setValue(financeType.getName() + "  ("+ pertempValue/100 +"%)", tempValue);
//	        		}
//	        		}
//				}
//				
//				put("laterFinanceType", new GeneralDatasetProducer("test", laterFinanceTypeDataSet));	
//
//			
//				// 按流动性
//				List laterMobilities= entityService.loadAll(Mobility.class);
//				DefaultPieDataset laterMobilityDataSet = new DefaultPieDataset();
//				if (!laterMobilities.isEmpty()) {
//					Collections.sort(laterMobilities);
//					for(Iterator mobilityiter=laterMobilities.iterator();mobilityiter.hasNext();)
//					{
//						Mobility mobility = (Mobility) mobilityiter.next();
//						double tempValue=0d;
//						double pertempValue=0d;
//			        for (Iterator iter = financeresults.iterator(); iter.hasNext();) {
//			        	FinancePlanResult plan = (FinancePlanResult) iter.next();
//			        	if(plan.getMobility()==mobility){
//			            	tempValue=tempValue+(capitals.get(plan.getFinancetype().getName()).get(intyear))+(expenses.get(plan.getFinancetype().getName()).get(intyear))+(incomes.get(plan.getFinancetype().getName()).get(intyear));
//			        	}		            	
//			        }
//	        		pertempValue = Math.rint(tempValue/totalcapitals*10000);
//	        		if (tempValue!=0){
//	        			laterMobilityDataSet.setValue(mobility.getName() + "  ("+ pertempValue/100 +"%)", tempValue);
//	        		}
//	        		}
//				}
//				
//				put("laterMobility", new GeneralDatasetProducer("test", laterMobilityDataSet));			
//			
//			
//			
//				// 按投资收益
//				DefaultPieDataset laterBenefitDataSet = new DefaultPieDataset();
//				List<String> laterBenefits=new ArrayList();
//				laterBenefits.add("大于百分之二十");
//				laterBenefits.add("介于百分之十与百分之二十之间");
//				laterBenefits.add("介于百分之五与百分之十之间");
//				laterBenefits.add("介于百分之零与百分之五之间");
//				if (!laterBenefits.isEmpty()) {
//					Collections.sort(laterBenefits);
//					for(Iterator benefititer=laterBenefits.iterator();benefititer.hasNext();)
//					{
//						String benefit = (String) benefititer.next();
//						double tempValue=0d;
//						double pertempValue=0d;
//			        for (Iterator iter = financeresults.iterator(); iter.hasNext();) {
//			        	FinancePlanResult plan = (FinancePlanResult) iter.next();
//			        	if((plan.getRate()>20)&&(benefit.equals("大于百分之二十"))){
//			            	tempValue=tempValue+(capitals.get(plan.getFinancetype().getName()).get(intyear))+(expenses.get(plan.getFinancetype().getName()).get(intyear))+(incomes.get(plan.getFinancetype().getName()).get(intyear));
//			        	}
//			        	else if((plan.getRate()>10)&&(plan.getRate()<=20)&&(benefit.equals("介于百分之十与百分之二十之间"))){
//			            	tempValue=tempValue+(capitals.get(plan.getFinancetype().getName()).get(intyear))+(expenses.get(plan.getFinancetype().getName()).get(intyear))+(incomes.get(plan.getFinancetype().getName()).get(intyear));
//			        	}
//			        	else if((plan.getRate()>5)&&(plan.getRate()<=10)&&(benefit.equals("介于百分之五与百分之十之间"))){
//			            	tempValue=tempValue+(capitals.get(plan.getFinancetype().getName()).get(intyear))+(expenses.get(plan.getFinancetype().getName()).get(intyear))+(incomes.get(plan.getFinancetype().getName()).get(intyear));
//			        	}
//			        	else if((plan.getRate()>=0)&&(plan.getRate()<=5)&&(benefit.equals("介于百分之零与百分之五之间"))){
//			            	tempValue=tempValue+(capitals.get(plan.getFinancetype().getName()).get(intyear))+(expenses.get(plan.getFinancetype().getName()).get(intyear))+(incomes.get(plan.getFinancetype().getName()).get(intyear));
//			        	}
//			        }
//	        		pertempValue = Math.rint(tempValue/totalcapitals*10000);
//	        		if (tempValue!=0){
//	        			laterBenefitDataSet.setValue(benefit + "  ("+ pertempValue/100 +"%)", tempValue);
//	        		}
//	        		}
//				}
//				
//				put("laterBenefit", new GeneralDatasetProducer("test", laterBenefitDataSet));
//			
//			
//			
//		}
//		else if (type.equals("InsuranceCompare"))
//		{//保险资产结构对比分析
//			List<InsuranceCompareResult> results=(List)entityService.search(query);
//			InsuranceCompareResult result=new InsuranceCompareResult();
//			if (!results.isEmpty()) {
//				result= results.get(0);
//			}
//			put("result",result);
//			put("analysisResult",result);
//			
//			Double nowTotalAmount = 0d;
//			EntityQuery nowTotalQuery = new EntityQuery(InsurancePolicyResult.class, "insurancePolicyResult");
//			nowTotalQuery.add(new Condition("insurancePolicyResult.result.experiment.id=" + expId));
//			addStdCondition(nowTotalQuery, "insurancePolicyResult.result", std);
//			nowTotalQuery.add(new Condition("insurancePolicyResult.result.student.code=:stdCode", getLoginName()));
//			nowTotalQuery.setSelect("select sum(insurancePolicyResult.policy.coverage)");
//			List nowTotalAmountList = entityService.search(nowTotalQuery);
//			if (!nowTotalAmountList.isEmpty()) {
//				nowTotalAmount = (Double)nowTotalAmountList.get(0);
//			}
//			put("nowTotalAmount", nowTotalAmount);
//			
//			
//			
//			/**取人员*/
//		    query = new EntityQuery(FamilyMemberResult.class, "memberResult");
//			query.add(new Condition("memberResult.result.experiment.id=:experimentId", expId));
//			addStdCondition(query, "memberResult.result", std);
//			query.setSelect("memberResult.member");
//			List<FamilyMember> members = entityService.search(query);
//			put("members",members);
//			Map<String,Double> nowMemberTotalAmountMap=new HashMap();
//			for ( int j=0;j<members.size();j++) {
//				FamilyMember member= members.get(j);
//				Double nowMemberTotalAmount = 0d;
//				EntityQuery nowMemberTotalQuery = new EntityQuery(InsurancePolicyResult.class, "insurancePolicyResult");
//				nowMemberTotalQuery.add(new Condition("insurancePolicyResult.result.experiment.id=" + expId));
//				addStdCondition(nowMemberTotalQuery, "insurancePolicyResult.result", std);
//				nowMemberTotalQuery.add(new Condition("insurancePolicyResult.policy.insurant='" + member.getName()+"'"));
//				nowMemberTotalQuery.setSelect("select sum(insurancePolicyResult.policy.coverage)");
//				List nowMemberTotalAmountList = entityService.search(nowMemberTotalQuery);
//				if (!nowMemberTotalAmountList.isEmpty()) {
//					nowMemberTotalAmount = (Double)nowMemberTotalAmountList.get(0)==null?0:(Double)nowMemberTotalAmountList.get(0);
//				}
//				nowMemberTotalAmountMap.put(member.getName(), nowMemberTotalAmount);
//			}
//			put("nowMemberTotalAmountMap",nowMemberTotalAmountMap);
//			
//			// 按保险类型
//			List notZeroItemsInsuranceType = new ArrayList();
//			EntityQuery nowInsuranceTypeQuery = new EntityQuery(InsurancePolicyResult.class, "insurancePolicyResult");
//	        nowInsuranceTypeQuery.add(new Condition("insurancePolicyResult.result.experiment.id=" + expId));
//	        addStdCondition(nowInsuranceTypeQuery, "insurancePolicyResult.result", std);
//	        nowInsuranceTypeQuery.groupBy("insurancePolicyResult.policy.type.parent");
//	        nowInsuranceTypeQuery.setSelect("select new com.ekingstar.eams.util.stat.CountItem(sum(insurancePolicyResult.policy.coverage), insurancePolicyResult.policy.type.parent) ");
//	        List nowInsuranceTypeItems = entityService.search(nowInsuranceTypeQuery);
//			DefaultPieDataset nowInsuranceTypeDataSet = new DefaultPieDataset();
//			if (!nowInsuranceTypeItems.isEmpty()) {
//				Collections.sort(nowInsuranceTypeItems);
//		        for (Iterator iter = nowInsuranceTypeItems.iterator(); iter.hasNext();) {
//		            CountItem item = (CountItem) iter.next();
//		            if (item.getCount().intValue() != 0&&null!=nowTotalAmount&&nowTotalAmount!=0) {
//		            	double tempValue = Math.rint(Double.parseDouble(item.getCount().toString())/nowTotalAmount*10000);
//		            	nowInsuranceTypeDataSet.setValue(((InsuranceType) item.getWhat()).getName() + "  ("+ tempValue/100 +"%)", item.getCount()
//		                        .intValue());
//		                notZeroItemsInsuranceType.add(item);
//		            }
//		        }
//			}
//			put("nowInsuranceType", new GeneralDatasetProducer("test", nowInsuranceTypeDataSet));
//			put("countResultInsuranceType", notZeroItemsInsuranceType);
//			// 按被保险人
//			List notZeroItemsInsurant = new ArrayList();
//			EntityQuery nowInsurantQuery = new EntityQuery(InsurancePolicyResult.class, "insurancePolicyResult");
//	        nowInsurantQuery.add(new Condition("insurancePolicyResult.result.experiment.id=" + expId));
//	        addStdCondition(nowInsurantQuery, "insurancePolicyResult.result", std);
//	        nowInsurantQuery.groupBy("insurancePolicyResult.policy.insurant");
//	        nowInsurantQuery.setSelect("select new com.ekingstar.eams.util.stat.CountItem(sum(insurancePolicyResult.policy.coverage), insurancePolicyResult.policy.insurant) ");
//			List nowInsurantItems = entityService.search(nowInsurantQuery);
//			DefaultPieDataset nowInsurantDataSet = new DefaultPieDataset();
//			if (!nowInsurantItems.isEmpty()) {
//				Collections.sort(nowInsurantItems);
//		        for (Iterator iter = nowInsurantItems.iterator(); iter.hasNext();) {
//		            CountItem item = (CountItem) iter.next();
//		            if (item.getCount().intValue() != 0&&null!=nowTotalAmount&&nowTotalAmount!=0) {
//		            	double tempValue = Math.rint(Double.parseDouble(item.getCount().toString())/nowTotalAmount*10000);
//		            	nowInsurantDataSet.setValue(item.getWhat() + "  ("+ tempValue/100 +"%)", item.getCount()
//		                        .intValue());
//		                notZeroItemsInsurant.add(item);
//		            }
//		        }
//			}
//			put("nowInsurant", new GeneralDatasetProducer("test", nowInsurantDataSet));
//			put("countResultInsurant", notZeroItemsInsurant);
//			
//			Map<String,GeneralDatasetProducer> nowMemberInsuranceTypeMap=new HashMap();
//			for ( int j=0;j<members.size();j++) {
//				FamilyMember member= members.get(j);
//				if((nowMemberTotalAmountMap.get(member.getName())==0d)||(nowMemberTotalAmountMap.get(member.getName())==null)){
//				}else{	
//				Double nowMemberTotalAmount	=nowMemberTotalAmountMap.get(member.getName());
//				List notZeroMemberItemsInsuranceType = new ArrayList();
//				EntityQuery nowMemberInsuranceTypeQuery = new EntityQuery(InsurancePolicyResult.class, "insurancePolicyResult");
//				nowMemberInsuranceTypeQuery.add(new Condition("insurancePolicyResult.result.experiment.id=" + expId));
//				nowMemberInsuranceTypeQuery.add(new Condition("insurancePolicyResult.policy.insurant='" + member.getName()+"'"));
//				addStdCondition(nowMemberInsuranceTypeQuery, "insurancePolicyResult.result", std);
//				nowMemberInsuranceTypeQuery.groupBy("insurancePolicyResult.policy.type.parent");
//				nowMemberInsuranceTypeQuery.setSelect("select new com.ekingstar.eams.util.stat.CountItem(sum(insurancePolicyResult.policy.coverage), insurancePolicyResult.policy.type.parent) ");
//				List nowMemberInsuranceTypeItems = entityService.search(nowMemberInsuranceTypeQuery);			
//
//				DefaultPieDataset nowMemberInsuranceTypeDataSet = new DefaultPieDataset();
//				if (!nowMemberInsuranceTypeItems.isEmpty()) {
//					Collections.sort(nowMemberInsuranceTypeItems);
//			        for (Iterator iter = nowMemberInsuranceTypeItems.iterator(); iter.hasNext();) {
//			            CountItem item = (CountItem) iter.next();
//			            if (item.getCount().intValue() != 0) {
//			            	double tempValue = Math.rint(Double.parseDouble(item.getCount().toString())/nowMemberTotalAmount*10000);
//			            	nowMemberInsuranceTypeDataSet.setValue(((InsuranceType) item.getWhat()).getName() + "  ("+ tempValue/100 +"%)", item.getCount()
//			                        .intValue());
//			            	notZeroMemberItemsInsuranceType.add(item);
//			            }
//			        }
//				}
//				put("nowMemberInsuranceType"+member.getName(), new GeneralDatasetProducer("test", nowMemberInsuranceTypeDataSet));
//				}
//			}	
//			
//			
//			
//			
//			/*
//			 * 
//				理财后
//						String year = (get("year")==null)?"1":get("year");
//			int intyear=Integer.parseInt(year);
//			 */
//
//			
//			int intyear=1;
//			if(get("faceyear")==null){
//			 intyear=1;
//			if (result.getYear()!=null)
//			{
//			 intyear=Integer.valueOf(result.getYear());
//			}}
//			else
//			{
//				 intyear=Integer.valueOf(get("faceyear"));
//			}
//			put("defaultYear",String.valueOf(intyear));	
//
//			/**每个成员每种类型保额*/
//			Map<String,Map<String, Map<Integer,Double>>>coverages = new HashMap();		
//			for ( int j=0;j<members.size();j++) {
//				FamilyMember member= members.get(j);
//				Map<String, Map<Integer,Double>> typecoverages = new HashMap();			
//				EntityQuery productquery=new EntityQuery(InsurancePlanPolicyResult.class, "policyresult");
//				productquery.add(new Condition("policyresult.result.experiment.id=:experimentId", expId));		
//				addStdCondition(productquery, "policyresult.result", std);
//				productquery.add(new Condition("policyresult.insurant=:insurant", member.getName()));
//				List<InsurancePlanPolicyResult> memberpolicy=entityService.search(productquery);
//				List<InsuranceType> insurancetypes=getTopInsuranceTypes();
//				for (InsuranceType insurancetype : insurancetypes) {
//					Map<Integer, Double> coverage=new HashMap();
//					for(int i=0;i<=getPlanYears();i++)
//					{
//						coverage.put(i, 0d);
//					}
//					for(InsurancePlanPolicyResult policyResult : memberpolicy){
//						if(policyResult.getProduct().getType().getParent()==insurancetype){
//							int insurancetime=calcYears(member.getAge()+policyResult.getApplyOn(),policyResult.getTime().getDuration());
//							for(int i=policyResult.getApplyOn();i<=insurancetime+policyResult.getApplyOn();i++)
//							{
//								if (i>30) 
//								{
//								 break; 
//								}
//								coverage.put(i,coverage.get(i)+policyResult.getCoverage().doubleValue());/**保额*/
//							}						
//						}
//					}
//					typecoverages.put(insurancetype.getName(), coverage);
//				}
//				coverages.put(member.getName(), typecoverages);
//			}		
//				
//
//
//			/**第intyear的总保额和个人的总保额*/
//			Double laterTotalCoverage=0d;
//			Map<String,Double> sumcoverage=new HashMap();
//			List<InsuranceType> insurancetypes=getTopInsuranceTypes();
//			for ( int j=0;j<members.size();j++) {
//				FamilyMember member= members.get(j);
//				Double membersum=0d;
//					for(InsuranceType insurancetype : insurancetypes)
//						{
//							membersum=membersum+coverages.get(member.getName()).get(insurancetype.getName()).get(intyear);
//						}
//					sumcoverage.put(member.getName(), membersum);
//					laterTotalCoverage=laterTotalCoverage+membersum;			
//			}
//			put("laterTotalCoverage",laterTotalCoverage);
//
//			/**按被保险人统计*/		
//			DefaultPieDataset laterInsurantDataSet = new DefaultPieDataset();
//			for ( int j=0;j<members.size();j++) {
//				FamilyMember member= members.get(j);
//				double tempValue=sumcoverage.get(member.getName());
//	    		double pertempValue = Math.rint(tempValue/laterTotalCoverage*10000);	
//	    		if (tempValue!=0){
//	    			laterInsurantDataSet.setValue(member.getName() + "  ("+ pertempValue/100 +"%)", tempValue);
//	    		}
//			}
//			
//			put("laterInsurant", new GeneralDatasetProducer("test", laterInsurantDataSet));	
//			
//			/**按保险类型统计*/
//			DefaultPieDataset laterInsuranceType = new DefaultPieDataset();
//			for(InsuranceType insurancetype : insurancetypes)	{
//				double tempValue=0d;
//				for(FamilyMember member : members){
//				 tempValue=tempValue+coverages.get(member.getName()).get(insurancetype.getName()).get(intyear);
//				}
//	    		double pertempValue = Math.rint(tempValue/laterTotalCoverage*10000);	
//	    		if (tempValue!=0){
//	    			laterInsuranceType.setValue(insurancetype.getName() + "  ("+ pertempValue/100 +"%)", tempValue);
//	    		}
//			}
//			
//			put("laterInsuranceType", new GeneralDatasetProducer("test", laterInsuranceType));			
//			/**按每个人保险类型统计*/
//			Map<String,Double> laterMemberTotalAmountMap=new HashMap();
//			for ( int j=0;j<members.size();j++) {
//				FamilyMember member= members.get(j);
//				laterMemberTotalAmountMap.put(member.getName(), sumcoverage.get(member.getName()));
//			}
//			put("laterMemberTotalAmountMap",laterMemberTotalAmountMap);		
//
//			
//			
//			for ( int j=0;j<members.size();j++) {
//				FamilyMember member= members.get(j);
//				if((laterMemberTotalAmountMap.get(member.getName())==0d)||(laterMemberTotalAmountMap.get(member.getName())==null)){
//				}else{	
//					DefaultPieDataset laterMemberInsuranceType = new DefaultPieDataset();
//					Double laterMemberTotalCoverage=laterMemberTotalAmountMap.get(member.getName());
//					for(InsuranceType insurancetype : insurancetypes)	{
//						double tempValue=coverages.get(member.getName()).get(insurancetype.getName()).get(intyear);
//			    		double pertempValue = Math.rint(tempValue/laterMemberTotalCoverage*10000);	
//			    		if (tempValue!=0){
//			    			laterMemberInsuranceType.setValue(insurancetype.getName() + "  ("+ pertempValue/100 +"%)", tempValue);
//			    		}
//					}
//					
//				put("laterMemberInsuranceType"+member.getName(), new GeneralDatasetProducer("test", laterMemberInsuranceType));
//				}
//			}	
//			
//			
//			
//			
//		}
//		put("phase",phase);
//	    put("type",type);
////		put("studentId",stdId);
////		put("experimentId",expId);
//		
//		/**取assementItem*/	
//		query=new EntityQuery(AssessItem.class,"item");
//		query.add(new Condition("item.assessment=:assessment and item.phase.engName=:type", experiment.getAssessment(), type));		
//		List<AssessItem> items=(List)entityService.search(query);
//		AssessItem item=null;
//		if(!items.isEmpty()){
//			item=items.get(0);
//			put("item",item);
//		}		
//		/**取某分析表的总分*/	
//		
//		query=new EntityQuery(Analysis.class,"analysis");
//		query.add(new Condition("analysis.engName=:engName", type));
//		List<Analysis> analysises=(List)entityService.search(query);		
//		Analysis analysis=analysises.get(0);
//		Float totalmark=(experiment.getMark(analysis).getMark()==null)?0f:experiment.getMark(analysis).getMark();
//		put("totalmark",totalmark);
//		return forward();
//	}
//	
//	
	private String getResultTypeName(String phase, String type) {
		return "org.expr.model." + phase + ".result." + type + "Result";
	}
//	
//	protected FinanceAssetPlanResult getstdFinanceAssetPlanResult(Long experimentId,Long stdId) {
//		EntityQuery query = new EntityQuery(FinanceAssetPlanResult.class, "result");
//		query.add(new Condition("result.experiment.id=:experimentId", experimentId));
//		query.add(new Condition("result.student.id=:stdId", stdId));
//		List results = entityService.search(query);
//		FinanceAssetPlanResult result = null;
//		if (results.isEmpty()) {
//			result = new FinanceAssetPlanResult();
//			result.setExperiment((Experiment) entityService.get(Experiment.class, experimentId));
//			List studentList = (List) entityService.load(Student.class, stdId);
//			if (null != studentList && studentList.size() != 0) {
//				result.setStudent((Student) studentList.get(0));
//			}
//			result.setAssets(new HashSet());
//			entityService.saveOrUpdate(result);
//		} else {
//			result = (FinanceAssetPlanResult) results.get(0);
//		}
//		return result;
//	}	
//	
	public String saveAnswer() {
		Long expId = getLong("experiment.id");
		Long stdId = getLong("std.id");
		String phase = get("phase");
		String type = get("type");
		Float score = getFloat("score");
		EntityQuery query = new EntityQuery(getResultTypeName(phase, type), "result");
		query.add(new Condition("result.student.id=:stdId and result.experiment.id=:expId", stdId,
				expId));
		List<AbstractResult> results = entityService.search(query);
		AbstractResult result = null;
		if (results.size() > 0) {
			result = results.get(0);
			result.setScore(score);
			entityService.saveOrUpdate(result);
		}
		EntityQuery resultQuery = new EntityQuery(AbstractResult.class, "result");
		resultQuery.add(new Condition("result.student.id=:stdId and result.experiment.id=:expId",
				stdId, expId));
		resultQuery.setSelect("result.score");
		List<Float> scores = entityService.search(resultQuery);
		Float sum=0f;
		for(Float one:scores){
			if(null!=one){
				sum+=one;
			}
		}
		// 修改总分
		query = new EntityQuery(CazeResult.class, "result");
		query.add(new Condition("result.student.id=:stdId and result.experiment.id=:expId", stdId,
				expId));
		List<CazeResult> cazeresults = (List) entityService.search(query);
		CazeResult cazeresult = null;
		if (cazeresults.isEmpty()) {
			cazeresult = new CazeResult();
			cazeresult.setExperiment((Experiment) entityService.load(Experiment.class, expId));
			cazeresult.setStudent((Student) entityService.load(Student.class, stdId));
		} else {
			cazeresult = (CazeResult) cazeresults.get(0);
		}
		if (!scores.isEmpty()) {
			cazeresult.setScore(sum);
			entityService.saveOrUpdate(cazeresult);
		}
		return redirect("checkIndex", "info.save.success", "&experiment.id=" + expId
				+ "&std.id=" + stdId + "&phase=" + phase + "&type=" + type);
	}
//	
//	/*计算保险*/
//	private Integer calcYears(Integer age, String script) {
//		if (StringUtils.isEmpty(script)) {
//			return 30;
//		}
//		else 
//		{
//			if(StringUtils.contains(script, "age"))
//			{
//				return Integer.parseInt(script.substring(script.indexOf("-")))-age+1;
//			}
//			else
//			{
//				return Integer.parseInt(script)-1;
//			}
//		}
//	}
//	public Double getstdFirstBalance(Experiment experiment,Long stdId) {
//		Long experimentId = experiment.getId();
//		Double balance = 0d;
//		EntityQuery balancequery = new EntityQuery(BalanceOfPaymentResult.class, "result");
//		balancequery.add(new Condition("result.experiment.id=:experimentId", experimentId));
//		balancequery.add(new Condition("result.student.id=:stdId", stdId));
//		List balanceresults = entityService.search(balancequery);
//		BalanceOfPaymentResult balanceresult = new BalanceOfPaymentResult();
//		if (!balanceresults.isEmpty()) {
//			balanceresult = (BalanceOfPaymentResult) balanceresults.get(0);
//		}
//		if (null != balanceresult && null != balanceresult.getForm()
//				&& null != balanceresult.getForm().getTotalBalance()) {
//			balance = balanceresult.getForm().getTotalBalance().doubleValue() * 12;
//		}
//		return balance;
//	}
//
//	/** 返回第year年的工资 */
//	/** 工资收入map */
//	public Double getYearCashes(Experiment experiment, Integer year,Student std) {
//		Long experimentId = experiment.getId();
//		EntityQuery query = new EntityQuery(CashPlanResult.class, "cashPlan");
//		query.add(new Condition("cashPlan.experiment.id=:experimentId", experimentId));
//		addStdCondition(query, "cashPlan", std);
//		List<CashPlanResult> cashresults = entityService.search(query);
//		CashPlanResult cashresult = new CashPlanResult();
//		if (!cashresults.isEmpty()) {
//			cashresult = cashresults.get(0);
//		}
//		double cash = 0;
//		for (MemberCashPlanResult memberResult : cashresult.getMembers()) {
//			if (memberResult.getSalaries() == null || memberResult.getSalaries().get(year) == null) {
//				cash = cash + 0;
//			} else {
//				cash = cash + memberResult.getSalaries().get(year);
//			}
//		}
//		return cash;
//	}
//
//	/** 返回第year年的奖金 */
//	/*** 奖金收入map */
//	public Double getYearBonuses(Experiment experiment, Integer year,Student std) {
//		Long experimentId = experiment.getId();
//		EntityQuery query = new EntityQuery(BonusPlanResult.class, "bonusPlan");
//		query.add(new Condition("bonusPlan.experiment.id=:experimentId", experimentId));
//		addStdCondition(query, "bonusPlan", std);
//		List<BonusPlanResult> bonusresults = entityService.search(query);
//		BonusPlanResult bonusresult = new BonusPlanResult();
//		if (!bonusresults.isEmpty()) {
//			bonusresult = bonusresults.get(0);
//		}
//		double bonuse = 0;
//		for (MemberBonusPlanResult memberResult : bonusresult.getMembers()) {
//			if (memberResult.getBonuses() == null || memberResult.getBonuses().get(year) == null) {
//				bonuse = bonuse + 0;
//			} else {
//				bonuse = bonuse + memberResult.getBonuses().get(year);
//			}
//		}
//
//		return bonuse;
//	}
//
//	/** 返回第 year年的投资收入 */
//	/**
//	 * 投资收入 public Double getYearInvestIncomes(Experiment experiment,Integer
//	 * year){ Double investincome=0d; FinanceAssetPlanResult
//	 * planResult=getFinanceAssetPlanResult(experiment); for (FinancePlanResult
//	 * assetResult : planResult.getAssets()) { if
//	 * ((assetResult.getStartYear()<=year)&&(assetResult.getEndYear()>=year)) {
//	 * investincome=investincome+getYearIncomes(experiment,assetResult,year); }
//	 * } return investincome; }
//	 */
//
//	/** 返回第year年的其他收入 */
//	/** 其他收入 */
//	public Double getYearOtherIncomes(Experiment experiment, Integer year,Student std) {
//		Long experimentId = experiment.getId();
//		EntityQuery query = new EntityQuery(OtherIncomePlanResult.class, "incomePlan");
//		query.add(new Condition("incomePlan.experiment.id=:experimentId", experimentId));
//		addStdCondition(query, "incomePlan", std);
//		List<OtherIncomePlanResult> incomeresults = entityService.search(query);
//		OtherIncomePlanResult incomeresult = new OtherIncomePlanResult();
//		if (!incomeresults.isEmpty()) {
//			incomeresult = incomeresults.get(0);
//		}
//		double income = 0d;
//		if ((incomeresult.getAmounts() == null) || (incomeresult.getAmounts().get(year) == null)) {
//			income = 0d;
//		} else {
//			income = incomeresult.getAmounts().get(year);
//		}
//		return income;
//	}
//
//	/** 返回第 year年的投资支出 */
//	/**
//	 * 投资支出 public Double getYearInvestExpenses(Experiment experiment,Integer
//	 * year){ Long experimentId = getLong("experiment.id"); Double
//	 * investexpense=0d; FinanceAssetPlanResult
//	 * planResult=getFinanceAssetPlanResult(experiment); for (FinancePlanResult
//	 * assetResult : planResult.getAssets()) { if
//	 * ((assetResult.getStartYear()<=year)&&(assetResult.getEndYear()>=year)) {
//	 * investexpense=investexpense+getYearExpenses(experiment,assetResult,year);
//	 * } } return investexpense; }
//	 */
//	/** 返回第year年的消费支出 */
//	/** 消费支出 */
//	public Double getYearConsumes(Experiment experiment, Integer year,Student std) {
//		Long experimentId = experiment.getId();
//		EntityQuery query = new EntityQuery(ConsumePlanResult.class, "consumePlan");
//		query.add(new Condition("consumePlan.experiment.id=:experimentId", experimentId));
//		addStdCondition(query, "consumePlan", std);
//		List<ConsumePlanResult> consumeresults = entityService.search(query);
//		ConsumePlanResult consumeresult = new ConsumePlanResult();
//		if (!consumeresults.isEmpty()) {
//			consumeresult = consumeresults.get(0);
//		}
//		double consume = 0d;
//		if ((consumeresult.getAmounts() == null) || (consumeresult.getAmounts().get(year) == null)) {
//			consume = 0d;
//		} else {
//			consume = consumeresult.getAmounts().get(year);
//		}
//		return consume;
//	}
//
//	/** 返回第year年教育支出 */
//	/** 教育支出 */
//	public Double getYearEducations(Experiment experiment, Integer year,Student std) {
//		Long experimentId = experiment.getId();
//		EntityQuery query = new EntityQuery(EducationPlanResult.class, "educationPlan");
//		query.add(new Condition("educationPlan.experiment.id=:experimentId", experimentId));
//		addStdCondition(query, "educationPlan", std);
//		List<EducationPlanResult> educationresults = entityService.search(query);
//		EducationPlanResult educationresult = new EducationPlanResult();
//		if (!educationresults.isEmpty()) {
//			educationresult = educationresults.get(0);
//		}
//		double education = 0d;
//		for (MemberEducationPlanResult memberResult : educationresult.getMembers()) {
//			if (memberResult.getExpenses() == null || memberResult.getExpenses().get(year) == null) {
//				education = education + 0;
//			} else {
//				education = education + memberResult.getExpenses().get(year);
//			}
//		}
//		return education;
//	}
//
//	/** 返回第year年旅游支出 */
//	/** 旅游支出 */
//	public Double getYearTrips(Experiment experiment, Integer year,Student std) {
//		Long experimentId = experiment.getId();
//		EntityQuery query = new EntityQuery(TripPlanResult.class, "tripPlan");
//		query.add(new Condition("tripPlan.experiment.id=:experimentId", experimentId));
//		addStdCondition(query, "tripPlan", std);
//		List<TripPlanResult> tripresults = entityService.search(query);
//		TripPlanResult tripresult = new TripPlanResult();
//		if (!tripresults.isEmpty()) {
//			tripresult = tripresults.get(0);
//			;
//		}
//		double trip = 0d;
//		if ((tripresult.getExpenses() == null) || (tripresult.getExpenses().get(year) == null)) {
//			trip = 0d;
//		} else {
//			trip = tripresult.getExpenses().get(year);
//		}
//		return trip;
//	}
//
//	/** 返回第year年医疗支出 */
//	/** 医疗支出 */
//	public Double getYearMedicals(Experiment experiment, Integer year,Student std) {
//		Long experimentId = experiment.getId();
//		EntityQuery query = new EntityQuery(MedicalPlanResult.class, "medicalPlan");
//		query.add(new Condition("medicalPlan.experiment.id=:experimentId", experimentId));
//		addStdCondition(query, "medicalPlan", std);
//		List<MedicalPlanResult> medicalresults = entityService.search(query);
//		MedicalPlanResult medicalresult = new MedicalPlanResult();
//		if (!medicalresults.isEmpty()) {
//			medicalresult = medicalresults.get(0);
//		}
//
//		double medical = 0d;
//		for (MemberMedicalPlanResult memberResult : medicalresult.getMembers()) {
//			if (memberResult.getExpenses() == null || memberResult.getExpenses().get(year) == null) {
//				medical = medical + 0;
//			} else {
//				medical = medical + memberResult.getExpenses().get(year);
//			}
//		}
//		return medical;
//	}
//
//	/** 返回第year年车贷支出 */
//
//	public Double getYearCarDeposits(Experiment experiment, Integer year,Student std) {
//		Long experimentId = experiment.getId();
//		EntityQuery query = new EntityQuery(CarPlanResult.class, "result");
//		query.add(new Condition("result.experiment.id=:experimentId", experimentId));
//		addStdCondition(query, "result", std);
//		List<CarPlanResult> carresults = entityService.search(query);
//		CarPlanResult carresult = new CarPlanResult();
//		if (!carresults.isEmpty()) {
//			carresult = carresults.get(0);
//		}
//		double cardeposit = 0d;
//		if (carresult.getLoans() == null || carresult.getLoans().get(year) == null
//				|| carresult.getLoans().get(year).getBusiness() == null
//				|| carresult.getLoans().get(year).getBusiness().getTotal() == null) {
//			cardeposit = cardeposit + 0;
//		} else {
//			cardeposit = cardeposit
//					+ carresult.getLoans().get(year).getBusiness().getTotal().doubleValue();
//		}
//		return cardeposit;
//	}
//
//	/** 返回第year年房贷支出 */
//	public Double getYearHouseDeposits(Experiment experiment, Integer year,Student std) {
//		Long experimentId = experiment.getId();
//		EntityQuery query = new EntityQuery(EstateLoanPlanResult.class, "result");
//		query.add(new Condition("result.experiment.id=:experimentId", experimentId));
//		addStdCondition(query, "result", std);
//		List<EstateLoanPlanResult> estateresults = entityService.search(query);
//		EstateLoanPlanResult estateresult = new EstateLoanPlanResult();
//		if (!estateresults.isEmpty()) {
//			estateresult = estateresults.get(0);
//		}
//		double housedeposit = 0d;
//		if (estateresult.getLoans() == null || estateresult.getLoans().get(year) == null
//				|| estateresult.getLoans().get(year).getAccumulation() == null
//				|| estateresult.getLoans().get(year).getAccumulation().getTotal() == null) {
//			housedeposit = housedeposit + 0;
//		} else {
//			housedeposit = housedeposit
//					+ estateresult.getLoans().get(year).getAccumulation().getTotal().doubleValue();
//		}
//		if (estateresult.getLoans() == null || estateresult.getLoans().get(year) == null
//				|| estateresult.getLoans().get(year).getBusiness() == null
//				|| estateresult.getLoans().get(year).getBusiness().getTotal() == null) {
//			housedeposit = housedeposit + 0;
//		} else {
//			housedeposit = housedeposit
//					+ estateresult.getLoans().get(year).getBusiness().getTotal().doubleValue();
//		}
//
//		return housedeposit;
//	}
//
//	/** 返回第year年还贷款支出 */
//	/** 还贷支出 */
//	/** 车贷 */
//	public Double getYearDeposits(Experiment experiment, Integer year,Student std) {
//		Long experimentId = experiment.getId();
//		EntityQuery query = new EntityQuery(CarPlanResult.class, "result");
//		query.add(new Condition("result.experiment.id=:experimentId", experimentId));
//		addStdCondition(query, "result", std);
//		List<CarPlanResult> carresults = entityService.search(query);
//		CarPlanResult carresult = new CarPlanResult();
//		if (!carresults.isEmpty()) {
//			carresult = carresults.get(0);
//		}
//
//		/** 房贷 */
//		query = new EntityQuery(EstateLoanPlanResult.class, "result");
//		query.add(new Condition("result.experiment.id=:experimentId", experimentId));
//		addStdCondition(query, "result", std);
//		List<EstateLoanPlanResult> estateresults = entityService.search(query);
//		EstateLoanPlanResult estateresult = new EstateLoanPlanResult();
//		if (!estateresults.isEmpty()) {
//			estateresult = estateresults.get(0);
//		}
//
//		double deposit = 0d;
//		if (carresult.getLoans() == null || carresult.getLoans().get(year) == null
//				|| carresult.getLoans().get(year).getBusiness() == null
//				|| carresult.getLoans().get(year).getBusiness().getTotal() == null) {
//			deposit = deposit + 0;
//		} else {
//			deposit = deposit
//					+ carresult.getLoans().get(year).getBusiness().getTotal().doubleValue();
//		}
//		if (estateresult.getLoans() == null || estateresult.getLoans().get(year) == null
//				|| estateresult.getLoans().get(year).getAccumulation() == null
//				|| estateresult.getLoans().get(year).getAccumulation().getTotal() == null) {
//			deposit = deposit + 0;
//		} else {
//			deposit = deposit
//					+ estateresult.getLoans().get(year).getAccumulation().getTotal().doubleValue();
//		}
//		if (estateresult.getLoans() == null || estateresult.getLoans().get(year) == null
//				|| estateresult.getLoans().get(year).getBusiness() == null
//				|| estateresult.getLoans().get(year).getBusiness().getTotal() == null) {
//			deposit = deposit + 0;
//		} else {
//			deposit = deposit
//					+ estateresult.getLoans().get(year).getBusiness().getTotal().doubleValue();
//		}
//		return deposit;
//	}
//
//	/** 返回当年保险支出 */
//	/** 保险支出 */
//	public Double getYearInsurances(Experiment experiment, Integer year,Student std) {
//		Long experimentId = experiment.getId();
//		EntityQuery query = new EntityQuery();
//		query = new EntityQuery(FamilyMemberResult.class, "memberResult");
//		query.add(new Condition("memberResult.result.experiment.id=:experimentId", experimentId));
//		addStdCondition(query, "memberResult.result", std);
//		query.add(new Condition("memberResult.result.student.code=:stdCode", getLoginName()));
//		query.setSelect("memberResult.member");
//		List<FamilyMember> members = entityService.search(query);
//		EntityQuery productquery = new EntityQuery();
//		Double insurance = 0d;
//		for (int j = 0; j < members.size(); j++) {
//			FamilyMember member = members.get(j);
//			productquery = new EntityQuery(InsurancePlanPolicyResult.class, "policyresult");
//			productquery.add(new Condition("policyresult.result.experiment.id=:experimentId",
//					experimentId));
//			addStdCondition(query, "policyresult.result", std);
//			productquery.add(new Condition("policyresult.insurant=:insurant", member.getName()));
//			List<InsurancePlanPolicyResult> memberpolicy = entityService.search(productquery);
//
//			for (InsurancePlanPolicyResult policyResult : memberpolicy) {
//				int paytime = calcYears(member.getAge(), policyResult.getPayTime().getDuration());
//				if ((policyResult.getApplyOn() <= year)
//						&& (paytime + policyResult.getApplyOn() >= year)) {
//					insurance = insurance + policyResult.getExpense();
//				}
//			}
//		}
//		return insurance;
//	}
//
//	/** 返回当年其他支出 */
//	/** 其他支出 */
//	public Double getYearOtherExpenses(Experiment experiment, Integer year,Student std) {
//		Long experimentId = experiment.getId();
//		EntityQuery query = new EntityQuery(OtherExpensePlanResult.class, "expensePlan");
//		query.add(new Condition("expensePlan.experiment.id=:experimentId", experimentId));
//		addStdCondition(query, "expensePlan", std);
//		List<OtherExpensePlanResult> expenseresults = entityService.search(query);
//		OtherExpensePlanResult expenseresult = new OtherExpensePlanResult();
//		if (!expenseresults.isEmpty()) {
//			expenseresult = expenseresults.get(0);
//		}
//		double expense = 0d;
//		if ((expenseresult.getAmounts() == null) || (expenseresult.getAmounts().get(year) == null)) {
//			expense = 0d;
//		} else {
//			expense = expenseresult.getAmounts().get(year);
//		}
//		return expense;
//	}
//	
//
//	protected BalanceOfPaymentResult getIncomeExpenseResult(Experiment experiment,Long stdId) {
//		EntityQuery query = new EntityQuery(BalanceOfPaymentResult.class, "result");
//		query.add(new Condition("result.experiment=:experiment", experiment));
//		query.add(new Condition("result.student.id=:stdId", stdId));			
//		List results = entityService.search(query);
//		BalanceOfPaymentResult result = null;
//		if (results.isEmpty()) {
//			result = new BalanceOfPaymentResult();
//			result.setExperiment(experiment);
//			result.setForm(new BalanceOfPayment());
//			List studentList = (List)entityService.load(Student.class,stdId);
//			if (null != studentList && studentList.size()!=0){
//				result.setStudent((Student)studentList.get(0));
//			}			
//			entityService.saveOrUpdate(result);
//		} else {
//			result = (BalanceOfPaymentResult) results.get(0);
//		}
//		return result;
//	}
//	private void populateIncomeExpend(BalanceOfPayment balence, Map incomeMap, Map expendMap) {
//		for (Iterator iterator = balence.getIncomes().iterator(); iterator.hasNext();) {
//			IncomeHolder holder = (IncomeHolder) iterator.next();
//			incomeMap.put(holder.getIncome().getIncomeProject().getId().toString(), holder
//					.getIncome().getAmount());
//		}
//		for (Iterator iterator = balence.getExpends().iterator(); iterator.hasNext();) {
//			ExpendHolder holder = (ExpendHolder) iterator.next();
//			expendMap.put(holder.getExpend().getExpendProject().getId().toString(), holder
//					.getExpend().getAmount());
//		}
//	}
//	private List getTopFinanceTypes() {
//		EntityQuery query = new EntityQuery(FinanceType.class, "financeType");
//		query.add(new Condition("financeType.parent is null"));
//		List financeTypes = entityService.search(query);
//		return financeTypes;
//	}
//	private List getTopIncomeProjects() {
//		EntityQuery query = new EntityQuery(IncomeProject.class, "project");
//		query.add(new Condition("project.parent is null"));
//		List IncomeProjects = entityService.search(query);
//		return IncomeProjects;
//	}
//
//	private List getTopExpendProjects() {
//		EntityQuery query = new EntityQuery(ExpendProject.class, "project");
//		query.add(new Condition("project.parent is null"));
//		List ExpendProjects = entityService.search(query);
//		return ExpendProjects;
//	}
//	private List getTopInsuranceTypes() {
//		EntityQuery query = new EntityQuery(InsuranceType.class, "insuranceType");
//		query.add(new Condition("insuranceType.parent is null"));
//		List insuranceTypes = entityService.search(query);
//		return insuranceTypes;
//	}
//	
//	
	/**统一评分界面*/
	public String checkSummary() throws IllegalAccessException, InvocationTargetException, NoSuchMethodException{
		Long stdId = getLong("std.id");
		Long expId = getLong("experiment.id");
		Experiment exp=(Experiment)entityService.get(Experiment.class, expId);
		put("experiment",exp);
		EntityQuery query = new EntityQuery(CazeResult.class, "r");
		query.add(new Condition("r.student.id=:stdId",stdId));
		query.add(new Condition("r.experiment.id=:experimentId",expId));		
		List<CazeResult> results = entityService.search(query);
		List<Analysis> analysisTalbes=entityService.loadAll(Analysis.class);
		Map<String,Float> ScoreMap=new HashMap();
		CazeResult result = null;
		if (results.size() > 0) {
			result = results.get(0);
			put("result", result);
			
			
			//取各分析表得分
			for (int i=0;i<analysisTalbes.size();i++){
				Analysis analysisTalbe=analysisTalbes.get(i);
				if (exp.getMark(analysisTalbe)!=null)
				{
					String hql="from "+analysisTalbe.getEngName()+"Result r where r.student.id=:stdId and r.experiment.id=:expId";
					Map params=new HashMap();
					params.put("stdId", stdId);
					params.put("expId", expId);
					Float score=0f;
					String remark=new String();
					List forms = entityService.searchHQLQuery(hql, params);
					if(forms.size()>0){
						 Object form=forms.get(0);	
						 score=(Float)PropertyUtils.getProperty(form,"score");
						//PropertyUtils.setProperty(form, "score", score);
					}
					ScoreMap.put(analysisTalbe.getEngName(), score);
				}
			}
			put("ScoreMap",ScoreMap);
			
		}
		return forward();
	}
	
	
	public String saveSummary() throws IllegalAccessException, InvocationTargetException, NoSuchMethodException
	{
		Long stdId = getLong("std.id");
		Long expId = getLong("experiment.id");
		Float sum=0f;
		Experiment experiment=(Experiment)entityService.get(Experiment.class, expId);
		EntityQuery query = new EntityQuery(CazeResult.class, "r");
		query.add(new Condition("r.student.id=:stdId and r.experiment.id=:expId", stdId, expId));
		List<CazeResult> results = entityService.search(query);
		CazeResult result = null;
		if (results.size() > 0) {
			result = results.get(0);
			String[] types = getValues("typeName");
			for (String type : types) {
				Float score = getFloat(type + "Score");
				if(null!=score){
					sum+=score;
				}
				String hql="from "+type+"Result r where r.student.id=:stdId and r.experiment.id=:expId";
				Map params=new HashMap();
				params.put("stdId", stdId);
				params.put("expId", expId);
				List<AnalysisForm> forms = entityService.searchHQLQuery(hql, params);
				Object form=null;
				if (forms.size() > 0) {
					form=forms.get(0);
					PropertyUtils.setProperty(form, "score", score);
					entityService.saveOrUpdate(form);
				}
			}
			result.setScore(sum);
			entityService.saveOrUpdate(result);
		}
		return redirect("checkSummary", "info.save.success", "&experiment.id=" + expId+"&std.id="+stdId);
	}
}


