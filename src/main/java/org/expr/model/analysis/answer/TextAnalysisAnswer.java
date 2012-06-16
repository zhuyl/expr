package org.expr.model.analysis.answer;

import org.expr.model.analysis.TextAnalysis;

public class TextAnalysisAnswer extends AbstractAnalysisAnswer {

    private TextAnalysis form;
    
    public TextAnalysis getForm() {
        return form;
    }
    
    public void setForm(TextAnalysis form) {
        this.form = form;
    }
}
