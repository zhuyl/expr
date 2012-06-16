package org.expr.model.assessment;

import java.util.HashSet;
import java.util.Set;

import org.beanfuse.model.pojo.LongIdObject;

public class Assessment extends LongIdObject  {
    /** 评分标准名称 */
    private String name;

    /**评分标准制作人 */
    private String author;
    
    /**评分标准说明*/
    private String remark; 
    
    /** 评分标准条目集合 */
    private Set<AssessItem> items=new HashSet();

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

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Set<AssessItem> getItems() {
		return items;
	}

	public void setItems(Set<AssessItem> items) {
		this.items = items;
	}
    
    
	
}