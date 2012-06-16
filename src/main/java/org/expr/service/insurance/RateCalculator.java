package org.expr.service.insurance;

import org.expr.model.insurance.Policy;

public interface RateCalculator {

	public RateResult calculate(Policy policy);
}
