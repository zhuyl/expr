package org.expr.web.action.plan.result;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.beanfuse.collection.Order;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.analysis.FamilyMember;
import org.expr.model.analysis.result.FamilyMemberResult;
import org.expr.model.lesson.Experiment;
import org.expr.model.plan.result.BonusPlanResult;
import org.expr.model.plan.result.CarPlanResult;
import org.expr.model.plan.result.CashPlanResult;
import org.expr.model.plan.result.ConsumePlanResult;
import org.expr.model.plan.result.EducationPlanResult;
import org.expr.model.plan.result.EstateLoanPlanResult;
import org.expr.model.plan.result.FinanceAssetPlanResult;
import org.expr.model.plan.result.FinancePlanResult;
import org.expr.model.plan.result.InsurancePlanPolicyResult;
import org.expr.model.plan.result.MedicalPlanResult;
import org.expr.model.plan.result.MemberBonusPlanResult;
import org.expr.model.plan.result.MemberCashPlanResult;
import org.expr.model.plan.result.MemberEducationPlanResult;
import org.expr.model.plan.result.MemberMedicalPlanResult;
import org.expr.model.plan.result.OtherExpensePlanResult;
import org.expr.model.plan.result.OtherIncomePlanResult;
import org.expr.model.plan.result.PlanSummaryResult;
import org.expr.model.plan.result.TripPlanResult;

import com.ekingstar.eams.student.Student;

/**
 * 理财规划综述
 * 
 * @return
 */
public class PlanSummaryAction extends AbstractPlanResultAction {

