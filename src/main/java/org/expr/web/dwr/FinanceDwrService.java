package org.expr.web.dwr;

import java.util.Collections;
import java.util.List;

import org.beanfuse.persist.impl.BaseServiceImpl;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.basecode.FinanceType;
import org.expr.model.finance.Finance;


public class FinanceDwrService extends BaseServiceImpl {

	public List<FinanceType> getFinanceTypes(Long parentId) {
		if (null == parentId) {
			return Collections.EMPTY_LIST;
		}
		EntityQuery query = new EntityQuery(FinanceType.class, "financeType");
		query.add(new Condition("financeType.parent.id=:parentId", parentId));
		return entityService.search(query);
	}
	
	public Finance getFinance(Long financeId) {
		EntityQuery query = new EntityQuery(Finance.class, "finance");
		query.add(new Condition("finance.id=:financeId", financeId));
		Finance finance = null;
		List financeList = entityService.search(query);
		if (null != financeList && !financeList.isEmpty()) {
			finance = (Finance)financeList.get(0);
		}
		return finance;
	}
	
}
