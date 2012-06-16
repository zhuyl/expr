package org.expr.model.analysis;

import org.beanfuse.model.pojo.LongIdObject;


/**
 * 选项表
 * 
 * @author Administrator
 * 
 */
public class Option extends LongIdObject {
    
    /** 问题 */
    private Question question;
    
    /** 选项得分 */
    private Float score;

    /** 选项内容 */
    private String context;
    /**选项序号*/
    
    private String seq;
    

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public Question getQuestion() {
		return question;
	}

	public void setQuestion(Question question) {
		this.question = question;
	}

	public Float getScore() {
		return score;
	}

	public void setScore(Float score) {
		this.score = score;
	}

	public String getContext() {
		return context;
	}

	public void setContext(String context) {
		this.context = context;
	}    
 
}