package org.expr.model.analysis.answer;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.analysis.Expend;
import org.expr.model.analysis.ExpendHolder;

/**
 * 支出表
 * 
 * @author Administrator
 * 
 */
public class ExpendAnswer extends LongIdObject implements ExpendHolder {
    
    private BalanceOfPaymentAnswer answer;
    
    private Expend expend;

	public BalanceOfPaymentAnswer getAnswer() {
		return answer;
	}

	public void setAnswer(BalanceOfPaymentAnswer balanceOfPayment) {
		this.answer = balanceOfPayment;
	}

	public Expend getExpend() {
		return expend;
	}

	public void setExpend(Expend expend) {
		this.expend = expend;
	}

}