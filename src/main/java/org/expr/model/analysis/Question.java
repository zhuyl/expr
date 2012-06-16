package org.expr.model.analysis;

import java.util.HashSet;
import java.util.Set;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.basecode.QuestionType;

/**
 * 问题表
 * 
 * @author Administrator
 * 
 */
public class Question extends LongIdObject {

	/** 问卷 */
	private Questionnaire questionnaire;

	/** 问题描述 */
	private String description;

	/** 问题类型 */
	private QuestionType questionType;

	/** 选项集合 */
	private Set<Option> options=new HashSet();

	public Questionnaire getQuestionnaire() {
		return questionnaire;
	}

	public void setQuestionnaire(Questionnaire questionnaire) {
		this.questionnaire = questionnaire;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public QuestionType getQuestionType() {
		return questionType;
	}

	public void setQuestionType(QuestionType questionType) {
		this.questionType = questionType;
	}

	public Set<Option> getOptions() {
		return options;
	}

	public void setOptions(Set<Option> options) {
		this.options = options;
	}

}