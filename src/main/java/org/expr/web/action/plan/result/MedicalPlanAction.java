package org.expr.web.action.plan.result;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.analysis.FamilyMember;
import org.expr.model.analysis.result.FamilyMemberResult;
import org.expr.model.lesson.Experiment;
import org.expr.model.plan.result.MedicalPlanResult;
import org.expr.model.plan.result.MemberMedicalPlanResult;

import com.ekingstar.eams.student.Student;

/**
 * 医疗支出规划
 * 
 * @author Administrator
 * 
 */
public class MedicalPlanAction extends AbstractPlanResultAction {

	public String index() {
		Long experimentId = getLong("experiment.id");
		EntityQuery query = new EntityQuery(FamilyMemberResult.class, "memberResult");
		query.add(new Condition("memberResult.result.experiment.id=:experimentId", experimentId));
		//query.add(new Condition("memberResult.result.student.code=:stdCode", getLoginName()));
		addStdCondition(query,"memberResult.result",getLoginStudent());
		query.setSelect("memberResult.member");
		List<FamilyMember> members = entityService.search(query);
		put("members", members);
		query = new EntityQuery(MedicalPlanResult.class, "medicalPlan");
		query.add(new Condition("medicalPlan.experiment.id=:experimentId", experimentId));
		//query.add(new Condition("medicalPlan.student.code=:stdCode", getLoginName()));
		addStdCondition(query,"medicalPlan",getLoginStudent());		
		List<MedicalPlanResult> results = entityService.search(query);
		Map<String, Map> expenses = new HashMap();
		if (!results.isEmpty()) {
			MedicalPlanResult result = (MedicalPlanResult) results.get(0);
			for (MemberMedicalPlanResult memberResult : result.getMembers()) {
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
		MedicalPlanResult result = getMedicalPlanResult(experimentId);
		MemberMedicalPlanResult finded = null;
		for (MemberMedicalPlanResult memberResult : result.getMembers()) {
			if (memberResult.getName().equals(name)) {
				finded = memberResult;
				break;
			}
		}
		if (null == finded) {
			finded = new MemberMedicalPlanResult();
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

	private MedicalPlanResult getMedicalPlanResult(Long experimentId) {
		EntityQuery query = new EntityQuery(MedicalPlanResult.class, "medicalPlan");
		query.add(new Condition("medicalPlan.experiment.id=:experimentId", experimentId));
		//query.add(new Condition("medicalPlan.student.code=:stdCode", getLoginName()));
		Student std=getLoginStudent();
		addStdCondition(query,"medicalPlan",std);				
		List<MedicalPlanResult> results = entityService.search(query);
		MedicalPlanResult result = null;
		if (!results.isEmpty()) {
			result = results.get(0);
		} else {
			result = new MedicalPlanResult();
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
		MedicalPlanResult result = getMedicalPlanResult(experimentId);
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
