package org.expr.model.plan.result;

import java.util.HashSet;
import java.util.Set;

import org.expr.model.analysis.AbstractResult;

/**
 * 金融投资表
 * 
 * @author Administrator
 * 
 */
public class FinanceAssetPlanResult extends AbstractResult {

	/** 金融资产集合 */
	private Set<FinancePlanResult> assets = new HashSet();

	public Set<FinancePlanResult> getAssets() {
		return assets;
	}

	public void setAssets(Set<FinancePlanResult> assets) {
		this.assets = assets;
	}

}