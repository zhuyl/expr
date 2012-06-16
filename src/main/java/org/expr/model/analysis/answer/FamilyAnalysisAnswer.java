package org.expr.model.analysis.answer;

import org.expr.model.analysis.FamilyAnalysis;


/**
 * 家庭分析表
 * 
 * @author Administrator
 * 
 */
public class FamilyAnalysisAnswer extends AbstractAnalysisAnswer {

	private FamilyAnalysis form;

	public FamilyAnalysis getForm() {
		return form;
	}

	public void setForm(FamilyAnalysis analysisForm) {
		this.form = analysisForm;
	}
	
}