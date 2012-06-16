package org.expr.model.analysis.result;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.analysis.Expend;
import org.expr.model.analysis.ExpendHolder;

/**
 * 平衡支出表
 * 
 * @author chaostone
 * 
 */
public class ChangeExpendResult extends LongIdObject implements ExpendHolder {
    
    private ChangeResult result;
    
    private Expend expend;

	public ChangeResult getResult() {
		return result;
	}

	public void setResult(ChangeResult result) {
		this.result = result;
	}

	public Expend getExpend() {
		return expend;
	}

	public void setExpend(Expend expend) {
		this.expend = expend;
	}

}