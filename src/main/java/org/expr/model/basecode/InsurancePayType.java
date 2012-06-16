package org.expr.model.basecode;

import com.ekingstar.eams.basecode.BaseCode;

/**
 * 保险缴费方式
 * 
 * @author Administrator
 * 
 */
public class InsurancePayType extends BaseCode {
    int countPerYear;

	public int getCountPerYear() {
		return countPerYear;
	}

	public void setCountPerYear(int countPerYear) {
		this.countPerYear = countPerYear;
	}
    
}