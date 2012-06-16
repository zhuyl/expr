package org.expr.web.action.analysis.result;

import java.util.List;

import org.apache.commons.lang.ObjectUtils;
import org.beanfuse.collection.Order;
import org.beanfuse.model.Entity;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.analysis.FamilyMember;
import org.expr.model.analysis.InsuranceAnalysis;
import org.expr.model.analysis.result.FamilyMemberResult;
import org.expr.model.analysis.result.InsuranceAnalysisResult;
import org.expr.model.analysis.result.InsurancePolicyResult;
import org.expr.model.basecode.InsurancePayTime;
import org.expr.model.basecode.InsurancePayType;
import org.expr.model.basecode.InsuranceTime;
import org.expr.model.basecode.InsuranceType;
import org.expr.model.lesson.Experiment;

import com.ekingstar.eams.student.Student;

public class InsuranceAnalysisAction extends AbstractAnalysisResultAction {

	public String index() {
		return search();
	}
	
	private InsuranceAnalysisResult getInsuranceAnalysisResult() {
		
		Long experimentid = getLong("experiment.id");

		EntityQuery query = new EntityQuery(InsuranceAnalysisResult.class, "result");
		query.add(new Condition("result.experiment.id=:experimentid", experimentid));
		//query.add(new Condition("result.student.code=:stdCode", getLoginName()));
		Student std=getLoginStudent();
		addStdCondition(query, "result",std);
		List results = entityService.search(query);	
		
		InsuranceAnalysisResult result = null;
		if (results.isEmpty()) {
			result = new InsuranceAnalysisResult();
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
			result.setForm(new InsuranceAnalysis());
			entityService.saveOrUpdate(result);
		} else {
			result = (InsuranceAnalysisResult) results.get(0);
		}
		return result;
	}

	public String search() {
		Long experimentid = getLong("experiment.id");
		EntityQuery query = new EntityQuery(InsurancePolicyResult.class, "policy");
		query.addOrder(Order.parse(get("orderBy")));
		query.add(new Condition("policy.result.experiment.id=:experimentid", experimentid));
	   // query.add(new Condition("policy.result.student.code=:stdCode", getLoginName()));
		addStdCondition(query, "policy.result",getLoginStudent());
		query.setLimit(getPageLimit());// 加分页，否则删除会有误
		InsuranceAnalysisResult analysisResult=getInsuranceAnalysisResult();
		put("results", entityService.search(query));
		put("analysisResult",analysisResult);
		return forward();
	}
	private List getTopInsuranceTypes() {
		EntityQuery query = new EntityQuery(InsuranceType.class, "insuranceType");
		query.add(new Condition("insuranceType.parent is null"));
		List insuranceTypes = entityService.search(query);
		return insuranceTypes;
	}
	public void editSetting(Entity entity) {
		put("InsurancePayTypes", entityService.search(new EntityQuery(InsurancePayType.class,
				"InsurancePayType")));
		put("InsuranceTypes", getTopInsuranceTypes());
		put("InsurancePayTimes", entityService.search(new EntityQuery(InsurancePayTime.class,
				"InsurancePayTime")));
		put("InsuranceTimes", entityService.search(new EntityQuery(InsuranceTime.class,
				"InsuranceTime")));

		Long experimentid = getLong("experiment.id");
		EntityQuery query = new EntityQuery(InsurancePolicyResult.class, "policy");
		query.add(new Condition("policy.result.experiment.id=:experimentid", experimentid));
		query.add(new Condition("policy.policy.additional=false"));
		query.add(new Condition("policy.result.student.code=:stdCode", getLoginName()));
		
		if(entity.isPO()){
			query.add(new Condition("policy.id<>:myid",entity.getEntityId()));
		}
		put("masters", entityService.search(query));
		/**取人员*/
		 query = new EntityQuery(FamilyMemberResult.class, "m");
		query.add(new Condition("m.result.experiment.id=:experimentid", experimentid));
		query.add(new Condition("m.result.student.code=:stdCode", getLoginName()));
		query.setSelect("m.member");
		List<FamilyMember> members = entityService.search(query);
		put("members",members);
	}

	protected String saveAndForward(Entity entity) {
		InsurancePolicyResult policyResult = (InsurancePolicyResult) entity;
		if(ObjectUtils.equals(Boolean.FALSE, policyResult.getPolicy().getAdditional())){
			policyResult.setMaster(null);
		}
		if (policyResult.isVO()) {
			Long experimentid = getLong("experiment.id");
			EntityQuery query = new EntityQuery(InsuranceAnalysisResult.class, "result");
			query.add(new Condition("result.experiment.id=:experimentid", experimentid));
			query.add(new Condition("result.student.code=:stdCode", getLoginName()));
			List results = entityService.search(query);	
			InsuranceAnalysisResult result = null;
			if (results.isEmpty()) {
				result = new InsuranceAnalysisResult();
				result.setExperiment((Experiment) entityService.load(Experiment.class, experimentid));
				result.setForm(new InsuranceAnalysis());
				List studentList = (List)entityService.load(Student.class,"code",getLoginName());
				if (null != studentList && studentList.size()!=0){
					result.setStudent((Student)studentList.get(0));
				}				
			} else {
				result = (InsuranceAnalysisResult) results.get(0);
			}
			policyResult.setResult(result);
			result.getForm().getPolicies().add(policyResult);
			entityService.saveOrUpdate(result);
		} else {
			entityService.saveOrUpdate(policyResult);
		}
		return redirect("search", "info.save.success");
	}

	public String saveRemark(){
		Long experimentId = getLong("experiment.id");
		String remark = get("remark");
		InsuranceAnalysisResult result = getInsuranceAnalysisResult();		
		result.setRemark(remark);
		entityService.saveOrUpdate(result);
		return redirect("search", "info.save.success", "&experiment.id=" + experimentId);
	}	
}