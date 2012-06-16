package org.expr.web.action.evaluation.answer;

import java.util.List;

import org.beanfuse.model.Entity;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.Caze;
import org.expr.model.basecode.FinanceType;
import org.expr.model.evaluation.answer.RiskAnswer;
import org.expr.model.evaluation.answer.RiskItemAnswer;

public class RiskAnalysisAction extends AbstractEvaluationAnswerAction {
	public String search() {
		Long cazeid = getLong("caze.id");
		EntityQuery query = new EntityQuery(RiskItemAnswer.class, "m");
		query.add(new Condition("m.answer.caze.id=:cazeId",cazeid));
		query.setLimit(getPageLimit());
		RiskAnswer analysisAnswer=getRiskAnalysisAnswer();
		put("analysisAnswer",analysisAnswer);
		put("answers", entityService.search(query));
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
		RiskItemAnswer itemAnswer = (RiskItemAnswer) entity;
		if (itemAnswer.isVO()) {
			Long cazeid = getLong("caze.id");
			List answers = entityService.load(RiskAnswer.class, "caze.id", cazeid);
			RiskAnswer answer = null;
			if (answers.isEmpty()) {
				answer = new RiskAnswer();
				answer.setCaze((Caze) entityService.load(Caze.class, cazeid));
				//answer.setForm(new Aim());
			} else {
				answer = (RiskAnswer) answers.get(0);
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
	
	private RiskAnswer getRiskAnalysisAnswer() {
		
		Long cazeid = getLong("caze.id");
		List answers = entityService.load(RiskAnswer.class, "caze.id", cazeid);
		RiskAnswer answer = null;
		if (answers.isEmpty()) {
			answer = new RiskAnswer();
			answer.setCaze((Caze) entityService.load(Caze.class, cazeid));
		} else {
			answer = (RiskAnswer) answers.get(0);
		}
		return answer;
	}
	public String saveRemark(){
		Long cazeId = getLong("caze.id");
		String remark = get("remark");
		RiskAnswer answer = getRiskAnalysisAnswer();		
		answer.setRemark(remark);
		entityService.saveOrUpdate(answer);
		return redirect("search", "info.save.success", "&caze.id=" + cazeId);
	}	
	
	public String info() {
		search();
		return forward();
	}
	
}