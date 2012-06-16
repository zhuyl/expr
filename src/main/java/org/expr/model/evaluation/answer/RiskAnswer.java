package org.expr.model.evaluation.answer;

import java.util.HashSet;
import java.util.Set;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.Caze;
import org.expr.model.evaluation.Risk;
import org.expr.model.evaluation.RiskItem;


public class RiskAnswer extends LongIdObject implements Risk {

	protected Caze caze;
	
	protected String remark;
	
	protected Set<RiskItem> items=new HashSet();

	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Set<RiskItem> getItems() {
		return items;
	}
	public void setItems(Set<RiskItem> items) {
		this.items = items;
	}
	
	public Caze getCaze() {
		return caze;
	}

	public void setCaze(Caze caze) {
		this.caze = caze;
	}
}