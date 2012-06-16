package org.expr.model.analysis.result;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.analysis.FundsLiability;

/**
 * 负债表
 * 
 * @author Administrator
 * 
 */
public class FundsLiabilityResult extends LongIdObject {
    
    /** 资金分析表 */
    private FundsAnalysisResult result;
    
    private FundsLiability liability=new FundsLiability();

	public FundsAnalysisResult getResult() {
		return result;
	}

	public void setResult(FundsAnalysisResult result) {
		this.result = result;
	}

	public FundsLiability getLiability() {
		return liability;
	}

	public void setLiability(FundsLiability liability) {
		this.liability = liability;
	}
    
}