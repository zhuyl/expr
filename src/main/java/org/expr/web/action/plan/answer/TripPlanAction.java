package org.expr.web.action.plan.answer;

import java.util.List;

import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.Caze;
import org.expr.model.plan.answer.TripPlanAnswer;

/**
 *旅游支出规划
 * 
 * @author Administrator
 * 
 */
public class TripPlanAction extends AbstractPlanAnswerAction {

	public String index() {
		Long cazeId = getLong("caze.id");
		EntityQuery query = new EntityQuery(TripPlanAnswer.class, "tripPlan");
		query.add(new Condition("tripPlan.caze.id=:cazeId", cazeId));
		List<TripPlanAnswer> answers=entityService.search(query);
		TripPlanAnswer answer=new TripPlanAnswer();
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
		TripPlanAnswer answer = getTripPlanAnswer(cazeId);
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

	private TripPlanAnswer getTripPlanAnswer(Long cazeId) {
		EntityQuery query = new EntityQuery(TripPlanAnswer.class, "tripPlan");
		query.add(new Condition("tripPlan.caze.id=:cazeId", cazeId));
		List<TripPlanAnswer> answers = entityService.search(query);
		TripPlanAnswer answer = null;
		if (!answers.isEmpty()) {
			answer = answers.get(0);
		} else {
			answer = new TripPlanAnswer();
			answer.setCaze((Caze) entityService.get(Caze.class, cazeId));
			entityService.saveOrUpdate(answer);
		}
		return answer;
	}



	public String saveRemark(){
		Long cazeId = getLong("caze.id");
		String remark = get("remark");
		TripPlanAnswer answer = getTripPlanAnswer(cazeId);
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
