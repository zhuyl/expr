package org.expr.web.action.analysis.result;

import java.util.List;

import org.beanfuse.model.Entity;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.analysis.FamilyAnalysis;
import org.expr.model.analysis.result.FamilyAnalysisResult;
import org.expr.model.analysis.result.FamilyMemberResult;
import org.expr.model.basecode.BenefitRelation;
import org.expr.model.insurance.Career;
import org.expr.model.lesson.Experiment;

import com.ekingstar.eams.basecode.nation.Gender;
import com.ekingstar.eams.student.Student;

public class FamilyAnalysisAction extends AbstractAnalysisResultAction {

	public String index() {
		return search();
	}
	private FamilyAnalysisResult getFamilyAnalysisResult() {
		Long experimentId=getLong("experiment.id");
		EntityQuery query=new EntityQuery(FamilyAnalysisResult.class,"family");
		//query.add(new Condition("family.student.code=:stdCode", getLoginName()));
		Student std=getLoginStudent();
		query.add(new Condition("family.experiment.id=:experimentId", experimentId));
		addStdCondition(query, "family",std);
		List results=(List)entityService.search(query);
		
		FamilyAnalysisResult result = null;
		if (results.isEmpty()) {
			result = new FamilyAnalysisResult();
			result.setExperiment((Experiment)entityService.load(Experiment.class, experimentId));
			result.setForm(new FamilyAnalysis());
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
		} else {
			result = (FamilyAnalysisResult) results.get(0);
		}
		return result;
	}

	public String search() {
		Long experimentid = getLong("experiment.id");
		FamilyAnalysisResult analysisResult=getFamilyAnalysisResult();
		EntityQuery query = new EntityQuery(FamilyMemberResult.class, "m");
		query.add(new Condition("m.result.experiment.id=:experimentid", experimentid));
		//query.add(new Condition("m.result.student.code=:stdCode", getLoginName()));
		addStdCondition(query, "m.result",getLoginStudent());
		if (get("nopage")==null){
		query.setLimit(getPageLimit());
		}
		put("results", entityService.search(query));
		put("analysisResult",analysisResult);
		return forward();
	}

	public void editSetting(Entity entity) {
		put("Genders", entityService.search(new EntityQuery(Gender.class, "Gender")));
		put("BenefitRealtion", entityService.search(new EntityQuery(BenefitRelation.class,
				"BenefitRelation")));
		EntityQuery query = new EntityQuery(Career.class, "career");
		query.add(new Condition("length(career.code)=2"));
		put("careers", entityService.search(query));
	}

	protected String saveAndForward(Entity entity) {
		FamilyMemberResult memberResult = (FamilyMemberResult) entity;
		if (memberResult.isVO()) {
			Long experimentid = getLong("experiment.id");
			EntityQuery query=new EntityQuery(FamilyAnalysisResult.class,"family");
			query.add(new Condition("family.student.code=:stdCode", getLoginName()));
			query.add(new Condition("family.experiment.id=:experimentId", experimentid));
			List results=(List)entityService.search(query);
			
			FamilyAnalysisResult result = null;
			if (results.isEmpty()) {
				result = new FamilyAnalysisResult();
				result.setExperiment((Experiment) entityService.load(Experiment.class, experimentid));
				List studentList = (List)entityService.load(Student.class,"code",getLoginName());
				if (null != studentList && studentList.size()!=0){
					result.setStudent((Student)studentList.get(0));
				}
				result.setForm(new FamilyAnalysis());
			} else {
				result = (FamilyAnalysisResult) results.get(0);
			}
			memberResult.setResult(result);
			// result.setForm(new FamilyAnalysis());
			result.getForm().getMembers().add(memberResult);
			entityService.saveOrUpdate(result);
		} else {
			entityService.saveOrUpdate(memberResult);
		}
		return redirect("search", "info.save.success");
	}
	
	public String saveRemark(){
		Long experimentId = getLong("experiment.id");
		String remark = get("remark");
		FamilyAnalysisResult result = null;
		EntityQuery query=new EntityQuery(FamilyAnalysisResult.class,"family");
		query.add(new Condition("family.student.code=:stdCode", getLoginName()));
		query.add(new Condition("family.experiment.id=:experimentId", experimentId));
		List results=(List)entityService.search(query);
		
		if (results.isEmpty()) {
			result = new FamilyAnalysisResult();
			result.setExperiment((Experiment) entityService.load(Experiment.class, experimentId));
			result.setForm(new FamilyAnalysis());
			List studentList = (List)entityService.load(Student.class,"code",getLoginName());
			if (null != studentList && studentList.size()!=0){
				result.setStudent((Student)studentList.get(0));
			}	
		} else {
			result = (FamilyAnalysisResult) results.get(0);
		}
	
		result.setRemark(remark);
		entityService.saveOrUpdate(result);
		return redirect("search", "info.save.success", "&experiment.id=" + experimentId);
	}

}