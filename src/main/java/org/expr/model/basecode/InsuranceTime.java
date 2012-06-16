package org.expr.model.basecode;

import com.ekingstar.eams.basecode.BaseCode;

/**
 * 保险期限
 * 
 * @author Administrator
 * 
 */
public class InsuranceTime extends BaseCode {
	//per year
	// 10,15,30,51-:age,61-:age,NaN
    String duration;

	public String getDuration() {
		return duration;
	}

	public void setDuration(String duration) {
		this.duration = duration;
	}
}