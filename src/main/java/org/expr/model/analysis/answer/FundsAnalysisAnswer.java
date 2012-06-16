package org.expr.model.analysis.answer;

import org.expr.model.analysis.FundsAnalysis;

/**
 * 资产分析表
 * 
 * @author Administrator
 * 
 */
public class FundsAnalysisAnswer extends AbstractAnalysisAnswer {
    
    private FundsAnalysis form;

	public FundsAnalysis getForm() {
		return form;
	}

	public void setForm(FundsAnalysis form) {
		this.form = form;
	}
    
}