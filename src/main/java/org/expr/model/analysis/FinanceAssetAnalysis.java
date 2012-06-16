package org.expr.model.analysis;

import java.util.HashSet;
import java.util.Set;

import org.expr.model.analysis.answer.FinanceAssetAnswer;

/**
 * 家庭分析表
 * 
 * @author Administrator
 * 
 */
public class FinanceAssetAnalysis implements AnalysisForm {

	/** 金融资产集合 */
	private Set<FinanceAssetAnswer> assets = new HashSet();

	public Set getAssets() {
		return assets;
	}

	public void setAssets(Set assets) {
		this.assets = assets;
	}

	
}