package org.expr.model.analysis.result;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.analysis.Option;
import org.expr.model.analysis.Question;
import org.expr.model.analysis.QuestionAnswer;

/**
 * 答案表
 * 
 * @author Administrator
 * 
 */
public class QuestionAnswerResult extends LongIdObject implements QuestionAnswer {

    private RiskToleranceResult result;
    
    /** 问题 */
    private Question question;
    
    /** 答案 */
    private Option option;


    public RiskToleranceResult getResult() {
        return result;
    }
    
    public void setResult(RiskToleranceResult result) {
        this.result = result;
    }

	public Question getQuestion() {
		return question;
	}

	public void setQuestion(Question question) {
		this.question = question;
	}

	public Option getOption() {
		return option;
	}

	public void setOption(Option option) {
		this.option = option;
	}
    
}