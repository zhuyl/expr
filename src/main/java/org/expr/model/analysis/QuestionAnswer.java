package org.expr.model.analysis;


/**
 * 答案表
 * 
 * @author Administrator
 * 
 */
public interface QuestionAnswer {

	public Question getQuestion();

	public void setQuestion(Question question);

	public Option getOption();

	public void setOption(Option option);

}