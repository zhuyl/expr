package org.expr.model.analysis.answer;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.analysis.FinanceAsset;

/**
 * 金融资产分析答案
 * 
 * @author Administrator
 * 
 */
public class FinanceAssetAnswer extends LongIdObject {

	private FinanceAssetAnalysisAnswer answer;

	private FinanceAsset asset;

	public FinanceAssetAnalysisAnswer getAnswer() {
		return answer;
	}

	public void setAnswer(FinanceAssetAnalysisAnswer answer) {
		this.answer = answer;
	}

	public FinanceAsset getAsset() {
		return asset;
	}

	public void setAsset(FinanceAsset asset) {
		this.asset = asset;
	}




}