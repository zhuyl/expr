package org.expr.web.action;

import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.basecode.FinanceTool;
import org.expr.model.basecode.FinanceToolCategory;

import com.ekingstar.eams.web.action.BaseAction;

public class FinanceToolAction extends BaseAction {

	public String list() {
		EntityQuery query = new EntityQuery(FinanceToolCategory.class, "category");
		Long categoryId = getLong("categoryId");
		if (null != categoryId) {
			query.add(new Condition("category.id=:categoryId", categoryId));
		}
		put("financeToolCategories", entityService.search(query));
		return forward();
	}

	public String show() {
		return get("tool");
	}
	
	public String financeToolList(){
		Long categoryId = getLong("category.id");
		EntityQuery query=new EntityQuery(FinanceTool.class,"financeTool");
		query.add(new Condition("financeTool.category.id=:categoryId", categoryId));
		put("financeTools",entityService.search(query));
		return forward();
	}
}
