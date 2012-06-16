package org.expr.model.analysis.result;

import org.expr.model.analysis.AbstractResult;
import org.expr.model.analysis.BalanceOfPayment;

/**
 * 月度收支分析表
 * 
 * @author Administrator
 * 
 */
public class BalanceOfPaymentResult extends AbstractResult {
	
	private BalanceOfPayment form;

	public BalanceOfPayment getForm() {
		return form;
	}

	public void setForm(BalanceOfPayment form) {
		this.form = form;
	}
}
