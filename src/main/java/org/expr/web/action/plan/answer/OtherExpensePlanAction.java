package org.expr.web.action.plan.answer;

import java.util.List;

import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.Caze;
import org.expr.model.plan.answer.OtherExpensePlanAnswer;

/**
 *其他支出规划
 * 
 * @author Administrator
 * 
 */
public class OtherExpensePlanAction extends AbstractPlanAnswerAction {

	public String index() {
		Long cazeId = getLong("caze.id");
		EntityQuery query = new EntityQuery(OtherExpensePlanAnswer.class, "otherexpensePlan");
		query.add(new Condition("otherexpensePlan.caze.id=:cazeId", cazeId));
		List<OtherExpensePlanAnswer> answers=entityService.search(query);
		OtherExpensePlanAnswer answer=new OtherExpensePlanAnswer();
		if (!answers.isEmpty()){
			answer=answers.get(0);
		}
		put("amount",answer.getAmounts());
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
		OtherExpensePlanAnswer answer = getOtherExpensePlanAnswer(cazeId);
		int startYear = getInteger("startYear");
		int endYear = getInteger("endYear");
		Double expense = getFloat("expense").doubleValue();
		Float rate = getFloat("rate");
		Float amount = getFloat("amount");
		while (startYear <= endYear) {
			if (Double.compare(expense, 0F) <= 0) {
				answer.getAmounts().remove(startYear);
			} else {
				answer.getAmounts().put(startYear, expense);
			}
			expense = calcOtherExpense(expense, rate, amount);
			startYear++;
		}
		entityService.saveOrUpdate(answer);
		return redirect("index", "info.save.success", "&caze.id=" + cazeId);
	}

	private OtherExpensePlanAnswer getOtherExpensePlanAnswer(Long cazeId) {
		EntityQuery query = new EntityQuery(OtherExpensePlanAnswer.class, "otherexpensePlan");
		query.add(new Condition("otherexpensePlan.caze.id=:cazeId", cazeId));
		List<OtherExpensePlanAnswer> answers = entityService.search(query);
		OtherExpensePlanAnswer answer = null;
		if (!answers.isEmpty()) {
			answer = answers.get(0);
		} else {
			answer = new OtherExpensePlanAnswer();
			answer.setCaze((Caze) entityService.get(Caze.class, cazeId));
			entityService.saveOrUpdate(answer);
		}
		return answer;
	}



	public String saveRemark(){
		Long cazeId = getLong("caze.id");
		String remark = get("remark");
		OtherExpensePlanAnswer answer = getOtherExpensePlanAnswer(cazeId);
		answer.setRemark(remark);
		entityService.saveOrUpdate(answer);
		return redirect("index", "info.save.success", "&caze.id=" + cazeId);
	}
	private double calcOtherExpense(Double expense, Float rate, Float amount) {
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
