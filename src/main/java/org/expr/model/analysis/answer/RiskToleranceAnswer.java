package org.expr.model.analysis.answer;

import java.util.HashSet;
import java.util.Set;

import org.expr.model.analysis.QuestionAnswer;
import org.expr.model.analysis.Questionnaire;
import org.expr.model.analysis.RiskTolerance;

/**
 * 客户风险承受能力分析表
 * 
 * @author Administrator
 * 
 */
public class RiskToleranceAnswer extends AbstractAnalysisAnswer implements RiskTolerance {

	/** 问卷 */
	private Questionnaire questionnaire;

	/** 问卷结果得分 */
	private Float questionScore;

	/** 得分 */
	private Float score;

	/** 答案集合 */
	private Set<QuestionAnswer> answers=new HashSet();

	public Questionnaire getQuestionnaire() {
		return questionnaire;
	}

	public void setQuestionnaire(Questionnaire questionnaire) {
		this.questionnaire = questionnaire;
	}

	public Float getQuestionScore() {
		return questionScore;
	}

	public void setQuestionScore(Float questionScore) {
		this.questionScore = questionScore;
	}

	public Float getScore() {
		return score;
	}

	public void setScore(Float score) {
		this.score = score;
	}

	public Set<QuestionAnswer> getAnswers() {
		return answers;
	}

	public void setAnswers(Set<QuestionAnswer> answers) {
		this.answers = answers;
	}

	
	
}