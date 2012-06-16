package org.expr.model.analysis.result;

import org.expr.model.analysis.AbstractResult;
import org.expr.model.analysis.FamilyAnalysis;

/**
 * 家庭分析表答案
 * 
 * @author chaostone
 * 
 */
public class FamilyAnalysisResult extends AbstractResult   {

	private FamilyAnalysis form;

	public FamilyAnalysis getForm() {
		return form;
	}

	public void setForm(FamilyAnalysis analysisForm) {
		this.form = analysisForm;
	}
}
