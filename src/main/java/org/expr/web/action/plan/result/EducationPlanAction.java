package org.expr.web.action.plan.result;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.analysis.FamilyMember;
import org.expr.model.analysis.result.FamilyMemberResult;
import org.expr.model.lesson.Experiment;
import org.expr.model.plan.result.EducationPlanResult;
import org.expr.model.plan.result.MemberEducationPlanResult;

import com.ekingstar.eams.student.Student;

/**
 * 教育支出规划
 * 
 * @author Administrator
 * 
 */
public class EducationPlanAction extends AbstractPlanResultAction {

	public String index() {
		Long experimentId = getLong("experiment.id");
		EntityQuery query = new EntityQuery(FamilyMemberResult.class, "memberResult");
		query.add(new Condition("memberResult.result.experiment.id=:experimentId", experimentId));
		//query.add(new Condition("memberResult.result.student.code=:stdCode", getLoginName()));	
		addStdCondition(query, "memberResult.result",getLoginStudent());
		query.setSelect("memberResult.member");
		List<FamilyMember> members = entityService.search(query);
		put("members", members);
		query = new EntityQuery(EducationPlanResult.class, "educationPlan");
		query.add(new Condition("educationPlan.experiment.id=:experimentId", experimentId));
		//query.add(new Condition("educationPlan.student.code=:stdCode", getLoginName()));	
		addStdCondition(query, "educationPlan",getLoginStudent());
		List<EducationPlanResult> results = entityService.search(query);
		Map<String, Map> expenses = new HashMap();
		if (!results.isEmpty()) {
			EducationPlanResult result = (EducationPlanResult) results.get(0);
			for (MemberEducationPlanResult memberResult : result.getMembers()) {
				expenses.put(memberResult.getName(), memberResult.getExpenses());
			}
			put("result", result);
		}
		put("expenses", expenses);
		return forward();
	}

	public String edit() {
		Long experimentId = getLong("experiment.id");
		String name = get("name");
		EntityQuery query = new EntityQuery(FamilyMemberResult.class, "memberResult");
		query.add(new Condition("memberResult.result.experiment.id=:experimentId", experimentId));
		query.add(new Condition("memberResult.result.student.code=:stdCode", getLoginName()));			
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
		EducationPlanResult result = getEducationPlanResult(experimentId);
		MemberEducationPlanResult finded = null;
		for (MemberEducationPlanResult memberResult : result.getMembers()) {
			if (memberResult.getName().equals(name)) {
				finded = memberResult;
				break;
			}
		}
		if (null == finded) {
			finded = new MemberEducationPlanResult();
			finded.setResult(result);
			finded.setName(name);
			result.getMembers().add(finded);
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
		entityService.saveOrUpdate(result);
		return redirect("index", "info.save.success", "&experiment.id=" + experimentId);
	}

	private EducationPlanResult getEducationPlanResult(Long experimentId) {
		EntityQuery query = new EntityQuery(EducationPlanResult.class, "eductionPlan");
		query.add(new Condition("eductionPlan.experiment.id=:experimentId", experimentId));
		//query.add(new Condition("eductionPlan.student.code=:stdCode", getLoginName()));	
		Student std=getLoginStudent();
		addStdCondition(query, "eductionPlan",std);
		List<EducationPlanResult> results = entityService.search(query);
		EducationPlanResult result = null;
		if (!results.isEmpty()) {
			result = results.get(0);
		} else {
			result = new EducationPlanResult();
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

	public String saveRemark(){
		Long experimentId = getLong("experiment.id");
		String remark = get("remark");
		EducationPlanResult result = getEducationPlanResult(experimentId);
		result.setRemark(remark);
		entityService.saveOrUpdate(result);
		return redirect("index", "info.save.success", "&experiment.id=" + experimentId);
	}
	private double calcExpense(Double expense, Float rate, Float amount) {
		if (null == rate) {
			return expense + amount;
		} else {
			return rate * expense + expense;
		}
	}
}
