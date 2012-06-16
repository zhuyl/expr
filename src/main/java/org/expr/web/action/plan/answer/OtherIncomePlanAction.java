package org.expr.web.action.plan.answer;

import java.util.List;

import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.Caze;
import org.expr.model.plan.answer.OtherIncomePlanAnswer;

/**
 *其他收入规划
 * 
 * @author Administrator
 * 
 */
public class OtherIncomePlanAction extends AbstractPlanAnswerAction {

	public String index() {
		Long cazeId = getLong("caze.id");
		EntityQuery query = new EntityQuery(OtherIncomePlanAnswer.class, "otherincomePlan");
		query.add(new Condition("otherincomePlan.caze.id=:cazeId", cazeId));
		List<OtherIncomePlanAnswer> answers=entityService.search(query);
		OtherIncomePlanAnswer answer=new OtherIncomePlanAnswer();
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
		OtherIncomePlanAnswer answer = getOtherIncomePlanAnswer(cazeId);
		int startYear = getInteger("startYear");
		int endYear = getInteger("endYear");
		Double income = getFloat("income").doubleValue();
		Float rate = getFloat("rate");
		Float amount = getFloat("amount");
		while (startYear <= endYear) {
			if (Double.compare(income, 0F) <= 0) {
				answer.getAmounts().remove(startYear);
			} else {
				answer.getAmounts().put(startYear, income);
			}
			income = calcOtherIncome(income, rate, amount);
			startYear++;
		}
		entityService.saveOrUpdate(answer);
		return redirect("index", "info.save.success", "&caze.id=" + cazeId);
	}

	private OtherIncomePlanAnswer getOtherIncomePlanAnswer(Long cazeId) {
		EntityQuery query = new EntityQuery(OtherIncomePlanAnswer.class, "otherincomePlan");
		query.add(new Condition("otherincomePlan.caze.id=:cazeId", cazeId));
		List<OtherIncomePlanAnswer> answers = entityService.search(query);
		OtherIncomePlanAnswer answer = null;
		if (!answers.isEmpty()) {
			answer = answers.get(0);
		} else {
			answer = new OtherIncomePlanAnswer();
			answer.setCaze((Caze) entityService.get(Caze.class, cazeId));
			entityService.saveOrUpdate(answer);
		}
		return answer;
	}



	public String saveRemark(){
		Long cazeId = getLong("caze.id");
		String remark = get("remark");
		OtherIncomePlanAnswer answer = getOtherIncomePlanAnswer(cazeId);
		answer.setRemark(remark);
		entityService.saveOrUpdate(answer);
		return redirect("index", "info.save.success", "&caze.id=" + cazeId);
	}
	private double calcOtherIncome(Double income, Float rate, Float amount) {
		if (null == rate) {
			return income + amount;
		} else {
			return rate * income + income;
		}
	}
	
	public String info() {
		index();
		return forward();
	}
	
}
