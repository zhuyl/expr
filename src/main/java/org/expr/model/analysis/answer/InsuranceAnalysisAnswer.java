package org.expr.model.analysis.answer;

import org.expr.model.analysis.InsuranceAnalysis;

/**
 * 保险资产分析表
 * 
 * @author Administrator
 * 
 */
public class InsuranceAnalysisAnswer extends AbstractAnalysisAnswer {
    
    private InsuranceAnalysis form;

	public InsuranceAnalysis getForm() {
		return form;
	}

	public void setForm(InsuranceAnalysis form) {
		this.form = form;
	}

}