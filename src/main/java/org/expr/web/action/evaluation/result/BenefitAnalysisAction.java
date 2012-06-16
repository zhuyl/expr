package org.expr.web.action.evaluation.result;

import java.util.List;

import org.beanfuse.model.Entity;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.basecode.FinanceType;
import org.expr.model.evaluation.result.BenefitItemResult;
import org.expr.model.evaluation.result.BenefitResult;
import org.expr.model.lesson.Experiment;

import com.ekingstar.eams.student.Student;

public class BenefitAnalysisAction extends AbstractEvaluationResultAction {
	public String search() {
		Long experimentid = getLong("experiment.id");
		EntityQuery query = new EntityQuery(BenefitItemResult.class, "m");
		query.add(new Condition("m.result.experiment.id=:experimentId",experimentid));
		addStdCondition(query, "m.result",getLoginStudent());
		//query.add(new Condition("m.result.student.code=:stdCode", getLoginName()));	
		query.setLimit(getPageLimit());
		BenefitResult benefitResult=getBenefitAnalysisResult();
		put("benefitResult",benefitResult);
		put("items", entityService.search(query));
		return forward();
	}
	private List getTopFinanceTypes() {
		EntityQuery query = new EntityQuery(FinanceType.class, "financeType");
		query.add(new Condition("financeType.parent is null"));
		List financeTypes = entityService.search(query);
		return financeTypes;
	}
	public void editSetting(Entity entity) {
		put("financeTypes", getTopFinanceTypes());
	}
	
	protected String saveAndForward(Entity entity) {
		BenefitItemResult itemResult = (BenefitItemResult) entity;
		if (itemResult.isVO()) {
			Long experimentid = getLong("experiment.id");
			EntityQuery query = new EntityQuery(BenefitResult.class, "result");
			query.add(new Condition("result.experiment.id=:experimentId",experimentid));
			query.add(new Condition("result.student.code=:stdCode", getLoginName()));				
			List results = entityService.search(query);
			BenefitResult result = null;
			if (results.isEmpty()) {
				result = new BenefitResult();
				result.setExperiment((Experiment) entityService.load(Experiment.class, experimentid));
				List studentList = (List)entityService.load(Student.class,"code",getLoginName());
				if (null != studentList && studentList.size()!=0){
					result.setStudent((Student)studentList.get(0));
				}
				//result.setForm(new Aim());
			} else {
				result = (BenefitResult) results.get(0);
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
	
	private BenefitResult getBenefitAnalysisResult() {
		
		Long experimentid = getLong("experiment.id");
		EntityQuery query = new EntityQuery(BenefitResult.class, "result");
		query.add(new Condition("result.experiment.id=:experimentId",experimentid));
		//query.add(new Condition("result.student.code=:stdCode", getLoginName()));	
		Student std=getLoginStudent();
		addStdCondition(query, "result",std);		
		List results = entityService.search(query);
		
		BenefitResult result = null;
		if (results.isEmpty()) {
			result = new BenefitResult();
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
			result = (BenefitResult) results.get(0);
		}
		return result;
	}
	public String saveRemark(){
		Long experimentId = getLong("experiment.id");
		String remark = get("remark");
		BenefitResult result = getBenefitAnalysisResult();		
		result.setRemark(remark);
		entityService.saveOrUpdate(result);
		return redirect("search", "info.save.success", "&experiment.id=" + experimentId);
	}	
}