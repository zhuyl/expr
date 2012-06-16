package org.expr.model.insurance;

import java.util.HashSet;
import java.util.Set;

import org.beanfuse.model.pojo.LongIdObject;

public class CareerProfile extends LongIdObject{
	private String name;
	private Set<Career> careers=new HashSet();

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Set<Career> getCareers() {
		return careers;
	}

	public void setCareers(Set<Career> careers) {
		this.careers = careers;
	}
    
}
