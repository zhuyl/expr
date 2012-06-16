package org.expr.model.analysis;

import java.util.Set;

/**
 * 客户风险承受能力分析表
 * 
 * @author Administrator
 * 
 */
public interface RiskTolerance {

	public Questionnaire getQuestionnaire();

	public void setQuestionnaire(Questionnaire questionnaire);

	public Float getQuestionScore();

	public void setQuestionScore(Float questionScore);

	public Float getScore();

	public void setScore(Float score);

	public Set<QuestionAnswer> getAnswers();

	public void setAnswers(Set<QuestionAnswer> answers);

}