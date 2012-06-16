package org.expr.model.aim.answer;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.aim.AimItem;
import org.expr.model.basecode.AimType;

public class AimItemAnswer extends LongIdObject implements AimItem {
	
	private AimAnswer answer;
	
	private AimType aimtype;
	
	private String content;
	
	public AimAnswer getAnswer() {
		return answer;
	}
	public void setAnswer(AimAnswer answer) {
		this.answer = answer;
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