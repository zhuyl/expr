package org.expr.model.evaluation.answer;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.Caze;


public class InsuranceCompareAnswer extends LongIdObject {

	protected Caze caze;
	
	protected String remark;
	
	protected Integer year;

	public Caze getCaze() {
		return caze;
	}

	public void setCaze(Caze caze) {
		this.caze = caze;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getYear() {
		return year;
	}

	public void setYear(Integer year) {
		this.year = year;
	}


}