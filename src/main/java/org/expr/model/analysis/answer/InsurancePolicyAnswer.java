package org.expr.model.analysis.answer;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.analysis.InsurancePolicy;

/**
 * 保单表
 * 
 * @author Administrator
 * 
 */
public class InsurancePolicyAnswer extends LongIdObject {
    
    /** 保险资产 */
    private InsuranceAnalysisAnswer answer;
    
    /**保单*/
    private InsurancePolicy policy;

	
	/**主险保单*/
	private InsurancePolicyAnswer master;
	
	public String getName() {
		return policy.getName();
	}

	public InsuranceAnalysisAnswer getAnswer() {
		return answer;
	}

	public void setAnswer(InsuranceAnalysisAnswer answer) {
		this.answer = answer;
	}

	public InsurancePolicy getPolicy() {
		return policy;
	}

	public void setPolicy(InsurancePolicy policy) {
		this.policy = policy;
	}

	public InsurancePolicyAnswer getMaster() {
		return master;
	}

	public void setMaster(InsurancePolicyAnswer master) {
		this.master = master;
	}


    
}