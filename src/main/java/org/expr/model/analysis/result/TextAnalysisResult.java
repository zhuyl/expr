package org.expr.model.analysis.result;

import org.expr.model.analysis.AbstractResult;
import org.expr.model.analysis.TextAnalysis;

public class TextAnalysisResult extends AbstractResult {
	
    private TextAnalysis form;
    
    public TextAnalysis getForm() {
        return form;
    }
    
    public void setForm(TextAnalysis form) {
        this.form = form;
    }
    
}
