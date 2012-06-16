package org.expr.web.action.plan.answer;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.Caze;
import org.expr.model.analysis.FamilyMember;
import org.expr.model.analysis.answer.FamilyMemberAnswer;
import org.expr.model.plan.answer.EducationPlanAnswer;
import org.expr.model.plan.answer.MemberEducationPlanAnswer;

/**
 * 教育支出规划
 * 
 * @author Administrator
 * 
 */
public class EducationPlanAction extends AbstractPlanAnswerAction {

	public String index() {
		Long cazeId = getLong("caze.id");
		EntityQuery query = new EntityQuery(FamilyMemberAnswer.class, "memberAnswer");
		query.add(new Condition("memberAnswer.answer.caze.id=:cazeId", cazeId));
		query.setSelect("memberAnswer.member");
		List<FamilyMember> members = entityService.search(query);
		put("members", members);
		query = new EntityQuery(EducationPlanAnswer.class, "educationPlan");
		query.add(new Condition("educationPlan.caze.id=:cazeId", cazeId));
		List<EducationPlanAnswer> answers = entityService.search(query);
		Map<String, Map> expenses = new HashMap();
		if (!answers.isEmpty()) {
			EducationPlanAnswer answer = (EducationPlanAnswer) answers.get(0);
			for (MemberEducationPlanAnswer memberAnswer : answer.getMembers()) {
				expenses.put(memberAnswer.getName(), memberAnswer.getExpenses());
			}
			put("answer", answer);
		}
		put("expenses", expenses);
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
		EducationPlanAnswer answer = getEducationPlanAnswer(cazeId);
		MemberEducationPlanAnswer finded = null;
		for (MemberEducationPlanAnswer memberAnswer : answer.getMembers()) {
			if (memberAnswer.getName().equals(name)) {
				finded = memberAnswer;
				break;
			}
		}
		if (null == finded) {
			finded = new MemberEducationPlanAnswer();
			finded.setAnswer(answer);
			finded.setName(name);
			answer.getMembers().add(finded);
		}
		int startYear = getInteger("startYear");
		int endYear = getInteger("endYear");
		Double expense = getFloat("expense").doubleValue();
		Float rate = getFloat("rate");
		Float amount = getFloat("amount");
		while (startYear <= endYear) {
			if (Double.compare(expense, 0F) <= 0) {
				finded.getExpenses().remove(startYear);
			} else {
				finded.getExpenses().put(startYear, expense);
			}
			expense = calcExpense(expense, rate, amount);
			startYear++;
		}
		entityService.saveOrUpdate(answer);
		return redirect("index", "info.save.success", "&caze.id=" + cazeId);
	}

	private EducationPlanAnswer getEducationPlanAnswer(Long cazeId) {
		EntityQuery query = new EntityQuery(EducationPlanAnswer.class, "eductionPlan");
		query.add(new Condition("eductionPlan.caze.id=:cazeId", cazeId));
		List<EducationPlanAnswer> answers = entityService.search(query);
		EducationPlanAnswer answer = null;
		if (!answers.isEmpty()) {
			answer = answers.get(0);
		} else {
			answer = new EducationPlanAnswer();
			answer.setCaze((Caze) entityService.get(Caze.class, cazeId));
			entityService.saveOrUpdate(answer);
		}
		return answer;
	}

	public String saveRemark(){
		Long cazeId = getLong("caze.id");
		String remark = get("remark");
		EducationPlanAnswer answer = getEducationPlanAnswer(cazeId);
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
