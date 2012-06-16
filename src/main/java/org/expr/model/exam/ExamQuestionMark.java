/**
* Expr System 
*/
package org.expr.model.exam;

import java.util.HashSet;
import java.util.Set;

import org.beanfuse.model.pojo.LongIdObject;

/**
 * Administrator 
 * Id:ExamQuestionMark.java 2011-1-20 下午12:52:02
 */
public class ExamQuestionMark extends LongIdObject{
	/**试卷*/
	ExamPaper paper;
	/**序号*/
	Integer code;
	/**大题*/
	Set<ExamQuestion> questions=new HashSet();
	
	Integer mark;
	
	
	public Set<ExamQuestion> getQuestions() {
		return questions;
	}
	public void setQuestions(Set<ExamQuestion> questions) {
		this.questions = questions;
	}
	public ExamPaper getPaper() {
		return paper;
	}
	public void setPaper(ExamPaper paper) {
		this.paper = paper;
	}

	public Integer getCode() {
		return code;
	}
	public void setCode(Integer code) {
		this.code = code;
	}
	public Integer getMark() {
		return mark;
	}
	public void setMark(Integer mark) {
		this.mark = mark;
	}
	
	
}
