package org.expr.model.plan.answer;

import org.beanfuse.model.Component;

public class BusinessLoans implements Component{

	LoanPayed business=new LoanPayed();
	
	//负债
	Double capital;

	public LoanPayed getBusiness() {
		return business;
	}

	public void setBusiness(LoanPayed business) {
		this.business = business;
	}

	public Double getCapital() {
		return capital;
	}

	public void setCapital(Double capital) {
		this.capital = capital;
	}
	
}
