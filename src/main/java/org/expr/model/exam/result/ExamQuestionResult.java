/**
* Expr System 
*/
package org.expr.model.exam.result;

import java.util.HashSet;
import java.util.Set;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.exam.ExamItem;
import org.expr.model.exam.ExamQuestion;

/**
 * Administrator 大题答案
 * Id:ExamQuestionResult.java 2011-1-20 下午12:24:40
 */
public class ExamQuestionResult extends LongIdObject  {
	Integer code;/**大题在试卷中的序号*/
	ExamQuestion question;
	Float mark;/**大题得分*/
	Set<ExamItemResult> itemResults=new HashSet();/**小题结果集合*/
	ExamResult examResult;
	

	public ExamResult getExamResult() {
		return examResult;
	}
	public void setExamResult(ExamResult examResult) {
		this.examResult = examResult;
	}
	public Integer getCode() {
		return code;
	}
	public void setCode(Integer code) {
		this.code = code;
	}
	public ExamQuestion getQuestion() {
		return question;
	}
	public void setQuestion(ExamQuestion question) {
		this.question = question;
	}
	public Float getMark() {
		return mark;
	}
	public void setMark(Float mark) {
		this.mark = mark;
	}
	public Set<ExamItemResult> getItemResults() {
		return itemResults;
	}
	public void setItemResults(Set<ExamItemResult> itemResults) {
		this.itemResults = itemResults;
	}

	
	
	
	
	
}
