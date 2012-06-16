package org.expr.web.action.plan.answer;

import java.util.List;

import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.Caze;
import org.expr.model.plan.answer.ConsumePlanAnswer;

/**
 *消费支出规划
 * 
 * @author Administrator
 * 
 */
public class ConsumePlanAction extends AbstractPlanAnswerAction {

	public String index() {
		Long cazeId = getLong("caze.id");
		EntityQuery query = new EntityQuery(ConsumePlanAnswer.class, "consumePlan");
		query.add(new Condition("consumePlan.caze.id=:cazeId", cazeId));
		List<ConsumePlanAnswer> answers=entityService.search(query);
		ConsumePlanAnswer answer=new ConsumePlanAnswer();
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
		ConsumePlanAnswer answer = getConsumePlanAnswer(cazeId);
		int startYear = getInteger("startYear");
		int endYear = getInteger("endYear");
		Double consume = getFloat("consume").doubleValue();
		Float rate = getFloat("rate");
		Float amount = getFloat("amount");
		while (startYear <= endYear) {
			if (Double.compare(consume, 0F) <= 0) {
				answer.getAmounts().remove(startYear);
			} else {
				answer.getAmounts().put(startYear, consume);
			}
			consume = calcConsume(consume, rate, amount);
			startYear++;
		}
		entityService.saveOrUpdate(answer);
		return redirect("index", "info.save.success", "&caze.id=" + cazeId);
	}

	private ConsumePlanAnswer getConsumePlanAnswer(Long cazeId) {
		EntityQuery query = new EntityQuery(ConsumePlanAnswer.class, "consumePlan");
		query.add(new Condition("consumePlan.caze.id=:cazeId", cazeId));
		List<ConsumePlanAnswer> answers = entityService.search(query);
		ConsumePlanAnswer answer = null;
		if (!answers.isEmpty()) {
			answer = answers.get(0);
		} else {
			answer = new ConsumePlanAnswer();
			answer.setCaze((Caze) entityService.get(Caze.class, cazeId));
			entityService.saveOrUpdate(answer);
		}
		return answer;
	}



	public String saveRemark(){
		Long cazeId = getLong("caze.id");
		String remark = get("remark");
		ConsumePlanAnswer answer = getConsumePlanAnswer(cazeId);
		answer.setRemark(remark);
		entityService.saveOrUpdate(answer);
		return redirect("index", "info.save.success", "&caze.id=" + cazeId);
	}
	private double calcConsume(Double consume, Float rate, Float amount) {
		if (null == rate) {
			return consume + amount;
		} else {
			return rate * consume + consume;
		}
	}
	
	public String info() {
		index();
		return forward();
	}
	
}
