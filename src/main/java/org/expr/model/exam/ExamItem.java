package org.expr.model.exam;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.Caze;

/**
 * 小题
 * 
 * @author Administrator
 * 	
	题目序号、题目描述
	选项（序号、文本）、得分权重、解析、答案
 */
public class ExamItem extends LongIdObject {

	ExamQuestion question;
	Integer code;
	String description;
	Set<ExamOption> options=new HashSet();
	Integer weight;
	String answer;
	String explain;
	
	public ExamQuestion getQuestion() {
		return question;
	}
	public void setQuestion(ExamQuestion question) {
		this.question = question;
	}
	public Integer getCode() {
		return code;
	}
	public void setCode(Integer code) {
		this.code = code;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Set<ExamOption> getOptions() {
		return options;
	}
	public void setOptions(Set<ExamOption> options) {
		this.options = options;
	}
	public Integer getWeight() {
		return weight;
	}
	public void setWeight(Integer weight) {
		this.weight = weight;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getExplain() {
		return explain;
	}
	public void setExplain(String explain) {
		this.explain = explain;
	}
	
	
	
	
	
	
}