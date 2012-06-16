package org.expr.model.plan.answer;

import java.util.HashSet;
import java.util.Set;

/**
 * 金融投资表
 * 
 * @author Administrator
 * 
 */
public class FinanceAssetPlanAnswer extends AbstractPlanAnswer {

	/** 金融资产集合 */
	private Set<FinancePlanAnswer> assets = new HashSet();

	public Set<FinancePlanAnswer> getAssets() {
		return assets;
	}

	public void setAssets(Set<FinancePlanAnswer> assets) {
		this.assets = assets;
	}

}