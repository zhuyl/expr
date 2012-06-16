package org.expr.web.action.aim.result;

import java.util.List;

import org.beanfuse.model.Entity;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.aim.result.AimItemResult;
import org.expr.model.aim.result.AimResult;
import org.expr.model.basecode.AimType;
import org.expr.model.lesson.Experiment;

import com.ekingstar.eams.student.Student;

public class AimAnalysisAction extends AbstractAimResultAction {
	protected void addStdCondition(EntityQuery query,String prefix,Student std){
		if (null == std) {
			query.add(new Condition(prefix+".student.id=:stdId", getLong("std.id")));
		} else {
			query.add(new Condition(prefix+".student=:std", std));
		}
	}
	
	public String search() {
		Long experimentid = getLong("experiment.id");
		EntityQuery query = new EntityQuery(AimItemResult.class, "m");
		query.add(new Condition("m.result.experiment.id=:experimentId",experimentid));		
		addStdCondition(query, "m.result",getLoginStudent());
		query.setLimit(getPageLimit());
		AimResult analysisResult=getAimAnalysisResult();
		put("analysisResult",analysisResult);
		put("results", entityService.search(query));
		return forward();
	}
	public void editSetting(Entity entity) {
		put("aimTypes", entityService.search(new EntityQuery(AimType.class, "AimType")));
	}
	
	protected String saveAndForward(Entity entity) {
		AimItemResult itemResult = (AimItemResult) entity;
		if (itemResult.isVO()) {
			Long experimentid = getLong("experiment.id");
			EntityQuery query = new EntityQuery(AimResult.class, "result");
			query.add(new Condition("result.experiment.id=:experimentId",experimentid));
			query.add(new Condition("result.student.code=:stdCode", getLoginName()));	
			List results = entityService.search(query);
			
			AimResult result = null;
			if (results.isEmpty()) {
				result = new AimResult();
				result.setExperiment((Experiment) entityService.load(Experiment.class, experimentid));
				List studentList = (List)entityService.load(Student.class,"code",getLoginName());
				if (null != studentList && studentList.size()!=0){
					result.setStudent((Student)studentList.get(0));
				}				
				//result.setForm(new Aim());
			} else {
				result = (AimResult) results.get(0);
			}
			itemResult.setResult(result);
			//result.getForm().getItmes().add(itemResult);
			result.getItems().add(itemResult);
			entityService.saveOrUpdate(result);
		} else {
			entityService.saveOrUpdate(itemResult);
		}
		return redirect("search", "info.save.success");
	}
	
	private AimResult getAimAnalysisResult() {
		
		Long experimentid = getLong("experiment.id");
		EntityQuery query = new EntityQuery(AimResult.class, "result");
		query.add(new Condition("result.experiment.id=:experimentId",experimentid));
		Student std=getLoginStudent();
		//query.add(new Condition("result.student.code=:stdCode", getLoginName()));	
		addStdCondition(query,"result",getLoginStudent());	
		List results = entityService.search(query);
		AimResult result = null;
		if (results.isEmpty()) {
			result = new AimResult();
			result.setExperiment((Experiment) entityService.load(Experiment.class, experimentid));

			if (std==null)
			{
				std=(Student)entityService.load(Student.class,getLong("std.id"));
			}
			result.setStudent(std);
	
			entityService.saveOrUpdate(result);
		} else {
			result = (AimResult) results.get(0);
		}
		return result;
	}
	public String saveRemark(){
		Long experimentId = getLong("experiment.id");
		String remark = get("remark");
		AimResult result = getAimAnalysisResult();		
		result.setRemark(remark);
		entityService.saveOrUpdate(result);
		return redirect("search", "info.save.success", "&experiment.id=" + experimentId);
	}	
}