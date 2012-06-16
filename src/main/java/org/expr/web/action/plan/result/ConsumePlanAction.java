package org.expr.web.action.plan.result;

import java.util.List;

import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.lesson.Experiment;
import org.expr.model.plan.result.ConsumePlanResult;

import com.ekingstar.eams.student.Student;

/**
 *消费支出规划
 * 
 * @author Administrator
 * 
 */
public class ConsumePlanAction extends AbstractPlanResultAction {

	public String index() {
		Long experimentId = getLong("experiment.id");
		EntityQuery query = new EntityQuery(ConsumePlanResult.class, "consumePlan");
		query.add(new Condition("consumePlan.experiment.id=:experimentId", experimentId));
		//query.add(new Condition("consumePlan.student.code=:stdCode", getLoginName()));	
		addStdCondition(query, "consumePlan",getLoginStudent());
		List<ConsumePlanResult> results=entityService.search(query);
		ConsumePlanResult result=new ConsumePlanResult();
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
		ConsumePlanResult result = getConsumePlanResult(experimentId);
		int startYear = getInteger("startYear");
		int endYear = getInteger("endYear");
		Double consume = getFloat("consume").doubleValue();
		Float rate = getFloat("rate");
		Float amount = getFloat("amount");
		while (startYear <= endYear) {
			if (Double.compare(consume, 0F) <= 0) {
				result.getAmounts().remove(startYear);
			} else {
				result.getAmounts().put(startYear, consume);
			}
			consume = calcConsume(consume, rate, amount);
			startYear++;
		}
		entityService.saveOrUpdate(result);
		return redirect("index", "info.save.success", "&experiment.id=" + experimentId);
	}

	private ConsumePlanResult getConsumePlanResult(Long experimentId) {
		EntityQuery query = new EntityQuery(ConsumePlanResult.class, "consumePlan");
		query.add(new Condition("consumePlan.experiment.id=:experimentId", experimentId));
		//query.add(new Condition("consumePlan.student.code=:stdCode", getLoginName()));	
		Student std=getLoginStudent();
		addStdCondition(query, "consumePlan",std);		
		List<ConsumePlanResult> results = entityService.search(query);
		ConsumePlanResult result = null;
		if (!results.isEmpty()) {
			result = results.get(0);
		} else {
			result = new ConsumePlanResult();
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
		ConsumePlanResult result = getConsumePlanResult(experimentId);
		result.setRemark(remark);
		entityService.saveOrUpdate(result);
		return redirect("index", "info.save.success", "&experiment.id=" + experimentId);
	}
	private double calcConsume(Double consume, Float rate, Float amount) {
		if (null == rate) {
			return consume + amount;
		} else {
			return rate * consume + consume;
		}
	}
}
