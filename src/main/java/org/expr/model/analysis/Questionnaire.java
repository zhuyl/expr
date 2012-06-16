package org.expr.model.analysis;

import java.util.Set;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.basecode.QuestionnaireType;

/**
 * 问卷表
 * 
 * @author Administrator
 * 
 */
public class Questionnaire extends LongIdObject  {
    
    /** 问卷名称 */
    private String name;

    /** 问卷制作人 */
    private String author;

    /** 问题集合 */
    private Set<Question> questions;
    
    /** 得分等级集合 */
    private Set<ScoreRank> ranks;
    
    /**问卷类型*/
    private QuestionnaireType type;
    
    /**问卷状态*/
    private boolean status;
    
    /**问卷表头*/
    private String head; 
    
	public String getHead() {
		return head;
	}

	public void setHead(String head) {
		this.head = head;
	}

	public boolean isStatus() {
		return status;
	}

	public void setStatus(boolean status) {
		this.status = status;
	}

	public QuestionnaireType getType() {
		return type;
	}

	public void setType(QuestionnaireType type) {
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public Set<Question> getQuestions() {
		return questions;
	}

	public void setQuestions(Set<Question> questions) {
		this.questions = questions;
	}

	public Set<ScoreRank> getRanks() {
		return ranks;
	}

	public void setRanks(Set<ScoreRank> scoreRanks) {
		this.ranks = scoreRanks;
	}
 
}