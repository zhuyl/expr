/**
* Expr System 
*/
package org.expr.model.exam.result;


import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.exam.ExamPaper;

import com.ekingstar.eams.student.Student;

/**
 * Administrator 
 * Id:ExamResult.java 2011-1-20 下午12:22:59
 */
public class ExamResult  extends LongIdObject {

	Set<ExamQuestionResult> questionResults=new HashSet();
	
	Student student;
	/**试卷*/
	ExamPaper paper;
	
	Float mark;
/**开始时间*/
	Date beginAt;
	
	Date endAt;

	public Set<ExamQuestionResult> getQuestionResults() {
		return questionResults;
	}

	public void setQuestionResults(Set<ExamQuestionResult> questionResults) {
		this.questionResults = questionResults;
	}

	public Student getStudent() {
		return student;
	}

	public void setStudent(Student student) {
		this.student = student;
	}

	public ExamPaper getPaper() {
		return paper;
	}

	public void setPaper(ExamPaper paper) {
		this.paper = paper;
	}

	public Float getMark() {
		return mark;
	}

	public void setMark(Float mark) {
		this.mark = mark;
	}

	public Date getBeginAt() {
		return beginAt;
	}

	public void setBeginAt(Date beginAt) {
		this.beginAt = beginAt;
	}

	public Date getEndAt() {
		return endAt;
	}

	public void setEndAt(Date endAt) {
		this.endAt = endAt;
	}


	
}
