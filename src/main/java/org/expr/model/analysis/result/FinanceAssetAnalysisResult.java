package org.expr.model.analysis.result;

import org.expr.model.analysis.AbstractResult;
import org.expr.model.analysis.FinanceAssetAnalysis;

/**
 * 金融资产表
 * 
 * @author Administrator
 * 
 */
public class FinanceAssetAnalysisResult extends AbstractResult {

	private FinanceAssetAnalysis form;

	public FinanceAssetAnalysis getForm() {
		return form;
	}

	public void setForm(FinanceAssetAnalysis analysisForm) {
		this.form = analysisForm;
	}
	
}