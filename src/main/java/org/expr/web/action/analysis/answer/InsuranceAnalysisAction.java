package org.expr.web.action.analysis.answer;

import java.util.List;

import org.apache.commons.lang.ObjectUtils;
import org.beanfuse.collection.Order;
import org.beanfuse.model.Entity;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.Caze;
import org.expr.model.analysis.FamilyMember;
import org.expr.model.analysis.InsuranceAnalysis;
import org.expr.model.analysis.answer.FamilyMemberAnswer;
import org.expr.model.analysis.answer.InsuranceAnalysisAnswer;
import org.expr.model.analysis.answer.InsurancePolicyAnswer;
import org.expr.model.basecode.InsurancePayTime;
import org.expr.model.basecode.InsurancePayType;
import org.expr.model.basecode.InsuranceTime;
import org.expr.model.basecode.InsuranceType;

public class InsuranceAnalysisAction extends AbstractAnalysisAnswerAction {

	public String index() {
		return search();
	}
	
	private InsuranceAnalysisAnswer getInsuranceAnalysisAnswer() {
		Long cazeid = getLong("caze.id");
		List answers = entityService.load(InsuranceAnalysisAnswer.class, "caze.id", cazeid);
		InsuranceAnalysisAnswer answer = null;
		if (answers.isEmpty()) {
			answer = new InsuranceAnalysisAnswer();
			answer.setCaze((Caze) entityService.load(Caze.class, cazeid));
			answer.setForm(new InsuranceAnalysis());
		} else {
			answer = (InsuranceAnalysisAnswer) answers.get(0);
		}
		return answer;
	}

	public String search() {
		Long cazeid = getLong("caze.id");
		EntityQuery query = new EntityQuery(InsurancePolicyAnswer.class, "policy");
		query.addOrder(Order.parse(get("orderBy")));
		query.add(new Condition("policy.answer.caze.id=:cazeid", cazeid));
		query.setLimit(getPageLimit());// 加分页，否则删除会有误
		InsuranceAnalysisAnswer analysisAnswer=getInsuranceAnalysisAnswer();
		put("answers", entityService.search(query));
		put("analysisAnswer",analysisAnswer);

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

		Long cazeid = getLong("caze.id");
		EntityQuery query = new EntityQuery(InsurancePolicyAnswer.class, "policy");
		query.add(new Condition("policy.answer.caze.id=:cazeid", cazeid));
		query.add(new Condition("policy.policy.additional=false"));
		
		if(entity.isPO()){
			query.add(new Condition("policy.id<>:myid",entity.getEntityId()));
		}
		put("masters", entityService.search(query));
		/**取人员*/		
		query = new EntityQuery(FamilyMemberAnswer.class, "memberAnswer");
		query.add(new Condition("memberAnswer.answer.caze.id=:cazeId", cazeid));
		query.setSelect("memberAnswer.member");
		List<FamilyMember> members = entityService.search(query);
		put("members",members);
	}

	protected String saveAndForward(Entity entity) {
		InsurancePolicyAnswer policyAnswer = (InsurancePolicyAnswer) entity;
		if(ObjectUtils.equals(Boolean.FALSE, policyAnswer.getPolicy().getAdditional())){
			policyAnswer.setMaster(null);
		}
		if (policyAnswer.isVO()) {
			Long cazeid = getLong("caze.id");
			List answers = entityService.load(InsuranceAnalysisAnswer.class, "caze.id", cazeid);
			InsuranceAnalysisAnswer answer = null;
			if (answers.isEmpty()) {
				answer = new InsuranceAnalysisAnswer();
				answer.setCaze((Caze) entityService.load(Caze.class, cazeid));
				answer.setForm(new InsuranceAnalysis());
			} else {
				answer = (InsuranceAnalysisAnswer) answers.get(0);
			}
			policyAnswer.setAnswer(answer);
			answer.getForm().getPolicies().add(policyAnswer);
			entityService.saveOrUpdate(answer);
		} else {
			entityService.saveOrUpdate(policyAnswer);
		}
		return redirect("search", "info.save.success");
	}

	public String saveRemark(){
		Long cazeId = getLong("caze.id");
		String remark = get("remark");
		InsuranceAnalysisAnswer answer = getInsuranceAnalysisAnswer();		
		answer.setRemark(remark);
		entityService.saveOrUpdate(answer);
		return redirect("search", "info.save.success", "&caze.id=" + cazeId);
	}	
	
	// 查看答案
	public String info() {
		search();
		return forward();
	}
	
}