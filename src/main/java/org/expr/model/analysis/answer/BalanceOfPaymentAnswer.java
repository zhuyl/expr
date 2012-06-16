package org.expr.model.analysis.answer;

import org.expr.model.analysis.BalanceOfPayment;

/**
 * 月度收支分析表
 * 
 * @author Administrator
 * 
 */
public class BalanceOfPaymentAnswer extends AbstractAnalysisAnswer {
	
	private BalanceOfPayment form;

	public BalanceOfPayment getForm() {
		return form;
	}

	public void setForm(BalanceOfPayment form) {
		this.form = form;
	}
}