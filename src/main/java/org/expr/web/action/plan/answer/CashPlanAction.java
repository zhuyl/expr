package org.expr.web.action.plan.answer;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.Caze;
import org.expr.model.analysis.FamilyMember;
import org.expr.model.analysis.answer.FamilyMemberAnswer;
import org.expr.model.plan.answer.CashPlanAnswer;
import org.expr.model.plan.answer.MemberCashPlanAnswer;

/**
 * 工资收入规划
 * 
 * @author Administrator
 * 
 */
public class CashPlanAction extends AbstractPlanAnswerAction {

	public String index() {
		Long cazeId = getLong("caze.id");
		EntityQuery query = new EntityQuery(FamilyMemberAnswer.class, "memberAnswer");
		query.add(new Condition("memberAnswer.answer.caze.id=:cazeId", cazeId));
		query.setSelect("memberAnswer.member");
		List<FamilyMember> members = entityService.search(query);
		put("members", members);
		query = new EntityQuery(CashPlanAnswer.class, "cashPlan");
		query.add(new Condition("cashPlan.caze.id=:cazeId", cazeId));
		List<CashPlanAnswer> answers = entityService.search(query);
		Map<String, Map<Integer, Double>> salaries = new HashMap();
		if (!answers.isEmpty()) {
			CashPlanAnswer answer = (CashPlanAnswer) answers.get(0);
			for (MemberCashPlanAnswer memberAnswer : answer.getMembers()) {
				salaries.put(memberAnswer.getName(), memberAnswer.getSalaries());
			}
			put("answer", answer);
		}
		put("salaries", salaries);
		return forward();
	}

	public String edit() {
		Long cazeId = getLong("caze.id");
		String name = get("name");
		EntityQuery query = new EntityQuery(FamilyMemberAnswer.class, "memberAnswer");
		query.add(new Condition("memberAnswer.answer.caze.id=:cazeId", cazeId));
		query.add(new Condition("memberAnswer.member.name=:name", name));
		query.setSelect("memberAnswer.member");
		List<FamilyMember> members = entityService.search(query);
		put("member", members.get(0));
		return forward();
	}

	@Override
	public String save() {
		Long cazeId = getLong("caze.id");
		String name = get("name");
		CashPlanAnswer answer = getCashPlanAnswer(cazeId);
		MemberCashPlanAnswer finded = null;
		for (MemberCashPlanAnswer memberAnswer : answer.getMembers()) {
			if (memberAnswer.getName().equals(name)) {
				finded = memberAnswer;
				break;
			}
		}
		if (null == finded) {
			finded = new MemberCashPlanAnswer();
			finded.setAnswer(answer);
			finded.setName(name);
			answer.getMembers().add(finded);
		}
		int startYear = getInteger("startYear");
		int endYear = getInteger("endYear");
		Double salary = getFloat("salary").doubleValue();
		Float rate = getFloat("rate");
		Float amount = getFloat("amount");
		while (startYear <= endYear) {
			if (Double.compare(salary, 0F) <= 0) {
				finded.getSalaries().remove(startYear);
			} else {
				finded.getSalaries().put(startYear, salary);
			}
			salary = calcSalary(salary, rate, amount);
			startYear++;
		}
		entityService.saveOrUpdate(answer);
		return redirect("index", "info.save.success", "&caze.id=" + cazeId);
	}

	private CashPlanAnswer getCashPlanAnswer(Long cazeId) {
		EntityQuery query = new EntityQuery(CashPlanAnswer.class, "cashPlan");
		query.add(new Condition("cashPlan.caze.id=:cazeId", cazeId));
		List<CashPlanAnswer> answers = entityService.search(query);
		CashPlanAnswer answer = null;
		if (!answers.isEmpty()) {
			answer = answers.get(0);
		} else {
			answer = new CashPlanAnswer();
			answer.setCaze((Caze) entityService.get(Caze.class, cazeId));
			entityService.saveOrUpdate(answer);
		}
		return answer;
	}

	public String saveRemark() {
		Long cazeId = getLong("caze.id");
		String remark = get("remark");
		CashPlanAnswer answer = getCashPlanAnswer(cazeId);
		answer.setRemark(remark);
		entityService.saveOrUpdate(answer);
		return redirect("index", "info.save.success", "&caze.id=" + cazeId);
	}

	private double calcSalary(Double salary, Float rate, Float amount) {
		if (null == rate) {
			return salary + amount;
		} else {
			return rate * salary + salary;
		}
	}
	
	public String info() {
		index();
		return forward();
	}
	
}
