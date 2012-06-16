package org.expr.web.action.plan.helper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.expr.model.Caze;
import org.expr.model.plan.answer.FinancePlanAnswer;
import org.expr.web.action.plan.answer.AbstractPlanAnswerAction;

public class FinanceAssetPlanHelper extends AbstractPlanAnswerAction{

	public void calcCapitals(List<FinancePlanAnswer> financeanswers,Caze caze){

		double firstbalance = getFirstBalance(caze);

		Map<String, Map<Integer, Double>> capitals = new HashMap();
		Map<String, Map<Integer, Double>> expenses = new HashMap();
		/** 追加 */
		Map<String, Map<Integer, Double>> incomes = new HashMap();
		/** 收益 */

		Map<Integer, Double>[] expensearray = new Map[financeanswers.size()];
		Map<Integer, Double>[] capitalarray = new Map[financeanswers.size()];
		Map<Integer, Double>[] incomearray = new Map[financeanswers.size()];
		for (int i = 0; i < financeanswers.size(); i++) {
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
				for (int j = 0; j < financeanswers.size(); j++) {
					expense = 0d;
					capital = 0d;
					income = 0d;
					FinancePlanAnswer plananswer = financeanswers.get(j);
					if (plananswer.getStartYear() == 1) {
						expense = plananswer.getAppend().doubleValue() * firstbalance / 100d;
						capital = plananswer.getAmount();
						income = (capital + expense) * plananswer.getRate() / 100d;
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
				for (int p = 0; p < financeanswers.size(); p++) {
					if ((i > financeanswers.get(p).getStartYear())
							&& (i <= financeanswers.get(p).getEndYear() + 1)) {
						lastexpense = expensearray[p].get(i - 1) + lastexpense;
						lastincome = incomearray[p].get(i - 1) + lastincome;
					}
				}
				lastbalance = getYearCashes(caze, i - 1) + getYearBonuses(caze, i - 1)
						+ getYearOtherIncomes(caze, i - 1) + lastincome
						- getYearConsumes(caze, i - 1) - lastexpense
						- getYearEducations(caze, i - 1) - getYearTrips(caze, i - 1)
						- getYearMedicals(caze, i - 1) - getYearDeposits(caze, i - 1)
						- getYearInsurances(caze, i - 1) - getYearOtherExpenses(caze, i - 1);

				for (int j = 0; j < financeanswers.size(); j++) {
					expense = 0d;
					capital = 0d;
					income = 0d;
					FinancePlanAnswer plananswer = financeanswers.get(j);
					if ((plananswer.getStartYear() <= i) && (plananswer.getEndYear() >= i)) {
						if (plananswer.getStartYear() == i) {
							expense = plananswer.getAppend().doubleValue() * lastbalance / 100d;
							capital = plananswer.getAmount();
							income = (expense + capital) * plananswer.getRate() / 100d;
						} else {
							expense = plananswer.getAppend().doubleValue() * lastbalance / 100d;
							capital = expensearray[j].get(i - 1) + incomearray[j].get(i - 1)
									+ capitalarray[j].get(i - 1);
							income = (expense + capital) * plananswer.getRate() / 100d;
						}
					}
					expensearray[j].put(i, expense);
					capitalarray[j].put(i, capital);
					incomearray[j].put(i, income);
				}
			}
		}
		for (int i = 0; i < financeanswers.size(); i++) {
			capitals.put(financeanswers.get(i).getFinancetype().getName(), capitalarray[i]);
			expenses.put(financeanswers.get(i).getFinancetype().getName(), expensearray[i]);
			incomes.put(financeanswers.get(i).getFinancetype().getName(), incomearray[i]);
		}
		put("expenses", expenses);
		put("capitals", capitals);
		put("incomes", incomes);
	}
}
