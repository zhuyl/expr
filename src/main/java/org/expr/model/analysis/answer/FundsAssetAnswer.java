  package org.expr.model.analysis.answer;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.analysis.FundsAsset;

/**
 * 资产表
 * 
 * @author Administrator
 * 
 */
public class FundsAssetAnswer extends LongIdObject {
    
    /** 资金分析表 */
    private FundsAnalysisAnswer answer;

    private FundsAsset asset=new FundsAsset();

	public FundsAnalysisAnswer getAnswer() {
		return answer;
	}

	public void setAnswer(FundsAnalysisAnswer answer) {
		this.answer = answer;
	}

	public FundsAsset getAsset() {
		return asset;
	}

	public void setAsset(FundsAsset asset) {
		this.asset = asset;
	}
    
}