	public String index() {
		Long experimentId = getLong("experiment.id");
		EntityQuery query = new EntityQuery(PlanSummaryResult.class, "plansummary");
		query.add(new Condition("plansummary.experiment.id=:experimentId", experimentId));
		Student std = getLoginStudent();
		addStdCondition(query, "plansummary", std);
		List<PlanSummaryResult> results = entityService.search(query);
		PlanSummaryResult result = new PlanSummaryResult();
		if (!results.isEmpty()) {
			result = (PlanSummaryResult) results.get(0);
		}
		put("result", result);

		query = new EntityQuery(FamilyMemberResult.class, "memberResult");
		query.add(new Condition("memberResult.result.experiment.id=:experimentId", experimentId));
		addStdCondition(query, "memberResult.result", std);
		query.setSelect("memberResult.member");
		List<FamilyMember> members = entityService.search(query);

		/** 工资收入map */
		query = new EntityQuery(CashPlanResult.class, "cashPlan");
		query.add(new Condition("cashPlan.experiment.id=:experimentId", experimentId));
		addStdCondition(query, "cashPlan", std);
		List<CashPlanResult> cashresults = entityService.search(query);
		CashPlanResult cashresult = new CashPlanResult();
		if (!cashresults.isEmpty()) {
			cashresult = cashresults.get(0);
		}

		Map<Integer, Double> cashes = new HashMap();
		for (int i = 1; i <= getPlanYears(); i++) {
			double sum = 0;
			for (MemberCashPlanResult memberResult : cashresult.getMembers()) {
				if (memberResult.getSalaries() == null || memberResult.getSalaries().get(i) == null) {
					sum = sum + 0;
				} else {
					sum = sum + memberResult.getSalaries().get(i);
				}
			}
			cashes.put(i, sum);
		}
		put("cashes", cashes);

		/*** 奖金收入map */
		query = new EntityQuery(BonusPlanResult.class, "bonusPlan");
		query.add(new Condition("bonusPlan.experiment.id=:experimentId", experimentId));
		addStdCondition(query, "bonusPlan", std);
		List<BonusPlanResult> bonusresults = entityService.search(query);
		BonusPlanResult bonusresult = new BonusPlanResult();
		if (!bonusresults.isEmpty()) {
			bonusresult = bonusresults.get(0);
		}
		Map<Integer, Double> bonuses = new HashMap();
		for (int i = 1; i <= getPlanYears(); i++) {
			double sum = 0;
			for (MemberBonusPlanResult memberResult : bonusresult.getMembers()) {
				if (memberResult.getBonuses() == null || memberResult.getBonuses().get(i) == null) {
					sum = sum + 0;
				} else {
					sum = sum + memberResult.getBonuses().get(i);
				}
			}
			bonuses.put(i, sum);
		}
		put("bonuses", bonuses);

		/** 其他收入 */
		query = new EntityQuery(OtherIncomePlanResult.class, "incomePlan");
		query.add(new Condition("incomePlan.experiment.id=:experimentId", experimentId));
		addStdCondition(query, "incomePlan", std);
		List<OtherIncomePlanResult> incomeresults = entityService.search(query);
		OtherIncomePlanResult incomeresult = new OtherIncomePlanResult();
		if (!incomeresults.isEmpty()) {
			incomeresult = incomeresults.get(0);
		}
		Map<Integer, Double> incomes = new HashMap();
		for (int i = 1; i <= getPlanYears(); i++) {
			if ((incomeresult.getAmounts() == null) || (incomeresult.getAmounts().get(i) == null)) {
				incomes.put(i, 0d);
			} else {
				incomes.put(i, incomeresult.getAmounts().get(i));
			}
		}
		put("incomes", incomes);

		/** 消费支出 */
		query = new EntityQuery(ConsumePlanResult.class, "consumePlan");
		query.add(new Condition("consumePlan.experiment.id=:experimentId", experimentId));
		addStdCondition(query, "consumePlan", std);
		List<ConsumePlanResult> consumeresults = entityService.search(query);
		ConsumePlanResult consumeresult = new ConsumePlanResult();
		if (!consumeresults.isEmpty()) {
			consumeresult = consumeresults.get(0);
		}
		Map<Integer, Double> consumes = new HashMap();
		for (int i = 1; i <= getPlanYears(); i++) {
			if ((consumeresult.getAmounts() == null) || (consumeresult.getAmounts().get(i) == null)) {
				consumes.put(i, 0d);
			} else {
				consumes.put(i, consumeresult.getAmounts().get(i));
			}
		}
		put("consumes", consumes);

		/** 教育支出 */
		query = new EntityQuery(EducationPlanResult.class, "educationPlan");
		query.add(new Condition("educationPlan.experiment.id=:experimentId", experimentId));
		addStdCondition(query, "educationPlan", std);
		List<EducationPlanResult> educationresults = entityService.search(query);
		EducationPlanResult educationresult = new EducationPlanResult();
		if (!educationresults.isEmpty()) {
			educationresult = educationresults.get(0);
		}
		Map<Integer, Double> educations = new HashMap();
		for (int i = 1; i <= getPlanYears(); i++) {
			double sum = 0;
			for (MemberEducationPlanResult memberResult : educationresult.getMembers()) {
				if (memberResult.getExpenses() == null || memberResult.getExpenses().get(i) == null) {
					sum = sum + 0;
				} else {
					sum = sum + memberResult.getExpenses().get(i);
				}
			}
			educations.put(i, sum);
		}
		put("educations", educations);

		/** 旅游支出 */
		query = new EntityQuery(TripPlanResult.class, "tripPlan");
		query.add(new Condition("tripPlan.experiment.id=:experimentId", experimentId));
		addStdCondition(query, "tripPlan", std);
		List<TripPlanResult> tripresults = entityService.search(query);
		TripPlanResult tripresult = new TripPlanResult();
		if (!tripresults.isEmpty()) {
			tripresult = tripresults.get(0);
			;
		}
		Map<Integer, Double> trips = new HashMap();
		for (int i = 1; i <= getPlanYears(); i++) {
			if ((tripresult.getExpenses() == null) || (tripresult.getExpenses().get(i) == null)) {
				trips.put(i, 0d);
			} else {
				trips.put(i, tripresult.getExpenses().get(i));
			}
		}

		put("trips", trips);

		/** 医疗支出 */
		query = new EntityQuery(MedicalPlanResult.class, "medicalPlan");
		query.add(new Condition("medicalPlan.experiment.id=:experimentId", experimentId));
		addStdCondition(query, "medicalPlan", std);
		List<MedicalPlanResult> medicalresults = entityService.search(query);
		MedicalPlanResult medicalresult = new MedicalPlanResult();
		if (!medicalresults.isEmpty()) {
			medicalresult = medicalresults.get(0);
		}
		Map<Integer, Double> medicals = new HashMap();
		for (int i = 1; i <= getPlanYears(); i++) {
			double sum = 0;
			for (MemberMedicalPlanResult memberResult : medicalresult.getMembers()) {
				if (memberResult.getExpenses() == null || memberResult.getExpenses().get(i) == null) {
					sum = sum + 0;
				} else {
					sum = sum + memberResult.getExpenses().get(i);
				}
			}
			medicals.put(i, sum);
		}
		put("medicals", medicals);

		/** 还贷支出 */
		/** 车贷 */
		query = new EntityQuery(CarPlanResult.class, "result");
		query.add(new Condition("result.experiment.id=:experimentId", experimentId));
		addStdCondition(query, "result", std);
		List<CarPlanResult> carresults = entityService.search(query);
		CarPlanResult carresult = new CarPlanResult();
		if (!carresults.isEmpty()) {
			carresult = carresults.get(0);
		}

		/** 房贷 */
		query = new EntityQuery(EstateLoanPlanResult.class, "result");
		query.add(new Condition("result.experiment.id=:experimentId", experimentId));
		addStdCondition(query, "result", std);
		List<EstateLoanPlanResult> estateresults = entityService.search(query);
		EstateLoanPlanResult estateresult = new EstateLoanPlanResult();
		if (!estateresults.isEmpty()) {
			estateresult = estateresults.get(0);
		}

		Map<Integer, Double> deposits = new HashMap();
		Map<Integer, Double> cardeposits = new HashMap();
		Map<Integer, Double> housedeposits = new HashMap();
		for (int i = 1; i <= getPlanYears(); i++) {
			double sum = 0d;
			double housesum = 0d;
			if (carresult.getLoans() == null || carresult.getLoans().get(i) == null
					|| carresult.getLoans().get(i).getBusiness() == null
					|| carresult.getLoans().get(i).getBusiness().getTotal() == null) {
				sum = sum + 0;
			} else {
				sum = sum + carresult.getLoans().get(i).getBusiness().getTotal().doubleValue();
			}
			if (carresult.getLoans() == null || carresult.getLoans().get(i) == null
					|| carresult.getLoans().get(i).getCapital() == null) {
				cardeposits.put(i, 0d);
			} else {
				cardeposits.put(i, carresult.getLoans().get(i).getCapital());
			}
			if (estateresult.getLoans() == null || estateresult.getLoans().get(i) == null
					|| estateresult.getLoans().get(i).getAccumulation() == null
					|| estateresult.getLoans().get(i).getAccumulation().getTotal() == null) {
				sum = sum + 0;
			} else {
				sum = sum
						+ estateresult.getLoans().get(i).getAccumulation().getTotal().doubleValue();
			}
			if (estateresult.getLoans() == null || estateresult.getLoans().get(i) == null
					|| estateresult.getLoans().get(i).getBusiness() == null
					|| estateresult.getLoans().get(i).getBusiness().getTotal() == null) {
				sum = sum + 0;
			} else {
				sum = sum + estateresult.getLoans().get(i).getBusiness().getTotal().doubleValue();
			}
			if (estateresult.getLoans() == null || estateresult.getLoans().get(i) == null
					|| estateresult.getLoans().get(i).getAccumulationCapital() == null) {
				housesum = housesum + 0;
			} else {
				housesum = housesum + estateresult.getLoans().get(i).getAccumulationCapital();
			}
			if (estateresult.getLoans() == null || estateresult.getLoans().get(i) == null
					|| estateresult.getLoans().get(i).getBusinessCapital() == null) {
				housesum = housesum + 0;
			} else {
				housesum = housesum + estateresult.getLoans().get(i).getBusinessCapital();
			}
			housedeposits.put(i, housesum);
			deposits.put(i, sum);
		}
		put("deposits", deposits);
		put("housedeposits", housedeposits);
		put("cardeposits", cardeposits);

		/** 保险支出 */
		/** 保单保额保费 */

		Map<Integer, Double> insurances = new HashMap();
		Map<Integer, Double> coverages = new HashMap();
		for (int i = 1; i <= getPlanYears(); i++) {
			insurances.put(i, 0d);
			coverages.put(i, 0d);
		}

		EntityQuery productquery = new EntityQuery();

		for (int j = 0; j < members.size(); j++) {
			FamilyMember member = members.get(j);

			productquery = new EntityQuery(InsurancePlanPolicyResult.class, "policyresult");
			productquery.add(new Condition("policyresult.result.experiment.id=:experimentId",
					experimentId));
			addStdCondition(query, "policyresult.result", std);
			productquery.add(new Condition("policyresult.insurant=:insurant", member.getName()));
			List<InsurancePlanPolicyResult> memberpolicy = entityService.search(productquery);

			for (InsurancePlanPolicyResult policyResult : memberpolicy) {
				int paytime = calcYears(member.getAge(), policyResult.getPayTime().getDuration());
				for (int i = policyResult.getApplyOn(); i <= paytime + policyResult.getApplyOn(); i++) {
					if (i > 30) {
						break;
					}
					insurances.put(i, insurances.get(i) + policyResult.getExpense().doubleValue());
				}
				int insurancetime = calcYears(member.getAge() + policyResult.getApplyOn(),
						policyResult.getTime().getDuration());
				for (int i = policyResult.getApplyOn(); i <= insurancetime
						+ policyResult.getApplyOn(); i++) {
					if (i > 30) {
						break;
					}
					coverages.put(i, coverages.get(i) + policyResult.getCoverage().doubleValue());
					/** 保额 */
				}
			}
		}
		put("insurances", insurances);
		put("coverages", coverages);

		/** 其他支出 */
		query = new EntityQuery(OtherExpensePlanResult.class, "expensePlan");
		query.add(new Condition("expensePlan.experiment.id=:experimentId", experimentId));
		addStdCondition(query, "expensePlan", std);
		List<OtherExpensePlanResult> expenseresults = entityService.search(query);
		OtherExpensePlanResult expenseresult = new OtherExpensePlanResult();
		if (!expenseresults.isEmpty()) {
			expenseresult = expenseresults.get(0);
		}
		Map<Integer, Double> expenses = new HashMap();
		for (int i = 1; i <= getPlanYears(); i++) {
			if ((expenseresult.getAmounts() == null) || (expenseresult.getAmounts().get(i) == null)) {
				expenses.put(i, 0d);
			} else {
				expenses.put(i, expenseresult.getAmounts().get(i));
			}
		}

		put("expenses", expenses);

		/** 理财收入支出 */
		Experiment experiment = (Experiment) entityService.load(Experiment.class, experimentId);
		FinanceAssetPlanResult planResult = getFinanceAssetPlanResult();
		query = new EntityQuery(FinancePlanResult.class, "asset");
		query.addOrder(Order.parse(get("orderBy")));
		query.add(new Condition("asset.result.experiment.id=:experimentid", experimentId));
		addStdCondition(query, "asset.result", std);
		List<FinancePlanResult> financeresults = entityService.search(query);
		double firstbalance = getFirstBalance(experiment);

		Map<Integer, Double> totalcapital = new HashMap();
		Map<Integer, Double> totalexpense = new HashMap();
		/** 追加 */
		Map<Integer, Double> totalincome = new HashMap();
		/** 收益 */
		Map<Integer, Double> totalbalance = new HashMap();
		/** 结余 */

		for (int i = 1; i <= getPlanYears(); i++) {
			totalcapital.put(i, 0d);
		}
		for (int i = 1; i <= getPlanYears(); i++) {
			totalexpense.put(i, 0d);
		}
		for (int i = 1; i <= getPlanYears(); i++) {
			totalincome.put(i, 0d);
		}
		Map<String, Double> lastcapital = new HashMap();
		for (FinancePlanResult planresult : financeresults) {
			lastcapital.put(planresult.getFinancetype().getName(), planresult.getAmount());
		}
		for (int i = 1; i <= getPlanYears(); i++) {
			double expense = 0d;
			double income = 0d;
			double capital = 0d;/* 期初+追加资产 */
			double balance = 0d;

			if (i == 1) {
				for (FinancePlanResult planresult : financeresults) {
					if (planresult.getStartYear() == 1) {

						expense = expense + planresult.getAppend().doubleValue() * firstbalance
								/ 100d;
						capital = capital + planresult.getAmount()
								+ planresult.getAppend().doubleValue() * firstbalance / 100d;
						income = income
								+ (planresult.getAmount() + firstbalance
										* planresult.getAppend().doubleValue() / 100d)
								* planresult.getRate().doubleValue() / 100d;
						lastcapital.put(planresult.getFinancetype().getName(),
								planresult.getAmount() + planresult.getAppend().doubleValue()
										* firstbalance / 100d);
					}
				}
			} else {
				for (FinancePlanResult planresult : financeresults) {
					if ((i <= planresult.getEndYear()) && (i >= planresult.getStartYear())) {
						double nowcapital = 0d;
						expense = expense + planresult.getAppend().doubleValue()
								* totalbalance.get(i - 1) / 100d;
						if (i == planresult.getStartYear()) {
							nowcapital = planresult.getAmount()
									+ planresult.getAppend().byteValue() * totalbalance.get(i - 1)
									/ 100d;
						} else {
							nowcapital = lastcapital.get(planresult.getFinancetype().getName())
									* (1 + planresult.getRate().doubleValue() / 100d)
									+ planresult.getAppend().byteValue() * totalbalance.get(i - 1)
									/ 100d;
						}
						capital = capital + nowcapital;
						lastcapital.put(planresult.getFinancetype().getName(), nowcapital);
						income = income + (nowcapital) * planresult.getRate().doubleValue() / 100d;
					}
				}
			}
			balance = cashes.get(i) + bonuses.get(i) + incomes.get(i) + income - consumes.get(i)
					- expense - educations.get(i) - trips.get(i) - medicals.get(i)
					- deposits.get(i) - insurances.get(i) - expenses.get(i);
			totalexpense.put(i, expense);
			totalincome.put(i, income);
			totalcapital.put(i, capital + income);
			/** 期初+追加+收益 */
			totalbalance.put(i, balance);
		}
		put("capitals", totalcapital);
		put("investexpenses", totalexpense);
		put("investincomes", totalincome);
		put("balances", totalbalance);

		/** 房屋资产 **/

		query = new EntityQuery(EstateLoanPlanResult.class, "result");
		query.add(new Condition("result.experiment.id=:experimentId", experimentId));
		addStdCondition(query, "result",getLoginStudent());
		//query.add(new Condition("result.student.code=:stdCode", getLoginName()));
		List<EstateLoanPlanResult> estatePlanresults = entityService.search(query);
		EstateLoanPlanResult estatePlanresult = new EstateLoanPlanResult();
		if (!estatePlanresults.isEmpty()) {
			estatePlanresult = (EstateLoanPlanResult) estatePlanresults.get(0);
		}
		Map<Integer, Double> estates = new HashMap();
		for (int i = 1; i <= getPlanYears(); i++) {
			if ((estatePlanresult.getExpenses() == null)
					|| (estatePlanresult.getExpenses().get(i) == null)) {
				estates.put(i, 0d);
			} else {
				estates.put(i, estatePlanresult.getExpenses().get(i));
			}
		}
		put("estates", estates);

		// **汽车资产**/
		query = new EntityQuery(CarPlanResult.class, "result");
		query.add(new Condition("result.experiment.id=:experimentId", experimentId));
		addStdCondition(query, "result", std);
		List<CarPlanResult> carPlanresults = entityService.search(query);
		CarPlanResult carPlanresult = new CarPlanResult();
		if (!carPlanresults.isEmpty()) {
			carPlanresult = (CarPlanResult) carPlanresults.get(0);
		}
		Map<Integer, Double> cars = new HashMap();
		for (int i = 1; i <= getPlanYears(); i++) {
			if ((carPlanresult.getExpenses() == null)
					|| (carPlanresult.getExpenses().get(i) == null)) {
				cars.put(i, 0d);
			} else {
				cars.put(i, carPlanresult.getExpenses().get(i));
			}
		}
		put("cars", cars);

		return forward();
	}

