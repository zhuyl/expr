package org.expr.model.analysis.result;

import org.expr.model.analysis.AbstractResult;
import org.expr.model.analysis.BalanceOfPayment;

public class ChangeResult extends AbstractResult {
	private BalanceOfPayment form;


	public BalanceOfPayment getForm() {
		return form;
	}

	public void setForm(BalanceOfPayment form) {
		this.form = form;
	}

}