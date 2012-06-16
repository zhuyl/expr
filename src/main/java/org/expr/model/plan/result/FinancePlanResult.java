package org.expr.model.plan.result;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.basecode.FinanceType;
import org.expr.model.basecode.Mobility;
import org.expr.model.basecode.RatePayPeriod;
import org.expr.model.basecode.RiskGrade;

/**
 * 金融资产分析答案
 * 
 * @author Administrator
 * 
 */
public class FinancePlanResult extends LongIdObject {

	private FinanceAssetPlanResult result;
/**风险等级*/
	RiskGrade riskgrade;
/**资产类型*/
	FinanceType financetype;
/**付息 周期*/
	RatePayPeriod ratepayperiod;
/***预计年收益率*/
	Float rate;
/***流动性*/
	Mobility mobility;
	/*
	 * 投资金额
	 */

	double amount;
	/*
	 * 后期追加占比
	 */
	Float append;
	/*
	 * 开始年份
	 */
	private Integer startYear;
	/*
	 * 结束年份
	 */
	private Integer endYear;

	/**建议产品集合 */
	private String finances;

	public FinanceAssetPlanResult getResult() {
		return result;
	}

	public void setResult(FinanceAssetPlanResult result) {
		this.result = result;
	}

	public RiskGrade getRiskgrade() {
		return riskgrade;
	}

	public void setRiskgrade(RiskGrade riskgrade) {
		this.riskgrade = riskgrade;
	}

	public FinanceType getFinancetype() {
		return financetype;
	}

	public void setFinancetype(FinanceType financetype) {
		this.financetype = financetype;
	}

	public RatePayPeriod getRatepayperiod() {
		return ratepayperiod;
	}

	public void setRatepayperiod(RatePayPeriod ratepayperiod) {
		this.ratepayperiod = ratepayperiod;
	}

	public Float getRate() {
		return rate;
	}

	public void setRate(Float rate) {
		this.rate = rate;
	}

	public Mobility getMobility() {
		return mobility;
	}

	public void setMobility(Mobility mobility) {
		this.mobility = mobility;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public Float getAppend() {
		return append;
	}

	public void setAppend(Float append) {
		this.append = append;
	}

	public Integer getStartYear() {
		return startYear;
	}

	public void setStartYear(Integer startYear) {
		this.startYear = startYear;
	}

	public Integer getEndYear() {
		return endYear;
	}

	public void setEndYear(Integer endYear) {
		this.endYear = endYear;
	}

	public String getFinances() {
		return finances;
	}

	public void setFinances(String finances) {
		this.finances = finances;
	}



	

}