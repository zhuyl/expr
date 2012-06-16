package org.expr.web.action.plan.result;

import java.util.List;

import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.lesson.Experiment;
import org.expr.model.plan.result.OtherIncomePlanResult;

import com.ekingstar.eams.student.Student;

/**
 *其他收入规划
 * 
 * @author Administrator
 * 
 */
public class OtherIncomePlanAction extends AbstractPlanResultAction {

	public String index() {
		Long experimentId = getLong("experiment.id");
		EntityQuery query = new EntityQuery(OtherIncomePlanResult.class, "otherincomePlan");
		query.add(new Condition("otherincomePlan.experiment.id=:experimentId", experimentId));
		//query.add(new Condition("otherincomePlan.student.code=:stdCode", getLoginName()));		
		addStdCondition(query, "otherincomePlan",getLoginStudent());
		List<OtherIncomePlanResult> results=entityService.search(query);
		OtherIncomePlanResult result=new OtherIncomePlanResult();
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
		OtherIncomePlanResult result = getOtherIncomePlanResult(experimentId);
		int startYear = getInteger("startYear");
		int endYear = getInteger("endYear");
		Double income = getFloat("income").doubleValue();
		Float rate = getFloat("rate");
		Float amount = getFloat("amount");
		while (startYear <= endYear) {
			if (Double.compare(income, 0F) <= 0) {
				result.getAmounts().remove(startYear);
			} else {
				result.getAmounts().put(startYear, income);
			}
			income = calcOtherIncome(income, rate, amount);
			startYear++;
		}
		entityService.saveOrUpdate(result);
		return redirect("index", "info.save.success", "&experiment.id=" + experimentId);
	}

	private OtherIncomePlanResult getOtherIncomePlanResult(Long experimentId) {
		EntityQuery query = new EntityQuery(OtherIncomePlanResult.class, "otherincomePlan");
		query.add(new Condition("otherincomePlan.experiment.id=:experimentId", experimentId));
		//query.add(new Condition("otherincomePlan.student.code=:stdCode", getLoginName()));
		Student std=getLoginStudent();
		addStdCondition(query, "otherincomePlan",std);
		List<OtherIncomePlanResult> results = entityService.search(query);
		OtherIncomePlanResult result = null;
		if (!results.isEmpty()) {
			result = results.get(0);
		} else {
			result = new OtherIncomePlanResult();			
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
		OtherIncomePlanResult result = getOtherIncomePlanResult(experimentId);
		result.setRemark(remark);
		entityService.saveOrUpdate(result);
		return redirect("index", "info.save.success", "&experiment.id=" + experimentId);
	}
	private double calcOtherIncome(Double income, Float rate, Float amount) {
		if (null == rate) {
			return income + amount;
		} else {
			return rate * income + income;
		}
	}
}
