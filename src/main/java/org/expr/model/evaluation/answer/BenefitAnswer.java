package org.expr.model.evaluation.answer;

import java.util.HashSet;
import java.util.Set;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.Caze;
import org.expr.model.evaluation.Benefit;
import org.expr.model.evaluation.BenefitItem;


public class BenefitAnswer extends LongIdObject implements Benefit {

	protected Caze caze;
	
	protected String remark;
	
	protected Set<BenefitItem> items=new HashSet();

	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Set<BenefitItem> getItems() {
		return items;
	}
	public void setItems(Set<BenefitItem> items) {
		this.items = items;
	}
	
	public Caze getCaze() {
		return caze;
	}

	public void setCaze(Caze caze) {
		this.caze = caze;
	}
}