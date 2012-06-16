package org.expr.model.analysis.result;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.analysis.Expend;
import org.expr.model.analysis.ExpendHolder;

/**
 * 支出表
 * 
 * @author Administrator
 * 
 */
public class ExpendResult extends LongIdObject implements ExpendHolder {
    
    private BalanceOfPaymentResult result;
    
    private Expend expend;

	public BalanceOfPaymentResult getResult() {
		return result;
	}

	public void setResult(BalanceOfPaymentResult balanceOfPayment) {
		this.result = balanceOfPayment;
	}

	public Expend getExpend() {
		return expend;
	}

	public void setExpend(Expend expend) {
		this.expend = expend;
	}

}