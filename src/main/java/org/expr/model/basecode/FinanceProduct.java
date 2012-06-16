package org.expr.model.basecode;

import com.ekingstar.eams.basecode.BaseCode;

public class FinanceProduct extends BaseCode {

	private FinanceProductCategory category;

	public FinanceProductCategory getCategory() {
		return category;
	}

	public void setCategory(FinanceProductCategory category) {
		this.category = category;
	}

}
