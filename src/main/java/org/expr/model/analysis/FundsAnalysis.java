package org.expr.model.analysis;

import java.util.HashSet;
import java.util.Set;

/**
 * 资金分析表
 * 
 * @author Administrator
 * 
 */
public class FundsAnalysis implements AnalysisForm {

	/** 总资产 */
	private Float totalAssets;

	/** 总负债 */
	private Float totalLiabilities;

	/** 总净值 */
	private Float totalNet;

	/** 资产集合 */
	private Set assets = new HashSet();

	/** 负债集合 */
	private Set liabilities = new HashSet();

	public Set getAssets() {
		return assets;
	}

	public void setAssets(Set assets) {
		this.assets = assets;
	}

	public Set getLiabilities() {
		return liabilities;
	}

	public void setLiabilities(Set liabilities) {
		this.liabilities = liabilities;
	}

	public Float getTotalAssets() {
		return totalAssets;
	}

	public void setTotalAssets(Float totalAssets) {
		this.totalAssets = totalAssets;
	}

	public Float getTotalLiabilities() {
		return totalLiabilities;
	}

	public void setTotalLiabilities(Float totalLiabilities) {
		this.totalLiabilities = totalLiabilities;
	}

	public Float getTotalNet() {
		return totalNet;
	}

	public void setTotalNet(Float totalNet) {
		this.totalNet = totalNet;
	}

}