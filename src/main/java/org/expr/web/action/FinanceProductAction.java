package org.expr.web.action;

import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.basecode.FinanceProductCategory;

import com.ekingstar.eams.web.action.BaseAction;

public class FinanceProductAction extends BaseAction {

	public String list() {
		EntityQuery query = new EntityQuery(FinanceProductCategory.class, "category");
		Long categoryId = getLong("category.id");
		if (null != categoryId) {
			query.add(new Condition("category.id=:categoryId", categoryId));
		}
		put("financeProductCategories", entityService.search(query));
		return forward();
	}

	public String show() {
		return get("product");
	}
}
