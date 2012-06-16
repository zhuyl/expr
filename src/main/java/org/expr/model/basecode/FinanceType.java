package org.expr.model.basecode;

import com.ekingstar.eams.basecode.BaseCode;

/**
 * 金融投资产品类型
 * 
 * @author Administrator
 * 
 */
public class FinanceType extends BaseCode {
	FinanceType parent;

	public FinanceType getParent() {
		return parent;
	}

	public void setParent(FinanceType parent) {
		this.parent = parent;
	}
	
    
}