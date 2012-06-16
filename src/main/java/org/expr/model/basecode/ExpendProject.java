package org.expr.model.basecode;

import java.util.HashSet;
import java.util.Set;

import com.ekingstar.eams.basecode.BaseCode;

/**
 * 支出项目
 * 
 * @author Administrator
 * 
 */
public class ExpendProject extends BaseCode {

	/** 上级项目 */
	private ExpendProject parent;

	private Set children = new HashSet();

	public ExpendProject getParent() {
		return parent;
	}

	public void setParent(ExpendProject parent) {
		this.parent = parent;
	}

	public Set getChildren() {
		return children;
	}

	public void setChildren(Set children) {
		this.children = children;
	}

}