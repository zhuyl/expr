package org.expr.model.basecode;

import java.util.HashSet;
import java.util.Set;

import com.ekingstar.eams.basecode.BaseCode;

/**
 * 收入项目
 * 
 * @author Administrator
 * 
 */
public class IncomeProject extends BaseCode {

	/** 上级项目 */
	private IncomeProject parent;

	private Set children = new HashSet();

	public IncomeProject getParent() {
		return parent;
	}

	public void setParent(IncomeProject parent) {
		this.parent = parent;
	}

	public Set getChildren() {
		return children;
	}

	public void setChildren(Set children) {
		this.children = children;
	}

}