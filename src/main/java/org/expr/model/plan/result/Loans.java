package org.expr.model.plan.result;

import org.beanfuse.model.Component;

public class Loans implements Component{
	//商业贷款
	LoanPayed business=new LoanPayed();
	//公积金贷款
	LoanPayed accumulation =new LoanPayed();
	//商业负债
	Double businessCapital;
	//公积金负债
	Double accumulationCapital;
	public LoanPayed getBusiness() {
		return business;
	}
	public void setBusiness(LoanPayed business) {
		this.business = business;
	}
	public LoanPayed getAccumulation() {
		return accumulation;
	}
	public void setAccumulation(LoanPayed accumulation) {
		this.accumulation = accumulation;
	}
	public Double getBusinessCapital() {
		return businessCapital;
	}
	public void setBusinessCapital(Double businessCapital) {
		this.businessCapital = businessCapital;
	}
	public Double getAccumulationCapital() {
		return accumulationCapital;
	}
	public void setAccumulationCapital(Double accumulationCapital) {
		this.accumulationCapital = accumulationCapital;
	}





}
