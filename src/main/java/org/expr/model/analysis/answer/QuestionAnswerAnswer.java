package org.expr.model.analysis.answer;

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
public class QuestionAnswerAnswer extends LongIdObject implements QuestionAnswer {

    private RiskToleranceAnswer answer;
    
    /** 问题 */
    private Question question;
    
    /** 答案 */
    private Option option;


    public RiskToleranceAnswer getAnswer() {
        return answer;
    }
    
    public void setAnswer(RiskToleranceAnswer answer) {
        this.answer = answer;
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