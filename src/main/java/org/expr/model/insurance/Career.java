package org.expr.model.insurance;

import java.util.HashSet;
import java.util.Set;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.basecode.CareerGrade;

public class Career extends LongIdObject {

	private CareerProfile profile;
	private String name;
	private String code;
	private CareerGrade grade;
	private Career parent;
	private Set<Career> children = new HashSet();

	
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

	public CareerGrade getGrade() {
		return grade;
	}

	public void setGrade(CareerGrade grade) {
		this.grade = grade;
	}

	public CareerProfile getProfile() {
		return profile;
	}

	public void setProfile(CareerProfile profile) {
		this.profile = profile;
	}

	public Career getParent() {
		return parent;
	}

	public void setParent(Career parent) {
		this.parent = parent;
	}

	public Set<Career> getChildren() {
		return children;
	}

	public void setChildren(Set<Career> children) {
		this.children = children;
	}

}
