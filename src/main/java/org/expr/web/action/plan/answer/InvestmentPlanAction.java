package org.expr.web.action.plan.answer;

import java.util.List;

import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.Caze;
import org.expr.model.plan.answer.InvestmentPlanAnswer;

/**
 *金融投资规划
 * 
 * @author Administrator
 * 
 */
public class InvestmentPlanAction extends AbstractPlanAnswerAction {

	public String index() {
		Long cazeId = getLong("caze.id");
		EntityQuery query = new EntityQuery(InvestmentPlanAnswer.class, "investmentPlan");
		query.add(new Condition("investmentPlan.caze.id=:cazeId", cazeId));
		List<InvestmentPlanAnswer> answers=entityService.search(query);
		InvestmentPlanAnswer answer=new InvestmentPlanAnswer();
		if (!answers.isEmpty()){
			answer=answers.get(0);
		}
		put("amount",answer.getExpenses());
		put("answer",answer);
		return forward();
	}

	public String edit() {
		Long cazeId = getLong("caze.id");
		return forward();
	}

	@Override
	public String save() {
		Long cazeId = getLong("caze.id");
		InvestmentPlanAnswer answer = getInvestmentPlanAnswer(cazeId);
		int startYear = getInteger("startYear");
		int endYear = getInteger("endYear");
		Double expense = getFloat("expense").doubleValue();
		Float rate = getFloat("rate");
		Float amount = getFloat("amount");
		while (startYear <= endYear) {
			if (Double.compare(expense, 0F) <= 0) {
				answer.getExpenses().remove(startYear);
			} else {
				answer.getExpenses().put(startYear, expense);
			}
			expense = calcExpense(expense, rate, amount);
			startYear++;
		}
		entityService.saveOrUpdate(answer);
		return redirect("index", "info.save.success", "&caze.id=" + cazeId);
	}

	private InvestmentPlanAnswer getInvestmentPlanAnswer(Long cazeId) {
		EntityQuery query = new EntityQuery(InvestmentPlanAnswer.class, "investmentPlan");
		query.add(new Condition("investmentPlan.caze.id=:cazeId", cazeId));
		List<InvestmentPlanAnswer> answers = entityService.search(query);
		InvestmentPlanAnswer answer = null;
		if (!answers.isEmpty()) {
			answer = answers.get(0);
		} else {
			answer = new InvestmentPlanAnswer();
			answer.setCaze((Caze) entityService.get(Caze.class, cazeId));
			entityService.saveOrUpdate(answer);
		}
		return answer;
	}



	public String saveRemark(){
		Long cazeId = getLong("caze.id");
		String remark = get("remark");
		InvestmentPlanAnswer answer = getInvestmentPlanAnswer(cazeId);
		answer.setRemark(remark);
		entityService.saveOrUpdate(answer);
		return redirect("index", "info.save.success", "&caze.id=" + cazeId);
	}
	private double calcExpense(Double expense, Float rate, Float amount) {
		if (null == rate) {
			return expense + amount;
		} else {
			return rate * expense + expense;
		}
	}
	
	public String info() {
		index();
		return forward();
	}
	
}
