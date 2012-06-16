package org.expr.model.insurance;

import org.beanfuse.model.pojo.LongIdObject;

public class RateRegistry extends LongIdObject{
	String name;
    
    /**保险费率类型 */
    private String type;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

}
