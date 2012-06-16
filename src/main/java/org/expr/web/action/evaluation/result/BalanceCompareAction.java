package org.expr.web.action.evaluation.result;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.beanfuse.collection.Order;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.analysis.result.BalanceOfPaymentResult;
import org.expr.model.analysis.result.ExpendResult;
import org.expr.model.analysis.result.IncomeResult;
import org.expr.model.basecode.ExpendProject;
import org.expr.model.basecode.FinanceType;
import org.expr.model.basecode.IncomeProject;
import org.expr.model.evaluation.result.BalanceCompareResult;
import org.expr.model.lesson.Experiment;
import org.expr.model.plan.result.FinanceAssetPlanResult;
import org.expr.model.plan.result.FinancePlanResult;
import org.jfree.data.general.DefaultPieDataset;

import com.ekingstar.eams.student.Student;
import com.ekingstar.eams.util.stat.CountItem;
import com.ekingstar.eams.util.stat.GeneralDatasetProducer;

public class BalanceCompareAction extends AbstractEvaluationResultAction {
	public String index() {
		/** 理财前 */
		Long experimentid = getLong("experiment.id");
		Experiment experiment = (Experiment) entityService.load(Experiment.class,
				getLong("experiment.id"));
		BalanceCompareResult balancecompareresult = getBalanceCompareResult();
		put("analysisResult", balancecompareresult);

		Double nowTotalIncomeAmount = 0d;
		Double nowTotalExpendAmount = 0d;
		Student std=getLoginStudent();
		EntityQuery nowTotalQuery = new EntityQuery(BalanceOfPaymentResult.class,
				"balanceOfPaymentResult");
		nowTotalQuery.add(new Condition("balanceOfPaymentResult.experiment.id=" + experimentid));
		addStdCondition(nowTotalQuery, "balanceOfPaymentResult", std);
		//nowTotalQuery.add(new Condition("balanceOfPaymentResult.student",std));
		List nowTotalAmountList = entityService.search(nowTotalQuery);
		if (!nowTotalAmountList.isEmpty()) {
			BalanceOfPaymentResult balanceOfPaymentResult = (BalanceOfPaymentResult) nowTotalAmountList
					.get(0);
			if (null != balanceOfPaymentResult && null != balanceOfPaymentResult.getForm()
					&& null != balanceOfPaymentResult.getForm().getTotalIncome()) {
				nowTotalIncomeAmount = balanceOfPaymentResult.getForm().getTotalIncome()
						.doubleValue();
			}
			if (null != balanceOfPaymentResult && null != balanceOfPaymentResult.getForm()
					&& null != balanceOfPaymentResult.getForm().getTotalExpend()) {
				nowTotalExpendAmount = balanceOfPaymentResult.getForm().getTotalExpend()
						.doubleValue();
			}
		}
		put("nowTotalIncomeAmount", nowTotalIncomeAmount);
		put("nowTotalExpendAmount", nowTotalExpendAmount);
		List notZeroItemsIncome = new ArrayList();
		List notZeroItemsExpense = new ArrayList();

		EntityQuery nowIncomeQuery = new EntityQuery(IncomeResult.class, "incomeResult");
		nowIncomeQuery.add(new Condition("incomeResult.result.experiment.id=" + experimentid));
		addStdCondition(nowIncomeQuery, "incomeResult.result", std);
		nowIncomeQuery.groupBy("incomeResult.income.incomeProject");
		nowIncomeQuery
				.setSelect("select new com.ekingstar.eams.util.stat.CountItem(sum(incomeResult.income.amount), incomeResult.income.incomeProject) ");
		nowIncomeQuery.add(new Condition("incomeResult.income.incomeProject.parent is null"));
		List nowIncomeItems = entityService.search(nowIncomeQuery);
		DefaultPieDataset nowIncomeDataSet = new DefaultPieDataset();
		if (!nowIncomeItems.isEmpty()) {
			for (Iterator iter = nowIncomeItems.iterator(); iter.hasNext();) {
				CountItem item = (CountItem) iter.next();
				if(item!=null&&item.getCount()!=null){
				if (item.getCount().intValue() != 0) {
					double tempValue = Math.rint(Double.parseDouble(item.getCount().toString())
							/ nowTotalIncomeAmount * 10000);
					nowIncomeDataSet.setValue(((IncomeProject) item.getWhat()).getName() + "  ("
							+ tempValue / 100 + "%)", item.getCount().intValue());
					notZeroItemsIncome.add(item);
				}
				}
			}
		}
		put("nowIncome", new GeneralDatasetProducer("test", nowIncomeDataSet));
		put("countResultIncome", notZeroItemsIncome);

		EntityQuery nowExpenseQuery = new EntityQuery(ExpendResult.class, "expendResult");
		nowExpenseQuery.add(new Condition("expendResult.result.experiment.id=" + experimentid));
		addStdCondition(nowExpenseQuery, "expendResult.result", std);
		nowExpenseQuery.groupBy("expendResult.expend.expendProject");
		nowExpenseQuery
				.setSelect("select new com.ekingstar.eams.util.stat.CountItem(sum(expendResult.expend.amount), expendResult.expend.expendProject) ");
		nowExpenseQuery.add(new Condition("expendResult.expend.expendProject.parent is null"));
		List nowExpenseItems = entityService.search(nowExpenseQuery);
		DefaultPieDataset nowExpenseDataSet = new DefaultPieDataset();
		if (!nowExpenseItems.isEmpty()) {
			for (Iterator iter = nowExpenseItems.iterator(); iter.hasNext();) {
				CountItem item = (CountItem) iter.next();
				if(item!=null&&item.getCount()!=null){
				if (item.getCount().intValue() != 0) {
					double tempValue = Math.rint(Double.parseDouble(item.getCount().toString())
							/ nowTotalExpendAmount * 10000);
					nowExpenseDataSet.setValue(((ExpendProject) item.getWhat()).getName() + "  ("
							+ tempValue / 100 + "%)", item.getCount().intValue());
					notZeroItemsExpense.add(item);
				}
				}
			}
		}
		put("nowExpense", new GeneralDatasetProducer("test", nowExpenseDataSet));
		put("countResultExpense", notZeroItemsExpense);

		/*
		 * String year = (get("year")==null)?"1":get("year"); int
		 * intyear=Integer.valueOf(year);
		 */
		int intyear = 1;
		if (get("faceyear") == null) {
			intyear = 1;
			if (balancecompareresult.getYear() != null) {
				intyear = Integer.valueOf(balancecompareresult.getYear());
			}
		} else {
			intyear = Integer.valueOf(get("faceyear"));
		}
		put("defaultYear", String.valueOf(intyear));
		/*
		 * List notZeroItems = new ArrayList(); if (year != null &&
		 * "".equals(year)) {
		 * 
		 * DefaultPieDataset dataset = new DefaultPieDataset(); CountItem item =
		 * new CountItem(1,""); if (item.getCount().intValue() != 0) {
		 * dataset.setValue(((Department) item.getWhat()).getName(),
		 * item.getCount() .intValue()); notZeroItems.add(item); } put("year",
		 * year); put("incomeExpense", new GeneralDatasetProducer("test",
		 * dataset)); } put("countResult", notZeroItems);
		 */

		/** 理财后 */
		FinanceAssetPlanResult planResult = getFinanceAssetPlanResult(experiment);
		EntityQuery query = new EntityQuery(FinancePlanResult.class, "asset");
		query.addOrder(Order.parse(get("orderBy")));
		query.add(new Condition("asset.result.experiment.id=:experimentid", experiment.getId()));
		addStdCondition(query, "asset.result", std);
		query.setLimit(getPageLimit());// 加分页，否则删除会有误
		List<FinancePlanResult> financeresults = entityService.search(query);

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
		/** 第n年金融收入、支出、资本 */
		Map<Integer, Double> yearincomes = new HashMap();
		Map<Integer, Double> yearexpenses = new HashMap();
		Map<Integer, Double> yearcapitals = new HashMap();
		for (int i = 1; i <= getPlanYears(); i++) {
			double tempincome = 0d;
			double tempexpense = 0d;
			double tempcapital = 0d;
			for (int j = 0; j < financeresults.size(); j++) {
				FinancePlanResult plan = financeresults.get(j);
				tempincome = incomes.get(plan.getFinancetype().getName()).get(i) + tempincome;
				tempexpense = expenses.get(plan.getFinancetype().getName()).get(i) + tempexpense;
				tempcapital = capitals.get(plan.getFinancetype().getName()).get(i) + tempcapital;
			}
			yearincomes.put(i, tempincome);
			yearexpenses.put(i, tempexpense);
			yearcapitals.put(i, tempcapital);
		}

		/* 收入 */
		double laterTotalIncomeAmount = 0d;
		laterTotalIncomeAmount = getYearCashes(experiment, intyear)
				+ getYearBonuses(experiment, intyear) + yearincomes.get(intyear)
				+ getYearOtherIncomes(experiment, intyear);
		DefaultPieDataset laterIncomeDataSet = new DefaultPieDataset();
		List<IncomeProject> laterIncomeProjects = getTopIncomeProjects();

		if (!laterIncomeProjects.isEmpty()) {
			Collections.sort(laterIncomeProjects);
			for (Iterator iter = laterIncomeProjects.iterator(); iter.hasNext();) {
				IncomeProject project = (IncomeProject) iter.next();
				double pertempValue = 0d;
				double tempValue = 0d;
				if (project.getName().equals("工资性收入")) {
					tempValue = getYearCashes(experiment, intyear)
							+ getYearBonuses(experiment, intyear);
					pertempValue = Math.rint((getYearCashes(experiment, intyear) + getYearBonuses(
							experiment, intyear)) / laterTotalIncomeAmount * 10000);
				} else if (project.getName().equals("理财性收入")) {
					tempValue = yearincomes.get(intyear);
					pertempValue = Math.rint((yearincomes.get(intyear)) / laterTotalIncomeAmount
							* 10000);

				} else if (project.getName().equals("其他收入")) {
					tempValue = getYearOtherIncomes(experiment, intyear);
					pertempValue = Math.rint((getYearOtherIncomes(experiment, intyear))
							/ laterTotalIncomeAmount * 10000);
				}

				laterIncomeDataSet.setValue(project.getName() + "  (" + pertempValue / 100 + "%)",
						tempValue);

			}
		}
		put("laterIncome", new GeneralDatasetProducer("test", laterIncomeDataSet));
		put("laterTotalIncomeAmount", laterTotalIncomeAmount);

		/** 支出 */
		double laterTotalExpenseAmount = 0d;
		laterTotalExpenseAmount = getYearConsumes(experiment, intyear)
				+ getYearEducations(experiment, intyear) + getYearMedicals(experiment, intyear)
				+ getYearHouseDeposits(experiment, intyear)
				+ getYearCarDeposits(experiment, intyear) + yearexpenses.get(intyear)
				+ getYearInsurances(experiment, intyear) + getYearTrips(experiment, intyear)
				+ getYearOtherExpenses(experiment, intyear);
		DefaultPieDataset laterExpendDataSet = new DefaultPieDataset();
		List<ExpendProject> laterExpenseProjects = getTopExpendProjects();
		if (!laterExpenseProjects.isEmpty()) {
			Collections.sort(laterExpenseProjects);
			for (Iterator iter = laterExpenseProjects.iterator(); iter.hasNext();) {
				ExpendProject project = (ExpendProject) iter.next();
				double pertempValue = 0d;
				double tempValue = 0d;
				if (project.getName().equals("消费支出")) {
					tempValue = getYearConsumes(experiment, intyear);
					pertempValue = Math.rint((getYearConsumes(experiment, intyear))
							/ laterTotalExpenseAmount * 10000);

				} else if (project.getName().equals("教育支出")) {
					tempValue = getYearEducations(experiment, intyear);
					pertempValue = Math.rint((getYearEducations(experiment, intyear))
							/ laterTotalExpenseAmount * 10000);
				} else if (project.getName().equals("医疗支出")) {
					tempValue = getYearMedicals(experiment, intyear);
					pertempValue = Math.rint((getYearMedicals(experiment, intyear))
							/ laterTotalExpenseAmount * 10000);

				} else if (project.getName().equals("贷款支出")) {
					tempValue = getYearHouseDeposits(experiment, intyear)
							+ getYearCarDeposits(experiment, intyear);
					pertempValue = Math
							.rint((getYearHouseDeposits(experiment, intyear) + getYearCarDeposits(
									experiment, intyear)) / laterTotalExpenseAmount * 10000);

				} else if (project.getName().equals("投资支出")) {
					tempValue = yearexpenses.get(intyear);
					pertempValue = Math.rint((yearexpenses.get(intyear)) / laterTotalExpenseAmount
							* 10000);
				} else if (project.getName().equals("保费支出")) {
					tempValue = getYearInsurances(experiment, intyear);
					pertempValue = Math.rint((getYearInsurances(experiment, intyear))
							/ laterTotalExpenseAmount * 10000);
				} else if (project.getName().equals("旅游支出")) {
					tempValue = getYearTrips(experiment, intyear);
					pertempValue = Math.rint((getYearTrips(experiment, intyear))
							/ laterTotalExpenseAmount * 10000);
				} else if (project.getName().equals("其他支出")) {
					tempValue = getYearOtherExpenses(experiment, intyear);
					pertempValue = Math.rint((getYearOtherExpenses(experiment, intyear))
							/ laterTotalExpenseAmount * 10000);
				}

				laterExpendDataSet.setValue(project.getName() + "  (" + pertempValue / 100 + "%)",
						tempValue);

			}
		}
		put("laterExpense", new GeneralDatasetProducer("test", laterExpendDataSet));
		put("laterTotalExpendAmount", laterTotalExpenseAmount);
		return forward();
	}

