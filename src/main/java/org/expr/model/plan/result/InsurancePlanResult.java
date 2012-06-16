package org.expr.model.plan.result;

import java.util.HashSet;
import java.util.Set;

import org.expr.model.analysis.AbstractResult;

/**
 * 保险规划分析表
 * 
 * @author Administrator
 * 
 */
public class InsurancePlanResult extends AbstractResult {
    
	/** 保单集合 */
	private Set<InsurancePlanPolicyResult> policies = new HashSet();

	public Set<InsurancePlanPolicyResult> getPolicies() {
		return policies;
	}

	public void setPolicies(Set<InsurancePlanPolicyResult> policies) {
		this.policies = policies;
	}

}