package org.expr.web.action.plan.result;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.analysis.FamilyMember;
import org.expr.model.analysis.result.FamilyMemberResult;
import org.expr.model.lesson.Experiment;
import org.expr.model.plan.result.BonusPlanResult;
import org.expr.model.plan.result.MemberBonusPlanResult;

import com.ekingstar.eams.student.Student;

/**
 * 奖金收入规划
 * 
 * @author Administrator
 * 
 */
public class BonusPlanAction extends AbstractPlanResultAction {

	public String index() {
		Long experimentId = getLong("experiment.id");
		EntityQuery query = new EntityQuery(FamilyMemberResult.class, "memberResult");
		query.add(new Condition("memberResult.result.experiment.id=:experimentId", experimentId));
		Student std= getLoginStudent();
		addStdCondition(query, "memberResult.result",std);
		query.setSelect("memberResult.member");
		List<FamilyMember> members = entityService.search(query);
		put("members", members);
		query = new EntityQuery(BonusPlanResult.class, "bonusPlan");
		query.add(new Condition("bonusPlan.experiment.id=:experimentId", experimentId));
		addStdCondition(query, "bonusPlan",std);
		List<BonusPlanResult> results = entityService.search(query);
		Map<String, Map<Integer, Double>> bonuses = new HashMap();
		if (!results.isEmpty()) {
			BonusPlanResult result = (BonusPlanResult) results.get(0);
			for (MemberBonusPlanResult memberResult : result.getMembers()) {
				bonuses.put(memberResult.getName(), memberResult.getBonuses());
			}
			put("result", result);
		}
		put("bonuses", bonuses);
		return forward();
	}

	public String edit() {
		Long experimentId = getLong("experiment.id");
		String name = get("name");
		EntityQuery query = new EntityQuery(FamilyMemberResult.class, "memberResult");
		query.add(new Condition("memberResult.result.experiment.id=:experimentId", experimentId));
		addStdCondition(query, "memberResult.result",getLoginStudent());
		query.add(new Condition("memberResult.member.name=:name", name));
		query.setSelect("memberResult.member");
		List<FamilyMember> members = entityService.search(query);
		put("member", members.get(0));
		return forward();
	}

	@Override
	public String save() {
		Long experimentId = getLong("experiment.id");
		String name = get("name");
		BonusPlanResult result = getBonusPlanResult(experimentId);
		MemberBonusPlanResult finded = null;
		for (MemberBonusPlanResult memberResult : result.getMembers()) {
			if (memberResult.getName().equals(name)) {
				finded = memberResult;
				break;
			}
		}
		if (null == finded) {
			finded = new MemberBonusPlanResult();
			finded.setResult(result);
			finded.setName(name);
			result.getMembers().add(finded);
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
		entityService.saveOrUpdate(result);
		return redirect("index", "info.save.success", "&experiment.id=" + experimentId);
	}

	private BonusPlanResult getBonusPlanResult(Long experimentId) {
		EntityQuery query = new EntityQuery(BonusPlanResult.class, "bonusPlan");
		query.add(new Condition("bonusPlan.experiment.id=:experimentId", experimentId));
		//query.add(new Condition("bonusPlan.student.code=:stdCode", getLoginName()));
		Student std=getLoginStudent();
		addStdCondition(query, "bonusPlan",std);
		List<BonusPlanResult> results = entityService.search(query);
		BonusPlanResult result = null;
		if (!results.isEmpty()) {
			result = results.get(0);
		} else {
			result = new BonusPlanResult();
			result.setExperiment((Experiment) entityService.get(Experiment.class, experimentId));
//			List studentList = (List)entityService.load(Student.class,"code",getLoginName());
//			if (null != studentList && studentList.size()!=0){
//				result.setStudent((Student)studentList.get(0));
//			}
			if (std==null)
			{
				std=(Student)entityService.load(Student.class,getLong("std.id"));
			}
			result.setStudent(std);	
			entityService.saveOrUpdate(result);
		}
		return result;
	}

	public String saveRemark() {
		Long experimentId = getLong("experiment.id");
		String remark = get("remark");
		BonusPlanResult result = getBonusPlanResult(experimentId);
		result.setRemark(remark);
		entityService.saveOrUpdate(result);
		return redirect("index", "info.save.success", "&experiment.id=" + experimentId);
	}

	private double calcSalary(Double bonus, Float rate, Float amount) {
		if (null == rate) {
			return bonus + amount;
		} else {
			return rate * bonus + bonus;
		}
	}
}
