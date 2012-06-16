package org.expr.model.finance;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.basecode.FinanceType;
import org.expr.model.basecode.Mobility;
import org.expr.model.basecode.RatePayPeriod;
import org.expr.model.basecode.RiskGrade;

/**
 * 金融投资产品
 * 
 * @author Administrator
 * 
 */

public class Finance extends LongIdObject{
	String name;
	RiskGrade riskgrade;
	FinanceType financetype;
	RatePayPeriod ratepayperiod;
	Float rate;
	Mobility mobility;
	String detail;
	
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
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public Mobility getMobility() {
		return mobility;
	}
	public void setMobility(Mobility mobility) {
		this.mobility = mobility;
	}
	
	
	
}
