package org.expr.model.basecode;

import com.ekingstar.eams.basecode.BaseCode;

/**
 * 保险产品类型
 * 
 * @author Administrator
 * 
 */
public class InsuranceType extends BaseCode {
	InsuranceType parent;

	public InsuranceType getParent() {
		return parent;
	}

	public void setParent(InsuranceType parent) {
		this.parent = parent;
	}
	
    
}