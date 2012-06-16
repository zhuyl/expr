package org.expr.web.action.analysis.answer;

import java.util.List;

import org.beanfuse.collection.Order;
import org.beanfuse.model.Entity;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.Caze;
import org.expr.model.analysis.FinanceAssetAnalysis;
import org.expr.model.analysis.answer.FinanceAssetAnalysisAnswer;
import org.expr.model.analysis.answer.FinanceAssetAnswer;
import org.expr.model.basecode.FinanceType;
import org.expr.model.basecode.Mobility;
import org.expr.model.basecode.RatePayPeriod;
import org.expr.model.basecode.RiskGrade;

public class FinanceAssetAnalysisAction extends AbstractAnalysisAnswerAction {

	public String index() {
		return search();
	}
	
	public String search() {
		Long cazeid = getLong("caze.id");
		FinanceAssetAnalysisAnswer analysisAnswer=getFinanceAssetAnalysisAnswer();
		EntityQuery query = new EntityQuery(FinanceAssetAnswer.class, "asset");
		query.addOrder(Order.parse(get("orderBy")));
		query.add(new Condition("asset.answer.caze.id=:cazeid", cazeid));
		query.setLimit(getPageLimit());// 加分页，否则删除会有误
		put("answers", entityService.search(query));
		put("analysisAnswer",analysisAnswer);
		return forward();
	}

	private List getTopFinanceTypes() {
		EntityQuery query = new EntityQuery(FinanceType.class, "financeType");
		query.add(new Condition("financeType.parent is null"));
		List financeTypes = entityService.search(query);
		return financeTypes;
	}

	public void editSetting(Entity entity) {
		put("FinanceTypes", getTopFinanceTypes());
		put("Mobilities", entityService.loadAll(Mobility.class));
		put("RiskGrades", entityService.loadAll(RiskGrade.class));
		put("RatePayPeriods", entityService.loadAll(RatePayPeriod.class));
	}

	protected FinanceAssetAnalysisAnswer getFinanceAssetAnalysisAnswer() {
		EntityQuery query = new EntityQuery(FinanceAssetAnalysisAnswer.class, "answer");
		Long cazeId = getLong("caze.id");
		query.add(new Condition("answer.caze.id=:cazeId", cazeId));
		List answers = entityService.search(query);
		FinanceAssetAnalysisAnswer answer = null;
		if (answers.isEmpty()) {
			answer = new FinanceAssetAnalysisAnswer();
			answer.setCaze((Caze) entityService.get(Caze.class, cazeId));
			answer.setForm(new FinanceAssetAnalysis());
			entityService.saveOrUpdate(answer);
		} else {
			answer = (FinanceAssetAnalysisAnswer) answers.get(0);
		}
		return answer;
	}

	@Override
	protected String saveAndForward(Entity entity) {
		FinanceAssetAnswer answer = (FinanceAssetAnswer) entity;
		if (null == answer.getAnswer()) {
			answer.setAnswer(getFinanceAssetAnalysisAnswer());
		}
		return super.saveAndForward(entity);
	}
	
	public String saveRemark(){
		Long cazeId = getLong("caze.id");
		String remark = get("remark");
		FinanceAssetAnalysisAnswer answer = getFinanceAssetAnalysisAnswer();
		answer.setRemark(remark);
		entityService.saveOrUpdate(answer);
		return redirect("search", "info.save.success", "&caze.id=" + cazeId);
	}
	
	public String info() {
		return search();
	}

}