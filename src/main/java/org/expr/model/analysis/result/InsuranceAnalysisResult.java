package org.expr.model.analysis.result;

import org.expr.model.analysis.AbstractResult;
import org.expr.model.analysis.InsuranceAnalysis;

/**
 * 保险资产分析表
 * 
 * @author Administrator
 * 
 */
public class InsuranceAnalysisResult extends AbstractResult {
    
    private InsuranceAnalysis form;

	public InsuranceAnalysis getForm() {
		return form;
	}

	public void setForm(InsuranceAnalysis form) {
		this.form = form;
	}

}