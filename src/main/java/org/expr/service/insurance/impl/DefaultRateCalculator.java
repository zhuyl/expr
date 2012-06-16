package org.expr.service.insurance.impl;

import java.util.HashMap;
import java.util.Map;

import org.expr.model.insurance.Policy;
import org.expr.model.insurance.RateRegistry;
import org.expr.service.insurance.RateCalculator;
import org.expr.service.insurance.RateResult;

public class DefaultRateCalculator implements RateCalculator {

	Map<String, RateCalculator> calculators = new HashMap();

	public RateResult calculate(Policy policy) {
		RateRegistry registry=policy.getProduct().getRegistry();
		RateCalculator calculator=calculators.get(registry.getType());
		if(null!=calculator){
			return calculator.calculate(policy);
		}else{
			return new RateResult();
		}
	}

	public Map<String, RateCalculator> getCalculators() {
		return calculators;
	}

	public void setCalculators(Map<String, RateCalculator> calculators) {
		this.calculators = calculators;
	}

}
