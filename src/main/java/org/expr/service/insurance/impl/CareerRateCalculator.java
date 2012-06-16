package org.expr.service.insurance.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.beanfuse.persist.impl.BaseServiceImpl;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.insurance.CareerRate;
import org.expr.model.insurance.Policy;
import org.expr.service.insurance.RateCalculator;
import org.expr.service.insurance.RateResult;

import bsh.EvalError;
import bsh.Interpreter;

public class CareerRateCalculator extends BaseServiceImpl implements RateCalculator {

	public RateResult calculate(Policy policy) {
		RateResult result = new RateResult();
		EntityQuery query = new EntityQuery(CareerRate.class, "rate");
		query.add(new Condition("rate.product=:product", policy
				.getProduct()));
		List<CareerRate> rates = entityService.search(query);
		if (rates.isEmpty()) {
			return result;
		} else {
			CareerRate careerRate = rates.get(0);
			Float rate = careerRate.getRates().get(policy.getCareer().getGrade());
			result.setRate(rate);
			Number years = calcYears(policy.getAge(), policy.getPaytime().getDuration());
			int countPerYear = policy.getPaytype().getCountPerYear();
			if (years.equals(Double.NaN)) {
				result.setCount(1);
			} else {
				result.setCount(years.intValue() * countPerYear);
			}
		}
		return result;
	}

	private Number calcYears(Integer age, String script) {
		if (StringUtils.isEmpty(script)) {
			return Double.NaN;
		}
		Interpreter interpreter = new Interpreter();
		try {
			interpreter.set("age", new Integer(30));
			Number years = (Number) interpreter.eval("41 - age");
			return years.intValue();
		} catch (EvalError e) {
			throw new RuntimeException(e);
		}
	}
}
