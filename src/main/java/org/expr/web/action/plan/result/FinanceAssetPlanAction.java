package org.expr.web.action.plan.result;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import org.beanfuse.collection.Order;
import org.beanfuse.model.Entity;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.basecode.FinanceType;
import org.expr.model.basecode.Mobility;
import org.expr.model.basecode.RatePayPeriod;
import org.expr.model.basecode.RiskGrade;
import org.expr.model.lesson.Experiment;
import org.expr.model.plan.result.FinanceAssetPlanResult;
import org.expr.model.plan.result.FinancePlanResult;

import com.ekingstar.eams.student.Student;

public class FinanceAssetPlanAction extends AbstractPlanResultAction {

	public String index() {
		return search();
	}

	public String search() {
		Long experimentid = getLong("experiment.id");
		Experiment experiment = (Experiment) entityService.load(Experiment.class, experimentid);
		FinanceAssetPlanResult planResult = getFinanceAssetPlanResult();
		EntityQuery query = new EntityQuery(FinancePlanResult.class, "asset");
		query.addOrder(Order.parse(get("orderBy")));
		query.add(new Condition("asset.result.experiment.id=:experimentid", experimentid));
		Student std = getLoginStudent();
		addStdCondition(query,"asset.result",std);
		query.setLimit(getPageLimit());// 加分页，否则删除会有误
		List<FinancePlanResult> financeresults = entityService.search(query);
		put("results", entityService.search(query));
		put("planResult", planResult);

		double firstbalance = getFirstBalance(experiment);

		Map<String, Map<Integer, Double>> capitals = new HashMap();
		Map<String, Map<Integer, Double>> expenses = new HashMap();
		/** 追加 */
		Map<String, Map<Integer, Double>> incomes = new HashMap();
		/** 收益 */

		Map<Integer, Double>[] expensearray = new Map[financeresults.size()];
		Map<Integer, Double>[] capitalarray = new Map[financeresults.size()];
		Map<Integer, Double>[] incomearray = new Map[financeresults.size()];
		for (int i = 0; i < financeresults.size(); i++) {
			expensearray[i] = new HashMap<Integer, Double>();
			capitalarray[i] = new HashMap<Integer, Double>();
			incomearray[i] = new HashMap<Integer, Double>();
		}
		for (int i = 1; i <= getPlanYears(); i++) {
			double expense = 0d;
			double capital = 0d;
			/** 期初资产 */
			double income = 0d;
			if (i == 1) {
				for (int j = 0; j < financeresults.size(); j++) {
					expense = 0d;
					capital = 0d;
					income = 0d;
					FinancePlanResult planresult = financeresults.get(j);
					if (planresult.getStartYear() == 1) {
						expense = planresult.getAppend().doubleValue() * firstbalance / 100d;
						capital = planresult.getAmount();
						income = (capital + expense) * planresult.getRate() / 100d;
					}
					expensearray[j].put(i, expense);
					capitalarray[j].put(i, capital);
					incomearray[j].put(i, income);
				}
			} else {
				/** 计算上一年收益和支出 */
				double lastexpense = 0d;
				double lastincome = 0d;
				double lastbalance = 0d;
				for (int p = 0; p < financeresults.size(); p++) {
					if ((i > financeresults.get(p).getStartYear())
							&& (i <= financeresults.get(p).getEndYear() + 1)) {
						lastexpense = expensearray[p].get(i - 1) + lastexpense;
						lastincome = incomearray[p].get(i - 1) + lastincome;
					}
				}
				lastbalance = getYearCashes(experiment, i - 1) + getYearBonuses(experiment, i - 1)
						+ getYearOtherIncomes(experiment, i - 1) + lastincome
						- getYearConsumes(experiment, i - 1) - lastexpense
						- getYearEducations(experiment, i - 1) - getYearTrips(experiment, i - 1)
						- getYearMedicals(experiment, i - 1) - getYearDeposits(experiment, i - 1)
						- getYearInsurances(experiment, i - 1)
						- getYearOtherExpenses(experiment, i - 1);

				for (int j = 0; j < financeresults.size(); j++) {
					expense = 0d;
					capital = 0d;
					income = 0d;
					FinancePlanResult planresult = financeresults.get(j);
					if ((planresult.getStartYear() <= i) && (planresult.getEndYear() >= i)) {
						if (planresult.getStartYear() == i) {
							expense = planresult.getAppend().doubleValue() * lastbalance / 100d;
							capital = planresult.getAmount();
							income = (expense + capital) * planresult.getRate() / 100d;
						} else {
							expense = planresult.getAppend().doubleValue() * lastbalance / 100d;
							capital = expensearray[j].get(i - 1) + incomearray[j].get(i - 1)
									+ capitalarray[j].get(i - 1);
							income = (expense + capital) * planresult.getRate() / 100d;
						}
					}
					expensearray[j].put(i, expense);
					capitalarray[j].put(i, capital);
					incomearray[j].put(i, income);
				}
			}
		}
		for (int i = 0; i < financeresults.size(); i++) {
			capitals.put(financeresults.get(i).getFinancetype().getName(), capitalarray[i]);
			expenses.put(financeresults.get(i).getFinancetype().getName(), expensearray[i]);
			incomes.put(financeresults.get(i).getFinancetype().getName(), incomearray[i]);
		}
		put("expenses", expenses);
		put("capitals", capitals);
		put("incomes", incomes);

		return forward();
	}

	private List getTopFinanceTypes() {
		EntityQuery query = new EntityQuery(FinanceType.class, "financeType");
		query.add(new Condition("financeType.parent is null"));
		List financeTypes = entityService.search(query);
		return financeTypes;
	}

	public void editSetting(Entity entity) {
		put("FinanceTypes", getTopFinanceTypes());
		put("Mobilities", entityService.loadAll(Mobility.class));
		put("RiskGrades", entityService.loadAll(RiskGrade.class));
		put("RatePayPeriods", entityService.loadAll(RatePayPeriod.class));
	}

	private FinanceAssetPlanResult getFinanceAssetPlanResult() {
		EntityQuery query = new EntityQuery(FinanceAssetPlanResult.class, "result");
		Long experimentId = getLong("experiment.id");
		query.add(new Condition("result.experiment.id=:experimentId", experimentId));
		Student std = getLoginStudent();
		addStdCondition(query,"result",std);
		List results = entityService.search(query);
		FinanceAssetPlanResult result = null;
		if (results.isEmpty()) {
			result = new FinanceAssetPlanResult();
			result.setExperiment((Experiment) entityService.get(Experiment.class, experimentId));
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

	@Override
	protected String saveAndForward(Entity entity) {
		FinancePlanResult result = (FinancePlanResult) entity;
		if (null == result.getResult()) {
			result.setResult(getFinanceAssetPlanResult());
		}
		return super.saveAndForward(entity);
	}

	public String saveRemark() {
		Long experimentId = getLong("experiment.id");
		String remark = get("remark");
		FinanceAssetPlanResult result = getFinanceAssetPlanResult();
		result.setRemark(remark);
		entityService.saveOrUpdate(result);
		return redirect("search", "info.save.success", "&experiment.id=" + experimentId);
	}

	public String infolet() {
		search();
		return forward("../../infolet/info");
	}
}