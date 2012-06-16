package org.expr.model.analysis;

import org.beanfuse.model.pojo.LongIdObject;

/**
 * 得分等级表
 * 
 * @author Administrator
 * 
 */
public class ScoreRank extends LongIdObject {
    
    /** 问卷 */
    private Questionnaire questionnaire;
    
    /** 得分等级名称 */
    private String name;

    /** 最低得分 */
    private Float lower;

    /** 最高得分 */
    private Float upper;

	public Questionnaire getQuestionnaire() {
		return questionnaire;
	}

	public void setQuestionnaire(Questionnaire questionnaire) {
		this.questionnaire = questionnaire;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Float getLower() {
		return lower;
	}

	public void setLower(Float lower) {
		this.lower = lower;
	}

	public Float getUpper() {
		return upper;
	}

	public void setUpper(Float upper) {
		this.upper = upper;
	}
    
 
}