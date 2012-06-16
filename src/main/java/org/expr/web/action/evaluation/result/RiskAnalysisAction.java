package org.expr.web.action.evaluation.result;

import java.util.List;

import org.beanfuse.model.Entity;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.basecode.FinanceType;
import org.expr.model.evaluation.result.RiskItemResult;
import org.expr.model.evaluation.result.RiskResult;
import org.expr.model.lesson.Experiment;

import com.ekingstar.eams.student.Student;

public class RiskAnalysisAction extends AbstractEvaluationResultAction {
	public String search() {
		Long experimentid = getLong("experiment.id");
		EntityQuery query = new EntityQuery(RiskItemResult.class, "m");
		query.add(new Condition("m.result.experiment.id=:experimentId",experimentid));
		//query.add(new Condition("m.result.student.code=:stdCode", getLoginName()));	
		addStdCondition(query, "m.result",getLoginStudent());
		query.setLimit(getPageLimit());
		RiskResult analysisResult=getRiskAnalysisResult();
		put("analysisResult",analysisResult);
		put("results", entityService.search(query));
		return forward();
	}
	public void editSetting(Entity entity) {
		put("financeTypes", getTopFinanceTypes());
	}
	private List getTopFinanceTypes() {
		EntityQuery query = new EntityQuery(FinanceType.class, "financeType");
		query.add(new Condition("financeType.parent is null"));
		List financeTypes = entityService.search(query);
		return financeTypes;
	}
	
	protected String saveAndForward(Entity entity) {
		RiskItemResult itemResult = (RiskItemResult) entity;
		if (itemResult.isVO()) {
			Long experimentid = getLong("experiment.id");
			EntityQuery query = new EntityQuery(RiskResult.class, "result");
			query.add(new Condition("result.experiment.id=:experimentId",experimentid));
			query.add(new Condition("result.student.code=:stdCode", getLoginName()));				
			List results = entityService.search(query);
			RiskResult result = null;
			if (results.isEmpty()) {
				result = new RiskResult();
				result.setExperiment((Experiment) entityService.load(Experiment.class, experimentid));
				List studentList = (List)entityService.load(Student.class,"code",getLoginName());
				if (null != studentList && studentList.size()!=0){
					result.setStudent((Student)studentList.get(0));
				}
				//result.setForm(new Aim());
			} else {
				result = (RiskResult) results.get(0);
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
	
	private RiskResult getRiskAnalysisResult() {
		
		Long experimentid = getLong("experiment.id");
		EntityQuery query = new EntityQuery(RiskResult.class, "result");
		query.add(new Condition("result.experiment.id=:experimentId",experimentid));
		//query.add(new Condition("result.student.code=:stdCode", getLoginName()));	
		Student std=getLoginStudent();
		addStdCondition(query, "result",std);
		List results = entityService.search(query);
		
		RiskResult result = null;
		if (results.isEmpty()) {
			result = new RiskResult();
			result.setExperiment((Experiment) entityService.load(Experiment.class, experimentid));
//			List studentList = (List)entityService.load(Student.class,"code",getLoginName());
//			if (null != studentList && studentList.size()!=0){
//				result.setStudent((Student)studentList.get(0));
//			}
			if (std==null)
			{
				std=(Student)entityService.load(Student.class,getLong("std.id"));
			}
			result.setStudent(std);	
		} else {
			result = (RiskResult) results.get(0);
		}
		return result;
	}
	public String saveRemark(){
		Long experimentId = getLong("experiment.id");
		String remark = get("remark");
		RiskResult result = getRiskAnalysisResult();		
		result.setRemark(remark);
		entityService.saveOrUpdate(result);
		return redirect("search", "info.save.success", "&experiment.id=" + experimentId);
	}	
	
	public String info() {
		search();
		return forward();
	}
}