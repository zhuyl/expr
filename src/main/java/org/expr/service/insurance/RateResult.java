package org.expr.service.insurance;

import java.util.ArrayList;
import java.util.List;

public class RateResult {

	Float rate;
	
	Number count;
	
	List<Double> moneys=new ArrayList();

	public Float getRate() {
		return rate;
	}

	public void setRate(Float rate) {
		this.rate = rate;
	}

	public Number getCount() {
		return count;
	}

	public void setCount(Number count) {
		this.count = count;
	}

	public List<Double> getMoneys() {
		return moneys;
	}

	public void setMoneys(List<Double> moneys) {
		this.moneys = moneys;
	}
	
	
}
