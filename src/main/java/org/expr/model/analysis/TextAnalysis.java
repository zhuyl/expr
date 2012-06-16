package org.expr.model.analysis;

import org.expr.model.basecode.Analysis;

    /**
     * 文本分析表
     * 
     * @author Administrator
     *
     */
public class TextAnalysis implements AnalysisForm {

	private String content;

	private Analysis analysis;
	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Analysis getAnalysis() {
		return analysis;
	}

	public void setAnalysis(Analysis analysis) {
		this.analysis = analysis;
	}
	
}
