package org.expr.model.exam;

import java.util.HashSet;
import java.util.Set;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.Caze;

/**
 * 试题
 * 
 * @author Administrator
 * 
 */
public class ExamQuestion extends LongIdObject {
    
    /** 试题序号 */
    private String code;
    
    /** 试题名称*/
    private String name;
    
    /**试题导语*/
    private String introduction;
    
    /**试题案例**/
    private Caze caze;
    
    /**试题作者*/
    private String author;
    
    /**小题*/
    private Set<ExamItem> items=new HashSet();
    
	public Set<ExamItem> getItems() {
		return items;
	}

	public void setItems(Set<ExamItem> items) {
		this.items = items;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	public Caze getCaze() {
		return caze;
	}

	public void setCaze(Caze caze) {
		this.caze = caze;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}
	
    



    
    
}