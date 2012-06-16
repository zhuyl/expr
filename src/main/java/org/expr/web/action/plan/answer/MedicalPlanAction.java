package org.expr.web.action.plan.answer;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.Caze;
import org.expr.model.analysis.FamilyMember;
import org.expr.model.analysis.answer.FamilyMemberAnswer;
import org.expr.model.plan.answer.MedicalPlanAnswer;
import org.expr.model.plan.answer.MemberMedicalPlanAnswer;

/**
 * 医疗支出规划
 * 
 * @author Administrator
 * 
 */
public class MedicalPlanAction extends AbstractPlanAnswerAction {

	public String index() {
		Long cazeId = getLong("caze.id");
		EntityQuery query = new EntityQuery(FamilyMemberAnswer.class, "memberAnswer");
		query.add(new Condition("memberAnswer.answer.caze.id=:cazeId", cazeId));
		query.setSelect("memberAnswer.member");
		List<FamilyMember> members = entityService.search(query);
		put("members", members);
		query = new EntityQuery(MedicalPlanAnswer.class, "medicalPlan");
		query.add(new Condition("medicalPlan.caze.id=:cazeId", cazeId));
		List<MedicalPlanAnswer> answers = entityService.search(query);
		Map<String, Map> expenses = new HashMap();
		if (!answers.isEmpty()) {
			MedicalPlanAnswer answer = (MedicalPlanAnswer) answers.get(0);
			for (MemberMedicalPlanAnswer memberAnswer : answer.getMembers()) {
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
		MedicalPlanAnswer answer = getMedicalPlanAnswer(cazeId);
		MemberMedicalPlanAnswer finded = null;
		for (MemberMedicalPlanAnswer memberAnswer : answer.getMembers()) {
			if (memberAnswer.getName().equals(name)) {
				finded = memberAnswer;
				break;
			}
		}
		if (null == finded) {
			finded = new MemberMedicalPlanAnswer();
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

	private MedicalPlanAnswer getMedicalPlanAnswer(Long cazeId) {
		EntityQuery query = new EntityQuery(MedicalPlanAnswer.class, "medicalPlan");
		query.add(new Condition("medicalPlan.caze.id=:cazeId", cazeId));
		List<MedicalPlanAnswer> answers = entityService.search(query);
		MedicalPlanAnswer answer = null;
		if (!answers.isEmpty()) {
			answer = answers.get(0);
		} else {
			answer = new MedicalPlanAnswer();
			answer.setCaze((Caze) entityService.get(Caze.class, cazeId));
			entityService.saveOrUpdate(answer);
		}
		return answer;
	}

	public String saveRemark(){
		Long cazeId = getLong("caze.id");
		String remark = get("remark");
		MedicalPlanAnswer answer = getMedicalPlanAnswer(cazeId);
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
