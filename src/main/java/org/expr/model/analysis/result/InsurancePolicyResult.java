package org.expr.model.analysis.result;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.analysis.InsurancePolicy;

/**
 * 保单表
 * 
 * @author Administrator
 * 
 */
public class InsurancePolicyResult extends LongIdObject {
    
    /** 保险资产 */
    private InsuranceAnalysisResult result;
    
    /**保单*/
    private InsurancePolicy policy;

	
	/**主险保单*/
	private InsurancePolicyResult master;
	
	public String getName() {
		return policy.getName();
	}

	public InsuranceAnalysisResult getResult() {
		return result;
	}

	public void setResult(InsuranceAnalysisResult result) {
		this.result = result;
	}

	public InsurancePolicy getPolicy() {
		return policy;
	}

	public void setPolicy(InsurancePolicy policy) {
		this.policy = policy;
	}

	public InsurancePolicyResult getMaster() {
		return master;
	}

	public void setMaster(InsurancePolicyResult master) {
		this.master = master;
	}


    
}