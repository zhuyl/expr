/**
* Expr System 
*/
package org.expr.model.exam;

import org.beanfuse.model.pojo.LongIdObject;

/**
 * Administrator 
 * Id:ExamOption.java 2011-1-20 下午12:36:35
 * 选项
 * 序号，选项描述
 */
public class ExamOption extends LongIdObject{
	String code;
	String description;
	ExamItem item;
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}

	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public ExamItem getItem() {
		return item;
	}
	public void setItem(ExamItem item) {
		this.item = item;
	}

	
}
