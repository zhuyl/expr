package org.expr.web.action;

import java.util.List;

import org.beanfuse.model.Entity;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.basecode.FinanceType;
import org.expr.model.basecode.Mobility;
import org.expr.model.basecode.RatePayPeriod;
import org.expr.model.basecode.RiskGrade;
import org.expr.model.finance.Finance;

import com.ekingstar.eams.web.action.BaseAction;

public class FinanceAction extends BaseAction {
	public String index() {
		put("FinanceTypes", getTopFinanceTypes());
		put("Mobilities", entityService.loadAll(Mobility.class));
		put("RiskGrades", entityService.loadAll(RiskGrade.class));
		put("RatePayPeriods", entityService.loadAll(RatePayPeriod.class));
		return forward();
	}
	public String userindex() {
		put("FinanceTypes", getTopFinanceTypes());
		put("Mobilities", entityService.loadAll(Mobility.class));
		put("RiskGrades", entityService.loadAll(RiskGrade.class));
		put("RatePayPeriods", entityService.loadAll(RatePayPeriod.class));
		return forward();
	}

	private List getTopFinanceTypes() {
		EntityQuery query = new EntityQuery(FinanceType.class, "financeType");
		query.add(new Condition("financeType.parent is null"));
		List financeTypes = entityService.search(query);
		return financeTypes;
	}
	protected void editSetting(Entity entity) {
		Finance product = (Finance) entity;
		put("FinanceTypes", getTopFinanceTypes());
		put("Mobilities", entityService.loadAll(Mobility.class));
		put("RiskGrades", entityService.loadAll(RiskGrade.class));
		put("RatePayPeriods", entityService.loadAll(RatePayPeriod.class));
	}
	public String financeQuery() {
		put("FinanceTypes", getTopFinanceTypes());
		put("Mobilities", entityService.loadAll(Mobility.class));
		put("RiskGrades", entityService.loadAll(RiskGrade.class));
		put("RatePayPeriods", entityService.loadAll(RatePayPeriod.class));
		return forward();
	}

	public String financeQueryList() {
		EntityQuery q=new EntityQuery(Finance.class,"finance");
		q.setLimit(getPageLimit());
		this.populateConditions(q);
		put("finances", entityService.search(q));
		return forward();
	}
	public String userlist() throws Exception{
		super.search();
		return forward();
	}
	
}