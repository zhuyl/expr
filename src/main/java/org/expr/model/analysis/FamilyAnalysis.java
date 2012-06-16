package org.expr.model.analysis;

import java.util.HashSet;
import java.util.Set;

/**
 * 家庭分析表
 * 
 * @author Administrator
 * 
 */
public class FamilyAnalysis implements AnalysisForm {

	/** 家庭成员集合 */
	private Set members = new HashSet();

	public Set getMembers() {
		return members;
	}

	public void setMembers(Set members) {
		this.members = members;
	}
}