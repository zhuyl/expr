package org.expr.model.plan.answer;

import java.util.HashSet;
import java.util.Set;

/**
 * 保险规划分析表
 * 
 * @author Administrator
 * 
 */
public class InsurancePlanAnswer extends AbstractPlanAnswer {
    
	/** 保单集合 */
	private Set<InsurancePlanPolicyAnswer> policies = new HashSet();

	public Set<InsurancePlanPolicyAnswer> getPolicies() {
		return policies;
	}

	public void setPolicies(Set<InsurancePlanPolicyAnswer> policies) {
		this.policies = policies;
	}

}