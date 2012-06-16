package org.expr.model.analysis;

import java.util.HashSet;
import java.util.Set;

/**
 * 保险资产分析表
 * 
 * @author Administrator
 * 
 */
public class InsuranceAnalysis implements AnalysisForm {

	/** 保单集合 */
	private Set policies = new HashSet();

	public Set getPolicies() {
		return policies;
	}

	public void setPolicies(Set policies) {
		this.policies = policies;
	}

}