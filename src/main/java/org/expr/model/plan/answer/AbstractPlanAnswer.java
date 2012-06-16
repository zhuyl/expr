package org.expr.model.plan.answer;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.Caze;

public class AbstractPlanAnswer extends LongIdObject {
	protected String remark;
	
	protected Caze caze;

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Caze getCaze() {
		return caze;
	}

	public void setCaze(Caze caze) {
		this.caze = caze;
	}
	
}
