package org.expr.model.plan.answer;

import java.math.BigDecimal;

import org.beanfuse.model.Component;

public class LoanPayed implements Component {

	BigDecimal capital = BigDecimal.ZERO;
	BigDecimal interest = BigDecimal.ZERO;

	public LoanPayed() {
		super();
	}

	public LoanPayed(BigDecimal i, BigDecimal j) {
		capital = i;
		interest = j;
	}

	public BigDecimal getCapital() {
		return capital;
	}

	public void setCapital(BigDecimal capital) {
		this.capital = capital;
	}

	public BigDecimal getInterest() {
		return interest;
	}

	public void setInterest(BigDecimal interest) {
		this.interest = interest;
	}

	public void add(LoanPayed other) {
		capital = capital.add(other.getCapital());
		interest = interest.add(other.getInterest());
	}

	public BigDecimal getTotal() {
		BigDecimal total = BigDecimal.ZERO;
		if (null == capital && null == interest) {
			return null;
		} else {
			if (null != capital) {
				total = total.add(capital);
			}
			if (null != interest) {
				total = total.add(interest);
			}
			return total;
		}
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("capital:").append(capital).append(" interest:").append(interest);
		return sb.toString();
	}

}
