package org.expr.web.action.plan.result;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.analysis.FamilyMember;
import org.expr.model.analysis.result.FamilyMemberResult;
import org.expr.model.lesson.Experiment;
import org.expr.model.plan.result.CashPlanResult;
import org.expr.model.plan.result.MemberCashPlanResult;

import com.ekingstar.eams.student.Student;

/**
 * 工资收入规划
 * 
 * @author Administrator
 * 
 */
public class CashPlanAction extends AbstractPlanResultAction {

	public String index() {
		Long experimentid = getLong("experiment.id");
		EntityQuery query = new EntityQuery(FamilyMemberResult.class, "memberResult");
		query.add(new Condition("memberResult.result.experiment.id=:experimentid", experimentid));
		//query.add(new Condition("memberResult.result.student.code=:stdCode", getLoginName()));
		addStdCondition(query, "memberResult.result",getLoginStudent());
		query.setSelect("memberResult.member");
		List<FamilyMember> members = entityService.search(query);
		put("members", members);
		
		query = new EntityQuery(CashPlanResult.class, "cashPlan");
		query.add(new Condition("cashPlan.experiment.id=:experimentId", experimentid));
		//query.add(new Condition("cashPlan.student.code=:stdCode", getLoginName()));		
		addStdCondition(query, "cashPlan",getLoginStudent());
		List<CashPlanResult> results = entityService.search(query);
		Map<String, Map<Integer, Double>> salaries = new HashMap();
		if (!results.isEmpty()) {
			CashPlanResult result = (CashPlanResult) results.get(0);
			for (MemberCashPlanResult memberResult : result.getMembers()) {
				salaries.put(memberResult.getName(), memberResult.getSalaries());
			}
			put("result", result);
		}
		put("salaries", salaries);
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
		CashPlanResult result = getCashPlanResult(experimentId);
		MemberCashPlanResult finded = null;
		for (MemberCashPlanResult memberResult : result.getMembers()) {
			if (memberResult.getName().equals(name)) {
				finded = memberResult;
				break;
			}
		}
		if (null == finded) {
			finded = new MemberCashPlanResult();
			finded.setResult(result);
			finded.setName(name);
			result.getMembers().add(finded);
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
				
		entityService.saveOrUpdate(result);
		return redirect("index", "info.save.success", "&experiment.id=" + experimentId);
	}

	private CashPlanResult getCashPlanResult(Long experimentId) {
		EntityQuery query = new EntityQuery(CashPlanResult.class, "cashPlan");
		query.add(new Condition("cashPlan.experiment.id=:experimentId", experimentId));
		//query.add(new Condition("cashPlan.student.code=:stdCode", getLoginName()));	
		Student std=getLoginStudent();
		addStdCondition(query, "cashPlan",std);		
		List<CashPlanResult> results = entityService.search(query);
		CashPlanResult result = null;
		if (!results.isEmpty()) {
			result = results.get(0);
		} else {
			result = new CashPlanResult();
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
		CashPlanResult result = getCashPlanResult(experimentId);
		result.setRemark(remark);
		entityService.saveOrUpdate(result);
		return redirect("index", "info.save.success", "&experiment.id=" + experimentId);
	}

	private double calcSalary(Double salary, Float rate, Float amount) {
		if (null == rate) {
			return salary + amount;
		} else {
			return rate * salary + salary;
		}
	}
}
