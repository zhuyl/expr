package org.expr.web.action.evaluation.answer;

import java.util.List;

import org.beanfuse.model.Entity;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.Caze;
import org.expr.model.basecode.FinanceType;
import org.expr.model.evaluation.answer.BenefitAnswer;
import org.expr.model.evaluation.answer.BenefitItemAnswer;

public class BenefitAnalysisAction extends AbstractEvaluationAnswerAction {
	public String search() {
		Long cazeid = getLong("caze.id");
		EntityQuery query = new EntityQuery(BenefitItemAnswer.class, "m");
		query.add(new Condition("m.answer.caze.id=:cazeId",cazeid));
		query.setLimit(getPageLimit());
		BenefitAnswer benefitAnswer=getBenefitAnalysisAnswer();
		put("benefitAnswer",benefitAnswer);
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
		BenefitItemAnswer itemAnswer = (BenefitItemAnswer) entity;
		if (itemAnswer.isVO()) {
			Long cazeid = getLong("caze.id");
			List answers = entityService.load(BenefitAnswer.class, "caze.id", cazeid);
			BenefitAnswer answer = null;
			if (answers.isEmpty()) {
				answer = new BenefitAnswer();
				answer.setCaze((Caze) entityService.load(Caze.class, cazeid));
				//answer.setForm(new Aim());
			} else {
				answer = (BenefitAnswer) answers.get(0);
			}
			itemAnswer.setAnswer(answer);
			//answer.getForm().getItmes().add(itemAnswer);
			answer.getItems().add(itemAnswer);
			entityService.saveOrUpdate(answer);
		} else {
			entityService.saveOrUpdate(itemAnswer);
		}
		return redirect("search", "info.save.success");
	}
	
	private BenefitAnswer getBenefitAnalysisAnswer() {
		
		Long cazeid = getLong("caze.id");
		List answers = entityService.load(BenefitAnswer.class, "caze.id", cazeid);
		BenefitAnswer answer = null;
		if (answers.isEmpty()) {
			answer = new BenefitAnswer();
			answer.setCaze((Caze) entityService.load(Caze.class, cazeid));
		} else {
			answer = (BenefitAnswer) answers.get(0);
		}
		return answer;
	}
	public String saveRemark(){
		Long cazeId = getLong("caze.id");
		String remark = get("remark");
		BenefitAnswer answer = getBenefitAnalysisAnswer();		
		answer.setRemark(remark);
		entityService.saveOrUpdate(answer);
		return redirect("search", "info.save.success", "&caze.id=" + cazeId);
	}	
	
	public String info() {
		search();
		return forward();
	}
	
}