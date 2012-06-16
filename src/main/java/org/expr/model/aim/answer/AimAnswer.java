package org.expr.model.aim.answer;

import java.util.Set;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.Caze;
import org.expr.model.aim.Aim;
import org.expr.model.aim.AimItem;

public class AimAnswer extends LongIdObject implements Aim {

	protected Caze caze;
	
	protected String remark;
	
	protected Set<AimItem> items;

	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Set<AimItem> getItems() {
		return items;
	}
	public void setItems(Set<AimItem> items) {
		this.items = items;
	}
	
	public Caze getCaze() {
		return caze;
	}

	public void setCaze(Caze caze) {
		this.caze = caze;
	}
}