	private List getTopFinanceTypes() {
		EntityQuery query = new EntityQuery(FinanceType.class, "financeType");
		query.add(new Condition("financeType.parent is null"));
		List financeTypes = entityService.search(query);
		return financeTypes;
	}

	private List getTopIncomeProjects() {
		EntityQuery query = new EntityQuery(IncomeProject.class, "project");
		query.add(new Condition("project.parent is null"));
		List IncomeProjects = entityService.search(query);
		return IncomeProjects;
	}

	private List getTopExpendProjects() {
		EntityQuery query = new EntityQuery(ExpendProject.class, "project");
		query.add(new Condition("project.parent is null"));
		List ExpendProjects = entityService.search(query);
		return ExpendProjects;
	}

	private BalanceCompareResult getBalanceCompareResult() {
		Long experimentid = getLong("experiment.id");
		EntityQuery query = new EntityQuery(BalanceCompareResult.class, "result");
		query.add(new Condition("result.experiment.id=:experimentId", experimentid));
		Student std=getLoginStudent();
		addStdCondition(query, "result", std);
		List results = entityService.search(query);

		BalanceCompareResult result = null;
		if (results.isEmpty()) {
			result = new BalanceCompareResult();
			result.setExperiment((Experiment) entityService.load(Experiment.class, experimentid));
//			List studentList = (List)entityService.load(Student.class,"code",getLoginName());
//			if (null != studentList && studentList.size()!=0){
//				result.setStudent((Student)studentList.get(0));
//			}
			if (std==null)
			{
				std=(Student)entityService.load(Student.class,getLong("std.id"));
			}
			result.setStudent(std);	
		} else {
			result = (BalanceCompareResult) results.get(0);
		}
		return result;
	}

	public String saveRemark() {
		Long experimentId = getLong("experiment.id");
		String remark = get("remark");
		String year = get("year");
		BalanceCompareResult result = getBalanceCompareResult();
		result.setRemark(remark);
		result.setYear(Integer.parseInt(year));
		entityService.saveOrUpdate(result);
		return redirect("index", "info.save.success", "&experiment.id=" + experimentId);
	}

	public String info() {
		index();
		return forward();
	}

	public String infolet() {
		index();
		return forward("../../infolet/info");
	}
}