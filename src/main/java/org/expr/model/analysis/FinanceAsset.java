package org.expr.model.analysis;

import org.beanfuse.model.Component;
import org.expr.model.basecode.FinanceType;
import org.expr.model.basecode.Mobility;
import org.expr.model.basecode.RatePayPeriod;
import org.expr.model.basecode.RiskGrade;

/**
 * 金融资产表
 * 
 * @author Administrator
 * 
 */
public class FinanceAsset implements Component {

	String name;
	RiskGrade riskgrade;
	FinanceType financetype;
	RatePayPeriod ratepayperiod;
	Float rate;
	Mobility mobility;
	/*
	 * 投资金额
	 */
	double amount;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	
	



}