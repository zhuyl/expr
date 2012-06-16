package org.expr.web.action.plan.result;

import java.util.List;

import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.lesson.Experiment;
import org.expr.model.plan.result.OtherExpensePlanResult;

import com.ekingstar.eams.student.Student;

/**
 *其他支出规划
 * 
 * @author Administrator
 * 
 */
public class OtherExpensePlanAction extends AbstractPlanResultAction {

	public String index() {
		Long experimentId = getLong("experiment.id");
		EntityQuery query = new EntityQuery(OtherExpensePlanResult.class, "otherexpensePlan");
		query.add(new Condition("otherexpensePlan.experiment.id=:experimentId", experimentId));
		//query.add(new Condition("otherexpensePlan.student.code=:stdCode", getLoginName()));	
		addStdCondition(query, "otherexpensePlan",getLoginStudent());		
		List<OtherExpensePlanResult> results=entityService.search(query);
		OtherExpensePlanResult result=new OtherExpensePlanResult();
		if (!results.isEmpty()){
			result=results.get(0);
		}
		put("amount",result.getAmounts());
		put("result",result);
		return forward();
	}

	public String edit() {
		Long experimentId = getLong("experiment.id");
		return forward();
	}

	@Override
	public String save() {
		Long experimentId = getLong("experiment.id");
		OtherExpensePlanResult result = getOtherExpensePlanResult(experimentId);
		int startYear = getInteger("startYear");
		int endYear = getInteger("endYear");
		Double expense = getFloat("expense").doubleValue();
		Float rate = getFloat("rate");
		Float amount = getFloat("amount");
		while (startYear <= endYear) {
			if (Double.compare(expense, 0F) <= 0) {
				result.getAmounts().remove(startYear);
			} else {
				result.getAmounts().put(startYear, expense);
			}
			expense = calcOtherExpense(expense, rate, amount);
			startYear++;
		}
		entityService.saveOrUpdate(result);
		return redirect("index", "info.save.success", "&experiment.id=" + experimentId);
	}

	private OtherExpensePlanResult getOtherExpensePlanResult(Long experimentId) {
		EntityQuery query = new EntityQuery(OtherExpensePlanResult.class, "otherexpensePlan");
		query.add(new Condition("otherexpensePlan.experiment.id=:experimentId", experimentId));
		//query.add(new Condition("otherexpensePlan.student.code=:stdCode", getLoginName()));
		Student std=getLoginStudent();
		addStdCondition(query, "otherexpensePlan",std);
		List<OtherExpensePlanResult> results = entityService.search(query);
		OtherExpensePlanResult result = null;
		if (!results.isEmpty()) {
			result = results.get(0);
		} else {
			result = new OtherExpensePlanResult();
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
		OtherExpensePlanResult result = getOtherExpensePlanResult(experimentId);
		result.setRemark(remark);
		entityService.saveOrUpdate(result);
		return redirect("index", "info.save.success", "&experiment.id=" + experimentId);
	}
	private double calcOtherExpense(Double expense, Float rate, Float amount) {
		if (null == rate) {
			return expense + amount;
		} else {
			return rate * expense + expense;
		}
	}
}
