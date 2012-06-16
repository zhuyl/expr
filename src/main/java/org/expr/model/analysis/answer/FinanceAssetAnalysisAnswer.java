package org.expr.model.analysis.answer;

import org.expr.model.analysis.FinanceAssetAnalysis;

/**
 * 金融资产表
 * 
 * @author Administrator
 * 
 */
public class FinanceAssetAnalysisAnswer extends AbstractAnalysisAnswer {

	private FinanceAssetAnalysis form;

	public FinanceAssetAnalysis getForm() {
		return form;
	}

	public void setForm(FinanceAssetAnalysis analysisForm) {
		this.form = analysisForm;
	}
	
}