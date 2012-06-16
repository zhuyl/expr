package org.expr.model.analysis.answer;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.analysis.FundsLiability;

/**
 * 负债表
 * 
 * @author Administrator
 * 
 */
public class FundsLiabilityAnswer extends LongIdObject {
    
    /** 资金分析表 */
    private FundsAnalysisAnswer answer;
    
    private FundsLiability liability=new FundsLiability();

	public FundsAnalysisAnswer getAnswer() {
		return answer;
	}

	public void setAnswer(FundsAnalysisAnswer answer) {
		this.answer = answer;
	}

	public FundsLiability getLiability() {
		return liability;
	}

	public void setLiability(FundsLiability liability) {
		this.liability = liability;
	}
    
}