	protected FinanceAssetPlanResult getFinanceAssetPlanResult() {
		EntityQuery query = new EntityQuery(FinanceAssetPlanResult.class, "result");
		Long experimentId = getLong("experiment.id");
		query.add(new Condition("result.experiment.id=:experimentId", experimentId));
		Student std=getLoginStudent();
		addStdCondition(query, "result", std);
		List results = entityService.search(query);
		FinanceAssetPlanResult result = null;
		if (results.isEmpty()) {
			result = new FinanceAssetPlanResult();
			result.setExperiment((Experiment) entityService.get(Experiment.class, experimentId));
//			List studentList = (List) entityService.load(Student.class, "code", getLoginName());
//			if (null != studentList && studentList.size() != 0) {
//				result.setStudent((Student) studentList.get(0));
//			}
			if (std==null)
			{
				std=(Student)entityService.load(Student.class,getLong("std.id"));
			}
			result.setStudent(std);
			result.setAssets(new HashSet());
			entityService.saveOrUpdate(result);
		} else {
			result = (FinanceAssetPlanResult) results.get(0);
		}
		return result;
	}

	public String saveRemark() {
		Long experimentId = getLong("experiment.id");
		String remark = get("remark");
		PlanSummaryResult result = getPlanSummaryResult(experimentId);
		result.setRemark(remark);
		entityService.saveOrUpdate(result);
		return redirect("index", "info.save.success", "&experiment.id=" + experimentId);
	}

