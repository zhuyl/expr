package org.expr.web.action.plan.answer;

import java.util.HashSet;
import java.util.List;

import org.beanfuse.collection.Order;
import org.beanfuse.model.Entity;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.Caze;
import org.expr.model.basecode.FinanceType;
import org.expr.model.basecode.Mobility;
import org.expr.model.basecode.RatePayPeriod;
import org.expr.model.basecode.RiskGrade;
import org.expr.model.plan.answer.FinanceAssetPlanAnswer;
import org.expr.model.plan.answer.FinancePlanAnswer;
import org.expr.web.action.plan.helper.FinanceAssetPlanHelper;

public class FinanceAssetPlanAction extends AbstractPlanAnswerAction {

	public String index() {
		return search();
	}

	public String search() {
		Long cazeid = getLong("caze.id");
		Caze caze = (Caze) entityService.load(Caze.class, cazeid);
		FinanceAssetPlanAnswer planAnswer = getFinanceAssetPlanAnswer();
		EntityQuery query = new EntityQuery(FinancePlanAnswer.class, "asset");
		query.addOrder(Order.parse(get("orderBy")));
		query.add(new Condition("asset.answer.caze.id=:cazeid", cazeid));
		query.setLimit(getPageLimit());// 加分页，否则删除会有误
		List<FinancePlanAnswer> financeanswers = entityService.search(query);
		put("answers", entityService.search(query));
		put("planAnswer", planAnswer);
		FinanceAssetPlanHelper helper=new FinanceAssetPlanHelper();
		helper.setEntityService(entityService);
		helper.calcCapitals(financeanswers, caze);
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

	private FinanceAssetPlanAnswer getFinanceAssetPlanAnswer() {
		EntityQuery query = new EntityQuery(FinanceAssetPlanAnswer.class, "answer");
		Long cazeId = getLong("caze.id");
		query.add(new Condition("answer.caze.id=:cazeId", cazeId));
		List answers = entityService.search(query);
		FinanceAssetPlanAnswer answer = null;
		if (answers.isEmpty()) {
			answer = new FinanceAssetPlanAnswer();
			answer.setCaze((Caze) entityService.get(Caze.class, cazeId));
			answer.setAssets(new HashSet());
			entityService.saveOrUpdate(answer);
		} else {
			answer = (FinanceAssetPlanAnswer) answers.get(0);
		}
		return answer;
	}

	@Override
	protected String saveAndForward(Entity entity) {
		FinancePlanAnswer answer = (FinancePlanAnswer) entity;
		if (null == answer.getAnswer()) {
			answer.setAnswer(getFinanceAssetPlanAnswer());
		}
		return super.saveAndForward(entity);
	}

	public String saveRemark() {
		Long cazeId = getLong("caze.id");
		String remark = get("remark");
		FinanceAssetPlanAnswer answer = getFinanceAssetPlanAnswer();
		answer.setRemark(remark);
		entityService.saveOrUpdate(answer);
		return redirect("search", "info.save.success", "&caze.id=" + cazeId);
	}

	public String info() {
		index();
		return forward();
	}
	
	public String infolet() {
		search();
		return forward("../../infolet/info");
	}
}