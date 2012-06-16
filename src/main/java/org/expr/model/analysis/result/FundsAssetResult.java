  package org.expr.model.analysis.result;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.analysis.FundsAsset;

/**
 * 资产表
 * 
 * @author Administrator
 * 
 */
public class FundsAssetResult extends LongIdObject {
    
    /** 资金分析表 */
    private FundsAnalysisResult result;

    private FundsAsset asset=new FundsAsset();

	public FundsAnalysisResult getResult() {
		return result;
	}

	public void setResult(FundsAnalysisResult result) {
		this.result = result;
	}

	public FundsAsset getAsset() {
		return asset;
	}

	public void setAsset(FundsAsset asset) {
		this.asset = asset;
	}
    
}