	private PlanSummaryResult getPlanSummaryResult(Long experimentId) {
		EntityQuery query = new EntityQuery(PlanSummaryResult.class, "plansummary");
		query.add(new Condition("plansummary.experiment.id=:experimentId", experimentId));
		Student std=getLoginStudent();
		addStdCondition(query, "plansummary", std);
		List<PlanSummaryResult> results = entityService.search(query);
		PlanSummaryResult result = null;
		if (!results.isEmpty()) {
			result = results.get(0);
		} else {
			result = new PlanSummaryResult();
			result.setExperiment((Experiment) entityService.get(Experiment.class, experimentId));
//			List studentList = (List) entityService.load(Student.class, "code", getLoginName());
//			if (null != studentList && studentList.size() != 0) {
//				result.setStudent((Student) studentList.get(0));
//			}
			if (std==null)
			{
				std=(Student)entityService.load(Student.class,getLong("std.id"));
			}
			result.setStudent(std);
			entityService.saveOrUpdate(result);
		}
		return result;
	}

	/** 计算保险期限，缴费期限的年份 */
	/** 计算保险期限，缴费期限的年份 */
	private Integer calcYears(Integer age, String script) {
		if (StringUtils.isEmpty(script)) {
			return 30;
		} else {
			if (StringUtils.contains(script, "age")) {
				return Integer.parseInt(script.substring(0,script.indexOf("-"))) - age + 1;
			} else {
				return Integer.parseInt(script) - 1;
			}
		}
	}

	public String infolet() {
		index();
		return forward("../../infolet/info");
	}
}