/**
* Expr System 
*/
package org.expr.model.exam.result;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.exam.ExamItem;

/**
 * Administrator 
 * Id:ExamQuestionResult.java 2011-1-20 下午12:24:40
 */
public class ExamItemResult extends LongIdObject  {
	ExamQuestionResult questionResult;
	
	ExamItem item;
	
	String result;
	
	Float mark;/**小题得分*/

	
	public ExamItem getItem() {
		return item;
	}

	public ExamQuestionResult getQuestionResult() {
		return questionResult;
	}

	public void setQuestionResult(ExamQuestionResult questionResult) {
		this.questionResult = questionResult;
	}

	public void setItem(ExamItem item) {
		this.item = item;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public Float getMark() {
		return mark;
	}

	public void setMark(Float mark) {
		this.mark = mark;
	}





	
	
}
