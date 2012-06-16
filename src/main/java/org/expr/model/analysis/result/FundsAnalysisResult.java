package org.expr.model.analysis.result;

import org.expr.model.analysis.AbstractResult;
import org.expr.model.analysis.FundsAnalysis;

/**
 * 资产分析表
 * 
 * @author Administrator
 * 
 */
public class FundsAnalysisResult extends AbstractResult {
    
    private FundsAnalysis form;

	public FundsAnalysis getForm() {
		return form;
	}

	public void setForm(FundsAnalysis form) {
		this.form = form;
	}
    
}
