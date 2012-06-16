package org.expr.model.analysis.result;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.analysis.FinanceAsset;

/**
 * 金融资产分析答案
 * 
 * @author Administrator
 * 
 */
public class FinanceAssetResult extends LongIdObject {

	private FinanceAssetAnalysisResult result;

	private FinanceAsset asset;

	public FinanceAssetAnalysisResult getResult() {
		return result;
	}

	public void setResult(FinanceAssetAnalysisResult result) {
		this.result = result;
	}

	public FinanceAsset getAsset() {
		return asset;
	}

	public void setAsset(FinanceAsset asset) {
		this.asset = asset;
	}




}