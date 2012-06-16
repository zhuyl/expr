package org.expr.model.analysis.answer;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.analysis.Expend;
import org.expr.model.analysis.ExpendHolder;

/**
 * 平衡支出表
 * 
 * @author chaostone
 * 
 */
public class ChangeExpendAnswer extends LongIdObject implements ExpendHolder {
    
    private ChangeAnswer answer;
    
    private Expend expend;

	public ChangeAnswer getAnswer() {
		return answer;
	}

	public void setAnswer(ChangeAnswer answer) {
		this.answer = answer;
	}

	public Expend getExpend() {
		return expend;
	}

	public void setExpend(Expend expend) {
		this.expend = expend;
	}

}