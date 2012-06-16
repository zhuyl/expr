package org.expr.model.analysis.answer;

import org.expr.model.analysis.BalanceOfPayment;

public class ChangeAnswer extends AbstractAnalysisAnswer {
	private BalanceOfPayment form;


	public BalanceOfPayment getForm() {
		return form;
	}

	public void setForm(BalanceOfPayment form) {
		this.form = form;
	}

}