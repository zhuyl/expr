package org.expr.model.aim.result;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.aim.AimItem;
import org.expr.model.basecode.AimType;

public class AimItemResult extends LongIdObject implements AimItem {
	
	private AimResult result;
	
	private AimType aimtype;
	
	private String content;

	public AimResult getResult() {
		return result;
	}

	public void setResult(AimResult result) {
		this.result = result;
	}

	public AimType getAimtype() {
		return aimtype;
	}

	public void setAimtype(AimType aimtype) {
		this.aimtype = aimtype;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	

	
	
}