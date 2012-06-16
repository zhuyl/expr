package org.expr.web.action.plan.result;

import java.util.List;

import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.lesson.Experiment;
import org.expr.model.plan.result.TripPlanResult;

import com.ekingstar.eams.student.Student;

/**
 *旅游支出规划
 * 
 * @author Administrator
 * 
 */
public class TripPlanAction extends AbstractPlanResultAction {

	public String index() {
		Long experimentId = getLong("experiment.id");
		EntityQuery query = new EntityQuery(TripPlanResult.class, "tripPlan");
		query.add(new Condition("tripPlan.experiment.id=:experimentId", experimentId));
		//query.add(new Condition("tripPlan.student.code=:stdCode", getLoginName()));			
		addStdCondition(query, "tripPlan",getLoginStudent());
		List<TripPlanResult> results=entityService.search(query);
		TripPlanResult result=new TripPlanResult();
		if (!results.isEmpty()){
			result=results.get(0);
		}
		put("amount",result.getExpenses());
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
		TripPlanResult result = getTripPlanResult(experimentId);
		int startYear = getInteger("startYear");
		int endYear = getInteger("endYear");
		Double expense = getFloat("expense").doubleValue();
		Float rate = getFloat("rate");
		Float amount = getFloat("amount");
		while (startYear <= endYear) {
			if (Double.compare(expense, 0F) <= 0) {
				result.getExpenses().remove(startYear);
			} else {
				result.getExpenses().put(startYear, expense);
			}
			expense = calcExpense(expense, rate, amount);
			startYear++;
		}
		entityService.saveOrUpdate(result);
		return redirect("index", "info.save.success", "&experiment.id=" + experimentId);
	}

	private TripPlanResult getTripPlanResult(Long experimentId) {
		EntityQuery query = new EntityQuery(TripPlanResult.class, "tripPlan");
		query.add(new Condition("tripPlan.experiment.id=:experimentId", experimentId));
		//query.add(new Condition("tripPlan.student.code=:stdCode", getLoginName()));	
		Student std=getLoginStudent();
		addStdCondition(query, "tripPlan",std);
		List<TripPlanResult> results = entityService.search(query);
		TripPlanResult result = null;
		if (!results.isEmpty()) {
			result = results.get(0);
		} else {
			result = new TripPlanResult();
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
		TripPlanResult result = getTripPlanResult(experimentId);
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
