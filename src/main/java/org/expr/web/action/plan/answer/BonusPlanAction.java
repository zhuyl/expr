package org.expr.web.action.plan.answer;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.Caze;
import org.expr.model.analysis.FamilyMember;
import org.expr.model.analysis.answer.FamilyMemberAnswer;
import org.expr.model.plan.answer.BonusPlanAnswer;
import org.expr.model.plan.answer.MemberBonusPlanAnswer;

/**
 * 奖金收入规划
 * 
 * @author Administrator
 * 
 */
public class BonusPlanAction extends AbstractPlanAnswerAction {

	public String index() {
		Long cazeId = getLong("caze.id");
		EntityQuery query = new EntityQuery(FamilyMemberAnswer.class, "memberAnswer");
		query.add(new Condition("memberAnswer.answer.caze.id=:cazeId", cazeId));
		query.setSelect("memberAnswer.member");
		List<FamilyMember> members = entityService.search(query);
		put("members", members);
		query = new EntityQuery(BonusPlanAnswer.class, "bonusPlan");
		query.add(new Condition("bonusPlan.caze.id=:cazeId", cazeId));
		List<BonusPlanAnswer> answers = entityService.search(query);
		Map<String, Map<Integer, Double>> bonuses = new HashMap();
		if (!answers.isEmpty()) {
			BonusPlanAnswer answer = (BonusPlanAnswer) answers.get(0);
			for (MemberBonusPlanAnswer memberAnswer : answer.getMembers()) {
				bonuses.put(memberAnswer.getName(), memberAnswer.getBonuses());
			}
			put("answer", answer);
		}
		put("bonuses", bonuses);
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
		BonusPlanAnswer answer = getBonusPlanAnswer(cazeId);
		MemberBonusPlanAnswer finded = null;
		for (MemberBonusPlanAnswer memberAnswer : answer.getMembers()) {
			if (memberAnswer.getName().equals(name)) {
				finded = memberAnswer;
				break;
			}
		}
		if (null == finded) {
			finded = new MemberBonusPlanAnswer();
			finded.setAnswer(answer);
			finded.setName(name);
			answer.getMembers().add(finded);
		}
		int startYear = getInteger("startYear");
		int endYear = getInteger("endYear");
		Double bonus = getFloat("bonus").doubleValue();
		Float rate = getFloat("rate");
		Float amount = getFloat("amount");
		while (startYear <= endYear) {
			if (Double.compare(bonus, 0F) <= 0) {
				finded.getBonuses().remove(startYear);
			} else {
				finded.getBonuses().put(startYear, bonus);
			}
			bonus = calcSalary(bonus, rate, amount);
			startYear++;
		}
		entityService.saveOrUpdate(answer);
		return redirect("index", "info.save.success", "&caze.id=" + cazeId);
	}

	private BonusPlanAnswer getBonusPlanAnswer(Long cazeId) {
		EntityQuery query = new EntityQuery(BonusPlanAnswer.class, "bonusPlan");
		query.add(new Condition("bonusPlan.caze.id=:cazeId", cazeId));
		List<BonusPlanAnswer> answers = entityService.search(query);
		BonusPlanAnswer answer = null;
		if (!answers.isEmpty()) {
			answer = answers.get(0);
		} else {
			answer = new BonusPlanAnswer();
			answer.setCaze((Caze) entityService.get(Caze.class, cazeId));
			entityService.saveOrUpdate(answer);
		}
		return answer;
	}

	public String saveRemark() {
		Long cazeId = getLong("caze.id");
		String remark = get("remark");
		BonusPlanAnswer answer = getBonusPlanAnswer(cazeId);
		answer.setRemark(remark);
		entityService.saveOrUpdate(answer);
		return redirect("index", "info.save.success", "&caze.id=" + cazeId);
	}

	private double calcSalary(Double bonus, Float rate, Float amount) {
		if (null == rate) {
			return bonus + amount;
		} else {
			return rate * bonus + bonus;
		}
	}
	
	public String info() {
		index();
		return forward();
	}
	
}
